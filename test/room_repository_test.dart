import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_talk/core/rooms.dart';
import 'package:table_talk/services/room_repository.dart';

void main() {
  test('invitation streams normalize the authenticated email', () async {
    final firestore = FakeFirebaseFirestore();
    final repository = RoomRepository(firestore: firestore);
    final now = DateTime.utc(2026, 11, 10);

    await firestore.collection('invitations').doc('room-invite').set({
      'roomId': 'room-1',
      'invitedBy': 'sender',
      'inviteeEmail': 'invitee@example.com',
      'role': 'editor',
      'status': 'pending',
      'createdAt': now,
      'expiresAt': now.add(const Duration(days: 30)),
      'roomTitle': 'Dinner',
    });
    await firestore.collection('crew_invitations').doc('crew-invite').set({
      'crewId': 'crew-1',
      'invitedBy': 'sender',
      'inviteeEmail': 'invitee@example.com',
      'crewName': 'Friends',
      'isCouple': false,
      'status': 'pending',
      'createdAt': now,
    });

    final roomInvitations =
        await repository.watchRoomInvitations(' Invitee@Example.com ').first;
    final crewInvitations =
        await repository.watchCrewInvitations(' Invitee@Example.com ').first;

    expect(roomInvitations.map((invitation) => invitation.id), ['room-invite']);
    expect(crewInvitations.map((invitation) => invitation.id), ['crew-invite']);
    expect(await repository.watchCrewInvitations(' ').first, isEmpty);
  });

  test('createRoom shares only with the explicitly selected crews', () async {
    final firestore = FakeFirebaseFirestore();
    final repository = RoomRepository(firestore: firestore);
    final crew = firestore.collection('crews').doc('two-person');
    await crew.set({
      'name': 'Two of us',
      'ownerId': 'owner',
      'memberIds': ['owner', 'partner'],
      'isCouple': true,
      'createdAt': DateTime.utc(2026, 11, 10),
    });
    await crew.collection('members').doc('partner').set({
      'email': 'partner@example.com',
      'displayName': 'Partner',
      'isOwner': false,
      'role': 'viewer',
      'joinedAt': DateTime.utc(2026, 11, 10),
    });

    RoomDraft draft(List<String> crewIds, String name) => RoomDraft(
          name: name,
          description: '',
          mealAt: DateTime.now().add(const Duration(days: 1)),
          options: const [
            OptionDraft(title: 'Noodles'),
            OptionDraft(title: 'Tacos'),
          ],
          crewIds: crewIds,
          inviteeEmails: const [],
        );

    final unsharedRoomId = await repository.createRoom(
      userId: 'owner',
      email: 'owner@example.com',
      displayName: 'Owner',
      draft: draft(const [], 'Private lunch'),
    );

    final unsharedRoom =
        await firestore.collection('rooms').doc(unsharedRoomId).get();
    expect(unsharedRoom.data()!['sharedWithCrewIds'], isEmpty);
    expect(unsharedRoom.data()!['participantIds'], ['owner']);

    final sharedRoomId = await repository.createRoom(
      userId: 'owner',
      email: 'owner@example.com',
      displayName: 'Owner',
      draft: draft(['two-person'], 'Shared lunch'),
    );
    final partner = await firestore
        .collection('rooms')
        .doc(sharedRoomId)
        .collection('participants')
        .doc('partner')
        .get();
    expect(partner.data()!['role'], 'viewer');
  });

  test('a blocked user cannot be invited to a crew', () async {
    final firestore = FakeFirebaseFirestore();
    final repository = RoomRepository(firestore: firestore);
    await firestore.collection('users').doc('owner').set({
      'email': 'owner@example.com',
    });
    await firestore.collection('users').doc('blocked-member').set({
      'email': 'blocked@example.com',
    });
    await firestore
        .collection('users')
        .doc('owner')
        .collection('blocked')
        .doc('blocked-member')
        .set({'email': 'blocked@example.com', 'active': true});

    await expectLater(
      repository.inviteToCrew(
        crew: Crew(
          id: 'lunch-team',
          name: 'Lunch team',
          ownerId: 'owner',
          memberIds: const ['owner'],
          isCouple: false,
          createdAt: DateTime.utc(2026, 11, 10),
        ),
        invitedBy: 'owner',
        inviteeEmail: 'blocked@example.com',
      ),
      throwsA(isA<RoomFailure>()),
    );
    expect(
      (await firestore.collection('crew_invitations').get()).docs,
      isEmpty,
    );
  });

  test('deleteCrew unshares decisions without deleting the decisions',
      () async {
    final firestore = FakeFirebaseFirestore();
    final repository = RoomRepository(firestore: firestore);
    final crewRef = firestore.collection('crews').doc('lunch-team');
    final createdAt = DateTime.utc(2026, 11, 10);
    await crewRef.set({
      'name': 'Lunch team',
      'ownerId': 'owner',
      'memberIds': ['owner', 'member'],
      'isCouple': false,
      'createdAt': createdAt,
    });
    await crewRef.collection('members').doc('owner').set({
      'email': 'owner@example.com',
      'displayName': 'Owner',
      'isOwner': true,
      'role': 'admin',
      'joinedAt': createdAt,
    });
    await crewRef.collection('members').doc('member').set({
      'email': 'member@example.com',
      'displayName': 'Member',
      'isOwner': false,
      'role': 'editor',
      'joinedAt': createdAt,
    });
    await firestore.collection('crew_invitations').doc('pending-invite').set({
      'crewId': 'lunch-team',
      'invitedBy': 'owner',
      'inviteeEmail': 'pending@example.com',
      'status': 'pending',
    });
    final roomId = await repository.createRoom(
      userId: 'owner',
      email: 'owner@example.com',
      displayName: 'Owner',
      draft: RoomDraft(
        name: 'Team lunch',
        description: '',
        mealAt: DateTime.now().add(const Duration(days: 1)),
        options: const [
          OptionDraft(title: 'Noodles'),
          OptionDraft(title: 'Tacos'),
        ],
        crewIds: const ['lunch-team'],
        inviteeEmails: const [],
      ),
    );

    await repository.deleteCrew(
      crew: Crew(
        id: 'lunch-team',
        name: 'Lunch team',
        ownerId: 'owner',
        memberIds: const ['owner', 'member'],
        isCouple: false,
        createdAt: createdAt,
      ),
      ownerId: 'owner',
    );

    final roomRef = firestore.collection('rooms').doc(roomId);
    final room = await roomRef.get();
    final ownerParticipant =
        await roomRef.collection('participants').doc('owner').get();
    final removedParticipant =
        await roomRef.collection('participants').doc('member').get();
    expect((await crewRef.get()).exists, isFalse);
    expect(room.exists, isTrue);
    expect(room.data()!['sharedWithCrewIds'], isEmpty);
    expect(room.data()!['participantIds'], ['owner']);
    expect(room.data()!['participantCount'], 1);
    expect(ownerParticipant.data()!['sourceCrewIds'], isEmpty);
    expect(removedParticipant.data()!['inviteStatus'], 'removed');
    expect(
      (await firestore
              .collection('crew_invitations')
              .doc('pending-invite')
              .get())
          .data()!['status'],
      'cancelled',
    );
  });
}
