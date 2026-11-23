import { getApps, initializeApp, cert } from "firebase-admin/app";
import { getAuth } from "firebase-admin/auth";
import {
  FieldValue,
  getFirestore,
  type BulkWriter,
  type Firestore,
  type DocumentReference,
  type Query,
} from "firebase-admin/firestore";
import type { IncomingMessage, ServerResponse } from "node:http";
import { hasRecentAuthentication } from "./recent-auth.mjs";

type Request = IncomingMessage & { body?: unknown };
type Input = Record<string, unknown>;
type DeletionContext = {
  uid: string;
  input: Input;
  db: Firestore;
  auth: ReturnType<typeof getAuth>;
};
type DeletionAction = (context: DeletionContext) => Promise<void>;

class HttpError extends Error {
  readonly status: number;
  readonly code?: string;

  constructor(status: number, message: string, code?: string) {
    super(message);
    this.status = status;
    this.code = code;
  }
}

function getAdmin() {
  if (process.env.VERCEL === "1" && process.env.FIRESTORE_EMULATOR_HOST) {
    throw new HttpError(
      503,
      "Firestore emulator configuration is set in this deployment.",
    );
  }

  const projectId = process.env.FIREBASE_ADMIN_PROJECT_ID;
  const clientEmail = process.env.FIREBASE_ADMIN_CLIENT_EMAIL;
  const privateKey = process.env.FIREBASE_ADMIN_PRIVATE_KEY?.replace(/\\n/g, "\n");
  if (!projectId || !clientEmail || !privateKey) {
    throw new HttpError(
      503,
      "The account deletion service is not configured.",
    );
  }

  const app =
    getApps()[0] ??
    initializeApp({
      credential: cert({ projectId, clientEmail, privateKey }),
      projectId,
    });

  return { auth: getAuth(app), db: getFirestore(app) };
}

async function parseInput(req: Request): Promise<Input> {
  if (req.body !== undefined) {
    if (typeof req.body === "string") {
      try {
        const body: unknown = JSON.parse(req.body);
        if (body && typeof body === "object" && !Array.isArray(body)) {
          return body as Input;
        }
      } catch {
        throw new HttpError(400, "A valid JSON request body is required.");
      }
    }
    if (req.body && typeof req.body === "object" && !Array.isArray(req.body)) {
      return req.body as Input;
    }
  }

  const chunks: Buffer[] = [];
  for await (const chunk of req) {
    chunks.push(Buffer.isBuffer(chunk) ? chunk : Buffer.from(chunk));
  }
  try {
    const body: unknown = JSON.parse(Buffer.concat(chunks).toString("utf8"));
    if (!body || typeof body !== "object" || Array.isArray(body)) {
      throw new HttpError(400, "A valid JSON request body is required.");
    }
    return body as Input;
  } catch (error) {
    if (error instanceof HttpError) throw error;
    throw new HttpError(400, "A valid JSON request body is required.");
  }
}

export function deletionHandler(action: DeletionAction) {
  return async (req: Request, res: ServerResponse) => {
    res.setHeader("Cache-Control", "no-store");
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
    res.setHeader("Access-Control-Allow-Headers", "Authorization, Content-Type");
    if (req.method === "OPTIONS") {
      res.statusCode = 204;
      res.end();
      return;
    }
    res.setHeader("Content-Type", "application/json");
    if (req.method !== "POST") {
      res.statusCode = 405;
      res.end(JSON.stringify({ success: false, error: "Method not allowed." }));
      return;
    }

    try {
      const authorization = req.headers.authorization;
      const token =
        typeof authorization === "string" && authorization.startsWith("Bearer ")
          ? authorization.slice("Bearer ".length)
          : "";
      if (!token) throw new HttpError(401, "Sign in to continue.");

      const { auth, db } = getAdmin();
      let decodedToken: Awaited<ReturnType<typeof auth.verifyIdToken>>;
      try {
        decodedToken = await auth.verifyIdToken(token, true);
      } catch {
        throw new HttpError(401, "Your session is invalid. Sign in again.");
      }
      if (!hasRecentAuthentication(decodedToken.auth_time)) {
        throw new HttpError(
          401,
          "For security, sign in again before deleting your account.",
          "requires-recent-login",
        );
      }

      await action({ uid: decodedToken.uid, input: await parseInput(req), db, auth });
      res.statusCode = 200;
      res.end(JSON.stringify({ success: true }));
    } catch (error) {
      if (error instanceof HttpError) {
        res.statusCode = error.status;
        res.end(
          JSON.stringify({
            success: false,
            error: error.message,
            ...(error.code ? { code: error.code } : {}),
          }),
        );
        return;
      }
      console.error("[bite-brigade] Admin deletion request failed:", error);
      res.statusCode = 500;
      res.end(
        JSON.stringify({
          success: false,
          error: "Deletion could not be completed. Please retry.",
        }),
      );
    }
  };
}

function requiredString(input: Input, key: string): string {
  const value = input[key];
  if (typeof value !== "string" || value.length === 0) {
    throw new HttpError(400, `The ${key} field is required.`);
  }
  return value;
}

