\set content `cat ../../SVTSW/Configurations/WaferTypeMappings/ER2WaferMap_v0.json`
INSERT INTO
main."WaferTypeMap" ("waferTypeId", "waferMap")
VALUES
(3, :'content'::json);

