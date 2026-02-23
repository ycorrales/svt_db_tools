ALTER TABLE "main"."WaferProbeMachine"
ADD COLUMN "loadedWaferOrientation" main."waferMapOrientation" DEFAULT NULL;

ALTER TABLE "main"."WaferProbeMachine"
ADD COLUMN "installedProbeCardOrientation" main."waferMapOrientation" DEFAULT NULL;

CREATE TABLE "main"."WaferLoadedInMachine" (
  "machineId" integer,
  "waferId" integer,
  "orientation" main."waferMapOrientation",
  "date" date DEFAULT (CURRENT_DATE),
  "username" varchar(50),
  "status" main."waferInMachineStatus"
);

CREATE TABLE "main"."ProbeCardInstalledInMachine" (
  "machineId" integer,
  "probeCardId" integer,
  "orientation" main."waferMapOrientation",
  "date" date DEFAULT (CURRENT_DATE),
  "username" varchar(50)
);

ALTER TABLE "main"."WaferLoadedInMachine" ADD FOREIGN KEY ("machineId") REFERENCES "main"."WaferProbeMachine" ("id");

ALTER TABLE "main"."WaferLoadedInMachine" ADD FOREIGN KEY ("waferId") REFERENCES "main"."Wafer" ("id");

ALTER TABLE "main"."ProbeCardInstalledInMachine" ADD FOREIGN KEY ("machineId") REFERENCES "main"."WaferProbeMachine" ("id");

ALTER TABLE "main"."ProbeCardInstalledInMachine" ADD FOREIGN KEY ("probeCardId") REFERENCES "main"."ProbeCard" ("id");

