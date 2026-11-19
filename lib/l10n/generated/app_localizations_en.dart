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

  @override
  String get homeTitle => 'Plan a meal.';

  @override
  String get homeDescription =>
      'Choose where to eat, invite your crew, and decide together.';

  @override
  String get getStarted => 'Get started';

  @override
  String get createMealPlan => 'Create a meal plan';

  @override
  String get keepMealPlansSynced => 'Keep your meal plans in sync';

  @override
  String get syncMealPlansDescription =>
      'Sign in to keep meal plans in sync across devices and decide where to eat with your crew.';

  @override
  String get couldNotLoadMealPlans =>
      'Could not load your meal plans. Pull down to try again.';

  @override
  String get options => 'Options';

  @override
  String get open => 'Open';

  @override
  String get openMealPlan => 'Open meal plan';

  @override
  String get upcomingPlans => 'UPCOMING PLANS';

  @override
  String get newMealPlan => 'New meal plan';

  @override
  String get readyToGather => 'READY TO GATHER';

  @override
  String get comingUp => 'COMING UP';

  @override
  String get years => 'Years';

  @override
  String get months => 'Months';

  @override
  String get days => 'Days';

  @override
  String get hours => 'Hours';

  @override
  String minutesRemaining(int minutes, int seconds) {
    return '$minutes min · $seconds sec remaining';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navInvitations => 'Invitations';

  @override
  String get navCrews => 'Crews';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navSupport => 'Support';

  @override
  String get tableIsYours => 'THE TABLE IS YOURS';

  @override
  String get whereAreWeGoing => 'Where are we\ngoing?';

  @override
  String get groupDecisionDescription =>
      'Good meals start with a group decision.';

  @override
  String get newDecision => 'New decision';

  @override
  String get decisionsCouldNotLoad => 'Your decisions could not be loaded.';

  @override
  String get yourTable => 'Your table';

  @override
  String get noDecisions => 'No decisions on the table';

  @override
  String get noDecisionsDescription =>
      'Bring your people together and let everyone pick the place.';

  @override
  String get startDecision => 'Start a decision';

  @override
  String get roomOpen => 'OPEN';

  @override
  String get roomDecided => 'DECIDED';

  @override
  String get roomCancelled => 'CANCELLED';

  @override
  String votesProgress(int votesCast, int participantCount) {
    return '$votesCast of $participantCount voted';
  }

  @override
  String get createAccountHeading => 'Create your account';

  @override
  String get welcomeHeading => 'Welcome to Bite Brigade';

  @override
  String get createAccountDescription =>
      'Make dinner decisions together, on every device.';

  @override
  String get welcomeDescription =>
      'Count down to the moments that matter — on phone, tablet and web.';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'Alex Rivera';

  @override
  String get nameRequired => 'Tell us what to call you.';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get emailRequired => 'Enter your email.';

  @override
  String get emailInvalid => 'That does not look like an email.';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Enter your password.';

  @override
  String get passwordTooShort => 'Use at least 6 characters.';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signInServiceUnavailable =>
      'Could not reach the sign-in service. Check your connection.';

  @override
  String get createAccountAction => 'Create account';

  @override
  String get or => 'OR';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get newHere => 'New here?';

  @override
  String get createOne => 'Create one';

  @override
  String get signInTrouble => 'Trouble signing in? Get help';

  @override
  String get accountCreated => 'Account created.';

  @override
  String get welcomeBack => 'Welcome back.';

  @override
  String get signedInWithGoogle => 'Signed in with Google.';

  @override
  String get enterEmailForReset =>
      'Enter your email first, then tap “Forgot password”.';

  @override
  String resetLinkSent(String email) {
    return 'Reset link sent to $email.';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get moreOptions => 'More options';

  @override
  String get noReadMessages => 'No read messages to delete.';

  @override
  String get deleteReadMessages => 'Delete read messages';

  @override
  String get deletedReadMessages => 'Deleted read messages.';

  @override
  String get signInFirst => 'Sign in first';

  @override
  String get notificationsAccountOnly =>
      'Notifications are tied to your account.';

  @override
  String get couldNotLoad => 'Could not load';

  @override
  String get checkConnectionRetry => 'Check your connection and try again.';

  @override
  String get nothingYet => 'Nothing yet';

  @override
  String get notificationsEmpty =>
      'When something happens with your meal plans or invitations, it will show up here.';

  @override
  String get liveNotificationsUnavailable =>
      'Live notifications could not be loaded.';

  @override
  String get inbox => 'INBOX';

  @override
  String get invitationResponses => 'INVITATION RESPONSES';

  @override
  String get invitationResponsesUnavailable =>
      'Invitation responses could not be loaded.';

  @override
  String get circles => 'Circles';

  @override
  String get editDecision => 'Edit decision';

  @override
  String get setDecisionScene => 'Set the scene. We’ll take the votes.';

  @override
  String get keepDecisionUpdated => 'Keep the plan up to date.';

  @override
  String get decisionEditorDescription =>
      'Name the occasion, pick a time, and add places everyone can vote on.';

  @override
  String get decisionName => 'Decision name';

  @override
  String get decisionNameHint => 'Dinner Friday';

  @override
  String get decisionNameRequired => 'Add a name for your decision.';

  @override
  String get optionalContext => 'A little context (optional)';

  @override
  String get decisionContextHint => 'A birthday dinner, a team lunch…';

  @override
  String get decisionTime => 'Decision time';

  @override
  String get shortlist => 'The shortlist';

  @override
  String get addTwoPlaces => 'Add at least two places.';

  @override
  String get shortlistLocked =>
      'Voting has started, so the shortlist is locked.';

  @override
  String get addRestaurant => 'Add a restaurant';

  @override
  String get shareWithCrew => 'Share with a crew';

  @override
  String get twoPersonCrewSharing =>
      'Two-person crews share plans automatically.';

  @override
  String get crewMembersCanVote =>
      'Crew members can vote without another invite.';

  @override
  String get createCrewFirst =>
      'Create a crew first to plan meals with a group.';

  @override
  String get inviteByEmailOptional => 'Invite people by email (optional)';

  @override
  String get inviteEmailsHint => 'alex@example.com, sam@example.com';

  @override
  String get createDecision => 'Create decision';

  @override
  String get saveChanges => 'Save changes';

  @override
  String restaurantNumber(int number) {
    return 'Restaurant $number';
  }

  @override
  String get restaurantExample => 'e.g. Northside Noodles';

  @override
  String get addName => 'Add a name.';

  @override
  String get removeRestaurant => 'Remove restaurant';

  @override
  String get addressOptional => 'Address (optional)';

  @override
  String get websiteOptional => 'Website (optional)';

  @override
  String get couldNotSaveDecision => 'Could not save this decision.';

  @override
  String get castYourVote => 'Cast your vote';

  @override
  String get swipeMode => 'Swipe';

  @override
  String get listMode => 'List';

  @override
  String get swipeRightToPick => 'Swipe right to pick it. Swipe left to pass.';

  @override
  String yourCurrentPick(String title) {
    return 'Your current pick: $title';
  }

  @override
  String get pass => 'Pass';

  @override
  String get vote => 'Vote';

  @override
  String youVotedFor(String title) {
    return 'You voted for $title.';
  }

  @override
  String get backToDecision => 'Back to decision';

  @override
  String get yesLetsGo => 'YES, LET’S GO';

  @override
  String get maybeNextTime => 'MAYBE NEXT TIME';

  @override
  String get onTheMenu => 'ON THE MENU';

  @override
  String get rightToVoteLeftToPass => 'Right to vote · left to pass';

  @override
  String get yourVote => 'Your vote';

  @override
  String get decisionUnavailable => 'This decision is no longer available.';

  @override
  String get acceptInvitationBeforeVote =>
      'Accept the invitation before casting a vote.';

  @override
  String get restaurantsUnavailable => 'Could not load restaurants.';

  @override
  String get noRestaurantsYet => 'There are no restaurants to vote on yet.';

  @override
  String get always => 'always';

  @override
  String get couldNotLoadRoom =>
      'Could not load this decision. Check your connection and try again.';

  @override
  String get voteCouldNotSave =>
      'Your vote could not be saved. Check your connection and try again.';

  @override
  String get eventUnavailable => 'This meal plan is no longer available.';

  @override
  String get share => 'Share';

  @override
  String get edit => 'Edit';

  @override
  String get viewDetails => 'View details';

  @override
  String get sharedWith => 'SHARED WITH';

  @override
  String get notes => 'NOTES';

  @override
  String get notesEmpty =>
      'Nothing yet. Leave a thought for everyone planning with you.';

  @override
  String get addNote => 'Add a note';

  @override
  String get dayHasCome => 'THE DAY HAS COME';

  @override
  String arrivalWithoutDescription(String title) {
    return '$title is here — enjoy every minute of it.';
  }

  @override
  String arrivalWithDescription(String title, String description) {
    return '$title is here — $description';
  }

  @override
  String get passed => 'Passed';

  @override
  String get countingDown => 'Counting down';

  @override
  String get duplicateYearLater => 'Duplicate a year later';

  @override
  String get duplicateEventSuccess =>
      'Duplicated — open it to adjust the date.';

  @override
  String get deleteMealPlan => 'Delete meal plan';

  @override
  String get deleteOwnerOnly => 'Only the owner can delete this meal plan.';

  @override
  String get mealPlanDeleted => 'Meal plan deleted.';

  @override
  String get couldNotDelete => 'Could not delete. Try again.';

  @override
  String get deleteMealPlanConfirm => 'Delete this meal plan?';

  @override
  String get mealPlanCannotRecover => 'This meal plan cannot be recovered.';

  @override
  String get keep => 'Keep';

  @override
  String get delete => 'Delete';

  @override
  String get cancelDecisionConfirm => 'Cancel this decision?';

  @override
  String get roomKeptInHistory => 'The room will be kept in the history.';

  @override
  String get keepIt => 'Keep it';

  @override
  String get cancelDecision => 'Cancel decision';

  @override
  String get couldNotRevealWinner => 'Could not reveal the winner.';

  @override
  String get couldNotAddNote => 'Could not add your note.';

  @override
  String get couldNotDuplicateDecision => 'Could not duplicate this decision.';

  @override
  String get couldNotCancelDecision => 'Could not cancel this decision.';

  @override
  String get linkCouldNotOpen => 'This link could not be opened.';

  @override
  String get mapsCouldNotOpen => 'Maps could not be opened.';

  @override
  String get decision => 'Decision';

  @override
  String get duplicateForAnotherDay => 'Duplicate for another day';

  @override
  String get swipeToVote => 'Swipe to vote';

  @override
  String get noRestaurantsAdded => 'No restaurants have been added yet.';

  @override
  String get aroundTable => 'Around the table';

  @override
  String get couldNotLoadGroup => 'Could not load the group.';

  @override
  String get couldNotLoadNotes => 'Could not load notes.';

  @override
  String get theGroupDecision => 'THE GROUP DECISION';

  @override
  String get weAreGoingTo => 'WE’RE GOING TO';

  @override
  String get tableStillOpen => 'The table is still open';

  @override
  String get openInMaps => 'Open in Maps';

  @override
  String get addToCalendar => 'Add to calendar';

  @override
  String get website => 'Website';

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
  String get currentVote => 'Your current vote';

  @override
  String voteForOption(String title) {
    return 'Vote for $title';
  }

  @override
  String get openInMapsTooltip => 'Open in Maps';

  @override
  String get openWebsiteTooltip => 'Open website';

  @override
  String get guest => 'Guest';

  @override
  String calendarEventTitle(String roomName) {
    return 'Bite Brigade · $roomName';
  }

  @override
  String get calendarDecisionMade => 'Decision made with Bite Brigade.';

  @override
  String calendarWinnerPicked(String title) {
    return 'We picked $title.';
  }

  @override
  String get back => 'Back';

  @override
  String get nobodyBlocked => 'Nobody is blocked';

  @override
  String get blockPeopleHowTo =>
      'To block someone, open a meal plan you share with them, open the ⋮ menu on their row, and tap Block.';

  @override
  String get blockedPeopleCannotInvite =>
      'These people cannot invite you, and you do not share any meal plans with them.';

  @override
  String get notToldTheyAreBlocked => 'They are not told they are blocked.';

  @override
  String get blockedListLoadError => 'Could not load your blocked list';

  @override
  String get blockedListPermissionError =>
      'Your account is not allowed to read this list. If this keeps happening, update the app.';

  @override
  String get tryAgain => 'Try again';

  @override
  String blockUserTitle(String name) {
    return 'Block $name?';
  }

  @override
  String get blockUserExplanation =>
      'You will stop seeing each other. They are removed from every meal plan you share, invitations between you are cancelled, and they cannot invite you again. They are not told.';

  @override
  String get blockUndoTip =>
      'You can undo this any time in Settings → Blocked people.';

  @override
  String get blocking => 'Blocking…';

  @override
  String get block => 'Block';

  @override
  String get undo => 'Undo';

  @override
  String personBlocked(String name) {
    return '$name is blocked.';
  }

  @override
  String get blockUndoFailed => 'Could not undo block. Please try again.';

  @override
  String get blockSavePermissionError =>
      'Your block could not be saved. Sign in again and retry.';

  @override
  String get blockSaveNetworkError =>
      'No connection. Check your network and try again.';

  @override
  String blockSaveError(String name) {
    return 'Could not block $name. Please try again.';
  }

  @override
  String personUnblocked(String name) {
    return '$name is unblocked. Meal plan access was not restored.';
  }

  @override
  String get weReadEveryMessage => 'We read every message';

  @override
  String supportIntroduction(String responseTime) {
    return 'Bite Brigade is an independent app. Email is the fastest way to reach the person who builds it — there is no support desk in between. We usually reply $responseTime.';
  }

  @override
  String get supportResponseTime => 'within 2 business days';

  @override
  String get commonQuestions => 'Common questions';

  @override
  String get faqMissingPlansQuestion =>
      'I signed in but my dinner rooms are missing.';

  @override
  String get faqMissingPlansAnswer =>
      'Check that you signed in with the account invited to those rooms. For a crew-shared room, confirm you are still a member of that crew.';

  @override
  String get faqInviteeQuestion => 'Someone I invited cannot see the room.';

  @override
  String get faqInviteeAnswer =>
      'Ask them to sign in with the email address that received the invitation and accept it from the Invitations screen.';

  @override
  String get faqDeleteAccountQuestion =>
      'How do I delete my account and my data?';

  @override
  String get faqDeleteAccountAnswer =>
      'Email us from the address you signed up with and ask about deleting your account or information. Requests are handled subject to identity verification and applicable law.';

  @override
  String get faqWhoSeesRoomQuestion => 'Who can see my room?';

  @override
  String get faqWhoSeesRoomAnswer =>
      'The room creator and accepted participants can see its details. Rooms shared with a crew are also visible to that crew’s members.';

  @override
  String get faqDataQuestion => 'Do you sell my data or show ads?';

  @override
  String get faqDataAnswer =>
      'Room information is stored in the configured Firebase project and shared with the participants or crew you choose. Read the privacy policy for details.';

  @override
  String get supportContactNote =>
      'A refund, a billing question or a crash report all belong at the same address. If the app misbehaves, telling us your device and what you were doing when it happened is the single most useful thing you can include.';

  @override
  String get emailSupport => 'Email support';

  @override
  String supportEmailCopied(String email) {
    return '$email copied';
  }

  @override
  String get openMail => 'Open mail';

  @override
  String get linkCopiedClipboard => 'Link copied to your clipboard.';

  @override
  String get nothingWaitingForYou => 'Nothing waiting for you.';

  @override
  String get invitationsEmptyDescription =>
      'Meal-plan and crew invitations will appear here. Most need your response; two-person groups are added automatically.';

  @override
  String get waitingOnYou => 'Waiting on you';

  @override
  String get invitationsSummary =>
      'Join a meal plan to help choose where to eat, or join a crew to plan meals together. If you decline, the person who invited you will know.';

  @override
  String get signInToSeeInvitations => 'Sign in to see invitations';

  @override
  String get invitationsSignInDescription =>
      'Invitations are addressed to your email, so sign in with the address someone invited.';

  @override
  String get dinnerDecisions => 'Dinner decisions';

  @override
  String get invitedToChoosePlace =>
      'You’re invited to help decide where the group will eat.';

  @override
  String get joinDecision => 'Join decision';

  @override
  String get twoPersonBadge => 'TWO-PERSON';

  @override
  String get joinTwoPersonCrewDescription =>
      'Join this two-person crew to share future meal plans automatically.';

  @override
  String get joinCrewDescription =>
      'Join this crew to receive and shape future meal plans.';

  @override
  String get joinCrew => 'Join crew';

  @override
  String get invitationLoadError =>
      'Invitations could not be loaded. Check your connection and try again.';

  @override
  String get couldNotRespondInvitation =>
      'Could not respond to this invitation. Try again.';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleEditor => 'Editor';

  @override
  String get roleViewer => 'Viewer';

  @override
  String get decline => 'Decline';

  @override
  String get cancel => 'Cancel';

  @override
  String get yourCrews => 'Your crews';

  @override
  String get createCrew => 'Create a crew';

  @override
  String get couldNotLoadCrews => 'Your crews could not be loaded.';

  @override
  String get goodThingsShared => 'Good things are better shared.';

  @override
  String get bringPeopleTogether =>
      'Bring friends, family, or teammates together to plan your next meal.';

  @override
  String membersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '$count member',
    );
    return '$_temp0';
  }

  @override
  String get crewNameRequired => 'Give your crew a name.';

  @override
  String get couldNotCreateCrew => 'Could not create this crew. Try again.';

  @override
  String get gatherYourCrew => 'Gather your crew.';

  @override
  String get inviteEveryoneOnce =>
      'Invite everyone once, then plan meals together whenever you are ready to eat.';

  @override
  String get mark => 'Mark';

  @override
  String get crewName => 'Crew name';

  @override
  String get crewNameHint => 'Friday regulars';

  @override
  String get twoPersonCrewTitle => 'Just the two of us';

  @override
  String get twoPersonCrewDescription =>
      'Share meal plans with each other automatically.';

  @override
  String get crewCreated => 'Crew created.';

  @override
  String get crewInvitationSent => 'Crew invitation sent.';

  @override
  String get couldNotSendCrewInvitation =>
      'Could not send this invitation. Try again.';

  @override
  String get couldNotRenameCrew => 'Could not rename this crew. Try again.';

  @override
  String leaveNamedCrew(String name) {
    return 'Leave $name?';
  }

  @override
  String get leaveCrewDescription =>
      'You will stop seeing new decisions shared with this crew.';

  @override
  String get stay => 'Stay';

  @override
  String get leaveCrew => 'Leave crew';

  @override
  String get couldNotLeaveCrew => 'Could not leave this crew. Try again.';

  @override
  String get crew => 'Crew';

  @override
  String get crewUnavailable => 'This crew is no longer available.';

  @override
  String get renameCrew => 'Rename crew';

  @override
  String get twoPersonCrew => 'Two-person crew';

  @override
  String get standingCrew => 'Standing crew';

  @override
  String get mealPlansSharedAutomatically =>
      'Meal plans are shared automatically with each other.';

  @override
  String get sharePlansWithCrew =>
      'Share meal plans with this crew whenever you plan together.';

  @override
  String get members => 'Members';

  @override
  String get invite => 'Invite';

  @override
  String get owner => 'OWNER';

  @override
  String get leaveThisCrew => 'Leave this crew';

  @override
  String get inviteToYourCrew => 'Invite to your crew';

  @override
  String get emailAddress => 'Email address';

  @override
  String get sendInvitation => 'Send invitation';

  @override
  String get save => 'Save';

  @override
  String get couldNotLoadCrew => 'Could not load this crew.';

  @override
  String get couldNotLoadCrewMembers => 'Could not load crew members.';

  @override
  String get accept => 'Accept';

  @override
  String get mealPlanInvitation => 'Meal-plan invitation';

  @override
  String get unnamedMealPlan => 'A meal plan';

  @override
  String mealPlanInvitationBody(String role) {
    return 'You have been invited to join this meal plan. Accepting adds it to your list as $role.';
  }

  @override
  String get joinMealPlanQuestion => 'Join this meal plan?';

  @override
  String get joinMealPlanExplanation =>
      'It will appear in your list so the date and details are easy to find.';

  @override
  String get join => 'Join';

  @override
  String alreadyMemberOf(String name) {
    return 'You are already a member of “$name”.';
  }

  @override
  String joinedNamedMealPlan(String name) {
    return 'You joined “$name”.';
  }

  @override
  String get invitationDeclined => 'Invitation declined.';

  @override
  String get twoPersonGroupInvitation => 'Two-person group invitation';

  @override
  String get crewInvitation => 'Crew invitation';

  @override
  String addingYouToCrew(String name) {
    return 'You\'re being added to $name\'s crew.';
  }

  @override
  String invitedYouToNamedCrew(String inviter, String crew) {
    return '$inviter invited you to “$crew”.';
  }

  @override
  String automaticCrewInvitationBody(String crew) {
    return 'You will be added automatically. Future meal plans shared with “$crew” will appear in your list.';
  }

  @override
  String namedCrewInvitationBody(String crew) {
    return 'Join “$crew” to see the meal plans this crew shares with you.';
  }

  @override
  String get couldNotAddYouAutomatically =>
      'We could not add you automatically.';

  @override
  String get retryAddingYou => 'Retry adding you';

  @override
  String get notNow => 'Not now';

  @override
  String alreadyMemberOfCrew(String crew) {
    return 'You are already a member of “$crew”.';
  }

  @override
  String addedToNamedCrew(String crew) {
    return 'You were added to “$crew”.';
  }

  @override
  String joinedNamedCrew(String crew) {
    return 'You joined “$crew”.';
  }

  @override
  String get someone => 'Someone';

  @override
  String get you => 'You';

  @override
  String get noCrewsYet => 'No crews yet';

  @override
  String get remove => 'Remove';

  @override
  String get removeFromCrew => 'Remove from crew';

  @override
  String removeCrewMemberTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get removeCrewMemberExplanation =>
      'They will stop seeing meal plans shared with this crew. Nothing they created is deleted.';

  @override
  String deleteNamedCrew(String name) {
    return 'Delete “$name”?';
  }

  @override
  String get deleteCrewExplanation =>
      'The crew goes away. Meal plans shared with it are kept and stay yours — they are just no longer shared with these people.';

  @override
  String inviteToNamedCrew(String name) {
    return 'Invite to “$name”';
  }

  @override
  String get inviteToTwoPersonCrew => 'Invite to your two-person crew';

  @override
  String get automaticCrewInviteExplanation =>
      'If they already have an account, they will be added automatically. Otherwise, they will be added when they sign in. Meal plans shared with this crew will appear automatically.';

  @override
  String get crewInviteExplanation =>
      'They will get an invitation to accept or decline. After they join, you can share meal plans with this crew in one tap.';

  @override
  String get inviteEmailHint => 'friend@example.com';

  @override
  String get recentContactsLoadError =>
      'Recent contacts could not load. Check your connection and try again.';

  @override
  String get theyWillBeAddedAutomatically =>
      'They will be added automatically.';

  @override
  String invitationSentTo(String email) {
    return 'Invitation sent to $email.';
  }

  @override
  String leftNamedCrew(String name) {
    return 'You left “$name”.';
  }

  @override
  String deletedNamedCrew(String name) {
    return 'Deleted “$name”.';
  }

  @override
  String get signInToUseCrews => 'Sign in to use crews';

  @override
  String get crewsSignInDescription =>
      'Crews invite people by email, so they need an account to be invited.';

  @override
  String get editMealPlan => 'Edit meal plan';

  @override
  String get createMealPlanAction => 'Create meal plan';

  @override
  String get mealPlanActions => 'Meal plan actions';

  @override
  String get titleField => 'Title';

  @override
  String get mealPlanTitleHint => 'Friday dinner, team lunch, family brunch';

  @override
  String get descriptionField => 'Description';

  @override
  String get mealPlanDescriptionHint =>
      'Add a note about the meal, place, or plan';

  @override
  String get when => 'When';

  @override
  String get date => 'Date';

  @override
  String get oneWeek => '+1 week';

  @override
  String get oneMonth => '+1 month';

  @override
  String get oneYear => '+1 year';

  @override
  String get fiveYears => '+5 years';

  @override
  String get mealPlanTitleRequired => 'Give this meal plan a title.';

  @override
  String get futureMomentRequired => 'Pick a moment still ahead of you.';

  @override
  String get signInToSaveMealPlans => 'Sign in to save meal plans.';

  @override
  String get mealPlanCreated => 'Meal plan created.';

  @override
  String get changesSaved => 'Changes saved.';

  @override
  String get otherPerson => 'The other person';

  @override
  String coupleNotAdded(String name) {
    return 'Meal plan created, but $name was not added. Invite them manually from the plan.';
  }

  @override
  String coupleAdded(String name) {
    return 'Meal plan created. $name was added.';
  }

  @override
  String get nobodyAdded =>
      'Meal plan created, but no one was added. Invite them manually.';

  @override
  String get viewOnlyMealPlan =>
      'You can view this meal plan but not change it.';

  @override
  String get chooseFutureMealTime =>
      'Choose a future meal time to see the plan.';

  @override
  String timeUntilMeal(String duration) {
    return 'Time until your meal: $duration';
  }

  @override
  String get collaborators => 'Collaborators';

  @override
  String get inviteesAccessDescription =>
      'Anyone you invite can see this meal plan on their own devices.';

  @override
  String get peopleWithAccess => 'People with access to this meal plan.';

  @override
  String get noCollaboratorsYet => 'No one else yet.';

  @override
  String sharedWithNamedCrew(String name) {
    return 'Shared with $name';
  }

  @override
  String get inviteAgain => 'Invite again';

  @override
  String get moreActions => 'More actions';

  @override
  String get changeRole => 'Change role';

  @override
  String memberRoleUpdated(String name, String role) {
    return '$name is now $role.';
  }

  @override
  String personRemoved(String name) {
    return '$name was removed.';
  }

  @override
  String invitationAskedAgain(String email) {
    return 'Asked $email again.';
  }

  @override
  String get removePersonQuestion => 'Remove this person?';

  @override
  String removePersonExplanation(String email) {
    return '$email will lose access to this meal plan and will no longer see it in their list.';
  }

  @override
  String changeRoleFor(String name) {
    return 'Change role for $name';
  }

  @override
  String roleCurrentAccess(String role) {
    return 'This changes what they can do on this meal plan. They currently have $role access.';
  }

  @override
  String rolesCannotBeAssigned(String roles, String role) {
    return '$roles cannot be assigned by you — your role is $role.';
  }

  @override
  String get and => 'and';

  @override
  String get adminRoleDescription =>
      'Can invite people, change roles, edit the meal plan, and remove collaborators.';

  @override
  String get editorRoleDescription =>
      'Can edit the title, description, and date. Cannot manage people.';

  @override
  String get viewerRoleDescription => 'Can only view the meal plan.';

  @override
  String durationYearCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String durationMonthCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '$count month',
    );
    return '$_temp0';
  }

  @override
  String durationDayCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String durationHourCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '$count hour',
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
      other: '$count seconds',
      one: '$count second',
    );
    return '$_temp0';
  }

  @override
  String get momentHasPassed => 'The moment has passed.';

  @override
  String get couldNotSaveMealPlan =>
      'Could not save this meal plan. Please try again.';

  @override
  String get savePermissionError =>
      'Your account cannot save this meal plan. Update the app and try again.';

  @override
  String get saveNetworkError =>
      'Could not reach the service. Check your connection and try again.';

  @override
  String get unblock => 'Unblock';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get invitationAcceptedState => 'Accepted';

  @override
  String get invitationDeclinedState => 'Declined';

  @override
  String get invitationRemovedState => 'Removed';

  @override
  String get invitationReopenedState => 'Reopened';

  @override
  String get invitationWaitingState => 'Waiting';

  @override
  String get sharedCrewInviteInfo =>
      'Two-person crews share meal plans automatically. Other crews get an invitation.';

  @override
  String get shareWith => 'Share with';

  @override
  String get arrived => 'It has arrived.';

  @override
  String countdownToGo(String duration) {
    return '$duration to go';
  }
}
