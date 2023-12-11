-- Monthly Order Analysis (2016-2018)
-- This query calculates the total number of orders for each month from 2016 to 2018, ordered chronologically.
SELECT
    FORMAT(order_purchase_timestamp, 'MM-yyyy') AS MonthYear,
    COUNT(Order_id) AS total_orders
FROM
    [EcommerceOlist].[dbo].[olist_orders_dataset$]
WHERE
    YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY
    FORMAT(order_purchase_timestamp, 'MM-yyyy'), YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
ORDER BY
    YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp);

-- Order Distribution by Time of Day (2016-2018)
-- This query segments total orders into time categories (Dawn, Morning, Afternoon, Night) from 2016 to 2018.
SELECT
    CASE
        WHEN DATEPART(HOUR, order_purchase_timestamp) >= 0 AND DATEPART(HOUR, order_purchase_timestamp) < 6 THEN 'Dawn'
        WHEN DATEPART(HOUR, order_purchase_timestamp) >= 6 AND DATEPART(HOUR, order_purchase_timestamp) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, order_purchase_timestamp) >= 12 AND DATEPART(HOUR, order_purchase_timestamp) < 18 THEN 'Afternoon'
        ELSE 'Night'
    END AS part_of_day,
    Count(order_id) AS total_orders
FROM
    [EcommerceOlist].[dbo].[olist_orders_dataset$]
WHERE
    YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY
    CASE 
        WHEN DATEPART(HOUR, order_purchase_timestamp) >= 0 AND DATEPART(HOUR, order_purchase_timestamp) < 6 THEN 'Dawn'
        WHEN DATEPART(HOUR, order_purchase_timestamp) >= 6 AND DATEPART(HOUR, order_purchase_timestamp) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, order_purchase_timestamp) >= 12 AND DATEPART(HOUR, order_purchase_timestamp) < 18 THEN 'Afternoon'
        ELSE 'Night'
    END
ORDER BY
    total_orders DESC;

-- Weekly Sales Analysis (2016-2018)
-- This query determines the total number of orders for each day of the week from 2016 to 2018, ordered by total sales.
SELECT
    DATENAME(WEEKDAY, order_purchase_timestamp) AS full_day_name,
    FORMAT(order_purchase_timestamp, 'ddd') AS abbreviated_day_name,
    Count(Order_id) AS total_orders
FROM
    [EcommerceOlist].[dbo].[olist_orders_dataset$]
WHERE
    YEAR(order_purchase_timestamp) BETWEEN 2016 AND 2018
GROUP BY
    DATENAME(WEEKDAY, order_purchase_timestamp),
    FORMAT(order_purchase_timestamp, 'ddd')
ORDER BY
    CASE
        WHEN DATENAME(WEEKDAY, order_purchase_timestamp) = 'Monday' THEN 1
        WHEN DATENAME(WEEKDAY, order_purchase_timestamp) = 'Tuesday' THEN 2
        WHEN DATENAME(WEEKDAY, order_purchase_timestamp) = 'Wednesday' THEN 3
        WHEN DATENAME(WEEKDAY, order_purchase_timestamp) = 'Thursday' THEN 4
        WHEN DATENAME(WEEKDAY, order_purchase_timestamp) = 'Friday' THEN 5
        WHEN DATENAME(WEEKDAY, order_purchase_timestamp) = 'Saturday' THEN 6
        WHEN DATENAME(WEEKDAY, order_purchase_timestamp) = 'Sunday' THEN 7
    END;

-- Year-Over-Year Order Comparison (2017 vs 2018)
-- Compares the number of orders month-by-month for 2017 and 2018.
SELECT
    YEAR(order_purchase_timestamp) AS SaleYear,
    MONTH(order_purchase_timestamp) AS SaleMonth,
    LEFT(DATENAME(MONTH, order_purchase_timestamp), 3) AS MonthName,
    COUNT(order_id) AS total_orders
FROM
    [EcommerceOlist].[dbo].[olist_orders_dataset$]
WHERE
    (YEAR(order_purchase_timestamp) = 2017 OR YEAR(order_purchase_timestamp) = 2018)
    AND (MONTH(order_purchase_timestamp) >= 1 AND MONTH(order_purchase_timestamp) <= 8)
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp),
    DATENAME(MONTH, order_purchase_timestamp)  
ORDER BY
    SaleYear,
    SaleMonth;

-- KPI Analysis: Total Orders in 2017 and 2018
-- Calculates the total number of orders for the years 2017 and 2018.
SELECT 
YEAR(order_purchase_timestamp) AS SaleYear , 
 COUNT(order_id) AS total_orders
