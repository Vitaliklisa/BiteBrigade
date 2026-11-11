# Bite Brigade implementation checklist

- [x] Copy the app into an independent Bite Brigade repository folder.
- [x] Add rooms, restaurant options, participants, votes, notes, crews, and
      invitations.
- [x] Add Firestore rules and indexes for room and crew access.
- [x] Add emulator tests for room permissions, invitations, voting, and crew
      access changes.
- [x] Give the Android and iOS app distinct `com.tabletalk.app` identifiers.
- [x] Replace Date Dawn branding in the primary app UI, web pages, app icons,
      splash assets, privacy policy, and support content.
- [x] Prevent the copied app and Firebase CLI from targeting the inherited
      Firebase project by default.
- [ ] Create and configure a dedicated Bite Brigade Firebase project.
- [ ] Review the Firebase rules and indexes, then deploy them only to the new
      Bite Brigade project.
- [ ] Verify sign-in providers, room creation, invitations, voting, crew
      sharing, and notifications on Android, iOS, and web.
- [ ] Confirm support details and publish the privacy policy before release.
