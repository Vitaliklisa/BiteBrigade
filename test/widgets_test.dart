import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/theme.dart';
import 'package:table_talk/widgets/arrival_celebration.dart';
import 'package:table_talk/widgets/countdown_face.dart';

/// Wraps a widget in the app's real theme so the palette extension resolves —
/// without it every `context.colors` lookup falls back and the test would not
/// be exercising the same styles the app ships.
Widget _host(Widget child) {
  return MaterialApp(
    theme: AppTheme.build(brightness: Brightness.dark),
    home: Scaffold(body: SingleChildScrollView(child: child)),
  );
}

void main() {
  group('CountdownFace', () {
    testWidgets('renders the four unit tiles with padded values',
        (tester) async {
      final now = DateTime(2026, 1, 15, 10, 0);
      final target = DateTime(2028, 4, 20, 14, 30);

      await tester.pumpWidget(_host(CountdownFace(target: target, now: now)));

      expect(find.text('02'), findsOneWidget); // years
      expect(find.text('03'), findsOneWidget); // months
      expect(find.text('05'), findsOneWidget); // days
      expect(find.text('YEARS'), findsOneWidget);
      expect(find.text('MONTHS'), findsOneWidget);
      expect(find.text('DAYS'), findsOneWidget);
      expect(find.text('HOURS'), findsOneWidget);
    });

    testWidgets('shows the ticking minutes and seconds line', (tester) async {
      final now = DateTime(2026, 6, 1, 12, 0, 0);
      final target = DateTime(2026, 6, 1, 12, 4, 30);

      await tester.pumpWidget(_host(CountdownFace(target: target, now: now)));

      expect(find.textContaining('min ·'), findsOneWidget);
      expect(find.textContaining('sec remaining'), findsOneWidget);
    });

    testWidgets('renders nothing once the moment has passed', (tester) async {
      final now = DateTime(2026, 6, 1);
      final target = DateTime(2026, 5, 1);

      await tester.pumpWidget(_host(CountdownFace(target: target, now: now)));

      expect(find.text('00'), findsNothing);
      expect(find.byType(GridView), findsNothing);
    });
  });

  group('ArrivalCelebration', () {
    testWidgets('announces the day and names the countdown', (tester) async {
      await tester.pumpWidget(
        _host(const ArrivalCelebration(
            title: 'Wedding day', description: 'Finally')),
      );
      // Let the post-frame confetti callback and the ring animation start.
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('THE DAY HAS COME'), findsOneWidget);
      expect(find.textContaining('Wedding day is here'), findsOneWidget);

      // The confetti controller repeats; drain the timer so the test does not
      // fail on a pending animation.
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('falls back to its own closing line without a description',
        (tester) async {
      await tester.pumpWidget(_host(const ArrivalCelebration(title: 'Launch')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.textContaining('enjoy every minute of it'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
    });
  });
}
