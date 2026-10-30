-- Data validation queries for the SauceDemo test data

-- 1. Every product has a positive price (should return 0 rows)
SELECT product_id, name, price
FROM products
WHERE price <= 0;

-- 2. Exactly six products exist, matching the "six items" UI test
SELECT COUNT(*) AS product_count
FROM products;

-- 3. Locked-out user is flagged correctly (matches TC-LOGIN-02)
SELECT username, is_locked_out
FROM users
WHERE username = 'locked_out_user';

-- 4. Orders with their customer, using a join
SELECT o.order_id, u.username, o.order_date
FROM orders o
         JOIN users u ON u.user_id = o.user_id
ORDER BY o.order_id;

-- 5. Items in each order with product names (multi-table join)
SELECT oi.order_id, p.name, oi.quantity, p.price,
       oi.quantity * p.price AS line_total
FROM order_items oi
         JOIN products p ON p.product_id = oi.product_id
ORDER BY oi.order_id, p.name;

-- 6. Total spent per user (aggregate with GROUP BY)
SELECT u.username,
       COUNT(DISTINCT o.order_id)        AS order_count,
       SUM(oi.quantity * p.price)        AS total_spent
FROM users u
         JOIN orders o       ON o.user_id = u.user_id
         JOIN order_items oi ON oi.order_id = o.order_id
         JOIN products p     ON p.product_id = oi.product_id
GROUP BY u.username;

-- 7. Products never ordered (LEFT JOIN with a NULL check)
SELECT p.product_id, p.name
FROM products p
         LEFT JOIN order_items oi ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

-- 8. Users with orders over $40 in total (HAVING)
SELECT u.username, SUM(oi.quantity * p.price) AS total_spent
FROM users u
         JOIN orders o       ON o.user_id = u.user_id
         JOIN order_items oi ON oi.order_id = o.order_id
         JOIN products p     ON p.product_id = oi.product_id
GROUP BY u.username
HAVING SUM(oi.quantity * p.price) > 40;