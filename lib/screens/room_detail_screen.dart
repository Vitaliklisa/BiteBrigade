import 'dart:async';
import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/rooms.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../providers/app_providers.dart';
import '../providers/room_providers.dart';
import '../widgets/brand_kit.dart';
import '../widgets/room_widgets.dart';

class RoomDetailScreen extends ConsumerStatefulWidget {
  const RoomDetailScreen({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends ConsumerState<RoomDetailScreen>
    with SingleTickerProviderStateMixin {
  final _noteController = TextEditingController();
  late final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 4));
  Timer? _deadlineTimer;
  String? _scheduledRoom;
  String? _finalizingRoomId;
  bool _sendingNote = false;

  @override
  void initState() {
    super.initState();
    ref.listenManual(roomProvider(widget.roomId), (previous, next) {
      final room = next.value;
      if (room == null) return;
      if (room.status == RoomStatus.decided &&
          previous?.value?.status != RoomStatus.decided) {
        _confettiController.play();
      }
      _scheduleDeadline(room);
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _deadlineTimer?.cancel();
    _noteController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _scheduleDeadline(Room room) {
    if (room.status != RoomStatus.open ||
        !room.mealAt.isAfter(DateTime.now()) ||
        _scheduledRoom == room.id) {
      return;
    }
    _scheduledRoom = room.id;
    _deadlineTimer?.cancel();
    _deadlineTimer = Timer(
      room.mealAt.difference(DateTime.now()),
      () => unawaited(_finalizeRoom(room.id)),
    );
  }

  Future<void> _finalizeRoom(String roomId) async {
    if (_finalizingRoomId == roomId) return;
    _finalizingRoomId = roomId;
    try {
      await ref.read(roomRepositoryProvider).finalizeRoom(roomId);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not reveal the winner: $error')),
        );
      }
    } finally {
      if (_finalizingRoomId == roomId) _finalizingRoomId = null;
    }
  }

  Future<void> _addNote() async {
    final user = ref.read(currentUserProvider);
    final text = _noteController.text;
    if (user == null || text.trim().isEmpty || _sendingNote) return;
    setState(() => _sendingNote = true);
    try {
      await ref.read(roomRepositoryProvider).addNote(
            roomId: widget.roomId,
            userId: user.id,
            text: text,
          );
      _noteController.clear();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not add your note: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _sendingNote = false);
    }
  }

  Future<void> _duplicate(Room room, List<RestaurantOption> options) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final when = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (!mounted || when == null) return;
    try {
      final mealAt = DateTime(
        when.year,
        when.month,
        when.day,
        room.mealAt.hour,
        room.mealAt.minute,
      );
      final id = await ref.read(roomRepositoryProvider).duplicateRoom(
            room: room,
            options: options,
            userId: user.id,
            email: user.email,
            displayName: user.displayName ?? '',
            mealAt: mealAt,
          );
      if (!mounted) return;
      await context.push('${Routes.room}/$id');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not duplicate this decision: $error')),
        );
      }
    }
  }

  Future<void> _cancel(Room room) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel this decision?'),
        content: const Text('The room will be kept in the history.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep it'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cancel decision'),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      final user = ref.read(currentUserProvider);
      if (user == null) return;
      await ref.read(roomRepositoryProvider).softDeleteRoom(room, user.id);
      if (mounted) context.go(Routes.home);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not cancel this decision: $error')),
        );
      }
    }
  }

  Future<void> _openUrl(String? value) async {
    if (value == null || value.trim().isEmpty) return;
    final uri = Uri.tryParse(value);
    if (uri == null ||
        !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This link could not be opened.')),
        );
      }
    }
  }

  Future<void> _openMaps(String address, String title) async {
    final query = address.trim().isNotEmpty ? address : title;
    final uri = Uri.https(
      'www.google.com',
      '/maps/search/',
      {'api': '1', 'query': query},
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) &&
        mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maps could not be opened.')),
      );
    }
  }

  Future<void> _addToCalendar(Room room, RestaurantOption? winner) async {
    final start = room.mealAt.toUtc();
    final end = start.add(const Duration(hours: 2));
    String stamp(DateTime value) => value
        .toIso8601String()
        .replaceAll(RegExp(r'[-:]'), '')
        .split('.')
        .first;
    final uri = Uri.https('calendar.google.com', '/calendar/render', {
      'action': 'TEMPLATE',
      'text': 'Bite Brigade · ${room.name}',
      'dates': '${stamp(start)}/${stamp(end)}',
      if (winner?.address?.isNotEmpty == true) 'location': winner!.address!,
      'details': winner == null
          ? 'Decision made with Bite Brigade.'
          : 'We picked ${winner.title}.',
    });
    await _openUrl(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomProvider(widget.roomId));
    final optionsAsync = ref.watch(roomOptionsProvider(widget.roomId));
    final participantsAsync =
        ref.watch(roomParticipantsProvider(widget.roomId));
    final votesAsync = ref.watch(roomVotesProvider(widget.roomId));
    final notesAsync = ref.watch(roomNotesProvider(widget.roomId));
    final user = ref.watch(currentUserProvider);
    final room = roomAsync.value;
    final options = optionsAsync.value ?? const <RestaurantOption>[];
    final participants = participantsAsync.value ?? const <RoomParticipant>[];
    final votes = votesAsync.value ?? const <RoomVote>[];
    final notes = notesAsync.value ?? const <RoomNote>[];
    final winner = room?.winnerOptionId == null
        ? null
        : _findOption(options, room!.winnerOptionId!);
    final currentParticipant = participants
        .where((participant) => participant.userId == user?.id)
        .firstOrNull;
    final canVote = room?.status == RoomStatus.open &&
        (room?.createdBy == user?.id || currentParticipant?.accepted == true);

    if (room != null && room.status == RoomStatus.open) {
      final acceptedIds = participants
          .where((participant) => participant.accepted)
          .map((participant) => participant.userId)
          .toSet();
      final votedIds = votes.map((vote) => vote.userId).toSet();
      final allVoted =
          acceptedIds.isNotEmpty && acceptedIds.every(votedIds.contains);
      final deadlineReached = !room.mealAt.isAfter(DateTime.now());
      if (acceptedIds.isNotEmpty && (allVoted || deadlineReached)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) unawaited(_finalizeRoom(room.id));
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decision'),
        actions: [
          if (room != null)
            PopupMenuButton<String>(
              onSelected: (action) {
                if (action == 'edit') {
                  context.push('${Routes.room}/${room.id}/edit');
                } else if (action == 'duplicate') {
                  unawaited(_duplicate(room, options));
                } else if (action == 'cancel') {
                  unawaited(_cancel(room));
                }
              },
              itemBuilder: (context) => [
                if (room.createdBy == user?.id &&
                    room.status == RoomStatus.open)
                  const PopupMenuItem(
                      value: 'edit', child: Text('Edit decision')),
                const PopupMenuItem(
                  value: 'duplicate',
                  child: Text('Duplicate for another day'),
                ),
                if (room.createdBy == user?.id && !room.isDeleted)
                  const PopupMenuItem(
                    value: 'cancel',
                    child: Text('Cancel decision'),
                  ),
              ],
            ),
        ],
      ),
      body: roomAsync.isLoading && room == null
          ? const Center(child: CircularProgressIndicator())
          : roomAsync.hasError
              ? _ErrorPanel(
                  message: 'Could not load this decision: ${roomAsync.error}')
              : room == null
                  ? const _ErrorPanel(
                      message: 'This decision is no longer available.')
                  : Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 920),
                        child: Stack(
                          children: [
                            ListView(
                              padding:
                                  const EdgeInsets.fromLTRB(22, 12, 22, 42),
                              children: [
                                _RoomHeader(room: room),
                                if (room.status == RoomStatus.decided)
                                  _WinnerCard(
                                    room: room,
                                    winner: winner,
                                    onMaps: () => _openMaps(
                                      winner?.address ?? '',
                                      winner?.title ?? room.name,
                                    ),
                                    onCalendar: () =>
                                        _addToCalendar(room, winner),
                                    onWebsite: winner?.url == null
                                        ? null
                                        : () =>
                                            unawaited(_openUrl(winner!.url)),
                                  )
                                else ...[
                                  const SizedBox(height: 22),
                                  RoomProgress(
                                    votesCast: votes.length,
                                    participantCount: participants
                                        .where((participant) =>
                                            participant.accepted)
                                        .length,
                                  ),
                                  const SizedBox(height: 24),
                                  _SectionHeader(
                                    title: 'The shortlist',
                                    trailing: canVote
                                        ? TextButton.icon(
                                            onPressed: () => context.push(
                                              '${Routes.room}/${room.id}/vote',
                                            ),
                                            icon:
                                                const Icon(Icons.swipe_rounded),
                                            label: const Text('Swipe to vote'),
                                          )
                                        : null,
                                  ),
                                  const SizedBox(height: 10),
                                  if (optionsAsync.hasError)
                                    _ErrorPanel(
                                      message:
                                          'Could not load restaurants: ${optionsAsync.error}',
                                    )
                                  else if (options.isEmpty)
                                    const _InlineEmpty(
                                      message:
                                          'No restaurants have been added yet.',
                                    )
                                  else
                                    for (final option in options)
                                      _OptionCard(
                                        option: option,
                                        voteCount: votes
                                            .where((vote) =>
                                                vote.optionId == option.id)
                                            .length,
                                        selected: votes.any((vote) =>
                                            vote.userId == user?.id &&
                                            vote.optionId == option.id),
                                        canVote: canVote,
                                        onVote: () async {
                                          try {
                                            await ref
                                                .read(roomRepositoryProvider)
                                                .vote(
                                                  roomId: room.id,
                                                  userId: user!.id,
                                                  optionId: option.id,
                                                );
                                          } catch (error) {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Your vote could not be saved: $error'),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        onMaps: () => _openMaps(
                                          option.address ?? '',
                                          option.title,
                                        ),
                                        onWebsite: option.url == null
                                            ? null
                                            : () =>
                                                unawaited(_openUrl(option.url)),
                                      ),
                                ],
                                const SizedBox(height: 28),
                                _SectionHeader(
                                  title: 'Around the table',
                                  trailing: Text(
                                    '${participants.where((p) => p.accepted).length}',
                                    style: TextStyle(
                                      color: context.colors.muted,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                if (participantsAsync.hasError)
                                  _ErrorPanel(
                                    message:
                                        'Could not load the group: ${participantsAsync.error}',
                                  )
                                else
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      for (final participant in participants
                                          .where((p) => p.accepted))
                                        _ParticipantChip(
                                          participant: participant,
                                          hasVoted: votes.any((vote) =>
                                              vote.userId ==
                                              participant.userId),
                                        ),
                                    ],
                                  ),
                                const SizedBox(height: 28),
                                _SectionHeader(
                                  title: 'Notes',
                                  trailing: Text(
                                    '${notes.length}',
                                    style: TextStyle(
                                      color: context.colors.muted,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                if (notesAsync.hasError)
                                  _ErrorPanel(
                                    message:
                                        'Could not load notes: ${notesAsync.error}',
                                  )
                                else if (notes.isEmpty)
                                  const _InlineEmpty(
                                    message:
                                        'No notes yet. Share a time, a thought, or a must-have.',
                                  )
                                else
                                  for (final note in notes)
                                    _NoteCard(
                                      note: note,
                                      isMine: note.userId == user?.id,
                                    ),
                                if (canVote) ...[
                                  const SizedBox(height: 12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _noteController,
                                          maxLength: 500,
                                          minLines: 1,
                                          maxLines: 3,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          decoration: const InputDecoration(
                                            hintText: 'Add a note…',
                                            counterText: '',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton.filled(
                                        onPressed:
                                            _sendingNote ? null : _addNote,
                                        icon: _sendingNote
                                            ? const SizedBox(
                                                width: 18,
                                                height: 18,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.arrow_upward_rounded),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: ConfettiWidget(
                                confettiController: _confettiController,
                                blastDirection: -math.pi / 2,
                                emissionFrequency: 0.05,
                                numberOfParticles: 22,
                                maxBlastForce: 22,
                                minBlastForce: 8,
                                gravity: 0.12,
                                colors: AppColors.party,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
      floatingActionButton: canVote && room != null
          ? FloatingActionButton.extended(
              onPressed: () => context.push('${Routes.room}/${room.id}/vote'),
              icon: const Icon(Icons.how_to_vote_rounded),
              label: const Text('Cast your vote'),
            )
          : null,
    );
  }
}

RestaurantOption? _findOption(
  List<RestaurantOption> options,
  String id,
) {
  for (final option in options) {
    if (option.id == id) return option;
  }
  return null;
}

class _RoomHeader extends StatelessWidget {
  const _RoomHeader({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THE GROUP DECISION',
          style: TextStyle(
            color: colors.accent,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                room.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.12,
                    ),
              ),
            ),
            const SizedBox(width: 8),
            RoomStatusPill(status: room.status),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.event_outlined, size: 16, color: colors.muted),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                formatMealTime(room.mealAt),
                style: TextStyle(color: colors.muted),
              ),
            ),
          ],
        ),
        if (room.description.isNotEmpty) ...[
          const SizedBox(height: 14),
          Text(
            room.description,
            style: TextStyle(color: colors.muted, height: 1.5),
          ),
        ],
      ],
    );
  }
}

class _WinnerCard extends StatelessWidget {
  const _WinnerCard({
    required this.room,
    required this.winner,
    required this.onMaps,
    required this.onCalendar,
    required this.onWebsite,
  });

  final Room room;
  final RestaurantOption? winner;
  final VoidCallback onMaps;
  final VoidCallback onCalendar;
  final VoidCallback? onWebsite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colors.accent.withValues(alpha: 0.45)),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3A2D1C), Color(0xFF171411)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.celebration_rounded, color: colors.accent, size: 28),
          const SizedBox(height: 16),
          Text(
            "WE'RE GOING TO",
            style: TextStyle(
              color: colors.accent,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            winner?.title ?? 'The table is still open',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (winner?.address?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(winner!.address!, style: TextStyle(color: colors.muted)),
          ],
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: winner == null ? null : onMaps,
                icon: const Icon(Icons.map_outlined),
                label: const Text('Open in Maps'),
              ),
              OutlinedButton.icon(
                onPressed: onCalendar,
                icon: const Icon(Icons.calendar_today_outlined),
                label: const Text('Add to calendar'),
              ),
              if (onWebsite != null)
                OutlinedButton.icon(
                  onPressed: onWebsite,
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: const Text('Website'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.option,
    required this.voteCount,
    required this.selected,
    required this.canVote,
    required this.onVote,
    required this.onMaps,
    required this.onWebsite,
  });

  final RestaurantOption option;
  final int voteCount;
  final bool selected;
  final bool canVote;
  final VoidCallback onVote;
  final VoidCallback onMaps;
  final VoidCallback? onWebsite;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SurfaceCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: selected ? colors.accentSoft : colors.surface2,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                selected ? Icons.check_rounded : Icons.restaurant_menu_rounded,
                color: colors.accent,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.title,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  if (option.address?.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      option.address!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: colors.muted, fontSize: 12, height: 1.3),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    '$voteCount ${voteCount == 1 ? 'vote' : 'votes'}',
                    style: TextStyle(
                      color: selected ? colors.accent : colors.subtle,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (canVote)
              IconButton(
                tooltip:
                    selected ? 'Your current vote' : 'Vote for ${option.title}',
                onPressed: selected ? null : onVote,
                icon: Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: selected ? colors.accent : colors.muted,
                ),
              )
            else ...[
              IconButton(
                tooltip: 'Open in Maps',
                onPressed: onMaps,
                icon: Icon(Icons.map_outlined, color: colors.muted),
              ),
              if (onWebsite != null)
                IconButton(
                  tooltip: 'Open website',
                  onPressed: onWebsite,
                  icon: Icon(Icons.open_in_new_rounded, color: colors.muted),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ParticipantChip extends StatelessWidget {
  const _ParticipantChip({
    required this.participant,
    required this.hasVoted,
  });

  final RoomParticipant participant;
  final bool hasVoted;

  @override
  Widget build(BuildContext context) {
    final label = participant.displayName.trim().isNotEmpty
        ? participant.displayName
        : participant.email;
    return Chip(
      avatar: UserAvatar(
        initials: _initials(label),
        seed: participant.userId,
        size: 24,
      ),
      label: Text(label.isEmpty ? 'Guest' : label),
      deleteIcon: Icon(
        hasVoted ? Icons.check_circle : Icons.schedule_rounded,
        size: 16,
        color: hasVoted ? context.colors.success : context.colors.subtle,
      ),
      onDeleted: () {},
      shape: StadiumBorder(
        side: BorderSide(color: context.colors.border),
      ),
      backgroundColor: context.colors.surface,
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.note, required this.isMine});

  final RoomNote note;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SurfaceCard(
        padding: const EdgeInsets.all(14),
        backgroundColor: isMine ? colors.accentSoft : colors.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              color: isMine ? colors.accent : colors.muted,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(note.text, style: const TextStyle(height: 1.45))),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _InlineEmpty extends StatelessWidget {
  const _InlineEmpty({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          message,
          style: TextStyle(color: context.colors.muted, height: 1.45),
        ),
      );
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(message, textAlign: TextAlign.center),
        ),
      );
}

String _initials(String value) {
  final words = value.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
  final first = words.take(2).map((word) => word[0].toUpperCase()).join();
  return first.isEmpty ? '?' : first;
}
