// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get language => 'Langue';

  @override
  String get followSystemLanguage => 'Suivre la langue du système';

  @override
  String get languageSaveFailed =>
      'Impossible d’enregistrer votre préférence de langue.';

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
  String get settings => 'Réglages';

  @override
  String get biteBrigadeUser => 'Membre de Bite Brigade';

  @override
  String get guestAccount => 'Compte invité';

  @override
  String mealPlansCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count plans de repas',
      one: '$count plan de repas',
    );
    return '$_temp0';
  }

  @override
  String get notSignedIn => 'Vous n’êtes pas connecté';

  @override
  String get syncAndShareDescription =>
      'Connectez-vous pour synchroniser vos plans de repas entre vos appareils et planifier avec vos proches et vos groupes.';

  @override
  String get signIn => 'Se connecter';

  @override
  String get appearance => 'Apparence';

  @override
  String get darkTheme => 'Sombre';

  @override
  String get lightTheme => 'Clair';

  @override
  String get systemTheme => 'Système';

  @override
  String get time => 'Heure';

  @override
  String get timeFormatDescription =>
      'Choisissez l’affichage des heures de repas. Vos plans conservent toujours l’heure exacte.';

  @override
  String get twelveHourFormat => '12 heures (AM/PM)';

  @override
  String get twentyFourHourFormat => '24 heures';

  @override
  String get about => 'À propos';

  @override
  String get version => 'Version';

  @override
  String get sync => 'Synchronisation';

  @override
  String get safety => 'Sécurité';

  @override
  String get blockedPeople => 'Personnes bloquées';

  @override
  String get legal => 'Informations légales';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d’utilisation';

  @override
  String get helpAndSupport => 'Aide et assistance';

  @override
  String get signedOut => 'Déconnexion effectuée.';

  @override
  String get signOut => 'Se déconnecter';
}
