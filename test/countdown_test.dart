import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/countdown.dart';

void main() {
  group('remainingUntil', () {
    test('splits a distant moment into calendar years and months', () {
      final now = DateTime(2026, 1, 15, 10, 0);
      final target = DateTime(2028, 4, 20, 14, 30);
      final r = remainingUntil(target, now);

      expect(r.years, 2);
      expect(r.months, 3);
      expect(r.days, 5);
      expect(r.hours, 4);
      expect(r.minutes, 30);
      expect(r.isPast, isFalse);
    });

    test('a month means a calendar month, not thirty days', () {
      // Jan 31 -> Feb 28 in a non-leap year is one calendar month, even though
      // only 28 days pass.
      final now = DateTime(2026, 1, 31, 0, 0);
      final target = DateTime(2026, 2, 28, 0, 0);
      final r = remainingUntil(target, now);

      expect(r.months, 1);
      expect(r.days, 0);
    });

    test('clamps 29 February when the target year is not a leap year', () {
      final now = DateTime(2024, 2, 29, 12, 0);
      final target = DateTime(2025, 2, 28, 12, 0);
      final r = remainingUntil(target, now);

      expect(r.years, 1);
      expect(r.isPast, isFalse);
    });

    test('counts the last hours, minutes and seconds of an event', () {
      final now = DateTime(2026, 6, 1, 9, 30, 15);
      final target = DateTime(2026, 6, 1, 12, 45, 45);
      final r = remainingUntil(target, now);

      expect(r.years, 0);
      expect(r.months, 0);
      expect(r.days, 0);
      expect(r.hours, 3);
      expect(r.minutes, 15);
      expect(r.seconds, 30);
    });

    test('a past moment reports isPast and zeroed units', () {
      final now = DateTime(2026, 6, 1);
      final target = DateTime(2026, 5, 1);
      final r = remainingUntil(target, now);

      expect(r.isPast, isTrue);
      expect(r.years, 0);
      expect(r.days, 0);
      expect(r.hours, 0);
    });

    test('a moment exactly now is past, not zero-remaining', () {
      final moment = DateTime(2026, 6, 1, 12, 0);
      final r = remainingUntil(moment, moment);
      expect(r.isPast, isTrue);
    });
  });

  group('pad2', () {
    test('pads single digits and leaves larger values alone', () {
      expect(pad2(0), '00');
      expect(pad2(7), '07');
      expect(pad2(42), '42');
      expect(pad2(365), '365');
    });

    test('never emits a negative width', () {
      expect(pad2(-5), '00');
    });
  });

  group('describeRemaining', () {
    test('joins the populated units with "and" before the last', () {
      final r = remainingUntil(
        DateTime(2028, 4, 20, 14, 0),
        DateTime(2026, 1, 15, 10, 0),
      );
      expect(describeRemaining(r), contains('2 years'));
      expect(describeRemaining(r), contains(' and '));
    });

    test('falls back to minutes and seconds inside the last hour', () {
      final r = remainingUntil(
        DateTime(2026, 6, 1, 12, 4, 30),
        DateTime(2026, 6, 1, 12, 0, 0),
      );
      expect(describeRemaining(r), '4 minutes');
    });

    test('reports arrival for a past moment', () {
      final r = remainingUntil(DateTime(2020, 1, 1), DateTime(2026, 1, 1));
      expect(describeRemaining(r), 'The moment has passed');
    });

    test('compact mode keeps to the two leading units', () {
      final r = remainingUntil(
        DateTime(2028, 4, 20, 14, 0),
        DateTime(2026, 1, 15, 10, 0),
      );
      final compact = describeRemaining(r, compact: true);
      expect(compact.split(' · ').length, lessThanOrEqualTo(2));
      expect(compact, contains('2 years'));
    });
  });

  group('Remaining.isImminent', () {
    test('is true only inside the final day', () {
      final soon = remainingUntil(
        DateTime(2026, 6, 1, 14, 0),
        DateTime(2026, 6, 1, 10, 0),
      );
      final later = remainingUntil(
        DateTime(2026, 6, 5, 14, 0),
        DateTime(2026, 6, 1, 10, 0),
      );

      expect(soon.isImminent, isTrue);
      expect(later.isImminent, isFalse);
    });
  });
}
