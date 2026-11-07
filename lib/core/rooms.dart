import 'package:cloud_firestore/cloud_firestore.dart';

enum RoomStatus { open, decided, cancelled }

enum RoomRole { admin, editor, viewer }

class Room {
  const Room({
    required this.id,
    required this.name,
    required this.description,
    required this.mealAt,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.participantIds,
    required this.sharedWithCrewIds,
    required this.participantCount,
    required this.votesCast,
    required this.votesRevision,
    this.deletedAt,
    this.winnerOptionId,
    this.decidedAt,
  });

  final String id;
  final String name;
  final String description;
  final DateTime mealAt;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final RoomStatus status;
  final List<String> participantIds;
  final List<String> sharedWithCrewIds;
  final int participantCount;
  final int votesCast;
  final int votesRevision;
  final DateTime? deletedAt;
  final String? winnerOptionId;
  final DateTime? decidedAt;

  bool get isDeleted => deletedAt != null;

  factory Room.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    return Room(
      id: doc.id,
      name: _string(data['name'], 'Untitled decision'),
      description: _string(data['description'], ''),
      mealAt: _date(data['mealAt']),
      createdBy: _string(data['createdBy'], ''),
      createdAt: _date(data['createdAt']),
      updatedAt: _date(data['updatedAt']),
      status: RoomStatus.values.firstWhere(
        (value) => value.name == data['status'],
        orElse: () => RoomStatus.open,
      ),
      participantIds: _strings(data['participantIds']),
      sharedWithCrewIds: _strings(data['sharedWithCrewIds']),
      participantCount: data['participantCount'] is num
          ? (data['participantCount'] as num).toInt()
          : _strings(data['participantIds']).length,
      votesCast:
          data['votesCast'] is num ? (data['votesCast'] as num).toInt() : 0,
      votesRevision: data['votesRevision'] is num
          ? (data['votesRevision'] as num).toInt()
          : 0,
      deletedAt: data['deletedAt'] == null ? null : _date(data['deletedAt']),
      winnerOptionId: data['winnerOptionId'] as String?,
      decidedAt: data['decidedAt'] == null ? null : _date(data['decidedAt']),
    );
  }
}

class RestaurantOption {
  const RestaurantOption({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.createdAt,
    required this.voteCount,
    this.url,
    this.address,
  });

  final String id;
  final String title;
  final String createdBy;
  final DateTime createdAt;
  final int voteCount;
  final String? url;
  final String? address;

  factory RestaurantOption.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};
    return RestaurantOption(
      id: doc.id,
      title: _string(data['title'], 'Restaurant'),
      createdBy: _string(data['createdBy'], ''),
      createdAt: _date(data['createdAt']),
      voteCount:
          data['voteCount'] is num ? (data['voteCount'] as num).toInt() : 0,
      url: data['url'] as String?,
      address: data['address'] as String?,
    );
  }
}

class RoomParticipant {
  const RoomParticipant({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.role,
    required this.inviteStatus,
    required this.joinedAt,
    this.fromCrew = false,
  });

  final String userId;
  final String email;
  final String displayName;
  final RoomRole role;
  final String inviteStatus;
  final DateTime joinedAt;
  final bool fromCrew;

  bool get accepted => inviteStatus == 'accepted';

  factory RoomParticipant.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    bool fromCrew = false,
  }) {
    final data = doc.data() ?? const <String, dynamic>{};
    return RoomParticipant(
      userId: doc.id,
      email: _string(data['email'], ''),
      displayName: _string(data['displayName'], ''),
      role: RoomRole.values.firstWhere(
        (value) => value.name == data['role'],
        orElse: () => fromCrew ? RoomRole.editor : RoomRole.viewer,
      ),
      inviteStatus: _string(
        data['inviteStatus'],
        fromCrew ? 'accepted' : 'pending',
      ),
      joinedAt: _date(data['joinedAt']),
      fromCrew: fromCrew,
    );
  }
}

class RoomVote {
  const RoomVote({
    required this.userId,
    required this.optionId,
    required this.createdAt,
  });

  final String userId;
  final String optionId;
  final DateTime createdAt;

  factory RoomVote.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    return RoomVote(
      userId: doc.id,
      optionId: _string(data['optionId'], ''),
      createdAt: _date(data['createdAt']),
    );
  }
}

class RoomNote {
  const RoomNote({
    required this.id,
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final String text;
  final DateTime createdAt;

  factory RoomNote.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    return RoomNote(
      id: doc.id,
      userId: _string(data['userId'], ''),
      text: _string(data['text'], ''),
      createdAt: _date(data['createdAt']),
    );
  }
}

class Crew {
  const Crew({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.memberIds,
    required this.isCouple,
    required this.createdAt,
    this.emoji,
  });

  final String id;
  final String name;
  final String ownerId;
  final List<String> memberIds;
  final bool isCouple;
  final DateTime createdAt;
  final String? emoji;

