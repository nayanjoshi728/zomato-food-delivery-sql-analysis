use zomato_project;


-- Q1. Top 5 Most Frequently Ordered Dishes by a Specific Customer
-- Find the top 5 dishes most ordered by customer "Arjun Gupta" in the last 1 year.

SELECT * FROM
(SELECT 
    c.customer_id,
    c.customer_name,
    o.order_item AS dishes,
    COUNT(*) AS total_orders,
    dense_rank () over (order by count(*) desc) as rnk
FROM 
    orders AS o
JOIN 
    customers AS c 
    ON c.customer_id = o.customer_id 
WHERE 
	o.order_date >= CURRENT_DATE - INTERVAL 1 YEAR 
    and
    c.customer_name ="Arjun Gupta"
GROUP BY 
    c.customer_id, 
    c.customer_name, 
    o.order_item
order by C.customer_id, count(*) desc) as t1
 where rnk  <=5;
 

-- Q2. Popular Time Slots
-- Identify the time slots during which the most orders are placed, based on 2-hour intervals.

-- Apporach 1
SELECT 
	CASE 
		WHEN hour(order_time) BETWEEN 0 AND 1 THEN  '00.00 -02.00'
		WHEN hour(order_time) BETWEEN 2 AND 3 THEN  '02.00-04.00'
		WHEN hour(order_time) BETWEEN 4 AND 5 THEN  '04.00-6.00'
		WHEN hour(order_time) BETWEEN 6 AND 7 THEN  '06.00-08.00'
		WHEN hour(order_time) BETWEEN 8 AND 9 THEN  '08,00-10.00'
		WHEN hour(order_time) BETWEEN 10 AND 11 THEN  '10.00-12.00'
		WHEN hour(order_time) BETWEEN 12 AND 13 THEN '12.00-14.00'
		WHEN hour(order_time) BETWEEN 14 AND 15 THEN '14.00-16.00'
		WHEN hour(order_time) BETWEEN 16 AND 17 THEN '16.00-18.00'
		WHEN hour(order_time) BETWEEN 18 AND 19 THEN '18.00-20.00'
		WHEN hour(order_time) BETWEEN 20 AND 21 THEN '20.00-22.00'
		WHEN hour(order_time) BETWEEN 22 AND 23 THEN '22.00-00.00'
	END as time_slot,
    count(order_id) as order_count
FROM orders
group by time_slot
order by order_count desc;
		
        
-- apporach 2
select 
	floor(extract(hour from order_time)/2)*2 as start_time,
   	floor(extract(hour from order_time)/2)*2 + 2 as end_time,
    count(*) as total_orders
from orders
group by  start_time,end_time
order by total_orders desc;


-- Q3. Order Value Analysis
-- Find the average order value (AOV) per customer who has placed more than 25 orders.

select 
	c.customer_name,
    avg(o.total_amount) as aov
from orders o
	 join customers c
     on c.customer_id =o.customer_id
group by c.customer_name
having count(order_id) >25;

-- Q4. High-Value Customers
-- List customers who have spent more than ₹10,000 in total.

select 
	c.customer_name,
    sum(total_amount) as total_spent
from orders o
	 join customers c
     on c.customer_id =o.customer_id
group by c.customer_name
having sum(total_amount) > 10000;

-- Q5. Orders Without Delivery
-- Find orders that were placed but never delivered.
-- Return restaurant name, city, and count of undelivered orders.

SELECT 
    r.restaurant_name,
    COUNT(o.order_id) AS cnt_not_deliverd_orders
FROM
    orders AS o
        LEFT JOIN
    restaurants AS r ON r.restaurant_id = o.restaurant_id
        LEFT JOIN
    deliveries AS d ON d.order_id = o.order_id
WHERE
    d.delivery_id IS NULL
GROUP BY r.restaurant_name
ORDER BY COUNT(o.order_id) DESC;

-- Q6. Restaurant Revenue Ranking
-- Rank restaurants by total revenue from the last year, showing only the top-ranked restaurant per city.

WITH ranking_table AS (
    SELECT
        r.city,
        r.restaurant_name,
        SUM(o.total_amount) AS revenue,
        RANK() OVER (PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) AS rnk
    FROM orders AS o
    JOIN restaurants AS r ON r.restaurant_id = o.restaurant_id
    WHERE o.order_date >= CURRENT_DATE - INTERVAL 1 YEAR
    GROUP BY r.city, r.restaurant_name
)
SELECT * 
FROM ranking_table
WHERE rnk = 1;

-- Q7. Most Popular Dish by City
-- Identify the most ordered dish in each city.

SELECT * 
FROM
(SELECT
	r.city,
    o.order_item AS Dish,
    COUNT(order_id) AS total_orders,
    RANK()OVER(PARTITION BY r.city ORDER BY COUNT(order_id) DESC) as rnk
FROM orders as o
JOIN
restaurants AS r
ON r.restaurant_id = o.restaurant_id
 GROUP BY r.city,o.order_item
 ) as t1
 WHERE rnk = 1;
 
--  Q 8 Customer Churn:
--  find customers  who haven't  an order in 2025 but did in 2024
  
