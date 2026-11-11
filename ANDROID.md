# Bite Brigade — Android

Bite Brigade is a Flutter app. Android uses the same Dart screens and Firestore
repository as iOS and web.

## App identity

- Android application ID: `com.tabletalk.app`
- iOS bundle ID: `com.tabletalk.app`
- Display name: `Bite Brigade`

These are new identifiers for this copy. Register them for Bite Brigade before
publishing; do not use the inherited Date Dawn Firebase configuration.

## Configure Firebase

Create a separate Firebase project, enable the sign-in providers you intend to
support and create a Cloud Firestore database. Then run FlutterFire
configuration for the new project:

```powershell
flutterfire configure --project=your-bite-brigade-project-id
```

Replace the example project ID with the one you created. Register the Android
app using `com.tabletalk.app`; FlutterFire should generate
`android/app/google-services.json` and update `lib/firebase_options.dart`.
Until all platform settings target the new project, the app displays a setup
screen and will not connect to Firebase.

## Build and run

Install Flutter 3.22+ and Android Studio with the Android SDK and NDK
`28.2.13676358`:

```powershell
flutter pub get
flutter run
flutter build apk --debug
```

For a signed Play release, configure a private upload key in
`android/key.properties` and build:

```powershell
flutter build appbundle --release
```

Never commit signing credentials. Before release, test the app on a real device
and complete the checklist in [docs/PUBLISHING_CHECKLIST.md](./docs/PUBLISHING_CHECKLIST.md).
