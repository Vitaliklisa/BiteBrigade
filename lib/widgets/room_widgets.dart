import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/rooms.dart';
import '../core/theme.dart';

String formatMealTime(DateTime value) =>
    DateFormat('EEE, MMM d · h:mm a').format(value.toLocal());

class RoomStatusPill extends StatelessWidget {
  const RoomStatusPill({super.key, required this.status});

  final RoomStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (label, color, icon) = switch (status) {
      RoomStatus.open => ('OPEN', colors.accent, Icons.how_to_vote_rounded),
      RoomStatus.decided => ('DECIDED', colors.success, Icons.check_rounded),
      RoomStatus.cancelled => ('CANCELLED', colors.subtle, Icons.close_rounded),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.9,
            ),
          ),
        ],
      ),
    );
  }
}

class RoomProgress extends StatelessWidget {
  const RoomProgress({
    super.key,
    required this.votesCast,
    required this.participantCount,
  });

  final int votesCast;
  final int participantCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final total = participantCount > 0 ? participantCount : 1;
    final progress = (votesCast / total).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.people_alt_outlined, size: 16, color: colors.muted),
            const SizedBox(width: 6),
            Text(
              '$votesCast of $participantCount voted',
              style: TextStyle(
                color: colors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: colors.borderStrong,
            color: colors.accent,
          ),
        ),
      ],
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: backgroundColor ?? colors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.border),
          ),
          child: child,
        ),
      ),
    );
  }
}

class EmptyRoomsState extends StatelessWidget {
  const EmptyRoomsState({super.key, required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SurfaceCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: colors.accentSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.restaurant_menu_rounded,
              color: colors.accent,
              size: 30,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No decisions on the table',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Bring your people together and let everyone pick the place.',
            style: TextStyle(color: colors.muted, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: onCreate,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Start a decision'),
          ),
        ],
      ),
    );
  }
}
