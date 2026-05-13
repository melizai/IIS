--------------------------------------------------------------------------------
--- PostgreSQL Views: menu_items + employees
--------------------------------------------------------------------------------

SELECT java_method(
               'org.spark.service.rest.QueryRESTDataService',
               'getRESTDataDocument',
               'http://localhost:8090/DSA-SQL-JDBCService/rest/restaurant/MenuItemView');

SELECT java_method(
               'org.spark.service.rest.QueryRESTDataService',
               'getRESTDataDocument',
               'http://localhost:8090/DSA-SQL-JDBCService/rest/restaurant/EmployeeView');

--------------------------------------------------------------------------------
--- MENU ITEMS VIEW
--------------------------------------------------------------------------------

SELECT * FROM MENU_ITEMS_JSON_VIEW;

-- DROP VIEW menu_items_view;

CREATE OR REPLACE VIEW menu_items_view AS
SELECT
    v.menuItemId,
    v.name,
    v.category,
    v.price,
    v.isActive
FROM MENU_ITEMS_JSON_VIEW AS json_view
LATERAL VIEW explode(json_view.array) AS v;

SELECT * FROM menu_items_view;

--------------------------------------------------------------------------------
--- EMPLOYEES VIEW
--------------------------------------------------------------------------------

SELECT * FROM EMPLOYEES_JSON_VIEW;

-- DROP VIEW employees_view;

CREATE OR REPLACE VIEW employees_view AS
SELECT
    v.employeeId,
    v.fullName,
    v.role,
    v.hireDate,
    v.isActive
FROM EMPLOYEES_JSON_VIEW AS json_view
LATERAL VIEW explode(json_view.array) AS v;

SELECT * FROM employees_view;
