# Bite Brigade release checklist

This is a pre-release checklist, not evidence that the app is ready for store
submission. Confirm each item against the actual production configuration.

## App identity and backend

- [ ] Confirm the `com.tabletalk.app` Android application ID and iOS bundle ID
      are available and registered for this app.
- [ ] Create a dedicated Firebase project for Bite Brigade. Do not use the
      inherited Date Dawn project.
- [ ] Enable the intended Firebase Authentication providers and Cloud
      Firestore.
- [ ] Run `flutterfire configure` for the Bite Brigade project and verify all
      generated platform settings target that same project.
- [ ] Verify `node scripts/check-backend.mjs` succeeds.
- [ ] Review and test `firestore.rules` and `firestore.indexes.json` before
      deploying them to the new project.

## User-facing and store information

- [ ] Publish `docs/privacy.html` and `docs/support.html` at stable public URLs.
- [ ] Verify the support email and privacy disclosures with the service
      operator.
- [ ] Complete the required data-safety and privacy disclosures using the
      actual Firebase configuration and data flows.
- [ ] Provide reviewer instructions and a test account if the store review
      requires sign-in.

## Release builds

- [ ] Run `flutter analyze`, `flutter test`, and the Firestore emulator tests.
- [ ] Test room creation, invitations, voting, winner reveal, crew sharing,
      account access, and error states on supported platforms.
- [ ] Generate new Android and iOS Firebase configuration for the Bite Brigade
      application IDs. In particular, configure Google Sign-In URL schemes from
      the new iOS Firebase settings.
- [ ] Configure release signing with credentials stored outside source control.
- [ ] Build and install release artifacts on real devices before submission.
