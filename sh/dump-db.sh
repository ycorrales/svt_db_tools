#! /bin/bash

set -auo pipefail

pg_dump -h dbod-svt-sw-pgdb -p 6600 -d svt_sw_db_test -U admin -s -F p -E UTF-8 -f "$DBNAME"-schema.sql
pg_dump -h dbod-svt-sw-pgdb -p 6600 -d svt_sw_db_test -U admin -a -F p -E UTF-8 -f "$DBNAME"-data.sql
