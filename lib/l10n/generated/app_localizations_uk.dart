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
  String get languageEnglish => 'Англійська';

  @override
  String get languageFrench => 'Французька';

  @override
  String get languageSpanish => 'Іспанська';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get languageGerman => 'Німецька';

  @override
  String get languageChineseTaiwan => 'Традиційна китайська (Тайвань)';

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

  @override
  String get homeTitle => 'Сплануймо обід.';

  @override
  String get homeDescription =>
      'Оберіть, де поїсти, запросіть свою компанію та вирішіть разом.';

  @override
  String get getStarted => 'Почати';

  @override
  String get createMealPlan => 'Створити план зустрічі';

  @override
  String get keepMealPlansSynced => 'Синхронізуйте плани зустрічей';

  @override
  String get syncMealPlansDescription =>
      'Увійдіть, щоб синхронізувати плани між пристроями та разом із компанією обрати місце.';

  @override
  String get couldNotLoadMealPlans =>
      'Не вдалося завантажити плани зустрічей. Потягніть униз, щоб спробувати ще раз.';

  @override
  String get options => 'Параметри';

  @override
  String get open => 'Відкрити';

  @override
  String get openMealPlan => 'Відкрити план зустрічі';

  @override
  String get openDecision => 'Відкрити вибір';

  @override
  String get upcomingPlans => 'НАСТУПНІ ЗУСТРІЧІ';

  @override
  String get newMealPlan => 'Новий план зустрічі';

  @override
  String get readyToGather => 'ЧАС ЗБИРАТИСЯ';

  @override
  String get comingUp => 'НЕЗАБАРОМ';

  @override
  String get years => 'Роки';

  @override
  String get months => 'Місяці';

  @override
  String get days => 'Дні';

  @override
  String get hours => 'Години';

  @override
  String minutesRemaining(int minutes, int seconds) {
    return 'Залишилося $minutes хв · $seconds с';
  }

  @override
  String get navHome => 'Головна';

  @override
  String get navInvitations => 'Запрошення';

  @override
  String get navCrews => 'Компанії';

  @override
  String get navNotifications => 'Сповіщення';

  @override
  String get navSupport => 'Підтримка';

  @override
  String get tableIsYours => 'ОБИРАЙТЕ РАЗОМ';

  @override
  String get whereAreWeGoing => 'Куди підемо?';

  @override
  String get groupDecisionDescription =>
      'Смачна вечеря починається зі спільного рішення.';

  @override
  String get newDecision => 'Нове рішення';

  @override
  String get decisionsCouldNotLoad => 'Не вдалося завантажити ваші рішення.';

  @override
  String get yourTable => 'Ваш стіл';

  @override
  String get noDecisions => 'Поки немає рішень';

  @override
  String get noDecisionsDescription =>
      'Зберіть друзів і дозвольте кожному обрати місце.';

  @override
  String get startDecision => 'Почати вибір';

  @override
  String get roomOpen => 'ВІДКРИТЕ';

  @override
  String get roomDecided => 'ОБРАНО';

  @override
  String get roomCancelled => 'СКАСОВАНО';

  @override
  String votesProgress(int votesCast, int participantCount) {
    return 'Проголосували: $votesCast з $participantCount';
  }

  @override
  String get createAccountHeading => 'Створити обліковий запис';

  @override
  String get welcomeHeading => 'Вітаємо в Bite Brigade';

  @override
  String get createAccountDescription =>
      'Обирайте вечерю разом на будь-якому пристрої.';

  @override
  String get welcomeDescription =>
      'Відлік до важливих моментів на телефоні, планшеті та в інтернеті.';

  @override
  String get name => 'Ім’я';

  @override
  String get nameHint => 'Олексій';

  @override
  String get nameRequired => 'Як до вас звертатися?';

  @override
  String get email => 'Електронна пошта';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get emailRequired => 'Введіть адресу електронної пошти.';

  @override
  String get emailInvalid => 'Схоже, адреса електронної пошти неправильна.';

  @override
  String get password => 'Пароль';

  @override
  String get passwordRequired => 'Введіть пароль.';

  @override
  String get passwordTooShort => 'Використайте щонайменше 6 символів.';

  @override
  String get forgotPassword => 'Забули пароль?';

  @override
  String get signInServiceUnavailable =>
      'Не вдалося підключитися до служби входу. Перевірте з’єднання.';

  @override
  String get createAccountAction => 'Створити обліковий запис';

  @override
  String get or => 'АБО';

  @override
  String get continueWithGoogle => 'Продовжити з Google';

  @override
  String get alreadyHaveAccount => 'Уже маєте обліковий запис?';

  @override
  String get newHere => 'Вперше тут?';

  @override
  String get createOne => 'Створити';

  @override
  String get signInTrouble => 'Не вдається увійти? Отримати допомогу';

  @override
  String get accountCreated => 'Обліковий запис створено.';

  @override
  String get welcomeBack => 'З поверненням!';

  @override
  String get signedInWithGoogle => 'Ви ввійшли через Google.';

  @override
  String get enterEmailForReset =>
      'Спершу введіть електронну пошту, а потім натисніть «Забули пароль?».';

  @override
  String resetLinkSent(String email) {
    return 'Посилання для скидання пароля надіслано на $email.';
  }

  @override
  String get notificationsTitle => 'Сповіщення';

  @override
  String get markAllRead => 'Позначити все прочитаним';

  @override
  String get moreOptions => 'Інші параметри';

  @override
  String get noReadMessages => 'Немає прочитаних повідомлень для видалення.';

  @override
  String get deleteReadMessages => 'Видалити прочитані повідомлення';

  @override
  String get deletedReadMessages => 'Прочитані повідомлення видалено.';

  @override
  String get signInFirst => 'Спершу ввійдіть';

  @override
  String get notificationsAccountOnly =>
      'Сповіщення пов’язані з вашим обліковим записом.';

  @override
  String get couldNotLoad => 'Не вдалося завантажити';

  @override
  String get checkConnectionRetry => 'Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get nothingYet => 'Поки що нічого';

  @override
  String get notificationsEmpty =>
      'Тут з’являтимуться новини про плани зустрічей і запрошення.';

  @override
  String get liveNotificationsUnavailable =>
      'Не вдалося завантажити сповіщення в реальному часі.';

  @override
  String get inbox => 'ВХІДНІ';

  @override
  String get invitationResponses => 'ВІДПОВІДІ НА ЗАПРОШЕННЯ';

  @override
  String get invitationResponsesUnavailable =>
      'Не вдалося завантажити відповіді на запрошення.';

  @override
  String get circles => 'Кола';

  @override
  String get editDecision => 'Змінити рішення';

  @override
  String get setDecisionScene =>
      'Розкажіть про плани — ми подбаємо про голосування.';

  @override
  String get keepDecisionUpdated => 'Оновлюйте план.';

  @override
  String get decisionEditorDescription =>
      'Назвіть подію, оберіть час і додайте місця, за які всі зможуть проголосувати.';

  @override
  String get decisionName => 'Назва рішення';

  @override
  String get decisionNameHint => 'Вечеря в п’ятницю';

  @override
  String get decisionNameRequired => 'Додайте назву рішення.';

  @override
  String get optionalContext => 'Трохи подробиць (необов’язково)';

  @override
  String get decisionContextHint => 'День народження, обід із командою…';

  @override
  String get decisionTime => 'Час рішення';

  @override
  String get shortlist => 'Список варіантів';

  @override
  String get addTwoPlaces => 'Додайте щонайменше два місця.';

  @override
  String get shortlistLocked =>
      'Голосування вже почалося, тому список заблоковано.';

  @override
  String get addRestaurant => 'Додати ресторан';

  @override
  String get shareWithCrew => 'Поділитися з компанією';

  @override
  String get twoPersonCrewSharing =>
      'Компанії з двох людей вибрано за замовчуванням. Для цього рішення їх можна вимкнути.';

  @override
  String get crewMembersCanVote =>
      'Учасники компанії можуть голосувати без окремого запрошення.';

  @override
  String get createCrewFirst =>
      'Спершу створіть компанію, щоб планувати зустрічі разом.';

  @override
  String get inviteByEmailOptional =>
      'Запросити електронною поштою (необов’язково)';

  @override
  String get inviteEmailsHint => 'alex@example.com, sam@example.com';

  @override
  String get createDecision => 'Створити рішення';

  @override
  String get saveChanges => 'Зберегти зміни';

  @override
  String restaurantNumber(int number) {
    return 'Ресторан $number';
  }

  @override
  String get restaurantExample => 'наприклад, Північна локшина';

  @override
  String get addName => 'Додайте назву.';

  @override
  String get removeRestaurant => 'Видалити ресторан';

  @override
  String get addressOptional => 'Адреса (необов’язково)';

  @override
  String get websiteOptional => 'Вебсайт (необов’язково)';

  @override
  String get couldNotSaveDecision => 'Не вдалося зберегти це рішення.';

  @override
  String get castYourVote => 'Проголосуйте';

  @override
  String get swipeMode => 'Гортання';

  @override
  String get listMode => 'Список';

  @override
  String get swipeRightToPick =>
      'Гортайте праворуч, щоб обрати, ліворуч — щоб пропустити.';

  @override
  String yourCurrentPick(String title) {
    return 'Ваш поточний вибір: $title';
  }

  @override
  String get pass => 'Пропустити';

  @override
  String get vote => 'Голосувати';

  @override
  String youVotedFor(String title) {
    return 'Ви проголосували за «$title».';
  }

  @override
  String get backToDecision => 'Назад до рішення';

  @override
  String get yesLetsGo => 'ТАК, ХОДІМО!';

  @override
  String get maybeNextTime => 'МОЖЕ, ІНШОГО РАЗУ';

  @override
  String get onTheMenu => 'У МЕНЮ';

  @override
  String get rightToVoteLeftToPass =>
      'Праворуч — голосувати · ліворуч — пропустити';

  @override
  String get yourVote => 'Ваш голос';

  @override
  String get decisionUnavailable => 'Це рішення більше недоступне.';

  @override
  String get acceptInvitationBeforeVote =>
      'Прийміть запрошення, перш ніж голосувати.';

  @override
  String get restaurantsUnavailable => 'Не вдалося завантажити ресторани.';

  @override
  String get noRestaurantsYet => 'Поки немає ресторанів для голосування.';

  @override
  String get always => 'завжди';

  @override
  String get couldNotLoadRoom =>
      'Не вдалося завантажити це рішення. Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get voteCouldNotSave =>
      'Не вдалося зберегти ваш голос. Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get eventUnavailable => 'Цей план зустрічі більше недоступний.';

  @override
  String get share => 'Поділитися';

  @override
  String get edit => 'Змінити';

  @override
  String get viewDetails => 'Переглянути подробиці';

  @override
  String get sharedWith => 'СПІЛЬНИЙ ДОСТУП';

  @override
  String get notes => 'НОТАТКИ';

  @override
  String get notesEmpty =>
      'Поки що нічого. Залиште повідомлення тим, хто планує зустріч разом із вами.';

  @override
  String get addNote => 'Додати нотатку';

  @override
  String get dayHasCome => 'ЦЕЙ ДЕНЬ НАСТАВ';

  @override
  String arrivalWithoutDescription(String title) {
    return '«$title» вже настало — насолоджуйтеся кожною миттю.';
  }

  @override
  String arrivalWithDescription(String title, String description) {
    return '«$title» вже настало — $description';
  }

  @override
  String get passed => 'Минуло';

  @override
  String get countingDown => 'Зворотний відлік';

  @override
  String get duplicateYearLater => 'Створити копію на рік пізніше';

  @override
  String get duplicateEventSuccess =>
      'Створено копію — відкрийте її, щоб змінити дату.';

  @override
  String get deleteMealPlan => 'Видалити план зустрічі';

  @override
  String get deleteOwnerOnly => 'Лише власник може видалити цей план зустрічі.';

  @override
  String get mealPlanDeleted => 'План зустрічі видалено.';

  @override
  String get couldNotDelete => 'Не вдалося видалити. Спробуйте ще раз.';

  @override
  String get deleteMealPlanConfirm => 'Видалити цей план зустрічі?';

  @override
  String get mealPlanCannotRecover =>
      'Відновити цей план зустрічі буде неможливо.';

  @override
  String get keep => 'Залишити';

  @override
  String get delete => 'Видалити';

  @override
  String get cancelDecisionConfirm => 'Скасувати це рішення?';

  @override
  String get roomKeptInHistory => 'Зустріч залишиться в історії.';

  @override
  String get keepIt => 'Залишити';

  @override
  String get cancelDecision => 'Скасувати рішення';

  @override
  String get couldNotRevealWinner => 'Не вдалося показати результат.';

  @override
  String get couldNotAddNote => 'Не вдалося додати нотатку.';

  @override
  String get couldNotDuplicateDecision =>
      'Не вдалося створити копію цього рішення.';

  @override
  String get couldNotCancelDecision => 'Не вдалося скасувати це рішення.';

  @override
  String get linkCouldNotOpen => 'Не вдалося відкрити це посилання.';

  @override
  String get mapsCouldNotOpen => 'Не вдалося відкрити Maps.';

  @override
  String get decision => 'Рішення';

  @override
  String get duplicateForAnotherDay => 'Створити копію для іншого дня';

  @override
  String get swipeToVote => 'Гортайте, щоб голосувати';

  @override
  String get noRestaurantsAdded => 'Ресторани ще не додано.';

  @override
  String get aroundTable => 'За столом';

  @override
  String get couldNotLoadGroup => 'Не вдалося завантажити компанію.';

  @override
  String get couldNotLoadNotes => 'Не вдалося завантажити нотатки.';

  @override
  String get theGroupDecision => 'СПІЛЬНИЙ ВИБІР';

  @override
  String get weAreGoingTo => 'МИ ЙДЕМО ДО';

  @override
  String get tableStillOpen => 'Вибір ще не зроблено';

  @override
  String get openInMaps => 'Відкрити в Maps';

  @override
  String get addToCalendar => 'Додати до календаря';

  @override
  String get website => 'Вебсайт';

  @override
  String votesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count голосу',
      many: '$count голосів',
      few: '$count голоси',
      one: '$count голос',
    );
    return '$_temp0';
  }

  @override
  String get currentVote => 'Ваш поточний голос';

  @override
  String voteForOption(String title) {
    return 'Проголосувати за «$title»';
  }

  @override
  String get openInMapsTooltip => 'Відкрити в Maps';

  @override
  String get openWebsiteTooltip => 'Відкрити вебсайт';

  @override
  String get guest => 'Гість';

  @override
  String calendarEventTitle(String roomName) {
    return 'Bite Brigade · $roomName';
  }

  @override
  String get calendarDecisionMade => 'Рішення прийнято в Bite Brigade.';

  @override
  String calendarWinnerPicked(String title) {
    return 'Ми обрали $title.';
  }

  @override
  String get back => 'Назад';

  @override
  String get nobodyBlocked => 'Нікого не заблоковано';

  @override
  String get blockPeopleHowTo =>
      'Щоб заблокувати людину, відкрийте спільний план зустрічі, меню ⋮ у її рядку та натисніть «Заблокувати».';

  @override
  String get blockedPeopleCannotInvite =>
      'Ці люди не можуть запрошувати вас, і ви не бачите спільних планів зустрічей.';

  @override
  String get notToldTheyAreBlocked => 'Їм не повідомляють про блокування.';

  @override
  String get blockedListLoadError =>
      'Не вдалося завантажити список заблокованих людей';

  @override
  String get blockedListPermissionError =>
      'Ваш обліковий запис не має доступу до цього списку. Якщо проблема не зникне, оновіть застосунок.';

  @override
  String get tryAgain => 'Спробувати ще раз';

  @override
  String blockUserTitle(String name) {
    return 'Заблокувати $name?';
  }

  @override
  String get blockUserExplanation =>
      'Ви більше не бачитимете вміст одне одного. Людину буде вилучено зі спільних планів зустрічей, запрошення між вами скасовано, і вона не зможе запросити вас знову. Їй не повідомлять про це.';

  @override
  String get blockUndoTip =>
      'Блокування можна скасувати в Налаштуваннях → Заблоковані люди.';

  @override
  String get blocking => 'Блокуємо…';

  @override
  String get block => 'Заблокувати';

  @override
  String get undo => 'Скасувати';

  @override
  String personBlocked(String name) {
    return '$name заблоковано.';
  }

  @override
  String get blockUndoFailed =>
      'Не вдалося скасувати блокування. Спробуйте ще раз.';

  @override
  String get blockSavePermissionError =>
      'Не вдалося зберегти блокування. Увійдіть знову та повторіть спробу.';

  @override
  String get blockSaveNetworkError =>
      'Немає з’єднання. Перевірте мережу та спробуйте ще раз.';

  @override
  String blockSaveError(String name) {
    return 'Не вдалося заблокувати $name. Спробуйте ще раз.';
  }

  @override
  String personUnblocked(String name) {
    return '$name більше не заблоковано. Доступ до планів зустрічей не відновлено.';
  }

  @override
  String get weReadEveryMessage => 'Ми читаємо кожне повідомлення';

  @override
  String supportIntroduction(String responseTime) {
    return 'Bite Brigade — незалежний застосунок. Найшвидше зв’язатися з розробником можна електронною поштою — окремої служби підтримки немає. Зазвичай ми відповідаємо $responseTime.';
  }

  @override
  String get supportResponseTime => 'протягом 2 робочих днів';

  @override
  String get commonQuestions => 'Поширені запитання';

  @override
  String get faqMissingPlansQuestion =>
      'Я ввійшов, але мої плани зустрічей зникли.';

  @override
  String get faqMissingPlansAnswer =>
      'Перевірте, чи ввійшли ви в обліковий запис, якому надіслали запрошення. Якщо план спільний із компанією, переконайтеся, що ви досі її учасник.';

  @override
  String get faqInviteeQuestion => 'Запрошена людина не бачить зустріч.';

  @override
  String get faqInviteeAnswer =>
      'Попросіть її ввійти з адресою, на яку надійшло запрошення, і прийняти його на екрані «Запрошення».';

  @override
  String get faqDeleteAccountQuestion => 'Як видалити обліковий запис і дані?';

  @override
  String get faqDeleteAccountAnswer =>
      'Відкрийте Налаштування > Видалити обліковий запис і виконайте кроки підтвердження. Якщо не можете ввійти, зверніться до підтримки з адреси електронної пошти свого облікового запису.';

  @override
  String get faqWhoSeesRoomQuestion => 'Хто бачить мою зустріч?';

  @override
  String get faqWhoSeesRoomAnswer =>
      'Подробиці бачать автор зустрічі та учасники, які прийняли запрошення. Учасники компанії також бачать зустрічі, якими поділилися з компанією.';

  @override
  String get faqDataQuestion =>
      'Чи продаєте ви мої дані або показуєте рекламу?';

  @override
  String get faqDataAnswer =>
      'Інформація про зустрічі зберігається в налаштованому проєкті Firebase і доступна обраним вами учасникам або компанії. Докладніше — у політиці конфіденційності.';

  @override
  String get supportContactNote =>
      'Питання щодо повернення коштів, оплати та збоїв надсилайте на ту саму адресу. Якщо застосунок працює неправильно, зазначте пристрій і свої дії — це дуже допоможе.';

  @override
  String get emailSupport => 'Написати в службу підтримки';

  @override
  String supportEmailCopied(String email) {
    return 'Скопійовано $email';
  }

  @override
  String get openMail => 'Відкрити пошту';

  @override
  String get linkCopiedClipboard => 'Посилання скопійовано в буфер обміну.';

  @override
  String get nothingWaitingForYou => 'Немає нових запрошень.';

  @override
  String get invitationsEmptyDescription =>
      'Тут з’являтимуться запрошення до планів харчування й компаній. На більшість потрібно відповісти; до компаній із двох людей додають автоматично.';

  @override
  String get waitingOnYou => 'Очікують на вашу відповідь';

  @override
  String get invitationsSummary =>
      'Приєднайтеся до плану харчування, щоб допомогти обрати місце, або до компанії, щоб планувати разом. Якщо відхилите запрошення, запрошувач про це дізнається.';

  @override
  String get signInToSeeInvitations => 'Увійдіть, щоб переглянути запрошення';

  @override
  String get invitationsSignInDescription =>
      'Запрошення надсилаються на вашу електронну адресу. Увійдіть за адресою, на яку вас запросили.';

  @override
  String get dinnerDecisions => 'Вибір місця зустрічі';

  @override
  String get invitedToChoosePlace =>
      'Вас запросили разом обрати місце для зустрічі.';

  @override
  String get joinDecision => 'Приєднатися до вибору';

  @override
  String get twoPersonBadge => 'ДВОЄ';

  @override
  String get joinTwoPersonCrewDescription =>
      'Приєднайтеся до компанії з двох людей, щоб автоматично ділитися планами зустрічей.';

  @override
  String get joinCrewDescription =>
      'Приєднайтеся до компанії, щоб бачити плани зустрічей і долучатися до них.';

  @override
  String get joinCrew => 'Приєднатися до компанії';

  @override
  String get invitationLoadError =>
      'Не вдалося завантажити запрошення. Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get couldNotRespondInvitation =>
      'Не вдалося відповісти на запрошення. Спробуйте ще раз.';

  @override
  String get roleAdmin => 'Адміністратор';

  @override
  String get roleEditor => 'Редактор';

  @override
  String get roleViewer => 'Переглядач';

  @override
  String get decline => 'Відхилити';

  @override
  String get cancel => 'Скасувати';

  @override
  String get yourCrews => 'Ваші компанії';

  @override
  String get createCrew => 'Створити компанію';

  @override
  String get couldNotLoadCrews => 'Не вдалося завантажити ваші компанії.';

  @override
  String get goodThingsShared => 'Радісні миті приємніше розділяти.';

  @override
  String get bringPeopleTogether =>
      'Зберіть друзів, рідних або колег і сплануйте наступну зустріч.';

  @override
  String membersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count учасника',
      many: '$count учасників',
      few: '$count учасники',
      one: '$count учасник',
    );
    return '$_temp0';
  }

  @override
  String get crewNameRequired => 'Назвіть компанію.';

  @override
  String get couldNotCreateCrew =>
      'Не вдалося створити компанію. Спробуйте ще раз.';

  @override
  String get gatherYourCrew => 'Зберіть свою компанію.';

  @override
  String get inviteEveryoneOnce =>
      'Запросіть усіх один раз, а потім плануйте спільні зустрічі, коли забажаєте.';

  @override
  String get mark => 'Позначка';

  @override
  String get crewName => 'Назва компанії';

  @override
  String get crewNameHint => 'П’ятничні друзі';

  @override
  String get twoPersonCrewTitle => 'Лише ми вдвох';

  @override
  String get twoPersonCrewDescription =>
      'Діліться планами зустрічей автоматично.';

  @override
  String get crewCreated => 'Компанію створено.';

  @override
  String get crewInvitationSent => 'Запрошення до компанії надіслано.';

  @override
  String get couldNotSendCrewInvitation =>
      'Не вдалося надіслати запрошення. Спробуйте ще раз.';

  @override
  String get couldNotRenameCrew =>
      'Не вдалося перейменувати компанію. Спробуйте ще раз.';

  @override
  String get couldNotChangeCrewRole =>
      'Не вдалося змінити роль учасника. Спробуйте ще раз.';

  @override
  String get couldNotRemoveCrewMember =>
      'Не вдалося вилучити цю людину з компанії. Спробуйте ще раз.';

  @override
  String get couldNotDeleteCrew =>
      'Не вдалося видалити компанію. Спробуйте ще раз.';

  @override
  String get couldNotUpdateCrewAfterBlock =>
      'Цю людину заблоковано, але не вдалося оновити доступ до компанії. Спробуйте вилучити її ще раз.';

  @override
  String get crewRoleAppliesToFutureDecisions =>
      'Роль учасника застосовується до нових рішень, якими діляться з цією компанією.';

  @override
  String get blockCrewMemberExplanation =>
      'Цю людину буде заблоковано. Якщо ви власник компанії, її буде вилучено; інакше ви залишите компанію. Прямий доступ до інших планів харчування не зміниться.';

  @override
  String leaveNamedCrew(String name) {
    return 'Вийти з компанії «$name»?';
  }

  @override
  String get leaveCrewDescription =>
      'Ви більше не бачитимете нові рішення, якими діляться з цією компанією.';

  @override
  String get stay => 'Залишитися';

  @override
  String get leaveCrew => 'Вийти з компанії';

  @override
  String get couldNotLeaveCrew =>
      'Не вдалося вийти з компанії. Спробуйте ще раз.';

  @override
  String get crew => 'Компанія';

  @override
  String get crewUnavailable => 'Ця компанія більше недоступна.';

  @override
  String get renameCrew => 'Перейменувати компанію';

  @override
  String get twoPersonCrew => 'Компанія з двох людей';

  @override
  String get standingCrew => 'Постійна компанія';

  @override
  String get mealPlansSharedAutomatically =>
      'Плани зустрічей автоматично доступні одне одному.';

  @override
  String get sharePlansWithCrew =>
      'Діліться планами зустрічей із компанією, коли плануєте разом.';

  @override
  String get members => 'Учасники';

  @override
  String get invite => 'Запросити';

  @override
  String get owner => 'ВЛАСНИК';

  @override
  String get leaveThisCrew => 'Вийти з компанії';

  @override
  String get inviteToYourCrew => 'Запросити до компанії';

  @override
  String get emailAddress => 'Електронна пошта';

  @override
  String get sendInvitation => 'Надіслати запрошення';

  @override
  String get save => 'Зберегти';

  @override
  String get couldNotLoadCrew => 'Не вдалося завантажити цю компанію.';

  @override
  String get couldNotLoadCrewMembers =>
      'Не вдалося завантажити учасників компанії.';

  @override
  String get accept => 'Прийняти';

  @override
  String get mealPlanInvitation => 'Запрошення до плану харчування';

  @override
  String get unnamedMealPlan => 'План харчування';

  @override
  String mealPlanInvitationBody(String role) {
    return 'Вас запросили до цього плану харчування. Після прийняття він з’явиться у вашому списку з роллю «$role».';
  }

  @override
  String get joinMealPlanQuestion => 'Приєднатися до цього плану харчування?';

  @override
  String get joinMealPlanExplanation =>
      'Він з’явиться у вашому списку, щоб вам було легко знайти дату й деталі.';

  @override
  String get join => 'Приєднатися';

  @override
  String alreadyMemberOf(String name) {
    return 'Ви вже є учасником «$name».';
  }

  @override
  String joinedNamedMealPlan(String name) {
    return 'Ви приєдналися до «$name».';
  }

  @override
  String get invitationDeclined => 'Запрошення відхилено.';

  @override
  String get twoPersonGroupInvitation => 'Запрошення до групи з двох';

  @override
  String get crewInvitation => 'Запрошення до компанії';

  @override
  String addingYouToCrew(String name) {
    return 'Вас додають до компанії $name.';
  }

  @override
  String invitedYouToNamedCrew(String inviter, String crew) {
    return '$inviter запросив вас до «$crew».';
  }

  @override
  String automaticCrewInvitationBody(String crew) {
    return 'Вас буде додано автоматично. Майбутні плани харчування, якими поділяться з «$crew», з’являться у вашому списку.';
  }

  @override
  String namedCrewInvitationBody(String crew) {
    return 'Приєднайтеся до «$crew», щоб бачити плани харчування, якими компанія ділиться з вами.';
  }

  @override
  String get couldNotAddYouAutomatically =>
      'Не вдалося додати вас автоматично.';

  @override
  String get retryAddingYou => 'Спробувати додати ще раз';

  @override
  String get notNow => 'Не зараз';

  @override
  String alreadyMemberOfCrew(String crew) {
    return 'Ви вже є учасником «$crew».';
  }

  @override
  String addedToNamedCrew(String crew) {
    return 'Вас додано до «$crew».';
  }

  @override
  String joinedNamedCrew(String crew) {
    return 'Ви приєдналися до «$crew».';
  }

  @override
  String get someone => 'Хтось';

  @override
  String get you => 'Ви';

  @override
  String get noCrewsYet => 'Компаній поки немає';

  @override
  String get remove => 'Вилучити';

  @override
  String get removeFromCrew => 'Вилучити з компанії';

  @override
  String removeCrewMemberTitle(String name) {
    return 'Вилучити $name?';
  }

  @override
  String get removeCrewMemberExplanation =>
      'Ця людина більше не бачитиме плани харчування, якими діляться з компанією. Створені нею плани не буде видалено.';

  @override
  String deleteNamedCrew(String name) {
    return 'Видалити «$name»?';
  }

  @override
  String get deleteCrewExplanation =>
      'Компанію буде видалено. Плани харчування залишаться у вас, але більше не будуть доступні цим людям.';

  @override
  String inviteToNamedCrew(String name) {
    return 'Запросити до «$name»';
  }

  @override
  String get inviteToTwoPersonCrew => 'Запросити до компанії з двох';

  @override
  String get automaticCrewInviteExplanation =>
      'Якщо ця людина вже має обліковий запис, її буде додано автоматично. Інакше її додадуть після входу. Плани харчування, якими діляться з компанією, з’являтимуться автоматично.';

  @override
  String get crewInviteExplanation =>
      'Людина отримає запрошення, яке можна прийняти або відхилити. Після приєднання ви зможете ділитися планами харчування з компанією одним дотиком.';

  @override
  String get inviteEmailHint => 'friend@example.com';

  @override
  String get recentContactsLoadError =>
      'Не вдалося завантажити нещодавні контакти. Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get theyWillBeAddedAutomatically => 'Людину буде додано автоматично.';

  @override
  String invitationSentTo(String email) {
    return 'Запрошення надіслано на адресу $email.';
  }

  @override
  String leftNamedCrew(String name) {
    return 'Ви залишили «$name».';
  }

  @override
  String deletedNamedCrew(String name) {
    return '«$name» видалено.';
  }

  @override
  String get signInToUseCrews => 'Увійдіть, щоб користуватися компаніями';

  @override
  String get crewsSignInDescription =>
      'Учасників компаній запрошують електронною поштою, тому їм потрібен обліковий запис.';

  @override
  String get editMealPlan => 'Редагувати план харчування';

  @override
  String get createMealPlanAction => 'Створити план харчування';

  @override
  String get mealPlanActions => 'Дії з планом харчування';

  @override
  String get titleField => 'Назва';

  @override
  String get mealPlanTitleHint =>
      'П’ятнична вечеря, обід команди, сімейний бранч';

  @override
  String get descriptionField => 'Опис';

  @override
  String get mealPlanDescriptionHint =>
      'Додайте примітку про їжу, місце або план';

  @override
  String get when => 'Коли';

  @override
  String get date => 'Дата';

  @override
  String get oneWeek => '+1 тиждень';

  @override
  String get oneMonth => '+1 місяць';

  @override
  String get oneYear => '+1 рік';

  @override
  String get fiveYears => '+5 років';

  @override
  String get mealPlanTitleRequired => 'Укажіть назву плану харчування.';

  @override
  String get futureMomentRequired => 'Виберіть майбутній час.';

  @override
  String get signInToSaveMealPlans =>
      'Увійдіть, щоб зберігати плани харчування.';

  @override
  String get mealPlanCreated => 'План харчування створено.';

  @override
  String get changesSaved => 'Зміни збережено.';

  @override
  String get otherPerson => 'Інша людина';

  @override
  String coupleNotAdded(String name) {
    return 'План створено, але $name не додано. Запросіть цю людину вручну з плану.';
  }

  @override
  String coupleAdded(String name) {
    return 'План харчування створено. $name додано.';
  }

  @override
  String get nobodyAdded =>
      'План створено, але нікого не додано. Надішліть запрошення з плану.';

  @override
  String get viewOnlyMealPlan =>
      'Ви можете переглядати цей план харчування, але не змінювати його.';

  @override
  String get chooseFutureMealTime =>
      'Виберіть майбутній час, щоб побачити зворотний відлік.';

  @override
  String timeUntilMeal(String duration) {
    return 'До прийому їжі залишилося: $duration';
  }

  @override
  String get collaborators => 'Співавтори';

  @override
  String get inviteesAccessDescription =>
      'Запрошені люди зможуть переглядати цей план на своїх пристроях.';

  @override
  String get peopleWithAccess =>
      'Люди, які мають доступ до цього плану харчування.';

  @override
  String get noCollaboratorsYet => 'Поки що більше нікого.';

  @override
  String sharedWithNamedCrew(String name) {
    return 'Відкрито для компанії «$name»';
  }

  @override
  String get inviteAgain => 'Запросити ще раз';

  @override
  String get moreActions => 'Інші дії';

  @override
  String get changeRole => 'Змінити роль';

  @override
  String memberRoleUpdated(String name, String role) {
    return 'Тепер у $name роль «$role».';
  }

  @override
  String personRemoved(String name) {
    return '$name вилучено.';
  }

  @override
  String invitationAskedAgain(String email) {
    return '$email запрошено ще раз.';
  }

  @override
  String get removePersonQuestion => 'Вилучити цю людину?';

  @override
  String removePersonExplanation(String email) {
    return '$email втратить доступ до цього плану харчування й більше не бачитиме його у своєму списку.';
  }

  @override
  String changeRoleFor(String name) {
    return 'Змінити роль для $name';
  }

  @override
  String roleCurrentAccess(String role) {
    return 'Це змінює доступні дії з планом. Зараз у людини роль «$role».';
  }

  @override
  String rolesCannotBeAssigned(String roles, String role) {
    return 'Ви не можете призначити ролі «$roles», маючи роль «$role».';
  }

  @override
  String get and => 'і';

  @override
  String get adminRoleDescription =>
      'Може запрошувати людей, змінювати ролі, редагувати план і вилучати співавторів.';

  @override
  String get editorRoleDescription =>
      'Може змінювати назву, опис і дату. Не може керувати людьми.';

  @override
  String get viewerRoleDescription => 'Може лише переглядати план харчування.';

  @override
  String durationYearCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count року',
      many: '$count років',
      few: '$count роки',
      one: '$count рік',
    );
    return '$_temp0';
  }

  @override
  String durationMonthCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count місяця',
      many: '$count місяців',
      few: '$count місяці',
      one: '$count місяць',
    );
    return '$_temp0';
  }

  @override
  String durationDayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count днів',
      few: '$count дні',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String durationHourCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count години',
      many: '$count годин',
      few: '$count години',
      one: '$count година',
    );
    return '$_temp0';
  }

  @override
  String durationMinuteCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count хвилини',
      many: '$count хвилин',
      few: '$count хвилини',
      one: '$count хвилина',
    );
    return '$_temp0';
  }

  @override
  String durationSecondCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count секунди',
      many: '$count секунд',
      few: '$count секунди',
      one: '$count секунда',
    );
    return '$_temp0';
  }

  @override
  String get momentHasPassed => 'Цей момент уже минув.';

  @override
  String get couldNotSaveMealPlan =>
      'Не вдалося зберегти план харчування. Спробуйте ще раз.';

  @override
  String get savePermissionError =>
      'Ваш обліковий запис не може зберегти цей план. Оновіть застосунок і спробуйте ще раз.';

  @override
  String get saveNetworkError =>
      'Не вдалося підключитися до служби. Перевірте з’єднання та спробуйте ще раз.';

  @override
  String get unblock => 'Розблокувати';

  @override
  String get upcoming => 'Незабаром';

  @override
  String get invitationAcceptedState => 'Прийнято';

  @override
  String get invitationDeclinedState => 'Відхилено';

  @override
  String get invitationRemovedState => 'Вилучено';

  @override
  String get invitationReopenedState => 'Повторно відкрито';

  @override
  String get invitationWaitingState => 'Очікування';

  @override
  String get sharedCrewInviteInfo =>
      'Компанії з двох людей діляться планами автоматично. До інших компаній надсилається запрошення.';

  @override
  String get shareWith => 'Поділитися з';

  @override
  String get arrived => 'Цей момент настав.';

  @override
  String countdownToGo(String duration) {
    return 'Залишилося: $duration';
  }

  @override
  String get deleteAccount => 'Видалити обліковий запис';

  @override
  String get deleteAccountWarning =>
      'Цю дію неможливо скасувати. Усі ваші плани харчування, компанії та дані буде видалено назавжди.';

  @override
  String get deleteAccountConfirmationPrompt =>
      'Введіть точну електронну адресу облікового запису, щоб продовжити.';

  @override
  String get deleteAccountConfirmationLabel =>
      'Електронна адреса облікового запису';

  @override
  String get deleteAccountProfileConsequence =>
      'Ваш профіль буде видалено назавжди.';

  @override
  String get deleteAccountAccessConsequence =>
      'Ви втратите доступ до всіх своїх планів харчування й компаній.';

  @override
  String get deleteAccountIrreversibleConsequence =>
      'Цю дію неможливо скасувати.';

  @override
  String get deleteAccountPermanentlyAction =>
      'Видалити обліковий запис назавжди';

  @override
  String get accountDeletionReauthRequired =>
      'З міркувань безпеки увійдіть знову й повторіть спробу видалення облікового запису.';

  @override
  String get accountDeleted => 'Обліковий запис успішно видалено.';

  @override
  String get serverTimedOutTryAgain =>
      'Час очікування відповіді сервера минув. Спробуйте ще раз пізніше.';

  @override
  String get accountDeletionFailed =>
      'Не вдалося видалити обліковий запис. Спробуйте ще раз.';

  @override
  String get accountDeletedCleanupWarning =>
      'Обліковий запис видалено, але не вдалося очистити деякі локальні налаштування. Перезапустіть застосунок, перш ніж увійти в інший обліковий запис.';
}
