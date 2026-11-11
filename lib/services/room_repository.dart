import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/rooms.dart';

class RoomFailure implements Exception {
  const RoomFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

class OptionDraft {
  const OptionDraft({required this.title, this.url, this.address});

  final String title;
  final String? url;
  final String? address;
}

class RoomDraft {
  const RoomDraft({
    required this.name,
    required this.description,
    required this.mealAt,
    required this.options,
    required this.crewIds,
    required this.inviteeEmails,
  });

  final String name;
  final String description;
  final DateTime mealAt;
  final List<OptionDraft> options;
  final List<String> crewIds;
  final List<String> inviteeEmails;
}

class RoomRepository {
  RoomRepository({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _rooms =>
      _db.collection('rooms');
  CollectionReference<Map<String, dynamic>> get _invitations =>
      _db.collection('invitations');
  CollectionReference<Map<String, dynamic>> get _crews =>
      _db.collection('crews');
  CollectionReference<Map<String, dynamic>> get _crewInvitations =>
      _db.collection('crew_invitations');

  Stream<List<Room>> watchRooms(String userId) {
    final queries = <Query<Map<String, dynamic>>>[
      _rooms.where('createdBy', isEqualTo: userId),
      _rooms.where('participantIds', arrayContains: userId),
    ];
    final records = List<Map<String, Room>>.generate(
      queries.length,
      (_) => <String, Room>{},
    );
    final ready = List<bool>.filled(queries.length, false);
    final controller = StreamController<List<Room>>();
    final subscriptions =
        <StreamSubscription<QuerySnapshot<Map<String, dynamic>>>>[];

    void emit() {
      if (!ready.every((value) => value)) return;
      final merged = <String, Room>{};
      for (final source in records) {
        merged.addAll(source);
      }
      final rooms = merged.values.where((room) => !room.isDeleted).toList()
        ..sort((left, right) => left.mealAt.compareTo(right.mealAt));
      controller.add(rooms);
    }

    controller.onListen = () {
      for (var index = 0; index < queries.length; index++) {
        final stream = queries[index].snapshots();
        subscriptions.add(stream.listen(
          (snapshot) {
            ready[index] = true;
            records[index] = {
              for (final doc in snapshot.docs) doc.id: Room.fromDoc(doc),
            };
            emit();
          },
          onError: controller.addError,
        ));
      }
    };
    controller.onCancel = () async {
      await Future.wait(
          subscriptions.map((subscription) => subscription.cancel()));
    };
    return controller.stream;
  }

  Stream<Room?> watchRoom(String roomId) => _rooms.doc(roomId).snapshots().map(
        (snapshot) => snapshot.exists ? Room.fromDoc(snapshot) : null,
      );

  Stream<List<RestaurantOption>> watchOptions(String roomId) => _rooms
      .doc(roomId)
      .collection('options')
      .orderBy('createdAt')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map(RestaurantOption.fromDoc).toList(growable: false));

  Stream<List<RoomParticipant>> watchParticipants(String roomId) => _rooms
      .doc(roomId)
      .collection('participants')
      .where('inviteStatus', isEqualTo: 'accepted')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map(RoomParticipant.fromDoc).toList(growable: false)
            ..sort((left, right) {
              if (left.role == RoomRole.admin) return -1;
              if (right.role == RoomRole.admin) return 1;
              return left.displayName.toLowerCase().compareTo(
                    right.displayName.toLowerCase(),
                  );
            }));

  Stream<List<RoomVote>> watchVotes(String roomId) => _rooms
      .doc(roomId)
      .collection('votes')
      .orderBy('createdAt')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map(RoomVote.fromDoc).toList(growable: false));

