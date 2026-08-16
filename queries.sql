-- =========================================================
-- Olist E-Commerce SQL Analysis
-- Dataset: Brazilian E-Commerce Public Dataset by Olist (Kaggle)
-- Tool: SQLite (DB Browser for SQLite)
-- =========================================================

-- ---------------------------------------------------------
-- Q1a: Top 10 product categories by total revenue
-- ---------------------------------------------------------
SELECT 
    ct.product_category_name_english,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
GROUP BY product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;


-- ---------------------------------------------------------
-- Q1b: Monthly revenue trend
-- ---------------------------------------------------------
SELECT 
    strftime('%Y-%m', order_approved_at) AS timeOfOrder,
    SUM(oi.price) AS total_revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY timeOfOrder
ORDER BY timeOfOrder;


-- ---------------------------------------------------------
-- Q2: Top 10 sellers by revenue (with order volume)
-- ---------------------------------------------------------
SELECT 
    s.seller_id, 
    SUM(oi.price) AS revenue, 
    COUNT(*) AS numberOfOrders
FROM order_items oi 
JOIN sellers s ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY revenue DESC
LIMIT 10;


-- ---------------------------------------------------------
-- Q3: Best-selling products vs. average review score
-- Note: reviews are joined via a subquery that collapses
-- duplicate review rows per order (some orders had 2-3
-- review entries) to avoid inflating unit-sold counts.
-- ---------------------------------------------------------
SELECT 
    oi.product_id, 
    COUNT(oi.order_id) AS unitSold, 
    ROUND(AVG(rev.avg_score), 1) AS reviewsScore
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
JOIN (
    SELECT order_id, AVG(review_score) AS avg_score
    FROM reviews
    GROUP BY order_id
) rev ON rev.order_id = o.order_id
GROUP BY p.product_id
ORDER BY unitSold DESC
LIMIT 20;
