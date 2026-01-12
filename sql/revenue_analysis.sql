/* ============================
   REVENUE ANALYSIS
   ============================ */

/* Revenue by Region */
SELECT
    region,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;


/* Monthly Revenue Trend by Region */
SELECT
    DATE_TRUNC('month', order_date) AS month,
    region,
    SUM(revenue) AS monthly_revenue
FROM sales
GROUP BY month, region
ORDER BY month, region;


/* Top 10 Products by Revenue */
SELECT
    product_name,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;


/* Revenue Contribution by Product Category */
SELECT
    product_category,
    SUM(revenue) AS category_revenue,
    ROUND(
        SUM(revenue) * 100.0 / SUM(SUM(revenue)) OVER (),
        2
    ) AS revenue_share_pct
FROM sales
GROUP BY product_category
ORDER BY category_revenue DESC;


/* Quarterly Revenue (Seasonality Analysis) */
SELECT
    EXTRACT(quarter FROM order_date) AS quarter,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY quarter
ORDER BY quarter;
