use ahyeon;
drop table if exists book;
create table if not exists book(
isbn varchar(50) primary key,
title varchar(50) not null,
author varchar(50) not null,
publisher varchar(50) not null,
price int not null,
description varchar(200)
);

insert into book(isbn,title,author,
publisher,price, description) 
values('80001','모던 아현을 위한 책','류치현','아현사',2000, 
'자바를 사랑하는 분께'), 
('80002','모던 보이를 위한 책','류치현','아현사',3000, 
'떡볶기를 사랑하는 분께'),
('80003','누구를 위하여 예비군에 가는가','손경수','아현사',4000, 
'알골향상을 위한 분께'),
('80004','치킨을 아는가','손경수','아현사',4000, 
'닭을 잘 튀기는 법'),
('80005','사과를 아는가','손경수','아현사',3000, 
'사과를 잘 고르는 법');

select * from book;
insert into book(isbn,title,author,
publisher,price, description)
values('80006','모던 아현을 위한 책','류치현','아현사',2000, 
'자바를 사랑하는 분께');
delete from book where isbn='80006';
insert into book(isbn,title,author,
publisher,price, description)
values('80006','모던 아현을 위한 책','류치현','아현사',2000, 
'자바를 사랑하는 분께');
update book set 
title='희주는 고양이를 좋하해',
author='희주',
description='고양이 키우기....'
where isbn='80006';
select * from book;

select count(*) from book;


drop table if exists author;
create table if not exists author(
authorno int primary key,
name varchar(50),
phone varchar(50)
);















