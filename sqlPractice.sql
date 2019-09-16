-- ddl
CREATE SCHEMA hhhh DEFAULT CHARACTER SET utf8 ;
drop SCHEMA hhhh;

use chaelyn;
show databases;
use sakila;
show tables;
show create database chaelyn;

use chaelyn; /*chaelyn 스키마를 사용하겠다*/
drop table if exists books; /*books 테이블 있으면 삭제*/
create table if not exists books( /*books 테이블 없으면 만들기*/
	isbn varchar(50) primary key, /*not null*/
    title varchar(100) not null,
    author varchar(50) not null,
    publisher varchar(50) not null,
    price int(8) not null, /*8자리로 제한*/
    quantity int(8) not null
);

show create table books; /*create table 쿼리 확인*/
/*테이블 구조 보기*/
desc books; /*describe books*/

select isbn, title, author from books;

/*모든 col, db 순으로*/
select * from books;
/*Create*/
insert into books (isbn, title, author, publisher, price, quantity)
values('t001', '누구를 위하여 알골을 하는가?', '류치현', '희주사', 2000, 5);
insert into books (isbn, title, author, publisher, price, quantity)
values('t002', '누구를 위하여 밥을 먹는가?', '류시호', '희주사', 3000, 50);
insert into books (isbn, title, author, publisher, price, quantity)
values('t003', '누구를 위하여 일을 하는가?', '우아앙', '랄랄라', 20000, 52);

commit;
select * from books;
select count(isbn) from books; -- aggregation,군집 1x1

select * from books where isbn='t001'; -- 하나일 때
select * from books where author='류치현';

select * from books where author like '류%'; -- everything after 류

select * from books where author like '류__'; -- 류 뒤에 한글자

select count(*) from books where author like '류%'; 

insert into books (isbn, title, author, publisher, price, quantity)
values('t0005', '체조하기 싫어', '강백호', '민철사', 3000, 6);

select * from books;
select concat(author, '-', publisher) from books;
select concat(author, '-', publisher) as au_pub from books; /*concat name*/
/*select concat(author, '-', publisher) au_pub from books;*/ -- 위와 동일 oracle은 as 무조건 넣어줘야 함

select count(*), publisher from books; 

select count(*), publisher from books group by publisher;
-- count max min avg std sum
select * from books;
select sum(price) '한권당 가격의 합' from books;
select sum(price*quantity) total from books;
select price*quantity total from books; -- one row

select max(price), min(price) from books;
/* 출판사 별로 가장 비싼 책의 가격과 가장 싼 책의 가격*/
select max(price) maxp, min(price) minp, count(*) nums, publisher from books group by publisher;
/* 출판사 별로 가장 비싼 책의 가격과 가장 싼 책의 가격이 같은 경우*/
select max(price) maxp, min(price) minp, count(*) nums, publisher from books group by publisher
having maxp=minp;

select * from books order by 5; -- ascending

select * from books order by 5, 6 desc;

select price pp, title tt from books order by pp;

select * from books order by 5 desc limit 2; -- 위에서 2개

update books set title='누구를 위하여 체조를 하는가', author='킴' where isbn='t001';

delete from books where isbn='t001';

select * from books;
select distinct publisher from books; -- 중복 제거

select count(distinct publisher) from books;
select count(*) from books;

select now(); -- 현재 시간
select current_timestamp();
select current_date(); -- 연월일
select current_time(); -- 시분초
select year(now()); -- 연도
select month(now());
-- 경과 시간
select datediff(now(), '2019-08-13');

select length(title) from books;
select substr(now(), 1, 4);














