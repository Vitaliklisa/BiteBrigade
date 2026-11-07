-- Device push tokens, one row per (user, device, platform).
--
-- A user can have several devices (Pixel + iPad + browser), so the token is the
-- primary key, not the user — one account maps to many rows. Tokens rotate
-- (FCM reissues them), so `on conflict ... do update` refreshes `updatedAt`
-- rather than erroring on re-registration.
create table if not exists "device_tokens" (
  "token" text not null primary key,
  "userId" text not null references "user" ("id") on delete cascade,
  "platform" text not null default 'android', -- 'android' | 'ios' | 'web'
  "createdAt" timestamptz default CURRENT_TIMESTAMP not null,
  "updatedAt" timestamptz default CURRENT_TIMESTAMP not null
);

create index if not exists "device_tokens_userId_idx" on "device_tokens" ("userId");
