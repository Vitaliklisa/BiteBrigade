import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

const googleServerClientId = String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID');

String get firebaseProjectId => DefaultFirebaseOptions.currentPlatform.projectId;

bool get hasFirebaseConfig {
  const options = [
    DefaultFirebaseOptions.web,
    DefaultFirebaseOptions.android,
    DefaultFirebaseOptions.ios,
  ];
  final projectIds = options.map((option) => option.projectId).toSet();
  return projectIds.length == 1 &&
      !projectIds.contains('datedawn') &&
      options.every((option) =>
          option.projectId.isNotEmpty &&
          option.apiKey.isNotEmpty &&
          option.appId.isNotEmpty);
}

FirebaseOptions get firebaseOptions => DefaultFirebaseOptions.currentPlatform;
