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
  String get languageEnglish => 'Anglais';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageUkrainian => 'Ukrainien';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageChineseTaiwan => 'Chinois traditionnel (Taïwan)';

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

  @override
  String get homeTitle => 'Organisez un repas.';

  @override
  String get homeDescription =>
      'Choisissez où manger, invitez votre groupe et décidez ensemble.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get createMealPlan => 'Créer un plan de repas';

  @override
  String get keepMealPlansSynced => 'Gardez vos plans de repas synchronisés';

  @override
  String get syncMealPlansDescription =>
      'Connectez-vous pour synchroniser vos plans entre vos appareils et choisir où manger avec votre groupe.';

  @override
  String get couldNotLoadMealPlans =>
      'Impossible de charger vos plans de repas. Tirez vers le bas pour réessayer.';

  @override
  String get options => 'Options';

  @override
  String get open => 'Ouvrir';

  @override
  String get openMealPlan => 'Ouvrir le plan de repas';

  @override
  String get openDecision => 'Ouvrir la décision';

  @override
  String get upcomingPlans => 'REPAS À VENIR';

  @override
  String get newMealPlan => 'Nouveau plan de repas';

  @override
  String get readyToGather => 'À TABLE !';

  @override
  String get comingUp => 'À VENIR';

  @override
  String get years => 'Années';

  @override
  String get months => 'Mois';

  @override
  String get days => 'Jours';

  @override
  String get hours => 'Heures';

  @override
  String minutesRemaining(int minutes, int seconds) {
    return '$minutes min · $seconds s restantes';
  }

  @override
  String get navHome => 'Accueil';

  @override
  String get navInvitations => 'Invitations';

  @override
  String get navCrews => 'Groupes';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navSupport => 'Assistance';

  @override
  String get tableIsYours => 'À VOUS DE CHOISIR';

  @override
  String get whereAreWeGoing => 'Où allons-nous ?';

  @override
  String get groupDecisionDescription =>
      'Un bon repas commence par une décision collective.';

  @override
  String get newDecision => 'Nouvelle décision';

  @override
  String get decisionsCouldNotLoad => 'Impossible de charger vos décisions.';

  @override
  String get yourTable => 'Votre table';

  @override
  String get noDecisions => 'Aucune décision à prendre';

  @override
  String get noDecisionsDescription =>
      'Réunissez vos proches et laissez chacun choisir l’endroit.';

  @override
  String get startDecision => 'Commencer une décision';

  @override
  String get roomOpen => 'OUVERTE';

  @override
  String get roomDecided => 'CHOISIE';

  @override
  String get roomCancelled => 'ANNULÉE';

  @override
  String votesProgress(int votesCast, int participantCount) {
    return '$votesCast vote(s) sur $participantCount';
  }

  @override
  String get createAccountHeading => 'Créer votre compte';

  @override
  String get welcomeHeading => 'Bienvenue sur Bite Brigade';

  @override
  String get createAccountDescription =>
      'Décidez ensemble où dîner, sur tous vos appareils.';

  @override
  String get welcomeDescription =>
      'Compte à rebours avant les moments qui comptent, sur mobile, tablette et web.';

  @override
  String get name => 'Nom';

  @override
  String get nameHint => 'Alex Martin';

  @override
  String get nameRequired => 'Comment souhaitez-vous que l’on vous appelle ?';

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'vous@example.com';

  @override
  String get emailRequired => 'Saisissez votre adresse e-mail.';

  @override
  String get emailInvalid => 'Cette adresse e-mail ne semble pas valide.';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordRequired => 'Saisissez votre mot de passe.';

  @override
  String get passwordTooShort => 'Utilisez au moins 6 caractères.';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get signInServiceUnavailable =>
      'Impossible de joindre le service de connexion. Vérifiez votre connexion Internet.';

  @override
  String get createAccountAction => 'Créer un compte';

  @override
  String get or => 'OU';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get newHere => 'Nouveau ici ?';

  @override
  String get createOne => 'En créer un';

  @override
  String get signInTrouble => 'Un problème de connexion ? Obtenir de l’aide';

  @override
  String get accountCreated => 'Compte créé.';

  @override
  String get welcomeBack => 'Ravi de vous revoir.';

  @override
  String get signedInWithGoogle => 'Connexion avec Google réussie.';

  @override
  String get enterEmailForReset =>
      'Saisissez d’abord votre e-mail, puis touchez « Mot de passe oublié ».';

  @override
  String resetLinkSent(String email) {
    return 'Lien de réinitialisation envoyé à $email.';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get markAllRead => 'Tout marquer comme lu';

  @override
  String get moreOptions => 'Plus d’options';

  @override
  String get noReadMessages => 'Aucun message lu à supprimer.';

  @override
  String get deleteReadMessages => 'Supprimer les messages lus';

  @override
  String get deletedReadMessages => 'Messages lus supprimés.';

  @override
  String get signInFirst => 'Connectez-vous d’abord';

  @override
  String get notificationsAccountOnly =>
      'Les notifications sont associées à votre compte.';

  @override
  String get couldNotLoad => 'Chargement impossible';

  @override
  String get checkConnectionRetry => 'Vérifiez votre connexion et réessayez.';

  @override
  String get nothingYet => 'Rien pour le moment';

  @override
  String get notificationsEmpty =>
      'Les nouveautés concernant vos repas ou vos invitations apparaîtront ici.';

  @override
  String get liveNotificationsUnavailable =>
      'Impossible de charger les notifications en direct.';

  @override
  String get inbox => 'BOÎTE DE RÉCEPTION';

  @override
  String get invitationResponses => 'RÉPONSES AUX INVITATIONS';

  @override
  String get invitationResponsesUnavailable =>
      'Impossible de charger les réponses aux invitations.';

  @override
  String get circles => 'Cercles';

  @override
  String get editDecision => 'Modifier la décision';

  @override
  String get setDecisionScene =>
      'Présentez le projet, nous nous occupons des votes.';

  @override
  String get keepDecisionUpdated => 'Gardez le plan à jour.';

  @override
  String get decisionEditorDescription =>
      'Nommez l’occasion, choisissez une heure et ajoutez des lieux que chacun pourra choisir.';

  @override
  String get decisionName => 'Nom de la décision';

  @override
  String get decisionNameHint => 'Dîner vendredi';

  @override
  String get decisionNameRequired => 'Donnez un nom à votre décision.';

  @override
  String get optionalContext => 'Quelques précisions (facultatif)';

  @override
  String get decisionContextHint => 'Dîner d’anniversaire, déjeuner d’équipe…';

  @override
  String get decisionTime => 'Heure de la décision';

  @override
  String get shortlist => 'Sélection';

  @override
  String get addTwoPlaces => 'Ajoutez au moins deux lieux.';

  @override
  String get shortlistLocked =>
      'Le vote a commencé : la sélection est verrouillée.';

  @override
  String get addRestaurant => 'Ajouter un restaurant';

  @override
  String get shareWithCrew => 'Partager avec un groupe';

  @override
  String get twoPersonCrewSharing =>
      'Les groupes de deux partagent automatiquement leurs plans.';

  @override
  String get crewMembersCanVote =>
      'Les membres du groupe peuvent voter sans autre invitation.';

  @override
  String get createCrewFirst =>
      'Créez d’abord un groupe pour planifier des repas ensemble.';

  @override
  String get inviteByEmailOptional =>
      'Inviter des personnes par e-mail (facultatif)';

  @override
  String get inviteEmailsHint => 'alex@example.com, sam@example.com';

  @override
  String get createDecision => 'Créer la décision';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String restaurantNumber(int number) {
    return 'Restaurant $number';
  }

  @override
  String get restaurantExample => 'p. ex. Les Nouilles du Nord';

  @override
  String get addName => 'Ajoutez un nom.';

  @override
  String get removeRestaurant => 'Supprimer le restaurant';

  @override
  String get addressOptional => 'Adresse (facultatif)';

  @override
  String get websiteOptional => 'Site web (facultatif)';

  @override
  String get couldNotSaveDecision => 'Impossible d’enregistrer cette décision.';

  @override
  String get castYourVote => 'Votez';

  @override
  String get swipeMode => 'Balayer';

  @override
  String get listMode => 'Liste';

  @override
  String get swipeRightToPick =>
      'Balayez à droite pour choisir, à gauche pour passer.';

  @override
  String yourCurrentPick(String title) {
    return 'Votre choix actuel : $title';
  }

  @override
  String get pass => 'Passer';

  @override
  String get vote => 'Voter';

  @override
  String youVotedFor(String title) {
    return 'Vous avez voté pour $title.';
  }

  @override
  String get backToDecision => 'Retour à la décision';

  @override
  String get yesLetsGo => 'OUI, ON Y VA';

  @override
  String get maybeNextTime => 'UNE AUTRE FOIS';

  @override
  String get onTheMenu => 'AU MENU';

  @override
  String get rightToVoteLeftToPass =>
      'À droite pour voter · à gauche pour passer';

  @override
  String get yourVote => 'Votre vote';

  @override
  String get decisionUnavailable => 'Cette décision n’est plus disponible.';

  @override
  String get acceptInvitationBeforeVote =>
      'Acceptez l’invitation avant de voter.';

  @override
  String get restaurantsUnavailable => 'Impossible de charger les restaurants.';

  @override
  String get noRestaurantsYet =>
      'Il n’y a pas encore de restaurants à choisir.';

  @override
  String get always => 'toujours';

  @override
  String get couldNotLoadRoom =>
      'Impossible de charger cette décision. Vérifiez votre connexion et réessayez.';

  @override
  String get voteCouldNotSave =>
      'Impossible d’enregistrer votre vote. Vérifiez votre connexion et réessayez.';

  @override
  String get eventUnavailable => 'Ce plan de repas n’est plus disponible.';

  @override
  String get share => 'Partager';

  @override
  String get edit => 'Modifier';

  @override
  String get viewDetails => 'Voir les détails';

  @override
  String get sharedWith => 'PARTAGÉ AVEC';

  @override
  String get notes => 'NOTES';

  @override
  String get notesEmpty =>
      'Rien pour le moment. Laissez un mot aux personnes qui préparent ce repas avec vous.';

  @override
  String get addNote => 'Ajouter une note';

  @override
  String get dayHasCome => 'LE GRAND JOUR EST ARRIVÉ';

  @override
  String arrivalWithoutDescription(String title) {
    return '$title est arrivé — profitez de chaque instant.';
  }

  @override
  String arrivalWithDescription(String title, String description) {
    return '$title est arrivé — $description';
  }

  @override
  String get passed => 'Terminé';

  @override
  String get countingDown => 'Compte à rebours';

  @override
  String get duplicateYearLater => 'Dupliquer un an plus tard';

  @override
  String get duplicateEventSuccess =>
      'Copie créée — ouvrez-la pour modifier la date.';

  @override
  String get deleteMealPlan => 'Supprimer le plan de repas';

  @override
  String get deleteOwnerOnly =>
      'Seul le propriétaire peut supprimer ce plan de repas.';

  @override
  String get mealPlanDeleted => 'Plan de repas supprimé.';

  @override
  String get couldNotDelete => 'Suppression impossible. Réessayez.';

  @override
  String get deleteMealPlanConfirm => 'Supprimer ce plan de repas ?';

  @override
  String get mealPlanCannotRecover =>
      'Ce plan de repas ne pourra pas être récupéré.';

  @override
  String get keep => 'Conserver';

  @override
  String get delete => 'Supprimer';

  @override
  String get cancelDecisionConfirm => 'Annuler cette décision ?';

  @override
  String get roomKeptInHistory => 'La salle restera dans l’historique.';

  @override
  String get keepIt => 'Conserver';

  @override
  String get cancelDecision => 'Annuler la décision';

  @override
  String get couldNotRevealWinner => 'Impossible de révéler le résultat.';

  @override
  String get couldNotAddNote => 'Impossible d’ajouter votre note.';

  @override
  String get couldNotDuplicateDecision =>
      'Impossible de dupliquer cette décision.';

  @override
  String get couldNotCancelDecision => 'Impossible d’annuler cette décision.';

  @override
  String get linkCouldNotOpen => 'Impossible d’ouvrir ce lien.';

  @override
  String get mapsCouldNotOpen => 'Impossible d’ouvrir Maps.';

  @override
  String get decision => 'Décision';

  @override
  String get duplicateForAnotherDay => 'Dupliquer pour un autre jour';

  @override
  String get swipeToVote => 'Balayez pour voter';

  @override
  String get noRestaurantsAdded => 'Aucun restaurant n’a encore été ajouté.';

  @override
  String get aroundTable => 'Autour de la table';

  @override
  String get couldNotLoadGroup => 'Impossible de charger le groupe.';

  @override
  String get couldNotLoadNotes => 'Impossible de charger les notes.';

  @override
  String get theGroupDecision => 'LA DÉCISION DU GROUPE';

  @override
  String get weAreGoingTo => 'NOUS IRONS CHEZ';

  @override
  String get tableStillOpen => 'Le choix est encore ouvert';

  @override
  String get openInMaps => 'Ouvrir dans Maps';

  @override
  String get addToCalendar => 'Ajouter au calendrier';

  @override
  String get website => 'Site web';

  @override
  String votesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count votes',
      one: '$count vote',
    );
    return '$_temp0';
  }

  @override
  String get currentVote => 'Votre vote actuel';

  @override
  String voteForOption(String title) {
    return 'Voter pour $title';
  }

  @override
  String get openInMapsTooltip => 'Ouvrir dans Maps';

  @override
  String get openWebsiteTooltip => 'Ouvrir le site web';

  @override
  String get guest => 'Invité';

  @override
  String calendarEventTitle(String roomName) {
    return 'Bite Brigade · $roomName';
  }

  @override
  String get calendarDecisionMade => 'Décision prise avec Bite Brigade.';

  @override
  String calendarWinnerPicked(String title) {
    return 'Nous avons choisi $title.';
  }

  @override
  String get back => 'Retour';

  @override
  String get nobodyBlocked => 'Personne n’est bloqué';

  @override
  String get blockPeopleHowTo =>
      'Pour bloquer quelqu’un, ouvrez un plan de repas partagé avec cette personne, touchez le menu ⋮ sur sa ligne, puis Bloquer.';

  @override
  String get blockedPeopleCannotInvite =>
      'Ces personnes ne peuvent pas vous inviter et vous ne partagez aucun plan de repas avec elles.';

  @override
  String get notToldTheyAreBlocked => 'Elles ne sont pas informées du blocage.';

  @override
  String get blockedListLoadError =>
      'Impossible de charger votre liste de personnes bloquées';

  @override
  String get blockedListPermissionError =>
      'Votre compte ne peut pas consulter cette liste. Si le problème persiste, mettez l’application à jour.';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String blockUserTitle(String name) {
    return 'Bloquer $name ?';
  }

  @override
  String get blockUserExplanation =>
      'Vous ne verrez plus le contenu de l’autre personne. Elle sera retirée de vos plans de repas partagés, vos invitations seront annulées et elle ne pourra plus vous inviter. Elle ne sera pas informée.';

  @override
  String get blockUndoTip =>
      'Vous pouvez annuler ce blocage à tout moment dans Réglages → Personnes bloquées.';

  @override
  String get blocking => 'Blocage…';

  @override
  String get block => 'Bloquer';

  @override
  String get undo => 'Annuler';

  @override
  String personBlocked(String name) {
    return '$name est bloqué.';
  }

  @override
  String get blockUndoFailed => 'Impossible d’annuler le blocage. Réessayez.';

  @override
  String get blockSavePermissionError =>
      'Impossible d’enregistrer le blocage. Reconnectez-vous et réessayez.';

  @override
  String get blockSaveNetworkError =>
      'Aucune connexion. Vérifiez votre réseau et réessayez.';

  @override
  String blockSaveError(String name) {
    return 'Impossible de bloquer $name. Réessayez.';
  }

  @override
  String personUnblocked(String name) {
    return '$name n’est plus bloqué. L’accès aux plans de repas n’a pas été rétabli.';
  }

  @override
  String get weReadEveryMessage => 'Nous lisons chaque message';

  @override
  String supportIntroduction(String responseTime) {
    return 'Bite Brigade est une application indépendante. Le moyen le plus rapide de joindre son développeur est par e-mail ; il n’y a pas d’équipe d’assistance intermédiaire. Nous répondons généralement $responseTime.';
  }

  @override
  String get supportResponseTime => 'sous 2 jours ouvrés';

  @override
  String get commonQuestions => 'Questions fréquentes';

  @override
  String get faqMissingPlansQuestion =>
      'Je me suis connecté, mais mes salles de repas ont disparu.';

  @override
  String get faqMissingPlansAnswer =>
      'Vérifiez que vous êtes connecté au compte invité dans ces salles. Pour une salle partagée avec un groupe, vérifiez que vous en êtes toujours membre.';

  @override
  String get faqInviteeQuestion => 'Une personne invitée ne voit pas la salle.';

  @override
  String get faqInviteeAnswer =>
      'Demandez-lui de se connecter avec l’adresse e-mail qui a reçu l’invitation, puis de l’accepter dans l’écran Invitations.';

  @override
  String get faqDeleteAccountQuestion =>
      'Comment supprimer mon compte et mes données ?';

  @override
  String get faqDeleteAccountAnswer =>
      'Ouvrez Réglages > Supprimer le compte et suivez les étapes de confirmation. Si vous ne pouvez pas vous connecter, contactez l’assistance depuis l’adresse e-mail de votre compte.';

  @override
  String get faqWhoSeesRoomQuestion => 'Qui peut voir ma salle ?';

  @override
  String get faqWhoSeesRoomAnswer =>
      'Le créateur de la salle et les personnes ayant accepté l’invitation peuvent en voir les détails. Les membres d’un groupe voient aussi les salles partagées avec celui-ci.';

  @override
  String get faqDataQuestion =>
      'Vendez-vous mes données ou affichez-vous des publicités ?';

  @override
  String get faqDataAnswer =>
      'Les informations des salles sont conservées dans le projet Firebase configuré et partagées avec les participants ou le groupe que vous choisissez. Consultez la politique de confidentialité pour en savoir plus.';

  @override
  String get supportContactNote =>
      'Les remboursements, questions de facturation et rapports de plantage sont traités à la même adresse. En cas de problème, indiquez-nous votre appareil et ce que vous faisiez : c’est l’information la plus utile.';

  @override
  String get emailSupport => 'Contacter l’assistance par e-mail';

  @override
  String supportEmailCopied(String email) {
    return '$email copié';
  }

  @override
  String get openMail => 'Ouvrir la messagerie';

  @override
  String get linkCopiedClipboard => 'Lien copié dans le presse-papiers.';

  @override
  String get nothingWaitingForYou => 'Aucune invitation pour le moment.';

  @override
  String get invitationsEmptyDescription =>
      'Les invitations aux plans de repas et aux groupes apparaîtront ici. La plupart attendent votre réponse ; les groupes de deux sont ajoutés automatiquement.';

  @override
  String get waitingOnYou => 'En attente de votre réponse';

  @override
  String get invitationsSummary =>
      'Rejoignez un plan de repas pour aider à choisir où manger, ou un groupe pour planifier ensemble. Si vous refusez, la personne qui vous a invité le saura.';

  @override
  String get signInToSeeInvitations =>
      'Connectez-vous pour voir les invitations';

  @override
  String get invitationsSignInDescription =>
      'Les invitations sont envoyées à votre adresse e-mail. Connectez-vous avec l’adresse à laquelle vous avez été invité.';

  @override
  String get dinnerDecisions => 'Décisions de repas';

  @override
  String get invitedToChoosePlace =>
      'Vous êtes invité à choisir où le groupe ira manger.';

  @override
  String get joinDecision => 'Rejoindre la décision';

  @override
  String get twoPersonBadge => 'À DEUX';

  @override
  String get joinTwoPersonCrewDescription =>
      'Rejoignez ce groupe de deux pour partager automatiquement vos prochains plans de repas.';

  @override
  String get joinCrewDescription =>
      'Rejoignez ce groupe pour recevoir et préparer de futurs plans de repas.';

  @override
  String get joinCrew => 'Rejoindre le groupe';

  @override
  String get invitationLoadError =>
      'Impossible de charger les invitations. Vérifiez votre connexion et réessayez.';

  @override
  String get couldNotRespondInvitation =>
      'Impossible de répondre à cette invitation. Réessayez.';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleEditor => 'Éditeur';

  @override
  String get roleViewer => 'Lecteur';

  @override
  String get decline => 'Refuser';

  @override
  String get cancel => 'Annuler';

  @override
  String get yourCrews => 'Vos groupes';

  @override
  String get createCrew => 'Créer un groupe';

  @override
  String get couldNotLoadCrews => 'Impossible de charger vos groupes.';

  @override
  String get goodThingsShared => 'Les bons moments se partagent.';

  @override
  String get bringPeopleTogether =>
      'Réunissez vos amis, votre famille ou vos collègues pour prévoir votre prochain repas.';

  @override
  String membersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count membres',
      one: '$count membre',
    );
    return '$_temp0';
  }

  @override
  String get crewNameRequired => 'Donnez un nom à votre groupe.';

  @override
  String get couldNotCreateCrew => 'Impossible de créer ce groupe. Réessayez.';

  @override
  String get gatherYourCrew => 'Réunissez votre groupe.';

  @override
  String get inviteEveryoneOnce =>
      'Invitez tout le monde une fois, puis organisez vos repas ensemble quand vous le souhaitez.';

  @override
  String get mark => 'Marque';

  @override
  String get crewName => 'Nom du groupe';

  @override
  String get crewNameHint => 'Les habitués du vendredi';

  @override
  String get twoPersonCrewTitle => 'Juste nous deux';

  @override
  String get twoPersonCrewDescription =>
      'Partagez automatiquement vos plans de repas.';

  @override
  String get crewCreated => 'Groupe créé.';

  @override
  String get crewInvitationSent => 'Invitation au groupe envoyée.';

  @override
  String get couldNotSendCrewInvitation =>
      'Impossible d’envoyer cette invitation. Réessayez.';

  @override
  String get couldNotRenameCrew =>
      'Impossible de renommer ce groupe. Réessayez.';

  @override
  String leaveNamedCrew(String name) {
    return 'Quitter $name ?';
  }

  @override
  String get leaveCrewDescription =>
      'Vous ne verrez plus les nouvelles décisions partagées avec ce groupe.';

  @override
  String get stay => 'Rester';

  @override
  String get leaveCrew => 'Quitter le groupe';

  @override
  String get couldNotLeaveCrew => 'Impossible de quitter ce groupe. Réessayez.';

  @override
  String get crew => 'Groupe';

  @override
  String get crewUnavailable => 'Ce groupe n’est plus disponible.';

  @override
  String get renameCrew => 'Renommer le groupe';

  @override
  String get twoPersonCrew => 'Groupe de deux';

  @override
  String get standingCrew => 'Groupe régulier';

  @override
  String get mealPlansSharedAutomatically =>
      'Les plans de repas sont automatiquement partagés entre vous.';

  @override
  String get sharePlansWithCrew =>
      'Partagez vos plans de repas avec ce groupe quand vous prévoyez un repas.';

  @override
  String get members => 'Membres';

  @override
  String get invite => 'Inviter';

  @override
  String get owner => 'PROPRIÉTAIRE';

  @override
  String get leaveThisCrew => 'Quitter ce groupe';

  @override
  String get inviteToYourCrew => 'Inviter dans votre groupe';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get sendInvitation => 'Envoyer l’invitation';

  @override
  String get save => 'Enregistrer';

  @override
  String get couldNotLoadCrew => 'Impossible de charger ce groupe.';

  @override
  String get couldNotLoadCrewMembers =>
      'Impossible de charger les membres du groupe.';

  @override
  String get accept => 'Accepter';

  @override
  String get mealPlanInvitation => 'Invitation à un plan de repas';

  @override
  String get unnamedMealPlan => 'Un plan de repas';

  @override
  String mealPlanInvitationBody(String role) {
    return 'Vous êtes invité à rejoindre ce plan de repas. En l’acceptant, il sera ajouté à votre liste avec le rôle $role.';
  }

  @override
  String get joinMealPlanQuestion => 'Rejoindre ce plan de repas ?';

  @override
  String get joinMealPlanExplanation =>
      'Il apparaîtra dans votre liste pour retrouver facilement la date et les détails.';

  @override
  String get join => 'Rejoindre';

  @override
  String alreadyMemberOf(String name) {
    return 'Vous êtes déjà membre de « $name ».';
  }

  @override
  String joinedNamedMealPlan(String name) {
    return 'Vous avez rejoint « $name ».';
  }

  @override
  String get invitationDeclined => 'Invitation refusée.';

  @override
  String get twoPersonGroupInvitation => 'Invitation à un groupe de deux';

  @override
  String get crewInvitation => 'Invitation au groupe';

  @override
  String addingYouToCrew(String name) {
    return 'Vous allez rejoindre le groupe de $name.';
  }

  @override
  String invitedYouToNamedCrew(String inviter, String crew) {
    return '$inviter vous invite dans « $crew ».';
  }

  @override
  String automaticCrewInvitationBody(String crew) {
    return 'Vous serez ajouté automatiquement. Les futurs plans de repas partagés avec « $crew » apparaîtront dans votre liste.';
  }

  @override
  String namedCrewInvitationBody(String crew) {
    return 'Rejoignez « $crew » pour voir les plans de repas partagés par ce groupe.';
  }

  @override
  String get couldNotAddYouAutomatically =>
      'Impossible de vous ajouter automatiquement.';

  @override
  String get retryAddingYou => 'Réessayer de vous ajouter';

  @override
  String get notNow => 'Pas maintenant';

  @override
  String alreadyMemberOfCrew(String crew) {
    return 'Vous êtes déjà membre de « $crew ».';
  }

  @override
  String addedToNamedCrew(String crew) {
    return 'Vous avez été ajouté à « $crew ».';
  }

  @override
  String joinedNamedCrew(String crew) {
    return 'Vous avez rejoint « $crew ».';
  }

  @override
  String get someone => 'Quelqu’un';

  @override
  String get you => 'Vous';

  @override
  String get noCrewsYet => 'Aucun groupe pour le moment';

  @override
  String get remove => 'Retirer';

  @override
  String get removeFromCrew => 'Retirer du groupe';

  @override
  String removeCrewMemberTitle(String name) {
    return 'Retirer $name ?';
  }

  @override
  String get removeCrewMemberExplanation =>
      'Cette personne ne verra plus les plans de repas partagés avec ce groupe. Rien de ce qu’elle a créé ne sera supprimé.';

  @override
  String deleteNamedCrew(String name) {
    return 'Supprimer « $name » ?';
  }

  @override
  String get deleteCrewExplanation =>
      'Le groupe sera supprimé. Les plans de repas partagés restent les vôtres, mais ne seront plus partagés avec ces personnes.';

  @override
  String inviteToNamedCrew(String name) {
    return 'Inviter dans « $name »';
  }

  @override
  String get inviteToTwoPersonCrew => 'Inviter dans votre groupe de deux';

  @override
  String get automaticCrewInviteExplanation =>
      'Si cette personne a déjà un compte, elle sera ajoutée automatiquement. Sinon, elle le sera après sa connexion. Les plans partagés avec ce groupe apparaîtront automatiquement.';

  @override
  String get crewInviteExplanation =>
      'Cette personne recevra une invitation à accepter ou refuser. Après son arrivée, vous pourrez partager vos plans avec ce groupe en un geste.';

  @override
  String get inviteEmailHint => 'ami@example.com';

  @override
  String get recentContactsLoadError =>
      'Impossible de charger les contacts récents. Vérifiez votre connexion et réessayez.';

  @override
  String get theyWillBeAddedAutomatically =>
      'Cette personne sera ajoutée automatiquement.';

  @override
  String invitationSentTo(String email) {
    return 'Invitation envoyée à $email.';
  }

  @override
  String leftNamedCrew(String name) {
    return 'Vous avez quitté « $name ».';
  }

  @override
  String deletedNamedCrew(String name) {
    return '« $name » a été supprimé.';
  }

  @override
  String get signInToUseCrews => 'Connectez-vous pour utiliser les groupes';

  @override
  String get crewsSignInDescription =>
      'Les groupes invitent des personnes par e-mail ; elles doivent donc avoir un compte pour être invitées.';

  @override
  String get editMealPlan => 'Modifier le plan de repas';

  @override
  String get createMealPlanAction => 'Créer un plan de repas';

  @override
  String get mealPlanActions => 'Actions du plan de repas';

  @override
  String get titleField => 'Titre';

  @override
  String get mealPlanTitleHint =>
      'Dîner vendredi, déjeuner d’équipe, brunch en famille';

  @override
  String get descriptionField => 'Description';

  @override
  String get mealPlanDescriptionHint =>
      'Ajoutez une note sur le repas, le lieu ou le plan';

  @override
  String get when => 'Quand';

  @override
  String get date => 'Date';

  @override
  String get oneWeek => '+1 semaine';

  @override
  String get oneMonth => '+1 mois';

  @override
  String get oneYear => '+1 an';

  @override
  String get fiveYears => '+5 ans';

  @override
  String get mealPlanTitleRequired => 'Donnez un titre à ce plan de repas.';

  @override
  String get futureMomentRequired => 'Choisissez une date ultérieure.';

  @override
  String get signInToSaveMealPlans =>
      'Connectez-vous pour enregistrer vos plans de repas.';

  @override
  String get mealPlanCreated => 'Plan de repas créé.';

  @override
  String get changesSaved => 'Modifications enregistrées.';

  @override
  String get otherPerson => 'L’autre personne';

  @override
  String coupleNotAdded(String name) {
    return 'Plan créé, mais $name n’a pas été ajouté. Invitez cette personne depuis le plan.';
  }

  @override
  String coupleAdded(String name) {
    return 'Plan de repas créé. $name a été ajouté.';
  }

  @override
  String get nobodyAdded =>
      'Plan créé, mais personne n’a été ajouté. Envoyez une invitation depuis le plan.';

  @override
  String get viewOnlyMealPlan =>
      'Vous pouvez consulter ce plan de repas, mais pas le modifier.';

  @override
  String get chooseFutureMealTime =>
      'Choisissez une date future pour voir le compte à rebours.';

  @override
  String timeUntilMeal(String duration) {
    return 'Temps restant avant le repas : $duration';
  }

  @override
  String get collaborators => 'Participants';

  @override
  String get inviteesAccessDescription =>
      'Les personnes invitées peuvent consulter ce plan sur leurs appareils.';

  @override
  String get peopleWithAccess => 'Personnes ayant accès à ce plan de repas.';

  @override
  String get noCollaboratorsYet => 'Personne d’autre pour le moment.';

  @override
  String sharedWithNamedCrew(String name) {
    return 'Partagé avec $name';
  }

  @override
  String get inviteAgain => 'Renvoyer l’invitation';

  @override
  String get moreActions => 'Plus d’actions';

  @override
  String get changeRole => 'Modifier le rôle';

  @override
  String memberRoleUpdated(String name, String role) {
    return '$name a maintenant le rôle $role.';
  }

  @override
  String personRemoved(String name) {
    return '$name a été retiré.';
  }

  @override
  String invitationAskedAgain(String email) {
    return 'Invitation renvoyée à $email.';
  }

  @override
  String get removePersonQuestion => 'Retirer cette personne ?';

  @override
  String removePersonExplanation(String email) {
    return '$email perdra l’accès à ce plan et ne le verra plus dans sa liste.';
  }

  @override
  String changeRoleFor(String name) {
    return 'Modifier le rôle de $name';
  }

  @override
  String roleCurrentAccess(String role) {
    return 'Cela modifie les actions autorisées sur ce plan. Cette personne a actuellement le rôle $role.';
  }

  @override
  String rolesCannotBeAssigned(String roles, String role) {
    return 'Vous ne pouvez pas attribuer les rôles $roles avec votre rôle $role.';
  }

  @override
  String get and => 'et';

  @override
  String get adminRoleDescription =>
      'Peut inviter des personnes, modifier les rôles et le plan, et retirer des participants.';

  @override
  String get editorRoleDescription =>
      'Peut modifier le titre, la description et la date. Ne peut pas gérer les participants.';

  @override
  String get viewerRoleDescription =>
      'Peut uniquement consulter le plan de repas.';

  @override
  String durationYearCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ans',
      one: '$count an',
    );
    return '$_temp0';
  }

  @override
  String durationMonthCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mois',
      one: '$count mois',
    );
    return '$_temp0';
  }

  @override
  String durationDayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String durationHourCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures',
      one: '$count heure',
    );
    return '$_temp0';
  }

  @override
  String durationMinuteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '$count minute',
    );
    return '$_temp0';
  }

  @override
  String durationSecondCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count secondes',
      one: '$count seconde',
    );
    return '$_temp0';
  }

  @override
  String get momentHasPassed => 'Le moment est passé.';

  @override
  String get couldNotSaveMealPlan =>
      'Impossible d’enregistrer ce plan de repas. Réessayez.';

  @override
  String get savePermissionError =>
      'Votre compte ne peut pas enregistrer ce plan. Mettez l’application à jour et réessayez.';

  @override
  String get saveNetworkError =>
      'Impossible de joindre le service. Vérifiez votre connexion et réessayez.';

  @override
  String get unblock => 'Débloquer';

  @override
  String get upcoming => 'À venir';

  @override
  String get invitationAcceptedState => 'Acceptée';

  @override
  String get invitationDeclinedState => 'Refusée';

  @override
  String get invitationRemovedState => 'Retirée';

  @override
  String get invitationReopenedState => 'Rouverte';

  @override
  String get invitationWaitingState => 'En attente';

  @override
  String get sharedCrewInviteInfo =>
      'Les groupes de deux partagent automatiquement les plans de repas. Les autres groupes envoient une invitation.';

  @override
  String get shareWith => 'Partager avec';

  @override
  String get arrived => 'Le moment est arrivé.';

  @override
  String countdownToGo(String duration) {
    return 'Encore $duration';
  }

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get deleteAccountWarning =>
      'Cette action est irréversible. Tous vos plans de repas, groupes et données seront supprimés définitivement.';

  @override
  String get deleteAccountConfirmationPrompt =>
      'Saisissez exactement l’adresse e-mail de votre compte pour continuer.';

  @override
  String get deleteAccountConfirmationLabel => 'E-mail du compte';

  @override
  String get deleteAccountProfileConsequence =>
      'Votre profil sera supprimé définitivement.';

  @override
  String get deleteAccountAccessConsequence =>
      'Vous perdrez l’accès à tous vos plans de repas et groupes.';

  @override
  String get deleteAccountIrreversibleConsequence =>
      'Cette action est irréversible.';

  @override
  String get deleteAccountPermanentlyAction =>
      'Supprimer définitivement le compte';

  @override
  String get accountDeleted => 'Compte supprimé avec succès.';

  @override
  String get serverTimedOutTryAgain =>
      'Le délai d’attente du serveur a expiré. Veuillez réessayer plus tard.';

  @override
  String get accountDeletionFailed =>
      'La suppression du compte n’a pas abouti. Veuillez réessayer.';

  @override
  String get accountDeletedCleanupWarning =>
      'Le compte a été supprimé, mais certains réglages locaux n’ont pas pu être effacés. Redémarrez l’application avant d’utiliser un autre compte.';
}
