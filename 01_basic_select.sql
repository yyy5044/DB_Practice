USE ssafydb;

# 현 데이터베이스의 모든 테이블 조회
show tables;


# 테이블 구조 확인
desc emp;


----------------------------------------------------------
--- 기본 조회
----------------------------------------------------------

# 모든 사원의 모든 정보(열) 조회
select *
from emp;


# 모든 사원의 특정 정보(열) 조회
select empno, ename, sal
from emp;


# 모든 사원의 이름, 1년급여,  커미션, 1년급여+커미션 조회
# null은 " ", 0과 다르다! 연산시 연산의 결과도 null이 되는 특징이 있다.
select empno, sal, sal * 12, comm, sal*12 + comm
from emp;

select empno, sal, sal * 12 as "1년 급여", comm, sal*12 + ifnull(comm, 0) as "1년 총 소득"
from emp;

# 모든 사원들이 속해 있는 부서 번호 조회
select distinct deptno
from emp;


# 모든 사원이 속한 부서와 각 부서의 직무 조회
select distinct deptno, job
from emp;

----------------------------------------------------------
--- 조건절과 연산자
----------------------------------------------------------

# 20번 부서에 속한 사원이름, 부서번호 조회
select ename, deptno
from emp
where deptno = 20;


# 직무가 CLERK인 사원이름, 직무, 입사일 조회
select ename, job, HIREDATE
from emp
where job = 'CLERK';


# 월급여가 2000보다 많이 받는 사원이름, 월급여 조회



# 월급여가 1000이상 2000이하인 사원이름, 월급여 조회
select ename, sal
from emp
where job between 1000 and 2000;


# 10,20번 부서에 근무하는 사원이름, 부서번호, 월급여 조회
select ename, DEPTNO, SAL
from emp
where DEPTNO in(10, 20);


# 10번 부서에서 MANAGER직무를 담당하거나 20번 부서에서 CLERK직무를 담당하고 있는 사원이름,부서번호,직무,월급여 조회
select ename, DEPTNO, job, SAL
from emp
where (deptno, job) in ((10, 'MANAGER'), (20, 'CLERK')); # 페어와이즈!!


# 이름이 S로 시작하는 사원이름, 월급여 조회
select ename, SAL
from emp
where ename like 'S%';

# 이름안에 S를 포함하는 사원이름, 월급여 조회
select ename, SAL
from emp
where ename like '%S%';


# 이름이 5글자이고 S로 끝나는 사원이름 조회



# 이름의 두번째 글자가 A인 사원번호, 사원이름 조회
select empno, ename
from emp
where ename like '_A%';


# 이름에 _가 포함된 사원번호, 이름 조회
select empno, ename
from emp
where ename like '%\_%'; # 백슬래시로 이스케이프
# where ename like '%#_%' escape '#'; 이렇게 이스케이프 문자 정해주기도 가능

# COMM이 NULL인 사원이름, 커미션 조회
select ename, comm
from emp
where comm is null;


# 10번 부서에 속하지 않으며 월급여가 2000보다 많이 받는 사원이름,부서번호,월급여 조회



# 10,20번 부서에 속하는 사원이름, 부서번호 조회(논리 연산자 활용)



# 월급여가 1000이상 2000이하인 사원이름, 월급여 조회(논리 연산자 활용)



# 20번 부서에 속하지 않는 사원이름, 부서번호 조회(논리 연산자 활용)
select ename, deptno
from emp
where deptno != 0;
# where not deptno = 0; <- 이것도 가능

# 000101-3010224 주민번호에서 성별 알아내기(case 연산자 활용)



# 사원번호, 사원이름, 월급여, 월급여가 0~2000미만 : C등급, 2000~4000미만 : B등급, 4000~ : A등급으로 조회


----------------------------------------------------------
--- 정렬
----------------------------------------------------------

# 사원번호, 이름, 부서번호를 부서번호 기준으로 오름차순 정렬



# 사원번호, 이름, 부서번호, 월급여를 부서번호가 빠른 순으로, 같은 부서안에서는 월급여를 많이 받는 순으로 사원 조회



# 가장 많은 월급여를 받는 상위 5명 사원이름, 월급여 조회



# 가장 많은 월급여를 받는 상위 5명 이후 5명의 사원이름, 월급여 조회


