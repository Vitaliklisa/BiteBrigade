import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { initializeTestEnvironment } from '@firebase/rules-unit-testing';
import {
  collection,
  doc,
  getDoc,
  getDocs,
  increment,
  query,
  serverTimestamp,
  setDoc,
  where,
  writeBatch,
} from 'firebase/firestore';

const projectId = 'table-talk-rules';
const env = await initializeTestEnvironment({
  projectId,
  firestore: {
    rules: readFileSync('firestore.rules', 'utf8'),
    host: '127.0.0.1',
    port: 8080,
  },
});

const denied = (operation) =>
  assert.rejects(operation, (error) => error.code === 'permission-denied');

try {
  await env.clearFirestore();

  const creator = env.authenticatedContext('creator', {
    email: 'creator@example.com',
  }).firestore();
  const participant = env.authenticatedContext('participant', {
    email: 'participant@example.com',
  }).firestore();
  const stranger = env.authenticatedContext('stranger', {
    email: 'stranger@example.com',
  }).firestore();

  const roomRef = doc(creator, 'rooms/dinner');
  const batch = writeBatch(creator);
  batch.set(roomRef, {
    name: 'Friday dinner',
    description: '',
    mealAt: new Date(Date.now() + 60_000),
    createdBy: 'creator',
    createdAt: serverTimestamp(),
    updatedAt: serverTimestamp(),
    status: 'open',
    participantIds: ['creator'],
    participantCount: 1,
    optionCount: 2,
    votesCast: 0,
    votesRevision: 0,
    sharedWithCrewIds: [],
    winnerOptionId: null,
    decidedAt: null,
    deletedAt: null,
  });
  batch.set(doc(creator, 'rooms/dinner/participants/creator'), {
    email: 'creator@example.com',
    displayName: 'Creator',
    role: 'admin',
    inviteStatus: 'accepted',
    joinedAt: serverTimestamp(),
    isDirect: true,
    sourceCrewIds: [],
  });
  for (const id of ['one', 'two']) {
    batch.set(doc(creator, `rooms/dinner/options/${id}`), {
      title: id,
      url: null,
      address: null,
      createdBy: 'creator',
      createdAt: serverTimestamp(),
      voteCount: 0,
    });
  }
  await batch.commit();
  console.log('PASS  creator can create a room with options and participant');

  await denied(getDoc(doc(stranger, 'rooms/dinner')));
  console.log('PASS  an unrelated account cannot read a room');

  await env.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await setDoc(doc(db, 'rooms/dinner/participants/participant'), {
      email: 'participant@example.com',
      displayName: 'Participant',
      role: 'editor',
      inviteStatus: 'accepted',
      joinedAt: new Date(),
      isDirect: true,
      sourceCrewIds: [],
    });
    await setDoc(doc(db, 'rooms/dinner'), {
      participantIds: ['creator', 'participant'],
      participantCount: 2,
    }, { merge: true });
  });

  const acceptedParticipants = await getDocs(
    query(
      collection(participant, 'rooms/dinner/participants'),
      where('inviteStatus', '==', 'accepted'),
    ),
  );
  assert.equal(acceptedParticipants.size, 2);
  console.log('PASS  a participant can list accepted room members');

  const voterBatch = writeBatch(participant);
  voterBatch.set(doc(participant, 'rooms/dinner/votes/participant'), {
    userId: 'participant',
    optionId: 'one',
    createdAt: serverTimestamp(),
  });
  voterBatch.update(doc(participant, 'rooms/dinner/options/one'), {
    voteCount: increment(1),
  });
  voterBatch.update(doc(participant, 'rooms/dinner'), {
    votesCast: increment(1),
    votesRevision: increment(1),
  });
  await voterBatch.commit();
  console.log('PASS  an accepted participant can cast a valid vote');

  await denied(
    setDoc(doc(stranger, 'rooms/dinner/votes/stranger'), {
      userId: 'stranger',
      optionId: 'one',
      createdAt: serverTimestamp(),
    }),
  );
  console.log('PASS  an unrelated account cannot vote in a room');

  await denied(
    setDoc(doc(participant, 'rooms/dinner/participants/other'), {
      email: 'other@example.com',
      role: 'admin',
      inviteStatus: 'accepted',
      joinedAt: serverTimestamp(),
    }),
  );
  console.log('PASS  a participant cannot grant room access to someone else');

  await env.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await setDoc(doc(db, 'rooms/invite-room'), {
      name: 'Invite dinner',
      description: '',
      mealAt: new Date(Date.now() + 60_000),
      createdBy: 'creator',
      createdAt: new Date(),
      updatedAt: new Date(),
      status: 'open',
      participantIds: ['creator'],
      participantCount: 1,
      optionCount: 2,
      votesCast: 0,
      votesRevision: 0,
      sharedWithCrewIds: [],
    });
    await setDoc(doc(db, 'rooms/invite-room/participants/creator'), {
      email: 'creator@example.com',
      role: 'admin',
      inviteStatus: 'accepted',
      isDirect: true,
      sourceCrewIds: [],
    });
  });

  const inviteRef = doc(creator, 'invitations/room-invite');
  const inviteBatch = writeBatch(creator);
  inviteBatch.set(inviteRef, {
    roomId: 'invite-room',
    invitedBy: 'creator',
    inviteeEmail: 'participant@example.com',
    role: 'editor',
    status: 'pending',
    expiresAt: new Date(Date.now() + 60_000),
    roomTitle: 'Invite dinner',
  });
  inviteBatch.set(doc(creator, 'rooms/invite-room/participants/participant'), {
    email: 'participant@example.com',
    role: 'editor',
    inviteStatus: 'pending',
    joinedAt: serverTimestamp(),
    isDirect: true,
    sourceCrewIds: [],
    invitationId: 'room-invite',
  });
  await inviteBatch.commit();
  console.log('PASS  the room creator can send a pending invitation');

  const acceptRoomInvite = writeBatch(participant);
  acceptRoomInvite.update(doc(participant, 'invitations/room-invite'), {
    status: 'accepted',
  });
  acceptRoomInvite.set(
    doc(participant, 'rooms/invite-room/participants/participant'),
    {
      email: 'participant@example.com',
      role: 'editor',
      inviteStatus: 'accepted',
      joinedAt: serverTimestamp(),
      isDirect: true,
      sourceCrewIds: [],
      invitationId: 'room-invite',
    },
  );
  acceptRoomInvite.update(doc(participant, 'rooms/invite-room'), {
    participantIds: ['creator', 'participant'],
    participantCount: 2,
    updatedAt: serverTimestamp(),
  });
  await acceptRoomInvite.commit();
  assert.equal(
    (await getDoc(doc(participant, 'rooms/invite-room'))).data().name,
    'Invite dinner',
  );
  console.log('PASS  accepting an invitation grants room access atomically');

  await env.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await setDoc(doc(db, 'crews/crew-a'), {
      name: 'Friday group',
      ownerId: 'creator',
      memberIds: ['creator'],
      isCouple: false,
      createdAt: new Date(),
    });
    await setDoc(doc(db, 'crews/crew-a/members/creator'), {
      email: 'creator@example.com',
      isOwner: true,
      joinedAt: new Date(),
    });
    await setDoc(doc(db, 'rooms/crew-room'), {
      name: 'Crew dinner',
      description: '',
      mealAt: new Date(Date.now() + 60_000),
      createdBy: 'creator',
      createdAt: new Date(),
      updatedAt: new Date(),
      status: 'open',
      participantIds: ['creator'],
      participantCount: 1,
      optionCount: 2,
      votesCast: 0,
      votesRevision: 0,
      sharedWithCrewIds: ['crew-a'],
    });
    await setDoc(doc(db, 'rooms/crew-room/participants/creator'), {
      email: 'creator@example.com',
      role: 'admin',
      inviteStatus: 'accepted',
      isDirect: true,
      sourceCrewIds: ['crew-a'],
    });
  });

  const crewInvite = doc(creator, 'crew_invitations/crew-invite');
  await setDoc(crewInvite, {
    crewId: 'crew-a',
    invitedBy: 'creator',
    inviteeEmail: 'participant@example.com',
    crewName: 'Friday group',
    isCouple: false,
    status: 'pending',
    expiresAt: new Date(Date.now() + 60_000),
  });
  await setDoc(doc(creator, 'crews/crew-a/sharedRooms/crew-room'), {
    roomId: 'crew-room',
    sharedWithCrewIds: ['crew-a'],
    createdAt: serverTimestamp(),
  });
  const acceptCrewInvite = writeBatch(participant);
  acceptCrewInvite.update(
    doc(participant, 'crew_invitations/crew-invite'),
    { status: 'accepted' },
  );
  acceptCrewInvite.update(doc(participant, 'crews/crew-a'), {
    memberIds: ['creator', 'participant'],
    lastInvitationId: 'crew-invite',
  });
  acceptCrewInvite.set(doc(participant, 'crews/crew-a/members/participant'), {
    email: 'participant@example.com',
    displayName: 'Participant',
    isOwner: false,
    joinedAt: serverTimestamp(),
    invitationId: 'crew-invite',
  });
  await acceptCrewInvite.commit();

  const shareCrewRoom = writeBatch(participant);
  shareCrewRoom.update(doc(participant, 'rooms/crew-room'), {
    participantIds: ['creator', 'participant'],
    participantCount: 2,
    updatedAt: serverTimestamp(),
  });
  shareCrewRoom.set(doc(participant, 'rooms/crew-room/participants/participant'), {
    email: 'participant@example.com',
    displayName: 'Participant',
    role: 'editor',
    inviteStatus: 'accepted',
    joinedAt: serverTimestamp(),
    isDirect: false,
    sourceCrewIds: ['crew-a'],
    lastAddedCrewId: 'crew-a',
  });
  await shareCrewRoom.commit();
  assert.equal(
    (await getDoc(doc(participant, 'rooms/crew-room'))).data().participantCount,
    2,
  );
  console.log('PASS  a new crew member gains access to previously shared rooms');

  const leaveCrew = writeBatch(participant);
  leaveCrew.update(doc(participant, 'crews/crew-a'), {
    memberIds: ['creator'],
  });
  leaveCrew.delete(doc(participant, 'crews/crew-a/members/participant'));
  await leaveCrew.commit();
  const removeCrewRoom = writeBatch(participant);
  removeCrewRoom.update(doc(participant, 'rooms/crew-room'), {
    participantIds: ['creator'],
    participantCount: 1,
    updatedAt: serverTimestamp(),
  });
  removeCrewRoom.set(
    doc(participant, 'rooms/crew-room/participants/participant'),
    {
      inviteStatus: 'removed',
      sourceCrewIds: [],
      lastRemovedCrewId: 'crew-a',
    },
    { merge: true },
  );
  await removeCrewRoom.commit();
  await denied(getDoc(doc(participant, 'rooms/crew-room')));
  console.log('PASS  leaving the last shared crew removes room access');
} finally {
  await env.clearFirestore();
  await env.cleanup();
}
