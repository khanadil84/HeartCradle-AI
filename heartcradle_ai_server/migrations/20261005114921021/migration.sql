BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_event" (
    "id" bigserial PRIMARY KEY,
    "eventId" text,
    "missionId" text NOT NULL,
    "event" text NOT NULL,
    "fromState" text NOT NULL,
    "toState" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "audit_event__eventId__unique_idx" ON "audit_event" USING btree ("eventId");


--
-- MIGRATION VERSION FOR heartcradle_ai
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('heartcradle_ai', '20261005114921021', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005114921021', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
