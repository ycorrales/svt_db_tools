-- \set content `cat db_tools/config_json/ts_mit.json`
-- \set content `cat db_tools/config_json/analog_monitoring_prober_mit.json`
\set content `cat db_tools/config_json/sldo_ts_brunel.json`
INSERT INTO
main."SvtTestSetupConfigBody" ("setupConfigId", "configBody")
VALUES
(3, :'content'::json);