async function finishBulkWriter(
  writer: BulkWriter,
  operation: "delete" | "update" | "write",
  writes: Promise<unknown>[],
): Promise<void> {
  await writer.close();
  const results = await Promise.allSettled(writes);
  const failures = results.filter((result) => result.status === "rejected");
  if (failures.length > 0) {
    throw new Error(`Failed to ${operation} ${failures.length} Firestore documents.`);
  }
}

async function deleteReferences(
  db: Firestore,
  references: DocumentReference[],
): Promise<void> {
  for (let offset = 0; offset < references.length; offset += 400) {
    const writer = db.bulkWriter();
    writer.onWriteError((error) => error.failedAttempts < 3);
    const page = references.slice(offset, offset + 400);
    const writes = page.map((reference) => writer.delete(reference));
    await finishBulkWriter(writer, "delete", writes);
  }
}

async function deleteQuery(db: Firestore, query: Query): Promise<void> {
  while (true) {
    const page = await query.limit(400).get();
    if (page.empty) return;
    await deleteReferences(
      db,
      page.docs.map((document) => document.ref),
    );
  }
}

async function runInBatches<T>(
  items: T[],
  batchSize: number,
  operation: (item: T) => Promise<void>,
  description: string,
) {
  for (let offset = 0; offset < items.length; offset += batchSize) {
    const results = await Promise.allSettled(
      items.slice(offset, offset + batchSize).map(operation),
    );
    const failures = results.filter(
      (result): result is PromiseRejectedResult => result.status === "rejected",
    );
    if (failures.length > 0) {
      throw new AggregateError(
        failures.map((failure) => failure.reason),
        `Failed to ${description}.`,
      );
    }
  }
}

async function deleteAccount({
  uid,
  input,
  db,
  auth,
}: DeletionContext): Promise<void> {
  const confirmation = requiredString(input, "confirmation");
  const user = await auth.getUser(uid);
  const accountEmail = user.email?.toLowerCase();
  if (!accountEmail) {
    throw new HttpError(400, "Your account has no email address to confirm deletion.");
  }
  if (confirmation.trim().toLowerCase() !== accountEmail) {
    throw new HttpError(400, "The confirmation value does not match your account email.");
  }

  await Promise.all([
    auth.deleteUser(uid),
    db.recursiveDelete(db.collection("users").doc(uid)),
  ]);

  const ownedRooms = await db.collection("rooms").where("createdBy", "==", uid).get();
  await runInBatches(
    ownedRooms.docs,
    10,
    async (room) => db.recursiveDelete(room.ref),
    "delete owned meal plans",
  );

  const ownedEvents = await db.collection("events").where("createdBy", "==", uid).get();
  await runInBatches(
    ownedEvents.docs,
    10,
    async (event) => db.recursiveDelete(event.ref),
    "delete owned legacy countdowns",
  );

  const ownedCrews = await db.collection("crews").where("ownerId", "==", uid).get();
  await runInBatches(
    ownedCrews.docs,
    5,
    async (crew) => {
      await deleteQuery(
        db,
        db.collection("crew_invitations").where("crewId", "==", crew.id),
      );
      await db.recursiveDelete(crew.ref);
    },
    "delete owned crews",
  );

  const ownedCircles = await db.collection("circles").where("ownerId", "==", uid).get();
  await runInBatches(
    ownedCircles.docs,
    5,
    async (circle) => {
      await deleteQuery(
        db,
        db.collection("circle_invitations").where("circleId", "==", circle.id),
      );
      await db.recursiveDelete(circle.ref);
    },
    "delete owned circles",
  );

  const memberCrews = await db
    .collection("crews")
    .where("memberIds", "array-contains", uid)
    .get();
  const memberCircles = await db
    .collection("circles")
    .where("memberIds", "array-contains", uid)
    .get();

  if (!memberCrews.empty || !memberCircles.empty) {
    const writer = db.bulkWriter();
    writer.onWriteError((error) => error.failedAttempts < 3);
    const writes: Promise<unknown>[] = [];
    for (const crew of memberCrews.docs) {
      writes.push(writer.update(crew.ref, {
        memberIds: FieldValue.arrayRemove(uid),
      }));
      writes.push(writer.delete(crew.ref.collection("members").doc(uid)));
    }
    for (const circle of memberCircles.docs) {
      writes.push(writer.update(circle.ref, {
        memberIds: FieldValue.arrayRemove(uid),
      }));
      writes.push(writer.delete(circle.ref.collection("members").doc(uid)));
    }
    await finishBulkWriter(writer, "write", writes);
  }

  const email = accountEmail;
  const invitationQueries = [
    db.collection("invitations").where("invitedBy", "==", uid),
    db.collection("crew_invitations").where("invitedBy", "==", uid),
    db.collection("circle_invitations").where("invitedBy", "==", uid),
    db.collection("responses").where("recipientId", "==", uid),
    db.collection("invitations").where("inviteeEmail", "==", email),
    db.collection("crew_invitations").where("inviteeEmail", "==", email),
    db.collection("circle_invitations").where("inviteeEmail", "==", email),
    db.collection("responses").where("responderEmail", "==", email),
  ];
  await Promise.all(invitationQueries.map((query) => deleteQuery(db, query)));

  const participantRows = await db
    .collectionGroup("participants")
    .where("userId", "==", uid)
    .get();
  await deleteReferences(
    db,
    participantRows.docs.map((row) => row.ref),
  );
}

export const deleteAccountHandler = deletionHandler(deleteAccount);
