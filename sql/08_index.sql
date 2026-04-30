
use ssafydb;

-- ------------------------------------------------------------------------------------------
-- index 확인
-- ------------------------------------------------------------------------------------------
select count(*) from students;

show index from students;
show index from users;


-- ------------------------------------------------------------------------------------------
-- full table scan
-- ------------------------------------------------------------------------------------------

-- explain analyze
select  *
from	students;

select  *
from	users;

-- ------------------------------------------------------------------------------------------
-- Index full scan
-- ------------------------------------------------------------------------------------------

explain
select  count(*)
from	students;

select  count(*)
from	users;

-- ------------------------------------------------------------------------------------------
-- Index unique scan
-- ------------------------------------------------------------------------------------------

select  name, campus, class_no, ord_no
from	students
where	student_id = 'A004648';

explain analyze
select  no,name,age
from	users
WHERE	no = 7777; 

-- ------------------------------------------------------------------------------------------
-- Index range scan
-- ------------------------------------------------------------------------------------------


select  student_id, name, campus, class_no, ord_no
from	students 
where	student_id  BETWEEN 'A004800' and 'Y004999'; 
 
 
select  no,name,age
from	users 
WHERE	no between 1 and 90000;


--------------------------------------------------------------------------------------------
-- secendary index
--------------------------------------------------------------------------------------------

select  name, campus, class_no
from	students
where   name = '김태희';

explain analyze
select  no,name,age
from	users
WHERE	name = 'user007777'; 

-- 이름에 인덱스 생성

create index idx_name on users(name);

--------------------------------------------------------------------------------------------
-- functional based index
--------------------------------------------------------------------------------------------
	select  no,name,age
	from	users
	WHERE	name like 'user7%'; 

    select  name, campus, class_no
    from	students
    where	substr(name,2) = '수지';
    
   -- 함수 기반 인덱스 생성

--------------------------------------------------------------------------------------------
-- multi-columned index
--------------------------------------------------------------------------------------------

select ord_no, campus, class_no, name
FROM   students 
WHERE  ord_no = 13
AND    campus = '서울';


select  no, age,gender
from	users
where	age between 20 and 29
and		gender = 'f';
    

   -- multi columned 인덱스 생성
   
   

--------------------------------------------------------------------------------------------
-- covering index
--------------------------------------------------------------------------------------------


select  count( distinct campus )
from	students
where	ord_no = 13;


select	student_id
from	students
where	ord_no = 13;

