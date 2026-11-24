import assert from "node:assert/strict";
import { createRequire } from "node:module";
import { test } from "node:test";
import { hasRecentAuthentication } from "./recent-auth.mjs";

test("Firebase Admin Auth loads through both module entry points", async () => {
  const require = createRequire(import.meta.url);
  const commonJsAuth = require("firebase-admin/auth");
  const esmAuth = await import("firebase-admin/auth");

  assert.equal(typeof commonJsAuth.getAuth, "function");
  assert.equal(typeof esmAuth.getAuth, "function");
});

test("accepts authentication from within the five-minute window", () => {
  assert.equal(hasRecentAuthentication(700, 1000), true);
  assert.equal(hasRecentAuthentication(699, 1000), false);
});

test("allows small clock skew but rejects implausible future auth times", () => {
  assert.equal(hasRecentAuthentication(1060, 1000), true);
  assert.equal(hasRecentAuthentication(1061, 1000), false);
});

test("rejects malformed authentication times", () => {
  assert.equal(hasRecentAuthentication(Number.NaN, 1000), false);
  assert.equal(hasRecentAuthentication("1000", 1000), false);
});
