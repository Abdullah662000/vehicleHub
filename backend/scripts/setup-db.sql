-- Run as a Postgres superuser after install, e.g.:
--   psql -U postgres -f scripts/setup-db.sql
-- Then set DATABASE_PASSWORD in backend/.env to the password you use for this role.

DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'vehiclehub') THEN
    CREATE ROLE vehiclehub LOGIN PASSWORD 'change_me';
  END IF;
END
$$;

SELECT 'CREATE DATABASE vehiclehub OWNER vehiclehub'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'vehiclehub')\gexec

GRANT ALL PRIVILEGES ON DATABASE vehiclehub TO vehiclehub;
