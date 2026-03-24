--------------------------------------------------------------------------------
-- CONNECT with FDBO on XEPDB1
--------------------------------------------------------------------------------

ROLLBACK;
ALTER SESSION CLOSE DATABASE LINK salesDB;

DROP DATABASE LINK salesDB;

CREATE DATABASE LINK salesDB
   CONNECT TO sales IDENTIFIED BY sales
   USING '//localhost:1521/XEPDB1';

SELECT * FROM user_db_links;


SELECT * FROM user_tables@salesDB;

SELECT * FROM orders@salesDB; 


DROP VIEW ORDERS_VIEW;

CREATE OR REPLACE VIEW ORDERS_VIEW AS
SELECT
    order_id,
    order_ts,
    channel,
    cashier_id,
    total_amount
FROM orders@salesDB;

SELECT * FROM ORDERS_VIEW;

--------------------------------------------------------------------------------

DROP VIEW ORDER_ITEMS_VIEW;

CREATE OR REPLACE VIEW ORDER_ITEMS_VIEW AS
SELECT
    order_item_id,
    order_id,
    menu_item_id,
    quantity,
    unit_price,
    line_total
FROM order_items@salesDB;

SELECT * FROM ORDER_ITEMS_VIEW;

--------------------------------------------------------------------------------

DROP VIEW PAYMENTS_VIEW;

CREATE OR REPLACE VIEW PAYMENTS_VIEW AS
SELECT
    payment_id,
    order_id,
    payment_ts,
    method,
    amount
FROM payments@salesDB;

SELECT * FROM PAYMENTS_VIEW;

--------------------------------------------------------------------------------
-- Aggregated order view
--------------------------------------------------------------------------------

DROP VIEW ORDERS_AGG_VIEW;

CREATE OR REPLACE VIEW ORDERS_AGG_VIEW AS
 SELECT
    o.order_id,
    o.order_ts,
    o.channel,
    o.cashier_id,
    o.total_amount,

    oi.order_item_id,
    oi.menu_item_id,
    oi.quantity,
    oi.unit_price,
    oi.line_total,

    p.payment_id,
    p.payment_ts,
    p.method,
    p.amount

 FROM orders@salesDB o
 INNER JOIN order_items@salesDB oi
    ON o.order_id = oi.order_id
 LEFT JOIN payments@salesDB p
    ON o.order_id = p.order_id;

SELECT * FROM ORDERS_AGG_VIEW;

--------------------------------------------------------------------------------
-- Distinct cashier view
--------------------------------------------------------------------------------

DROP VIEW CASHIERS_VIEW;

CREATE OR REPLACE VIEW CASHIERS_VIEW AS
SELECT DISTINCT cashier_id
FROM orders@salesDB
WHERE cashier_id IS NOT NULL;

SELECT * FROM CASHIERS_VIEW;

