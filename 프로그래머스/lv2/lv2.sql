# 문제1 동물 수 구하기
[풀이 1]
select count(*) as count
from ANIMAL_INS;

# 문제2 조건에 맞는 아이템들의 가격의 총합 구하기
[풀이 1]
select sum(price) as TOTAL_PRICE
from item_info
where rarity = 'LEGEND';

# 문제3 카테고리 별 상품 개수 구하기
# 오답노트: 문제 제대로 읽어야 하고, 직접 나열하는 식으로 하는게 아니다. substring으로 앞에 두 자리 떼어서 그걸로 그룹핑한 후, 각 그룹의 개수를 세어야 한다.
[풀이 1]
select substring(PRODUCT_CODE, 1, 2) as CATEGORY, count(*) as PRODUCTS
from PRODUCT
group by substring(PRODUCT_CODE, 1, 2);

# 문제4 동명 동물 수 찾기
[풀이 1]
select name, count(name) as COUNT
from ANIMAL_INS
group by name
having count(name) >= 2
order by name;

# 문제5 이름에 el이 들어가는 동물 찾기
# 오답노트: 동물 보호소지 유기견 보호소가 아니다. animal_type도 필터링해야 한다 ㅠㅠ
[풀이 1]
select ANIMAL_ID, NAME
from ANIMAL_INS
where name like '%el%' and animal_type = 'Dog'
order by name;

# 문제6 NULL 처리하기
[풀이 1]
select ANIMAL_TYPE, ifnull(NAME, 'No name'), SEX_UPON_INTAKE
from ANIMAL_INS
order by ANIMAL_ID;

# 문제7 DATETIME에서 DATE로 형 변환
[풀이 1] 
select ANIMAL_ID, NAME, DATE(DATETIME) as 날짜
from ANIMAL_INS
order by ANIMAL_ID;

# 문제8 가격이 제일 비싼 식품의 정보 출력하기
[풀이 1]
select PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE
from FOOD_PRODUCT
order by price desc limit 1;

# 풀이9 최솟값 구하기
[풀이 1]
select min(datetime) as 시간
from ANIMAL_INS;

# 풀이10 중복 제거하기
[풀이 1]
select count(distinct name) as count
from ANIMAL_INS;

# 풀이11 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
[풀이 1]
select CAR_TYPE, count(*) as CARS
from CAR_RENTAL_COMPANY_CAR
where (OPTIONS like '%통풍시트%') or (OPTIONS like '%열선시트%') or (OPTIONS like '%가죽시트%')
group by CAR_TYPE
order by CAR_TYPE;

# 풀이12 중성화 여부 파악하기
[풀이 1]
select ANIMAL_ID, NAME, case
                            when SEX_UPON_INTAKE like 'Neutered%' then 'O'
                            when SEX_UPON_INTAKE like 'Spayed%' then 'O'
                            else 'X'
                        end as 중성화
from ANIMAL_INS;

# 문제13 진료과별 총 예약 횟수 출력하기
[풀이 1]
select MCDP_CD as '진료과코드', count(*) as '5월예약건수'
from APPOINTMENT
where APNT_YMD like '2022-05-%'
group by MCDP_CD
order by count(*), MCDP_CD;

# 문제14 조건에 맞는 도서와 저자 리스트 출력하기
[풀이 1]
select BOOK_ID, AUTHOR_NAME, PUBLISHED_DATE
from BOOK as b
join AUTHOR as a
on b.AUTHOR_ID = a.AUTHOR_ID
where CATEGORY = '경제'
order by PUBLISHED_DATE;

# 문제15 고양이와 개는 몇 마리 있을까
[풀이 1]
select ANIMAL_TYPE, count(ANIMAL_TYPE) as count
from ANIMAL_INS
where ANIMAL_TYPE = 'Dog' or ANIMAL_TYPE = 'Cat'
group by ANIMAL_TYPE
order by ANIMAL_TYPE asc;

# 문제16 입양 시각 구하기(1)
# 오답노트: time() 함수 -> 시:분:초로 반환 hour()함수 -> 정수형 시간만 반환
# minute(), second() 함수도 따로 있음.
[풀이 1]
select hour(datetime), count(*)
from ANIMAL_OUTS
where hour(datetime) between 9 and 19
group by hour(DATETIME)
order by hour(datetime);

