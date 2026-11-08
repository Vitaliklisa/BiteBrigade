import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/rooms.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../providers/app_providers.dart';
import '../providers/room_providers.dart';
import '../widgets/room_widgets.dart';

class TableTalkInvitationsScreen extends ConsumerWidget {
  const TableTalkInvitationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomInvitationsProvider);
    final crews = ref.watch(crewInvitationsProvider);
    final error = rooms.error ?? crews.error;
    final loading = rooms.isLoading || crews.isLoading;
    final roomInvites = rooms.value ?? const <RoomInvitation>[];
    final crewInvites = crews.value ?? const <CrewInvitation>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Invitations')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: loading && roomInvites.isEmpty && crewInvites.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : error != null
                  ? _InvitationError(
                      message: 'Invitations could not be loaded: $error',
                    )
                  : roomInvites.isEmpty && crewInvites.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(24),
                          child: SurfaceCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.mark_email_read_outlined,
                                  color: context.colors.accent,
                                  size: 38,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Nothing waiting for you.',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'When someone asks you to join a dinner decision or crew, it will show up here.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: context.colors.muted,
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(22, 14, 22, 32),
                          children: [
                            if (roomInvites.isNotEmpty) ...[
                              Text(
                                'Dinner decisions',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              for (final invitation in roomInvites)
                                _RoomInvitationCard(invitation: invitation),
                            ],
                            if (crewInvites.isNotEmpty) ...[
                              if (roomInvites.isNotEmpty)
                                const SizedBox(height: 22),
                              Text(
                                'Crews',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              for (final invitation in crewInvites)
                                _CrewInvitationCard(invitation: invitation),
                            ],
                          ],
                        ),
        ),
      ),
    );
  }
}

class _RoomInvitationCard extends ConsumerStatefulWidget {
  const _RoomInvitationCard({required this.invitation});

  final RoomInvitation invitation;

  @override
  ConsumerState<_RoomInvitationCard> createState() =>
      _RoomInvitationCardState();
}

class _RoomInvitationCardState extends ConsumerState<_RoomInvitationCard> {
  bool _busy = false;

  Future<void> _respond(bool accept) async {
    if (_busy) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    setState(() => _busy = true);
    try {
      await ref.read(roomRepositoryProvider).respondToRoomInvitation(
            invitation: widget.invitation,
            userId: user.id,
            email: user.email,
            displayName: user.displayName ?? '',
            accept: accept,
          );
      if (!mounted || !accept) return;
      await context.push('${Routes.room}/${widget.invitation.roomId}');
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Could not respond to this invitation: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.restaurant_menu_rounded, color: colors.accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.invitation.roomTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  widget.invitation.role.name.toUpperCase(),
                  style: TextStyle(
                    color: colors.subtle,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'You’re invited to help decide where the group will eat.',
              style: TextStyle(color: colors.muted, height: 1.4),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: _busy ? null : () => _respond(false),
                  child: const Text('Decline'),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _busy ? null : () => _respond(true),
                  child: _busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Join decision'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CrewInvitationCard extends ConsumerStatefulWidget {
  const _CrewInvitationCard({required this.invitation});

  final CrewInvitation invitation;

  @override
  ConsumerState<_CrewInvitationCard> createState() =>
      _CrewInvitationCardState();
}

class _CrewInvitationCardState extends ConsumerState<_CrewInvitationCard> {
  bool _busy = false;

  Future<void> _respond(bool accept) async {
    if (_busy) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    setState(() => _busy = true);
    try {
      await ref.read(roomRepositoryProvider).respondToCrewInvitation(
            invitationId: widget.invitation.id,
            userId: user.id,
            email: user.email,
            displayName: user.displayName ?? '',
            accept: accept,
          );
      if (mounted && accept) {
        context.go('${Routes.crew}/${widget.invitation.crewId}');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Could not respond to this invitation: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SurfaceCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget.invitation.isCouple
                      ? Icons.favorite_border_rounded
                      : Icons.groups_rounded,
                  color: colors.accent,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.invitation.crewName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (widget.invitation.isCouple)
                  Text(
                    'TWO-PERSON',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.invitation.isCouple
                  ? 'Join this two-person crew to share future meal plans automatically.'
                  : 'Join this crew to receive and shape future meal plans.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.muted, height: 1.4),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: _busy ? null : () => _respond(false),
                  child: const Text('Decline'),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _busy ? null : () => _respond(true),
                  child: _busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Join crew'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InvitationError extends StatelessWidget {
  const _InvitationError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(message, textAlign: TextAlign.center),
        ),
      );
}