FROM 
[EcommerceOlist].[dbo].[olist_orders_dataset$]
 WHERE
    (YEAR(order_purchase_timestamp) = 2017 OR YEAR(order_purchase_timestamp) = 2018)
    AND (MONTH(order_purchase_timestamp) >= 1 AND MONTH(order_purchase_timestamp) <= 8)
GROUP BY 
YEAR(order_purchase_timestamp)

-- State-wise E-commerce Order Evolution (Jan 2017 - Aug 2018)
-- Tracks the monthly evolution of orders in each Brazilian state from January 2017 to August 2018.
SELECT 
    oc.customer_state AS State,
    FORMAT(oo.order_purchase_timestamp, 'MM-yyyy') AS MonthYear,
    CONCAT(YEAR(oo.order_purchase_timestamp), FORMAT(oo.order_purchase_timestamp, 'MM')) AS YearMonth,
    COUNT(oo.order_id) AS total_orders
FROM 
    [EcommerceOlist].[dbo].[olist_orders_dataset$] AS oo
JOIN 
    [EcommerceOlist].[dbo].[olist_customers_dataset$] AS oc ON oo.customer_id = oc.customer_id
WHERE 
    oo.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
GROUP BY 
    oc.customer_state,
    FORMAT(oo.order_purchase_timestamp, 'MM-yyyy'),
    CONCAT(YEAR(oo.order_purchase_timestamp), FORMAT(oo.order_purchase_timestamp, 'MM'))
ORDER BY 
    YearMonth, State;

-- National E-commerce  Order Evolution (Jan 2017 - Aug 2018)
-- Analyzes the overall growth of orders across Brazil from January 2017 to August 2018.
SELECT 
    FORMAT(oo.order_purchase_timestamp, 'MM-yyyy') AS MonthYear,
    CONCAT(YEAR(oo.order_purchase_timestamp), FORMAT(oo.order_purchase_timestamp, 'MM')) AS YearMonth,
    COUNT(oo.order_id) AS total_orders
FROM 
    [EcommerceOlist].[dbo].[olist_orders_dataset$] AS oo
JOIN 
    [EcommerceOlist].[dbo].[olist_customers_dataset$] AS oc ON oo.customer_id = oc.customer_id
WHERE 
    oo.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
GROUP BY 
    FORMAT(oo.order_purchase_timestamp, 'MM-yyyy'), CONCAT(YEAR(oo.order_purchase_timestamp), FORMAT(oo.order_purchase_timestamp, 'MM'))
ORDER BY 
    YearMonth; 

-- State Order Generation Analysis (Jan 2017 - Aug 2018)
-- Determines which Brazilian states generated the most orders from January 2017 to August 2018.
SELECT    
    oc.customer_state AS State, 
    COUNT(oo.order_id) AS total_orders
FROM 
    [EcommerceOlist].[dbo].[olist_orders_dataset$] AS oo
JOIN 
    [EcommerceOlist].[dbo].[olist_customers_dataset$] AS oc ON oo.customer_id = oc.customer_id
WHERE 
    oo.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
GROUP BY 
    oc.customer_state 
ORDER BY 
    total_orders DESC;

-- Top 10 Cities in Order Volume (Jan 2017 - Aug 2018)
-- Identifies the top 10 Brazilian cities with the highest order volume from January 2017 to August 2018.
SELECT
    TOP 10 oc.customer_city AS City,
    COUNT(oo.order_id) AS total_orders
FROM 
    [EcommerceOlist].[dbo].[olist_orders_dataset$] AS oo
JOIN 
    [EcommerceOlist].[dbo].[olist_customers_dataset$] AS oc ON oo.customer_id = oc.customer_id
WHERE 
    oo.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
GROUP BY 
    oc.customer_city 
ORDER BY 
    total_orders DESC;