  Stream<List<RoomNote>> watchNotes(String roomId) => _rooms
      .doc(roomId)
      .collection('notes')
      .orderBy('createdAt')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map(RoomNote.fromDoc).toList(growable: false));

  Stream<List<Crew>> watchCrews(String userId) => _crews
      .where('memberIds', arrayContains: userId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map(Crew.fromDoc).toList(growable: false));

  Stream<List<CrewMember>> watchCrewMembers(String crewId) => _crews
      .doc(crewId)
      .collection('members')
      .orderBy('joinedAt')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map(CrewMember.fromDoc).toList(growable: false));

  Stream<List<RoomInvitation>> watchRoomInvitations(String email) {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) return Stream.value(const []);
    return _invitations
        .where('inviteeEmail', isEqualTo: normalizedEmail)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .where((doc) => doc.data()['roomId'] is String)
            .map(RoomInvitation.fromDoc)
            .toList(growable: false));
  }

  Stream<List<CrewInvitation>> watchCrewInvitations(String email) {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty) return Stream.value(const []);
    return _crewInvitations
        .where('inviteeEmail', isEqualTo: normalizedEmail)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map(CrewInvitation.fromDoc).toList(growable: false));
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> watchInbox(
    String userId,
  ) =>
      _db
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .snapshots()
          .map((snapshot) => snapshot.docs);

  Future<String> createRoom({
    required String userId,
    required String email,
    required String displayName,
    required RoomDraft draft,
  }) async {
    final name = draft.name.trim();
    if (name.isEmpty || name.length > 80) {
      throw const RoomFailure(
          'Give this decision a name (up to 80 characters).');
    }
    if (draft.options.length < 2 || draft.options.length > 20) {
      throw const RoomFailure('Add between two and twenty restaurant options.');
    }
    if (draft.mealAt.isBefore(DateTime.now())) {
      throw const RoomFailure('Choose a decision time in the future.');
    }
    if (draft.description.trim().length > 1000) {
      throw const RoomFailure('The description can be up to 1000 characters.');
    }
    final options = _validatedOptions(draft.options);
    if (options.length < 2) {
      throw const RoomFailure('Keep at least two restaurant options.');
    }
    final memberCrews =
        await _crews.where('memberIds', arrayContains: userId).get();
    final crews = memberCrews.docs.map(Crew.fromDoc).toList();
    final selected = draft.crewIds.toSet();
    if (selected.any((id) => !crews.any((crew) => crew.id == id))) {
      throw const RoomFailure('You can only share with crews you belong to.');
    }
    selected.addAll(
      crews.where((crew) => crew.isCouple).map((crew) => crew.id),
    );
    if (selected.length > 10) {
      throw const RoomFailure(
        'A decision can be shared with up to ten crews.',
      );
    }
    final crewMembers = <String, Map<String, dynamic>>{};
    final memberCrewIds = <String, Set<String>>{};
    for (final crew in crews.where((crew) => selected.contains(crew.id))) {
      final members = await _crews.doc(crew.id).collection('members').get();
      for (final member in members.docs) {
        if (member.id == userId) continue;
        crewMembers[member.id] = member.data();
        memberCrewIds.putIfAbsent(member.id, () => <String>{}).add(crew.id);
      }
    }
    if (crewMembers.length > 100) {
      throw const RoomFailure(
        'This crew is too large to add to one decision. Invite a smaller group.',
      );
    }

    final roomRef = _rooms.doc();
    final now = DateTime.now();
    final batch = _db.batch();
    batch.set(roomRef, {
      'name': name,
      'description': draft.description.trim(),
      'mealAt': Timestamp.fromDate(draft.mealAt),
      'createdBy': userId,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'status': RoomStatus.open.name,
      'participantIds': [userId, ...crewMembers.keys],
      'participantCount': crewMembers.length + 1,
      'optionCount': options.length,
      'votesCast': 0,
      'votesRevision': 0,
      'sharedWithCrewIds': selected.toList(),
      'winnerOptionId': null,
      'decidedAt': null,
      'deletedAt': null,
    });
    batch.set(roomRef.collection('participants').doc(userId), {
      'email': email.trim().toLowerCase(),
      'displayName': displayName.trim(),
      'role': RoomRole.admin.name,
      'inviteStatus': 'accepted',
      'joinedAt': Timestamp.fromDate(now),
      'isDirect': true,
      'sourceCrewIds': selected.toList(),
    });
    for (final entry in crewMembers.entries) {
      final member = entry.value;
      batch.set(roomRef.collection('participants').doc(entry.key), {
        'email': (member['email'] as String? ?? '').toLowerCase(),
        'displayName': member['displayName'] ?? '',
        'role': RoomRole.editor.name,
        'inviteStatus': 'accepted',
        'joinedAt': member['joinedAt'] ?? FieldValue.serverTimestamp(),
        'isDirect': false,
        'sourceCrewIds': memberCrewIds[entry.key]!.toList(),
      });
    }
    for (final option in options) {
      final ref = roomRef.collection('options').doc();
      batch.set(ref, {
        'title': option.title,
        'url': option.url,
        'address': option.address,
        'createdBy': userId,
        'createdAt': FieldValue.serverTimestamp(),
        'voteCount': 0,
      });
    }
    for (final crewId in selected) {
      batch.set(_crews.doc(crewId).collection('sharedRooms').doc(roomRef.id), {
        'roomId': roomRef.id,
        'sharedWithCrewIds': selected.toList(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();

    final crewEmails = crewMembers.values
        .map((member) => (member['email'] as String? ?? '').toLowerCase())
        .toSet();
    final sentEmails = <String>{email.trim().toLowerCase(), ...crewEmails};
    for (final invitee in draft.inviteeEmails) {
      final normalized = invitee.trim().toLowerCase();
      if (!sentEmails.add(normalized)) continue;
      await inviteToRoom(
        roomId: roomRef.id,
        roomTitle: name,
        invitedBy: userId,
        inviteeEmail: normalized,
        role: RoomRole.editor,
      );
    }
    return roomRef.id;
  }

  Future<void> updateRoom({
    required Room room,
    required String actorId,
    required String name,
    required String description,
    required DateTime mealAt,
    required List<OptionDraft> options,
  }) async {
    if (room.createdBy != actorId) {
      throw const RoomFailure('Only the room creator can edit this decision.');
    }
    final cleanName = name.trim();
    if (cleanName.isEmpty || cleanName.length > 80) {
      throw const RoomFailure(
          'Give this decision a name (up to 80 characters).');
    }
    if (mealAt.isBefore(DateTime.now())) {
      throw const RoomFailure('Choose a decision time in the future.');
    }
    final validOptions = _validatedOptions(options);
    if (validOptions.length < 2 || validOptions.length > 20) {
      throw const RoomFailure('Add between two and twenty restaurant options.');
    }
    if (description.trim().length > 1000) {
      throw const RoomFailure('The description can be up to 1000 characters.');
    }

    final roomRef = _rooms.doc(room.id);
    final oldOptions = await roomRef.collection('options').get();
    final existingVotes = await roomRef.collection('votes').limit(1).get();
    if (existingVotes.docs.isNotEmpty) {
      throw const RoomFailure(
        'Restaurant options cannot change after voting starts.',
      );
    }
    final batch = _db.batch();
    batch.update(roomRef, {
      'name': cleanName,
      'description': description.trim(),
      'mealAt': Timestamp.fromDate(mealAt),
      'optionCount': validOptions.length,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    for (final old in oldOptions.docs) {
      batch.delete(old.reference);
    }
    for (final option in validOptions) {
      final ref = roomRef.collection('options').doc();
      batch.set(ref, {
        'title': option.title,
        'url': option.url,
        'address': option.address,
        'createdBy': actorId,
        'createdAt': FieldValue.serverTimestamp(),
        'voteCount': 0,
      });
    }
    await batch.commit();
  }

  Future<String> duplicateRoom({
    required Room room,
    required List<RestaurantOption> options,
    required String userId,
    required String email,
    required String displayName,
    required DateTime mealAt,
  }) =>
      createRoom(
        userId: userId,
        email: email,
        displayName: displayName,
        draft: RoomDraft(
          name: room.name,
          description: room.description,
          mealAt: mealAt,
          options: options
              .map((option) => OptionDraft(
                    title: option.title,
                    url: option.url,
                    address: option.address,
                  ))
              .toList(),
          crewIds: room.sharedWithCrewIds,
          inviteeEmails: const [],
        ),
      );

  Future<void> softDeleteRoom(Room room, String userId) async {
    if (room.createdBy != userId) {
      throw const RoomFailure(
          'Only the room creator can cancel this decision.');
    }
    await _rooms.doc(room.id).update({
      'status': RoomStatus.cancelled.name,
      'deletedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> inviteToRoom({
    required String roomId,
    required String roomTitle,
    required String invitedBy,
    required String inviteeEmail,
    required RoomRole role,
  }) async {
    final email = inviteeEmail.trim().toLowerCase();
    if (email.isEmpty || !email.contains('@')) {
      throw const RoomFailure('Enter a valid email address.');
    }
    final owner = await _db.collection('users').doc(invitedBy).get();
    final ownerEmail = (owner.data()?['email'] as String? ?? '').toLowerCase();
    if (email == ownerEmail) {
      throw const RoomFailure('You cannot invite yourself.');
    }
    final existing = await _db
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (existing.docs.isNotEmpty) {
      final participant = await _rooms
          .doc(roomId)
          .collection('participants')
          .doc(existing.docs.first.id)
          .get();
      if (participant.data()?['inviteStatus'] == 'accepted') {
        throw const RoomFailure('This person is already in the decision.');
      }
    }
    final inviteRef = _invitations.doc();
    final batch = _db.batch();
    batch.set(inviteRef, {
      'roomId': roomId,
      'invitedBy': invitedBy,
      'inviteeEmail': email,
      'role': role.name,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt':
          Timestamp.fromDate(DateTime.now().add(const Duration(days: 30))),
      'roomTitle': roomTitle,
      if (existing.docs.isNotEmpty) 'inviteeId': existing.docs.first.id,
    });
    if (existing.docs.isNotEmpty) {
      final invitee = existing.docs.first;
      batch.set(_rooms.doc(roomId).collection('participants').doc(invitee.id), {
        'email': email,
        'displayName': invitee.data()['displayName'] ?? '',
        'role': role.name,
        'inviteStatus': 'pending',
        'joinedAt': FieldValue.serverTimestamp(),
        'isDirect': true,
        'sourceCrewIds': <String>[],
        'invitationId': inviteRef.id,
      });
      _writeNotification(
        batch,
        invitee.id,
        'You have a new dinner decision',
        'You were invited to "$roomTitle".',
        'invitation',
      );
    }
    await batch.commit();
  }

  Future<void> respondToRoomInvitation({
    required RoomInvitation invitation,
    required String userId,
    required String email,
    required String displayName,
    required bool accept,
  }) async {
    final invitationRef = _invitations.doc(invitation.id);
    final roomRef = _rooms.doc(invitation.roomId);
    final participantRef = roomRef.collection('participants').doc(userId);
    final profileRef = _db.collection('users').doc(userId);
    final responseRef = _db.collection('responses').doc();
    await _db.runTransaction((transaction) async {
      final inviteSnapshot = await transaction.get(invitationRef);
      if (!inviteSnapshot.exists) {
        throw const RoomFailure('This invitation is no longer available.');
      }
      final invite = inviteSnapshot.data()!;
      if (invite['status'] != 'pending' ||
          (invite['inviteeEmail'] as String? ?? '').toLowerCase() !=
              email.toLowerCase()) {
        throw const RoomFailure('This invitation is no longer available.');
      }
      final oldParticipant = await transaction.get(participantRef);
      final wasAccepted = oldParticipant.data()?['inviteStatus'] == 'accepted';
      final existingSourceCrewIds =
          (oldParticipant.data()?['sourceCrewIds'] as Iterable?)
                  ?.whereType<String>()
                  .toList() ??
              const <String>[];
      final decision = accept ? 'accepted' : 'declined';
      transaction.update(invitationRef, {'status': decision});
      if (accept) {
        transaction.set(participantRef, {
          'email': email.toLowerCase(),
          'displayName': displayName,
          'role': invite['role'] ?? RoomRole.editor.name,
          'inviteStatus': 'accepted',
          'joinedAt': FieldValue.serverTimestamp(),
          'isDirect': true,
          'sourceCrewIds': existingSourceCrewIds,
          'invitationId': invitation.id,
        });
        transaction.update(roomRef, {
          'participantIds': FieldValue.arrayUnion([userId]),
          if (!wasAccepted) 'participantCount': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        transaction.set(participantRef, {
          'email': email.toLowerCase(),
          'displayName': displayName,
          'role': invite['role'] ?? RoomRole.editor.name,
          'inviteStatus': 'declined',
          'joinedAt': FieldValue.serverTimestamp(),
          'isDirect': true,
          'sourceCrewIds': existingSourceCrewIds,
          'invitationId': invitation.id,
        });
      }
      _writeNotification(
        null,
        invite['invitedBy'] as String,
        accept ? 'Invitation accepted' : 'Invitation declined',
        '${displayName.isEmpty ? email : displayName} '
            '${accept ? 'joined' : 'declined'} '
            '"${invite['roomTitle'] ?? 'the decision'}".',
        'invitation',
        transaction: transaction,
        reference: responseRef,
      );
      transaction.set(responseRef, {
        'recipientId': invite['invitedBy'],
        'roomId': invitation.roomId,
        'roomTitle': invite['roomTitle'] ?? 'Dinner decision',
        'responderEmail': email,
        'responderName': displayName,
        'accepted': accept,
        'respondedAt': FieldValue.serverTimestamp(),
        'read': false,
      });
      transaction.set(
          profileRef,
          {
            'email': email.toLowerCase(),
            'displayName': displayName,
          },
          SetOptions(merge: true));
    });
  }

  Future<void> vote({
    required String roomId,
    required String userId,
    required String optionId,
  }) async {
    final roomRef = _rooms.doc(roomId);
    final voteRef = roomRef.collection('votes').doc(userId);
    final targetRef = roomRef.collection('options').doc(optionId);
    await _db.runTransaction((transaction) async {
      final roomSnapshot = await transaction.get(roomRef);
      final targetSnapshot = await transaction.get(targetRef);
      final oldVoteSnapshot = await transaction.get(voteRef);
      if (!roomSnapshot.exists ||
          !targetSnapshot.exists ||
          roomSnapshot.data()?['status'] != RoomStatus.open.name) {
        throw const RoomFailure('This decision is no longer accepting votes.');
      }
      final oldOptionId = oldVoteSnapshot.data()?['optionId'] as String?;
      if (oldOptionId == optionId) return;

      DocumentSnapshot<Map<String, dynamic>>? oldOptionSnapshot;
      if (oldOptionId != null) {
        oldOptionSnapshot = await transaction.get(
          roomRef.collection('options').doc(oldOptionId),
        );
      }
      if (oldOptionSnapshot != null && oldOptionSnapshot.exists) {
        final oldCount =
            (oldOptionSnapshot.data()?['voteCount'] as num?)?.toInt() ?? 0;
        transaction.update(oldOptionSnapshot.reference, {
          'voteCount': oldCount > 0 ? oldCount - 1 : 0,
        });
      }
      final targetCount =
          (targetSnapshot.data()?['voteCount'] as num?)?.toInt() ?? 0;
      transaction.update(targetRef, {'voteCount': targetCount + 1});
      transaction.set(voteRef, {
        'userId': userId,
        'optionId': optionId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.update(roomRef, {
        'votesRevision': FieldValue.increment(1),
        if (!oldVoteSnapshot.exists) 'votesCast': FieldValue.increment(1),
      });
      final creatorId = roomSnapshot.data()?['createdBy'] as String?;
      if (creatorId != null && creatorId != userId) {
        _writeNotification(
          null,
          creatorId,
          'A vote is in',
          'Someone voted in "${roomSnapshot.data()?['name'] ?? 'your room'}".',
          'system',
          transaction: transaction,
          reference: _db
              .collection('users')
              .doc(creatorId)
              .collection('notifications')
              .doc(),
        );
      }
    });
  }

  Future<void> finalizeRoom(String roomId) async {
    final roomRef = _rooms.doc(roomId);
    final initialSnapshot = await roomRef.get();
    if (!initialSnapshot.exists) return;
    final initialRoom = Room.fromDoc(initialSnapshot);
    final participantsSnapshot = await roomRef
        .collection('participants')
        .where('inviteStatus', isEqualTo: 'accepted')
        .get();
    final votesSnapshot = await roomRef.collection('votes').get();
    final optionsSnapshot = await roomRef.collection('options').get();
    final participantIds =
        participantsSnapshot.docs.map((doc) => doc.id).toSet();
    final votes =
        votesSnapshot.docs.map(RoomVote.fromDoc).toList(growable: false);
    final voteIds = votes.map((vote) => vote.userId).toSet();
    final options = optionsSnapshot.docs.map(RestaurantOption.fromDoc).toList();

    await _db.runTransaction((transaction) async {
      final roomSnapshot = await transaction.get(roomRef);
      if (!roomSnapshot.exists) return;
      final room = Room.fromDoc(roomSnapshot);
      if (room.status != RoomStatus.open ||
          room.votesRevision != initialRoom.votesRevision ||
          room.participantCount != initialRoom.participantCount ||
          !room.updatedAt.isAtSameMomentAs(initialRoom.updatedAt)) {
        return;
      }
      if (!roomIsReadyToDecide(
        room: room,
        acceptedParticipantIds: participantIds,
        votedUserIds: voteIds,
        now: DateTime.now(),
      )) {
        return;
      }
      final winnerId = resolveWinnerOptionId(options, votes);
      transaction.update(roomRef, {
        'status': RoomStatus.decided.name,
        'winnerOptionId': winnerId,
        'decidedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      for (final participantId
          in participantIds.where((id) => id != room.createdBy)) {
        _writeNotification(
          null,
          participantId,
          'Dinner is decided',
          'The group picked "${room.name}".',
          'system',
          transaction: transaction,
          reference: _db
              .collection('users')
              .doc(participantId)
              .collection('notifications')
              .doc(),
        );
      }
    });
  }

  Future<void> addNote({
    required String roomId,
    required String userId,
    required String text,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty || cleanText.length > 500) {
      throw const RoomFailure('Notes must be between 1 and 500 characters.');
    }
    await _rooms.doc(roomId).collection('notes').add({
      'userId': userId,
      'text': cleanText,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String> createCrew({
    required String ownerId,
    required String email,
    required String displayName,
    required String name,
    required bool isCouple,
    String? emoji,
  }) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty || cleanName.length > 60) {
      throw const RoomFailure('Give your crew a name (up to 60 characters).');
    }
    final existingCrews =
        await _crews.where('memberIds', arrayContains: ownerId).get();
    if (existingCrews.docs.length >= 10) {
      throw const RoomFailure('You can belong to up to ten crews.');
    }
    final crewRef = _crews.doc();
    final batch = _db.batch();
    batch.set(crewRef, {
      'name': cleanName,
      'ownerId': ownerId,
      'memberIds': [ownerId],
      'isCouple': isCouple,
      'emoji': emoji,
      'createdAt': FieldValue.serverTimestamp(),
    });
    batch.set(crewRef.collection('members').doc(ownerId), {
      'email': email.toLowerCase(),
      'displayName': displayName,
      'isOwner': true,
      'joinedAt': FieldValue.serverTimestamp(),
    });
    await batch.commit();
    return crewRef.id;
  }

  Future<void> renameCrew({
    required Crew crew,
    required String actorId,
    required String name,
  }) async {
    final cleanName = name.trim();
    if (crew.ownerId != actorId) {
      throw const RoomFailure('Only the crew owner can rename this crew.');
    }
    if (cleanName.isEmpty || cleanName.length > 60) {
      throw const RoomFailure('Give your crew a name (up to 60 characters).');
    }
    await _crews.doc(crew.id).update({'name': cleanName});
  }

  Future<void> inviteToCrew({
    required Crew crew,
    required String invitedBy,
    required String inviteeEmail,
  }) async {
    if (crew.ownerId != invitedBy) {
      throw const RoomFailure('Only the crew owner can invite people.');
    }
    if (crew.isCouple && crew.memberIds.length >= 2) {
      throw const RoomFailure('A two-person crew can have two members.');
    }
    final email = inviteeEmail.trim().toLowerCase();
    if (email.isEmpty || !email.contains('@')) {
      throw const RoomFailure('Enter a valid email address.');
    }
    final owner = await _db.collection('users').doc(invitedBy).get();
    if (email == (owner.data()?['email'] as String? ?? '').toLowerCase()) {
      throw const RoomFailure('You cannot invite yourself.');
    }
    final existing = await _db
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (existing.docs.isNotEmpty &&
        crew.memberIds.contains(existing.docs.first.id)) {
      throw const RoomFailure('This person is already in the crew.');
    }
    final inviteRef = _crewInvitations.doc();
    final batch = _db.batch();
    batch.set(inviteRef, {
      'crewId': crew.id,
      'invitedBy': invitedBy,
      'inviteeEmail': email,
      'crewName': crew.name,
      'isCouple': crew.isCouple,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt':
          Timestamp.fromDate(DateTime.now().add(const Duration(days: 30))),
      if (existing.docs.isNotEmpty) 'inviteeId': existing.docs.first.id,
    });
    if (existing.docs.isNotEmpty) {
      _writeNotification(
        batch,
        existing.docs.first.id,
        'You have a crew invitation',
        'You were invited to "${crew.name}".',
        'circle',
      );
    }
    await batch.commit();
  }

  Future<void> respondToCrewInvitation({
    required String invitationId,
    required String userId,
    required String email,
    required String displayName,
    required bool accept,
  }) async {
    final inviteRef = _crewInvitations.doc(invitationId);
    String? acceptedCrewId;
    await _db.runTransaction((transaction) async {
      final inviteSnapshot = await transaction.get(inviteRef);
      if (!inviteSnapshot.exists) {
        throw const RoomFailure('This crew invitation is no longer available.');
      }
      final invitation = inviteSnapshot.data()!;
      if (invitation['status'] != 'pending' ||
          (invitation['inviteeEmail'] as String? ?? '').toLowerCase() !=
              email.toLowerCase()) {
        throw const RoomFailure('This crew invitation is no longer available.');
      }
      final crewId = invitation['crewId'] as String;
      final crewRef = _crews.doc(crewId);
      transaction
          .update(inviteRef, {'status': accept ? 'accepted' : 'declined'});
      if (accept) {
        acceptedCrewId = crewId;
        transaction.update(crewRef, {
          'memberIds': FieldValue.arrayUnion([userId]),
          'lastInvitationId': invitationId,
        });
        transaction.set(crewRef.collection('members').doc(userId), {
          'email': email.toLowerCase(),
          'displayName': displayName,
          'isOwner': false,
          'joinedAt': FieldValue.serverTimestamp(),
          'invitationId': invitationId,
        });
        transaction.set(
            _db.collection('users').doc(userId),
            {
              'email': email.toLowerCase(),
              'displayName': displayName,
            },
            SetOptions(merge: true));
        _writeNotification(
          null,
          invitation['invitedBy'] as String,
          'Someone joined your crew',
          '${displayName.isEmpty ? email : displayName} joined '
              '"${invitation['crewName'] ?? 'the crew'}".',
          'circle',
          transaction: transaction,
          reference: _db
              .collection('users')
              .doc(invitation['invitedBy'] as String)
              .collection('notifications')
              .doc(),
        );
      }
    });
    if (acceptedCrewId != null) {
      await _addCrewMemberToSharedRooms(
        crewId: acceptedCrewId!,
        userId: userId,
        email: email,
        displayName: displayName,
      );
    }
  }

  Future<void> leaveCrew({
    required Crew crew,
    required String userId,
  }) async {
    if (crew.ownerId == userId) {
      throw const RoomFailure(
        'The owner cannot leave their crew. Delete it from crew settings instead.',
      );
    }
    final sharedRooms =
        await _crews.doc(crew.id).collection('sharedRooms').get();
    final batch = _db.batch();
    batch.update(_crews.doc(crew.id), {
      'memberIds': FieldValue.arrayRemove([userId]),
    });
    batch.delete(_crews.doc(crew.id).collection('members').doc(userId));
    await batch.commit();
    final remainingCrews =
        await _crews.where('memberIds', arrayContains: userId).get();
    await _removeCrewMemberFromSharedRooms(
      crewId: crew.id,
      userId: userId,
      remainingCrewIds: remainingCrews.docs.map((doc) => doc.id).toList(),
      sharedRooms: sharedRooms.docs,
    );
  }

  Future<void> _addCrewMemberToSharedRooms({
    required String crewId,
    required String userId,
    required String email,
    required String displayName,
  }) async {
    final sharedRooms =
        await _crews.doc(crewId).collection('sharedRooms').get();
    for (var start = 0; start < sharedRooms.docs.length; start += 200) {
      final batch = _db.batch();
      for (final sharedRoom in sharedRooms.docs.skip(start).take(200)) {
        final roomRef = _rooms.doc(sharedRoom.id);
        final participantRef = roomRef.collection('participants').doc(userId);
        final previousParticipant = await participantRef.get();
        final wasAccepted =
            previousParticipant.data()?['inviteStatus'] == 'accepted';
        batch.update(roomRef, {
          'participantIds': FieldValue.arrayUnion([userId]),
          if (!wasAccepted) 'participantCount': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        batch.set(
            participantRef,
            {
              'email': email.toLowerCase(),
              'displayName': displayName,
              'role': RoomRole.editor.name,
              'inviteStatus': 'accepted',
              'joinedAt': FieldValue.serverTimestamp(),
              'isDirect': previousParticipant.data()?['isDirect'] == true,
              'sourceCrewIds': FieldValue.arrayUnion([crewId]),
              'lastAddedCrewId': crewId,
            },
            SetOptions(merge: true));
      }
      await batch.commit();
    }
  }

  Future<void> _removeCrewMemberFromSharedRooms({
    required String crewId,
    required String userId,
    required List<String> remainingCrewIds,
    required List<QueryDocumentSnapshot<Map<String, dynamic>>> sharedRooms,
  }) async {
    for (var start = 0; start < sharedRooms.length; start += 200) {
      final batch = _db.batch();
      for (final sharedRoom in sharedRooms.skip(start).take(200)) {
        final sharedCrewIds =
            (sharedRoom.data()['sharedWithCrewIds'] as Iterable?)
                    ?.whereType<String>()
                    .toSet() ??
                const <String>{};
        final stillShared = sharedCrewIds.any(remainingCrewIds.contains);
        final roomRef = _rooms.doc(sharedRoom.id);
        final participantRef = roomRef.collection('participants').doc(userId);
        final participant = await participantRef.get();
        final data = participant.data();
        if (data == null) continue;
        if (stillShared || data['isDirect'] == true) {
          batch.update(participantRef, {
            'sourceCrewIds': FieldValue.arrayRemove([crewId]),
            'lastRemovedCrewId': crewId,
          });
        } else {
          batch.update(roomRef, {
            'participantIds': FieldValue.arrayRemove([userId]),
            'participantCount': FieldValue.increment(-1),
            'updatedAt': FieldValue.serverTimestamp(),
          });
          batch.set(
            participantRef,
            {
              'inviteStatus': 'removed',
              'sourceCrewIds': FieldValue.arrayRemove([crewId]),
              'lastRemovedCrewId': crewId,
            },
            SetOptions(merge: true),
          );
        }
      }
      await batch.commit();
    }
  }

  List<OptionDraft> _validatedOptions(List<OptionDraft> options) {
    final valid = <OptionDraft>[];
    for (final option in options) {
      final title = option.title.trim();
      final url = option.url?.trim() ?? '';
      final address = option.address?.trim() ?? '';
      if (title.isEmpty) continue;
      if (title.length > 100 || url.length > 500 || address.length > 200) {
        throw const RoomFailure('One of the restaurant details is too long.');
      }
      if (url.isNotEmpty &&
          (Uri.tryParse(url) == null ||
              !{'http', 'https'}.contains(Uri.tryParse(url)!.scheme) ||
              Uri.tryParse(url)!.host.isEmpty)) {
        throw const RoomFailure(
          'Restaurant links must start with http:// or https://.',
        );
      }
      valid.add(OptionDraft(
        title: title,
        url: url.isEmpty ? null : url,
        address: address.isEmpty ? null : address,
      ));
    }
    return valid;
  }

  void _writeNotification(
    WriteBatch? batch,
    String recipientId,
    String title,
    String body,
    String type, {
    Transaction? transaction,
    DocumentReference<Map<String, dynamic>>? reference,
  }) {
    final ref = reference ??
        _db
            .collection('users')
            .doc(recipientId)
            .collection('notifications')
            .doc();
    final data = {
      'title': title,
      'body': body,
      'type': type,
      'read': false,
      'createdAt': FieldValue.serverTimestamp(),
    };
    if (transaction != null) {
      transaction.set(ref, data);
    } else if (batch != null) {
      batch.set(ref, data);
    } else {
      throw StateError('A batch or transaction is required for notifications.');
    }
  }
}
