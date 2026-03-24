-- Populat

INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-1,'IN_STORE',1,45);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-2,'DELIVERY',2,52);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-3,'TAKEAWAY',1,30);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-4,'IN_STORE',3,61);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-5,'DELIVERY',2,38);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-6,'IN_STORE',4,47);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-7,'TAKEAWAY',5,22);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-8,'DELIVERY',1,34);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-9,'IN_STORE',2,29);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-10,'DELIVERY',3,44);

INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-11,'IN_STORE',4,56);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-12,'TAKEAWAY',2,18);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-13,'IN_STORE',3,65);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-14,'DELIVERY',4,39);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-15,'IN_STORE',5,42);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-16,'DELIVERY',2,31);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-17,'TAKEAWAY',1,27);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-18,'IN_STORE',3,33);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-19,'DELIVERY',4,48);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-20,'IN_STORE',5,54);

INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-21,'DELIVERY',1,40);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-22,'IN_STORE',2,36);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-23,'TAKEAWAY',3,23);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-24,'IN_STORE',4,58);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-25,'DELIVERY',5,41);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-26,'IN_STORE',1,32);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-27,'TAKEAWAY',2,19);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-28,'IN_STORE',3,60);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-29,'DELIVERY',4,45);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-30,'IN_STORE',5,37);

INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-31,'DELIVERY',1,46);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-32,'IN_STORE',2,28);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-33,'TAKEAWAY',3,21);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-34,'IN_STORE',4,57);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-35,'DELIVERY',5,49);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-36,'IN_STORE',1,34);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-37,'TAKEAWAY',2,26);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-38,'IN_STORE',3,55);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-39,'DELIVERY',4,43);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-40,'IN_STORE',5,39);

INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-41,'DELIVERY',1,50);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-42,'IN_STORE',2,35);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-43,'TAKEAWAY',3,24);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-44,'IN_STORE',4,59);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-45,'DELIVERY',5,47);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-46,'IN_STORE',1,33);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-47,'TAKEAWAY',2,20);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-48,'IN_STORE',3,63);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-49,'DELIVERY',4,44);
INSERT INTO sales.orders (order_ts, channel, cashier_id, total_amount) VALUES (SYSTIMESTAMP-50,'IN_STORE',5,52);

COMMIT;

SELECT * FROM sales.orders;


INSERT INTO sales.order_items (order_id,menu_item_id,quantity,unit_price,line_total) VALUES (1,1,1,30,30);
INSERT INTO sales.order_items VALUES (DEFAULT,2,5,1,22,22);
INSERT INTO sales.order_items VALUES (DEFAULT,3,15,1,28,28);
INSERT INTO sales.order_items VALUES (DEFAULT,4,9,2,10,20);
INSERT INTO sales.order_items VALUES (DEFAULT,5,7,1,24,24);
INSERT INTO sales.order_items VALUES (DEFAULT,6,20,1,20,20);
INSERT INTO sales.order_items VALUES (DEFAULT,7,11,1,12,12);
INSERT INTO sales.order_items VALUES (DEFAULT,8,6,1,28,28);
INSERT INTO sales.order_items VALUES (DEFAULT,9,18,1,22,22);
INSERT INTO sales.order_items VALUES (DEFAULT,10,4,1,40,40);
INSERT INTO sales.order_items VALUES (DEFAULT,11,14,1,18,18);
INSERT INTO sales.order_items VALUES (DEFAULT,12,16,1,27,27);
INSERT INTO sales.order_items VALUES (DEFAULT,13,17,1,29,29);
INSERT INTO sales.order_items VALUES (DEFAULT,14,8,1,21,21);
INSERT INTO sales.order_items VALUES (DEFAULT,15,13,1,18,18);
INSERT INTO sales.order_items VALUES (DEFAULT,16,10,1,15,15);
INSERT INTO sales.order_items VALUES (DEFAULT,17,12,1,16,16);
INSERT INTO sales.order_items VALUES (DEFAULT,18,19,1,23,23);
INSERT INTO sales.order_items VALUES (DEFAULT,19,3,1,38,38);
INSERT INTO sales.order_items VALUES (DEFAULT,20,2,1,35,35);
INSERT INTO sales.order_items VALUES (DEFAULT,21,5,1,22,22);
INSERT INTO sales.order_items VALUES (DEFAULT,22,7,1,24,24);
INSERT INTO sales.order_items VALUES (DEFAULT,23,1,1,30,30);
INSERT INTO sales.order_items VALUES (DEFAULT,24,6,1,28,28);
INSERT INTO sales.order_items VALUES (DEFAULT,25,4,1,40,40);

COMMIT;

SELECT * FROM sales.order_items;


INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (1, SYSTIMESTAMP-1, 'CARD', 45);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (2, SYSTIMESTAMP-2, 'ONLINE', 52);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (3, SYSTIMESTAMP-3, 'CASH', 30);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (4, SYSTIMESTAMP-4, 'CARD', 61);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (5, SYSTIMESTAMP-5, 'ONLINE', 38);

INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (6, SYSTIMESTAMP-6, 'CARD', 47);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (7, SYSTIMESTAMP-7, 'CASH', 22);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (8, SYSTIMESTAMP-8, 'ONLINE', 34);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (9, SYSTIMESTAMP-9, 'CARD', 29);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (10, SYSTIMESTAMP-10, 'ONLINE', 44);

INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (11, SYSTIMESTAMP-11, 'CARD', 56);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (12, SYSTIMESTAMP-12, 'CASH', 18);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (13, SYSTIMESTAMP-13, 'CARD', 65);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (14, SYSTIMESTAMP-14, 'ONLINE', 39);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (15, SYSTIMESTAMP-15, 'CARD', 42);

INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (16, SYSTIMESTAMP-16, 'ONLINE', 31);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (17, SYSTIMESTAMP-17, 'CASH', 27);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (18, SYSTIMESTAMP-18, 'CARD', 33);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (19, SYSTIMESTAMP-19, 'ONLINE', 48);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (20, SYSTIMESTAMP-20, 'CARD', 54);

INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (21, SYSTIMESTAMP-21, 'ONLINE', 40);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (22, SYSTIMESTAMP-22, 'CARD', 36);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (23, SYSTIMESTAMP-23, 'CASH', 23);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (24, SYSTIMESTAMP-24, 'CARD', 58);
INSERT INTO sales.payments (order_id, payment_ts, method, amount) VALUES (25, SYSTIMESTAMP-25, 'ONLINE', 41);

COMMIT;

SELECT * FROM sales.payments;

--modif

UPDATE sales.orders
SET cashier_id = 6
WHERE cashier_id IN (3,5);

UPDATE sales.orders
SET cashier_id = 10
WHERE cashier_id = 4;

