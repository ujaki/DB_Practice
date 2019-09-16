use ahyeon;
drop table ah_user_stock;
drop table ah_user;
drop table ah_stock;
create table if not exists ah_user(
	uid varchar(50) primary key,
    name varchar(50) not null,
    address varchar(50) not null
);

create table if not exists ah_stock(
	sid varchar(50) primary key,
    name varchar(50) not null,
    price int not null
);

create table if not exists ah_user_stock(
	uid varchar(50) not null,
    sid varchar(50) not null,
    quantity int not null,
    primary key (uid, sid),
    foreign key (uid) references ah_user (uid),
    foreign key (sid) references ah_stock (sid)
);
show tables;
desc ah_user;
desc ah_stock;
desc ah_user_stock;

insert into ah_user(uid,name,address)
values('u000001','류치현','경기도 파주시 112');
insert into ah_user(uid,name,address)
values('u000002','손경수','충북 영동 113');
insert into ah_user(uid,name,address)
values('u000003','김아현','대전 논산 훈련소');
select * from ah_user;

insert into ah_stock(sid,name,price)
values('SDS','삼성 SDS',50000);
insert into ah_stock(sid,name,price)
values('HD','현대 모비스',150000);
insert into ah_stock(sid,name,price)
values('KIA','KIA 불루',100000);
select * from ah_stock;

commit;
insert into ah_user_stock(uid, sid, quantity)
values('u000002', 'HD',300);

select * from ah_user_stock;

-- error ambiguous
select uid, name, sid, name, price*quantity from ah_user , ah_user_stock, ah_stock;
-- 위의 에러를 처리하기 위해 아래와 같이 수정, cross
select u.uid, u.name, s.sid, s.name, s.price*us.quantity from ah_user u, ah_user_stock us, ah_stock s;
-- or, 카타시안
select u.uid, u.name, s.sid, s.name, s.price*us.quantity from ah_user u join ah_user_stock us
on u.uid=us.uid
join ah_stock s on us.sid=s.sid;

-- ------------------------------------------------------------------------------------------------------------------

SHOW DATABASES;
CREATE DATABASE southwind;
show create database southwind;
DROP DATABASE southwind;
show databases;

CREATE DATABASE IF NOT EXISTS southwind;
DROP DATABASE IF EXISTS southwind;

CREATE DATABASE IF NOT EXISTS southwind;
use southwind;
show tables;
CREATE TABLE IF NOT EXISTS products (
         productID    INT UNSIGNED  NOT NULL AUTO_INCREMENT,
         productCode  CHAR(3)       NOT NULL DEFAULT '',
         name         VARCHAR(30)   NOT NULL DEFAULT '',
         quantity     INT UNSIGNED  NOT NULL DEFAULT 0,
         price        DECIMAL(7,2)  NOT NULL DEFAULT 99999.99,
         PRIMARY KEY  (productID)
       );
DESCRIBE products;

select * from products;

INSERT INTO products VALUES (1001, 'PEN', 'Pen Red', 5000, 1.23);

INSERT INTO products VALUES
         (NULL, 'PEN', 'Pen Blue',  8000, 1.25), -- auto increment 이니까 null이면 자동으로 증가
         (NULL, 'PEN', 'Pen Black', 2000, 1.25);

INSERT INTO products (productCode, name, quantity, price) VALUES
         ('PEC', 'Pencil 2B', 10000, 0.48),
         ('PEC', 'Pencil 2H', 8000, 0.49);

INSERT INTO products (productCode, name) VALUES ('PEC', 'Pencil HB');
         
SELECT name, price FROM products;
SELECT * FROM products;
SELECT 1+1;

SELECT name, price FROM products WHERE name LIKE 'PENCIL%';

SELECT name, price FROM products WHERE name LIKE 'P__ %';

SELECT * FROM products WHERE quantity >= 5000 AND name LIKE 'Pen %';

SELECT * FROM products WHERE quantity >= 5000 AND price < 1.24 AND name LIKE 'Pen %';

SELECT * FROM products WHERE NOT (quantity >= 5000 AND name LIKE 'Pen %');

SELECT * FROM products WHERE name IN ('Pen Red', 'Pen Black');

SELECT * FROM products WHERE (price BETWEEN 1.0 AND 2.0) AND (quantity BETWEEN 1000 AND 2000);

SELECT * FROM products WHERE name LIKE 'Pen %' ORDER BY price DESC;
SELECT quantity, price FROM products WHERE name LIKE 'Pen %' ORDER BY 2 DESC;
-- 
SELECT * FROM products WHERE name LIKE 'Pen %' ORDER BY price DESC, quantity;

SELECT * FROM products ORDER BY price LIMIT 2; -- 작은 숫자 2개
SELECT * FROM products ORDER BY price desc LIMIT 2; -- 큰 숫자 2개

SELECT CONCAT(productCode, ' - ', name) AS `Product Description`, price FROM products;

 SELECT MAX(price), MIN(price), AVG(price), STD(price), SUM(quantity)
       FROM products;

SELECT productCode, MAX(price) AS `Highest Price`, MIN(price) AS `Lowest Price`
       FROM products
       GROUP BY productCode;

SELECT productCode, MAX(price), MIN(price),
              CAST(AVG(price) AS DECIMAL(7,2)) AS `Average`,
              CAST(STD(price) AS DECIMAL(7,2)) AS `Std Dev`,
              SUM(quantity)
       FROM products
       GROUP BY productCode;
       
