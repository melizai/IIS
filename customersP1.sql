-- Connect with postgres ON postgres database
CREATE ROLE customers WITH
	LOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	CONNECTION LIMIT -1
	PASSWORD 'customers';
	
CREATE SCHEMA customers
    AUTHORIZATION customers;
	

----------------------------------------------------------------------

-- Create Tables

CREATE TABLE customers.menu_items (
  menu_item_id  BIGSERIAL PRIMARY KEY,
  name          VARCHAR(120) NOT NULL,
  category      VARCHAR(60)  NOT NULL,      
  price         NUMERIC(10,2) NOT NULL CHECK (price >= 0),
  is_active     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX idx_menu_category ON customers.menu_items(category);


CREATE TABLE customers.employees (
  employee_id   BIGSERIAL PRIMARY KEY,
  full_name     VARCHAR(120) NOT NULL,
  role          VARCHAR(40) NOT NULL,
  hire_date     DATE NOT NULL,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX idx_employees_role ON customers.employees(role);

-- Populat

INSERT INTO customers.menu_items (name, category, price) VALUES
('Margherita Pizza','pizza',30),
('Pepperoni Pizza','pizza',35),
('Quattro Formaggi','pizza',38),
('BBQ Chicken Pizza','pizza',40),
('Cheeseburger','burger',22),
('Double Burger','burger',28),
('Chicken Burger','burger',24),
('Veggie Burger','burger',21),
('Fries','sides',10),
('Loaded Fries','sides',15),
('Onion Rings','sides',12),
('Chicken Nuggets','sides',16),
('Caesar Salad','salad',18),
('Greek Salad','salad',18),
('Pasta Carbonara','pasta',28),
('Pasta Bolognese','pasta',27),
('Pasta Alfredo','pasta',29),
('Chicken Wrap','wrap',22),
('Beef Wrap','wrap',23),
('Falafel Wrap','wrap',20);


INSERT INTO customers.employees (full_name, role, hire_date) VALUES
('Andrei Ionescu','cashier','2023-02-10'),
('Maria Popa','cashier','2023-05-14'),
('Vlad Georgescu','cook','2022-11-03'),
('Ana Dumitru','manager','2021-07-19'),
('Cristian Pavel','cook','2024-01-10'),
('Ioana Matei','cashier','2024-02-01'),
('Mihai Stan','courier','2023-09-22'),
('Laura Marin','courier','2023-10-05'),
('Alex Dobre','cook','2024-03-11'),
('Diana Neagu','cashier','2024-04-12');

