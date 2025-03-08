-- PARALLEL
-- Enable parallel execution
ALTER SYSTEM SET parallel_tuple_cost = 0.1;
ALTER SYSTEM SET parallel_setup_cost = 1000;
ALTER SYSTEM SET max_parallel_workers_per_gather = 4;


-- Postgresql relies on shared buffers and effective cache size for memory management
-- Configure shared buffers
ALTER SYSTEM SET shared_buffers = '2GB';

-- Configure cache size
ALTER SYSTEM SET effective_cache_size = '4GB';


-- Table partitioning: LIST, RANGE, HASH
-- Create a partitioned table (RANGE)
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL
) PARTITION BY RANGE (order_date);

-- Create partitions
CREATE TABLE orders_2023 PARTITION OF orders FOR VALUES FROM ('2023-01-01') TO ('2023-12-31');
CREATE TABLE orders_2024 PARTITION OF orders FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');


-- PostgreSQL for Foreign Data Wrapper (FDW) for Distributed Databases
-- Install and create the FDW extension
CREATE EXTENSION postgres_fdw;

-- Create a foreign server
CREATE SERVER remote_db FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'remote_host', dbname 'remote_db');

-- Create a foreign table
CREATE FOREIGN TABLE remote_users (
    id INT,
    name TEXT,
    email TEXT
) SERVER remote_db OPTIONS (schema_name 'public', table_name 'users');
