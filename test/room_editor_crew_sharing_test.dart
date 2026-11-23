import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/rooms.dart';
import 'package:table_talk/l10n/generated/app_localizations.dart';
import 'package:table_talk/providers/room_providers.dart';
import 'package:table_talk/screens/room_editor_screen.dart';

void main() {
  testWidgets('two-person crews are selected by default and can be toggled',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          crewsProvider.overrideWith(
            (ref) => Stream.value([
              Crew(
                id: 'couple',
                name: 'Two of us',
                ownerId: 'owner',
                memberIds: const ['owner', 'partner'],
                isCouple: true,
                createdAt: DateTime(2026),
              ),
              Crew(
                id: 'team',
                name: 'Team lunch',
                ownerId: 'owner',
                memberIds: const ['owner'],
                isCouple: false,
                createdAt: DateTime(2026),
              ),
            ]),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: RoomEditorScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final coupleChip = find.widgetWithText(FilterChip, 'Two of us');
    await tester.scrollUntilVisible(
      coupleChip,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Two of us'), findsOneWidget);
    final teamChip = find.widgetWithText(FilterChip, 'Team lunch');
    expect(tester.widget<FilterChip>(coupleChip).selected, isTrue);
    expect(tester.widget<FilterChip>(teamChip).selected, isFalse);

    await tester.tap(coupleChip);
    await tester.pumpAndSettle();
    expect(tester.widget<FilterChip>(coupleChip).selected, isFalse);
  });
}
