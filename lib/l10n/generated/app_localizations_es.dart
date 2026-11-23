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
  String get languageEnglish => 'Inglés';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageUkrainian => 'Ucraniano';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languageChineseTaiwan => 'Chino tradicional (Taiwán)';

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

  @override
  String get homeTitle => 'Planea una comida.';

  @override
  String get homeDescription =>
      'Elige dónde comer, invita a tu grupo y decidid juntos.';

  @override
  String get getStarted => 'Empezar';

  @override
  String get createMealPlan => 'Crear un plan de comida';

  @override
  String get keepMealPlansSynced => 'Mantén tus planes de comida sincronizados';

  @override
  String get syncMealPlansDescription =>
      'Inicia sesión para sincronizar tus planes entre dispositivos y decidir dónde comer con tu grupo.';

  @override
  String get couldNotLoadMealPlans =>
      'No se pudieron cargar tus planes de comida. Desliza hacia abajo para volver a intentarlo.';

  @override
  String get options => 'Opciones';

  @override
  String get open => 'Abrir';

  @override
  String get openMealPlan => 'Abrir plan de comida';

  @override
  String get openDecision => 'Abrir decisión';

  @override
  String get upcomingPlans => 'PRÓXIMAS COMIDAS';

  @override
  String get newMealPlan => 'Nuevo plan de comida';

  @override
  String get readyToGather => '¡A LA MESA!';

  @override
  String get comingUp => 'PRÓXIMAMENTE';

  @override
  String get years => 'Años';

  @override
  String get months => 'Meses';

  @override
  String get days => 'Días';

  @override
  String get hours => 'Horas';

  @override
  String minutesRemaining(int minutes, int seconds) {
    return '$minutes min · $seconds s restantes';
  }

  @override
  String get navHome => 'Inicio';

  @override
  String get navInvitations => 'Invitaciones';

  @override
  String get navCrews => 'Grupos';

  @override
  String get navNotifications => 'Notificaciones';

  @override
  String get navSupport => 'Ayuda';

  @override
  String get tableIsYours => 'LA MESA ES TUYA';

  @override
  String get whereAreWeGoing => '¿Adónde vamos?';

  @override
  String get groupDecisionDescription =>
      'Una buena comida empieza con una decisión en grupo.';

  @override
  String get newDecision => 'Nueva decisión';

  @override
  String get decisionsCouldNotLoad => 'No se pudieron cargar tus decisiones.';

  @override
  String get yourTable => 'Tu mesa';

  @override
  String get noDecisions => 'No hay decisiones pendientes';

  @override
  String get noDecisionsDescription =>
      'Reúne a tu gente y deja que todos elijan el lugar.';

  @override
  String get startDecision => 'Empezar una decisión';

  @override
  String get roomOpen => 'ABIERTA';

  @override
  String get roomDecided => 'DECIDIDA';

  @override
  String get roomCancelled => 'CANCELADA';

  @override
  String votesProgress(int votesCast, int participantCount) {
    return '$votesCast de $participantCount han votado';
  }

  @override
  String get createAccountHeading => 'Crea tu cuenta';

  @override
  String get welcomeHeading => 'Te damos la bienvenida a Bite Brigade';

  @override
  String get createAccountDescription =>
      'Decidid juntos dónde cenar, en cualquier dispositivo.';

  @override
  String get welcomeDescription =>
      'Cuenta atrás para los momentos importantes, en móvil, tableta y web.';

  @override
  String get name => 'Nombre';

  @override
  String get nameHint => 'Alex Rivera';

  @override
  String get nameRequired => 'Dinos cómo te llamamos.';

  @override
  String get email => 'Correo electrónico';

  @override
  String get emailHint => 'tu@example.com';

  @override
  String get emailRequired => 'Introduce tu correo electrónico.';

  @override
  String get emailInvalid => 'Ese correo electrónico no parece válido.';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordRequired => 'Introduce tu contraseña.';

  @override
  String get passwordTooShort => 'Usa al menos 6 caracteres.';

  @override
  String get forgotPassword => '¿Olvidaste la contraseña?';

  @override
  String get signInServiceUnavailable =>
      'No se pudo conectar con el servicio de inicio de sesión. Comprueba tu conexión.';

  @override
  String get createAccountAction => 'Crear cuenta';

  @override
  String get or => 'O';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get newHere => '¿Eres nuevo?';

  @override
  String get createOne => 'Crear una';

  @override
  String get signInTrouble => '¿Problemas para iniciar sesión? Obtén ayuda';

  @override
  String get accountCreated => 'Cuenta creada.';

  @override
  String get welcomeBack => 'Te damos la bienvenida de nuevo.';

  @override
  String get signedInWithGoogle => 'Has iniciado sesión con Google.';

  @override
  String get enterEmailForReset =>
      'Introduce primero tu correo y luego toca «¿Olvidaste la contraseña?».';

  @override
  String resetLinkSent(String email) {
    return 'Se envió un enlace para restablecerla a $email.';
  }

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get markAllRead => 'Marcar todo como leído';

  @override
  String get moreOptions => 'Más opciones';

  @override
  String get noReadMessages => 'No hay mensajes leídos para eliminar.';

  @override
  String get deleteReadMessages => 'Eliminar mensajes leídos';

  @override
  String get deletedReadMessages => 'Se eliminaron los mensajes leídos.';

  @override
  String get signInFirst => 'Inicia sesión primero';

  @override
  String get notificationsAccountOnly =>
      'Las notificaciones están vinculadas a tu cuenta.';

  @override
  String get couldNotLoad => 'No se pudo cargar';

  @override
  String get checkConnectionRetry =>
      'Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get nothingYet => 'Todavía no hay nada';

  @override
  String get notificationsEmpty =>
      'Aquí aparecerán las novedades de tus planes de comida e invitaciones.';

  @override
  String get liveNotificationsUnavailable =>
      'No se pudieron cargar las notificaciones en directo.';

  @override
  String get inbox => 'BANDEJA DE ENTRADA';

  @override
  String get invitationResponses => 'RESPUESTAS A INVITACIONES';

  @override
  String get invitationResponsesUnavailable =>
      'No se pudieron cargar las respuestas a las invitaciones.';

  @override
  String get circles => 'Círculos';

  @override
  String get editDecision => 'Editar decisión';

  @override
  String get setDecisionScene =>
      'Cuéntanos el plan. Nosotros nos encargamos de los votos.';

  @override
  String get keepDecisionUpdated => 'Mantén el plan al día.';

  @override
  String get decisionEditorDescription =>
      'Ponle nombre a la ocasión, elige una hora y añade lugares para que todos voten.';

  @override
  String get decisionName => 'Nombre de la decisión';

  @override
  String get decisionNameHint => 'Cena del viernes';

  @override
  String get decisionNameRequired => 'Añade un nombre para la decisión.';

  @override
  String get optionalContext => 'Un poco de contexto (opcional)';

  @override
  String get decisionContextHint => 'Cena de cumpleaños, almuerzo del equipo…';

  @override
  String get decisionTime => 'Hora de la decisión';

  @override
  String get shortlist => 'Lista de opciones';

  @override
  String get addTwoPlaces => 'Añade al menos dos lugares.';

  @override
  String get shortlistLocked =>
      'La votación ha empezado y la lista está bloqueada.';

  @override
  String get addRestaurant => 'Añadir restaurante';

  @override
  String get shareWithCrew => 'Compartir con un grupo';

  @override
  String get twoPersonCrewSharing =>
      'Los grupos de dos se seleccionan de forma predeterminada. Puedes desactivarlo para esta decisión cuando quieras.';

  @override
  String get crewMembersCanVote =>
      'Los miembros del grupo pueden votar sin otra invitación.';

  @override
  String get createCrewFirst =>
      'Crea primero un grupo para planear comidas juntos.';

  @override
  String get inviteByEmailOptional =>
      'Invitar por correo electrónico (opcional)';

  @override
  String get inviteEmailsHint => 'alex@example.com, sam@example.com';

  @override
  String get createDecision => 'Crear decisión';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String restaurantNumber(int number) {
    return 'Restaurante $number';
  }

  @override
  String get restaurantExample => 'p. ej., Fideos del Norte';

  @override
  String get addName => 'Añade un nombre.';

  @override
  String get removeRestaurant => 'Eliminar restaurante';

  @override
  String get addressOptional => 'Dirección (opcional)';

  @override
  String get websiteOptional => 'Sitio web (opcional)';

  @override
  String get couldNotSaveDecision => 'No se pudo guardar la decisión.';

  @override
  String get castYourVote => 'Emite tu voto';

  @override
  String get swipeMode => 'Deslizar';

  @override
  String get listMode => 'Lista';

  @override
  String get swipeRightToPick =>
      'Desliza a la derecha para elegir y a la izquierda para pasar.';

  @override
  String yourCurrentPick(String title) {
    return 'Tu elección actual: $title';
  }

  @override
  String get pass => 'Pasar';

  @override
  String get vote => 'Votar';

  @override
  String youVotedFor(String title) {
    return 'Has votado por $title.';
  }

  @override
  String get backToDecision => 'Volver a la decisión';

  @override
  String get yesLetsGo => 'SÍ, ¡VAMOS!';

  @override
  String get maybeNextTime => 'QUIZÁ LA PRÓXIMA VEZ';

  @override
  String get onTheMenu => 'EN EL MENÚ';

  @override
  String get rightToVoteLeftToPass =>
      'Derecha para votar · izquierda para pasar';

  @override
  String get yourVote => 'Tu voto';

  @override
  String get decisionUnavailable => 'Esta decisión ya no está disponible.';

  @override
  String get acceptInvitationBeforeVote =>
      'Acepta la invitación antes de votar.';

  @override
  String get restaurantsUnavailable =>
      'No se pudieron cargar los restaurantes.';

  @override
  String get noRestaurantsYet => 'Todavía no hay restaurantes para votar.';

  @override
  String get always => 'siempre';

  @override
  String get couldNotLoadRoom =>
      'No se pudo cargar esta decisión. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get voteCouldNotSave =>
      'No se pudo guardar tu voto. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get eventUnavailable => 'Este plan de comida ya no está disponible.';

  @override
  String get share => 'Compartir';

  @override
  String get edit => 'Editar';

  @override
  String get viewDetails => 'Ver detalles';

  @override
  String get sharedWith => 'COMPARTIDO CON';

  @override
  String get notes => 'NOTAS';

  @override
  String get notesEmpty =>
      'Todavía no hay nada. Deja un mensaje para quienes están planeando contigo.';

  @override
  String get addNote => 'Añadir una nota';

  @override
  String get dayHasCome => 'HA LLEGADO EL DÍA';

  @override
  String arrivalWithoutDescription(String title) {
    return '$title ya está aquí: disfruta cada momento.';
  }

  @override
  String arrivalWithDescription(String title, String description) {
    return '$title ya está aquí: $description';
  }

  @override
  String get passed => 'Finalizado';

  @override
  String get countingDown => 'Cuenta atrás';

  @override
  String get duplicateYearLater => 'Duplicar un año después';

  @override
  String get duplicateEventSuccess =>
      'Se ha duplicado. Ábrelo para cambiar la fecha.';

  @override
  String get deleteMealPlan => 'Eliminar plan de comida';

  @override
  String get deleteOwnerOnly =>
      'Solo el propietario puede eliminar este plan de comida.';

  @override
  String get mealPlanDeleted => 'Se eliminó el plan de comida.';

  @override
  String get couldNotDelete => 'No se pudo eliminar. Inténtalo de nuevo.';

  @override
  String get deleteMealPlanConfirm => '¿Eliminar este plan de comida?';

  @override
  String get mealPlanCannotRecover =>
      'No se podrá recuperar este plan de comida.';

  @override
  String get keep => 'Conservar';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancelDecisionConfirm => '¿Cancelar esta decisión?';

  @override
  String get roomKeptInHistory => 'La sala se conservará en el historial.';

  @override
  String get keepIt => 'Conservar';

  @override
  String get cancelDecision => 'Cancelar decisión';

  @override
  String get couldNotRevealWinner => 'No se pudo mostrar el resultado.';

  @override
  String get couldNotAddNote => 'No se pudo añadir la nota.';

  @override
  String get couldNotDuplicateDecision => 'No se pudo duplicar esta decisión.';

  @override
  String get couldNotCancelDecision => 'No se pudo cancelar esta decisión.';

  @override
  String get linkCouldNotOpen => 'No se pudo abrir este enlace.';

  @override
  String get mapsCouldNotOpen => 'No se pudo abrir Maps.';

  @override
  String get decision => 'Decisión';

  @override
  String get duplicateForAnotherDay => 'Duplicar para otro día';

  @override
  String get swipeToVote => 'Desliza para votar';

  @override
  String get noRestaurantsAdded => 'Todavía no se han añadido restaurantes.';

  @override
  String get aroundTable => 'Alrededor de la mesa';

  @override
  String get couldNotLoadGroup => 'No se pudo cargar el grupo.';

  @override
  String get couldNotLoadNotes => 'No se pudieron cargar las notas.';

  @override
  String get theGroupDecision => 'LA DECISIÓN DEL GRUPO';

  @override
  String get weAreGoingTo => 'VAMOS A';

  @override
  String get tableStillOpen => 'La decisión sigue abierta';

  @override
  String get openInMaps => 'Abrir en Maps';

  @override
  String get addToCalendar => 'Añadir al calendario';

  @override
  String get website => 'Sitio web';

  @override
  String votesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count votos',
      one: '$count voto',
    );
    return '$_temp0';
  }

  @override
  String get currentVote => 'Tu voto actual';

  @override
  String voteForOption(String title) {
    return 'Votar por $title';
  }

  @override
  String get openInMapsTooltip => 'Abrir en Maps';

  @override
  String get openWebsiteTooltip => 'Abrir sitio web';

  @override
  String get guest => 'Invitado';

  @override
  String calendarEventTitle(String roomName) {
    return 'Bite Brigade · $roomName';
  }

  @override
  String get calendarDecisionMade => 'Decisión tomada con Bite Brigade.';

  @override
  String calendarWinnerPicked(String title) {
    return 'Hemos elegido $title.';
  }

  @override
  String get back => 'Atrás';

  @override
  String get nobodyBlocked => 'No hay nadie bloqueado';

  @override
  String get blockPeopleHowTo =>
      'Para bloquear a alguien, abre un plan de comida que compartáis, toca el menú ⋮ de su fila y elige Bloquear.';

  @override
  String get blockedPeopleCannotInvite =>
      'Estas personas no pueden invitarte y no compartes ningún plan de comida con ellas.';

  @override
  String get notToldTheyAreBlocked =>
      'No se les avisará de que están bloqueadas.';

  @override
  String get blockedListLoadError =>
      'No se pudo cargar la lista de personas bloqueadas';

  @override
  String get blockedListPermissionError =>
      'Tu cuenta no puede leer esta lista. Si el problema continúa, actualiza la aplicación.';

  @override
  String get tryAgain => 'Volver a intentarlo';

  @override
  String blockUserTitle(String name) {
    return '¿Bloquear a $name?';
  }

  @override
  String get blockUserExplanation =>
      'Dejarás de ver el contenido de esa persona. Se eliminará de los planes de comida compartidos, se cancelarán las invitaciones entre vosotros y no podrá volver a invitarte. No recibirá ningún aviso.';

  @override
  String get blockUndoTip =>
      'Puedes deshacerlo cuando quieras en Ajustes → Personas bloqueadas.';

  @override
  String get blocking => 'Bloqueando…';

  @override
  String get block => 'Bloquear';

  @override
  String get undo => 'Deshacer';

  @override
  String personBlocked(String name) {
    return '$name está bloqueado.';
  }

  @override
  String get blockUndoFailed =>
      'No se pudo deshacer el bloqueo. Inténtalo de nuevo.';

  @override
  String get blockSavePermissionError =>
      'No se pudo guardar el bloqueo. Inicia sesión de nuevo e inténtalo otra vez.';

  @override
  String get blockSaveNetworkError =>
      'No hay conexión. Comprueba la red e inténtalo de nuevo.';

  @override
  String blockSaveError(String name) {
    return 'No se pudo bloquear a $name. Inténtalo de nuevo.';
  }

  @override
  String personUnblocked(String name) {
    return '$name ya no está bloqueado. No se restableció el acceso a los planes de comida.';
  }

  @override
  String get weReadEveryMessage => 'Leemos todos los mensajes';

  @override
  String supportIntroduction(String responseTime) {
    return 'Bite Brigade es una aplicación independiente. El correo electrónico es la forma más rápida de contactar con quien la desarrolla; no hay un equipo de soporte intermediario. Normalmente respondemos $responseTime.';
  }

  @override
  String get supportResponseTime => 'en un plazo de 2 días laborables';

  @override
  String get commonQuestions => 'Preguntas frecuentes';

  @override
  String get faqMissingPlansQuestion =>
      'He iniciado sesión, pero no aparecen mis salas para comer.';

  @override
  String get faqMissingPlansAnswer =>
      'Comprueba que has iniciado sesión con la cuenta invitada a esas salas. Si se comparte con un grupo, confirma que sigues siendo miembro.';

  @override
  String get faqInviteeQuestion => 'Una persona invitada no puede ver la sala.';

  @override
  String get faqInviteeAnswer =>
      'Pídele que inicie sesión con el correo que recibió la invitación y la acepte desde la pantalla de Invitaciones.';

  @override
  String get faqDeleteAccountQuestion => '¿Cómo elimino mi cuenta y mis datos?';

  @override
  String get faqDeleteAccountAnswer =>
      'Abre Ajustes > Eliminar cuenta y sigue los pasos de confirmación. Si no puedes iniciar sesión, contacta con soporte desde el correo electrónico de tu cuenta.';

  @override
  String get faqWhoSeesRoomQuestion => '¿Quién puede ver mi sala?';

  @override
  String get faqWhoSeesRoomAnswer =>
      'El creador de la sala y los participantes que aceptaron la invitación pueden ver sus detalles. Los miembros del grupo también pueden ver las salas compartidas con él.';

  @override
  String get faqDataQuestion => '¿Vendéis mis datos o mostráis anuncios?';

  @override
  String get faqDataAnswer =>
      'La información de las salas se almacena en el proyecto de Firebase configurado y se comparte con los participantes o el grupo que elijas. Consulta la política de privacidad para obtener más información.';

  @override
  String get supportContactNote =>
      'Los reembolsos, las dudas de facturación y los informes de errores se atienden en la misma dirección. Si la aplicación falla, dinos qué dispositivo usabas y qué estabas haciendo; será de gran ayuda.';

  @override
  String get emailSupport => 'Escribir al soporte';

  @override
  String supportEmailCopied(String email) {
    return 'Se copió $email';
  }

  @override
  String get openMail => 'Abrir correo';

  @override
  String get linkCopiedClipboard => 'Enlace copiado al portapapeles.';

  @override
  String get nothingWaitingForYou => 'No tienes invitaciones pendientes.';

  @override
  String get invitationsEmptyDescription =>
      'Aquí aparecerán las invitaciones a planes de comida y grupos. La mayoría requiere tu respuesta; los grupos de dos se añaden automáticamente.';

  @override
  String get waitingOnYou => 'Esperando tu respuesta';

  @override
  String get invitationsSummary =>
      'Únete a un plan de comida para ayudar a elegir dónde comer, o a un grupo para planear juntos. Si rechazas la invitación, quien te invitó lo sabrá.';

  @override
  String get signInToSeeInvitations =>
      'Inicia sesión para ver las invitaciones';

  @override
  String get invitationsSignInDescription =>
      'Las invitaciones se envían a tu correo. Inicia sesión con la dirección a la que te invitaron.';

  @override
  String get dinnerDecisions => 'Decisiones para comer';

  @override
  String get invitedToChoosePlace =>
      'Te han invitado a decidir dónde comerá el grupo.';

  @override
  String get joinDecision => 'Unirse a la decisión';

  @override
  String get twoPersonBadge => 'DOS PERSONAS';

  @override
  String get joinTwoPersonCrewDescription =>
      'Únete a este grupo de dos para compartir automáticamente los próximos planes de comida.';

  @override
  String get joinCrewDescription =>
      'Únete a este grupo para recibir y preparar futuros planes de comida.';

  @override
  String get joinCrew => 'Unirse al grupo';

  @override
  String get invitationLoadError =>
      'No se pudieron cargar las invitaciones. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get couldNotRespondInvitation =>
      'No se pudo responder a esta invitación. Inténtalo de nuevo.';

  @override
  String get roleAdmin => 'Administrador';

  @override
  String get roleEditor => 'Editor';

  @override
  String get roleViewer => 'Lector';

  @override
  String get decline => 'Rechazar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yourCrews => 'Tus grupos';

  @override
  String get createCrew => 'Crear un grupo';

  @override
  String get couldNotLoadCrews => 'No se pudieron cargar tus grupos.';

  @override
  String get goodThingsShared => 'Las cosas buenas se disfrutan en compañía.';

  @override
  String get bringPeopleTogether =>
      'Reúne a tus amistades, familiares o compañeros para planear la próxima comida.';

  @override
  String membersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count miembros',
      one: '$count miembro',
    );
    return '$_temp0';
  }

  @override
  String get crewNameRequired => 'Ponle un nombre al grupo.';

  @override
  String get couldNotCreateCrew =>
      'No se pudo crear el grupo. Inténtalo de nuevo.';

  @override
  String get gatherYourCrew => 'Reúne a tu grupo.';

  @override
  String get inviteEveryoneOnce =>
      'Invita a todos una vez y luego planead comidas juntos cuando queráis.';

  @override
  String get mark => 'Marca';

  @override
  String get crewName => 'Nombre del grupo';

  @override
  String get crewNameHint => 'Los de los viernes';

  @override
  String get twoPersonCrewTitle => 'Solo nosotros dos';

  @override
  String get twoPersonCrewDescription =>
      'Compartid los planes de comida automáticamente.';

  @override
  String get crewCreated => 'Grupo creado.';

  @override
  String get crewInvitationSent => 'Se envió la invitación al grupo.';

  @override
  String get couldNotSendCrewInvitation =>
      'No se pudo enviar la invitación. Inténtalo de nuevo.';

  @override
  String get couldNotRenameCrew =>
      'No se pudo cambiar el nombre del grupo. Inténtalo de nuevo.';

  @override
  String get couldNotChangeCrewRole =>
      'No se pudo cambiar el rol de esta persona. Inténtalo de nuevo.';

  @override
  String get couldNotRemoveCrewMember =>
      'No se pudo quitar a esta persona del grupo. Inténtalo de nuevo.';

  @override
  String get couldNotDeleteCrew =>
      'No se pudo eliminar el grupo. Inténtalo de nuevo.';

  @override
  String get couldNotUpdateCrewAfterBlock =>
      'La persona está bloqueada, pero no se pudo actualizar su acceso al grupo. Intenta quitarla otra vez.';

  @override
  String get crewRoleAppliesToFutureDecisions =>
      'El rol de cada persona se aplica a las nuevas decisiones que se compartan con este grupo.';

  @override
  String get blockCrewMemberExplanation =>
      'Se bloqueará a esta persona. Si eres propietario del grupo, se la quitará; de lo contrario, saldrás del grupo. Su acceso directo a otros planes no cambiará.';

  @override
  String leaveNamedCrew(String name) {
    return '¿Salir de $name?';
  }

  @override
  String get leaveCrewDescription =>
      'Dejarás de ver las nuevas decisiones que se compartan con este grupo.';

  @override
  String get stay => 'Quedarse';

  @override
  String get leaveCrew => 'Salir del grupo';

  @override
  String get couldNotLeaveCrew =>
      'No se pudo salir del grupo. Inténtalo de nuevo.';

  @override
  String get crew => 'Grupo';

  @override
  String get crewUnavailable => 'Este grupo ya no está disponible.';

  @override
  String get renameCrew => 'Cambiar nombre del grupo';

  @override
  String get twoPersonCrew => 'Grupo de dos';

  @override
  String get standingCrew => 'Grupo habitual';

  @override
  String get mealPlansSharedAutomatically =>
      'Los planes de comida se comparten automáticamente.';

  @override
  String get sharePlansWithCrew =>
      'Comparte planes de comida con este grupo cuando planeéis juntos.';

  @override
  String get members => 'Miembros';

  @override
  String get invite => 'Invitar';

  @override
  String get owner => 'PROPIETARIO';

  @override
  String get leaveThisCrew => 'Salir de este grupo';

  @override
  String get inviteToYourCrew => 'Invitar a tu grupo';

  @override
  String get emailAddress => 'Dirección de correo electrónico';

  @override
  String get sendInvitation => 'Enviar invitación';

  @override
  String get save => 'Guardar';

  @override
  String get couldNotLoadCrew => 'No se pudo cargar este grupo.';

  @override
  String get couldNotLoadCrewMembers =>
      'No se pudieron cargar los miembros del grupo.';

  @override
  String get accept => 'Aceptar';

  @override
  String get mealPlanInvitation => 'Invitación a un plan de comida';

  @override
  String get unnamedMealPlan => 'Un plan de comida';

  @override
  String mealPlanInvitationBody(String role) {
    return 'Te han invitado a este plan de comida. Si aceptas, aparecerá en tu lista con el rol $role.';
  }

  @override
  String get joinMealPlanQuestion => '¿Unirte a este plan de comida?';

  @override
  String get joinMealPlanExplanation =>
      'Aparecerá en tu lista para que encuentres fácilmente la fecha y los detalles.';

  @override
  String get join => 'Unirme';

  @override
  String alreadyMemberOf(String name) {
    return 'Ya formas parte de «$name».';
  }

  @override
  String joinedNamedMealPlan(String name) {
    return 'Te has unido a «$name».';
  }

  @override
  String get invitationDeclined => 'Invitación rechazada.';

  @override
  String get twoPersonGroupInvitation => 'Invitación a un grupo de dos';

  @override
  String get crewInvitation => 'Invitación al grupo';

  @override
  String addingYouToCrew(String name) {
    return 'Te están añadiendo al grupo de $name.';
  }

  @override
  String invitedYouToNamedCrew(String inviter, String crew) {
    return '$inviter te ha invitado a «$crew».';
  }

  @override
  String automaticCrewInvitationBody(String crew) {
    return 'Se te añadirá automáticamente. Los futuros planes de comida compartidos con «$crew» aparecerán en tu lista.';
  }

  @override
  String namedCrewInvitationBody(String crew) {
    return 'Únete a «$crew» para ver los planes de comida que comparte este grupo.';
  }

  @override
  String get couldNotAddYouAutomatically =>
      'No se te pudo añadir automáticamente.';

  @override
  String get retryAddingYou => 'Intentar añadirme de nuevo';

  @override
  String get notNow => 'Ahora no';

  @override
  String alreadyMemberOfCrew(String crew) {
    return 'Ya formas parte de «$crew».';
  }

  @override
  String addedToNamedCrew(String crew) {
    return 'Te han añadido a «$crew».';
  }

  @override
  String joinedNamedCrew(String crew) {
    return 'Te has unido a «$crew».';
  }

  @override
  String get someone => 'Alguien';

  @override
  String get you => 'Tú';

  @override
  String get noCrewsYet => 'Todavía no hay grupos';

  @override
  String get remove => 'Quitar';

  @override
  String get removeFromCrew => 'Quitar del grupo';

  @override
  String removeCrewMemberTitle(String name) {
    return '¿Quitar a $name?';
  }

  @override
  String get removeCrewMemberExplanation =>
      'Dejará de ver los planes de comida compartidos con este grupo. No se eliminará nada de lo que haya creado.';

  @override
  String deleteNamedCrew(String name) {
    return '¿Eliminar «$name»?';
  }

  @override
  String get deleteCrewExplanation =>
      'El grupo desaparecerá. Los planes compartidos se conservarán y seguirán siendo tuyos, pero dejarán de compartirse con estas personas.';

  @override
  String inviteToNamedCrew(String name) {
    return 'Invitar a «$name»';
  }

  @override
  String get inviteToTwoPersonCrew => 'Invitar a tu grupo de dos';

  @override
  String get automaticCrewInviteExplanation =>
      'Si ya tiene una cuenta, se añadirá automáticamente. De lo contrario, se añadirá cuando inicie sesión. Los planes compartidos con este grupo aparecerán automáticamente.';

  @override
  String get crewInviteExplanation =>
      'Recibirá una invitación que podrá aceptar o rechazar. Cuando se una, podrás compartir planes de comida con este grupo con un solo toque.';

  @override
  String get inviteEmailHint => 'amigo@example.com';

  @override
  String get recentContactsLoadError =>
      'No se pudieron cargar los contactos recientes. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get theyWillBeAddedAutomatically => 'Se añadirá automáticamente.';

  @override
  String invitationSentTo(String email) {
    return 'Invitación enviada a $email.';
  }

  @override
  String leftNamedCrew(String name) {
    return 'Has salido de «$name».';
  }

  @override
  String deletedNamedCrew(String name) {
    return 'Se ha eliminado «$name».';
  }

  @override
  String get signInToUseCrews => 'Inicia sesión para usar grupos';

  @override
  String get crewsSignInDescription =>
      'Los grupos invitan a personas por correo electrónico, así que necesitan una cuenta para recibir invitaciones.';

  @override
  String get editMealPlan => 'Editar plan de comida';

  @override
  String get createMealPlanAction => 'Crear plan de comida';

  @override
  String get mealPlanActions => 'Acciones del plan de comida';

  @override
  String get titleField => 'Título';

  @override
  String get mealPlanTitleHint =>
      'Cena del viernes, almuerzo del equipo, brunch familiar';

  @override
  String get descriptionField => 'Descripción';

  @override
  String get mealPlanDescriptionHint =>
      'Añade una nota sobre la comida, el lugar o el plan';

  @override
  String get when => 'Cuándo';

  @override
  String get date => 'Fecha';

  @override
  String get oneWeek => '+1 semana';

  @override
  String get oneMonth => '+1 mes';

  @override
  String get oneYear => '+1 año';

  @override
  String get fiveYears => '+5 años';

  @override
  String get mealPlanTitleRequired => 'Ponle un título a este plan de comida.';

  @override
  String get futureMomentRequired => 'Elige una fecha futura.';

  @override
  String get signInToSaveMealPlans =>
      'Inicia sesión para guardar planes de comida.';

  @override
  String get mealPlanCreated => 'Plan de comida creado.';

  @override
  String get changesSaved => 'Cambios guardados.';

  @override
  String get otherPerson => 'La otra persona';

  @override
  String coupleNotAdded(String name) {
    return 'Se creó el plan, pero no se añadió a $name. Invítale manualmente desde el plan.';
  }

  @override
  String coupleAdded(String name) {
    return 'Plan de comida creado. Se añadió a $name.';
  }

  @override
  String get nobodyAdded =>
      'Se creó el plan, pero no se añadió a nadie. Envía las invitaciones desde el plan.';

  @override
  String get viewOnlyMealPlan =>
      'Puedes ver este plan de comida, pero no modificarlo.';

  @override
  String get chooseFutureMealTime =>
      'Elige una fecha futura para ver la cuenta atrás.';

  @override
  String timeUntilMeal(String duration) {
    return 'Tiempo hasta la comida: $duration';
  }

  @override
  String get collaborators => 'Colaboradores';

  @override
  String get inviteesAccessDescription =>
      'Las personas que invites podrán ver este plan en sus dispositivos.';

  @override
  String get peopleWithAccess => 'Personas con acceso a este plan de comida.';

  @override
  String get noCollaboratorsYet => 'Todavía no hay nadie más.';

  @override
  String sharedWithNamedCrew(String name) {
    return 'Compartido con $name';
  }

  @override
  String get inviteAgain => 'Volver a invitar';

  @override
  String get moreActions => 'Más acciones';

  @override
  String get changeRole => 'Cambiar rol';

  @override
  String memberRoleUpdated(String name, String role) {
    return '$name ahora tiene el rol $role.';
  }

  @override
  String personRemoved(String name) {
    return 'Se ha eliminado a $name.';
  }

  @override
  String invitationAskedAgain(String email) {
    return 'Se ha vuelto a invitar a $email.';
  }

  @override
  String get removePersonQuestion => '¿Quitar a esta persona?';

  @override
  String removePersonExplanation(String email) {
    return '$email perderá el acceso a este plan de comida y dejará de verlo en su lista.';
  }

  @override
  String changeRoleFor(String name) {
    return 'Cambiar el rol de $name';
  }

  @override
  String roleCurrentAccess(String role) {
    return 'Esto cambia lo que puede hacer en este plan. Actualmente tiene el rol $role.';
  }

  @override
  String rolesCannotBeAssigned(String roles, String role) {
    return 'No puedes asignar los roles $roles porque tu rol es $role.';
  }

  @override
  String get and => 'y';

  @override
  String get adminRoleDescription =>
      'Puede invitar a personas, cambiar roles, editar el plan y quitar colaboradores.';

  @override
  String get editorRoleDescription =>
      'Puede editar el título, la descripción y la fecha. No puede gestionar personas.';

  @override
  String get viewerRoleDescription => 'Solo puede ver el plan de comida.';

  @override
  String durationYearCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count años',
      one: '$count año',
    );
    return '$_temp0';
  }

  @override
  String durationMonthCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses',
      one: '$count mes',
    );
    return '$_temp0';
  }

  @override
  String durationDayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '$count día',
    );
    return '$_temp0';
  }

  @override
  String durationHourCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas',
      one: '$count hora',
    );
    return '$_temp0';
  }

  @override
  String durationMinuteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '$count minuto',
    );
    return '$_temp0';
  }

  @override
  String durationSecondCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segundos',
      one: '$count segundo',
    );
    return '$_temp0';
  }

  @override
  String get momentHasPassed => 'El momento ya ha pasado.';

  @override
  String get couldNotSaveMealPlan =>
      'No se pudo guardar este plan de comida. Inténtalo de nuevo.';

  @override
  String get savePermissionError =>
      'Tu cuenta no puede guardar este plan. Actualiza la aplicación e inténtalo de nuevo.';

  @override
  String get saveNetworkError =>
      'No se pudo conectar con el servicio. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get unblock => 'Desbloquear';

  @override
  String get upcoming => 'Próximamente';

  @override
  String get invitationAcceptedState => 'Aceptada';

  @override
  String get invitationDeclinedState => 'Rechazada';

  @override
  String get invitationRemovedState => 'Eliminada';

  @override
  String get invitationReopenedState => 'Reabierta';

  @override
  String get invitationWaitingState => 'Pendiente';

  @override
  String get sharedCrewInviteInfo =>
      'Los grupos de dos comparten los planes automáticamente. Los demás grupos envían una invitación.';

  @override
  String get shareWith => 'Compartir con';

  @override
  String get arrived => 'Ya ha llegado el momento.';

  @override
  String countdownToGo(String duration) {
    return 'Faltan $duration';
  }

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountWarning =>
      'Esta acción es permanente. Todos tus planes de comida, grupos y datos se eliminarán para siempre.';

  @override
  String get deleteAccountConfirmationPrompt =>
      'Escribe exactamente el correo electrónico de tu cuenta para continuar.';

  @override
  String get deleteAccountConfirmationLabel =>
      'Correo electrónico de la cuenta';

  @override
  String get deleteAccountProfileConsequence =>
      'Tu perfil se eliminará permanentemente.';

  @override
  String get deleteAccountAccessConsequence =>
      'Perderás el acceso a todos tus planes de comida y grupos.';

  @override
  String get deleteAccountIrreversibleConsequence =>
      'Esta acción no se puede deshacer.';

  @override
  String get deleteAccountPermanentlyAction =>
      'Eliminar cuenta permanentemente';

  @override
  String get accountDeleted => 'Cuenta eliminada correctamente.';

  @override
  String get serverTimedOutTryAgain =>
      'El servidor agotó el tiempo de espera. Inténtalo de nuevo más tarde.';

  @override
  String get accountDeletionFailed =>
      'No se pudo completar la eliminación de la cuenta. Inténtalo de nuevo.';

  @override
  String get accountDeletedCleanupWarning =>
      'La cuenta se eliminó, pero no se pudieron borrar algunos ajustes locales. Reinicia la aplicación antes de usar otra cuenta.';
}
