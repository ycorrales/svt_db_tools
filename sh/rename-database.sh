#! /bin/bash

set -auo pipefail

clean_up() {
  local FNAME=${1:-}
  if [ -z "$FNAME" ]; then
    echo "ERROR: filemame is missing. Please specify file to delete"
    exit 1
  fi
  trap EXIT ERR SIGINT SIGTERM TSTP
  test -f "$FNAME" && rm -rf "$FNAME"
}

thisScriptPath=$(cd "$(dirname "${BASH_SOURCE[0]:-0}")" &>/dev/null && pwd -P)

DBNAME_OLD=${1:-'svt_sw_db_test'}
DBNAME_NEW=${1:-'svt_sw_db_test'}

FNAME=$(mktemp -u -t update_"${DBNAME}".sql)

echo "$FNAME"
sed -e "s/%DBNAME%/$DBNAME/g" "$thisScriptPath"/../sql_script/SVT-database-rename.sql >"$FNAME"

#shellcheck disable=2064
trap "clean_up $FNAME" EXIT ERR SIGINT SIGTERM TSTP
