import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:table_talk/core/rooms.dart';
import 'package:table_talk/l10n/generated/app_localizations.dart';
import 'package:table_talk/providers/app_providers.dart';
import 'package:table_talk/providers/room_providers.dart';
import 'package:table_talk/screens/crews_screen.dart';
import 'package:table_talk/services/auth_service.dart';

void main() {
  testWidgets('crew detail back button returns to the crews list',
      (tester) async {
    final router = GoRouter(
      initialLocation: '/crews/c1',
      routes: [
        GoRoute(
          path: '/crews',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('Crews list'))),
        ),
        GoRoute(
          path: '/crews/:id',
          builder: (context, state) =>
              CrewDetailScreen(crewId: state.pathParameters['id']!),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserProvider.overrideWithValue(
            const AppUser(id: 'u1', email: 'owner@example.com'),
          ),
          crewsProvider.overrideWith(
            (ref) => Stream.value([
              Crew(
                id: 'c1',
                name: 'Dinner crew',
                ownerId: 'u1',
                memberIds: const ['u1'],
                isCouple: false,
                createdAt: DateTime(2026),
              ),
            ]),
          ),
          crewMembersProvider('c1')
              .overrideWith((ref) => Stream.value(const [])),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Dinner crew'), findsOneWidget);
    final backButton = find.byTooltip('Back');
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/crews');
    expect(find.text('Crews list'), findsOneWidget);
  });
}
