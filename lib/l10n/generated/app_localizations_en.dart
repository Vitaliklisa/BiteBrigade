// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

  @override
  String get followSystemLanguage => 'Follow system language';

  @override
  String get languageSaveFailed => 'Could not save your language preference.';

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
  String get settings => 'Settings';

  @override
  String get biteBrigadeUser => 'Bite Brigade member';

  @override
  String get guestAccount => 'Guest account';

  @override
  String mealPlansCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meal plans',
      one: '$count meal plan',
    );
    return '$_temp0';
  }

  @override
  String get notSignedIn => 'You are not signed in';

  @override
  String get syncAndShareDescription =>
      'Sign in to sync meal plans across devices and plan with friends, family, and crews.';

  @override
  String get signIn => 'Sign in';

  @override
  String get appearance => 'Appearance';

  @override
  String get darkTheme => 'Dark';

  @override
  String get lightTheme => 'Light';

  @override
  String get systemTheme => 'System';

  @override
  String get time => 'Time';

  @override
  String get timeFormatDescription =>
      'Choose how meal times are shown. Your plans keep the exact time either way.';

  @override
  String get twelveHourFormat => '12-hour (AM/PM)';

  @override
  String get twentyFourHourFormat => '24-hour';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get sync => 'Sync';

  @override
  String get safety => 'Safety';

  @override
  String get blockedPeople => 'Blocked people';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get termsOfService => 'Terms of service';

  @override
  String get helpAndSupport => 'Help & support';

  @override
  String get signedOut => 'Signed out.';

  @override
  String get signOut => 'Sign out';
}
