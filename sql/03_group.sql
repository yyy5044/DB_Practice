USE ssafydb;

----------------------------------------------------------
--- 그룹함수(다중행함수)
----------------------------------------------------------

# 모든 사원의 월급여합, 월급여평균, 사원수 조회
select sum(sal), round(avg(sal), 1), count(*) as "사원 수"
from emp;

# 커미션이 정해진 모든 사원들의 커미션합, 커미션평균 조회
select sum(comm), round(avg(sal), 1), count(comm)
from emp;


# 상사(관리자)가 있는 사원수 조회
select count(mgr)
from emp;


# 상사(관리자)인 사원수 조회
select count(distinct mgr)
from emp;


# 부서배치 받은 모든 사원수, 사원이 소속된 부서의 수 조회 
select count(deptno), count(distinct deptno)
from emp;


# 부서별 직무 조합의 수 조회
select count(distinct deptno, job)
from emp;


# 부서별 사원수, 월급여평균 조회
select deptno, count(*), avg(sal)
from emp
group by deptno;


# 같은 입사월을 갖는 사원들의 입사월, 사원수 , 월급여평균 조회(입사월 기준 오름차순 정렬)
select month(hiredate) as 입사월, count(*), avg(sal)
from emp
group by month(hiredate)
order by 입사월;


# 부서별 직무별 사원수 조회
select deptno, job, count(*)
from emp
group by deptno, job;


# 부서별 최대 급여 조회
select deptno, max(sal)
from emp
group by deptno;

# 부서 별 급여 제일 높은 사람 이름 뽑을 때 오류
-- select deptno, max(sal), ename
-- from emp
-- group by deptno;
show variables like 'SQL_MODE'; # 이게 뭐라고?
# 위와 같이 실수할 수 있다.

# 그래서 부서 별 급여 제일 높은 사람 이름 어떻게 뽑는데...
select deptno, dname, max(sal)
from emp
join dept using(deptno)
group by deptno;
# 위 같은 표현은 mysql이라 가능.


# 부서별 사원수가 5명 이상인 부서번호와 인원 조회
select deptno, count(*)
from emp
group by deptno
having count(*) >= 5;


# 직무별 평균 급여가 3000이상인 직무와 평균급여 조회
select		job, avg(sal)
from		emp
group by	job
having avg	(sal) >= 3000;


# 같은 달에 입사한 사원수 조회, 단,사원수가 2명이상인 경우 
select month(hiredate), count(*)
from emp
group by month(hiredate)
having count(*) >= 2;


# 같은 달에 입사한  사원수와 평균월급여 조회, 단,사원수가 2명이상이며 평균월급여가 2000이상인 경우(입사월 기준 오름차순 정렬)
select month(hiredate), count(*) as cnt, avg(sal) as avg_sal
from emp
group by month(hiredate)
having cnt >= 2 AND avg_sal >= 2000
order by month(hiredate);
# 실행 순서상 select가 맨 뒤라서 select에서 선언한 별칭이 안 되야 맞는데, mysql은 편의를 위해 가능하게 해뒀다.


# 사원평균월급여가 최대인 부서번호와 월평균급여 조회
-- select max(avg(sal))
-- from emp
-- group by deptno;
# 위의 표현은 에러다. 근데 또 oracleDB는 된다. 안 되는 이유는 집계함수를 중첩으로 쓸 수 없어서.

select deptno, avg(sal)
from emp
group by deptno
order by avg(sal) desc
limit 0, 1;
# 이거 서브쿼리로도 가능하다


# 총계 roll up
# 부서별 사원들의 급여합 조회하며 전사원들의 월급여합 총계 함께 생성
select deptno, sum(sal)
from emp
group by deptno with rollup;


# 소계, 총계 rollup
# 부서별 직무별 사원들의 급여합 조회하며 부서별 소계, 전사원들의 월급여합 총계 함께 생성
select deptno, job, sum(sal)
from emp
group by deptno, job with rollup;
# 이렇게 하면 그룹 기준1인 deptno과 그룹 기준2인 job에 대한 rollup이 하나씩 적용된다.
# 그룹기준1인 dept로 묶었을 때 소계 튜플 하나, 그룹


# grouping()
# 부서별 직무별 사원들의 급여합 조회하며 부서별 소계, 전사원들의 월급여합 총계 함께 생성



# 부서별 직무별 월급여합 피봇테이블로 조회
-- 출력형태--
-- deptno clerk		manager		president		analyst		salesman
-- 10    1300		2450		5000
-- 20    1900		2975						6000
--  ...

