# Table Talk

Make a dinner decision together. Create a room, add restaurant options, invite
friends or a crew, vote, and reveal the group's pick.

Table Talk is a Flutter app for Android, iOS, and web. It uses Firebase
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

Create a separate Firebase project for Table Talk, enable Authentication
(Email/Password and Google if desired) and Cloud Firestore, then configure the
Flutter and Firebase CLI tools:

```sh
flutterfire configure --project=your-table-talk-project-id
firebase use --add
node scripts/check-backend.mjs
```

Replace `your-table-talk-project-id` with the project ID you created. In the
`firebase use --add` prompt, select that same Table Talk project.
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

## Project layout

- `lib/core/rooms.dart` — room, participant, vote, crew, and invitation models.
- `lib/services/room_repository.dart` — Firestore operations and workflows.
- `lib/screens/` — room, voting, crew, and invitation screens.
- `firestore.rules` — server-side access control.
- `firestore.indexes.json` — indexes required by Firestore queries.
- `rules_test/` — emulator-backed authorization tests.
- `PRIVACY_POLICY.md` and `docs/privacy.html` — privacy policy sources.

The privacy and support pages are drafts for Table Talk. Before public release,
publish the policy at a stable URL and verify the contact details and legal
requirements for the service operator and its users.
