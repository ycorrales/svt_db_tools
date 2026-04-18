#! /bin/bash
set -euo pipefail

case "${1:-}" in
-l | --local | local)
  isLocal=true
  shift
  ;;
esac

declare -A DB_MAP
DB_MAP["main"]='svt_sw_db'
DB_MAP["dev"]='svt_sw_db_test'

for env in "${!DB_NAME[@]}"; do
  DB_NAME=${DB_MAP["$env"]}
  echo "-------Dumping db $env-------"
  sh sh/psql.sh ${isLocal:+'--local'} --db "${DB_NAME}" --dumpdb
  echo "-------Renaming db $env-------"
  sh sh/psql.sh ${isLocal:+'--local'} --db "${DB_NAME}" --renamedb "${DB_NAME}_bk"
  echo "-------droping db $env-------"
  sh sh/psql.sh ${isLocal:+'--local'} --db "${DB_NAME}" --dropdb
  echo "-------creating db $env-------"
  sh sh/psql.sh ${isLocal:+'--local'} --db "${DB_NAME}" --createdb
  echo "-------creating table structure for db $env-------"
  echo "from file: sql_script/SVT_DB_Tables_SourceOfTruth.sql"
  sh sh/psql.sh ${isLocal:+'--local'} --db "${DB_NAME}" --run sql_script/SVT_DB_Tables_SourceOfTruth.sql
  echo "-------Restoring data to db $env-------"
  sh sh/psql.sh ${isLocal:+'--local'} --db "${DB_NAME}" --run "${DB_NAME}"-data.sql
done