--  find cx who has done orders in 2024
--  find cx who has not done orders in 2025
--  compare 1 and 2

SELECT DISTINCT o.customer_id , c.customer_name
FROM orders as o
join customers as c ON c.customer_id = o.customer_id
WHERE YEAR(order_date) = 2024
AND c.customer_id NOT IN (
    SELECT DISTINCT customer_id 
    FROM orders
    WHERE YEAR(order_date) = 2025
);


-- Q9. Cancellation Rate Comparison (2024 vs 2025)
-- Compare the order cancellation rate per restaurant
-- between 2024 and 2025.

WITH  cancel_ratio_24
AS
(
SELECT  
	o.restaurant_id,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS not_delivered
FROM orders AS o
LEFT JOIN
deliveries AS d ON o.order_id = d.order_id
WHERE YEAR(order_date) = 2024
GROUP BY o.restaurant_id
),
cancel_ratio_25
AS
(
SELECT  
	o.restaurant_id,
    COUNT(o.order_id) AS total_orders,
    COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS not_delivered
FROM orders AS o
LEFT JOIN
deliveries AS d ON o.order_id = d.order_id
WHERE YEAR(order_date) = 2025
GROUP BY o.restaurant_id
),
last_year_data
as
(
 SELECT 
	restaurant_id,
    total_orders,
    not_delivered,
    ROUND(
			(not_delivered * 100.0) / total_orders, 
            2) AS cancel_ratio
FROM cancel_ratio_24
),
current_year_data
as
(
 SELECT 
	restaurant_id,
    total_orders,
    not_delivered,
    ROUND(
			(not_delivered * 100.0) / total_orders, 
            2) AS cancel_ratio
FROM cancel_ratio_25
)
SELECT 
	current_year_data.restaurant_id AS rest_id,
	current_year_data.cancel_ratio as cs_ratio,
    last_year_data.cancel_ratio as ls_ratio
FROM current_year_data
JOIN
last_year_data ON 	current_year_data.restaurant_id =last_year_data.restaurant_id;


-- Q10. Rider Average Delivery Time
-- Determine each rider's average delivery time in minutes, accounting for overnight deliveries.
SELECT 
    o.order_id, 
    o.order_time, 
    d.delivery_time, 
    d.rider_id,
    -- Difference in minutes 
    TIMESTAMPDIFF(MINUTE, o.order_time, d.delivery_time) AS time_difference,
    -- Difference with 1-day adjustment if delivery_time < order_time
    CASE 
        WHEN d.delivery_time < o.order_time 
        THEN TIMESTAMPDIFF(MINUTE, o.order_time, d.delivery_time + INTERVAL 1 DAY)
        ELSE TIMESTAMPDIFF(MINUTE, o.order_time, d.delivery_time)
    END AS time_difference_adjusted
FROM orders AS o 
JOIN deliveries AS d ON o.order_id = d.order_id 
WHERE d.delivery_status = 'Delivered'; 


-- Q11. Monthly Restaurant Growth Ratio
-- Calculate each restaurant's month-over-month growth ratio based on delivered orders.

WITH growth_ratio AS (
    SELECT 
        o.restaurant_id,
        -- Use DATE_FORMAT for MySQL; sorting by YYYY-MM ensures chronological order
        DATE_FORMAT(o.order_time, '%Y-%m') AS month,
        COUNT(o.order_id) AS cr_month_orders,
		COALESCE(LAG(COUNT(o.order_id), 1) OVER(PARTITION BY o.restaurant_id ORDER BY DATE_FORMAT(o.order_time, '%Y-%m')), 0)
        AS prev_month_orders
	FROM orders AS o
    JOIN deliveries AS d ON o.order_id = d.order_id
    WHERE d.delivery_status = 'Delivered'
    GROUP BY o.restaurant_id, month
)
SELECT
    restaurant_id,
    month,
    prev_month_orders,
    cr_month_orders,
    -- Use NULLIF to prevent division by zero; no ::numeric needed in MySQL for this math
   ROUND(
    (cr_month_orders - prev_month_orders) / NULLIF(prev_month_orders, 0) * 100, 
    2
) AS growth_ratio

FROM growth_ratio;


-- Q12. Customer Segmentation — Gold vs Silver
-- Classify customers as 'Gold' or 'Silver' based on whether
-- their order value exceeds the platform's average order value.
-- Return total customers, orders, and revenue per segment.


SELECT 
    segment,
    COUNT(customer_id) AS total_customers,
    COUNT(order_id) AS total_orders,
   ROUND( SUM(customer_revenue)) AS total_revenue
FROM (
    SELECT 
        customer_id,
        order_id,
        total_amount AS customer_revenue,
        CASE 
            WHEN total_amount > (SELECT AVG(total_amount) FROM orders) THEN 'Gold'
            ELSE 'Silver'
        END AS segment
    FROM orders
) AS subquery
GROUP BY Segment;

-- Q13. Rider Monthly Earnings
-- Calculate each rider's total monthly earnings, assuming they earn 8% of the total order value delivered.

SELECT 
	d.rider_id,
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
	ROUND(SUM(total_amount) *0.08) as total_revenue
