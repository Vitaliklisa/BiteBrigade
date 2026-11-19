import 'package:table_talk/core/countdown.dart';
import 'package:table_talk/core/locale_settings.dart';
import 'package:table_talk/l10n/countdown_localization.dart';
import 'package:table_talk/l10n/generated/app_localizations.dart';
import 'package:table_talk/providers/app_providers.dart';
import 'package:table_talk/providers/locale_provider.dart';
import 'package:table_talk/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _SettingsTestApp extends ConsumerWidget {
  const _SettingsTestApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp(
      locale: locale,
      supportedLocales: supportedAppLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SettingsScreen(),
    );
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('saved language takes precedence over the device language', () {
    final result = resolveLocalePreference(
      savedLanguageCode: 'es',
      deviceLocale: const Locale('fr', 'CA'),
    );

    expect(result.activeLocale, const Locale('es'));
    expect(result.selectedLocale, const Locale('es'));
  });

  test('unsupported saved and device languages fall back to English', () {
    final result = resolveLocalePreference(
      savedLanguageCode: 'pt',
      deviceLocale: const Locale('ja', 'JP'),
    );

    expect(result.activeLocale, const Locale('en'));
    expect(result.selectedLocale, isNull);
  });

  test('following system language clears a saved locale', () async {
    SharedPreferences.setMockInitialValues({localePreferenceKey: 'de'});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        localePreferenceProvider.overrideWith(
          () => LocalePreferenceController(
            initialPreference: const LocalePreference(
              activeLocale: Locale('de'),
              selectedLocale: Locale('de'),
            ),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(localePreferenceProvider.notifier).setLocale(null);

    expect(preferences.containsKey(localePreferenceKey), isFalse);
    expect(container.read(selectedLocaleProvider), isNull);
    expect(
      supportedLocaleForCode(container.read(localeProvider).languageCode),
      isNotNull,
    );
  });

  test('countdown duration uses each locale and its plural forms', () async {
    const remaining = Remaining(
      years: 1,
      months: 2,
      days: 0,
      hours: 3,
      minutes: 0,
      seconds: 0,
      totalMs: 0,
      isPast: false,
    );
    const expected = {
      'en': '1 year, 2 months and 3 hours',
      'fr': '1 an, 2 mois et 3 heures',
      'es': '1 año, 2 meses y 3 horas',
      'uk': '1 рік, 2 місяці і 3 години',
      'de': '1 Jahr, 2 Monate und 3 Stunden',
    };

    for (final entry in expected.entries) {
      final localizations =
          await AppLocalizations.delegate.load(Locale(entry.key));
      expect(describeRemainingLocalized(localizations, remaining), entry.value);
    }
  });

  testWidgets('language picker updates Settings and persists the selection',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localePreferenceProvider.overrideWith(
            () => LocalePreferenceController(
              initialPreference: resolveLocalePreference(
                savedLanguageCode: null,
                deviceLocale: const Locale('en'),
              ),
            ),
          ),
          currentUserProvider.overrideWith((ref) => null),
          eventsProvider.overrideWith((ref) => Stream.value(const [])),
        ],
        child: const _SettingsTestApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('language-selector')));
    await tester.pumpAndSettle();

    for (final flag in ['🇺🇸', '🇫🇷', '🇪🇸', '🇺🇦', '🇩🇪']) {
      expect(find.text(flag), findsOneWidget);
    }

    await tester.tap(find.byKey(const ValueKey('locale-option-fr')));
    await tester.pumpAndSettle();

    expect(find.text('Réglages'), findsOneWidget);
    expect(find.text('Langue'), findsOneWidget);
    expect(find.text('🇫🇷 Français'), findsOneWidget);
    expect(find.text('APPARENCE'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString(localePreferenceKey), 'fr');
  });
}
