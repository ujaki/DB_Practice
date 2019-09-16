CREATE SCHEMA `ahyeon` DEFAULT CHARACTER SET utf8 ;
drop SCHEMA `ahyeon`;
use ahyeon;
show CREATE SCHEMA ahyeon;
-- 'ahyeon', 'CREATE DATABASE `ahyeon`
show databases;
show tables;
use sakila;
show tables;
describe actor;
select * from actor;
select actor_id, first_name, last_name, last_update from actor;
select * from actor where first_name like upper('k%');
select * from actor where first_name='KARL';
select * from actor where actor_id=12;
select * from actor where year(last_update)>=2006;
select * from actor where year(last_update) in (2006,2007,2008);
select * from actor where year(last_update) between 2006 and 2008;
-- put first name and last name as the name of name 
select concat(first_name, ' ',last_name) as name from actor;
select now();
select current_timestamp();
select current_date();
select year(now());
select datediff(now(), '1991-04-22');

select count(*) from actor;
select * from actor;
select * from actor where substr(first_name,1,1) in ('A','B','C') order by first_name;
select * from actor where substr(first_name,1,1) between 'A' and 'Z' order by first_name;

show tables;
desc actor;
desc film;
desc film_actor;

select * from actor;
select * from film;
select actor_id, first_name, last_name from actor;

select * from film where title='WIFE TURN';
-- 973
select * from film where film_id=973;
select * from film_actor where film_id=973;
select count(*) from film_actor where film_id=973;

-- cross join, cartasian 10*20 = 200
-- ambiguous
select actor_id, first_name, last_name, title description from actor, film;
-- cross join
select a.actor_id, a.first_name, a.last_name, f.title, f.description 
from actor a, film f;
--
select a.actor_id, a.first_name, a.last_name, f.title, f.description 
from actor a join film_actor fa
on a.actor_id=fa.actor_id
join film f on fa.film_id=f.film_id;
--
select a.actor_id, a.first_name, a.last_name, f.title, f.description
from actor a, film_actor fa, film f
where a.actor_id=fa.actor_id
and fa.film_id=f.film_id
and f.film_id=973;














