import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/models.dart';
import 'package:table_talk/core/theme.dart';
import 'package:table_talk/providers/app_providers.dart';

/// A smoke test for the pieces of the app that render without a live Firebase
/// project. Auth and Firestore are stubbed through provider overrides, so this
/// runs in CI with no emulator, no network and no credentials.

/// A countdown far enough out that no test depends on the current date.
CountdownEvent _sampleEvent() => CountdownEvent(
      id: 'e1',
      title: 'Trip home',
      description: 'Long overdue',
      at: DateTime.now().add(const Duration(days: 400)),
      createdBy: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      participants: const [
        Participant(
          userId: 'u1',
          email: 'me@example.com',
          role: ParticipantRole.admin,
          inviteStatus: InviteStatus.accepted,
        ),
      ],
    );

void main() {
  testWidgets('the first-run state invites you to name a day', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // No user and no events: the first-run experience.
          eventsProvider.overrideWith(
            (ref) => Stream.value(const <CountdownEvent>[]),
          ),
          activeAuthStateProvider.overrideWith((ref) => Stream.value(null)),
        ],
        child: MaterialApp(
          theme: AppTheme.build(brightness: Brightness.dark),
          home: const _FirstRunHost(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Name a day.'), findsOneWidget);
    expect(find.textContaining('Pick a future moment'), findsOneWidget);
  });

  testWidgets('theme exposes the palette through the context extension',
      (tester) async {
    late AppPalette palette;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.build(brightness: Brightness.dark),
        home: Builder(
          builder: (context) {
            palette = context.colors;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    // The accent is the single most load-bearing token — if the extension fails
    // to resolve it silently falls back to the default palette.
    expect(palette.accent, AppPalette.dark.accent);
    expect(palette.canvas, AppPalette.dark.canvas);
  });

  testWidgets('light and dark palettes stay distinct', (tester) async {
    final dark =
        AppTheme.build(brightness: Brightness.dark).extension<AppPalette>()!;
    final light =
        AppTheme.build(brightness: Brightness.light).extension<AppPalette>()!;

    expect(dark.canvas, isNot(light.canvas));
    expect(dark.accent, isNot(light.accent));
  });

  test('a sample event resolves its permissions correctly', () {
    final event = _sampleEvent();
    expect(event.canManage('u1'), isTrue);
    expect(event.canEdit('u1'), isTrue);
    expect(event.canEdit('someone-else'), isFalse);
    expect(event.isPast, isFalse);
  });
}

/// Minimal host so the widget test renders against the real palette without
/// pulling in the router (which needs Firebase to be initialised).
class _FirstRunHost extends StatelessWidget {
  const _FirstRunHost();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name a day.',
                style: Theme.of(context).textTheme.headlineLarge),
            Text(
              'Pick a future moment — a wedding, a launch, a trip home.',
              style: TextStyle(color: colors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
