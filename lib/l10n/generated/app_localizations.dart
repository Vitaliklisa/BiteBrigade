import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('uk'),
    Locale('zh'),
    Locale('zh', 'TW')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @followSystemLanguage.
  ///
  /// In en, this message translates to:
  /// **'Follow system language'**
  String get followSystemLanguage;

  /// No description provided for @languageSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save your language preference.'**
  String get languageSaveFailed;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageUkrainian.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get languageUkrainian;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languageChineseTaiwan.
  ///
  /// In en, this message translates to:
  /// **'Traditional Chinese (Taiwan)'**
  String get languageChineseTaiwan;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @biteBrigadeUser.
  ///
  /// In en, this message translates to:
  /// **'Bite Brigade member'**
  String get biteBrigadeUser;

  /// No description provided for @guestAccount.
  ///
  /// In en, this message translates to:
  /// **'Guest account'**
  String get guestAccount;

  /// No description provided for @mealPlansCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} meal plan} other{{count} meal plans}}'**
  String mealPlansCount(int count);

  /// No description provided for @notSignedIn.
  ///
  /// In en, this message translates to:
  /// **'You are not signed in'**
  String get notSignedIn;

  /// No description provided for @syncAndShareDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync meal plans across devices and plan with friends, family, and crews.'**
  String get syncAndShareDescription;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @timeFormatDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how meal times are shown. Your plans keep the exact time either way.'**
  String get timeFormatDescription;

  /// No description provided for @twelveHourFormat.
  ///
  /// In en, this message translates to:
  /// **'12-hour (AM/PM)'**
  String get twelveHourFormat;

  /// No description provided for @twentyFourHourFormat.
  ///
  /// In en, this message translates to:
  /// **'24-hour'**
  String get twentyFourHourFormat;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safety;

  /// No description provided for @blockedPeople.
  ///
  /// In en, this message translates to:
  /// **'Blocked people'**
  String get blockedPeople;

  /// No description provided for @legal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legal;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get termsOfService;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpAndSupport;

  /// No description provided for @signedOut.
  ///
  /// In en, this message translates to:
  /// **'Signed out.'**
  String get signedOut;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan a meal.'**
  String get homeTitle;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose where to eat, invite your crew, and decide together.'**
  String get homeDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted;

  /// No description provided for @createMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Create a meal plan'**
  String get createMealPlan;

  /// No description provided for @keepMealPlansSynced.
  ///
  /// In en, this message translates to:
  /// **'Keep your meal plans in sync'**
  String get keepMealPlansSynced;

  /// No description provided for @syncMealPlansDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep meal plans in sync across devices and decide where to eat with your crew.'**
  String get syncMealPlansDescription;

  /// No description provided for @couldNotLoadMealPlans.
  ///
  /// In en, this message translates to:
  /// **'Could not load your meal plans. Pull down to try again.'**
  String get couldNotLoadMealPlans;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @openMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Open meal plan'**
  String get openMealPlan;

  /// No description provided for @openDecision.
  ///
  /// In en, this message translates to:
  /// **'Open decision'**
  String get openDecision;

  /// No description provided for @upcomingPlans.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING PLANS'**
  String get upcomingPlans;

  /// No description provided for @newMealPlan.
  ///
  /// In en, this message translates to:
  /// **'New meal plan'**
  String get newMealPlan;

  /// No description provided for @readyToGather.
  ///
  /// In en, this message translates to:
  /// **'READY TO GATHER'**
  String get readyToGather;

  /// No description provided for @comingUp.
  ///
  /// In en, this message translates to:
  /// **'COMING UP'**
  String get comingUp;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @minutesRemaining.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min · {seconds} sec remaining'**
  String minutesRemaining(int minutes, int seconds);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navInvitations.
  ///
  /// In en, this message translates to:
  /// **'Invitations'**
  String get navInvitations;

  /// No description provided for @navCrews.
  ///
  /// In en, this message translates to:
  /// **'Crews'**
  String get navCrews;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @navSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get navSupport;

  /// No description provided for @tableIsYours.
  ///
  /// In en, this message translates to:
  /// **'THE TABLE IS YOURS'**
  String get tableIsYours;

  /// No description provided for @whereAreWeGoing.
  ///
  /// In en, this message translates to:
  /// **'Where are we\ngoing?'**
  String get whereAreWeGoing;

  /// No description provided for @groupDecisionDescription.
  ///
  /// In en, this message translates to:
  /// **'Good meals start with a group decision.'**
  String get groupDecisionDescription;

  /// No description provided for @newDecision.
  ///
  /// In en, this message translates to:
  /// **'New decision'**
  String get newDecision;

  /// No description provided for @decisionsCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Your decisions could not be loaded.'**
  String get decisionsCouldNotLoad;

  /// No description provided for @yourTable.
  ///
  /// In en, this message translates to:
  /// **'Your table'**
  String get yourTable;

  /// No description provided for @noDecisions.
  ///
  /// In en, this message translates to:
  /// **'No decisions on the table'**
  String get noDecisions;

  /// No description provided for @noDecisionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Bring your people together and let everyone pick the place.'**
  String get noDecisionsDescription;

  /// No description provided for @startDecision.
  ///
  /// In en, this message translates to:
  /// **'Start a decision'**
  String get startDecision;

  /// No description provided for @roomOpen.
  ///
  /// In en, this message translates to:
  /// **'OPEN'**
  String get roomOpen;

  /// No description provided for @roomDecided.
  ///
  /// In en, this message translates to:
  /// **'DECIDED'**
  String get roomDecided;

  /// No description provided for @roomCancelled.
  ///
  /// In en, this message translates to:
  /// **'CANCELLED'**
  String get roomCancelled;

  /// No description provided for @votesProgress.
  ///
  /// In en, this message translates to:
  /// **'{votesCast} of {participantCount} voted'**
  String votesProgress(int votesCast, int participantCount);

  /// No description provided for @createAccountHeading.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createAccountHeading;

  /// No description provided for @welcomeHeading.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Bite Brigade'**
  String get welcomeHeading;

  /// No description provided for @createAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Make dinner decisions together, on every device.'**
  String get createAccountDescription;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Count down to the moments that matter — on phone, tablet and web.'**
  String get welcomeDescription;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Alex Rivera'**
  String get nameHint;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Tell us what to call you.'**
  String get nameRequired;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your email.'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'That does not look like an email.'**
  String get emailInvalid;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 6 characters.'**
  String get passwordTooShort;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @signInServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the sign-in service. Check your connection.'**
  String get signInServiceUnavailable;

  /// No description provided for @createAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountAction;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @newHere.
  ///
  /// In en, this message translates to:
  /// **'New here?'**
  String get newHere;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get createOne;

  /// No description provided for @signInTrouble.
  ///
  /// In en, this message translates to:
  /// **'Trouble signing in? Get help'**
  String get signInTrouble;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created.'**
  String get accountCreated;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back.'**
  String get welcomeBack;

  /// No description provided for @signedInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Signed in with Google.'**
  String get signedInWithGoogle;

  /// No description provided for @enterEmailForReset.
  ///
  /// In en, this message translates to:
  /// **'Enter your email first, then tap “Forgot password”.'**
  String get enterEmailForReset;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Reset link sent to {email}.'**
  String resetLinkSent(String email);

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @moreOptions.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get moreOptions;

  /// No description provided for @noReadMessages.
  ///
  /// In en, this message translates to:
  /// **'No read messages to delete.'**
  String get noReadMessages;

  /// No description provided for @deleteReadMessages.
  ///
  /// In en, this message translates to:
  /// **'Delete read messages'**
  String get deleteReadMessages;

  /// No description provided for @deletedReadMessages.
  ///
  /// In en, this message translates to:
  /// **'Deleted read messages.'**
  String get deletedReadMessages;

  /// No description provided for @signInFirst.
  ///
  /// In en, this message translates to:
  /// **'Sign in first'**
  String get signInFirst;

  /// No description provided for @notificationsAccountOnly.
  ///
  /// In en, this message translates to:
  /// **'Notifications are tied to your account.'**
  String get notificationsAccountOnly;

  /// No description provided for @couldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load'**
  String get couldNotLoad;

  /// No description provided for @checkConnectionRetry.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get checkConnectionRetry;

  /// No description provided for @nothingYet.
  ///
  /// In en, this message translates to:
  /// **'Nothing yet'**
  String get nothingYet;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'When something happens with your meal plans or invitations, it will show up here.'**
  String get notificationsEmpty;

  /// No description provided for @liveNotificationsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Live notifications could not be loaded.'**
  String get liveNotificationsUnavailable;

  /// No description provided for @inbox.
  ///
  /// In en, this message translates to:
  /// **'INBOX'**
  String get inbox;

  /// No description provided for @invitationResponses.
  ///
  /// In en, this message translates to:
  /// **'INVITATION RESPONSES'**
  String get invitationResponses;

  /// No description provided for @invitationResponsesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Invitation responses could not be loaded.'**
  String get invitationResponsesUnavailable;

  /// No description provided for @circles.
  ///
  /// In en, this message translates to:
  /// **'Circles'**
  String get circles;

  /// No description provided for @editDecision.
  ///
  /// In en, this message translates to:
  /// **'Edit decision'**
  String get editDecision;

  /// No description provided for @setDecisionScene.
  ///
  /// In en, this message translates to:
  /// **'Set the scene. We’ll take the votes.'**
  String get setDecisionScene;

  /// No description provided for @keepDecisionUpdated.
  ///
  /// In en, this message translates to:
  /// **'Keep the plan up to date.'**
  String get keepDecisionUpdated;

  /// No description provided for @decisionEditorDescription.
  ///
  /// In en, this message translates to:
  /// **'Name the occasion, pick a time, and add places everyone can vote on.'**
  String get decisionEditorDescription;

  /// No description provided for @decisionName.
  ///
  /// In en, this message translates to:
  /// **'Decision name'**
  String get decisionName;

  /// No description provided for @decisionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Dinner Friday'**
  String get decisionNameHint;

  /// No description provided for @decisionNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Add a name for your decision.'**
  String get decisionNameRequired;

  /// No description provided for @optionalContext.
  ///
  /// In en, this message translates to:
  /// **'A little context (optional)'**
  String get optionalContext;

  /// No description provided for @decisionContextHint.
  ///
  /// In en, this message translates to:
  /// **'A birthday dinner, a team lunch…'**
  String get decisionContextHint;

  /// No description provided for @decisionTime.
  ///
  /// In en, this message translates to:
  /// **'Decision time'**
  String get decisionTime;

  /// No description provided for @shortlist.
  ///
  /// In en, this message translates to:
  /// **'The shortlist'**
  String get shortlist;

  /// No description provided for @addTwoPlaces.
  ///
  /// In en, this message translates to:
  /// **'Add at least two places.'**
  String get addTwoPlaces;

  /// No description provided for @shortlistLocked.
  ///
  /// In en, this message translates to:
  /// **'Voting has started, so the shortlist is locked.'**
  String get shortlistLocked;

  /// No description provided for @addRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Add a restaurant'**
  String get addRestaurant;

  /// No description provided for @shareWithCrew.
  ///
  /// In en, this message translates to:
  /// **'Share with a crew'**
  String get shareWithCrew;

  /// No description provided for @twoPersonCrewSharing.
  ///
  /// In en, this message translates to:
  /// **'Two-person crews are selected by default. Turn one off for this decision anytime.'**
  String get twoPersonCrewSharing;

  /// No description provided for @crewMembersCanVote.
  ///
  /// In en, this message translates to:
  /// **'Crew members can vote without another invite.'**
  String get crewMembersCanVote;

  /// No description provided for @createCrewFirst.
  ///
  /// In en, this message translates to:
  /// **'Create a crew first to plan meals with a group.'**
  String get createCrewFirst;

  /// No description provided for @inviteByEmailOptional.
  ///
  /// In en, this message translates to:
  /// **'Invite people by email (optional)'**
  String get inviteByEmailOptional;

  /// No description provided for @inviteEmailsHint.
  ///
  /// In en, this message translates to:
  /// **'alex@example.com, sam@example.com'**
  String get inviteEmailsHint;

  /// No description provided for @createDecision.
  ///
  /// In en, this message translates to:
  /// **'Create decision'**
  String get createDecision;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @restaurantNumber.
  ///
  /// In en, this message translates to:
  /// **'Restaurant {number}'**
  String restaurantNumber(int number);

  /// No description provided for @restaurantExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Northside Noodles'**
  String get restaurantExample;

  /// No description provided for @addName.
  ///
  /// In en, this message translates to:
  /// **'Add a name.'**
  String get addName;

  /// No description provided for @removeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Remove restaurant'**
  String get removeRestaurant;

  /// No description provided for @addressOptional.
  ///
  /// In en, this message translates to:
  /// **'Address (optional)'**
  String get addressOptional;

  /// No description provided for @websiteOptional.
  ///
  /// In en, this message translates to:
  /// **'Website (optional)'**
  String get websiteOptional;

  /// No description provided for @couldNotSaveDecision.
  ///
  /// In en, this message translates to:
  /// **'Could not save this decision.'**
  String get couldNotSaveDecision;

  /// No description provided for @castYourVote.
  ///
  /// In en, this message translates to:
  /// **'Cast your vote'**
  String get castYourVote;

  /// No description provided for @swipeMode.
  ///
  /// In en, this message translates to:
  /// **'Swipe'**
  String get swipeMode;

  /// No description provided for @listMode.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get listMode;

  /// No description provided for @swipeRightToPick.
  ///
  /// In en, this message translates to:
  /// **'Swipe right to pick it. Swipe left to pass.'**
  String get swipeRightToPick;

  /// No description provided for @yourCurrentPick.
  ///
  /// In en, this message translates to:
  /// **'Your current pick: {title}'**
  String yourCurrentPick(String title);

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get pass;

  /// No description provided for @vote.
  ///
  /// In en, this message translates to:
  /// **'Vote'**
  String get vote;

  /// No description provided for @youVotedFor.
  ///
  /// In en, this message translates to:
  /// **'You voted for {title}.'**
  String youVotedFor(String title);

  /// No description provided for @backToDecision.
  ///
  /// In en, this message translates to:
  /// **'Back to decision'**
  String get backToDecision;

  /// No description provided for @yesLetsGo.
  ///
  /// In en, this message translates to:
  /// **'YES, LET’S GO'**
  String get yesLetsGo;

  /// No description provided for @maybeNextTime.
  ///
  /// In en, this message translates to:
  /// **'MAYBE NEXT TIME'**
  String get maybeNextTime;

  /// No description provided for @onTheMenu.
  ///
  /// In en, this message translates to:
  /// **'ON THE MENU'**
  String get onTheMenu;

  /// No description provided for @rightToVoteLeftToPass.
  ///
  /// In en, this message translates to:
  /// **'Right to vote · left to pass'**
  String get rightToVoteLeftToPass;

  /// No description provided for @yourVote.
  ///
  /// In en, this message translates to:
  /// **'Your vote'**
  String get yourVote;

  /// No description provided for @decisionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This decision is no longer available.'**
  String get decisionUnavailable;

  /// No description provided for @acceptInvitationBeforeVote.
  ///
  /// In en, this message translates to:
  /// **'Accept the invitation before casting a vote.'**
  String get acceptInvitationBeforeVote;

  /// No description provided for @restaurantsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not load restaurants.'**
  String get restaurantsUnavailable;

  /// No description provided for @noRestaurantsYet.
  ///
  /// In en, this message translates to:
  /// **'There are no restaurants to vote on yet.'**
  String get noRestaurantsYet;

  /// No description provided for @always.
  ///
  /// In en, this message translates to:
  /// **'always'**
  String get always;

  /// No description provided for @couldNotLoadRoom.
  ///
  /// In en, this message translates to:
  /// **'Could not load this decision. Check your connection and try again.'**
  String get couldNotLoadRoom;

  /// No description provided for @voteCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Your vote could not be saved. Check your connection and try again.'**
  String get voteCouldNotSave;

  /// No description provided for @eventUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This meal plan is no longer available.'**
  String get eventUnavailable;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @sharedWith.
  ///
  /// In en, this message translates to:
  /// **'SHARED WITH'**
  String get sharedWith;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'NOTES'**
  String get notes;

  /// No description provided for @notesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing yet. Leave a thought for everyone planning with you.'**
  String get notesEmpty;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get addNote;

  /// No description provided for @dayHasCome.
  ///
  /// In en, this message translates to:
  /// **'THE DAY HAS COME'**
  String get dayHasCome;

  /// No description provided for @arrivalWithoutDescription.
  ///
  /// In en, this message translates to:
  /// **'{title} is here — enjoy every minute of it.'**
  String arrivalWithoutDescription(String title);

  /// No description provided for @arrivalWithDescription.
  ///
  /// In en, this message translates to:
  /// **'{title} is here — {description}'**
  String arrivalWithDescription(String title, String description);

  /// No description provided for @passed.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get passed;

  /// No description provided for @countingDown.
  ///
  /// In en, this message translates to:
  /// **'Counting down'**
  String get countingDown;

  /// No description provided for @duplicateYearLater.
  ///
  /// In en, this message translates to:
  /// **'Duplicate a year later'**
  String get duplicateYearLater;

  /// No description provided for @duplicateEventSuccess.
  ///
  /// In en, this message translates to:
  /// **'Duplicated — open it to adjust the date.'**
  String get duplicateEventSuccess;

  /// No description provided for @deleteMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Delete meal plan'**
  String get deleteMealPlan;

  /// No description provided for @deleteOwnerOnly.
  ///
  /// In en, this message translates to:
  /// **'Only the owner can delete this meal plan.'**
  String get deleteOwnerOnly;

  /// No description provided for @mealPlanDeleted.
  ///
  /// In en, this message translates to:
  /// **'Meal plan deleted.'**
  String get mealPlanDeleted;

  /// No description provided for @couldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete. Try again.'**
  String get couldNotDelete;

  /// No description provided for @deleteMealPlanConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this meal plan?'**
  String get deleteMealPlanConfirm;

  /// No description provided for @mealPlanCannotRecover.
  ///
  /// In en, this message translates to:
  /// **'This meal plan cannot be recovered.'**
  String get mealPlanCannotRecover;

  /// No description provided for @keep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get keep;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancelDecisionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Cancel this decision?'**
  String get cancelDecisionConfirm;

  /// No description provided for @roomKeptInHistory.
  ///
  /// In en, this message translates to:
  /// **'The room will be kept in the history.'**
  String get roomKeptInHistory;

  /// No description provided for @keepIt.
  ///
  /// In en, this message translates to:
  /// **'Keep it'**
  String get keepIt;

  /// No description provided for @cancelDecision.
  ///
  /// In en, this message translates to:
  /// **'Cancel decision'**
  String get cancelDecision;

  /// No description provided for @couldNotRevealWinner.
  ///
  /// In en, this message translates to:
  /// **'Could not reveal the winner.'**
  String get couldNotRevealWinner;

  /// No description provided for @couldNotAddNote.
  ///
  /// In en, this message translates to:
  /// **'Could not add your note.'**
  String get couldNotAddNote;

  /// No description provided for @couldNotDuplicateDecision.
  ///
  /// In en, this message translates to:
  /// **'Could not duplicate this decision.'**
  String get couldNotDuplicateDecision;

  /// No description provided for @couldNotCancelDecision.
  ///
  /// In en, this message translates to:
  /// **'Could not cancel this decision.'**
  String get couldNotCancelDecision;

  /// No description provided for @linkCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'This link could not be opened.'**
  String get linkCouldNotOpen;

  /// No description provided for @mapsCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Maps could not be opened.'**
  String get mapsCouldNotOpen;

  /// No description provided for @decision.
  ///
  /// In en, this message translates to:
  /// **'Decision'**
  String get decision;

  /// No description provided for @duplicateForAnotherDay.
  ///
  /// In en, this message translates to:
  /// **'Duplicate for another day'**
  String get duplicateForAnotherDay;

  /// No description provided for @swipeToVote.
  ///
  /// In en, this message translates to:
  /// **'Swipe to vote'**
  String get swipeToVote;

  /// No description provided for @noRestaurantsAdded.
  ///
  /// In en, this message translates to:
  /// **'No restaurants have been added yet.'**
  String get noRestaurantsAdded;

  /// No description provided for @aroundTable.
  ///
  /// In en, this message translates to:
  /// **'Around the table'**
  String get aroundTable;

  /// No description provided for @couldNotLoadGroup.
  ///
  /// In en, this message translates to:
  /// **'Could not load the group.'**
  String get couldNotLoadGroup;

  /// No description provided for @couldNotLoadNotes.
  ///
  /// In en, this message translates to:
  /// **'Could not load notes.'**
  String get couldNotLoadNotes;

  /// No description provided for @theGroupDecision.
  ///
  /// In en, this message translates to:
  /// **'THE GROUP DECISION'**
  String get theGroupDecision;

  /// No description provided for @weAreGoingTo.
  ///
  /// In en, this message translates to:
  /// **'WE’RE GOING TO'**
  String get weAreGoingTo;

  /// No description provided for @tableStillOpen.
  ///
  /// In en, this message translates to:
  /// **'The table is still open'**
  String get tableStillOpen;

  /// No description provided for @openInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get openInMaps;

  /// No description provided for @addToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add to calendar'**
  String get addToCalendar;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @votesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} vote} other{{count} votes}}'**
  String votesCount(int count);

  /// No description provided for @currentVote.
  ///
  /// In en, this message translates to:
  /// **'Your current vote'**
  String get currentVote;

  /// No description provided for @voteForOption.
  ///
  /// In en, this message translates to:
  /// **'Vote for {title}'**
  String voteForOption(String title);

  /// No description provided for @openInMapsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get openInMapsTooltip;

  /// No description provided for @openWebsiteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Open website'**
  String get openWebsiteTooltip;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @calendarEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Bite Brigade · {roomName}'**
  String calendarEventTitle(String roomName);

  /// No description provided for @calendarDecisionMade.
  ///
  /// In en, this message translates to:
  /// **'Decision made with Bite Brigade.'**
  String get calendarDecisionMade;

  /// No description provided for @calendarWinnerPicked.
  ///
  /// In en, this message translates to:
  /// **'We picked {title}.'**
  String calendarWinnerPicked(String title);

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @nobodyBlocked.
  ///
  /// In en, this message translates to:
  /// **'Nobody is blocked'**
  String get nobodyBlocked;

  /// No description provided for @blockPeopleHowTo.
  ///
  /// In en, this message translates to:
  /// **'To block someone, open a meal plan you share with them, open the ⋮ menu on their row, and tap Block.'**
  String get blockPeopleHowTo;

  /// No description provided for @blockedPeopleCannotInvite.
  ///
  /// In en, this message translates to:
  /// **'These people cannot invite you, and you do not share any meal plans with them.'**
  String get blockedPeopleCannotInvite;

  /// No description provided for @notToldTheyAreBlocked.
  ///
  /// In en, this message translates to:
  /// **'They are not told they are blocked.'**
  String get notToldTheyAreBlocked;

  /// No description provided for @blockedListLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your blocked list'**
  String get blockedListLoadError;

  /// No description provided for @blockedListPermissionError.
  ///
  /// In en, this message translates to:
  /// **'Your account is not allowed to read this list. If this keeps happening, update the app.'**
  String get blockedListPermissionError;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @blockUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Block {name}?'**
  String blockUserTitle(String name);

  /// No description provided for @blockUserExplanation.
  ///
  /// In en, this message translates to:
  /// **'You will stop seeing each other. They are removed from every meal plan you share, invitations between you are cancelled, and they cannot invite you again. They are not told.'**
  String get blockUserExplanation;

  /// No description provided for @blockUndoTip.
  ///
  /// In en, this message translates to:
  /// **'You can undo this any time in Settings → Blocked people.'**
  String get blockUndoTip;

  /// No description provided for @blocking.
  ///
  /// In en, this message translates to:
  /// **'Blocking…'**
  String get blocking;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @personBlocked.
  ///
  /// In en, this message translates to:
  /// **'{name} is blocked.'**
  String personBlocked(String name);

  /// No description provided for @blockUndoFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not undo block. Please try again.'**
  String get blockUndoFailed;

  /// No description provided for @blockSavePermissionError.
  ///
  /// In en, this message translates to:
  /// **'Your block could not be saved. Sign in again and retry.'**
  String get blockSavePermissionError;

  /// No description provided for @blockSaveNetworkError.
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your network and try again.'**
  String get blockSaveNetworkError;

  /// No description provided for @blockSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not block {name}. Please try again.'**
  String blockSaveError(String name);

  /// No description provided for @personUnblocked.
  ///
  /// In en, this message translates to:
  /// **'{name} is unblocked. Meal plan access was not restored.'**
  String personUnblocked(String name);

  /// No description provided for @weReadEveryMessage.
  ///
  /// In en, this message translates to:
  /// **'We read every message'**
  String get weReadEveryMessage;

  /// No description provided for @supportIntroduction.
  ///
  /// In en, this message translates to:
  /// **'Bite Brigade is an independent app. Email is the fastest way to reach the person who builds it — there is no support desk in between. We usually reply {responseTime}.'**
  String supportIntroduction(String responseTime);

  /// No description provided for @supportResponseTime.
  ///
  /// In en, this message translates to:
  /// **'within 2 business days'**
  String get supportResponseTime;

  /// No description provided for @commonQuestions.
  ///
  /// In en, this message translates to:
  /// **'Common questions'**
  String get commonQuestions;

  /// No description provided for @faqMissingPlansQuestion.
  ///
  /// In en, this message translates to:
  /// **'I signed in but my dinner rooms are missing.'**
  String get faqMissingPlansQuestion;

  /// No description provided for @faqMissingPlansAnswer.
  ///
  /// In en, this message translates to:
  /// **'Check that you signed in with the account invited to those rooms. For a crew-shared room, confirm you are still a member of that crew.'**
  String get faqMissingPlansAnswer;

  /// No description provided for @faqInviteeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Someone I invited cannot see the room.'**
  String get faqInviteeQuestion;

  /// No description provided for @faqInviteeAnswer.
  ///
  /// In en, this message translates to:
  /// **'Ask them to sign in with the email address that received the invitation and accept it from the Invitations screen.'**
  String get faqInviteeAnswer;

  /// No description provided for @faqDeleteAccountQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do I delete my account and my data?'**
  String get faqDeleteAccountQuestion;

  /// No description provided for @faqDeleteAccountAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open Settings > Delete account and follow the confirmation steps. If you cannot sign in, contact support from the email address on your account.'**
  String get faqDeleteAccountAnswer;

  /// No description provided for @faqWhoSeesRoomQuestion.
  ///
  /// In en, this message translates to:
  /// **'Who can see my room?'**
  String get faqWhoSeesRoomQuestion;

  /// No description provided for @faqWhoSeesRoomAnswer.
  ///
  /// In en, this message translates to:
  /// **'The room creator and accepted participants can see its details. Rooms shared with a crew are also visible to that crew’s members.'**
  String get faqWhoSeesRoomAnswer;

  /// No description provided for @faqDataQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you sell my data or show ads?'**
  String get faqDataQuestion;

  /// No description provided for @faqDataAnswer.
  ///
  /// In en, this message translates to:
  /// **'Room information is stored in the configured Firebase project and shared with the participants or crew you choose. Read the privacy policy for details.'**
  String get faqDataAnswer;

  /// No description provided for @supportContactNote.
  ///
  /// In en, this message translates to:
  /// **'A refund, a billing question or a crash report all belong at the same address. If the app misbehaves, telling us your device and what you were doing when it happened is the single most useful thing you can include.'**
  String get supportContactNote;

  /// No description provided for @emailSupport.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get emailSupport;

  /// No description provided for @supportEmailCopied.
  ///
  /// In en, this message translates to:
  /// **'{email} copied'**
  String supportEmailCopied(String email);

  /// No description provided for @openMail.
  ///
  /// In en, this message translates to:
  /// **'Open mail'**
  String get openMail;

  /// No description provided for @linkCopiedClipboard.
  ///
  /// In en, this message translates to:
  /// **'Link copied to your clipboard.'**
  String get linkCopiedClipboard;

  /// No description provided for @nothingWaitingForYou.
  ///
  /// In en, this message translates to:
  /// **'Nothing waiting for you.'**
  String get nothingWaitingForYou;

  /// No description provided for @invitationsEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Meal-plan and crew invitations will appear here. Most need your response; two-person groups are added automatically.'**
  String get invitationsEmptyDescription;

  /// No description provided for @waitingOnYou.
  ///
  /// In en, this message translates to:
  /// **'Waiting on you'**
  String get waitingOnYou;

  /// No description provided for @invitationsSummary.
  ///
  /// In en, this message translates to:
  /// **'Join a meal plan to help choose where to eat, or join a crew to plan meals together. If you decline, the person who invited you will know.'**
  String get invitationsSummary;

  /// No description provided for @signInToSeeInvitations.
  ///
  /// In en, this message translates to:
  /// **'Sign in to see invitations'**
  String get signInToSeeInvitations;

  /// No description provided for @invitationsSignInDescription.
  ///
  /// In en, this message translates to:
  /// **'Invitations are addressed to your email, so sign in with the address someone invited.'**
  String get invitationsSignInDescription;

  /// No description provided for @dinnerDecisions.
  ///
  /// In en, this message translates to:
  /// **'Dinner decisions'**
  String get dinnerDecisions;

  /// No description provided for @invitedToChoosePlace.
  ///
  /// In en, this message translates to:
  /// **'You’re invited to help decide where the group will eat.'**
  String get invitedToChoosePlace;

  /// No description provided for @joinDecision.
  ///
  /// In en, this message translates to:
  /// **'Join decision'**
  String get joinDecision;

  /// No description provided for @twoPersonBadge.
  ///
  /// In en, this message translates to:
  /// **'TWO-PERSON'**
  String get twoPersonBadge;

  /// No description provided for @joinTwoPersonCrewDescription.
  ///
  /// In en, this message translates to:
  /// **'Join this two-person crew to share future meal plans automatically.'**
  String get joinTwoPersonCrewDescription;

  /// No description provided for @joinCrewDescription.
  ///
  /// In en, this message translates to:
  /// **'Join this crew to receive and shape future meal plans.'**
  String get joinCrewDescription;

  /// No description provided for @joinCrew.
  ///
  /// In en, this message translates to:
  /// **'Join crew'**
  String get joinCrew;

  /// No description provided for @invitationLoadError.
  ///
  /// In en, this message translates to:
  /// **'Invitations could not be loaded. Check your connection and try again.'**
  String get invitationLoadError;

  /// No description provided for @couldNotRespondInvitation.
  ///
  /// In en, this message translates to:
  /// **'Could not respond to this invitation. Try again.'**
  String get couldNotRespondInvitation;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @roleEditor.
  ///
  /// In en, this message translates to:
  /// **'Editor'**
  String get roleEditor;

  /// No description provided for @roleViewer.
  ///
  /// In en, this message translates to:
  /// **'Viewer'**
  String get roleViewer;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yourCrews.
  ///
  /// In en, this message translates to:
  /// **'Your crews'**
  String get yourCrews;

  /// No description provided for @createCrew.
  ///
  /// In en, this message translates to:
  /// **'Create a crew'**
  String get createCrew;

  /// No description provided for @couldNotLoadCrews.
  ///
  /// In en, this message translates to:
  /// **'Your crews could not be loaded.'**
  String get couldNotLoadCrews;

  /// No description provided for @goodThingsShared.
  ///
  /// In en, this message translates to:
  /// **'Good things are better shared.'**
  String get goodThingsShared;

  /// No description provided for @bringPeopleTogether.
  ///
  /// In en, this message translates to:
  /// **'Bring friends, family, or teammates together to plan your next meal.'**
  String get bringPeopleTogether;

  /// No description provided for @membersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} member} other{{count} members}}'**
  String membersCount(int count);

  /// No description provided for @crewNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Give your crew a name.'**
  String get crewNameRequired;

  /// No description provided for @couldNotCreateCrew.
  ///
  /// In en, this message translates to:
  /// **'Could not create this crew. Try again.'**
  String get couldNotCreateCrew;

  /// No description provided for @gatherYourCrew.
  ///
  /// In en, this message translates to:
  /// **'Gather your crew.'**
  String get gatherYourCrew;

  /// No description provided for @inviteEveryoneOnce.
  ///
  /// In en, this message translates to:
  /// **'Invite everyone once, then plan meals together whenever you are ready to eat.'**
  String get inviteEveryoneOnce;

  /// No description provided for @mark.
  ///
  /// In en, this message translates to:
  /// **'Mark'**
  String get mark;

  /// No description provided for @crewName.
  ///
  /// In en, this message translates to:
  /// **'Crew name'**
  String get crewName;

  /// No description provided for @crewNameHint.
  ///
  /// In en, this message translates to:
  /// **'Friday regulars'**
  String get crewNameHint;

  /// No description provided for @twoPersonCrewTitle.
  ///
  /// In en, this message translates to:
  /// **'Just the two of us'**
  String get twoPersonCrewTitle;

  /// No description provided for @twoPersonCrewDescription.
  ///
  /// In en, this message translates to:
  /// **'Share meal plans with each other automatically.'**
  String get twoPersonCrewDescription;

  /// No description provided for @crewCreated.
  ///
  /// In en, this message translates to:
  /// **'Crew created.'**
  String get crewCreated;

  /// No description provided for @crewInvitationSent.
  ///
  /// In en, this message translates to:
  /// **'Crew invitation sent.'**
  String get crewInvitationSent;

  /// No description provided for @couldNotSendCrewInvitation.
  ///
  /// In en, this message translates to:
  /// **'Could not send this invitation. Try again.'**
  String get couldNotSendCrewInvitation;

  /// No description provided for @couldNotRenameCrew.
  ///
  /// In en, this message translates to:
  /// **'Could not rename this crew. Try again.'**
  String get couldNotRenameCrew;

  /// No description provided for @couldNotChangeCrewRole.
  ///
  /// In en, this message translates to:
  /// **'Could not change this crew member’s role. Try again.'**
  String get couldNotChangeCrewRole;

  /// No description provided for @couldNotRemoveCrewMember.
  ///
  /// In en, this message translates to:
  /// **'Could not remove this person from the crew. Try again.'**
  String get couldNotRemoveCrewMember;

  /// No description provided for @couldNotDeleteCrew.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this crew. Try again.'**
  String get couldNotDeleteCrew;

  /// No description provided for @couldNotUpdateCrewAfterBlock.
  ///
  /// In en, this message translates to:
  /// **'This person is blocked, but crew access could not be updated. Try removing them again.'**
  String get couldNotUpdateCrewAfterBlock;

  /// No description provided for @crewRoleAppliesToFutureDecisions.
  ///
  /// In en, this message translates to:
  /// **'A member’s role applies to new decisions shared with this crew.'**
  String get crewRoleAppliesToFutureDecisions;

  /// No description provided for @blockCrewMemberExplanation.
  ///
  /// In en, this message translates to:
  /// **'They will be blocked. If you own this crew, they will be removed; otherwise, you will leave it. Direct access to other meal plans is unchanged.'**
  String get blockCrewMemberExplanation;

  /// No description provided for @leaveNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'Leave {name}?'**
  String leaveNamedCrew(String name);

  /// No description provided for @leaveCrewDescription.
  ///
  /// In en, this message translates to:
  /// **'You will stop seeing new decisions shared with this crew.'**
  String get leaveCrewDescription;

  /// No description provided for @stay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// No description provided for @leaveCrew.
  ///
  /// In en, this message translates to:
  /// **'Leave crew'**
  String get leaveCrew;

  /// No description provided for @couldNotLeaveCrew.
  ///
  /// In en, this message translates to:
  /// **'Could not leave this crew. Try again.'**
  String get couldNotLeaveCrew;

  /// No description provided for @crew.
  ///
  /// In en, this message translates to:
  /// **'Crew'**
  String get crew;

  /// No description provided for @crewUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This crew is no longer available.'**
  String get crewUnavailable;

  /// No description provided for @renameCrew.
  ///
  /// In en, this message translates to:
  /// **'Rename crew'**
  String get renameCrew;

  /// No description provided for @twoPersonCrew.
  ///
  /// In en, this message translates to:
  /// **'Two-person crew'**
  String get twoPersonCrew;

  /// No description provided for @standingCrew.
  ///
  /// In en, this message translates to:
  /// **'Standing crew'**
  String get standingCrew;

  /// No description provided for @mealPlansSharedAutomatically.
  ///
  /// In en, this message translates to:
  /// **'Meal plans are shared automatically with each other.'**
  String get mealPlansSharedAutomatically;

  /// No description provided for @sharePlansWithCrew.
  ///
  /// In en, this message translates to:
  /// **'Share meal plans with this crew whenever you plan together.'**
  String get sharePlansWithCrew;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'OWNER'**
  String get owner;

  /// No description provided for @leaveThisCrew.
  ///
  /// In en, this message translates to:
  /// **'Leave this crew'**
  String get leaveThisCrew;

  /// No description provided for @inviteToYourCrew.
  ///
  /// In en, this message translates to:
  /// **'Invite to your crew'**
  String get inviteToYourCrew;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @sendInvitation.
  ///
  /// In en, this message translates to:
  /// **'Send invitation'**
  String get sendInvitation;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @couldNotLoadCrew.
  ///
  /// In en, this message translates to:
  /// **'Could not load this crew.'**
  String get couldNotLoadCrew;

  /// No description provided for @couldNotLoadCrewMembers.
  ///
  /// In en, this message translates to:
  /// **'Could not load crew members.'**
  String get couldNotLoadCrewMembers;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @mealPlanInvitation.
  ///
  /// In en, this message translates to:
  /// **'Meal-plan invitation'**
  String get mealPlanInvitation;

  /// No description provided for @unnamedMealPlan.
  ///
  /// In en, this message translates to:
  /// **'A meal plan'**
  String get unnamedMealPlan;

  /// No description provided for @mealPlanInvitationBody.
  ///
  /// In en, this message translates to:
  /// **'You have been invited to join this meal plan. Accepting adds it to your list as {role}.'**
  String mealPlanInvitationBody(String role);

  /// No description provided for @joinMealPlanQuestion.
  ///
  /// In en, this message translates to:
  /// **'Join this meal plan?'**
  String get joinMealPlanQuestion;

  /// No description provided for @joinMealPlanExplanation.
  ///
  /// In en, this message translates to:
  /// **'It will appear in your list so the date and details are easy to find.'**
  String get joinMealPlanExplanation;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @alreadyMemberOf.
  ///
  /// In en, this message translates to:
  /// **'You are already a member of “{name}”.'**
  String alreadyMemberOf(String name);

  /// No description provided for @joinedNamedMealPlan.
  ///
  /// In en, this message translates to:
  /// **'You joined “{name}”.'**
  String joinedNamedMealPlan(String name);

  /// No description provided for @invitationDeclined.
  ///
  /// In en, this message translates to:
  /// **'Invitation declined.'**
  String get invitationDeclined;

  /// No description provided for @twoPersonGroupInvitation.
  ///
  /// In en, this message translates to:
  /// **'Two-person group invitation'**
  String get twoPersonGroupInvitation;

  /// No description provided for @crewInvitation.
  ///
  /// In en, this message translates to:
  /// **'Crew invitation'**
  String get crewInvitation;

  /// No description provided for @addingYouToCrew.
  ///
  /// In en, this message translates to:
  /// **'You\'re being added to {name}\'s crew.'**
  String addingYouToCrew(String name);

  /// No description provided for @invitedYouToNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'{inviter} invited you to “{crew}”.'**
  String invitedYouToNamedCrew(String inviter, String crew);

  /// No description provided for @automaticCrewInvitationBody.
  ///
  /// In en, this message translates to:
  /// **'You will be added automatically. Future meal plans shared with “{crew}” will appear in your list.'**
  String automaticCrewInvitationBody(String crew);

  /// No description provided for @namedCrewInvitationBody.
  ///
  /// In en, this message translates to:
  /// **'Join “{crew}” to see the meal plans this crew shares with you.'**
  String namedCrewInvitationBody(String crew);

  /// No description provided for @couldNotAddYouAutomatically.
  ///
  /// In en, this message translates to:
  /// **'We could not add you automatically.'**
  String get couldNotAddYouAutomatically;

  /// No description provided for @retryAddingYou.
  ///
  /// In en, this message translates to:
  /// **'Retry adding you'**
  String get retryAddingYou;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @alreadyMemberOfCrew.
  ///
  /// In en, this message translates to:
  /// **'You are already a member of “{crew}”.'**
  String alreadyMemberOfCrew(String crew);

  /// No description provided for @addedToNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'You were added to “{crew}”.'**
  String addedToNamedCrew(String crew);

  /// No description provided for @joinedNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'You joined “{crew}”.'**
  String joinedNamedCrew(String crew);

  /// No description provided for @someone.
  ///
  /// In en, this message translates to:
  /// **'Someone'**
  String get someone;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @noCrewsYet.
  ///
  /// In en, this message translates to:
  /// **'No crews yet'**
  String get noCrewsYet;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeFromCrew.
  ///
  /// In en, this message translates to:
  /// **'Remove from crew'**
  String get removeFromCrew;

  /// No description provided for @removeCrewMemberTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String removeCrewMemberTitle(String name);

  /// No description provided for @removeCrewMemberExplanation.
  ///
  /// In en, this message translates to:
  /// **'They will stop seeing meal plans shared with this crew. Nothing they created is deleted.'**
  String get removeCrewMemberExplanation;

  /// No description provided for @deleteNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'Delete “{name}”?'**
  String deleteNamedCrew(String name);

  /// No description provided for @deleteCrewExplanation.
  ///
  /// In en, this message translates to:
  /// **'The crew goes away. Meal plans shared with it are kept and stay yours — they are just no longer shared with these people.'**
  String get deleteCrewExplanation;

  /// No description provided for @inviteToNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'Invite to “{name}”'**
  String inviteToNamedCrew(String name);

  /// No description provided for @inviteToTwoPersonCrew.
  ///
  /// In en, this message translates to:
  /// **'Invite to your two-person crew'**
  String get inviteToTwoPersonCrew;

  /// No description provided for @automaticCrewInviteExplanation.
  ///
  /// In en, this message translates to:
  /// **'If they already have an account, they will be added automatically. Otherwise, they will be added when they sign in. Meal plans shared with this crew will appear automatically.'**
  String get automaticCrewInviteExplanation;

  /// No description provided for @crewInviteExplanation.
  ///
  /// In en, this message translates to:
  /// **'They will get an invitation to accept or decline. After they join, you can share meal plans with this crew in one tap.'**
  String get crewInviteExplanation;

  /// No description provided for @inviteEmailHint.
  ///
  /// In en, this message translates to:
  /// **'friend@example.com'**
  String get inviteEmailHint;

  /// No description provided for @recentContactsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Recent contacts could not load. Check your connection and try again.'**
  String get recentContactsLoadError;

  /// No description provided for @theyWillBeAddedAutomatically.
  ///
  /// In en, this message translates to:
  /// **'They will be added automatically.'**
  String get theyWillBeAddedAutomatically;

  /// No description provided for @invitationSentTo.
  ///
  /// In en, this message translates to:
  /// **'Invitation sent to {email}.'**
  String invitationSentTo(String email);

  /// No description provided for @leftNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'You left “{name}”.'**
  String leftNamedCrew(String name);

  /// No description provided for @deletedNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'Deleted “{name}”.'**
  String deletedNamedCrew(String name);

  /// No description provided for @signInToUseCrews.
  ///
  /// In en, this message translates to:
  /// **'Sign in to use crews'**
  String get signInToUseCrews;

  /// No description provided for @crewsSignInDescription.
  ///
  /// In en, this message translates to:
  /// **'Crews invite people by email, so they need an account to be invited.'**
  String get crewsSignInDescription;

  /// No description provided for @editMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Edit meal plan'**
  String get editMealPlan;

  /// No description provided for @createMealPlanAction.
  ///
  /// In en, this message translates to:
  /// **'Create meal plan'**
  String get createMealPlanAction;

  /// No description provided for @mealPlanActions.
  ///
  /// In en, this message translates to:
  /// **'Meal plan actions'**
  String get mealPlanActions;

  /// No description provided for @titleField.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleField;

  /// No description provided for @mealPlanTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Friday dinner, team lunch, family brunch'**
  String get mealPlanTitleHint;

  /// No description provided for @descriptionField.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionField;

  /// No description provided for @mealPlanDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note about the meal, place, or plan'**
  String get mealPlanDescriptionHint;

  /// No description provided for @when.
  ///
  /// In en, this message translates to:
  /// **'When'**
  String get when;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @oneWeek.
  ///
  /// In en, this message translates to:
  /// **'+1 week'**
  String get oneWeek;

  /// No description provided for @oneMonth.
  ///
  /// In en, this message translates to:
  /// **'+1 month'**
  String get oneMonth;

  /// No description provided for @oneYear.
  ///
  /// In en, this message translates to:
  /// **'+1 year'**
  String get oneYear;

  /// No description provided for @fiveYears.
  ///
  /// In en, this message translates to:
  /// **'+5 years'**
  String get fiveYears;

  /// No description provided for @mealPlanTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Give this meal plan a title.'**
  String get mealPlanTitleRequired;

  /// No description provided for @futureMomentRequired.
  ///
  /// In en, this message translates to:
  /// **'Pick a moment still ahead of you.'**
  String get futureMomentRequired;

  /// No description provided for @signInToSaveMealPlans.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save meal plans.'**
  String get signInToSaveMealPlans;

  /// No description provided for @mealPlanCreated.
  ///
  /// In en, this message translates to:
  /// **'Meal plan created.'**
  String get mealPlanCreated;

  /// No description provided for @changesSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved.'**
  String get changesSaved;

  /// No description provided for @otherPerson.
  ///
  /// In en, this message translates to:
  /// **'The other person'**
  String get otherPerson;

  /// No description provided for @coupleNotAdded.
  ///
  /// In en, this message translates to:
  /// **'Meal plan created, but {name} was not added. Invite them manually from the plan.'**
  String coupleNotAdded(String name);

  /// No description provided for @coupleAdded.
  ///
  /// In en, this message translates to:
  /// **'Meal plan created. {name} was added.'**
  String coupleAdded(String name);

  /// No description provided for @nobodyAdded.
  ///
  /// In en, this message translates to:
  /// **'Meal plan created, but no one was added. Invite them manually.'**
  String get nobodyAdded;

  /// No description provided for @viewOnlyMealPlan.
  ///
  /// In en, this message translates to:
  /// **'You can view this meal plan but not change it.'**
  String get viewOnlyMealPlan;

  /// No description provided for @chooseFutureMealTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a future meal time to see the plan.'**
  String get chooseFutureMealTime;

  /// No description provided for @timeUntilMeal.
  ///
  /// In en, this message translates to:
  /// **'Time until your meal: {duration}'**
  String timeUntilMeal(String duration);

  /// No description provided for @collaborators.
  ///
  /// In en, this message translates to:
  /// **'Collaborators'**
  String get collaborators;

  /// No description provided for @inviteesAccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Anyone you invite can see this meal plan on their own devices.'**
  String get inviteesAccessDescription;

  /// No description provided for @peopleWithAccess.
  ///
  /// In en, this message translates to:
  /// **'People with access to this meal plan.'**
  String get peopleWithAccess;

  /// No description provided for @noCollaboratorsYet.
  ///
  /// In en, this message translates to:
  /// **'No one else yet.'**
  String get noCollaboratorsYet;

  /// No description provided for @sharedWithNamedCrew.
  ///
  /// In en, this message translates to:
  /// **'Shared with {name}'**
  String sharedWithNamedCrew(String name);

  /// No description provided for @inviteAgain.
  ///
  /// In en, this message translates to:
  /// **'Invite again'**
  String get inviteAgain;

  /// No description provided for @moreActions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get moreActions;

  /// No description provided for @changeRole.
  ///
  /// In en, this message translates to:
  /// **'Change role'**
  String get changeRole;

  /// No description provided for @memberRoleUpdated.
  ///
  /// In en, this message translates to:
  /// **'{name} is now {role}.'**
  String memberRoleUpdated(String name, String role);

  /// No description provided for @personRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} was removed.'**
  String personRemoved(String name);

  /// No description provided for @invitationAskedAgain.
  ///
  /// In en, this message translates to:
  /// **'Asked {email} again.'**
  String invitationAskedAgain(String email);

  /// No description provided for @removePersonQuestion.
  ///
  /// In en, this message translates to:
  /// **'Remove this person?'**
  String get removePersonQuestion;

  /// No description provided for @removePersonExplanation.
  ///
  /// In en, this message translates to:
  /// **'{email} will lose access to this meal plan and will no longer see it in their list.'**
  String removePersonExplanation(String email);

  /// No description provided for @changeRoleFor.
  ///
  /// In en, this message translates to:
  /// **'Change role for {name}'**
  String changeRoleFor(String name);

  /// No description provided for @roleCurrentAccess.
  ///
  /// In en, this message translates to:
  /// **'This changes what they can do on this meal plan. They currently have {role} access.'**
  String roleCurrentAccess(String role);

  /// No description provided for @rolesCannotBeAssigned.
  ///
  /// In en, this message translates to:
  /// **'{roles} cannot be assigned by you — your role is {role}.'**
  String rolesCannotBeAssigned(String roles, String role);

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @adminRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Can invite people, change roles, edit the meal plan, and remove collaborators.'**
  String get adminRoleDescription;

  /// No description provided for @editorRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Can edit the title, description, and date. Cannot manage people.'**
  String get editorRoleDescription;

  /// No description provided for @viewerRoleDescription.
  ///
  /// In en, this message translates to:
  /// **'Can only view the meal plan.'**
  String get viewerRoleDescription;

  /// No description provided for @durationYearCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} year} other{{count} years}}'**
  String durationYearCount(int count);

  /// No description provided for @durationMonthCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} month} other{{count} months}}'**
  String durationMonthCount(int count);

  /// No description provided for @durationDayCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String durationDayCount(int count);

  /// No description provided for @durationHourCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} hour} other{{count} hours}}'**
  String durationHourCount(int count);

  /// No description provided for @durationMinuteCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} minute} other{{count} minutes}}'**
  String durationMinuteCount(int count);

  /// No description provided for @durationSecondCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} second} other{{count} seconds}}'**
  String durationSecondCount(int count);

  /// No description provided for @momentHasPassed.
  ///
  /// In en, this message translates to:
  /// **'The moment has passed.'**
  String get momentHasPassed;

  /// No description provided for @couldNotSaveMealPlan.
  ///
  /// In en, this message translates to:
  /// **'Could not save this meal plan. Please try again.'**
  String get couldNotSaveMealPlan;

  /// No description provided for @savePermissionError.
  ///
  /// In en, this message translates to:
  /// **'Your account cannot save this meal plan. Update the app and try again.'**
  String get savePermissionError;

  /// No description provided for @saveNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the service. Check your connection and try again.'**
  String get saveNetworkError;

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @invitationAcceptedState.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get invitationAcceptedState;

  /// No description provided for @invitationDeclinedState.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get invitationDeclinedState;

  /// No description provided for @invitationRemovedState.
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get invitationRemovedState;

  /// No description provided for @invitationReopenedState.
  ///
  /// In en, this message translates to:
  /// **'Reopened'**
  String get invitationReopenedState;

  /// No description provided for @invitationWaitingState.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get invitationWaitingState;

  /// No description provided for @sharedCrewInviteInfo.
  ///
  /// In en, this message translates to:
  /// **'Two-person crews share meal plans automatically. Other crews get an invitation.'**
  String get sharedCrewInviteInfo;

  /// No description provided for @shareWith.
  ///
  /// In en, this message translates to:
  /// **'Share with'**
  String get shareWith;

  /// No description provided for @arrived.
  ///
  /// In en, this message translates to:
  /// **'It has arrived.'**
  String get arrived;

  /// No description provided for @countdownToGo.
  ///
  /// In en, this message translates to:
  /// **'{duration} to go'**
  String countdownToGo(String duration);

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent. All your meal plans, crews, and data will be deleted forever.'**
  String get deleteAccountWarning;

  /// No description provided for @deleteAccountConfirmationPrompt.
  ///
  /// In en, this message translates to:
  /// **'Type your exact account email to continue.'**
  String get deleteAccountConfirmationPrompt;

  /// No description provided for @deleteAccountConfirmationLabel.
  ///
  /// In en, this message translates to:
  /// **'Account email'**
  String get deleteAccountConfirmationLabel;

  /// No description provided for @deleteAccountProfileConsequence.
  ///
  /// In en, this message translates to:
  /// **'Your profile will be permanently deleted.'**
  String get deleteAccountProfileConsequence;

  /// No description provided for @deleteAccountAccessConsequence.
  ///
  /// In en, this message translates to:
  /// **'You will lose access to all your meal plans and crews.'**
  String get deleteAccountAccessConsequence;

  /// No description provided for @deleteAccountIrreversibleConsequence.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteAccountIrreversibleConsequence;

  /// No description provided for @deleteAccountPermanentlyAction.
  ///
  /// In en, this message translates to:
  /// **'Delete account permanently'**
  String get deleteAccountPermanentlyAction;

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully.'**
  String get accountDeleted;

  /// No description provided for @serverTimedOutTryAgain.
  ///
  /// In en, this message translates to:
  /// **'The server timed out. Please try again later.'**
  String get serverTimedOutTryAgain;

  /// No description provided for @accountDeletionFailed.
  ///
  /// In en, this message translates to:
  /// **'Account deletion could not be completed. Please try again.'**
  String get accountDeletionFailed;

  /// No description provided for @accountDeletedCleanupWarning.
  ///
  /// In en, this message translates to:
  /// **'The account was deleted, but some local settings could not be cleared. Restart the app before using another account.'**
  String get accountDeletedCleanupWarning;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'uk',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'uk':
      return AppLocalizationsUk();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
