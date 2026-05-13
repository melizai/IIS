SELECT * FROM menu_items_view;
SELECT * FROM employees_view;
SELECT * FROM orders_view;
SELECT * FROM order_items_view;
SELECT * FROM payments_view;
SELECT * FROM reviews_view;

-- DROP VIEW IF EXISTS OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY;
CREATE OR REPLACE VIEW OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY AS
SELECT
 CASE
   WHEN GROUPING(to_date(o.orderTs)) = 1 THEN '{ALL DAYS}'
   ELSE date_format(to_date(o.orderTs), 'yyyy-MM-dd')
 END AS order_day,
 CASE
   WHEN GROUPING(o.channel) = 1 THEN '{ALL CHANNELS}'
   ELSE o.channel
 END AS channel,
 CASE
   WHEN GROUPING(m.category) = 1 THEN '{ALL CATEGORIES}'
   ELSE m.category
 END AS category,
 SUM(COALESCE(oi.lineTotal, 0)) AS sales_amount,
 SUM(COALESCE(oi.quantity, 0))  AS total_quantity
FROM orders_view o
INNER JOIN order_items_view oi
   ON o.orderId = oi.orderId
INNER JOIN menu_items_view m
   ON oi.menuItemId = m.menuItemId
GROUP BY GROUPING SETS (
   (to_date(o.orderTs), o.channel, m.category),
   (to_date(o.orderTs), o.channel),
   (o.channel, m.category),
   (to_date(o.orderTs)),
   (o.channel),
   (m.category),
   ()
);

SELECT * FROM OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY
ORDER BY order_day, channel, category;

-- DROP VIEW IF EXISTS OLAP_VIEW_REVIEWS_TREND;
CREATE OR REPLACE VIEW OLAP_VIEW_REVIEWS_TREND AS
SELECT
   m.name AS product_name,
   m.category,
   r.rating,
   r.comment,
   ROW_NUMBER() OVER (
       PARTITION BY m.name
       ORDER BY r.orderId
   ) AS review_chronological_order,
   ROUND(
       AVG(r.rating) OVER (
           PARTITION BY m.name
           ORDER BY r.orderId
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ),
       2
   ) AS running_average_rating
FROM reviews_view r
INNER JOIN menu_items_view m
   ON r.menuItemId = m.menuItemId;

SELECT *
FROM OLAP_VIEW_REVIEWS_TREND
ORDER BY product_name, review_chronological_order;

-- DROP VIEW IF EXISTS OLAP_VIEW_REVIEWS_CHANNEL_RATING;
CREATE OR REPLACE VIEW OLAP_VIEW_REVIEWS_CHANNEL_RATING AS
SELECT
 CASE
   WHEN GROUPING(o.channel) = 1 THEN '{Total General}'
   ELSE o.channel
 END AS channel,
 CASE
   WHEN GROUPING(o.channel) = 1
        AND GROUPING(r.rating) = 0
     THEN CAST(r.rating AS STRING)
   WHEN GROUPING(r.rating) = 1
        AND GROUPING(o.channel) = 0
     THEN concat('subtotal channel ', o.channel)
   WHEN GROUPING(o.channel) = 1
        AND GROUPING(r.rating) = 1
     THEN ' '
   ELSE CAST(r.rating AS STRING)
 END AS rating,
 COUNT(*) AS review_count,
 CASE
   WHEN GROUPING(r.rating) = 1
     THEN ROUND(AVG(r.rating), 2)
   ELSE NULL
 END AS avg_rating
FROM reviews_view r
INNER JOIN orders_view o
   ON r.orderId = o.orderId
GROUP BY CUBE(o.channel, r.rating);

SELECT *
FROM OLAP_VIEW_REVIEWS_CHANNEL_RATING
ORDER BY channel, rating;


--- DROP VIEW IF EXISTS OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK;
CREATE OR REPLACE VIEW OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK AS
WITH sales_rows AS (
   SELECT
       to_date(o.orderTs) AS order_day,
       e.fullName,
       oi.lineTotal
   FROM orders_view o
   INNER JOIN order_items_view oi
       ON o.orderId = oi.orderId
   INNER JOIN employees_view e
       ON o.cashierId = e.employeeId
),
first_sales_day AS (
   SELECT MIN(order_day) AS first_day
   FROM sales_rows
),
employee_week_sales AS (
   SELECT
       CAST(
           FLOOR(datediff(s.order_day, f.first_day) / 7) + 1
           AS INT
       ) AS week_no,
       date_add(
           f.first_day,
           CAST(
               FLOOR(datediff(s.order_day, f.first_day) / 7) * 7
               AS INT
           )
       ) AS week_start,
       s.fullName,
       SUM(COALESCE(s.lineTotal, 0)) AS sales_amount
   FROM sales_rows s
   CROSS JOIN first_sales_day f
   GROUP BY
       CAST(
           FLOOR(datediff(s.order_day, f.first_day) / 7) + 1
           AS INT
       ),
       date_add(
           f.first_day,
           CAST(
               FLOOR(datediff(s.order_day, f.first_day) / 7) * 7
               AS INT
           )
       ),
       s.fullName
)
SELECT
   week_no,
   date_format(week_start, 'yyyy-MM-dd') AS week_start,
   date_format(
       date_add(week_start, 6),
       'yyyy-MM-dd'
   ) AS week_end,
   fullName,
   sales_amount,
   DENSE_RANK() OVER (
       PARTITION BY week_no
       ORDER BY sales_amount DESC
   ) AS rank_in_week
FROM employee_week_sales;

SELECT *
FROM OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK
ORDER BY week_no, rank_in_week, fullName;