-- Monthly Sales and Order Count (Jan 2017 - Aug 2018)
-- Computes total orders and sales for each month, formatted as 'YYYYMM', from January 2017 to August 2018.
SELECT
    YEAR(oo.order_purchase_timestamp) AS Year,
    MONTH(oo.order_purchase_timestamp) AS Month,
    FORMAT(oo.order_purchase_timestamp, 'MM-yyyy') AS MonthYear,
    CONCAT(YEAR(oo.order_purchase_timestamp), FORMAT(oo.order_purchase_timestamp, 'MM')) AS SaleYear,
    COUNT(oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM
    [EcommerceOlist].[dbo].[olist_orders_dataset$] AS oo
JOIN
    [EcommerceOlist].[dbo].[olist_order_items_dataset$] AS oi ON oo.order_id = oi.order_id
WHERE 
    oo.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
GROUP BY
    YEAR(oo.order_purchase_timestamp),
    MONTH(oo.order_purchase_timestamp),
    FORMAT(oo.order_purchase_timestamp, 'MM-yyyy'),
    CONCAT(YEAR(oo.order_purchase_timestamp), FORMAT(oo.order_purchase_timestamp, 'MM'))
ORDER BY
    Year,
    Month;

-------------------------------------------------------DELIVERY 
----- Comprehensive Metrics on Order Delivery Timelines
 WITH OrderSteps AS (
  SELECT
    order_id,
    customer_id,
    order_status,
    CAST(DATEDIFF(SECOND, order_purchase_timestamp, order_approved_at) AS BIGINT) AS purchase_to_approval_seconds,
    CAST(DATEDIFF(SECOND, order_approved_at, order_delivered_carrier_date) AS BIGINT) AS approval_to_carrier_seconds,
    CAST(DATEDIFF(SECOND, order_delivered_carrier_date, order_delivered_customer_date) AS BIGINT) AS carrier_to_customer_seconds,
    CAST(DATEDIFF(SECOND, order_delivered_carrier_date, order_estimated_delivery_date) AS BIGINT) AS carrier_to_estimated_seconds , 
    CAST(DATEDIFF(SECOND, order_purchase_timestamp, order_delivered_customer_date) AS BIGINT) AS avg_delivery ,
    CAST(DATEDIFF(SECOND, order_purchase_timestamp, order_estimated_delivery_date) AS BIGINT) AS estimated_delivery 
  FROM
    EcommerceOlist.dbo.olist_orders_dataset$
  WHERE 
    order_status = 'delivered'  
)

SELECT
  CAST(ROUND(AVG(purchase_to_approval_seconds / 3600.0), 0) AS INT) AS avg_purchase_to_approval_hours,
  CAST(ROUND(AVG(approval_to_carrier_seconds / 86400.0), 0) AS INT) AS avg_approval_to_carrier_days,
  CAST(ROUND(AVG(carrier_to_customer_seconds / 86400.0), 0) AS INT) AS avg_carrier_to_customer_days,
  CAST(ROUND(AVG(carrier_to_estimated_seconds / 86400.0), 0) AS INT) AS avg_carrier_to_estimated_days , 
  CAST(ROUND(AVG(avg_delivery / 86400.0), 0) AS INT) AS Avg_delivery , 
  CAST(ROUND(AVG(estimated_delivery / 86400.0), 0) AS INT) AS Estimated_delivery , 
  CAST(ROUND(AVG((avg_delivery - estimated_delivery) / 86400.0), 0) AS INT) AS avg_delivery_vs_estimated
FROM
  OrderSteps;

-- State-Wise Analysis of Average Delivery Times
WITH OrderSteps AS (
  SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    CAST(DATEDIFF(SECOND, o.order_purchase_timestamp, o.order_approved_at) AS BIGINT) AS purchase_to_approval_seconds,
    CAST(DATEDIFF(SECOND, o.order_approved_at, o.order_delivered_carrier_date) AS BIGINT) AS approval_to_carrier_seconds,
    CAST(DATEDIFF(SECOND, o.order_delivered_carrier_date, o.order_delivered_customer_date) AS BIGINT) AS carrier_to_customer_seconds,
    CAST(DATEDIFF(SECOND, o.order_delivered_carrier_date, o.order_estimated_delivery_date) AS BIGINT) AS carrier_to_estimated_seconds , 
    CAST(DATEDIFF(SECOND, o.order_purchase_timestamp, o.order_delivered_customer_date) AS BIGINT) AS avg_delivery ,
    CAST(DATEDIFF(SECOND, o.order_purchase_timestamp, o.order_estimated_delivery_date) AS BIGINT) AS estimated_delivery,
    c.customer_state
  FROM
    EcommerceOlist.dbo.olist_orders_dataset$ o
    JOIN EcommerceOlist.dbo.olist_customers_dataset$ c ON o.customer_id = c.customer_id
  WHERE 
    o.order_status = 'delivered'  
)

SELECT
  customer_state,
  CAST(ROUND(AVG(purchase_to_approval_seconds / 3600.0), 0) AS INT) AS avg_purchase_to_approval_hours,
  CAST(ROUND(AVG(approval_to_carrier_seconds / 86400.0), 0) AS INT) AS avg_approval_to_carrier_days,
  CAST(ROUND(AVG(carrier_to_customer_seconds / 86400.0), 0) AS INT) AS avg_carrier_to_customer_days,
  CAST(ROUND(AVG(carrier_to_estimated_seconds / 86400.0), 0) AS INT) AS avg_carrier_to_estimated_days , 
  CAST(ROUND(AVG(avg_delivery / 86400.0), 0) AS INT) AS Avg_delivery , 
  CAST(ROUND(AVG(estimated_delivery / 86400.0), 0) AS INT) AS Estimated_delivery , 
  CAST(ROUND(AVG((avg_delivery - estimated_delivery) / 86400.0), 0) AS INT) AS avg_delivery_vs_estimated
FROM
  OrderSteps
GROUP BY
  customer_state
  order by Estimated_delivery
---------------------------------------------------------------------PAYMENT TYPE
  ---Payment Type Analysis
  SELECT
  payment_type,
  COUNT(*) AS OrderCount,
  CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5, 2)) AS Percentage