# 문제17 성분으로 구분한 아이스크림 총 주문량
[풀이 1]
select INGREDIENT_TYPE, sum(TOTAL_ORDER) as TOTAL_ORDER
from FIRST_HALF
join ICECREAM_INFO
on FIRST_HALF.FLAVOR = ICECREAM_INFO.FLAVOR
group by INGREDIENT_TYPE
order by TOTAL_ORDER;

# 문제18 상품 별 오프라인 매출 구하기
# 오답노트: 끝나고 SALES 기준으로 내림차순 정렬! order by절은 select절까지 끝난 후 실행된다.
[풀이 1] 
select PRODUCT.PRODUCT_CODE, sum(PRODUCT.PRICE*OFFLINE_SALE.SALES_AMOUNT) as SALES
from OFFLINE_SALE
join PRODUCT
on OFFLINE_SALE.PRODUCT_ID = PRODUCT.PRODUCT_ID
group by PRODUCT.PRODUCT_CODE
order by SALES desc, PRODUCT.PRODUCT_CODE asc;

# 문제19 3월에 태어난 여성 회원 목록 출력하기
# 오답노트: '여성 회원'이어야 함. 조건 하나씩 빼먹으니까 문제 보고 체크리스트화 해놓고 풀자.
[풀이 1]
select MEMBER_ID, MEMBER_NAME, GENDER, DATE_OF_BIRTH
from MEMBER_PROFILE
where TLNO is not null and month(DATE_OF_BIRTH) = 3 and GENDER = 'W' 
order by MEMBER_ID;

# 문제20 연도 별 평균 미세먼지 농도 조회하기
# 오답노트: 아니 왜 자꾸 조건을 빠뜨리는거야 수원 지역이라고!!
# 계속 명사 앞에 붙은 한정어/수식어를 조건에서 빠뜨리는 것 같으니 그 부분 유의하자.
select  year(YM) as 'YEAR', 
        round(avg(PM_VAL1), 2) as 'PM10', 
        round(avg(PM_VAL2), 2) as 'PM2.5'
from AIR_POLLUTION
where location2 = '수원'
group by year(YM)
order by YEAR asc;

# 문제21 물고기 종류 별 잡은 수 구하기
[풀이 1]
select  count(*) as FISH_COUNT, FISH_NAME as FISH_NAME
from FISH_INFO
join FISH_NAME_INFO
using(FISH_TYPE)
group by FISH_TYPE
order by FISH_COUNT desc;

# 문제22 월별 잡은 물고기 수 구하기
[풀이 1]
select  count(*) as FISH_COUNT,
        month(TIME) as MONTH
from FISH_INFO
group by month(TIME)
order by MONTH;

# 문제23 가격대 별 상품 개수 구하기
# 오답노트: floor() 함수를 몰라서 못 풀었다.
# floor(x)는 x보다 작거나 같은 가장 큰 정수 반환하는 함수다. 예를 들어 floor(3.7)이면 3.7보다 작은 가장 큰 정수는 3이다.
# 참고로 x가 음수면 더 작은 쪽으로 끌려 간다. 이게 무슨 말이냐면, floor(-3.7)이면 -3이 아니라 -4라는 것이다. (-3.7보다 작거나 같은 가장 큰 정수는 -4다.)
# 그리고 가격대를 구할 때는 "floor(값/단위) * 단위" 패턴을 익혀두면 좋다.
[풀이 1]
select  (floor(PRICE/10000) * 10000) as PRICE_GROUP,
        count(*) as PRODUCTS
from PRODUCT
group by floor(PRICE/10000)
order by PRICE_GROUP;

# 문제24 ROOT 아이템 구하기
[풀이 1]
select i.ITEM_ID, i.ITEM_NAME
from ITEM_INFO as i
join ITEM_TREE as t
using(ITEM_ID)
where PARENT_ITEM_ID is null
order by ITEM_ID;

# 문제25 루시와 엘라 찾기
[풀이 1]
select ANIMAL_ID, NAME, SEX_UPON_INTAKE
from ANIMAL_INS
where name in('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty');

# 문제26 조건에 부합하는 중고거래 상태 조회하기
[풀이 1]
select BOARD_ID, WRITER_ID, TITLE, PRICE, 
        case
            when STATUS = 'SALE' then '판매중'
            when STATUS = 'RESERVED' then '예약중'
            else '거래완료'
        end as STATUS
