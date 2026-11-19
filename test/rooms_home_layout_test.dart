import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/rooms.dart';
import 'package:table_talk/providers/room_providers.dart';
import 'package:table_talk/screens/rooms_home_screen.dart';

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
}