FROM EcommerceOlist.dbo.olist_order_payments_dataset$
GROUP BY payment_type
ORDER BY Percentage DESC;
-----Evolution of Payment Types Over Time
SELECT
  op.payment_type,
  FORMAT(oo.order_purchase_timestamp, 'yyyyMM') AS YearMonth,
  COUNT(*) AS OrderCount,
  CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY FORMAT(oo.order_purchase_timestamp, 'yyyyMM')) AS DECIMAL(5, 2)) AS Percentage
FROM EcommerceOlist.dbo.olist_order_payments_dataset$ op
JOIN EcommerceOlist.dbo.olist_orders_dataset$ oo ON op.order_id = oo.order_id
WHERE 
    oo.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
GROUP BY 
  op.payment_type,
  FORMAT(oo.order_purchase_timestamp, 'yyyyMM')
ORDER BY 
  YearMonth, Percentage DESC;


---------------------------------------------------------------REVIEWS
---- Distribution of Customer Review Scores
  select review_score,
  COUNT(*) AS ReviewCount,
  CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5, 2)) AS Percentage
FROM EcommerceOlist.dbo.olist_order_reviews_dataset$
GROUP BY review_score
ORDER BY review_score DESC;

-- Calculating the Average Review Score
Select Round(Avg(review_score),2) as Avgreview
FROM EcommerceOlist.dbo.olist_order_reviews_dataset$

-- Tracking Changes in Average Review Scores Over Time (2017-2018)
Select 
YEAR(review_creation_date) as Year , 
MONTH(review_creation_date) as Month ,
Round(Avg(review_score),2) as Avgreview
FROM EcommerceOlist.dbo.olist_order_reviews_dataset$
 WHERE
        (YEAR(review_creation_date) = 2017 OR YEAR(review_creation_date) = 2018)
        AND (MONTH(review_creation_date) >= 1 AND MONTH(review_creation_date) <= 8)
GROUP BY 
YEAR(review_creation_date) , 
MONTH(review_creation_date)
ORDER BY 
YEAR , MONTH 

-- -- Assessing Average Review Scores Across Different Product Categories
SELECT 
  opc.product_category_name_english AS product_category, 
  ROUND(AVG(ord.review_score), 2) AS Avgreview
FROM EcommerceOlist.dbo.olist_order_reviews_dataset$ AS ord
JOIN EcommerceOlist.dbo.olist_orders_dataset$ AS od ON ord.order_id = od.order_id 
JOIN EcommerceOlist.dbo.olist_order_items_dataset$ AS oi ON oi.order_id = od.order_id
JOIN EcommerceOlist.dbo.olist_products_dataset$ AS opd ON opd.product_id = oi.product_id 
JOIN EcommerceOlist.dbo.product_category_name_translati$ AS opc ON opc.product_category_name = opd.product_category_name
GROUP BY 
  opc.product_category_name_english
  ORDER BY Avgreview DESC


-- Order Reviews and Comments Analysis
SELECT
  COUNT(DISTINCT ord.order_id) AS total_orders,
  COUNT(DISTINCT ord.review_id) AS total_reviews,
  COUNT(DISTINCT ord.review_comment_message) AS total_comments,
  ROUND(COUNT(DISTINCT ord.review_id) * 100 / COUNT(DISTINCT ord.order_id), 2) AS reviews_per_order,
  ROUND(COUNT(DISTINCT ord.review_comment_message) * 100 / COUNT(DISTINCT ord.order_id), 2) AS comments_per_order
FROM
  EcommerceOlist.dbo.olist_order_reviews_dataset$ AS ord;

  -- Positive vs Negative Review Analysis
SELECT
  CASE 
    WHEN review_score BETWEEN 1 AND 3 THEN 'Negative'
    WHEN review_score BETWEEN 4 AND 5 THEN 'Positive'
  END AS ReviewCategory,
  COUNT(*) AS ReviewCount,
  CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5, 2)) AS Percentage
FROM EcommerceOlist.dbo.olist_order_reviews_dataset$
GROUP BY
  CASE 
    WHEN review_score BETWEEN 1 AND 3 THEN 'Negative'
    WHEN review_score BETWEEN 4 AND 5 THEN 'Positive'
  END
ORDER BY ReviewCategory DESC;



