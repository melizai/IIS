----------------------------------------------------------------------------------
--- DS2_ORACLE_SparkSQL_Views.sql
--- Oracle JPA REST source: orders, order_items, payments
----------------------------------------------------------------------------------

SELECT java_method(
    'org.spark.service.rest.QueryRESTDataService',
    'getRESTDataDocument',
    'http://localhost:8091/DSA_SQL_JPAService/rest/sales/OrderView'
);

SELECT java_method(
    'org.spark.service.rest.QueryRESTDataService',
    'getRESTDataDocument',
    'http://localhost:8091/DSA_SQL_JPAService/rest/sales/OrderItemView'
);

SELECT java_method(
    'org.spark.service.rest.QueryRESTDataService',
    'getRESTDataDocument',
    'http://localhost:8091/DSA_SQL_JPAService/rest/sales/PaymentView'
);

----------------------------------------------------------------------------------
-- ORDERS
----------------------------------------------------------------------------------
SELECT java_method(
    'org.spark.service.rest.RESTEnabledSQLService',
    'createJSONViewFromREST',
    'ORDERS_JSON_VIEW',
    'http://localhost:8091/DSA_SQL_JPAService/rest/sales/OrderView'
);

SELECT * FROM ORDERS_JSON_VIEW;

CREATE OR REPLACE VIEW orders_view AS
SELECT
    v.orderId,
    v.orderTs,
    v.channel,
    v.cashierId,
    v.totalAmount
FROM ORDERS_JSON_VIEW json_view
LATERAL VIEW explode(json_view.array) AS v;

SELECT * FROM orders_view;

----------------------------------------------------------------------------------
-- ORDER ITEMS
----------------------------------------------------------------------------------
SELECT java_method(
    'org.spark.service.rest.RESTEnabledSQLService',
    'createJSONViewFromREST',
    'ORDER_ITEMS_JSON_VIEW',
    'http://localhost:8091/DSA_SQL_JPAService/rest/sales/OrderItemView'
);

SELECT * FROM ORDER_ITEMS_JSON_VIEW;

CREATE OR REPLACE VIEW order_items_view AS
SELECT
    v.orderItemId,
    v.orderId,
    v.menuItemId,
    v.quantity,
    v.unitPrice,
    v.lineTotal
FROM ORDER_ITEMS_JSON_VIEW json_view
LATERAL VIEW explode(json_view.array) AS v;

SELECT * FROM order_items_view;

----------------------------------------------------------------------------------
-- PAYMENTS
----------------------------------------------------------------------------------
SELECT java_method(
    'org.spark.service.rest.RESTEnabledSQLService',
    'createJSONViewFromREST',
    'PAYMENTS_JSON_VIEW',
    'http://localhost:8091/DSA_SQL_JPAService/rest/sales/PaymentView'
);

SELECT * FROM PAYMENTS_JSON_VIEW;

CREATE OR REPLACE VIEW payments_view AS
SELECT
    v.paymentId,
    v.orderId,
    v.paymentTs,
    v.method,
    v.amount
FROM PAYMENTS_JSON_VIEW json_view
LATERAL VIEW explode(json_view.array) AS v;

SELECT * FROM payments_view;

