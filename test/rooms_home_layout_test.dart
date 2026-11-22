import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/rooms.dart';
import 'package:table_talk/core/theme.dart';
import 'package:table_talk/providers/app_providers.dart';
import 'package:table_talk/providers/room_providers.dart';
import 'package:table_talk/screens/rooms_home_screen.dart';
import 'package:table_talk/widgets/app_navigation_shell.dart';

void main() {
  testWidgets('home hero fills the desktop content width', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          roomsProvider.overrideWith((ref) => Stream.value(const <Room>[])),
        ],
        child: const MaterialApp(home: RoomsHomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.getSize(find.text('Where are we\ngoing?')).width,
        greaterThan(400));
  });

  testWidgets('home hero remains readable at phone width', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          roomsProvider.overrideWith((ref) => Stream.value(const <Room>[])),
        ],
        child: const MaterialApp(home: RoomsHomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('THE TABLE IS YOURS'), findsOneWidget);
    expect(find.text('Where are we\ngoing?'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home text uses available width inside the desktop sidebar shell',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [900.0, 1024.0, 1920.0]) {
      tester.view.physicalSize = Size(width, 900);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentUserProvider.overrideWith((ref) => null),
            roomsProvider.overrideWith((ref) => Stream.value(const <Room>[])),
          ],
          child: MaterialApp(
            theme: AppTheme.build(brightness: Brightness.dark),
            home: const AppNavigationShell(
              location: '/',
              child: RoomsHomeScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final description = tester.renderObject<RenderParagraph>(
          find.text('Good meals start with a group decision.'));
      final descriptionBoxes = description.getBoxesForSelection(
        TextSelection(
          baseOffset: 0,
          extentOffset: description.text.toPlainText().length,
        ),
      );
      expect(
        descriptionBoxes.map((box) => box.right - box.left).reduce(
              (widest, current) => widest > current ? widest : current,
            ),
        greaterThan(200),
        reason: 'home description should wrap at the $width px viewport',
      );
      final headline = tester
          .renderObject<RenderParagraph>(find.text('Where are we\ngoing?'));
      final headlineBoxes = headline.getBoxesForSelection(
        TextSelection(
          baseOffset: 0,
          extentOffset: headline.text.toPlainText().length,
        ),
      );
      expect(
        headlineBoxes.map((box) => box.right - box.left).reduce(
              (widest, current) => widest > current ? widest : current,
            ),
        greaterThan(200),
        reason: 'home headline should wrap at the $width px viewport',
      );
      expect(tester.takeException(), isNull);
    }

    addTearDown(tester.view.resetPhysicalSize);
  });
}
