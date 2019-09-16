show databases;
DROP DATABASE southwind;
CREATE DATABASE southwind;
use southwind;
select database();

CREATE TABLE IF NOT EXISTS products (
         productID    INT UNSIGNED  NOT NULL AUTO_INCREMENT,
         productCode  CHAR(3)       NOT NULL DEFAULT '',
         name         VARCHAR(30)   NOT NULL DEFAULT '',
         quantity     INT UNSIGNED  NOT NULL DEFAULT 0,
         price        DECIMAL(7,2)  NOT NULL DEFAULT 99999.99,
         PRIMARY KEY  (productID)
       );
       
show tables;
describe products;
show create table products;      

INSERT INTO products VALUES (1001, 'PEN', 'Pen Red', 5000, 1.23);
INSERT INTO products VALUES
         (NULL, 'PEN', 'Pen Blue',  8000, 1.25),
         (NULL, 'PEN', 'Pen Black', 2000, 1.25);
INSERT INTO products (productCode, name, quantity, price) VALUES
         ('PEC', 'Pencil 2B', 10000, 0.48),
         ('PEC', 'Pencil 2H', 8000, 0.49);

INSERT INTO products (productCode, name) VALUES ('PEC', 'Pencil HB');

SELECT * FROM products;
select count(*) from products;
delete from products where productID = 1006;

SELECT name, price FROM products;

SELECT 1+1;
SELECT 1+1 from dual;
SELECT 1+1 from products;
select now();
select current_timestamp();
select curdate();
select current_time();
select curtime();
select year(now()) as year;
select month(now()) as month;
select day(now()) as day;
select dayofweek(now()) as dayofweek;
select datediff(now(), '2019-01-01');

-- != <> =
-- null, isnull, notnull



SELECT name, price FROM products WHERE price < 1.0;
SELECT name, quantity FROM products WHERE quantity <= 2000;



SELECT name, price FROM products WHERE productCode = 'PEN';
                                      -- String values are quoted
                                      
                                      
-- reggress expression regexp
SELECT name, price FROM products WHERE name regexp '^PENCIL'; -- ~로 시작하는
SELECT name, price FROM products WHERE name regexp '2B$'; -- ~로 끝나는
SELECT name, price FROM products WHERE name LIKE 'PENCIL%';

 SELECT * FROM products WHERE quantity >= 5000 AND name LIKE 'Pen %';
 SELECT * FROM products WHERE quantity < 5000 or name not LIKE 'Pen %';
 
 SELECT * FROM products WHERE name IN ('Pen Red', 'Pen Black');


SELECT * FROM products 
       WHERE (price BETWEEN 1.0 AND 2.0) AND (quantity BETWEEN 1000 AND 2000);

SELECT * FROM products WHERE name LIKE 'Pen %' ORDER BY price DESC;


SELECT * FROM products WHERE name LIKE 'Pen %' ORDER BY price DESC, quantity;


SELECT * FROM products ORDER BY price LIMIT 2;

SELECT productID AS ID, productCode AS Code,
              name AS Description, price AS `Unit Price`  -- Define aliases to be used as display names
       FROM products
       ORDER BY ID;  -- Use alias ID as reference
       
	

SELECT DISTINCT price AS `Distinct Price` FROM products;
SELECT COUNT(*) AS `Count` FROM products;
       -- All rows without GROUP BY clause
       

