import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/rooms.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../providers/room_providers.dart';
import '../widgets/room_widgets.dart';

class RoomsHomeScreen extends ConsumerStatefulWidget {
  const RoomsHomeScreen({super.key});

  @override
  ConsumerState<RoomsHomeScreen> createState() => _RoomsHomeScreenState();
}

class _RoomsHomeScreenState extends ConsumerState<RoomsHomeScreen> {
  Timer? _deadlineTimer;
  DateTime? _scheduledDeadline;

  @override
  void dispose() {
    _deadlineTimer?.cancel();
    super.dispose();
  }

  void _scheduleDeadline(List<Room> rooms) {
    final open = rooms
        .where((room) =>
            room.status == RoomStatus.open &&
            room.mealAt.isAfter(DateTime.now()))
        .toList()
      ..sort((left, right) => left.mealAt.compareTo(right.mealAt));
    if (open.isEmpty) {
      _deadlineTimer?.cancel();
      _deadlineTimer = null;
      _scheduledDeadline = null;
      return;
    }
    final nextDeadline = open.first.mealAt;
    if (_scheduledDeadline == nextDeadline &&
        _deadlineTimer?.isActive == true) {
      return;
    }
    _deadlineTimer?.cancel();
    _scheduledDeadline = nextDeadline;
    _deadlineTimer = Timer(
      nextDeadline.difference(DateTime.now()),
      () async {
        _scheduledDeadline = null;
        final now = DateTime.now();
        for (final room in open.where((room) => !room.mealAt.isAfter(now))) {
          try {
            await ref.read(roomRepositoryProvider).finalizeRoom(room.id);
          } catch (error) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not reveal the winner: $error')),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(roomsProvider, (previous, next) {
      next.whenData(_scheduleDeadline);
    });
    final asyncRooms = ref.watch(roomsProvider);
    final rooms = asyncRooms.value ?? const <Room>[];
    final openRooms = rooms
        .where((room) => room.status == RoomStatus.open)
        .toList()
      ..sort((left, right) => left.mealAt.compareTo(right.mealAt));
    final featured = openRooms.isEmpty ? null : openRooms.first;
    if (asyncRooms.hasValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _scheduleDeadline(rooms);
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'THE TABLE IS YOURS',
                                style: TextStyle(
                                  color: context.colors.accent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Where are we\\ngoing?',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontSize: 42,
                                      height: 1.03,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Good meals start with a group decision.',
                                style: TextStyle(
                                  color: context.colors.muted,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        FilledButton.icon(
                          onPressed: () => context.push(Routes.newRoom),
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('New decision'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (asyncRooms.isLoading && !asyncRooms.hasValue)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (asyncRooms.hasError)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'Your decisions could not be loaded.\n${asyncRooms.error}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                else if (rooms.isEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                    sliver: SliverToBoxAdapter(
                      child: EmptyRoomsState(
                        onCreate: () => context.push(Routes.newRoom),
                      ),
                    ),
                  )
                else ...[
                  if (featured != null)
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                      sliver: SliverToBoxAdapter(
                        child: _FeaturedRoomCard(room: featured),
                      ),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Text(
                            'Your table',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${rooms.length}',
                            style: TextStyle(
                              color: context.colors.subtle,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                    sliver: SliverList.separated(
                      itemCount: rooms.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _RoomRow(
                        room: rooms[index],
                        isFeatured: rooms[index].id == featured?.id,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedRoomCard extends StatelessWidget {
  const _FeaturedRoomCard({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: const Color(0xFF211B13),
      borderRadius: BorderRadius.circular(26),
      child: InkWell(
        onTap: () => context.push('${Routes.room}/${room.id}'),
        borderRadius: BorderRadius.circular(26),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: colors.accent.withValues(alpha: 0.32)),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2C2419), Color(0xFF171411)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_dining_rounded,
                      color: Color(0xFFC4A47A), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'NEXT UP',
                    style: TextStyle(
                      color: colors.accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const Spacer(),
                  const RoomStatusPill(status: RoomStatus.open),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                room.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.12,
                    ),
              ),
              if (room.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  room.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colors.muted, height: 1.45),
                ),
              ],
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(Icons.event_outlined, size: 16, color: colors.muted),
                  const SizedBox(width: 7),
                  Text(
                    formatMealTime(room.mealAt),
                    style: TextStyle(color: colors.muted, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              RoomProgress(
                votesCast: room.votesCast,
                participantCount: room.participantCount,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Open decision',
                    style: TextStyle(
                      color: colors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded,
                      size: 17, color: colors.accent),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomRow extends StatelessWidget {
  const _RoomRow({required this.room, required this.isFeatured});

  final Room room;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SurfaceCard(
      onTap: () => context.push('${Routes.room}/${room.id}'),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.surface2,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.restaurant_menu_rounded,
              color: colors.accent,
              size: 23,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        room.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    RoomStatusPill(status: room.status),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  formatMealTime(room.mealAt),
                  style: TextStyle(color: colors.muted, fontSize: 12),
                ),
                const SizedBox(height: 10),
                RoomProgress(
                  votesCast: room.votesCast,
                  participantCount: room.participantCount,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right_rounded, color: colors.subtle),
        ],
      ),
    );
  }
}
