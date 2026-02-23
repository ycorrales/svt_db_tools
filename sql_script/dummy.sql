-- INSERT INTO TestSetup (name, location) VALUES
-- ('SLDO_MPW1','Brunel'),
-- ('SLDO_MPW1', 'Birmingham'),
-- ('SLDO_MPW1', 'Darsburry'),
-- ('NVG_MPW2', 'LBL'),
-- ('MOSAIX_1', 'CERN_186_R_E10')
-- delete from main."WaferTypeMap"
-- where "waferTypeId" >= 3
-- ;
--
-- delete from main."WaferType"
-- where "id" >= 3
-- ;
--
-- ALTER SEQUENCE main."WaferType_id_seq"
-- RESTART WITH 3;
-- delete from main."Asic"
-- where "waferId" = 4
-- ;
--
-- ALTER SEQUENCE main."Asic_id_seq"
-- RESTART WITH 8878;
delete from main."ChipLocation"
where "chipId" >= 11
;

delete from main."Chip"
where "id" >= 11
;

ALTER SEQUENCE main."Chip_id_seq"
RESTART WITH 11;

--
-- delete from main."WaferLocation"
-- where "waferId" = 4
-- ;
--
-- delete from main."Wafer"
-- where "id" = 4
-- ;
--
-- ALTER SEQUENCE main."Wafer_id_seq"
-- RESTART WITH 4;
-- delete from main."Equipment"
-- ;
--
-- ALTER SEQUENCE main."Equipment_id_seq"
-- RESTART WITH 1;
--
-- delete from main."EquipmentLocation"
-- ;
--

