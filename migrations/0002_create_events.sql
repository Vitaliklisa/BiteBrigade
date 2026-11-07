create table if not exists "events" (
  "id" text not null primary key,
  "title" text not null,
  "description" text not null default '',
  "at" timestamptz not null,
  "createdBy" text not null references "user" ("id") on delete cascade,
  "createdAt" timestamptz default CURRENT_TIMESTAMP not null,
  "updatedAt" timestamptz default CURRENT_TIMESTAMP not null,
  "deletedAt" timestamptz
);

create table if not exists "event_participants" (
  "eventId" text not null references "events" ("id") on delete cascade,
  "userId" text not null references "user" ("id") on delete cascade,
  "role" text not null default 'viewer', -- 'admin', 'editor', 'viewer'
  "joinedAt" timestamptz default CURRENT_TIMESTAMP not null,
  "inviteStatus" text not null default 'pending', -- 'pending', 'accepted', 'rejected'
  primary key ("eventId", "userId")
);

create table if not exists "event_notes" (
  "id" text not null primary key,
  "eventId" text not null references "events" ("id") on delete cascade,
  "userId" text not null references "user" ("id") on delete cascade,
  "text" text not null,
  "createdAt" timestamptz default CURRENT_TIMESTAMP not null,
  "updatedAt" timestamptz default CURRENT_TIMESTAMP not null
);

create table if not exists "invitations" (
  "id" text not null primary key,
  "eventId" text not null references "events" ("id") on delete cascade,
  "invitedBy" text not null references "user" ("id") on delete cascade,
  "inviteeEmail" text not null,
  "role" text not null default 'viewer',
  "status" text not null default 'pending', -- 'pending', 'accepted', 'rejected'
  "createdAt" timestamptz default CURRENT_TIMESTAMP not null,
  "expiresAt" timestamptz not null
);

create index if not exists "events_createdBy_idx" on "events" ("createdBy");
create index if not exists "event_participants_userId_idx" on "event_participants" ("userId");
create index if not exists "event_notes_eventId_idx" on "event_notes" ("eventId");
create index if not exists "invitations_inviteeEmail_idx" on "invitations" ("inviteeEmail");
