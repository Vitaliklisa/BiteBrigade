import assert from "node:assert/strict";
import { test } from "node:test";
import { hasRecentAuthentication } from "./recent-auth.mjs";

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
