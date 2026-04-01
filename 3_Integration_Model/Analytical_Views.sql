----------------------------------------------
--view 1 OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY
----------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;

CREATE OR REPLACE VIEW OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY AS
SELECT
  CASE
    WHEN GROUPING(TRUNC(CAST(o.order_ts AS DATE))) = 1 THEN '{ALL DAYS}'
    ELSE TO_CHAR(TRUNC(CAST(o.order_ts AS DATE)), 'YYYY-MM-DD')
  END AS order_day,
  CASE
    WHEN GROUPING(o.channel) = 1 THEN '{ALL CHANNELS}'
    ELSE o.channel
  END AS channel,
  CASE
    WHEN GROUPING(m.category) = 1 THEN '{ALL CATEGORIES}'
    ELSE m.category
  END AS category,
  SUM(NVL(oi.line_total, 0)) AS sales_amount,
  SUM(NVL(oi.quantity, 0))   AS total_quantity
FROM ORDERS_VIEW o
     INNER JOIN ORDER_ITEMS_VIEW oi
        ON o.order_id = oi.order_id
     INNER JOIN MENU_ITEMS_VIEW m
        ON oi.menu_item_id = m.menu_item_id
GROUP BY GROUPING SETS (
    (TRUNC(CAST(o.order_ts AS DATE)), o.channel, m.category),
    (TRUNC(CAST(o.order_ts AS DATE)), o.channel),
    (o.channel, m.category),
    (TRUNC(CAST(o.order_ts AS DATE))),
    (o.channel),
    (m.category),
    ()
)
ORDER BY 1, 2, 3;

--test

SELECT * FROM OLAP_VIEW_SALES_DAY_CHANNEL_CATEGORY;


----------------------------------------------
--view 2 OLAP_VIEW_REVIEWS_TREND
----------------------------------------------
BEGIN
 EXECUTE IMMEDIATE 'DROP VIEW OLAP_VIEW_REVIEWS_TREND';
EXCEPTION
 WHEN OTHERS THEN NULL;
END;


CREATE OR REPLACE VIEW OLAP_VIEW_REVIEWS_TREND AS
SELECT
   m.name AS product_name,
   m.category,
   r.rating,
   r.review_comment,
   r.createdAt,
  
   ROW_NUMBER() OVER (
       PARTITION BY m.name
       ORDER BY r.createdAt
   ) AS review_chronological_order,
  
   ROUND(
       AVG(r.rating) OVER (
           PARTITION BY m.name
           ORDER BY r.createdAt
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ), 2
   ) AS running_average_rating
FROM reviews_view_mongodb r
INNER JOIN menu_items_view m
   ON r.menuItemId = m.menu_item_id;

--test
SELECT * FROM OLAP_VIEW_REVIEWS_TREND
ORDER BY product_name, createdAt;


----------------------------------------------
--view 3 OLAP_VIEW_REVIEWS_CHANNEL_RATING
----------------------------------------------
BEGIN
 EXECUTE IMMEDIATE 'DROP VIEW OLAP_VIEW_REVIEWS_CHANNEL_RATING';
EXCEPTION
 WHEN OTHERS THEN NULL;
END;


CREATE OR REPLACE VIEW OLAP_VIEW_REVIEWS_CHANNEL_RATING AS
SELECT
 CASE
   WHEN GROUPING(o.channel) = 1 THEN '{Total General}'
   ELSE o.channel
 END AS channel,
 CASE
   WHEN GROUPING(o.channel) = 1 AND GROUPING(r.rating) = 0 THEN TO_CHAR(r.rating)
   WHEN GROUPING(r.rating) = 1 AND GROUPING(o.channel) = 0 THEN 'subtotal channel ' || o.channel
   WHEN GROUPING(o.channel) = 1 AND GROUPING(r.rating) = 1 THEN ' '
   ELSE TO_CHAR(r.rating)
 END AS rating,
 COUNT(*) AS review_count,
 CASE
   WHEN GROUPING(r.rating) = 1 THEN ROUND(AVG(r.rating), 2)
   ELSE NULL
 END AS avg_rating  
FROM REVIEWS_VIEW_MONGODB r
    INNER JOIN ORDERS_VIEW o
       ON r.orderId = o.order_id
GROUP BY CUBE(o.channel, r.rating)
ORDER BY o.channel, r.rating;

--test
SELECT * FROM OLAP_VIEW_REVIEWS_CHANNEL_RATING;


----------------------------------------------
--view 4 OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK
----------------------------------------------
BEGIN
  EXECUTE IMMEDIATE 'DROP VIEW OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;


CREATE OR REPLACE VIEW OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK AS
WITH sales_rows AS (
    SELECT
        TRUNC(CAST(o.order_ts AS DATE)) AS order_day,
        e.full_name,
        oi.line_total
    FROM ORDERS_VIEW o
         INNER JOIN ORDER_ITEMS_VIEW oi
            ON o.order_id = oi.order_id
         INNER JOIN EMPLOYEES_VIEW e
            ON o.cashier_id = e.employee_id
),
first_sales_day AS (
    SELECT MIN(order_day) AS first_day
    FROM sales_rows
),
employee_week_sales AS (
    SELECT
        FLOOR((s.order_day - f.first_day) / 7) + 1 AS week_no,
        f.first_day + FLOOR((s.order_day - f.first_day) / 7) * 7 AS week_start,
        s.full_name,
        SUM(NVL(s.line_total, 0)) AS sales_amount
    FROM sales_rows s
         CROSS JOIN first_sales_day f
    GROUP BY
        FLOOR((s.order_day - f.first_day) / 7) + 1,
        f.first_day + FLOOR((s.order_day - f.first_day) / 7) * 7,
        s.full_name
)
SELECT
    week_no,
    TO_CHAR(week_start, 'YYYY-MM-DD') AS week_start,
    TO_CHAR(week_start + 6, 'YYYY-MM-DD') AS week_end,
    full_name,
    sales_amount,
    DENSE_RANK() OVER (
        PARTITION BY week_no
        ORDER BY sales_amount DESC
    ) AS rank_in_week
FROM employee_week_sales;

--test
SELECT *
FROM OLAP_VIEW_EMPLOYEE_RANK_BY_WEEK
ORDER BY week_no, rank_in_week, full_name;
