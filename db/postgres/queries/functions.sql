-- COUNT: counting rows
-- Count total number of users
SELECT COUNT(*) FROM users;

-- Count users above age 30
SELECT COUNT(*) FROM users WHERE age > 30;


-- SUM: summing values
-- Sum total sales from an orders table
SELECT SUM(total_price) FROM orders;

-- Sum sales per user
SELECT user_id, SUM(total_price) FROM orders GROUP BY user_id;


-- AVG: calculating averages
-- Average age of all users
SELECT AVG(age) FROM users;

-- Average order price per user
SELECT user_id, AVG(total_price) FROM orders GROUP BY user_id;


-- CASE: conditional logic
-- Categorizing users based on age
SELECT name, age,
    CASE
        WHEN age < 18 THEN 'Minor'
        WHEN age BETWEEN 18 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category
FROM users;


-- GROUP BY: grouping data
-- Count users by age group
SELECT age, COUNT(*) FROM users GROUP BY age;

-- Total sales per year
SELECT EXTRACT(YEAR FROM order_date) AS year, SUM(total_price)
FROM orders
GROUP BY year;
