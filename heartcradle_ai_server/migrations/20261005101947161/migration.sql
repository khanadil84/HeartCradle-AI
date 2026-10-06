BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mission" (
    "id" bigserial PRIMARY KEY,
    "missionId" text,
    "patientId" text NOT NULL,
    "status" text NOT NULL,
    "completedSteps" bigint NOT NULL,
    "totalSteps" bigint NOT NULL,
    "currentStep" text NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "completedAt" timestamp without time zone,
    "lastEvent" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "mission__missionId__unique_idx" ON "mission" USING btree ("missionId");


--
-- MIGRATION VERSION FOR heartcradle_ai
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('heartcradle_ai', '20261005101947161', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005101947161', "timestamp" = now();

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
