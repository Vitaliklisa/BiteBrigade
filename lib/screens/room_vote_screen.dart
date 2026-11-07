import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/rooms.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../providers/app_providers.dart';
import '../providers/room_providers.dart';
import '../services/room_repository.dart';

class RoomVoteScreen extends ConsumerStatefulWidget {
  const RoomVoteScreen({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<RoomVoteScreen> createState() => _RoomVoteScreenState();
}

class _RoomVoteScreenState extends ConsumerState<RoomVoteScreen> {
  final _swiper = CardSwiperController();
  bool _listMode = false;
  bool _saving = false;
  String? _lastVotedOption;
  String? _error;

  @override
  void dispose() {
    unawaited(_swiper.dispose());
    super.dispose();
  }

  Future<void> _vote(RestaurantOption option) async {
    final user = ref.read(currentUserProvider);
    if (user == null || _saving) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(roomRepositoryProvider).vote(
            roomId: widget.roomId,
            userId: user.id,
            optionId: option.id,
          );
      if (mounted) setState(() => _lastVotedOption = option.title);
    } on RoomFailure catch (error) {
      if (mounted) setState(() => _error = error.message);
    } catch (error) {
      if (mounted) {
        setState(() => _error = 'Your vote could not be saved: $error');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<bool> _onSwipe(
    List<RestaurantOption> options,
    int previousIndex,
    CardSwiperDirection direction,
  ) async {
    if (previousIndex < 0 || previousIndex >= options.length) return true;
    if (direction.isCloseTo(CardSwiperDirection.right)) {
      await _vote(options[previousIndex]);
      return _error == null;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomProvider(widget.roomId));
    final optionsAsync = ref.watch(roomOptionsProvider(widget.roomId));
    final votesAsync = ref.watch(roomVotesProvider(widget.roomId));
    final participantsAsync =
        ref.watch(roomParticipantsProvider(widget.roomId));
    final user = ref.watch(currentUserProvider);
    final room = roomAsync.value;
    final options = optionsAsync.value ?? const <RestaurantOption>[];
    final votes = votesAsync.value ?? const <RoomVote>[];
    final participants = participantsAsync.value ?? const <RoomParticipant>[];
    final currentVote =
        votes.where((vote) => vote.userId == user?.id).firstOrNull;
    final currentChoice = currentVote == null
        ? null
        : options
            .where((option) => option.id == currentVote.optionId)
            .firstOrNull;
    final canVote = room?.status == RoomStatus.open &&
        (room?.createdBy == user?.id ||
            participants.any((p) => p.userId == user?.id && p.accepted));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cast your vote'),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => _listMode = !_listMode),
            icon:
                Icon(_listMode ? Icons.style_rounded : Icons.view_list_rounded),
            label: Text(_listMode ? 'Swipe' : 'List'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: roomAsync.isLoading && room == null
          ? const Center(child: CircularProgressIndicator())
          : roomAsync.hasError
              ? _VoteError(
                  message: 'Could not load this room: ${roomAsync.error}')
              : room == null
                  ? const _VoteError(
                      message: 'This decision is no longer available.')
                  : !canVote
                      ? const _VoteError(
                          message:
                              'Accept the invitation before casting a vote.',
                        )
                      : optionsAsync.hasError
                          ? _VoteError(
                              message:
                                  'Could not load restaurants: ${optionsAsync.error}',
                            )
                          : options.isEmpty
                              ? const _VoteError(
                                  message:
                                      'There are no restaurants to vote on yet.',
                                )
                              : Center(
                                  child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 700),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 12, 20, 24),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            room.name,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            currentChoice == null
                                                ? 'Swipe right to pick it. Swipe left to pass.'
                                                : 'Your current pick: ${currentChoice.title}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: context.colors.muted,
                                              fontSize: 13,
                                            ),
                                          ),
                                          if (_error != null) ...[
                                            const SizedBox(height: 12),
                                            Text(
                                              _error!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: context.colors.danger),
                                            ),
                                          ],
                                          const SizedBox(height: 14),
                                          Expanded(
                                            child: _listMode
                                                ? _OptionList(
                                                    options: options,
                                                    currentOptionId:
                                                        currentVote?.optionId,
                                                    busy: _saving,
                                                    onVote: _vote,
                                                  )
                                                : CardSwiper(
                                                    key: ValueKey(options
                                                        .map((option) =>
                                                            option.id)
                                                        .join()),
                                                    controller: _swiper,
                                                    cardsCount: options.length,
                                                    initialIndex: 0,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    isLoop: false,
                                                    numberOfCardsDisplayed:
                                                        math.min(
                                                      3,
                                                      options.length,
                                                    ),
                                                    allowedSwipeDirection:
                                                        const AllowedSwipeDirection
                                                            .symmetric(
                                                      horizontal: true,
                                                    ),
                                                    onSwipe: (previous, next,
                                                            direction) =>
                                                        _onSwipe(
                                                      options,
                                                      previous,
                                                      direction,
                                                    ),
                                                    onEnd: () =>
                                                        setState(() {}),
                                                    cardBuilder: (
                                                      context,
                                                      index,
                                                      horizontalOffset,
                                                      verticalOffset,
                                                    ) =>
                                                        _SwipeRestaurantCard(
                                                      option: options[index],
                                                      offset: horizontalOffset,
                                                    ),
                                                  ),
                                          ),
                                          if (!_listMode) ...[
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: OutlinedButton.icon(
                                                    onPressed: _saving
                                                        ? null
                                                        : () => _swiper.swipe(
                                                              CardSwiperDirection
                                                                  .left,
                                                            ),
                                                    icon: const Icon(
                                                        Icons.close_rounded),
                                                    label: const Text('Pass'),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: FilledButton.icon(
                                                    onPressed: _saving
                                                        ? null
                                                        : () => _swiper.swipe(
                                                              CardSwiperDirection
                                                                  .right,
                                                            ),
                                                    icon: const Icon(
                                                        Icons.favorite_rounded),
                                                    label: const Text('Vote'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (_lastVotedOption != null) ...[
                                            const SizedBox(height: 12),
                                            Text(
                                              'You voted for $_lastVotedOption.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: context.colors.success,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                          const SizedBox(height: 12),
                                          TextButton(
                                            onPressed: () => context.go(
                                              '${Routes.room}/${room.id}',
                                            ),
                                            child:
                                                const Text('Back to decision'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
    );
  }
}

class _SwipeRestaurantCard extends StatelessWidget {
  const _SwipeRestaurantCard({
    required this.option,
    required this.offset,
  });

  final RestaurantOption option;
  final int offset;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF352A1C), Color(0xFF171411)],
        ),
        border: Border.all(color: colors.accent.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 24,
            top: 24,
            child: Icon(
              Icons.restaurant_menu_rounded,
              size: 60,
              color: colors.accent.withValues(alpha: 0.22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (offset > 15)
                  const _SwipeLabel(text: 'YES, LET’S GO', accepted: true),
                if (offset < -15)
                  const _SwipeLabel(text: 'MAYBE NEXT TIME', accepted: false),
                const Spacer(),
                const Text(
                  'ON THE MENU',
                  style: TextStyle(
                    color: Color(0xFFC4A47A),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  option.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: 'serif',
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                ),
                if (option.address?.isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: Color(0xFFC4A47A)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          option.address!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colors.muted, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 26),
                Row(
                  children: [
                    const Icon(Icons.swipe_rounded,
                        color: Color(0xFFC4A47A), size: 18),
                    const SizedBox(width: 7),
                    Text(
                      'Right to vote · left to pass',
                      style: TextStyle(color: colors.muted, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SwipeLabel extends StatelessWidget {
  const _SwipeLabel({required this.text, required this.accepted});

  final String text;
  final bool accepted;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: accepted
                ? context.colors.success.withValues(alpha: 0.14)
                : context.colors.danger.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: accepted ? context.colors.success : context.colors.danger,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: accepted ? context.colors.success : context.colors.danger,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ),
      );
}

class _OptionList extends StatelessWidget {
  const _OptionList({
    required this.options,
    required this.currentOptionId,
    required this.busy,
    required this.onVote,
  });

  final List<RestaurantOption> options;
  final String? currentOptionId;
  final bool busy;
  final ValueChanged<RestaurantOption> onVote;

  @override
  Widget build(BuildContext context) => ListView.separated(
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final option = options[index];
          final selected = option.id == currentOptionId;
          return Card(
            child: ListTile(
              leading: Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.restaurant_rounded,
                color: selected ? context.colors.accent : context.colors.muted,
              ),
              title: Text(option.title),
              subtitle: option.address?.isNotEmpty == true
                  ? Text(option.address!)
                  : null,
              trailing: FilledButton(
                onPressed: busy || selected ? null : () => onVote(option),
                child: Text(selected ? 'Your vote' : 'Vote'),
              ),
            ),
          );
        },
      );
}

class _VoteError extends StatelessWidget {
  const _VoteError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Text(message, textAlign: TextAlign.center),
        ),
      );
}
