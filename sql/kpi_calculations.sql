/* ============================
   KPI CALCULATIONS
   ============================ */

/* Total Revenue */
SELECT
    SUM(revenue) AS total_revenue
FROM sales;


/* Monthly Revenue */
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(revenue) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;


/* Month-over-Month Revenue Growth (%) */
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(revenue) AS monthly_revenue
    FROM sales
    GROUP BY month
)
SELECT
    month,
    monthly_revenue,
    ROUND(
        (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month))
        / LAG(monthly_revenue) OVER (ORDER BY month) * 100,
        2
    ) AS monthly_growth_pct
FROM monthly_sales
ORDER BY month;


/* Revenue by Region with Percentage Contribution */
SELECT
    region,
    SUM(revenue) AS region_revenue,
    ROUND(
        SUM(revenue) * 100.0 / SUM(SUM(revenue)) OVER (),
        2
    ) AS revenue_percentage
FROM sales
GROUP BY region
ORDER BY region_revenue DESC;
