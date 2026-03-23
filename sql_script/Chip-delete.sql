UPDATE main."Asic"
SET
  "chipId" = NULL;

delete from main."ChipLocation"
;

delete from main."Block"
;

select pg_catalog.setval('main."Block_id_seq"', 1, false)
;

delete from main."Chip"
;

delete from main."Chip"
;

select pg_catalog.setval('main."Chip_id_seq"', 1, false)
;

