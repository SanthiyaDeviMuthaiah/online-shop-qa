-- Online Shop test data schema
-- Mirrors the data the SauceDemo tests rely on, so expected values can be checked with SQL.

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
                       user_id       INTEGER PRIMARY KEY,
                       username      VARCHAR(50)  NOT NULL UNIQUE,
                       password      VARCHAR(50)  NOT NULL,
                       is_locked_out BOOLEAN      NOT NULL DEFAULT 0
);

CREATE TABLE products (
                          product_id    INTEGER PRIMARY KEY,
                          name          VARCHAR(100) NOT NULL,
                          price         DECIMAL(10,2) NOT NULL CHECK (price > 0)
);

CREATE TABLE orders (
                        order_id      INTEGER PRIMARY KEY,
                        user_id       INTEGER NOT NULL REFERENCES users(user_id),
                        order_date    DATE    NOT NULL
);

CREATE TABLE order_items (
                             order_id      INTEGER NOT NULL REFERENCES orders(order_id),
                             product_id    INTEGER NOT NULL REFERENCES products(product_id),
                             quantity      INTEGER NOT NULL CHECK (quantity > 0),
                             PRIMARY KEY (order_id, product_id)
);

-- Test data
INSERT INTO users (user_id, username, password, is_locked_out) VALUES
                                                                   (1, 'standard_user',   'secret_sauce', 0),
                                                                   (2, 'locked_out_user', 'secret_sauce', 1),
                                                                   (3, 'problem_user',    'secret_sauce', 0);

INSERT INTO products (product_id, name, price) VALUES
                                                   (1, 'Sauce Labs Backpack',         29.99),
                                                   (2, 'Sauce Labs Bike Light',        9.99),
                                                   (3, 'Sauce Labs Bolt T-Shirt',     15.99),
                                                   (4, 'Sauce Labs Fleece Jacket',    49.99),
                                                   (5, 'Sauce Labs Onesie',            7.99),
                                                   (6, 'Test.allTheThings() T-Shirt', 15.99);


INSERT INTO orders (order_id, user_id, order_date) VALUES
                                                       (1001, 1, '2026-10-01'),
                                                       (1002, 1, '2026-10-15');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
                                                             (1001, 1, 1),
                                                             (1001, 3, 2),
                                                             (1002, 2, 1);