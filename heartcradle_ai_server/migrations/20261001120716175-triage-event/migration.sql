BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "triage_event" (
    "id" bigserial PRIMARY KEY,
    "patientId" text NOT NULL,
    "heartRate" bigint NOT NULL,
    "spo2" bigint NOT NULL,
    "respiratoryRate" bigint NOT NULL,
    "temperature" double precision NOT NULL,
    "signalQuality" text NOT NULL,
    "decision" text NOT NULL,
    "reason" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR heartcradle_ai
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('heartcradle_ai', '20261001120716175-triage-event', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261001120716175-triage-event', "timestamp" = now();

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
