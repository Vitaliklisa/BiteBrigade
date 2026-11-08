import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/rooms.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../providers/app_providers.dart';
import '../providers/room_providers.dart';
import '../services/room_repository.dart';
import '../widgets/room_widgets.dart';

class RoomEditorScreen extends ConsumerStatefulWidget {
  const RoomEditorScreen({super.key, this.roomId});

  final String? roomId;

  @override
  ConsumerState<RoomEditorScreen> createState() => _RoomEditorScreenState();
}

class _RoomEditorScreenState extends ConsumerState<RoomEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _invitees = TextEditingController();
  final _options = <_OptionFields>[];
  DateTime _mealAt = DateTime.now().add(const Duration(days: 1));
  final Set<String> _crewIds = {};
  Room? _room;
  List<RestaurantOption>? _loadedOptions;
  bool _populated = false;
  bool _saving = false;
  bool _loading = false;
  ProviderSubscription<AsyncValue<Room?>>? _roomSubscription;
  ProviderSubscription<AsyncValue<List<RestaurantOption>>>?
      _optionsSubscription;

  @override
  void initState() {
    super.initState();
    _addOption();
    _addOption();
    _addOption();
    final roomId = widget.roomId;
    if (roomId != null) {
      _loading = true;
      _roomSubscription = ref.listenManual(
        roomProvider(roomId),
        (_, value) => value.whenData((room) {
          if (room != null) {
            _room = room;
            _tryPopulate();
          }
        }),
        fireImmediately: true,
      );
      _optionsSubscription = ref.listenManual(
        roomOptionsProvider(roomId),
        (_, value) => value.whenData((options) {
          _loadedOptions = options;
          _tryPopulate();
        }),
        fireImmediately: true,
      );
    }
  }

  @override
  void dispose() {
    _roomSubscription?.close();
    _optionsSubscription?.close();
    _name.dispose();
    _description.dispose();
    _invitees.dispose();
    for (final option in _options) {
      option.dispose();
    }
    super.dispose();
  }

  void _tryPopulate() {
    final room = _room;
    final options = _loadedOptions;
    if (_populated || room == null || options == null) return;
    _populated = true;
    _loading = false;
    _name.text = room.name;
    _description.text = room.description;
    _mealAt = room.mealAt;
    for (final fields in _options) {
      fields.dispose();
    }
    _options
      ..clear()
      ..addAll(options.map(_OptionFields.fromOption));
    while (_options.length < 2) {
      _addOption();
    }
    if (mounted) setState(() {});
  }

  void _addOption() => _options.add(_OptionFields());

  void _removeOption(int index) {
    if (_options.length <= 2 || _saving) return;
    final removed = _options.removeAt(index);
    removed.dispose();
    setState(() {});
  }

  Future<void> _chooseMealTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _mealAt.isAfter(now) ? _mealAt : now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 5),
    );
    if (!mounted || pickedDate == null) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_mealAt),
    );
    if (!mounted || pickedTime == null) return;
    setState(() {
      _mealAt = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final options = _options
        .map((fields) => OptionDraft(
              title: fields.title.text,
              url: fields.url.text,
              address: fields.address.text,
            ))
        .where((option) => option.title.trim().isNotEmpty)
        .toList();
    setState(() => _saving = true);
    try {
      final repository = ref.read(roomRepositoryProvider);
      if (_room == null) {
        final emails = _invitees.text
            .split(RegExp(r'[,;\n]'))
            .map((email) => email.trim().toLowerCase())
            .where((email) => email.isNotEmpty)
            .toSet()
            .toList();
        final id = await repository.createRoom(
          userId: user.id,
          email: user.email,
          displayName: user.displayName ?? '',
          draft: RoomDraft(
            name: _name.text,
            description: _description.text,
            mealAt: _mealAt,
            options: options,
            crewIds: _crewIds.toList(),
            inviteeEmails: emails,
          ),
        );
        if (mounted) context.go('${Routes.room}/$id');
      } else {
        await repository.updateRoom(
          room: _room!,
          actorId: user.id,
          name: _name.text,
          description: _description.text,
          mealAt: _mealAt,
          options: options,
        );
        if (mounted) context.go('${Routes.room}/${_room!.id}');
      }
    } on RoomFailure catch (error) {
      _showError(error.message);
    } catch (error) {
      _showError('Could not save this decision: $error');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final crews = ref.watch(crewsProvider).value ?? const <Crew>[];
    final canEditOptions = _room == null || _room!.votesCast == 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(_room == null ? 'New decision' : 'Edit decision'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(22, 16, 22, 36),
                    children: [
                      Text(
                        _room == null
                            ? 'Set the scene. We’ll take the votes.'
                            : 'Keep the plan up to date.',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Name the occasion, pick a time, and add places everyone can vote on.',
                        style: TextStyle(color: context.colors.muted),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _name,
                        maxLength: 80,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Decision name',
                          hintText: 'Dinner Friday',
                          prefixIcon: Icon(Icons.edit_note_rounded),
                        ),
                        validator: (value) => value?.trim().isEmpty == true
                            ? 'Add a name for your decision.'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _description,
                        maxLength: 300,
                        maxLines: 3,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'A little context (optional)',
                          hintText: 'A birthday dinner, a team lunch…',
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: _chooseMealTime,
                        icon: const Icon(Icons.calendar_month_rounded),
                        label:
                            Text('Decision time · ${formatMealTime(_mealAt)}'),
                        style: OutlinedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 26),
                      _SectionHeading(
                        title: 'The shortlist',
                        detail: canEditOptions
                            ? 'Add at least two places.'
                            : 'Voting has started, so the shortlist is locked.',
                      ),
                      const SizedBox(height: 12),
                      for (var index = 0; index < _options.length; index++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _OptionEditorRow(
                            fields: _options[index],
                            index: index,
                            enabled: canEditOptions,
                            canRemove: _options.length > 2,
                            onRemove: () => _removeOption(index),
                          ),
                        ),
                      if (canEditOptions)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () => setState(_addOption),
                            icon: const Icon(Icons.add_rounded),
                            label: const Text('Add a restaurant'),
                          ),
                        ),
                      if (_room == null) ...[
                        const SizedBox(height: 20),
                        _SectionHeading(
                          title: 'Share with a crew',
                          detail: crews.any((crew) => crew.isCouple)
                              ? 'Two-person crews share plans automatically.'
                              : 'Crew members can vote without another invite.',
                        ),
                        const SizedBox(height: 10),
                        if (crews.isEmpty)
                          Text(
                            'Create a crew first to plan meals with a group.',
                            style: TextStyle(color: context.colors.muted),
                          )
                        else
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final crew in crews)
                                FilterChip(
                                  selected: _crewIds.contains(crew.id),
                                  onSelected: crew.isCouple
                                      ? null
                                      : (selected) => setState(() {
                                            if (selected) {
                                              _crewIds.add(crew.id);
                                            } else {
                                              _crewIds.remove(crew.id);
                                            }
                                          }),
                                  avatar: Text(crew.emoji ?? '✦'),
                                  label: Text(
                                    crew.isCouple
                                        ? '${crew.name} · always'
                                        : crew.name,
                                  ),
                                ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _invitees,
                          maxLines: 3,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Invite people by email (optional)',
                            hintText: 'alex@example.com, sam@example.com',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                          ),
                        ),
                      ],
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        onPressed: _saving ? null : _save,
                        icon: _saving
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.check_rounded),
                        label: Text(
                            _room == null ? 'Create decision' : 'Save changes'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _OptionFields {
  _OptionFields({
    String title = '',
    String url = '',
    String address = '',
  })  : title = TextEditingController(text: title),
        url = TextEditingController(text: url),
        address = TextEditingController(text: address);

  final TextEditingController title;
  final TextEditingController url;
  final TextEditingController address;

  factory _OptionFields.fromOption(RestaurantOption option) => _OptionFields(
        title: option.title,
        url: option.url ?? '',
        address: option.address ?? '',
      );

  void dispose() {
    title.dispose();
    url.dispose();
    address.dispose();
  }
}

class _OptionEditorRow extends StatelessWidget {
  const _OptionEditorRow({
    required this.fields,
    required this.index,
    required this.enabled,
    required this.canRemove,
    required this.onRemove,
  });

  final _OptionFields fields;
  final int index;
  final bool enabled;
  final bool canRemove;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: fields.title,
                    enabled: enabled,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Restaurant ${index + 1}',
                      hintText: 'e.g. Northside Noodles',
                      prefixIcon: const Icon(Icons.restaurant_rounded),
                    ),
                    validator: (value) =>
                        (value?.trim().isEmpty ?? true) ? 'Add a name.' : null,
                  ),
                ),
                IconButton(
                  tooltip: 'Remove restaurant',
                  onPressed: enabled && canRemove ? onRemove : null,
                  icon: const Icon(Icons.remove_circle_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: fields.address,
              enabled: enabled,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Address (optional)',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: fields.url,
              enabled: enabled,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Website (optional)',
                prefixIcon: Icon(Icons.link_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(detail,
            style: TextStyle(color: context.colors.muted, fontSize: 13)),
      ],
    );
  }
}
