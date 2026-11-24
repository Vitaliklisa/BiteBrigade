# Bite Brigade

Make a dinner decision together. Create a room, add restaurant options, invite
friends or a crew, vote, and reveal the group's pick.

Bite Brigade is a Flutter app for Android, iOS, and web. It uses Firebase
Authentication and Cloud Firestore for accounts and shared data.

## Features

- Create a room with a meal time, notes, and two or more restaurant options.
- Invite people to a room, assign participant roles, and collect votes.
- Reveal the winner when everyone has voted or the decision deadline arrives.
- Save crews and share future rooms with their members.
- Invite and accept crew membership; create a couple crew for automatic sharing.
- Add notes to a room and receive in-app notifications about invitations and
  decision activity.

## Important: configure an independent Firebase project

This folder was copied from Date Dawn. Its checked-in Firebase configuration
still identifies the original `datedawn` project. The app deliberately refuses
to start Firebase while that inherited configuration is present. **Do not
deploy these Firestore rules or use this copy with the Date Dawn project.**

Create a separate Firebase project for Bite Brigade, enable Authentication
(Email/Password and Google if desired) and Cloud Firestore, then configure the
Flutter and Firebase CLI tools:

```sh
flutterfire configure --project=your-bite-brigade-project-id
firebase use --add
node scripts/check-backend.mjs
```

Replace `your-bite-brigade-project-id` with the project ID you created. In the
`firebase use --add` prompt, select that same Bite Brigade project.
FlutterFire should generate platform settings for `lib/firebase_options.dart`
and the native Android/iOS configuration. The app checks that those platform
settings agree and are not the inherited Date Dawn project. The backend check is
local-only and intentionally makes no requests to Firebase.

The Android and iOS application identifiers are `com.tabletalk.app`. Register
those identifiers in the new Firebase project. After configuring iOS Google
Sign-In, add its generated `REVERSED_CLIENT_ID` URL scheme to
`ios/Runner/Info.plist`.

After reviewing the rules and confirming the Firebase CLI target is your new
project, deploy the Firestore rules and indexes:

```sh
firebase deploy --only firestore:rules,firestore:indexes
```

## Account deletion API

The signed-in account deletion flow uses `api/delete-account.ts` and Firebase
Admin credentials. Configure these Vercel environment variables for the
Bite Brigade Firebase project:

- `FIREBASE_ADMIN_PROJECT_ID`
- `FIREBASE_ADMIN_CLIENT_EMAIL`
- `FIREBASE_ADMIN_PRIVATE_KEY`

The private key must contain the service-account key content with newlines
escaped or otherwise supplied as environment text. Never commit the credential
or the service-account JSON file.

`package.json` pins Firebase Admin's transitive `jwks-rsa` dependency to
3.2.2. Its 4.x release loads ESM-only `jose` through CommonJS `require()`,
which crashes the Vercel Node runtime before the deletion handler starts.

The deletion function is configured for up to 60 seconds, subject to the
Vercel plan's limits. For security, the API also requires a sign-in from within
the last five minutes; if the session is older, the app signs out and asks the
user to sign in again before retrying deletion.

Before deployment, deploy the Firestore index exemption for the collection
group `participants` and field `userId` included in
`firestore.indexes.json`.

## Run locally

Install Flutter 3.22 or newer and Java for the Firebase emulator. Then:

```sh
flutter pub get
flutter run
```

For web:

```sh
flutter run -d chrome
```

## Validation

```sh
flutter analyze
flutter test
node rules_test/run.mjs rules_test/table_talk_rooms.test.mjs
```

The Firestore rules tests use the local emulator and do not deploy rules to any
project. They cover room creation, access boundaries, invitations, voting, and
crew membership changes.

## Localization

The language preference supports English, French, Spanish, Ukrainian, German,
and Traditional Chinese (Taiwan). Language names are displayed in the currently
selected interface language. The initial locale follows the device language
when supported and otherwise falls back to English; an explicit choice is saved
on the device, and “Follow system language” clears it. ARB catalogs live in
`l10n/`; regenerate their typed Dart API with:

```sh
flutter gen-l10n
```

The Settings, home, crew, invitation, meal-plan editor, and support surfaces
use typed generated localization APIs for English, French, Spanish, Ukrainian,
and German. Traditional Chinese (Taiwan) is translated on the login and primary
home surfaces; untranslated catalog entries retain the English source copy.
Persisted notification text and legal-policy documents remain
destination-specific and require separate content review before translation.

## Project layout

- `lib/core/rooms.dart` — room, participant, vote, crew, and invitation models.
- `lib/services/room_repository.dart` — Firestore operations and workflows.
- `lib/screens/` — room, voting, crew, and invitation screens.
- `lib/core/locale_settings.dart` — supported locales and system fallback.
- `l10n/` — typed localization catalogs for the supported app languages.
- `firestore.rules` — server-side access control.
- `firestore.indexes.json` — indexes required by Firestore queries.
- `rules_test/` — emulator-backed authorization tests.
- `PRIVACY_POLICY.md` and `docs/privacy.html` — privacy policy sources.

The privacy and support pages are drafts for Bite Brigade. Before public release,
publish the policy at a stable URL and verify the contact details and legal
requirements for the service operator and its users.
