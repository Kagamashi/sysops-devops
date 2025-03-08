\l  -- List databases
\dt  -- List tables in the current database
\du  -- List users and roles

-- QUERIES --
-- Creating a table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Altering a table (adding a column)
ALTER TABLE users ADD COLUMN age INT;

-- Dropping a column
ALTER TABLE users DROP COLUMN age;

-- Creating a table with a foreign key
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- SELECT
-- Select all columns from a table
SELECT * FROM users;

-- Select specific columns
SELECT name, email FROM users;

-- Select with filtering (WHERE clause)
SELECT * FROM users WHERE age > 25;


-- INSERT
-- Insert a single row
INSERT INTO users (name, email, age) VALUES ('Alice', 'alice@example.com', 30);

-- Insert multiple rows
INSERT INTO users (name, email, age) VALUES 
('Bob', 'bob@example.com', 28),
('Charlie', 'charlie@example.com', 35);


-- UPDATE
-- Update a user's age
UPDATE users SET age = 32 WHERE name = 'Alice';

-- Update multiple columns
UPDATE users SET email = 'bob.new@example.com', age = 29 WHERE name = 'Bob';


-- DELETE
-- Delete a specific user
DELETE FROM users WHERE name = 'Charlie';

-- Delete all users older than 40
DELETE FROM users WHERE age > 40;


-- QUERY PERFORMANCE --
-- Analyzing a query execution plan
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'john@example.com';

-- Creating an index
CREATE INDEX idx_users_email ON users(email);

-- Creating a unique index
CREATE UNIQUE INDEX idx_users_email_unique ON users(email);