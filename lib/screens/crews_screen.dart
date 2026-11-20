import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/rooms.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../l10n/app_localizations_context.dart';
import '../providers/app_providers.dart';
import '../providers/room_providers.dart';
import '../widgets/brand_kit.dart';
import '../widgets/room_widgets.dart';

class CrewsScreen extends ConsumerWidget {
  const CrewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crews = ref.watch(crewsProvider);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.yourCrews),
        actions: [
          IconButton(
            tooltip: l10n.createCrew,
            onPressed: () => context.push(Routes.newCrew),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: crews.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) {
              debugPrint('Could not load crews: $error');
              return _CrewError(message: l10n.couldNotLoadCrews);
            },
            data: (items) => items.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: SurfaceCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.groups_rounded,
                            color: context.colors.accent,
                            size: 38,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            l10n.goodThingsShared,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.bringPeopleTogether,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: context.colors.muted,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 18),
                          FilledButton.icon(
                            onPressed: () => context.push(Routes.newCrew),
                            icon: const Icon(Icons.add_rounded),
                            label: Text(l10n.createCrew),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(22, 14, 22, 32),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final crew = items[index];
                      return SurfaceCard(
                        onTap: () => context.push('${Routes.crew}/${crew.id}'),
                        child: Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: context.colors.accentSoft,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  crew.emoji ?? (crew.isCouple ? '🍽️' : '✦'),
                                  style: TextStyle(
                                    color: context.colors.accent,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    crew.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${l10n.membersCount(crew.memberIds.length)}'
                                    '${crew.isCouple ? ' · ${l10n.twoPersonCrew}' : ''}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: context.colors.muted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right_rounded,
                                color: context.colors.subtle),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class CrewEditorScreen extends ConsumerStatefulWidget {
  const CrewEditorScreen({super.key});

  @override
  ConsumerState<CrewEditorScreen> createState() => _CrewEditorScreenState();
}

class _CrewEditorScreenState extends ConsumerState<CrewEditorScreen> {
  final _name = TextEditingController();
  final _emoji = TextEditingController(text: '✦');
  bool _isCouple = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _emoji.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (_saving) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    if (_name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.crewNameRequired)),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final id = await ref.read(roomRepositoryProvider).createCrew(
            ownerId: user.id,
            email: user.email,
            displayName: user.displayName ?? '',
            name: _name.text,
            isCouple: _isCouple,
            emoji: _emoji.text.trim().isEmpty ? null : _emoji.text.trim(),
          );
      if (mounted) context.go('${Routes.crew}/$id');
    } catch (error) {
      debugPrint('Could not create crew: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.couldNotCreateCrew)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.createCrew)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              Text(
                context.l10n.gatherYourCrew,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.inviteEveryoneOnce,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: context.colors.muted, height: 1.45),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  SizedBox(
                    width: 76,
                    child: TextField(
                      controller: _emoji,
                      textAlign: TextAlign.center,
                      maxLength: 2,
                      decoration: InputDecoration(
                        labelText: context.l10n.mark,
                        counterText: '',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _name,
                      maxLength: 60,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: context.l10n.crewName,
                        hintText: context.l10n.crewNameHint,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SwitchListTile.adaptive(
                value: _isCouple,
                onChanged: (value) => setState(() => _isCouple = value),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  context.l10n.twoPersonCrewTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(context.l10n.twoPersonCrewDescription),
                secondary: const Icon(Icons.restaurant_menu_rounded),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saving ? null : _create,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.groups_rounded),
                label: Text(context.l10n.createCrew),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CrewDetailScreen extends ConsumerWidget {
  const CrewDetailScreen({super.key, required this.crewId});

  final String crewId;

  Future<void> _invite(
    BuildContext context,
    WidgetRef ref,
    Crew crew,
    String userId,
  ) async {
    final email = await showDialog<String>(
      context: context,
      builder: (context) => const _InviteCrewDialog(),
    );
    if (email == null || !context.mounted) return;
    try {
      await ref.read(roomRepositoryProvider).inviteToCrew(
            crew: crew,
            invitedBy: userId,
            inviteeEmail: email,
          );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.crewInvitationSent)),
        );
      }
    } catch (error) {
      debugPrint('Could not send crew invitation: $error');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.couldNotSendCrewInvitation)),
        );
      }
    }
  }

  Future<void> _rename(
    BuildContext context,
    WidgetRef ref,
    Crew crew,
    String userId,
  ) async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => _RenameCrewDialog(initialName: crew.name),
    );
    if (name == null || !context.mounted) return;
    try {
      await ref.read(roomRepositoryProvider).renameCrew(
            crew: crew,
            actorId: userId,
            name: name,
          );
    } catch (error) {
      debugPrint('Could not rename crew: $error');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.couldNotRenameCrew)),
        );
      }
    }
  }

  Future<void> _leave(
    BuildContext context,
    WidgetRef ref,
    Crew crew,
    String userId,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.leaveNamedCrew(crew.name)),
        content: Text(context.l10n.leaveCrewDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.stay),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.leaveCrew),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await ref.read(roomRepositoryProvider).leaveCrew(
            crew: crew,
            userId: userId,
          );
      if (context.mounted) context.go(Routes.crews);
    } catch (error) {
      debugPrint('Could not leave crew: $error');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.couldNotLeaveCrew)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(currentUserProvider);
    final crews = ref.watch(crewsProvider);
    final crew = crews.value?.where((item) => item.id == crewId).firstOrNull;
    final membersAsync = ref.watch(crewMembersProvider(crewId));
    if (crews.isLoading && crew == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (crews.hasError || crew == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.crew)),
        body: _CrewError(
          message:
              crews.hasError ? l10n.couldNotLoadCrew : l10n.crewUnavailable,
        ),
      );
    }
    final isOwner = user?.id == crew.ownerId;
    final canInvite = isOwner && (!crew.isCouple || crew.memberIds.length < 2);
    return Scaffold(
      appBar: AppBar(
        title: Text(crew.name),
        actions: [
          if (isOwner)
            PopupMenuButton<String>(
              onSelected: (action) {
                if (action == 'rename') {
                  _rename(context, ref, crew, user!.id);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'rename',
                  child: Text(l10n.renameCrew),
                ),
              ],
            ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 32),
            children: [
              SurfaceCard(
                child: Row(
                  children: [
                    Text(
                      crew.emoji ?? (crew.isCouple ? '🍽️' : '✦'),
                      style: TextStyle(
                        fontSize: 36,
                        color: context.colors.accent,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            crew.isCouple
                                ? l10n.twoPersonCrew
                                : l10n.standingCrew,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            crew.isCouple
                                ? l10n.mealPlansSharedAutomatically
                                : l10n.sharePlansWithCrew,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.colors.muted,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.members,
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  if (canInvite)
                    FilledButton.icon(
                      onPressed: () => _invite(context, ref, crew, user!.id),
                      icon: const Icon(Icons.person_add_alt_1_rounded),
                      label: Text(l10n.invite),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              membersAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, _) {
                  debugPrint('Could not load crew members: $error');
                  return _CrewError(message: l10n.couldNotLoadCrewMembers);
                },
                data: (members) => Column(
                  children: [
                    for (final member in members)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SurfaceCard(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              UserAvatar(
                                initials: _initials(
                                  member.displayName.isNotEmpty
                                      ? member.displayName
                                      : member.email,
                                ),
                                seed: member.userId,
                                size: 40,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      member.displayName.isNotEmpty
                                          ? member.displayName
                                          : member.email,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    if (member.displayName.isNotEmpty) ...[
                                      const SizedBox(height: 3),
                                      Text(
                                        member.email,
                                        style: TextStyle(
                                          color: context.colors.muted,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (member.isOwner)
                                Text(
                                  l10n.owner,
                                  style: TextStyle(
                                    color: context.colors.accent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (!isOwner) ...[
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => _leave(context, ref, crew, user!.id),
                  icon: const Icon(Icons.exit_to_app_rounded),
                  label: Text(l10n.leaveThisCrew),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _InviteCrewDialog extends StatefulWidget {
  const _InviteCrewDialog();

  @override
  State<_InviteCrewDialog> createState() => _InviteCrewDialogState();
}

class _InviteCrewDialogState extends State<_InviteCrewDialog> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(context.l10n.inviteToYourCrew),
        content: TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: InputDecoration(
            labelText: context.l10n.emailAddress,
            hintText: context.l10n.emailHint,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, _email.text.trim()),
            child: Text(context.l10n.sendInvitation),
          ),
        ],
      );
}

class _RenameCrewDialog extends StatefulWidget {
  const _RenameCrewDialog({required this.initialName});

  final String initialName;

  @override
  State<_RenameCrewDialog> createState() => _RenameCrewDialogState();
}

class _RenameCrewDialogState extends State<_RenameCrewDialog> {
  late final _name = TextEditingController(text: widget.initialName);

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(context.l10n.renameCrew),
        content: TextField(
          controller: _name,
          autofocus: true,
          maxLength: 60,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, _name.text.trim()),
            child: Text(context.l10n.save),
          ),
        ],
      );
}

class _CrewError extends StatelessWidget {
  const _CrewError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(message, textAlign: TextAlign.center),
        ),
      );
}

String _initials(String value) {
  final parts =
      value.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty);
  final result = parts.take(2).map((part) => part[0].toUpperCase()).join();
  return result.isEmpty ? '?' : result;
}
