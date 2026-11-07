import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/rooms.dart';

void main() {
  final now = DateTime.utc(2026, 11, 7);
  final room = Room(
    id: 'room-1',
    name: 'Dinner Friday',
    description: '',
    mealAt: now.add(const Duration(days: 1)),
    createdBy: 'creator',
    createdAt: now,
    updatedAt: now,
    status: RoomStatus.open,
    participantIds: const ['creator', 'editor'],
    sharedWithCrewIds: const [],
    participantCount: 2,
    votesCast: 0,
    votesRevision: 0,
  );

  test('creator is always admin and a stranger is always a viewer', () {
    expect(
      roomRoleFor(room: room, userId: 'creator'),
      RoomRole.admin,
    );
    expect(
      canManageRoom(room: room, userId: 'creator'),
      isTrue,
    );
    expect(
      roomRoleFor(room: room, userId: 'stranger'),
      RoomRole.viewer,
    );
    expect(
      canEditRoom(room: room, userId: 'stranger'),
      isFalse,
    );
  });

  test('accepted participant uses their assigned role', () {
    final editor = RoomParticipant(
      userId: 'editor',
      email: 'editor@example.com',
      displayName: 'Editor',
      role: RoomRole.editor,
      inviteStatus: 'accepted',
      joinedAt: now,
    );
    expect(
      roomRoleFor(room: room, userId: 'editor', participant: editor),
      RoomRole.editor,
    );
    expect(
      canEditRoom(room: room, userId: 'editor', participant: editor),
      isTrue,
    );
    expect(
      canManageRoom(room: room, userId: 'editor', participant: editor),
      isFalse,
    );
  });

  test('winner uses vote totals and the earliest vote to break ties', () {
    final options = [
      RestaurantOption(
        id: 'later',
        title: 'Later vote',
        createdBy: 'creator',
        createdAt: now,
        voteCount: 0,
      ),
      RestaurantOption(
        id: 'earlier',
        title: 'Earlier vote',
        createdBy: 'creator',
        createdAt: now,
        voteCount: 0,
      ),
      RestaurantOption(
        id: 'low',
        title: 'One vote',
        createdBy: 'creator',
        createdAt: now,
        voteCount: 0,
      ),
    ];
    final votes = [
      RoomVote(
        userId: 'a',
        optionId: 'later',
        createdAt: now.add(const Duration(minutes: 5)),
      ),
      RoomVote(
        userId: 'b',
        optionId: 'later',
        createdAt: now.add(const Duration(minutes: 8)),
      ),
      RoomVote(
        userId: 'c',
        optionId: 'earlier',
        createdAt: now.add(const Duration(minutes: 2)),
      ),
      RoomVote(
        userId: 'd',
        optionId: 'earlier',
        createdAt: now.add(const Duration(minutes: 4)),
      ),
      RoomVote(
        userId: 'e',
        optionId: 'low',
        createdAt: now,
      ),
    ];

    expect(resolveWinnerOptionId(options, votes), 'earlier');
  });

  test('empty vote ties resolve deterministically and no options has no winner',
      () {
    final first = RestaurantOption(
      id: 'a',
      title: 'First',
      createdBy: 'creator',
      createdAt: now,
      voteCount: 0,
    );
    final second = RestaurantOption(
      id: 'b',
      title: 'Second',
      createdBy: 'creator',
      createdAt: now,
      voteCount: 0,
    );

    expect(resolveWinnerOptionId([second, first], const []), 'a');
    expect(resolveWinnerOptionId(const [], const []), isNull);
  });

  test('room decides when everyone voted or the deadline passed', () {
    expect(
      roomIsReadyToDecide(
        room: room,
        acceptedParticipantIds: {'creator', 'editor'},
        votedUserIds: {'creator', 'editor'},
        now: now,
      ),
      isTrue,
    );
    expect(
      roomIsReadyToDecide(
        room: room,
        acceptedParticipantIds: {'creator', 'editor'},
        votedUserIds: {'creator'},
        now: room.mealAt.add(const Duration(seconds: 1)),
      ),
      isTrue,
    );
    expect(
      roomIsReadyToDecide(
        room: room,
        acceptedParticipantIds: {'creator', 'editor'},
        votedUserIds: {'creator'},
        now: now,
      ),
      isFalse,
    );
  });
}
