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
