#! /bin/bash
sh sh/psql.sh --local --db svt_sw_db_test --dumpdb
sh sh/psql.sh --local --db svt_sw_db_test --renamedb svt_sw_db_test_bk
sh sh/psql.sh --local --db svt_sw_db_test --createdb
sh sh/psql.sh --local --db svt_sw_db_test --run sql_script/SVT_DB_Tables_SourceOfTruth.sql
