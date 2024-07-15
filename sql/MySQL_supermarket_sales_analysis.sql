-- Sales Performance by Branch
SELECT branch, SUM(total) AS total_sales
FROM sales
GROUP BY branch
ORDER BY total_sales DESC;

-- Average Rating by Product Line
SELECT product_line, AVG(rating) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- Sales for each day
SELECT 
    date AS sales_date, 
    SUM(total) AS total_sales_amount, 
    SUM(quantity) AS total_sales_units, 
    SUM(total) / SUM(quantity) AS avg_item_price
FROM sales
GROUP BY date
ORDER BY date;

-- Sales for each month
SELECT 
    DATE_FORMAT(date, '%Y-%m') AS sales_month, 
    SUM(total) AS total_sales_amount,
    SUM(quantity) AS total_sales_units,
    SUM(total) / SUM(quantity) AS avg_item_price
FROM sales
GROUP BY DATE_FORMAT(date, '%Y-%m')
ORDER BY DATE_FORMAT(date, '%Y-%m');

-- Sales for each week
SELECT 
    YEARWEEK(date, 1) AS sales_week, 
    SUM(total) AS total_sales_amount,
    SUM(quantity) AS total_sales_units,
    SUM(total) / SUM(quantity) AS avg_item_price
FROM sales
GROUP BY YEARWEEK(date, 1)
ORDER BY YEARWEEK(date, 1);

-- Customer Preferences by Payment Method
SELECT payment, COUNT(*) AS number_of_transactions, SUM(total) AS total_sales_amount
FROM sales
GROUP BY payment
ORDER BY number_of_transactions DESC;

-- The Average Revenue per Customer Type (Members vs. Normal)
WITH CustomerRevenue AS (
    SELECT customer_type, SUM(total) AS total_revenue
    FROM sales
    GROUP BY customer_type
),
CustomerCount AS (
    SELECT customer_type, COUNT(DISTINCT invoice_id) AS total_customers
    FROM sales
    GROUP BY customer_type
)
SELECT 
    cr.customer_type, cr.total_revenue, cc.total_customers,
    cr.total_revenue / cc.total_customers AS avg_revenue_per_customer
FROM CustomerRevenue cr
JOIN CustomerCount cc ON cr.customer_type = cc.customer_type;

-- Sales Patterns across different days of the week and times of the day
WITH SalesWithWeekDay AS (
    SELECT *, DAYOFWEEK(date) AS weekday
    FROM sales
)
SELECT weekday, HOUR(time) AS hour, SUM(total) AS total_sales_amount
FROM SalesWithWeekDay
GROUP BY weekday, hour
ORDER BY weekday, hour;

-- Customer Segmentation Analysis based on their spending
WITH CustomerSpending AS (
    SELECT branch, customer_type, gender, SUM(total) AS total_spending
    FROM sales
    GROUP BY branch, customer_type, gender
)
SELECT branch, customer_type, gender, total_spending,
    CASE
        WHEN total_spending > 30000 THEN 'High Spender'
        WHEN total_spending BETWEEN 25000 AND 30000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS spending_segment
FROM CustomerSpending
ORDER BY total_spending DESC;

-- Forecasting Future Sales using a window function AVG
WITH DailySales AS (
    SELECT date, SUM(total) AS daily_total_sales
    FROM sales
    GROUP BY date
),
MovingAverage AS (
    SELECT date, daily_total_sales,
        AVG(daily_total_sales) OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS windowed_avg_week
    FROM DailySales
)
SELECT date, daily_total_sales, windowed_avg_week
FROM MovingAverage
ORDER BY date;

-- Anomaly Detection in Sales (Identifying days with extraordinary sales)
WITH DailySales AS (
    SELECT date, SUM(total) AS daily_total_sales
    FROM sales
    GROUP BY date
),
SalesStats AS (
    SELECT AVG(daily_total_sales) AS avg_sales, STDDEV(daily_total_sales) AS stddev_sales
    FROM DailySales
)
SELECT 
    ds.date, ds.daily_total_sales, ss.avg_sales, ss.stddev_sales,
    CASE
        WHEN ds.daily_total_sales > ss.avg_sales + 2 * ss.stddev_sales THEN 'High'
        WHEN ds.daily_total_sales < ss.avg_sales - 2 * ss.stddev_sales THEN 'Low'
        ELSE 'None'
    END AS anomaly_type
FROM DailySales ds
CROSS JOIN SalesStats ss 
WHERE ds.daily_total_sales > ss.avg_sales + 2 * ss.stddev_sales 
   OR ds.daily_total_sales < ss.avg_sales - 2 * ss.stddev_sales
ORDER BY ds.date;
