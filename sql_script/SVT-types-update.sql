--Taking from
ALTER TYPE "wpGeneralLocation" RENAME TO "wpGeneralLocation_old";

CREATE TYPE "wpGeneralLocation" AS ENUM (
  'CERN_186_R_E10',
  'Prague',
  'LosAlamos',
  'BNL',
  'RAL',
  'Darsburry',
  'Brunel',
  'Birmingham',
  'Liverpool'
);

ALTER TABLE Wafer ALTER COLUMN generalLocation TYPE "wpGeneralLocation" USING (generalLocation::text::"wpGeneralLocation");

ALTER TABLE WaferLocation ALTER COLUMN generalLocation TYPE "wpGeneralLocation" USING (generalLocation::text::"wpGeneralLocation");

ALTER TABLE WaferProbeMachine ALTER COLUMN generalLocation TYPE "wpGeneralLocation" USING (generalLocation::text::"wpGeneralLocation");

ALTER TABLE Chip ALTER COLUMN generalLocation TYPE "wpGeneralLocation" USING (generalLocation::text::"wpGeneralLocation");

ALTER TABLE ChipLocation ALTER COLUMN generalLocation TYPE "wpGeneralLocation" USING (generalLocation::text::"wpGeneralLocation");

ALTER TABLE TestSetup ALTER COLUMN location TYPE "wpGeneralLocation" USING (location::text::"wpGeneralLocation");

DROP TYPE "wpGeneralLocation_old";
