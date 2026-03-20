update main."SvtTestSetup"
set
  "defaultConfigId" = NULL
where
  "id" > 0;

delete from main."SvtTestSetupConfig"
where "id" > 0
;

select pg_catalog.setval('main."SvtTestSetupConfig_id_seq"', 1, false)
;

delete from main."SvtTestSetupEquipList"
;

delete from main."SvtTestSetup"
where "id" > 0
;

select pg_catalog.setval('main."SvtTestSetup_id_seq"', 1, false)
;

