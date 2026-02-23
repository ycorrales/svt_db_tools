-- Insert chips for SLDO
-- INSERT INTO main."Chip" ("asicId", "serialNumber", "generalLocation")
-- VALUES
-- (8873, 'MPW1-01_0_0', 'CERN_186_R_E10'),
-- (8874, 'MPW1-01_0_1', 'Brunel'),
-- (8875, 'MPW1-01_0_2', 'Darsburry'),
-- (8876, 'MPW1-01_0_3', 'Birmingham'),
-- (8877, 'MPW1-01_0_4', 'LBL');

-- Insert Chip location records
-- INSERT INTO main."ChipLocation" ("chipId", "generalLocation", "note")
--   VALUES
--   (1, 'CERN_186_R_E10', 'Location at creation'),
--   (2, 'Brunel', 'Location at creation'),
--   (3, 'Darsburry', 'Location at creation'),
--   (4, 'Birmingham', 'Location at creation'),
--   (5, 'LBL', 'Location at creation');

-- Insert SLDOs
-- INSERT INTO main."SLDO" ("chipId", "serialNumber")
-- VALUES
-- (1, 'SLDO-MPW1-01_0_0'),
-- (2, 'SLDO-MPW1-01_0_1'),
-- (3, 'SLDO-MPW1-01_0_2'),
-- (4, 'SLDO-MPW1-01_0_3'),
-- (5, 'SLDO-MPW1-01_0_4');

-- Insert SLDO test setup configuration
-- INSERT INTO main."SLDOTestConfiguration" ("name", "mode", "loadCapacitance", "loadCurrent", "temperature")
--   VALUES
--   ('Test_Config_1', 'Mode0', '10nF', '40mA', '27C'),
--   ('Test_Config_2', 'Mode1', '100nF', '500mA', '60C'),
--   ('Test_Config_3', 'Mode0', '1uF', '900mA', '105C'),
--   ('Test_Config_4', 'Mode1', '10uF', '40mA', '-20C'),
--   ('Test_Config_5', 'Mode0', '100nF', '500mA', '27C');

SELECT * FROM main."Wafer";
SELECT * FROM main."Asic" WHERE "familyType"='AncMPW1';
SELECT * FROM main."Chip";
SELECT * FROM main."SLDO";
SELECT * FROM main."SLDOTestConfiguration";
