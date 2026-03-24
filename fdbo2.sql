--postgrest

SELECT HTTPURITYPE.createuri('http://host.docker.internal:3000/employees')
.getclob() AS doc
FROM dual;

--Employees view

CREATE OR REPLACE VIEW employees_view AS
WITH rest_doc AS
(
    SELECT HTTPURITYPE.createuri('http://host.docker.internal:3000/employees')
    .getclob() AS doc
    FROM dual
)
SELECT *
FROM JSON_TABLE(
    (SELECT doc FROM rest_doc),
    '$[*]'
    COLUMNS (
        employee_id NUMBER PATH '$.employee_id',
        full_name VARCHAR2(120) PATH '$.full_name',
        role VARCHAR2(40) PATH '$.role',
        hire_date VARCHAR2(40) PATH '$.hire_date',
        is_active VARCHAR2(10) PATH '$.is_active'
    )
);

--test:

SELECT * FROM employees_view;


--menu items view
CREATE OR REPLACE VIEW menu_items_view AS
WITH rest_doc AS
(
    SELECT HTTPURITYPE.createuri('http://host.docker.internal:3000/menu_items')
    .getclob() AS doc
    FROM dual
)
SELECT *
FROM JSON_TABLE(
    (SELECT doc FROM rest_doc),
    '$[*]'
    COLUMNS (
        menu_item_id NUMBER PATH '$.menu_item_id',
        name VARCHAR2(120) PATH '$.name',
        category VARCHAR2(60) PATH '$.category',
        price NUMBER PATH '$.price',
        is_active VARCHAR2(10) PATH '$.is_active'
    )
);


--test:
SELECT * FROM menu_items_view;



