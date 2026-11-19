// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'Idioma';

  @override
  String get followSystemLanguage => 'Usar el idioma del sistema';

  @override
  String get languageSaveFailed =>
      'No se pudo guardar la preferencia de idioma.';

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
  String get settings => 'Ajustes';

  @override
  String get biteBrigadeUser => 'Miembro de Bite Brigade';

  @override
  String get guestAccount => 'Cuenta de invitado';

  @override
  String mealPlansCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count planes de comida',
      one: '$count plan de comida',
    );
    return '$_temp0';
  }

  @override
  String get notSignedIn => 'No has iniciado sesión';

  @override
  String get syncAndShareDescription =>
      'Inicia sesión para sincronizar tus planes de comida entre dispositivos y planificar con amigos, familiares y grupos.';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get appearance => 'Apariencia';

  @override
  String get darkTheme => 'Oscuro';

  @override
  String get lightTheme => 'Claro';

  @override
  String get systemTheme => 'Sistema';

  @override
  String get time => 'Hora';

  @override
  String get timeFormatDescription =>
      'Elige cómo se muestran las horas de las comidas. Tus planes conservan la hora exacta.';

  @override
  String get twelveHourFormat => '12 horas (a. m./p. m.)';

  @override
  String get twentyFourHourFormat => '24 horas';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get sync => 'Sincronización';

  @override
  String get safety => 'Seguridad';

  @override
  String get blockedPeople => 'Personas bloqueadas';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos del servicio';

  @override
  String get helpAndSupport => 'Ayuda y soporte';

  @override
  String get signedOut => 'Sesión cerrada.';

  @override
  String get signOut => 'Cerrar sesión';
}
