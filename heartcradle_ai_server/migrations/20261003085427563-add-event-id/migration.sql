BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "triage_event" ADD COLUMN "eventId" text;
CREATE UNIQUE INDEX "triage_event__eventId__unique_idx" ON "triage_event" USING btree ("eventId");

--
-- MIGRATION VERSION FOR heartcradle_ai
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('heartcradle_ai', '20261003085427563-add-event-id', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261003085427563-add-event-id', "timestamp" = now();

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
