-- update main."SvtTestSetup"
-- set
-- "defaultConfigId" = NULL
-- where
-- "id" = 3;
delete from main."WaferTypeMap"
where "waferTypeId" > 3
;

delete from main."WaferType"
where "id" > 3
;

select pg_catalog.setval('main."WaferType_id_seq"', 3, true)
;

