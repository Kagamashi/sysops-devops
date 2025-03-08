-- Postgresql supports multiple types of indexes for query optimization
-- B-TREE: default index type, optimized for equality and range queries
-- HASH: faster for equality comparisons but not used for sorting
-- GIN (Generalized Inverted Index): optimized for full-text search and JSONB
-- BRIN (Block Range INdex): efficient for large, append-only tables

-- Create a basic index
CREATE INDEX idx_users_email ON users(email);

-- Create a unique index
CREATE UNIQUE INDEX idx_users_email_unique ON users(email);

-- Create a GIN index for JSONB data
CREATE INDEX idx_users_jsonb ON users USING GIN(data_column);

-- Enable the pg_stat_statements extension
CREATE EXTENSION pg_stat_statements;

-- View the most time-consuming queries
SELECT * FROM pg_stat_statements ORDER BY total_exec_time DESC LIMIT 10;
