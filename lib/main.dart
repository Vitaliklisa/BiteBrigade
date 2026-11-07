import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode, debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Riverpod 3 moved `Override` out of the main entrypoint; it lives in `misc`.
import 'package:flutter_riverpod/misc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'core/theme.dart';
import 'firebase_config.dart';
import 'providers/app_providers.dart';
import 'router.dart';
import 'services/auth_service.dart';
import 'services/event_repository.dart';

Future<void> main() async {
  // Launch breadcrumbs.
  //
  // The launch path is: Android window (launch_background) -> Flutter engine ->
  // Dart `main` -> first frame, at which point the engine removes the splash.
  // When the app "hangs on the splash", the cause is one of those stages, and
  // these lines make it unambiguous which: filter logcat for `table-talk` to see
  // exactly how far Dart got. Compiled out of release builds entirely.
  _trace('main() entered');
  WidgetsFlutterBinding.ensureInitialized();
  // Use real, hash-free paths on web (`https://…/invitations` rather than
  // `https://…/#/invitations`). Vercel rewrites every path back to the app
  // shell, so deep links resolve on a cold load too. A no-op off the web.
  usePathUrlStrategy();
  _trace('binding ready');

  // This copy must never initialize against the inherited Date Dawn project.
  // Show setup guidance until FlutterFire has generated a separate project
  // configuration for every supported platform.
  if (!hasFirebaseConfig) {
    _trace('Firebase config missing or inherited: showing setup page');
    runApp(const _MissingConfigApp());
    return;
  }

  // Firebase is initialised from the platform config files that `flutterfire
  // configure` generates: android/app/google-services.json,
  // ios/Runner/GoogleService-Info.plist, and `firebaseOptions` for web.
  // See `lib/firebase_config.dart` and the README.
  //
  // On Android the google-services Gradle plugin registers `[DEFAULT]` during
  // process start, before Dart runs. `Firebase.apps` does not always see that
  // natively-created app, so calling `initializeApp` throws
  // `[core/duplicate-app]` and — because `main` awaits it — the app never gets
  // past the splash screen. The app is already usable in that case, so the
  // duplicate is the one error worth swallowing.
  try {
    if (Firebase.apps.isEmpty) {
      _trace('initializing Firebase');
      await Firebase.initializeApp(options: firebaseOptions);
      _trace('Firebase ready');
    } else {
      _trace('Firebase already initialised (native config)');
    }
  } on FirebaseException catch (e) {
    if (e.code != 'duplicate-app') rethrow;
    _trace('duplicate-app ignored');
  }

  if (Firebase.app().options.projectId != firebaseOptions.projectId) {
    _trace('native Firebase project does not match Dart config');
    runApp(const _MissingConfigApp());
    return;
  }

  _trace('calling runApp');
  runApp(const ProviderScope(child: TableTalkApp()));
  _trace('runApp returned (Dart frame scheduled)');
}

/// Launch breadcrumb. No-op in release builds, where `kDebugMode` is false and
/// the whole call is tree-shaken away.
void _trace(String message) {
  if (kDebugMode) debugPrint('[table-talk] $message');
}

/// Shown until a dedicated Table Talk Firebase project is configured.
class _MissingConfigApp extends StatelessWidget {
  const _MissingConfigApp();

  @override
  Widget build(BuildContext context) {
    const palette = AppPalette.dark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(brightness: Brightness.dark),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Firebase is not configured for Table Talk yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: palette.fg,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'This copy must use its own Firebase project, not the '
                    'Date Dawn project. Create a Firebase project for Table '
                    'Talk, then run this from the project root and rebuild:',
                    style: TextStyle(
                        fontSize: 14, height: 1.5, color: palette.muted),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: palette.border),
                    ),
                    child: const SelectableText(
                      'flutterfire configure --project=your-table-talk-project-id',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        color: Color(0xFF4FD1C5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'That generates lib/firebase_options.dart and the native '
                    'configuration files for the new project.',
                    style: TextStyle(
                        fontSize: 13, height: 1.5, color: palette.subtle),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TableTalkApp extends ConsumerWidget {
  const TableTalkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Table Talk',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(brightness: Brightness.light),
      darkTheme: AppTheme.build(brightness: Brightness.dark),
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) => _FirstFrameLogger(
        child: ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox.expand(child: child!),
        ),
      ),
    );
  }
}

/// Logs once, on the first frame the engine actually presents.
class _FirstFrameLogger extends StatefulWidget {
  const _FirstFrameLogger({required this.child});

  final Widget child;

  @override
  State<_FirstFrameLogger> createState() => _FirstFrameLoggerState();
}

class _FirstFrameLoggerState extends State<_FirstFrameLogger> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _trace('first frame rendered — UI is live');
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// Overrides used by tests and by `main` before Firebase is reachable, so the
/// widget tree can be pumped without a live project.
List<Override> buildOverrides({
  AuthService? authService,
  EventRepository? repository,
}) =>
    [
      if (authService != null)
        authServiceProvider.overrideWithValue(authService),
      if (repository != null)
        eventRepositoryProvider.overrideWithValue(repository),
    ];
