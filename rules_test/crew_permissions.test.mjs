import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { initializeTestEnvironment } from '@firebase/rules-unit-testing';
import {
  collection,
  doc,
  getDoc,
  getDocs,
  query,
  serverTimestamp,
  setDoc,
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
    joinedAt: serverTimestamp(),
  });
  await batch.commit();

  const crews = await getDocs(
    query(collection(owner, 'crews'), where('memberIds', 'array-contains', 'owner')),
  );
  assert.equal(crews.size, 1);
  assert.equal((await getDoc(doc(owner, 'crews/friday-dinner/members/owner'))).exists(), true);
  console.log('PASS  an authenticated owner can create and read their crew');

  await denied(getDoc(doc(stranger, 'crews/friday-dinner')));
  console.log('PASS  an unrelated account cannot read another crew');

  await denied(
    setDoc(doc(stranger, 'private-data/unrelated'), {
      value: 'write',
    }),
  );
  console.log('PASS  authenticated access does not permit writes to unrelated paths');
} finally {
  await env.cleanup();
}