SELECT   productCode, 
          MAX(price), 
          MIN(price), 
          CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`,
          SUM(quantity)
       FROM products
       GROUP BY productCode
       WITH ROLLUP;        -- Apply aggregate functions to all groups

UPDATE products SET price = price * 1.1;
SELECT * FROM products;
UPDATE products SET quantity = quantity - 100 WHERE name = 'Pen Red';

SELECT * FROM products WHERE name = 'Pen Red';


UPDATE products SET quantity = quantity + 50, price = 1.23 WHERE name = 'Pen Red';

SELECT * FROM products WHERE name = 'Pen Red';

DELETE FROM products;
INSERT INTO products VALUES (2001, 'PEC', 'Pencil 3B', 500, 0.52),
                            (NULL, 'PEC', 'Pencil 4B', 200, 0.62),
                            (NULL, 'PEC', 'Pencil 5B', 100, 0.73),
                            (NULL, 'PEC', 'Pencil 6B', 500, 0.47);
SELECT * FROM products;


USE southwind;

DROP TABLE IF EXISTS suppliers;

CREATE TABLE suppliers (
         supplierID  INT UNSIGNED  NOT NULL AUTO_INCREMENT, 
         name        VARCHAR(30)   NOT NULL DEFAULT '', 
         phone       CHAR(8)       NOT NULL DEFAULT '',
         PRIMARY KEY (supplierID)
       );
       
DESCRIBE suppliers;   

INSERT INTO suppliers VALUE
          (501, 'ABC Traders', '88881111'), 
          (502, 'XYZ Company', '88882222'), 
          (503, 'QQ Corp', '88883333');
          
SELECT * FROM suppliers;          

ALTER TABLE products
       ADD COLUMN supplierID INT UNSIGNED NOT NULL;
       
SELECT * FROM products;     

UPDATE products SET supplierID = 501;

ALTER TABLE products
       ADD FOREIGN KEY (supplierID) REFERENCES suppliers (supplierID);
DESCRIBE products;
UPDATE products SET supplierID = 502 WHERE productID  = 2004;
  -- Choose a valid productID

-- 1 나열 -> ambiguous
select name, price, name from products, suppliers;
-- 2 누구것 -> alias
select p.name, p.price, s.name from products p, suppliers s;
-- 3 카타시안 곱, cross join
select p.name, p.price, s.name from products p, suppliers s;
select p.name, p.price, s.name from products p join suppliers s on p.supplierID=s.supplierID;
select p.name, p.price, s.name from products p natural join suppliers s;

select p.name, p.price, s.name from products p, suppliers s
where p.supplierID=s.supplierID;

SELECT products.name, price, suppliers.name 
       FROM products 
          JOIN suppliers ON products.supplierID = suppliers.supplierID
       WHERE price < 0.6;

SELECT products.name, price, suppliers.name 
       FROM products, suppliers 
       WHERE products.supplierID = suppliers.supplierID
          AND price < 0.6;
          
CREATE TABLE products_suppliers (
         productID   INT UNSIGNED  NOT NULL,
         supplierID  INT UNSIGNED  NOT NULL,
                     -- Same data types as the parent tables
         PRIMARY KEY (productID, supplierID),
                     -- uniqueness
         FOREIGN KEY (productID)  REFERENCES products  (productID),
         FOREIGN KEY (supplierID) REFERENCES suppliers (supplierID)
       );
       
DESCRIBE products_suppliers;

INSERT INTO products_suppliers VALUES (2001, 501), (2002, 501),
       (2003, 501), (2004, 502), (2001, 503);
-- Values in the foreign-key columns (of the child table) must match 
--   valid values in the columns they reference (of the parent table)
SELECT * FROM products_suppliers;

show create table products_suppliers;
ALTER TABLE products DROP FOREIGN KEY products_ibfk_1;
ALTER TABLE products DROP supplierID;
DESC products;

select * from products;
select * from suppliers;
-- 1
select name, price, name from products, suppliers;
-- 2
select p.name, p.price, s.name from products p, suppliers s;
-- 3
select p.name, p.price, s.name 
from products p join products_suppliers ps
on p.productID=ps.productID
join suppliers s on ps.supplierID=s.supplierID;
-- 4
select p.name, p.price, s.name 
from products p, products_suppliers ps, suppliers s 
where p.productID=ps.productID and ps.supplierID=s.supplierID;

SELECT products.name AS `Product Name`, price, suppliers.name AS `Supplier Name`
       FROM products_suppliers 
          JOIN products  ON products_suppliers.productID = products.productID
          JOIN suppliers ON products_suppliers.supplierID = suppliers.supplierID
       WHERE price < 0.6;
       

CREATE TABLE product_details (
          productID  INT UNSIGNED   NOT NULL,
                     -- same data type as the parent table
          comment    TEXT  NULL,
                     -- up to 64KB
          PRIMARY KEY (productID),
          FOREIGN KEY (productID) REFERENCES products (productID)
       );


select * from suppliers;
select * from products_suppliers;
select suppliers.name from suppliers
where suppliers.supplierID
not in (select distinct supplierID from products_suppliers);


select distinct supplierID from products_suppliers;



