FROM orders as o
JOIN deliveries as d
ON o.order_id =d.order_id
GROUP BY 1,2
ORDER BY 1,2,3 DESC;


-- Q 14 Rider Ratings Analysis: -- 
--  find the number of 5-star,4-star and 3-star ratings each riders has
--  riders receive this rating based on delivery time
--  if orders are delivered less than  15 minutes of order received time the rider get 5 star rating
--  if they deliver 15 and 20 minute they get 4 star star rating
--   if they deliver  after 20 minute they get 3 star star rating
--  

SELECT 
    d.rider_id,
    SUM(CASE WHEN TIMESTAMPDIFF(MINUTE, o.order_time, d.delivery_time) < 15 THEN 1 ELSE 0 END) AS five_star_ratings,
    SUM(CASE WHEN TIMESTAMPDIFF(MINUTE, o.order_time, d.delivery_time) BETWEEN 15 AND 20 THEN 1 ELSE 0 END) AS four_star_ratings,
    SUM(CASE WHEN TIMESTAMPDIFF(MINUTE, o.order_time, d.delivery_time) > 20 THEN 1 ELSE 0 END) AS three_star_ratings
FROM orders AS o
JOIN deliveries AS d ON o.order_id = d.order_id
where delivery_status ="delivered"
GROUP BY d.rider_id
Order BY d.rider_id;


-- Q15. Order Frequency by Day of Week
-- Analyze order frequency per day of the week and identify the peak day for each restaurant.

WITH daily_counts AS (
    SELECT 
        restaurant_id, 
        DAYNAME(order_date) AS day_of_week, 
        COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY 1, 2
),
ranked_days AS (
    SELECT 
        restaurant_id, 
        day_of_week, 
        total_orders,
        RANK() OVER (PARTITION BY restaurant_id ORDER BY total_orders DESC) as peak_rank
    FROM daily_counts
)
SELECT 
    restaurant_id, 
    day_of_week AS peak_day, 
    total_orders AS peak_volume
FROM ranked_days
WHERE peak_rank = 1;

-- Q16. Customer Lifetime Value (CLV)
-- Calculate the total revenue generated by each customer across all their orders.

select 
	c.customer_id,
    c.customer_name,
    ROUND(SUM(o.total_amount),2)as CLV
FROM orders AS o
join customers AS c
ON o.customer_id =c.customer_id
GROUP BY 1,2;
    

-- Q 17 Monthly Sales Trends:
-- Identify sales treads by comparing  each month's total sales to prevoius month.
SELECT 
		YEAR(order_date) AS Year,
        MONTH(order_date) AS Month,
        ROUND(SUM(total_amount),2) AS Total_sale,
        LAG(ROUND(SUM(total_amount),2),1) OVER( ORDER BY YEAR(order_date),MONTH(order_date) ) AS prev_month 
FROM orders
GROUP BY 1,2 
ORDER BY 1,2;

-- Q 18 Rider Efficiency:
-- Evalaute rider efficiency by  determining average delivery times and identtifying  those with  the lowest and heighest Averages.

WITH RiderPerformance AS (
    SELECT 
        d.rider_id,
        COUNT(d.order_id) AS total_deliveries,
        AVG(TIMESTAMPDIFF(MINUTE, o.order_time, d.delivery_time)) AS avg_delivery_time
    FROM deliveries d
    JOIN orders o ON d.order_id = o.order_id
    WHERE d.delivery_status = 'Delivered'
    GROUP BY d.rider_id
),
RankedRiders AS (
    SELECT 
        rider_id,
        avg_delivery_time,
        total_deliveries,
        RANK() OVER (ORDER BY avg_delivery_time ASC) AS fast_rank,
        RANK() OVER (ORDER BY avg_delivery_time DESC) AS slow_rank
    FROM RiderPerformance
)
SELECT 
    rider_id,
    ROUND(avg_delivery_time, 2) AS avg_delivery_time_minutes,
    total_deliveries,
    CASE 
        WHEN fast_rank = 1 THEN 'Highest Efficiency (Fastest)'
        WHEN slow_rank = 1 THEN 'Lowest Efficiency (Slowest)'
        ELSE 'Average Performance'
    END AS efficiency_tier
FROM RankedRiders
ORDER BY avg_delivery_time ASC;


-- Q 19 Order Item Popularity:
-- Track the popularity of specific order items over time and identfiy seasonal demad spikes


SELECT 
    order_item,
	CASE
        WHEN MONTH(order_date) IN (3,4,5,6) THEN 'Summer'
        WHEN MONTH(order_date) IN (7,8,9,10) THEN 'Monsoon'
        WHEN MONTH(order_date) IN (11,12,1,2) THEN 'Winter'
    END AS season,
	COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount),2) AS total_sales
FROM orders
GROUP BY order_item, season
ORDER BY order_item, total_orders DESC;



--  Q 20 Rank  each city based on the total revenue  for last year 2025 
SELECT 
	r.city,
    SUM(total_amount) AS totl_revenue,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS city_rank
FROM orders AS o
JOIN
restaurants as r
ON o.restaurant_id = r.restaurant_id
GROUP BY 1;