import '../core/countdown.dart';
import 'generated/app_localizations.dart';

String describeRemainingLocalized(
  AppLocalizations l10n,
  Remaining remaining, {
  bool compact = false,
}) {
  if (remaining.isPast) return l10n.momentHasPassed;

  final parts = <String>[];
  if (remaining.years > 0) {
    parts.add(l10n.durationYearCount(remaining.years));
  }
  if (remaining.months > 0) {
    parts.add(l10n.durationMonthCount(remaining.months));
  }
  if (remaining.days > 0) {
    parts.add(l10n.durationDayCount(remaining.days));
  }
  if (remaining.hours > 0) {
    parts.add(l10n.durationHourCount(remaining.hours));
  }

  if (parts.isEmpty) {
    return remaining.minutes > 0
        ? l10n.durationMinuteCount(remaining.minutes)
        : l10n.durationSecondCount(remaining.seconds);
  }
  if (compact) return parts.take(2).join(' · ');
  if (parts.length == 1) return parts.first;

  final last = parts.removeLast();
  return '${parts.join(', ')} ${l10n.and} $last';
}
