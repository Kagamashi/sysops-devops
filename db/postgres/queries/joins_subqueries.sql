-- JOIN --
-- INNER JOIN (returns matching rows in both tables)
SELECT users.name, orders.order_date
FROM users
INNER JOIN orders ON users.id = orders.user_id;

-- LEFT JOIN (returns all users, with orders if available)
SELECT users.name, orders.order_date
FROM users
LEFT JOIN orders ON users.id = orders.user_id;

-- RIGHT JOIN (returns all orders, with user info if available)
SELECT users.name, orders.order_date
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;

-- FULL JOIN (returns all records from both tables)
SELECT users.name, orders.order_date
FROM users
FULL JOIN orders ON users.id = orders.user_id;

-- SUBQUERIES and COMMON TABLE EXTPRESSIONS
-- Using a subquery
SELECT name FROM users WHERE id IN (SELECT user_id FROM orders);

-- Using a CTE (Common Table Expression)
WITH user_orders AS (
    SELECT user_id, COUNT(*) AS order_count FROM orders GROUP BY user_id
)
SELECT users.name, user_orders.order_count
FROM users
LEFT JOIN user_orders ON users.id = user_orders.user_id;
