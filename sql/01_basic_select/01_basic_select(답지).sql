USE ssafydb;

# 현 데이터베이스의 모든 테이블 조회
SHOW TABLES;


# 테이블 구조 확인
DESC emp;


----------------------------------------------------------
--- 기본 조회
----------------------------------------------------------

# 모든 사원의 모든 정보(열) 조회
SELECT *
FROM emp;


# 모든 사원의 특정 정보(열) 조회
SELECT empno, ename, sal
FROM emp;


# 모든 사원의 이름, 1년급여, 커미션, 1년급여+커미션 조회
# ※ NULL과 산술 연산하면 결과도 NULL → IFNULL로 0 처리
SELECT ename, 
       sal * 12 AS "1년 급여", 
       comm, 
       sal * 12 + IFNULL(comm, 0) AS "1년 총 소득"
FROM emp;


# 모든 사원들이 속해 있는 부서 번호 조회
SELECT DISTINCT deptno
FROM emp;


# 모든 사원이 속한 부서와 각 부서의 직무 조회
SELECT DISTINCT deptno, job
FROM emp;


----------------------------------------------------------
--- 조건절과 연산자
----------------------------------------------------------

# 20번 부서에 속한 사원이름, 부서번호 조회
SELECT ename, deptno
FROM emp
WHERE deptno = 20;


# 직무가 CLERK인 사원이름, 직무, 입사일 조회
SELECT ename, job, hiredate
FROM emp
WHERE job = 'CLERK';


# 월급여가 2000보다 많이 받는 사원이름, 월급여 조회
SELECT ename, sal
FROM emp
WHERE sal > 2000;


# 월급여가 1000이상 2000이하인 사원이름, 월급여 조회
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 2000;


# 10,20번 부서에 근무하는 사원이름, 부서번호, 월급여 조회
SELECT ename, deptno, sal
FROM emp
WHERE deptno IN (10, 20);


# 10번 부서에서 MANAGER직무를 담당하거나 20번 부서에서 CLERK직무를 담당하고 있는 사원이름,부서번호,직무,월급여 조회
# 페어와이즈(pairwise) 비교 활용
SELECT ename, deptno, job, sal
FROM emp
WHERE (deptno, job) IN ((10, 'MANAGER'), (20, 'CLERK'));


# 이름이 S로 시작하는 사원이름, 월급여 조회
SELECT ename, sal
FROM emp
WHERE ename LIKE 'S%';


# 이름안에 S를 포함하는 사원이름, 월급여 조회
SELECT ename, sal
FROM emp
WHERE ename LIKE '%S%';


# 이름이 5글자이고 S로 끝나는 사원이름 조회
# _ 는 정확히 한 글자, % 는 0글자 이상
SELECT ename
FROM emp
WHERE ename LIKE '____S';


# 이름의 두번째 글자가 A인 사원번호, 사원이름 조회
SELECT empno, ename
FROM emp
WHERE ename LIKE '_A%';


# 이름에 _가 포함된 사원번호, 이름 조회
# _ 는 와일드카드이므로 이스케이프 필요
SELECT empno, ename
FROM emp
WHERE ename LIKE '%\_%';
# 또는 ESCAPE 절로 이스케이프 문자 직접 지정:
# WHERE ename LIKE '%#_%' ESCAPE '#';


# COMM이 NULL인 사원이름, 커미션 조회
# NULL은 = 비교 불가 → IS NULL 사용
SELECT ename, comm
FROM emp
WHERE comm IS NULL;


# 10번 부서에 속하지 않으며 월급여가 2000보다 많이 받는 사원이름,부서번호,월급여 조회
SELECT ename, deptno, sal
FROM emp
WHERE deptno != 10 AND sal > 2000;


# 10,20번 부서에 속하는 사원이름, 부서번호 조회(논리 연산자 활용)
# IN 대신 OR로 작성
SELECT ename, deptno
FROM emp
WHERE deptno = 10 OR deptno = 20;


# 월급여가 1000이상 2000이하인 사원이름, 월급여 조회(논리 연산자 활용)
# BETWEEN 대신 AND로 작성
SELECT ename, sal
FROM emp
WHERE sal >= 1000 AND sal <= 2000;


# 20번 부서에 속하지 않는 사원이름, 부서번호 조회(논리 연산자 활용)
# != 대신 NOT 사용
SELECT ename, deptno
FROM emp
WHERE NOT deptno = 20;


# 000101-3010224 주민번호에서 성별 알아내기(case 연산자 활용)
# 주민번호 8번째 자리(하이픈 뒤 첫 글자)로 판별: 1,3 → 남 / 2,4 → 여
SELECT
    CASE SUBSTRING('000101-3010224', 8, 1)
        WHEN '1' THEN '남'
        WHEN '3' THEN '남'
        WHEN '2' THEN '여'
        WHEN '4' THEN '여'
    END AS gender;

# 검색 CASE로도 작성 가능:
# SELECT
#     CASE
#         WHEN SUBSTRING('000101-3010224', 8, 1) IN ('1', '3') THEN '남'
#         WHEN SUBSTRING('000101-3010224', 8, 1) IN ('2', '4') THEN '여'
#     END AS gender;


# 사원번호, 사원이름, 월급여, 월급여가 0~2000미만 : C등급, 2000~4000미만 : B등급, 4000~ : A등급으로 조회
# ※ CASE는 위에서부터 평가되므로 좁은 범위(높은 값)부터 작성
SELECT empno, ename, sal,
    CASE
        WHEN sal >= 4000 THEN 'A등급'
        WHEN sal >= 2000 THEN 'B등급'
        ELSE 'C등급'
    END AS grade
FROM emp;


----------------------------------------------------------
--- 정렬
----------------------------------------------------------

# 사원번호, 이름, 부서번호를 부서번호 기준으로 오름차순 정렬
SELECT empno, ename, deptno
FROM emp
ORDER BY deptno ASC;
# ASC는 기본값이라 생략 가능


# 사원번호, 이름, 부서번호, 월급여를 부서번호가 빠른 순으로, 같은 부서안에서는 월급여를 많이 받는 순으로 사원 조회
SELECT empno, ename, deptno, sal
FROM emp
ORDER BY deptno ASC, sal DESC;


# 가장 많은 월급여를 받는 상위 5명 사원이름, 월급여 조회
SELECT ename, sal
FROM emp
ORDER BY sal DESC
LIMIT 5;


# 가장 많은 월급여를 받는 상위 5명 이후 5명의 사원이름, 월급여 조회
# LIMIT a, b → a개 건너뛰고 b개 가져옴 (첫 번째가 OFFSET, 두 번째가 개수)
SELECT ename, sal
FROM emp
ORDER BY sal DESC
LIMIT 5, 5;
# 또는: LIMIT 5 OFFSET 5;