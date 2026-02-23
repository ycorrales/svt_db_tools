-- disconnect from the database to be renamed
\c postgres

-- force disconnect all other clients from the database to be renamed
SELECT pg_terminate_backend( pid )
FROM pg_stat_activity
WHERE pid <> pg_backend_pid( )
    AND datname = 'svt_test';

-- it should now have zero client
-- clone the database
-- CREATE DATABASE "svt_sw_db" WITH TEMPLATE "svt_sw_db_test" OWNER "admin";

-- rename the database
ALTER DATABASE "svt_test" RENAME TO "svt_sw_db_test";
