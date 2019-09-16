
use ahyeon;
drop table if exists emp;
--                사원번호, 사원 이름, 직업, 매니져(상사),고용일, 급여, 커미션,부서
CREATE TABLE EMP (EMPNO int(4) PRIMARY KEY, ENAME VARCHAR(10), JOB VARCHAR(9), MGR int(4), HIREDATE DATE, SAL decimal(7,2), COMM decimal(7,2), DEPTNO int(2));

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,cast('2010-10-19' as date),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,cast('2000-10-19' as date),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,cast('2013-05-19' as date),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,cast('2018-10-19' as date),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,cast('2008-04-19' as date),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,cast('2016-11-19' as date),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,cast('2017-10-19' as date),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,cast('2013-10-11' as date),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,cast('2014-08-19' as date),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,cast('2010-10-19' as date),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,cast('2000-09-19' as date),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,cast('2018-10-19' as date),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,cast('2003-10-19' as date),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,cast('2002-10-19' as date),1300,NULL,10);

commit;
-- 1) emp 테이블 정보의 구조를 확인하는 sql을 작성 하세요.
desc EMP;
-- 2) 이름이 K로 시작하는 사원의 사원번호, 이름, 입사일, 급여를 검색하세요.
-- select EMPNO, ENAME, HIREDATE, SAL from EMP;
select EMPNO, ENAME, HIREDATE, SAL from EMP where ENAME like 'K%';
-- 3) 입사일이 2000년도인 사람의 모든 정보를 검색하세요.
select * from EMP where year(HIREDATE)=2000;
select * from EMP where substr(HIREDATE,1,4) = '2000';
select * from EMP where HIREDATE like '2000%';
-- 4) 커미션이 NULL이 아닌 사람의 모든 정보를 검색하세요.
select * from EMP where COMM is not null;
select ifnull(comm,0) from emp;
-- 5) 부서가 30번 부서이고 급여가 $1,500 이상인 사람의 이름, 부서 ,월급을 검색하세요.
select ename, deptno, sal from emp where DEPTNO=30 and sal >= 1500;
-- 6) 부서번호가 30인 사람 중 사원번호 SORT하여 출력되도록 검색하세요.
select empno from emp where DEPTNO=30 order by EMPNO;
-- 7) 급여가 많은 순으로 SORT하여 출력되도록 검색하세요.
select * from emp order by sal;
-- 8) 부서번호로 ASCENDING SORT한 후 급여가 많은 사람 순으로 검색하세요.
select * from emp order by deptno asc, sal;
-- 9) 부서번호로 DESCENDING SORT하고, 이름 순으로 ASCENDING SORT, 급여 순으로 DESCENDING SORT 하여 출력되도록 검색하세요.
select * from emp order by deptno desc, ename, sal desc;
-- 10) emp Table에서 이름, 급여, 커미션 금액, 총액(급여+커미션금액)을 구하여 총액이 많은 순서로 검색하세요. 
-- 단, 커미션이 NULL인 사람은 제외한다.(총액: sal*comm/100)
select ename, sal, comm, sal*comm as total from emp order by total ; -- 틀림
-- 11) 10번 부서의 모든 사람들에게 급여의 13%를 보너스로 지불하기로 하였다. 이름, 급여, 보너스 금액, 부서번호를 검색하세요.
select ename, sal, sal*0.13 bonus, deptno from emp;
-- update emp set ~~~ where ~~

-- 12) 부서번호가 20인 사원의 시간당 임금을 계산하여 검색하세요. 
-- 단, 1달의 근무일수는 12일이고, 1일 근무시간은 5시간이다. 출력양식은 이름, 급여, 시간당 임금(소수이하 첫 번째 자리에서 반올림)을 검색하세요.
select ename, sal, round(((sal/12)/12)/5, 1) `sal by hour` from emp where deptno=20;
-- 13) 급여가 $1,500부터 $3,000 사이의 사람은 급여의 15%를 회비로 지불하기로 하였다. 이를 이름, 급여, 회비(소수점 두자리아래에서 반올림)를 검색하세요.
select ename, sal, round(sal*0.15,2) `회비` from emp where sal>=1500 and sal<=3000;
-- 14) 모든 사원의 실수령액을 계산하여 검색하세요.. 
-- 단, 급여가 많은 순으로 이름, 급여, 실수령액을 검색하세요..(실수령액은 급여에 대해 10%의 세금을 뺀 금액)
select ename, sal, sal-(sal*0.1) `실수령액` from emp order by sal;
-- 15) 이름의 글자수가 6자 이상인 사람의 이름을 앞에서 3자만 구하여 소문자로 이름만을 검색하세요.
select concat(ename,3) from emp where count(ename)>=6;
-- 16) 10번 부서 월급의 평균, 최고, 최저, 인원수를 구하여 검색하세요.
select avg(sal/12) as `평균`, max(sal/12) as `최고`, min(sal/12) as `최저`, count(*) as `인원수` from emp where deptno=10;
-- 17) 각 부서별 같은 업무를 하는 사람의 인원수를 구하여 부서번호,업무명, 인원수를 검색하세요.
select deptno as `부서번호`, job as `업무명`, count(empno) as `인원수` from emp group by deptno,job;
-- 18) 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 검색하세요.
select job as `업무`, count(job) from emp group by job having count(job)>=4;
-- 19) 입사일로부터 오늘까지의 일수를 구하여 이름, 입사일, 근무일수를 검색하세요.
select ename, hiredate, datediff(curdate(), hiredate) '근무 일수' from emp;
-- 20) 직원의 이름, 근속년수를 구하여 검색하세요.
select ename, year(curdate()) - year(hiredate) from emp;
-- 21) 업무가 ANALYST인 모든 사원의 사원번호, 이름, 입사일, 급여를 검색하세요.
select empno, ename, hiredate, sal from emp where job like 'ANALYST';
-- 22) 부서 번호를 한 번씩만 출력되도록 검색하세요.
select distinct deptno from emp;
-- 23)부서 번호와 부서별 연봉 평균을 검색하세요.
select deptno, avg(sal) from emp group by deptno;
-- 24) 부서별로 급여의 합계를 구하되 합계가 1,000 이상인 부서와 합계를 검색하세요.
select deptno, sum(sal) from emp group by deptno having sum(sal)>=1000;
-- 25) emp 테이블의 행의 개수를 검색하세요.
select count(*) from emp;










