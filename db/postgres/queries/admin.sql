-- ROLE BASED ACCESS CONTROL --
-- Create a new user
CREATE ROLE myuser WITH LOGIN PASSWORD 'securepassword';

-- Create an admin role without login
CREATE ROLE admin_role;

-- Grant privileges on a database
GRANT CONNECT ON DATABASE mydb TO myuser;

-- Grant privileges on a table
GRANT SELECT, INSERT ON users TO myuser;

-- Revoke privileges
REVOKE INSERT ON users FROM myuser;


-- SCHEMA MANAGEMENT --
-- Create a new database
CREATE DATABASE mydb;

-- Drop a database
DROP DATABASE mydb;

-- Create a new schema
CREATE SCHEMA my_schema;

-- Set default schema for a user
ALTER ROLE myuser SET search_path TO my_schema;


-- VACUUMING --
-- autovacuum: automatically reclaims storage and updates statistics
-- vacuum: removed dead tuples from tables
-- analyze: updates optimizer statistics

-- Manually vacuum a table
VACUUM users;

-- Vacuum and analyze a table
VACUUM ANALYZE users;

-- Rebuild a table to reclaim space
VACUUM FULL users;

-- Reindex a table to optimize performance
REINDEX TABLE users;