from USED_GOODS_BOARD
where CREATED_DATE = '2022-10-5'
order by BOARD_ID desc;

# 문제27 조건에 맞는 사원 정보 조회하기
[오답]
select  max(t.s) as SCORE, t.EMP_NO, t.EMP_NAME, t.POSITION, [t.EMAIL](http://t.EMAIL)
from (
    select sum(SCORE) as s, EMP_NO, EMP_NAME, POSITION, EMAIL
    from HR_EMPLOYEES
    join HR_GRADE
    using(EMP_NO)
    where YEAR = '2022'
    group by EMP_NO
) t;
# 이렇게 하면 평가 점수가 가장 높은 사원들의 점수는 잘 가져오는데 나머지 컬럼들은 평가 점수가 가장 높은 사원의 정보가 아닌 랜덤한 정보들을 가져오게 된다.
# 집계 컬럼과 비집계 컬럼을 같이 쓰는 걸 항상 주의해야 한다.

# 아래 해답 코드에서도 group by 뒤에 비집계 컬럼 다 넣어줘야 select에서 쓸 수 있다.
# mysql은 유도리 있게 하지만 oracleDB 같은 건 거부 당한다. 
# select에 쓸 비집계 컬럼은 group by에 넣어주는게 원칙적으로 맞다.
[풀이 1]
select sum(g.SCORE) as SCORE, e.EMP_NO, e.EMP_NAME, e.POSITION, e.EMAIL
from HR_EMPLOYEES as e
join HR_GRADE as g using(EMP_NO)
where YEAR = 2022
group by e.EMP_NO, e.EMP_NAME, e.POSITION, e.EMAIL
having sum(g.SCORE) = (
                        select max(year_total)
                        from(
                            select sum(SCORE) as year_total
                            from HR_GRADE
                            where YEAR = 2022
                            group by EMP_NO
                        ) sub
                    );

# 문제28 특정 물고기를 잡은 총 수 구하기
# 오답노트: 예시에서 BASS가 0이고 SNAPPER가 1이라고 해서 채점 서버에서도 그럴 거란 보장이 없다.
# 따라서 직접 테이블을 조인하고 FISH_NAME으로 필터링하는게 맞다.
[풀이 1]
select count(FISH_TYPE) as FISH_COUNT
from FISH_INFO
join FISH_NAME_INFO using(FISH_TYPE)
where FISH_NAME IN ('BASS', 'SNAPPER');

# 문제29 자동차 평균 대여 기간 구하기
# 오답노트: 날짜 간격 구하는 거잖아... +1 왜 안 해줬지?
[풀이 1]
select CAR_ID, round(avg(datediff), 1) as AVERAGE_DURATION
from (
        select CAR_ID, datediff(END_DATE, START_DATE + 1) as datediff
        from CAR_RENTAL_COMPANY_RENTAL_HISTORY
    ) sub
group by CAR_ID
having avg(datediff) >= 7
order by AVERAGE_DURATION desc, CAR_ID desc;

[풀이 2]
select CAR_ID, round(avg(datediff(END_DATE, START_DATE) + 1), 1) as AVERAGE_DURATION
from CAR_RENTAL_COMPANY_RENTAL_HISTORY
group by CAR_ID
having avg(datediff(END_DATE, START_DATE) + 1) >= 7
order by AVERAGE_DURATION desc, CAR_ID desc;


# 문제30 재구매가 일어난 상품과 회원 리스트 구하기
[풀이 1]
select USER_ID, PRODUCT_ID
from ONLINE_SALE
group by USER_ID, PRODUCT_ID
having count(*) >= 2
order by USER_ID asc, PRODUCT_ID desc;

# 문제31 노선별 평균 역 사이 거리 조회하기
# 오답노트: cancat으로 km 달아주면 반환값은 문자열이 되기 때문에 order by를 TOTAL_DISTANCE 기준으로 하면 사전식 정렬을 한다.
# 따라서 문자열이 되기 전인 round(sum(D_BETWEEN_DIST), 1)를 기준으로 정렬해야 제대로 정렬된다.
[풀이 1]
select  ROUTE,
        concat(round(sum(D_BETWEEN_DIST), 1), 'km') as TOTAL_DISTANCE,
        concat(round(avg(D_BETWEEN_DIST), 2), 'km') as AVERAGE_DISTANCE
from SUBWAY_DISTANCE
group by ROUTE
order by sum(D_BETWEEN_DIST) desc;

# 문제32 분기별 분화된 대장균의 개체 수 구하기
# 오답노트: 왜 sum을 쓴 거지?
[풀이 1]
select  concat(quarter(DIFFERENTIATION_DATE), 'Q') as QUARTER, 
        count(ID) as ECOLI_COUNT
from ECOLI_DATA
group by quarter(DIFFERENTIATION_DATE)
order by quarter(DIFFERENTIATION_DATE) asc;

# 문제33 업그레이드 된 아이템 구하기
# 팁: 조인이 아직 익숙하지 않아서 서브쿼리로 우회했는데, 부모 아이템의 정보가 알고 싶으면 옆에 이어 붙이고, 자식 아이템의 정보가 필요하면 또 조인해서 붙이면 된다. 옆에 붙이는게 조인의 본질이다.
[풀이 1]
select  t.ITEM_ID,
        (select ITEM_NAME from ITEM_INFO where ITEM_ID=t.ITEM_ID) as ITEM_NAME,
        (select RARITY from ITEM_INFO where ITEM_ID=t.ITEM_ID) as RARITY
from ITEM_INFO as i
join ITEM_TREE as t
on i.ITEM_ID = t.PARENT_ITEM_ID
where i.RARITY = 'RARE'
order by t.ITEM_ID desc;

[풀이 2]
select  child.ITEM_ID, child.ITEM_NAME, child.RARITY
from ITEM_TREE tree
join ITEM_INFO parent on tree.PARENT_ITEM_ID = parent.ITEM_ID
join ITEM_INFO child on tree.ITEM_ID = child.ITEM_ID
where parent.RARITY = 'RARE'
order by child.ITEM_ID desc;

# 문제34 연도별 대장균 크기의 편차 구하기
[풀이 1]
select sub.YEAR, (sub.MAX_SIZE - SIZE_OF_COLONY) as YEAR_DEV, ID
from (
        select year(DIFFERENTIATION_DATE) as YEAR, max(SIZE_OF_COLONY) as MAX_SIZE
        from ECOLI_DATA
        group by year(DIFFERENTIATION_DATE)
    ) sub
join ECOLI_DATA on sub.YEAR = year(DIFFERENTIATION_DATE)
order by sub.YEAR asc, YEAR_DEV asc;

# 문제35 조건에 맞는 개발자 찾기
# 오답노트: join이 항상 두 테이블의 공통 컬럼이 존재해야 하는 것은 아니다.
# 동등 비교가 안 돼도 두 테이블의 컬럼 사이에 TRUE/FALSE를 만들어내는 어떤 표현식이든 ON에 들어갈 수 있다.
# 그리고 이 문제는 exists가 더 자연스럽다. 조인할 경우에는 조건에 맞는게 두 번 생겨서 distinct로 중복 제거해야 한다.
[풀이 1]
select d.ID, d.EMAIL, d.FIRST_NAME, d.LAST_NAME
from DEVELOPERS d
where exists(
                select 1
                from SKILLCODES s
                where name IN('Python', 'C#') AND d.SKILL_CODE & s.CODE > 0
            )
order by d.ID;

[풀이 2]
select DISTINCT d.ID, d.EMAIL, d.FIRST_NAME, d.LAST_NAME
from DEVELOPERS d
join (
        select CODE
        from SKILLCODES
        where NAME in('Python', 'C#')
    ) s on d.SKILL_CODE & s.CODE > 0
order by d.ID;

[풀이 3]
SELECT DISTINCT d.ID, d.EMAIL, d.FIRST_NAME, d.LAST_NAME
FROM DEVELOPERS d
JOIN SKILLCODES s ON d.SKILL_CODE & s.CODE > 0
WHERE s.NAME IN ('Python', 'C#')
ORDER BY d.ID;

# 문제36 부모의 형질을 모두 가지는 대장균 찾기
[풀이 1]
select child.ID, child.GENOTYPE, parent.GENOTYPE
from ECOLI_DATA child
join ECOLI_DATA parent on child.PARENT_ID = parent.ID
where (child.GENOTYPE & parent.GENOTYPE) = parent.GENOTYPE
order by child.ID asc;