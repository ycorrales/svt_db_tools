#! /usr/bin/env bash
(
  set -euo pipefail

  db_name='svt_sw_db_test'
  db_schema='main'
  HOST='dbod-svt-sw-pgdb'

  thisScriptPath=$(cd "$(dirname "${BASH_SOURCE[0]:-0}")" &>/dev/null && pwd -P)

  _psql_exec() {
    eval " PGOPTIONS=\"--search_path=$db_schema\" psql${PSQL_CMD_SUFFIX:+${PSQL_CMD_SUFFIX}} -h $HOST -U admin -p 6600 ${*:+$*}"
  }

  _chTZ() {
    read -rp "Enter new TimeZone: " TZ
    local cmd="ALTER DATABASE ${db_name} SET TIMEZONE TO '${TZ}';"
    _psql_exec -c \""${cmd}"\"
  }

  _chpass() {
    read -rp "Enter new pass: " PASS
    local cmd="ALTER USER admin PASSWORD '${PASS}';"
    _psql_exec -c \""${cmd}"\"
  }

  _createdb() {
    local DB_NAME=${1:-}
    [ -z "$DB_NAME" ] && {
      echo "ERROR: no DB name provided."
      exit 1
    }
    local cmd="SELECT 1 FROM pg_database WHERE datname='${DB_NAME}';"
    if [[ "$(_psql_exec -XtAc \""$cmd"\")" == "1" ]]; then
      echo "DB ${DB_NAME} exits, exiting."
      exit 1
    else
      cmd="CREATE DATABASE ${DB_NAME};"
      _psql_exec -c \""${cmd}"\"
    fi
  }

  _dropdb() {
    local DB_NAME=${1:-}
    [ -z "$DB_NAME" ] && {
      echo "ERROR: no DB name provided."
      exit 1
    }
    local cmd="SELECT 1 FROM pg_database WHERE datname='${DB_NAME}';"
    if [[ "$(_psql_exec -XtAc \""$cmd"\")" != "1" ]]; then
      echo "DB ${DB_NAME} does not exits, exiting."
      exit 1
    else
      cmd="DROP DATABASE ${DB_NAME};"
      _psql_exec -c \""${cmd}"\"
    fi
  }

  _renamedb() {
    local oldDBNAME=${1:-}
    local newDBNAME=${2:-}
    if [ -z "$oldDBNAME" ] || [ -z "$newDBNAME" ]; then
      echo "usage --rename <old-db-name> <new-db-name>"
      exit 1
    fi

    echo "Renaming db $oldDBNAME to $newDBNAME"
    sql_file=$(mktemp -u rename.sql)
    sed -e "s/%oldDBNAME%/$oldDBNAME/g" -e "s/%newDBNAME%/$newDBNAME/g" "$thisScriptPath"/../sql_script/SVT-database-rename.sql >"$sql_file"
    _psql_exec '-a -f' "$sql_file"
    test -f "$sql_file" && rm "$sql_file"
  }

  _exec() {
    local opt=${1:-}
    local cmd=${2:-}
    db_names=${db_names:-$db_name}
    for db in "${db_names[@]}"; do
      echo -e "Executing cmd '$cmd' in db $db"
      _psql_exec "-d $db $opt '$cmd'"
    done
  }

  _run() {
    in_file=${1:-}
    [ -z "$in_file" ] && {
      echo "ERROR: script file not provided."
      exit 1
    }
    [[ -f "$in_file" ]] || {
      echo "ERROR script $in_file not found."
      exit 1
    }

    _exec '-a -f' "${in_file}"
  }

  [ $# -eq 0 ] && {
    echo "ERROR at least a argumentis needed"
    exit 1
  }

  PSQL_CMD_SUFFIX=
  while [ $# -gt 0 ]; do
    action=${1:-}

    case $action in
    --local)
      PSQL_CMD_SUFFIX='-17'
      HOST='localhost'
      shift
      ;;
    --db)
      db_name="${2:-}"
      shift 2
      ;;
    --schema)
      db_schema=${2:-}
      shift 2
      ;;
    --all)
      db_names=('svt_sw_db_test' 'svt_sw_db')
      shift
      ;;
    --chTZ)
      _chTZ
      shift
      ;;
    --chpass)
      _chpass
      shift
      ;;
    --createdb)
      _createdb "${2:-}"
      shift 2
      ;;
    --dropdb)
      _dropdb "${2:-}"
      shift 2
      ;;
    --renamedb)
      oldName=${2:-}
      newName=${3:-}
      [[ -n "$oldName" ]] && shift
      [[ -n "$newName" ]] && shift
      shift
      _renamedb "$oldName" "$newName"
      ;;
    --exec)
      _exec '-c' "${2:-}"
      shift 2
      ;;
    --run)
      _run "${2:-}"
      shift 2
      ;;
    --open)
      _psql_exec "-d ${db_name}"
      shift
      ;;
    *)
      echo "unknow action $action"
      exit 1
      ;;
    esac
  done
)
