# 1번
# 오답노트1: 100일 지난 후는 어떻게 하지? -> INTERVAL N (DAY | MONTH | YEAR | HOUR) 이렇게.
# 오답노트2: 년월일만 나타내고 싶으면? -> date()로 감싸거나 now()는 curdate()로 대체할 수도 있다.
select curdate() as 오늘, datediff(now(), '2026-01-01') as "올해 지난 날", date(date_add(now(), interval 100 day)) as "100일 후";

# 2번
select name, Continent, LifeExpectancy, case
											when LifeExpectancy > 80 then '장수국가'
											when LifeExpectancy > 60 then '일반국가'
											else '단명국가'
										end as 구분
from country
where Continent = 'Asia' and LifeExpectancy is not null
order by LifeExpectancy;

# 3번
select name, gnp, gnpold, (gnp-gnpold) as "gnp 향상"
from country
order by name;

# 4번
# 오답노트1: weekday()는 안에 date를 넣으면 월화수목금토일 여부를 0123456으로 반환한다.
select weekday('2020-05-05'), case
									when weekday('2020-05-05') < 5 then '행복'
									else '불행'
                                end as "행복여부";

# 5번
# 리마인드: *은 null까지 세고, 컬럼명만 쓰면 null은 안 센다.
select count(*) as 전체, count(IndepYear) as "독립 연도 보유"
from country;

# 6번
select round(sum(LifeExpectancy), 2) as 합계, round(avg(LifeExpectancy), 2) as 평균, round(max(LifeExpectancy), 2) as 최대, round(min(LifeExpectancy), 2) as 최소
from country;

# 7번
select Continent, count(*) as "국가 수", sum(Population) as "인구 합"
from country
group by continent
order by count(*) desc;

# 8번
select continent, sum(SurfaceArea) as "표면적 합"
from country
group by continent
order by sum(surfacearea) desc
limit 3;

# 9번
select continent, sum(gnp) as "gnp 합"
from country
where Population > 50000000
group by continent
order by sum(gnp) asc;

# 10번
select continent, sum(gnp) as "gnp 합"
from country
where population > 50000000
group by continent
having sum(GNP) > 5000000
order by sum(gnp) asc;

# 11번
select IndepYear, count(*)
from country
group by indepyear
having count(*) >= 10 and IndepYear is not null;

# 12번
# 오답노트: 걍 푸는 방법을 몰랐음 푸는 방법은 세 가지 정도 나온다. 그중 윈도우함수는 아직 안 배웠으니 스킵한다.
# 풀이 1
select 
	Continent, 
	name, 
    gnp, 
    (select avg(gnp) from country) as "전세계 평균",
    (select avg(gnp) from country as c2 where c2.continent = c1.continent) as "대륙 평균"
from country as c1
order by Continent;

# 풀이 2
select 	c1.Continent, 
		name, 
        gnp, 
        (select avg(gnp) from country) as "전세계 평균",
        c2.a as "대륙 평균"
from country as c1
join (
	select Continent, avg(gnp) as a
    from country
    group by Continent
    ) as c2 on c1.continent = c2.continent
order by c1.continent;


