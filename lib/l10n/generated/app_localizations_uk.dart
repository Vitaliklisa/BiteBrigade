// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get language => 'Мова';

  @override
  String get followSystemLanguage => 'Мова системи';

  @override
  String get languageSaveFailed => 'Не вдалося зберегти налаштування мови.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get settings => 'Налаштування';

  @override
  String get biteBrigadeUser => 'Учасник Bite Brigade';

  @override
  String get guestAccount => 'Гостьовий обліковий запис';

  @override
  String mealPlansCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count плану харчування',
      many: '$count планів харчування',
      few: '$count плани харчування',
      one: '$count план харчування',
    );
    return '$_temp0';
  }

  @override
  String get notSignedIn => 'Ви не ввійшли';

  @override
  String get syncAndShareDescription =>
      'Увійдіть, щоб синхронізувати плани харчування між пристроями та планувати разом із друзями, родиною й командами.';

  @override
  String get signIn => 'Увійти';

  @override
  String get appearance => 'Вигляд';

  @override
  String get darkTheme => 'Темна';

  @override
  String get lightTheme => 'Світла';

  @override
  String get systemTheme => 'Системна';

  @override
  String get time => 'Час';

  @override
  String get timeFormatDescription =>
      'Оберіть формат відображення часу прийому їжі. У планах завжди зберігається точний час.';

  @override
  String get twelveHourFormat => '12-годинний (AM/PM)';

  @override
  String get twentyFourHourFormat => '24-годинний';

  @override
  String get about => 'Про застосунок';

  @override
  String get version => 'Версія';

  @override
  String get sync => 'Синхронізація';

  @override
  String get safety => 'Безпека';

  @override
  String get blockedPeople => 'Заблоковані люди';

  @override
  String get legal => 'Юридична інформація';

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get termsOfService => 'Умови використання';

  @override
  String get helpAndSupport => 'Допомога та підтримка';

  @override
  String get signedOut => 'Ви вийшли.';

  @override
  String get signOut => 'Вийти';
}
