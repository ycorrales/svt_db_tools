#! /bin/bash

case "$1" in
-l | --local | local)
  isLocal=true
  shift
  ;;
esac

# sh sh/psql.sh ${isLocal:+'--local'} --db svt_sw_db_test --dumpdb
# sh sh/psql.sh ${isLocal:+'--local'} --db svt_sw_db_test --renamedb svt_sw_db_test_bk
sh sh/psql.sh ${isLocal:+'--local'} --db svt_sw_db_test --dropdb
sh sh/psql.sh ${isLocal:+'--local'} --db svt_sw_db_test --createdb
sh sh/psql.sh ${isLocal:+'--local'} --db svt_sw_db_test --run sql_script/SVT_DB_Tables_SourceOfTruth.sql
sh sh/psql.sh ${isLocal:+'--local'} --db svt_sw_db_test --run svt_sw_db_test-data.sql
