// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get language => 'Sprache';

  @override
  String get followSystemLanguage => 'Sprache des Systems verwenden';

  @override
  String get languageSaveFailed =>
      'Ihre Spracheinstellung konnte nicht gespeichert werden.';

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
  String get settings => 'Einstellungen';

  @override
  String get biteBrigadeUser => 'Bite-Brigade-Mitglied';

  @override
  String get guestAccount => 'Gastkonto';

  @override
  String mealPlansCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Essenspläne',
      one: '$count Essensplan',
    );
    return '$_temp0';
  }

  @override
  String get notSignedIn => 'Sie sind nicht angemeldet';

  @override
  String get syncAndShareDescription =>
      'Melden Sie sich an, um Essenspläne geräteübergreifend zu synchronisieren und mit Freunden, Familie und Gruppen zu planen.';

  @override
  String get signIn => 'Anmelden';

  @override
  String get appearance => 'Darstellung';

  @override
  String get darkTheme => 'Dunkel';

  @override
  String get lightTheme => 'Hell';

  @override
  String get systemTheme => 'System';

  @override
  String get time => 'Zeit';

  @override
  String get timeFormatDescription =>
      'Legen Sie fest, wie Essenszeiten angezeigt werden. Ihre Pläne speichern immer die genaue Uhrzeit.';

  @override
  String get twelveHourFormat => '12-Stunden (AM/PM)';

  @override
  String get twentyFourHourFormat => '24-Stunden';

  @override
  String get about => 'Über die App';

  @override
  String get version => 'Version';

  @override
  String get sync => 'Synchronisierung';

  @override
  String get safety => 'Sicherheit';

  @override
  String get blockedPeople => 'Blockierte Personen';

  @override
  String get legal => 'Rechtliches';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get helpAndSupport => 'Hilfe & Support';

  @override
  String get signedOut => 'Abgemeldet.';

  @override
  String get signOut => 'Abmelden';
}
