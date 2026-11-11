import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../widgets/brand_kit.dart';

/// EU (GDPR) and Canada (PIPEDA) compliant Privacy Policy and Terms of Service screen.
///
/// **Back is explicit, not a `pop`.** The page is opened with `go` inside the
/// shell (a `push` of a sibling route there is silently ignored — see
/// `Routes.privacy`), so there is no stack of Flutter routes to pop. Closing
/// goes through [closeLegalPage], which knows which page opened this one and
/// falls back to Support when the URL was loaded cold.
class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key, required this.isPrivacy});

  final bool isPrivacy;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final title = isPrivacy ? 'Privacy Policy' : 'Terms of Service';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: HoverTintIconButton(
          icon: Icons.arrow_back_rounded,
          tooltip: 'Back',
          onPressed: () => closeLegalPage(context),
        ),
      ),
      // As a layer over the shell the page has to cover everything beneath it,
      // or the page it was opened from shows through and stays tappable.
      backgroundColor: colors.canvas,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
        children: [
          const SizedBox(height: 6),
          Text(
            'Last updated: November 2026',
            style: TextStyle(fontSize: 12.5, color: colors.subtle),
          ),
          const SizedBox(height: 24),
          if (isPrivacy) ...[
            const _Section(
              title: '1. Introduction & Data Controller',
              body:
                  'Bite Brigade ("we", "our", or "us") explains here how information is handled when you use the app. For privacy questions or requests, contact: $supportEmailAddress',
            ),
            const _Section(
              title: '2. Information We Collect',
              body:
                  '• Account data: email address and display name used for sign-in.\n• Room content: decision names, descriptions, meal times, restaurant options and details, votes, and notes.\n• Sharing data: crew membership, invitations, and participant roles.\n• In-app notification records related to invitations and room activity.\n\nThis app does not need your contacts or location to provide its core features.',
            ),
            const _Section(
              title: '3. Legal Basis for Processing (EU GDPR)',
              body:
                  'Information is used to provide sign-in, save and share dinner decisions, record votes, deliver in-app updates, and maintain service security. Where local law requires a specific legal basis or consent, the service operator is responsible for providing it.',
            ),
            const _Section(
              title: '4. Sharing',
              body:
                  'Room information is visible to the room creator and accepted participants. Decisions shared with a crew are also visible to that crew’s members. Invitation email addresses are used to deliver invitations. Do not add information you do not want those people to see.',
            ),
            const _Section(
              title: '5. Storage & Security',
              body:
                  'The app uses Firebase Authentication and Cloud Firestore. Data is transmitted over encrypted connections and access is governed by the Firestore security rules deployed for the configured Bite Brigade project. No system can guarantee absolute security.',
            ),
            const _Section(
                title: '6. Retention & Requests',
                body:
                    'Room and account information is retained in the configured Firebase project until deleted by the user or service operator. To ask about access, correction, or deletion of information, contact $supportEmailAddress. Requests are handled subject to applicable law and identity verification.'),
            const _Section(
              title: '7. Children',
              body:
                  'Bite Brigade is not intended for children under 13. Do not use the service if you are below the minimum age required where you live.',
            ),
          ] else ...[
            const _Section(
              title: '1. Acceptance of Terms',
              body:
                  'By using Bite Brigade, you agree to these terms. If you do not agree, do not use the app.',
            ),
            const _Section(
              title: '2. Use of the Service',
              body:
                  'Bite Brigade helps people organize restaurant decisions. Use it lawfully and respectfully. Do not misuse invitations, submit harmful or unlawful content, interfere with the service, or attempt to bypass access controls.',
            ),
            const _Section(
              title: '3. User Content & Ownership',
              body:
                  'You retain rights you hold in the room details, restaurant options, notes, and other content you submit. You authorize the service to store and display that content to you and the room or crew members you choose to share it with.',
            ),
            const _Section(
              title: '4. Accounts & Content',
              body:
                  'You are responsible for activity under your account and for the content you submit. Contact $supportEmailAddress with account or data requests. The service operator may restrict access where reasonably necessary to protect users or the service.',
            ),
            const _Section(
              title: '5. Availability',
              body:
                  'The app is provided on an “as available” basis. Restaurant information and user-submitted content may be incomplete or out of date; verify details directly with the restaurant.',
            ),
          ],
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colors.fg,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              fontSize: 13.5,
              height: 1.55,
              color: colors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
