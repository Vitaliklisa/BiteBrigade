import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from "@firebase/rules-unit-testing";
import { collection, doc, getDocs, query, setDoc, where } from "firebase/firestore";

const env = await initializeTestEnvironment({
  projectId: "bite-brigade-invitation-queries",
  firestore: {
    rules: readFileSync("firestore.rules", "utf8"),
    host: "127.0.0.1",
    port: 8080,
  },
});

try {
  await env.clearFirestore();
  await env.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await setDoc(doc(db, "invitations/room-invite"), {
      roomId: "room-1",
      invitedBy: "sender",
      inviteeEmail: "invitee@example.com",
      status: "pending",
      role: "editor",
      roomTitle: "Dinner",
    });
    await setDoc(doc(db, "crew_invitations/crew-invite"), {
      crewId: "crew-1",
      invitedBy: "sender",
      inviteeEmail: "invitee@example.com",
      status: "pending",
      crewName: "Friends",
    });
  });

  const invitee = env.authenticatedContext("invitee", { email: "Invitee@Example.com" }).firestore();
  for (const collectionName of ["invitations", "crew_invitations"]) {
    const inbox = query(
      collection(invitee, collectionName),
      where("inviteeEmail", "==", "invitee@example.com"),
      where("status", "==", "pending"),
    );
    const snapshot = await assertSucceeds(getDocs(inbox));
    assert.equal(snapshot.size, 1);
  }

  const stranger = env
    .authenticatedContext("stranger", { email: "stranger@example.com" })
    .firestore();
  await assertFails(
    getDocs(
      query(
        collection(stranger, "crew_invitations"),
        where("inviteeEmail", "==", "invitee@example.com"),
        where("status", "==", "pending"),
      ),
    ),
  );
  console.log("PASS  invitee-only room and crew invitation queries");
} finally {
  await env.clearFirestore();
  await env.cleanup();
}
