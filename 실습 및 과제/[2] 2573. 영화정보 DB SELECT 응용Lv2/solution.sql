# 1번
SELECT 	COUNT(*) AS "영화 수"
FROM 	MOVIE;

# 2번
SELECT 	AVG(RunningTime) AS 평균
FROM 	movie;

# 3번
SELECT 	SUM(RunningTime) AS 총합
FROM 	movie;

# 4번
SELECT	ROUND(AVG(RunningTime), 2) AS "포터 평균"
FROM	movie
WHERE 	Title LIKE '%포터%';

# 5번
SELECT CinemaCode, count(*) AS 수
FROM movie
GROUP BY cinemacode;

# 6번
select CinemaCode, min(releasedate) as 날짜
from movie
group by cinemacode;

# 7번
select CinemaCode, max(RunningTime) as 최대
from movie
group by cinemacode;

# 8번
SELECT 	CinemaCode, AVG(RunningTime) AS "평균" 
FROM 	movie
GROUP BY CinemaCode
HAVING AVG(RunningTime) >= 150;

# 9번
select CinemaCode, sum(runningtime) as 합
from movie
group by cinemacode
having sum(runningtime) >= 300;

# 10번
select cinemacode, avg(RunningTime) as 평균, sum(RunningTime) as 합
from movie
group by cinemacode
having avg(runningtime) >= 150 and sum(runningtime) >= 300;