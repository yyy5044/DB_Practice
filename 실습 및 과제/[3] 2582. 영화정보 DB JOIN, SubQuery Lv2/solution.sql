use ssafy_movie;

-- 1.    movie 테이블과 cinema 테이블을 CROSS JOIN 하면 몇개의 행이 조회되는지 출력하시오.
SELECT count(*) AS '행 수'
FROM movie cross join cinema;

-- 2.    모든 영화가 어떤 cinema에서 상영중인지 알 수 있도록 영화 정보와 시네마 정보를 모두 출력하시오.
SELECT *
FROM movie
join cinema on movie.CinemaCode = cinema.CinemaCode;

-- 3.    서울에 있는 시네마에서 상영하는 영화들을 조회하시오.
SELECT *
FROM movie, cinema
WHERE movie.CinemaCode = cinema.CinemaCode
AND cinema.location = '서울';

-- 4.    광주에 있는 시네마에서 상영하는 영화가 몇개인지 조회하시오.
SELECT count(*) AS '상영 중', cinema.location
FROM movie
join cinema on movie.cinemacode = cinema.cinemacode
WHERE cinema.location = '광주';

-- 5.    cinema 이름으로 그룹핑 하여 각 시네마 마다 몇개의 영화가 상영중인지 조회하시오.
SELECT cinema.cinemaName, count(movie.id) AS '상영 중'
FROM movie
join cinema on movie.CinemaCode = cinema.cinemacode
group by cinema.cinemaName;

-- 6.    cinema 이름으로 그룹핑 하여 각 시네마 마다 몇개의 영화가 상영중인지 출력하는데 상영중인 영화가 0개인 시네마도 조회하시오.
SELECT cinema.cinemaName, count(movie.ID) AS '상영 중'
FROM movie
right join cinema on movie.CinemaCode = cinema.CinemaCode
group by cinema.cinemaName;

-- 7.    cinema 지역으로 그룹핑 하는데 상영하는 영화의 개수가 1개인 시네마의 지역들을 조회하시오. 
select count(movie.id) as '상영 중', cinema.location AS '지역'
FROM movie
join cinema on movie.CinemaCode = cinema.CinemaCode
group by cinema.Location 
having count(movie.ID) = 1;

-- 8.    영화 이름이 '이터널스' 인 영화의 상영 시간 이상인 영화 이름과 상영 시간을 출력하시오.
SELECT title, runningTime
FROM movie
WHERE runningTime >= (select runningTime
						from movie
						where title = '이터널스');
# 이터널스라는 이름이 여러 개면 안 되는 거 아닌가? 이게 왜 맞는지를 모르겠다.

-- 9.    상영 시간이 156분 이상인 영화들을 상영중인 cinema 이름을 출력하시오.
SELECT cinemaName
FROM cinema
WHERE cinemacode IN (select cinemacode
					from movie
					where runningTime >= 156);

-- 10. 상영 시간이 156분 이상인 영화들 중 제목에 '해리포터' 라는 단어를 포함하는 영화 제목과 상영시간을 출력하시오.
SELECT title, runningTime
FROM (
		select title, runningTime
		from movie
		where runningTime >= 156
		) temp
WHERE title LIKE '%해리포터%';