import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { initializeTestEnvironment } from '@firebase/rules-unit-testing';
import {
  collection,
  deleteDoc,
  doc,
  getDoc,
  getDocs,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
  where,
  writeBatch,
} from 'firebase/firestore';

const env = await initializeTestEnvironment({
  projectId: 'table-talk-crew-rules',
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

  const owner = env.authenticatedContext('owner', {
    email: 'owner@example.com',
  }).firestore();
  const stranger = env.authenticatedContext('stranger', {
    email: 'stranger@example.com',
  }).firestore();

  const batch = writeBatch(owner);
  batch.set(doc(owner, 'crews/friday-dinner'), {
    name: 'Friday dinner',
    ownerId: 'owner',
    memberIds: ['owner'],
    isCouple: false,
    emoji: '🍽️',
    createdAt: serverTimestamp(),
  });
  batch.set(doc(owner, 'crews/friday-dinner/members/owner'), {
    email: 'owner@example.com',
    displayName: 'Owner',
    isOwner: true,
    role: 'admin',
    joinedAt: serverTimestamp(),
  });
  await batch.commit();

  const crews = await getDocs(
    query(collection(owner, 'crews'), where('memberIds', 'array-contains', 'owner')),
  );
  assert.equal(crews.size, 1);
  assert.equal((await getDoc(doc(owner, 'crews/friday-dinner/members/owner'))).exists(), true);
  console.log('PASS  an authenticated owner can create and read their crew');

  await env.withSecurityRulesDisabled(async (context) => {
    await setDoc(doc(context.firestore(), 'crew_invitations/pending-invite'), {
      crewId: 'friday-dinner',
      invitedBy: 'owner',
      inviteeEmail: 'pending@example.com',
      status: 'pending',
      expiresAt: new Date(Date.now() + 60_000),
    });
  });
  const ownerInvitations = await getDocs(
    query(
      collection(owner, 'crew_invitations'),
      where('invitedBy', '==', 'owner'),
    ),
  );
  assert.equal(ownerInvitations.size, 1);
  await updateDoc(doc(owner, 'crew_invitations/pending-invite'), {
    status: 'cancelled',
  });
  console.log('PASS  a crew owner can list and cancel their pending invitations');

  await denied(getDoc(doc(stranger, 'crews/friday-dinner')));
  console.log('PASS  an unrelated account cannot read another crew');

  await denied(
    setDoc(doc(stranger, 'private-data/unrelated'), {
      value: 'write',
    }),
  );
  console.log('PASS  authenticated access does not permit writes to unrelated paths');

  const member = env.authenticatedContext('crew-member', {
    email: 'member@example.com',
  }).firestore();
  await env.withSecurityRulesDisabled(async (context) => {
    const admin = context.firestore();
    await updateDoc(doc(admin, 'crews/friday-dinner'), {
      memberIds: ['owner', 'crew-member'],
    });
    await setDoc(doc(admin, 'crews/friday-dinner/members/crew-member'), {
      email: 'member@example.com',
      displayName: 'Member',
      isOwner: false,
      role: 'editor',
      joinedAt: new Date(),
    });
    await setDoc(doc(admin, 'rooms/shared-lunch'), {
      name: 'Shared lunch',
      description: '',
      createdBy: 'owner',
      participantIds: ['owner', 'crew-member'],
      participantCount: 2,
      sharedWithCrewIds: ['friday-dinner'],
      status: 'open',
      votesCast: 0,
      updatedAt: new Date(),
    });
    await setDoc(
      doc(admin, 'rooms/shared-lunch/participants/crew-member'),
      {
        email: 'member@example.com',
        displayName: 'Member',
        role: 'editor',
        inviteStatus: 'accepted',
        isDirect: false,
        sourceCrewIds: ['friday-dinner'],
      },
    );
  });

  await updateDoc(doc(owner, 'crews/friday-dinner/members/crew-member'), {
    role: 'viewer',
  });
  assert.equal(
    (
      await getDoc(doc(owner, 'crews/friday-dinner/members/crew-member'))
    ).data().role,
    'viewer',
  );
  await denied(
    updateDoc(doc(member, 'crews/friday-dinner/members/owner'), {
      role: 'viewer',
    }),
  );
  await denied(deleteDoc(doc(member, 'crews/friday-dinner')));
  console.log('PASS  only the crew owner can change a member role');

  const removal = writeBatch(owner);
  removal.update(doc(owner, 'rooms/shared-lunch'), {
    participantIds: ['owner'],
    participantCount: 1,
    lastRemovedCrewId: 'friday-dinner',
    lastRemovedCrewMemberId: 'crew-member',
    updatedAt: serverTimestamp(),
  });
  removal.update(
    doc(owner, 'rooms/shared-lunch/participants/crew-member'),
    {
      sourceCrewIds: [],
      lastRemovedCrewId: 'friday-dinner',
      inviteStatus: 'removed',
    },
  );
  await removal.commit();
  await updateDoc(doc(owner, 'rooms/shared-lunch'), {
    sharedWithCrewIds: [],
    lastRemovedCrewId: 'friday-dinner',
    updatedAt: serverTimestamp(),
  });
  console.log('PASS  a crew owner can remove its access from a shared meal plan');

  const removeMember = writeBatch(owner);
  removeMember.update(doc(owner, 'crews/friday-dinner'), {
    memberIds: ['owner'],
    lastRemovedMemberId: 'crew-member',
  });
  removeMember.delete(doc(owner, 'crews/friday-dinner/members/crew-member'));
  await removeMember.commit();
  console.log('PASS  the crew owner can remove a member after access cleanup');

  const deleteCrew = writeBatch(owner);
  deleteCrew.delete(doc(owner, 'crews/friday-dinner/members/owner'));
  deleteCrew.delete(doc(owner, 'crews/friday-dinner'));
  await deleteCrew.commit();
  console.log('PASS  only the owner can delete a crew after its subcollections');
} finally {
  await env.cleanup();
}
