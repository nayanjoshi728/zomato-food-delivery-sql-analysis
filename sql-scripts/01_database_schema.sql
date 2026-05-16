-- =========================
-- CREATE DATABASE
-- =========================

CREATE DATABASE IF NOT EXISTS zomato_project;
USE zomato_project;


-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE IF NOT EXISTS customers (
    customer_id   INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(25),
    reg_date      DATE
);

CREATE TABLE IF NOT EXISTS restaurants (
    restaurant_id   INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(55),
    city            VARCHAR(15),
    opening_hours   VARCHAR(55)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    customer_id   INT,
    restaurant_id INT,
    order_item    VARCHAR(55),
    order_date    DATE,
    order_time    TIME,
    order_status  VARCHAR(55),
    total_amount  FLOAT,
    FOREIGN KEY (customer_id)   REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE IF NOT EXISTS riders (
    rider_id   INT AUTO_INCREMENT PRIMARY KEY,
    rider_name VARCHAR(55),
    sign_up    DATE
);

CREATE TABLE IF NOT EXISTS deliveries (
    delivery_id     INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT,
    delivery_status VARCHAR(35),
    delivery_time   TIME,
    rider_id        INT,
    FOREIGN KEY (order_id)  REFERENCES orders(order_id),
    FOREIGN KEY (rider_id)  REFERENCES riders(rider_id)
);
