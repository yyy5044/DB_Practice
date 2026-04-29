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

# 문제13
[풀이 1]
select MCDP_CD as '진료과코드', count(*) as '5월예약건수'
from APPOINTMENT
where APNT_YMD like '2022-05-%'
group by MCDP_CD
order by count(*), MCDP_CD;
