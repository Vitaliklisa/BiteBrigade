import 'package:table_talk/core/countdown.dart';
import 'package:table_talk/core/locale_settings.dart';
import 'package:table_talk/l10n/countdown_localization.dart';
import 'package:table_talk/l10n/generated/app_localizations.dart';
import 'package:table_talk/providers/app_providers.dart';
import 'package:table_talk/providers/locale_provider.dart';
import 'package:table_talk/screens/settings_screen.dart';
import 'package:table_talk/screens/login_screen.dart';
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

class _LoginTestApp extends ConsumerWidget {
  const _LoginTestApp();

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
      home: const LoginScreen(),
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

  test('decision and account-support copy is translated in every locale',
      () async {
    const expectedOpenDecision = {
      'en': 'Open decision',
      'fr': 'Ouvrir la décision',
      'es': 'Abrir decisión',
      'uk': 'Відкрити вибір',
      'de': 'Entscheidung öffnen',
      'zh': '查看用餐選擇',
    };
    const expectedDeleteAccountHelp = {
      'en':
          'Open Settings > Delete account and follow the confirmation steps. If you cannot sign in, contact support from the email address on your account.',
      'fr':
          'Ouvrez Réglages > Supprimer le compte et suivez les étapes de confirmation. Si vous ne pouvez pas vous connecter, contactez l’assistance depuis l’adresse e-mail de votre compte.',
      'es':
          'Abre Ajustes > Eliminar cuenta y sigue los pasos de confirmación. Si no puedes iniciar sesión, contacta con soporte desde el correo electrónico de tu cuenta.',
      'uk':
          'Відкрийте Налаштування > Видалити обліковий запис і виконайте кроки підтвердження. Якщо не можете ввійти, зверніться до підтримки з адреси електронної пошти свого облікового запису.',
      'de':
          'Öffne Einstellungen > Konto löschen und folge den Bestätigungsschritten. Wenn du dich nicht anmelden kannst, kontaktiere den Support über die E-Mail-Adresse deines Kontos.',
      'zh': '請開啟「設定」>「刪除帳戶」，並依照確認步驟操作。如果無法登入，請使用帳戶所屬的電子郵件地址聯絡支援團隊。',
    };

    for (final locale in supportedAppLocales) {
      final localizations = await AppLocalizations.delegate.load(locale);
      expect(
        localizations.openDecision,
        expectedOpenDecision[locale.languageCode],
      );
      expect(
        localizations.faqDeleteAccountAnswer,
        expectedDeleteAccountHelp[locale.languageCode],
      );
    }
  });

  test('Traditional Chinese translates the login and home hero copy', () async {
    final localizations = await AppLocalizations.delegate.load(
      const Locale('zh', 'TW'),
    );

    expect(localizations.welcomeHeading, '歡迎使用 Bite Brigade');
    expect(localizations.signIn, '登入');
    expect(localizations.tableIsYours, '餐桌由你作主');
    expect(localizations.whereAreWeGoing, '我們要去哪裡吃？');
    expect(localizations.groupDecisionDescription, '美味的一餐，從大家一起決定開始。');
  });

  test('language names are localized in every supported interface language',
      () async {
    const expectedNames = <String, List<String>>{
      'en': [
        'English',
        'French',
        'Spanish',
        'Ukrainian',
        'German',
        'Traditional Chinese (Taiwan)',
      ],
      'fr': [
        'Anglais',
        'Français',
        'Espagnol',
        'Ukrainien',
        'Allemand',
        'Chinois traditionnel (Taïwan)',
      ],
      'es': [
        'Inglés',
        'Francés',
        'Español',
        'Ucraniano',
        'Alemán',
        'Chino tradicional (Taiwán)',
      ],
      'uk': [
        'Англійська',
        'Французька',
        'Іспанська',
        'Українська',
        'Німецька',
        'Традиційна китайська (Тайвань)',
      ],
      'de': [
        'Englisch',
        'Französisch',
        'Spanisch',
        'Ukrainisch',
        'Deutsch',
        'Traditionelles Chinesisch (Taiwan)',
      ],
      'zh': ['英文', '法文', '西班牙文', '烏克蘭文', '德文', '繁體中文（台灣）'],
    };

    for (final locale in supportedAppLocales) {
      final localizations = await AppLocalizations.delegate.load(locale);
      expect(
        [
          localizations.languageEnglish,
          localizations.languageFrench,
          localizations.languageSpanish,
          localizations.languageUkrainian,
          localizations.languageGerman,
          localizations.languageChineseTaiwan,
        ],
        expectedNames[locale.languageCode],
      );
    }
  });

  testWidgets('language picker updates Settings and persists the selection',
      (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
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

    expect(find.text('🇬🇧'), findsOneWidget);
    expect(find.text('🇺🇸'), findsNothing);
    expect(find.text('🇫🇷'), findsOneWidget);
    expect(find.text('French'), findsOneWidget);
    expect(find.text('🇪🇸'), findsOneWidget);
    expect(find.text('🇺🇦'), findsOneWidget);
    expect(find.text('🇩🇪'), findsOneWidget);
    expect(find.text('🇹🇼'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('locale-option-fr')));
    await tester.pumpAndSettle();

    expect(find.text('Réglages'), findsOneWidget);
    expect(find.text('Langue'), findsOneWidget);
    expect(find.text('🇫🇷 Français'), findsOneWidget);
    expect(find.text('APPARENCE'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString(localePreferenceKey), 'fr');
  });

  testWidgets('login picker sits at top right and selects Taiwan Chinese',
      (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues({});
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
          activeAuthStateProvider.overrideWith((ref) => Stream.value(null)),
        ],
        child: const _LoginTestApp(),
      ),
    );
    await tester.pumpAndSettle();

    final picker = find.byKey(const ValueKey('login-language-picker'));
    expect(picker, findsOneWidget);
    expect(
      tester.getRect(picker).top,
      lessThan(tester.getRect(find.text('Welcome to Bite Brigade')).top),
    );
    expect(
      tester.getRect(picker).right,
      greaterThan(tester.getRect(find.text('Welcome to Bite Brigade')).right),
    );
    await tester.tap(picker);
    await tester.pumpAndSettle();

    expect(find.text('🇹🇼'), findsOneWidget);
    expect(find.text('Traditional Chinese (Taiwan)'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('locale-option-zh')));
    await tester.pumpAndSettle();

    expect(find.text('歡迎使用 Bite Brigade'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString(localePreferenceKey), 'zh');
  });
}
