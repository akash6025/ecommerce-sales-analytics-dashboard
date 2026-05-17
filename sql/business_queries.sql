


CREATE TABLE ecommerce_data (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    order_year TEXT,
    order_month TEXT,
    order_day TEXT,
    customer_city TEXT,
    customer_state TEXT,
    payment_type TEXT,
    payment_value TEXT,
    product_id TEXT,
    seller_id TEXT,
    price TEXT,
    freight_value TEXT,
    product_category_name TEXT
);

SELECT COUNT(*)
FROM ecommerce_data;



-- =========================================
-- E-Commerce Sales Analytics SQL Queries
-- =========================================

-- Total Revenue
SELECT SUM(NULLIF(payment_value, '')::numeric) AS total_revenue
FROM ecommerce_data;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_data;

-- Top 10 States by Revenue
SELECT
    customer_state,
    SUM(NULLIF(payment_value, '')::numeric) AS revenue
FROM ecommerce_data
GROUP BY customer_state
ORDER BY revenue DESC
LIMIT 10;

-- Top Product Categories
SELECT
    product_category_name,
    SUM(NULLIF(payment_value, '')::numeric) AS revenue
FROM ecommerce_data
GROUP BY product_category_name
ORDER BY revenue DESC
LIMIT 10;

-- Monthly Revenue Trend
SELECT
    order_month,
    SUM(NULLIF(payment_value, '')::numeric) AS revenue
FROM ecommerce_data
GROUP BY order_month
ORDER BY order_month;

-- Payment Type Analysis
SELECT
    payment_type,
    SUM(NULLIF(payment_value, '')::numeric) AS revenue
FROM ecommerce_data
GROUP BY payment_type
ORDER BY revenue DESC;

-- Top Customers
SELECT
    customer_id,
    SUM(NULLIF(payment_value, '')::numeric) AS total_spent
FROM ecommerce_data
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Average Order Value
SELECT
    SUM(NULLIF(payment_value, '')::numeric) /
    COUNT(DISTINCT order_id) AS average_order_value
FROM ecommerce_data;

-- Orders Per State
SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_data
GROUP BY customer_state
ORDER BY total_orders DESC;

-- Estimated State Profitability
SELECT
    customer_state,
    SUM(NULLIF(payment_value, '')::numeric) - SUM(NULLIF(freight_value, '')::numeric) AS profitability
FROM ecommerce_data
GROUP BY customer_state
ORDER BY profitability DESC;