import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/circles.dart';
import '../core/models.dart';
import '../core/theme.dart';
import '../l10n/app_localizations_context.dart';
import '../providers/app_providers.dart';

/// One inbox for meal-plan and group invitations.
///
/// A meal-plan invite adds you to one plan, a group invite adds you to a
/// standing crew, and a two-person group invite joins automatically.
class InvitationsInbox extends ConsumerWidget {
  const InvitationsInbox({super.key, this.showWhenEmpty = false});

  /// On the invitations screen an empty inbox still needs to say so; on the
  /// home screen it should take no space at all.
  final bool showWhenEmpty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();

    final eventInvitesAsync = ref.watch(invitationsProvider);
    final circleInvitesAsync = ref.watch(circleInvitationsProvider);
    final eventInvites = eventInvitesAsync.value ?? const <Invitation>[];
    final circleInvites =
        circleInvitesAsync.value ?? const <CircleInvitation>[];
    final hasLoadError =
        eventInvitesAsync.hasError || circleInvitesAsync.hasError;

    if (eventInvites.isEmpty && circleInvites.isEmpty && !hasLoadError) {
      return showWhenEmpty ? const _EmptyInbox() : const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasLoadError) const _InviteLoadError(),
        // The keys are load-bearing, not decoration.
        //
        // These cards are emitted from two separate loops into one `Column`, so
        // without a key Flutter matches them to element slots **by position**.
        // When the first list changes length — exactly what happens the moment a
        // circle invitation is answered — every event card shifts position and
        // is rebuilt as a brand-new widget, discarding its `_busy` flag and the
        // in-flight guard with it. That is what let one Accept/Decline send a
        // stream of requests: each rebuild re-entered the handler on an
        // invitation that had already been settled. A stable key per invitation
        // makes each card keep its own state, so answering one cannot disturb
        // the next.
        for (final invite in circleInvites) ...[
          _CircleInviteCard(
              key: ValueKey('circle-${invite.id}'), invite: invite),
          const SizedBox(height: 10),
        ],
        for (final invite in eventInvites) ...[
          _EventInviteCard(key: ValueKey('event-${invite.id}'), invite: invite),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _InviteLoadError extends StatelessWidget {
  const _InviteLoadError();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        context.l10n.invitationLoadError,
        style: TextStyle(fontSize: 12.5, color: colors.danger),
      ),
    );
  }
}

class _EmptyInbox extends StatelessWidget {
  const _EmptyInbox();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(Icons.mark_email_read_outlined, size: 30, color: colors.subtle),
        const SizedBox(height: 16),
        Text(
          context.l10n.nothingWaitingForYou,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: colors.fg),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.invitationsEmptyDescription,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, height: 1.5, color: colors.muted),
        ),
      ],
    );
  }
}

/// Shared shell for invitations that require an answer or join automatically.
class _InviteShell extends StatelessWidget {
  const _InviteShell({
    required this.eyebrow,
    required this.title,
    required this.body,
    required this.acceptLabel,
    this.onAccept,
    this.onDecline,
    this.automaticStatus,
    this.onRetry,
    this.busy = false,
  });

  final String eyebrow;
  final String title;
  final String body;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final String acceptLabel;
  final String? automaticStatus;
  final VoidCallback? onRetry;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mail_outline_rounded, size: 16, color: colors.accent),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  eyebrow.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.3,
                    color: colors.accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(
            body,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, height: 1.45, color: colors.muted),
          ),
          const SizedBox(height: 16),
          if (automaticStatus != null)
            if (busy)
              Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.accent,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      automaticStatus!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: colors.muted),
                    ),
                  ),
                ],
              )
            else if (onRetry != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    automaticStatus!,
                    style: TextStyle(fontSize: 13, color: colors.danger),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: onRetry,
                    child: Text(context.l10n.retryAddingYou),
                  ),
                ],
              )
            else
              Text(
                automaticStatus!,
                style: TextStyle(fontSize: 13, color: colors.muted),
              )
          else
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(42),
                      backgroundColor:
                          busy ? colors.borderStrong : colors.accent,
                    ),
                    onPressed: busy ? null : onAccept,
                    child: busy
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.accentFg,
                            ),
                          )
                        : Text(acceptLabel),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(42),
                      foregroundColor: colors.danger,
                      side: BorderSide(
                        color: busy
                            ? colors.borderStrong
                            : colors.danger.withValues(alpha: 0.5),
                      ),
                      overlayColor: colors.danger.withValues(alpha: 0.10),
                    ),
                    onPressed: busy ? null : onDecline,
                    child: Text(context.l10n.decline),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _EventInviteCard extends ConsumerStatefulWidget {
  const _EventInviteCard({super.key, required this.invite});

  final Invitation invite;

  @override
  ConsumerState<_EventInviteCard> createState() => _EventInviteCardState();
}

