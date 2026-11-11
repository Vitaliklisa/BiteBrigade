import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
