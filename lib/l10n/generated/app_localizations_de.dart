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
  String get languageEnglish => 'Englisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageUkrainian => 'Ukrainisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageChineseTaiwan => 'Traditionelles Chinesisch (Taiwan)';

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

  @override
  String get homeTitle => 'Plant eine Mahlzeit.';

  @override
  String get homeDescription =>
      'Wählt gemeinsam, wo ihr essen geht, und ladet eure Gruppe ein.';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get createMealPlan => 'Essensplan erstellen';

  @override
  String get keepMealPlansSynced => 'Essenspläne synchron halten';

  @override
  String get syncMealPlansDescription =>
      'Melde dich an, um Essenspläne geräteübergreifend zu synchronisieren und gemeinsam mit deiner Gruppe ein Lokal auszuwählen.';

  @override
  String get couldNotLoadMealPlans =>
      'Essenspläne konnten nicht geladen werden. Ziehe zum erneuten Laden nach unten.';

  @override
  String get options => 'Optionen';

  @override
  String get open => 'Öffnen';

  @override
  String get openMealPlan => 'Essensplan öffnen';

  @override
  String get openDecision => 'Entscheidung öffnen';

  @override
  String get upcomingPlans => 'ANSTEHENDE ESSENSPLÄNE';

  @override
  String get newMealPlan => 'Neuer Essensplan';

  @override
  String get readyToGather => 'ES KANN LOSGEHEN';

  @override
  String get comingUp => 'DEMNÄCHST';

  @override
  String get years => 'Jahre';

  @override
  String get months => 'Monate';

  @override
  String get days => 'Tage';

  @override
  String get hours => 'Stunden';

  @override
  String minutesRemaining(int minutes, int seconds) {
    return 'Noch $minutes Min. · $seconds Sek.';
  }

  @override
  String get navHome => 'Start';

  @override
  String get navInvitations => 'Einladungen';

  @override
  String get navCrews => 'Gruppen';

  @override
  String get navNotifications => 'Mitteilungen';

  @override
  String get navSupport => 'Hilfe';

  @override
  String get tableIsYours => 'IHR ENTSCHEIDET';

  @override
  String get whereAreWeGoing => 'Wohin gehen wir?';

  @override
  String get groupDecisionDescription =>
      'Ein gutes Essen beginnt mit einer gemeinsamen Entscheidung.';

  @override
  String get newDecision => 'Neue Entscheidung';

  @override
  String get decisionsCouldNotLoad =>
      'Entscheidungen konnten nicht geladen werden.';

  @override
  String get yourTable => 'Euer Tisch';

  @override
  String get noDecisions => 'Noch keine offenen Entscheidungen';

  @override
  String get noDecisionsDescription =>
      'Bring deine Leute zusammen und lass alle den Ort aussuchen.';

  @override
  String get startDecision => 'Entscheidung starten';

  @override
  String get roomOpen => 'OFFEN';

  @override
  String get roomDecided => 'ENTSCHIEDEN';

  @override
  String get roomCancelled => 'ABGESAGT';

  @override
  String votesProgress(int votesCast, int participantCount) {
    return '$votesCast von $participantCount haben abgestimmt';
  }

  @override
  String get createAccountHeading => 'Konto erstellen';

  @override
  String get welcomeHeading => 'Willkommen bei Bite Brigade';

  @override
  String get createAccountDescription =>
      'Trefft Essensentscheidungen gemeinsam und auf jedem Gerät.';

  @override
  String get welcomeDescription =>
      'Countdowns für wichtige Momente – auf Smartphone, Tablet und im Web.';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Alex Müller';

  @override
  String get nameRequired => 'Wie sollen wir dich nennen?';

  @override
  String get email => 'E-Mail';

  @override
  String get emailHint => 'du@example.com';

  @override
  String get emailRequired => 'Gib deine E-Mail-Adresse ein.';

  @override
  String get emailInvalid => 'Diese E-Mail-Adresse scheint ungültig zu sein.';

  @override
  String get password => 'Passwort';

  @override
  String get passwordRequired => 'Gib dein Passwort ein.';

  @override
  String get passwordTooShort => 'Verwende mindestens 6 Zeichen.';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get signInServiceUnavailable =>
      'Der Anmeldedienst ist nicht erreichbar. Überprüfe deine Verbindung.';

  @override
  String get createAccountAction => 'Konto erstellen';

  @override
  String get or => 'ODER';

  @override
  String get continueWithGoogle => 'Mit Google fortfahren';

  @override
  String get alreadyHaveAccount => 'Hast du schon ein Konto?';

  @override
  String get newHere => 'Neu hier?';

  @override
  String get createOne => 'Konto erstellen';

  @override
  String get signInTrouble => 'Probleme bei der Anmeldung? Hilfe erhalten';

  @override
  String get accountCreated => 'Konto erstellt.';

  @override
  String get welcomeBack => 'Willkommen zurück.';

  @override
  String get signedInWithGoogle => 'Mit Google angemeldet.';

  @override
  String get enterEmailForReset =>
      'Gib zuerst deine E-Mail-Adresse ein und tippe dann auf „Passwort vergessen?“. ';

  @override
  String resetLinkSent(String email) {
    return 'Link zum Zurücksetzen wurde an $email gesendet.';
  }

  @override
  String get notificationsTitle => 'Mitteilungen';

  @override
  String get markAllRead => 'Alle als gelesen markieren';

  @override
  String get moreOptions => 'Weitere Optionen';

  @override
  String get noReadMessages =>
      'Keine gelesenen Nachrichten zum Löschen vorhanden.';

  @override
  String get deleteReadMessages => 'Gelesene Nachrichten löschen';

  @override
  String get deletedReadMessages => 'Gelesene Nachrichten gelöscht.';

  @override
  String get signInFirst => 'Bitte zuerst anmelden';

  @override
  String get notificationsAccountOnly =>
      'Mitteilungen sind mit deinem Konto verknüpft.';

  @override
  String get couldNotLoad => 'Laden nicht möglich';

  @override
  String get checkConnectionRetry =>
      'Überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get nothingYet => 'Noch nichts vorhanden';

  @override
  String get notificationsEmpty =>
      'Neuigkeiten zu Essensplänen und Einladungen erscheinen hier.';

  @override
  String get liveNotificationsUnavailable =>
      'Live-Mitteilungen konnten nicht geladen werden.';

  @override
  String get inbox => 'POSTEINGANG';

  @override
  String get invitationResponses => 'ANTWORTEN AUF EINLADUNGEN';

  @override
  String get invitationResponsesUnavailable =>
      'Antworten auf Einladungen konnten nicht geladen werden.';

  @override
  String get circles => 'Kreise';

  @override
  String get editDecision => 'Entscheidung bearbeiten';

  @override
  String get setDecisionScene =>
      'Leg den Plan fest. Wir kümmern uns um die Abstimmung.';

  @override
  String get keepDecisionUpdated => 'Halte den Plan aktuell.';

  @override
  String get decisionEditorDescription =>
      'Benenne den Anlass, wähle eine Uhrzeit und füge Orte hinzu, über die alle abstimmen können.';

  @override
  String get decisionName => 'Name der Entscheidung';

  @override
  String get decisionNameHint => 'Abendessen am Freitag';

  @override
  String get decisionNameRequired => 'Gib deiner Entscheidung einen Namen.';

  @override
  String get optionalContext => 'Ein paar Details (optional)';

  @override
  String get decisionContextHint => 'Geburtstagsessen, Team-Mittagessen …';

  @override
  String get decisionTime => 'Zeitpunkt der Entscheidung';

  @override
  String get shortlist => 'Vorauswahl';

  @override
  String get addTwoPlaces => 'Füge mindestens zwei Orte hinzu.';

  @override
  String get shortlistLocked =>
      'Die Abstimmung läuft bereits, daher ist die Vorauswahl gesperrt.';

  @override
  String get addRestaurant => 'Restaurant hinzufügen';

  @override
  String get shareWithCrew => 'Mit einer Gruppe teilen';

  @override
  String get twoPersonCrewSharing => 'Zweiergruppen teilen Pläne automatisch.';

  @override
  String get crewMembersCanVote =>
      'Gruppenmitglieder können ohne weitere Einladung abstimmen.';

  @override
  String get createCrewFirst =>
      'Erstelle zuerst eine Gruppe, um gemeinsam Essen zu planen.';

  @override
  String get inviteByEmailOptional => 'Personen per E-Mail einladen (optional)';

  @override
  String get inviteEmailsHint => 'alex@example.com, sam@example.com';

  @override
  String get createDecision => 'Entscheidung erstellen';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String restaurantNumber(int number) {
    return 'Restaurant $number';
  }

  @override
  String get restaurantExample => 'z. B. Nordstadt-Nudeln';

  @override
  String get addName => 'Gib einen Namen ein.';

  @override
  String get removeRestaurant => 'Restaurant entfernen';

  @override
  String get addressOptional => 'Adresse (optional)';

  @override
  String get websiteOptional => 'Website (optional)';

  @override
  String get couldNotSaveDecision =>
      'Entscheidung konnte nicht gespeichert werden.';

  @override
  String get castYourVote => 'Stimme ab';

  @override
  String get swipeMode => 'Wischen';

  @override
  String get listMode => 'Liste';

  @override
  String get swipeRightToPick =>
      'Nach rechts wischen zum Auswählen, nach links zum Überspringen.';

  @override
  String yourCurrentPick(String title) {
    return 'Deine aktuelle Wahl: $title';
  }

  @override
  String get pass => 'Überspringen';

  @override
  String get vote => 'Abstimmen';

  @override
  String youVotedFor(String title) {
    return 'Du hast für $title gestimmt.';
  }

  @override
  String get backToDecision => 'Zurück zur Entscheidung';

  @override
  String get yesLetsGo => 'JA, LOS GEHT’S';

  @override
  String get maybeNextTime => 'VIELLEICHT EIN ANDERMAL';

  @override
  String get onTheMenu => 'AUF DER KARTE';

  @override
  String get rightToVoteLeftToPass =>
      'Rechts zum Abstimmen · links zum Überspringen';

  @override
  String get yourVote => 'Deine Stimme';

  @override
  String get decisionUnavailable =>
      'Diese Entscheidung ist nicht mehr verfügbar.';

  @override
  String get acceptInvitationBeforeVote =>
      'Nimm die Einladung an, bevor du abstimmst.';

  @override
  String get restaurantsUnavailable =>
      'Restaurants konnten nicht geladen werden.';

  @override
  String get noRestaurantsYet => 'Es gibt noch keine Restaurants zur Auswahl.';

  @override
  String get always => 'immer';

  @override
  String get couldNotLoadRoom =>
      'Diese Entscheidung konnte nicht geladen werden. Überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get voteCouldNotSave =>
      'Deine Stimme konnte nicht gespeichert werden. Überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get eventUnavailable => 'Dieser Essensplan ist nicht mehr verfügbar.';

  @override
  String get share => 'Teilen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get viewDetails => 'Details ansehen';

  @override
  String get sharedWith => 'GETEILT MIT';

  @override
  String get notes => 'NOTIZEN';

  @override
  String get notesEmpty =>
      'Noch nichts vorhanden. Hinterlasse eine Nachricht für alle, die mit dir planen.';

  @override
  String get addNote => 'Notiz hinzufügen';

  @override
  String get dayHasCome => 'DER TAG IST GEKOMMEN';

  @override
  String arrivalWithoutDescription(String title) {
    return '$title ist da – genieße jeden Moment.';
  }

  @override
  String arrivalWithDescription(String title, String description) {
    return '$title ist da – $description';
  }

  @override
  String get passed => 'Vorbei';

  @override
  String get countingDown => 'Countdown läuft';

  @override
  String get duplicateYearLater => 'Ein Jahr später duplizieren';

  @override
  String get duplicateEventSuccess =>
      'Duplikat erstellt – öffne es, um das Datum anzupassen.';

  @override
  String get deleteMealPlan => 'Essensplan löschen';

  @override
  String get deleteOwnerOnly =>
      'Nur der Besitzer kann diesen Essensplan löschen.';

  @override
  String get mealPlanDeleted => 'Essensplan gelöscht.';

  @override
  String get couldNotDelete => 'Löschen nicht möglich. Versuche es erneut.';

  @override
  String get deleteMealPlanConfirm => 'Diesen Essensplan löschen?';

  @override
  String get mealPlanCannotRecover =>
      'Dieser Essensplan kann nicht wiederhergestellt werden.';

  @override
  String get keep => 'Behalten';

  @override
  String get delete => 'Löschen';

  @override
  String get cancelDecisionConfirm => 'Diese Entscheidung absagen?';

  @override
  String get roomKeptInHistory => 'Der Raum bleibt im Verlauf erhalten.';

  @override
  String get keepIt => 'Behalten';

  @override
  String get cancelDecision => 'Entscheidung absagen';

  @override
  String get couldNotRevealWinner =>
      'Das Ergebnis konnte nicht angezeigt werden.';

  @override
  String get couldNotAddNote => 'Deine Notiz konnte nicht hinzugefügt werden.';

  @override
  String get couldNotDuplicateDecision =>
      'Diese Entscheidung konnte nicht dupliziert werden.';

  @override
  String get couldNotCancelDecision =>
      'Diese Entscheidung konnte nicht abgesagt werden.';

  @override
  String get linkCouldNotOpen => 'Dieser Link konnte nicht geöffnet werden.';

  @override
  String get mapsCouldNotOpen => 'Maps konnte nicht geöffnet werden.';

  @override
  String get decision => 'Entscheidung';

  @override
  String get duplicateForAnotherDay => 'Für einen anderen Tag duplizieren';

  @override
  String get swipeToVote => 'Zum Abstimmen wischen';

  @override
  String get noRestaurantsAdded =>
      'Es wurden noch keine Restaurants hinzugefügt.';

  @override
  String get aroundTable => 'Am Tisch';

  @override
  String get couldNotLoadGroup => 'Die Gruppe konnte nicht geladen werden.';

  @override
  String get couldNotLoadNotes => 'Notizen konnten nicht geladen werden.';

  @override
  String get theGroupDecision => 'DIE GRUPPENENTSCHEIDUNG';

  @override
  String get weAreGoingTo => 'WIR GEHEN ZU';

  @override
  String get tableStillOpen => 'Die Entscheidung ist noch offen';

  @override
  String get openInMaps => 'In Maps öffnen';

  @override
  String get addToCalendar => 'Zum Kalender hinzufügen';

  @override
  String get website => 'Website';

  @override
  String votesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Stimmen',
      one: '$count Stimme',
    );
    return '$_temp0';
  }

  @override
  String get currentVote => 'Deine aktuelle Stimme';

  @override
  String voteForOption(String title) {
    return 'Für $title abstimmen';
  }

  @override
  String get openInMapsTooltip => 'In Maps öffnen';

  @override
  String get openWebsiteTooltip => 'Website öffnen';

  @override
  String get guest => 'Gast';

  @override
  String calendarEventTitle(String roomName) {
    return 'Bite Brigade · $roomName';
  }

  @override
  String get calendarDecisionMade => 'Entscheidung mit Bite Brigade getroffen.';

  @override
  String calendarWinnerPicked(String title) {
    return 'Wir haben $title ausgewählt.';
  }

  @override
  String get back => 'Zurück';

  @override
  String get nobodyBlocked => 'Niemand ist blockiert';

  @override
  String get blockPeopleHowTo =>
      'Zum Blockieren öffne einen gemeinsamen Essensplan, tippe in der Zeile der Person auf ⋮ und wähle Blockieren.';

  @override
  String get blockedPeopleCannotInvite =>
      'Diese Personen können dich nicht einladen und ihr teilt keine Essenspläne.';

  @override
  String get notToldTheyAreBlocked =>
      'Die Personen werden nicht über die Blockierung informiert.';

  @override
  String get blockedListLoadError =>
      'Liste blockierter Personen konnte nicht geladen werden';

  @override
  String get blockedListPermissionError =>
      'Dein Konto darf diese Liste nicht lesen. Wenn das weiterhin passiert, aktualisiere die App.';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String blockUserTitle(String name) {
    return '$name blockieren?';
  }

  @override
  String get blockUserExplanation =>
      'Du siehst die Inhalte der anderen Person nicht mehr. Sie wird aus allen gemeinsamen Essensplänen entfernt, Einladungen zwischen euch werden aufgehoben und sie kann dich nicht erneut einladen. Sie wird nicht benachrichtigt.';

  @override
  String get blockUndoTip =>
      'Du kannst die Blockierung jederzeit unter Einstellungen → Blockierte Personen aufheben.';

  @override
  String get blocking => 'Wird blockiert …';

  @override
  String get block => 'Blockieren';

  @override
  String get undo => 'Rückgängig';

  @override
  String personBlocked(String name) {
    return '$name wurde blockiert.';
  }

  @override
  String get blockUndoFailed =>
      'Blockierung konnte nicht aufgehoben werden. Versuche es erneut.';

  @override
  String get blockSavePermissionError =>
      'Blockierung konnte nicht gespeichert werden. Melde dich erneut an und versuche es noch einmal.';

  @override
  String get blockSaveNetworkError =>
      'Keine Verbindung. Überprüfe dein Netzwerk und versuche es erneut.';

  @override
  String blockSaveError(String name) {
    return '$name konnte nicht blockiert werden. Versuche es erneut.';
  }

  @override
  String personUnblocked(String name) {
    return '$name wurde entblockt. Der Zugriff auf Essenspläne wurde nicht wiederhergestellt.';
  }

  @override
  String get weReadEveryMessage => 'Wir lesen jede Nachricht';

  @override
  String supportIntroduction(String responseTime) {
    return 'Bite Brigade ist eine unabhängige App. Am schnellsten erreichst du die Person, die sie entwickelt, per E-Mail – ein Supportteam gibt es nicht. Wir antworten normalerweise $responseTime.';
  }

  @override
  String get supportResponseTime => 'innerhalb von 2 Werktagen';

  @override
  String get commonQuestions => 'Häufige Fragen';

  @override
  String get faqMissingPlansQuestion =>
      'Ich bin angemeldet, aber meine Essensräume fehlen.';

  @override
  String get faqMissingPlansAnswer =>
      'Prüfe, ob du mit dem Konto angemeldet bist, das zu den Räumen eingeladen wurde. Bei einem mit einer Gruppe geteilten Raum muss dein Konto weiterhin Mitglied sein.';

  @override
  String get faqInviteeQuestion =>
      'Eine eingeladene Person kann den Raum nicht sehen.';

  @override
  String get faqInviteeAnswer =>
      'Bitte die Person, sich mit der E-Mail-Adresse anzumelden, die die Einladung erhalten hat, und diese im Einladungsbereich anzunehmen.';

  @override
  String get faqDeleteAccountQuestion =>
      'Wie lösche ich mein Konto und meine Daten?';

  @override
  String get faqDeleteAccountAnswer =>
      'Öffne Einstellungen > Konto löschen und folge den Bestätigungsschritten. Wenn du dich nicht anmelden kannst, kontaktiere den Support über die E-Mail-Adresse deines Kontos.';

  @override
  String get faqWhoSeesRoomQuestion => 'Wer kann meinen Raum sehen?';

  @override
  String get faqWhoSeesRoomAnswer =>
      'Der Ersteller und angenommene Teilnehmende sehen die Details. Mitglieder einer Gruppe sehen außerdem Räume, die mit dieser Gruppe geteilt wurden.';

  @override
  String get faqDataQuestion =>
      'Verkauft ihr meine Daten oder zeigt ihr Werbung?';

  @override
  String get faqDataAnswer =>
      'Rauminformationen werden im eingerichteten Firebase-Projekt gespeichert und mit den von dir ausgewählten Teilnehmenden oder Gruppen geteilt. Weitere Informationen findest du in der Datenschutzerklärung.';

  @override
  String get supportContactNote =>
      'Rückerstattungen, Abrechnungsfragen und Fehlermeldungen gehen an dieselbe Adresse. Wenn die App nicht richtig funktioniert, nenne dein Gerät und was du gerade getan hast – das hilft am meisten.';

  @override
  String get emailSupport => 'Support per E-Mail kontaktieren';

  @override
  String supportEmailCopied(String email) {
    return '$email kopiert';
  }

  @override
  String get openMail => 'E-Mail öffnen';

  @override
  String get linkCopiedClipboard => 'Link in die Zwischenablage kopiert.';

  @override
  String get nothingWaitingForYou => 'Keine offenen Einladungen.';

  @override
  String get invitationsEmptyDescription =>
      'Einladungen zu Essensplänen und Gruppen erscheinen hier. Für die meisten ist deine Antwort nötig; Zweiergruppen werden automatisch hinzugefügt.';

  @override
  String get waitingOnYou => 'Deine Antwort steht aus';

  @override
  String get invitationsSummary =>
      'Tritt einem Essensplan bei, um bei der Wahl des Lokals mitzuentscheiden, oder plane gemeinsam in einer Gruppe. Wenn du ablehnst, erfährt die einladende Person davon.';

  @override
  String get signInToSeeInvitations => 'Melde dich an, um Einladungen zu sehen';

  @override
  String get invitationsSignInDescription =>
      'Einladungen werden an deine E-Mail-Adresse gesendet. Melde dich mit der Adresse an, an die die Einladung ging.';

  @override
  String get dinnerDecisions => 'Essensentscheidungen';

  @override
  String get invitedToChoosePlace =>
      'Du wurdest eingeladen, gemeinsam mit der Gruppe ein Lokal auszuwählen.';

  @override
  String get joinDecision => 'Entscheidung beitreten';

  @override
  String get twoPersonBadge => 'ZU ZWEIT';

  @override
  String get joinTwoPersonCrewDescription =>
      'Tritt dieser Zweiergruppe bei, um künftige Essenspläne automatisch zu teilen.';

  @override
  String get joinCrewDescription =>
      'Tritt dieser Gruppe bei, um künftige Essenspläne zu erhalten und mitzugestalten.';

  @override
  String get joinCrew => 'Gruppe beitreten';

  @override
  String get invitationLoadError =>
      'Einladungen konnten nicht geladen werden. Überprüfe deine Verbindung und versuche es erneut.';

  @override
  String get couldNotRespondInvitation =>
      'Auf diese Einladung konnte nicht geantwortet werden. Versuche es erneut.';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleEditor => 'Bearbeiter';

  @override
  String get roleViewer => 'Betrachter';

  @override
  String get decline => 'Ablehnen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get yourCrews => 'Deine Gruppen';

  @override
  String get createCrew => 'Gruppe erstellen';

  @override
  String get couldNotLoadCrews => 'Deine Gruppen konnten nicht geladen werden.';

  @override
  String get goodThingsShared => 'Gemeinsam macht es mehr Spaß.';

  @override
  String get bringPeopleTogether =>
      'Bring Freunde, Familie oder Kollegen zusammen und plane eure nächste Mahlzeit.';

  @override
  String membersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Mitglieder',
      one: '$count Mitglied',
    );
    return '$_temp0';
  }

  @override
  String get crewNameRequired => 'Gib deiner Gruppe einen Namen.';

  @override
  String get couldNotCreateCrew =>
      'Gruppe konnte nicht erstellt werden. Versuche es erneut.';

  @override
  String get gatherYourCrew => 'Bring deine Gruppe zusammen.';

  @override
  String get inviteEveryoneOnce =>
      'Lade alle einmal ein und plant danach jederzeit gemeinsam eure Mahlzeiten.';

  @override
  String get mark => 'Kennzeichnung';

  @override
  String get crewName => 'Gruppenname';

  @override
  String get crewNameHint => 'Freitagsrunde';

  @override
  String get twoPersonCrewTitle => 'Nur wir zwei';

  @override
  String get twoPersonCrewDescription =>
      'Teilt Essenspläne automatisch miteinander.';

  @override
  String get crewCreated => 'Gruppe erstellt.';

  @override
  String get crewInvitationSent => 'Gruppeneinladung gesendet.';

  @override
  String get couldNotSendCrewInvitation =>
      'Einladung konnte nicht gesendet werden. Versuche es erneut.';

  @override
  String get couldNotRenameCrew =>
      'Gruppe konnte nicht umbenannt werden. Versuche es erneut.';

  @override
  String leaveNamedCrew(String name) {
    return '$name verlassen?';
  }

  @override
  String get leaveCrewDescription =>
      'Neue Entscheidungen, die mit dieser Gruppe geteilt werden, werden dir nicht mehr angezeigt.';

  @override
  String get stay => 'Bleiben';

  @override
  String get leaveCrew => 'Gruppe verlassen';

  @override
  String get couldNotLeaveCrew =>
      'Gruppe konnte nicht verlassen werden. Versuche es erneut.';

  @override
  String get crew => 'Gruppe';

  @override
  String get crewUnavailable => 'Diese Gruppe ist nicht mehr verfügbar.';

  @override
  String get renameCrew => 'Gruppe umbenennen';

  @override
  String get twoPersonCrew => 'Zweiergruppe';

  @override
  String get standingCrew => 'Feste Gruppe';

  @override
  String get mealPlansSharedAutomatically =>
      'Essenspläne werden automatisch miteinander geteilt.';

  @override
  String get sharePlansWithCrew =>
      'Teile Essenspläne mit dieser Gruppe, wenn ihr gemeinsam plant.';

  @override
  String get members => 'Mitglieder';

  @override
  String get invite => 'Einladen';

  @override
  String get owner => 'BESITZER';

  @override
  String get leaveThisCrew => 'Diese Gruppe verlassen';

  @override
  String get inviteToYourCrew => 'In deine Gruppe einladen';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get sendInvitation => 'Einladung senden';

  @override
  String get save => 'Speichern';

  @override
  String get couldNotLoadCrew => 'Diese Gruppe konnte nicht geladen werden.';

  @override
  String get couldNotLoadCrewMembers =>
      'Gruppenmitglieder konnten nicht geladen werden.';

  @override
  String get accept => 'Annehmen';

  @override
  String get mealPlanInvitation => 'Einladung zu einem Essensplan';

  @override
  String get unnamedMealPlan => 'Ein Essensplan';

  @override
  String mealPlanInvitationBody(String role) {
    return 'Du wurdest zu diesem Essensplan eingeladen. Nach der Annahme erscheint er mit der Rolle $role in deiner Liste.';
  }

  @override
  String get joinMealPlanQuestion => 'Diesem Essensplan beitreten?';

  @override
  String get joinMealPlanExplanation =>
      'Er erscheint in deiner Liste, damit du Datum und Details leicht findest.';

  @override
  String get join => 'Beitreten';

  @override
  String alreadyMemberOf(String name) {
    return 'Du bist bereits Mitglied von „$name“.';
  }

  @override
  String joinedNamedMealPlan(String name) {
    return 'Du bist „$name“ beigetreten.';
  }

  @override
  String get invitationDeclined => 'Einladung abgelehnt.';

  @override
  String get twoPersonGroupInvitation => 'Einladung für eine Zweiergruppe';

  @override
  String get crewInvitation => 'Gruppeneinladung';

  @override
  String addingYouToCrew(String name) {
    return 'Du wirst der Gruppe von $name hinzugefügt.';
  }

  @override
  String invitedYouToNamedCrew(String inviter, String crew) {
    return '$inviter hat dich zu „$crew“ eingeladen.';
  }

  @override
  String automaticCrewInvitationBody(String crew) {
    return 'Du wirst automatisch hinzugefügt. Künftige Essenspläne, die mit „$crew“ geteilt werden, erscheinen in deiner Liste.';
  }

  @override
  String namedCrewInvitationBody(String crew) {
    return 'Tritt „$crew“ bei, um die Essenspläne zu sehen, die diese Gruppe mit dir teilt.';
  }

  @override
  String get couldNotAddYouAutomatically =>
      'Du konntest nicht automatisch hinzugefügt werden.';

  @override
  String get retryAddingYou => 'Erneut versuchen, dich hinzuzufügen';

  @override
  String get notNow => 'Nicht jetzt';

  @override
  String alreadyMemberOfCrew(String crew) {
    return 'Du bist bereits Mitglied von „$crew“.';
  }

  @override
  String addedToNamedCrew(String crew) {
    return 'Du wurdest zu „$crew“ hinzugefügt.';
  }

  @override
  String joinedNamedCrew(String crew) {
    return 'Du bist „$crew“ beigetreten.';
  }

  @override
  String get someone => 'Jemand';

  @override
  String get you => 'Du';

  @override
  String get noCrewsYet => 'Noch keine Gruppen';

  @override
  String get remove => 'Entfernen';

  @override
  String get removeFromCrew => 'Aus der Gruppe entfernen';

  @override
  String removeCrewMemberTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get removeCrewMemberExplanation =>
      'Diese Person sieht keine Essenspläne mehr, die mit dieser Gruppe geteilt werden. Ihre erstellten Pläne bleiben erhalten.';

  @override
  String deleteNamedCrew(String name) {
    return '„$name“ löschen?';
  }

  @override
  String get deleteCrewExplanation =>
      'Die Gruppe wird entfernt. Geteilte Essenspläne bleiben erhalten und gehören weiterhin dir, werden aber nicht mehr mit diesen Personen geteilt.';

  @override
  String inviteToNamedCrew(String name) {
    return 'Zu „$name“ einladen';
  }

  @override
  String get inviteToTwoPersonCrew => 'In deine Zweiergruppe einladen';

  @override
  String get automaticCrewInviteExplanation =>
      'Wenn die Person bereits ein Konto hat, wird sie automatisch hinzugefügt. Andernfalls geschieht das nach der Anmeldung. Essenspläne, die mit dieser Gruppe geteilt werden, erscheinen automatisch.';

  @override
  String get crewInviteExplanation =>
      'Die Person erhält eine Einladung, die sie annehmen oder ablehnen kann. Nach dem Beitritt kannst du Essenspläne mit dieser Gruppe teilen.';

  @override
  String get inviteEmailHint => 'freund@example.com';

  @override
  String get recentContactsLoadError =>
      'Zuletzt verwendete Kontakte konnten nicht geladen werden. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get theyWillBeAddedAutomatically =>
      'Die Person wird automatisch hinzugefügt.';

  @override
  String invitationSentTo(String email) {
    return 'Einladung an $email gesendet.';
  }

  @override
  String leftNamedCrew(String name) {
    return 'Du hast „$name“ verlassen.';
  }

  @override
  String deletedNamedCrew(String name) {
    return '„$name“ wurde gelöscht.';
  }

  @override
  String get signInToUseCrews => 'Melde dich an, um Gruppen zu nutzen';

  @override
  String get crewsSignInDescription =>
      'Gruppen laden Personen per E-Mail ein. Dafür benötigen sie ein Konto.';

  @override
  String get editMealPlan => 'Essensplan bearbeiten';

  @override
  String get createMealPlanAction => 'Essensplan erstellen';

  @override
  String get mealPlanActions => 'Aktionen für den Essensplan';

  @override
  String get titleField => 'Titel';

  @override
  String get mealPlanTitleHint =>
      'Freitagsessen, Team-Mittagessen, Familienbrunch';

  @override
  String get descriptionField => 'Beschreibung';

  @override
  String get mealPlanDescriptionHint =>
      'Notiz zum Essen, Ort oder Plan hinzufügen';

  @override
  String get when => 'Wann';

  @override
  String get date => 'Datum';

  @override
  String get oneWeek => '+1 Woche';

  @override
  String get oneMonth => '+1 Monat';

  @override
  String get oneYear => '+1 Jahr';

  @override
  String get fiveYears => '+5 Jahre';

  @override
  String get mealPlanTitleRequired => 'Gib diesem Essensplan einen Titel.';

  @override
  String get futureMomentRequired => 'Wähle einen Zeitpunkt in der Zukunft.';

  @override
  String get signInToSaveMealPlans =>
      'Melde dich an, um Essenspläne zu speichern.';

  @override
  String get mealPlanCreated => 'Essensplan erstellt.';

  @override
  String get changesSaved => 'Änderungen gespeichert.';

  @override
  String get otherPerson => 'Die andere Person';

  @override
  String coupleNotAdded(String name) {
    return 'Essensplan erstellt, aber $name wurde nicht hinzugefügt. Lade die Person manuell aus dem Plan ein.';
  }

  @override
  String coupleAdded(String name) {
    return 'Essensplan erstellt. $name wurde hinzugefügt.';
  }

  @override
  String get nobodyAdded =>
      'Essensplan erstellt, aber niemand wurde hinzugefügt. Lade Personen manuell aus dem Plan ein.';

  @override
  String get viewOnlyMealPlan =>
      'Du kannst diesen Essensplan ansehen, aber nicht ändern.';

  @override
  String get chooseFutureMealTime =>
      'Wähle einen zukünftigen Zeitpunkt, um den Countdown zu sehen.';

  @override
  String timeUntilMeal(String duration) {
    return 'Zeit bis zum Essen: $duration';
  }

  @override
  String get collaborators => 'Mitwirkende';

  @override
  String get inviteesAccessDescription =>
      'Eingeladene Personen können diesen Essensplan auf ihren Geräten sehen.';

  @override
  String get peopleWithAccess => 'Personen mit Zugriff auf diesen Essensplan.';

  @override
  String get noCollaboratorsYet => 'Noch niemand sonst.';

  @override
  String sharedWithNamedCrew(String name) {
    return 'Mit „$name“ geteilt';
  }

  @override
  String get inviteAgain => 'Erneut einladen';

  @override
  String get moreActions => 'Weitere Aktionen';

  @override
  String get changeRole => 'Rolle ändern';

  @override
  String memberRoleUpdated(String name, String role) {
    return '$name hat jetzt die Rolle $role.';
  }

  @override
  String personRemoved(String name) {
    return '$name wurde entfernt.';
  }

  @override
  String invitationAskedAgain(String email) {
    return '$email wurde erneut eingeladen.';
  }

  @override
  String get removePersonQuestion => 'Diese Person entfernen?';

  @override
  String removePersonExplanation(String email) {
    return '$email verliert den Zugriff auf diesen Essensplan und sieht ihn nicht mehr in der Liste.';
  }

  @override
  String changeRoleFor(String name) {
    return 'Rolle für $name ändern';
  }

  @override
  String roleCurrentAccess(String role) {
    return 'Damit änderst du die Berechtigungen für diesen Essensplan. Die Person hat derzeit Zugriff als $role.';
  }

  @override
  String rolesCannotBeAssigned(String roles, String role) {
    return 'Du kannst die Rollen $roles mit deiner Rolle $role nicht vergeben.';
  }

  @override
  String get and => 'und';

  @override
  String get adminRoleDescription =>
      'Kann Personen einladen, Rollen ändern, den Essensplan bearbeiten und Mitwirkende entfernen.';

  @override
  String get editorRoleDescription =>
      'Kann Titel, Beschreibung und Datum bearbeiten. Kann keine Personen verwalten.';

  @override
  String get viewerRoleDescription => 'Kann den Essensplan nur ansehen.';

  @override
  String durationYearCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Jahre',
      one: '$count Jahr',
    );
    return '$_temp0';
  }

  @override
  String durationMonthCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Monate',
      one: '$count Monat',
    );
    return '$_temp0';
  }

  @override
  String durationDayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '$count Tag',
    );
    return '$_temp0';
  }

  @override
  String durationHourCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Stunden',
      one: '$count Stunde',
    );
    return '$_temp0';
  }

  @override
  String durationMinuteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minuten',
      one: '$count Minute',
    );
    return '$_temp0';
  }

  @override
  String durationSecondCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Sekunden',
      one: '$count Sekunde',
    );
    return '$_temp0';
  }

  @override
  String get momentHasPassed => 'Der Zeitpunkt ist vorbei.';

  @override
  String get couldNotSaveMealPlan =>
      'Essensplan konnte nicht gespeichert werden. Bitte versuche es erneut.';

  @override
  String get savePermissionError =>
      'Dein Konto kann diesen Essensplan nicht speichern. Aktualisiere die App und versuche es erneut.';

  @override
  String get saveNetworkError =>
      'Der Dienst ist nicht erreichbar. Prüfe deine Verbindung und versuche es erneut.';

  @override
  String get unblock => 'Entsperren';

  @override
  String get upcoming => 'Bevorstehend';

  @override
  String get invitationAcceptedState => 'Angenommen';

  @override
  String get invitationDeclinedState => 'Abgelehnt';

  @override
  String get invitationRemovedState => 'Entfernt';

  @override
  String get invitationReopenedState => 'Erneut geöffnet';

  @override
  String get invitationWaitingState => 'Ausstehend';

  @override
  String get sharedCrewInviteInfo =>
      'Zweiergruppen teilen Essenspläne automatisch. Bei anderen Gruppen ist eine Einladung nötig.';

  @override
  String get shareWith => 'Teilen mit';

  @override
  String get arrived => 'Der Moment ist da.';

  @override
  String countdownToGo(String duration) {
    return 'Noch $duration';
  }

  @override
  String get deleteAccount => 'Konto löschen';

  @override
  String get deleteAccountWarning =>
      'Diese Aktion ist endgültig. Alle deine Essenspläne, Gruppen und Daten werden für immer gelöscht.';

  @override
  String get deleteAccountConfirmationPrompt =>
      'Gib deine genaue Konto-E-Mail-Adresse ein, um fortzufahren.';

  @override
  String get deleteAccountConfirmationLabel => 'Konto-E-Mail-Adresse';

  @override
  String get deleteAccountProfileConsequence =>
      'Dein Profil wird dauerhaft gelöscht.';

  @override
  String get deleteAccountAccessConsequence =>
      'Du verlierst den Zugriff auf alle deine Essenspläne und Gruppen.';

  @override
  String get deleteAccountIrreversibleConsequence =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteAccountPermanentlyAction => 'Konto endgültig löschen';

  @override
  String get accountDeleted => 'Konto erfolgreich gelöscht.';

  @override
  String get serverTimedOutTryAgain =>
      'Der Server hat das Zeitlimit überschritten. Bitte versuche es später erneut.';

  @override
  String get accountDeletionFailed =>
      'Das Konto konnte nicht gelöscht werden. Bitte versuche es erneut.';

  @override
  String get accountDeletedCleanupWarning =>
      'Das Konto wurde gelöscht, aber einige lokale Einstellungen konnten nicht entfernt werden. Starte die App neu, bevor du ein anderes Konto verwendest.';
}
