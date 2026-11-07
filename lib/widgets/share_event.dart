import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../core/models.dart';
import '../services/event_repository.dart';

/// Shares a countdown as plain text.
///
/// This lives in its own file rather than on a screen so the detail screen, the
/// actions sheet and the home screen can all use it without importing each
/// other — which is what a shared helper on a screen widget would force.
///
/// Text-only is deliberate: it is the one share path that behaves identically
/// on Android, iOS and web, with no share backend, no deep-link infrastructure
/// and no uploaded files.
Future<void> shareEvent(BuildContext context, CountdownEvent event) async {
  final text = EventRepository.shareText(event);
  final messenger = ScaffoldMessenger.maybeOf(context);

  try {
    // share_plus 13 replaced the static `Share.share` with an instance API;
    // `SharePlus.instance.share` is the same call through the new entry point.
    await SharePlus.instance.share(
      ShareParams(text: text, subject: 'Countdown: ${event.title}'),
    );
  } catch (_) {
    // If the platform share sheet is unavailable (some desktop browsers, or a
    // device with no share target), show the text so it can still be copied.
    messenger?.showSnackBar(SnackBar(content: Text(text)));
  }
}