  factory Crew.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    return Crew(
      id: doc.id,
      name: _string(data['name'], 'Crew'),
      ownerId: _string(data['ownerId'], ''),
      memberIds: _strings(data['memberIds']),
      isCouple: data['isCouple'] == true,
      createdAt: _date(data['createdAt']),
      emoji: data['emoji'] as String?,
    );
  }
}

class CrewMember {
  const CrewMember({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.isOwner,
    required this.joinedAt,
  });

  final String userId;
  final String email;
  final String displayName;
  final bool isOwner;
  final DateTime joinedAt;

  factory CrewMember.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const <String, dynamic>{};
    return CrewMember(
      userId: doc.id,
      email: _string(data['email'], ''),
      displayName: _string(data['displayName'], ''),
      isOwner: data['isOwner'] == true,
      joinedAt: _date(data['joinedAt']),
    );
  }
}

class RoomInvitation {
  const RoomInvitation({
    required this.id,
    required this.roomId,
    required this.invitedBy,
    required this.inviteeEmail,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.expiresAt,
    required this.roomTitle,
  });

  final String id;
  final String roomId;
  final String invitedBy;
  final String inviteeEmail;
  final RoomRole role;
  final String status;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String roomTitle;

  factory RoomInvitation.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};
    return RoomInvitation(
      id: doc.id,
      roomId: _string(data['roomId'], ''),
      invitedBy: _string(data['invitedBy'], ''),
      inviteeEmail: _string(data['inviteeEmail'], ''),
      role: RoomRole.values.firstWhere(
        (value) => value.name == data['role'],
        orElse: () => RoomRole.viewer,
      ),
      status: _string(data['status'], 'pending'),
      createdAt: _date(data['createdAt']),
      expiresAt: _date(data['expiresAt']),
      roomTitle: _string(data['roomTitle'], 'A Table Talk decision'),
    );
  }
}

class CrewInvitation {
  const CrewInvitation({
    required this.id,
    required this.crewId,
    required this.invitedBy,
    required this.inviteeEmail,
    required this.crewName,
    required this.isCouple,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String crewId;
  final String invitedBy;
  final String inviteeEmail;
  final String crewName;
  final bool isCouple;
  final String status;
  final DateTime createdAt;

  factory CrewInvitation.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};
    return CrewInvitation(
      id: doc.id,
      crewId: _string(data['crewId'], ''),
      invitedBy: _string(data['invitedBy'], ''),
      inviteeEmail: _string(data['inviteeEmail'], ''),
      crewName: _string(data['crewName'], 'Crew'),
      isCouple: data['isCouple'] == true,
      status: _string(data['status'], 'pending'),
      createdAt: _date(data['createdAt']),
    );
  }
}

RoomRole roomRoleFor({
  required Room room,
  required String? userId,
  RoomParticipant? participant,
}) {
  if (userId != null && userId == room.createdBy) return RoomRole.admin;
  if (participant?.accepted == true) return participant!.role;
  return RoomRole.viewer;
}

bool canManageRoom({
  required Room room,
  required String? userId,
  RoomParticipant? participant,
}) =>
    roomRoleFor(room: room, userId: userId, participant: participant) ==
    RoomRole.admin;

bool canEditRoom({
  required Room room,
  required String? userId,
  RoomParticipant? participant,
}) =>
    roomRoleFor(room: room, userId: userId, participant: participant) !=
    RoomRole.viewer;

String? resolveWinnerOptionId(
  List<RestaurantOption> options,
  List<RoomVote> votes,
) {
  if (options.isEmpty) return null;
  final voteCounts = <String, int>{};
  final firstVote = <String, DateTime>{};
  for (final vote in votes) {
    voteCounts.update(
      vote.optionId,
      (voteCount) => voteCount + 1,
      ifAbsent: () => 1,
    );
    final current = firstVote[vote.optionId];
    if (current == null || vote.createdAt.isBefore(current)) {
      firstVote[vote.optionId] = vote.createdAt;
    }
  }

  final ranked = [...options]..sort((left, right) {
      final countOrder =
          (voteCounts[right.id] ?? 0).compareTo(voteCounts[left.id] ?? 0);
      if (countOrder != 0) return countOrder;
      final leftVote = firstVote[left.id] ?? left.createdAt;
      final rightVote = firstVote[right.id] ?? right.createdAt;
      final firstOrder = leftVote.compareTo(rightVote);
      return firstOrder != 0 ? firstOrder : left.id.compareTo(right.id);
    });
  return ranked.first.id;
}

bool roomIsReadyToDecide({
  required Room room,
  required Set<String> acceptedParticipantIds,
  required Set<String> votedUserIds,
  required DateTime now,
}) =>
    room.status == RoomStatus.open &&
    (now.isAfter(room.mealAt) ||
        acceptedParticipantIds.isNotEmpty &&
            acceptedParticipantIds.every(votedUserIds.contains));

String _string(Object? value, String fallback) =>
    value is String ? value : fallback;

List<String> _strings(Object? value) => value is Iterable
    ? value.whereType<String>().toSet().toList(growable: false)
    : const [];

DateTime _date(Object? value) {
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
  return DateTime.now();
}