class _EventInviteCardState extends ConsumerState<_EventInviteCard> {
  bool _busy = false;

  /// The key this card claims before writing. The claim lives in a provider, so
  /// it survives the rebuilds and remounts that wiped the old per-card flag.
  String get _claimKey => 'event-${widget.invite.id}';

  bool get _alreadyClaimed =>
      ref.read(invitationSubmissionProvider).contains(_claimKey);

  void _release() {
    ref.read(invitationSubmissionProvider.notifier).release(_claimKey);
  }

  Future<void> _accept() async {
    if (_alreadyClaimed) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final l10n = context.l10n;
    setState(() => _busy = true);
    final confirmed = await _confirm(
      context,
      title: l10n.joinMealPlanQuestion,
      body: l10n.joinMealPlanExplanation,
      action: l10n.join,
    );
    if (!confirmed) {
      if (mounted) setState(() => _busy = false);
      return;
    }
    if (!mounted) return;

    // Claim **synchronously**, after the dialog and before any await. Claiming
    // before the dialog would block every other mounted instance of this same
    // invitation while somebody is still deciding; claiming after an await
    // would let a second tap through in the same frame.
    if (!ref.read(invitationSubmissionProvider.notifier).claim(_claimKey)) {
      if (mounted) setState(() => _busy = false);
      return;
    }

    final claimKey = _claimKey;
    final container = ProviderScope.containerOf(context, listen: false);
    final repository = container.read(eventRepositoryProvider);
    final messenger = ScaffoldMessenger.maybeOf(context);
    var alreadyMember = false;
    final failure = await runAction(
      context,
      () async {
        alreadyMember = await repository.acceptInvitation(
          invitation: widget.invite,
          userId: user.id,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoUrl,
        );
      },
    );
    container.read(invitationSubmissionProvider.notifier).release(claimKey);
    if (failure == null) {
      container.invalidate(eventsProvider);
      messenger?.showSnackBar(
        SnackBar(
          content: Text(
            alreadyMember
                ? l10n.alreadyMemberOf(widget.invite.eventTitle)
                : l10n.joinedNamedMealPlan(widget.invite.eventTitle),
          ),
        ),
      );
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _decline() async {
    if (_alreadyClaimed) return;
    final user = ref.read(currentUserProvider);
    setState(() => _busy = true);
    if (!ref.read(invitationSubmissionProvider.notifier).claim(_claimKey)) {
      if (mounted) setState(() => _busy = false);
      return;
    }
    final failure = await runAction(
      context,
      () => ref.read(eventRepositoryProvider).rejectInvitation(
            widget.invite,
            responderEmail: user?.email,
            responderName: user?.displayName,
            userId: user?.id,
          ),
      successMessage: context.l10n.invitationDeclined,
    );
    if (failure != null) _release();
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final invite = widget.invite;
    final l10n = context.l10n;
    return _InviteShell(
      eyebrow: l10n.mealPlanInvitation,
      title: invite.eventTitle.isEmpty
          ? l10n.unnamedMealPlan
          : '“${invite.eventTitle}”',
      body: l10n.mealPlanInvitationBody(_roleLabel(context, invite.role)),
      acceptLabel: l10n.accept,
      busy: _busy,
      onAccept: _accept,
      onDecline: _decline,
    );
  }
}

class _CircleInviteCard extends ConsumerStatefulWidget {
  const _CircleInviteCard({super.key, required this.invite});

  final CircleInvitation invite;

  @override
  ConsumerState<_CircleInviteCard> createState() => _CircleInviteCardState();
}

class _CircleInviteCardState extends ConsumerState<_CircleInviteCard> {
  bool _busy = false;

  /// See `_EventInviteCardState._claimKey` — the claim lives in a provider so it
  /// survives the rebuilds that reset per-card state.
  String get _claimKey => 'circle-${widget.invite.id}';

  bool get _alreadyClaimed =>
      ref.read(invitationSubmissionProvider).contains(_claimKey);

  void _release() {
    ref.read(invitationSubmissionProvider.notifier).release(_claimKey);
  }

  Future<void> _accept() async {
    if (_alreadyClaimed) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final l10n = context.l10n;
    setState(() => _busy = true);
    if (!ref.read(invitationSubmissionProvider.notifier).claim(_claimKey)) {
      if (mounted) setState(() => _busy = false);
      return;
    }
    final claimKey = _claimKey;
    final container = ProviderScope.containerOf(context, listen: false);
    final repository = container.read(eventRepositoryProvider);
    final messenger = ScaffoldMessenger.maybeOf(context);
    var alreadyMember = false;
    final failure = await runAction(
      context,
      () async {
        alreadyMember = await repository.acceptCircleInvitation(
          invitation: widget.invite,
          userId: user.id,
          email: user.email,
          displayName: user.displayName,
          photoUrl: user.photoUrl,
        );
      },
    );
    container.read(invitationSubmissionProvider.notifier).release(claimKey);
    if (failure == null) {
      container.invalidate(eventsProvider);
      container.invalidate(circlesProvider);
      messenger?.showSnackBar(
        SnackBar(
          content: Text(
            alreadyMember
                ? l10n.alreadyMemberOfCrew(widget.invite.circleName)
                : widget.invite.isCouple
                    ? l10n.addedToNamedCrew(widget.invite.circleName)
                    : l10n.joinedNamedCrew(widget.invite.circleName),
          ),
        ),
      );
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _decline() async {
    if (_alreadyClaimed) return;
    final user = ref.read(currentUserProvider);
    setState(() => _busy = true);
    if (!ref.read(invitationSubmissionProvider.notifier).claim(_claimKey)) {
      if (mounted) setState(() => _busy = false);
      return;
    }
    final failure = await runAction(
      context,
      () => ref.read(eventRepositoryProvider).rejectCircleInvitation(
            widget.invite,
            // Passed so the inviter's notification can name who declined; the
            // sender previously heard nothing at all.
            responderEmail: user?.email,
            responderName: user?.displayName,
            userId: user?.id,
          ),
      successMessage: context.l10n.invitationDeclined,
    );
    if (failure != null) _release();
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final invite = widget.invite;
    final l10n = context.l10n;
    final invitedBy = invite.invitedByName?.trim();
    final from =
        (invitedBy != null && invitedBy.isNotEmpty) ? invitedBy : l10n.someone;

    return _InviteShell(
      eyebrow:
          invite.isCouple ? l10n.twoPersonGroupInvitation : l10n.crewInvitation,
      title: invite.isCouple
          ? l10n.addingYouToCrew(from)
          : l10n.invitedYouToNamedCrew(from, invite.circleName),
      body: invite.isCouple
          ? l10n.automaticCrewInvitationBody(invite.circleName)
          : l10n.namedCrewInvitationBody(invite.circleName),
      acceptLabel: l10n.joinCrew,
      busy: _busy,
      automaticStatus: invite.isCouple
          ? invite.joinError ?? l10n.couldNotAddYouAutomatically
          : null,
      onRetry: invite.isCouple ? _accept : null,
      onAccept: invite.isCouple ? null : _accept,
      onDecline: invite.isCouple ? null : _decline,
    );
  }
}

Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String body,
  required String action,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(context.l10n.notNow),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(88, 42)),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(action),
        ),
      ],
    ),
  );
  return result ?? false;
}

String _roleLabel(BuildContext context, ParticipantRole role) => switch (role) {
      ParticipantRole.admin => context.l10n.roleAdmin,
      ParticipantRole.editor => context.l10n.roleEditor,
      ParticipantRole.viewer => context.l10n.roleViewer,
    };
