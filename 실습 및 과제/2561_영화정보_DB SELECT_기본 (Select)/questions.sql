-- 아래부터 문제 
use ssafy_movie;

# 1. movie 테이블 내의 전체 data를 조회하시오.
SELECT ___
FROM _____;

# 2. movie 테이블 내의 모든 title을 조회하시오.
SELECT _____
FROM _____;

# 3. 제목이 '이터널스' 인 영화 정보를 조회하시오.
SELECT *
FROM movie
WHERE _____ = '______';

# 4. 제목이 '해리' 로 시작하는 영화 정보를 조회하시오.
SELECT *
FROM movie
WHERE Title _____ '____';

# 5. 제목에 '포터' 단어가 포함되는 영화 정보를 조회하시오.
SELECT *
FROM movie
WHERE Title _____ '______';
    
# 6. ID가 1000 또는 1004 인 영화의 제목을 조회하시오.
SELECT Title
FROM movie
WHERE ID = ____ __ ID = ____;

# 7. 'touppercase' 를 모두 대문자로 바꿔서 출력하시오. *****
SELECT _____('touppercase') FROM DUAL;

# 8. '해리포터와' '마법사의 돌' 두 단어를 연결해서 출력하시오. *****
SELECT ______('해리포터와', '마법사의 돌') FROM DUAL;

# 9. 개봉일이 2018년 1월 1일 이후인 영화들의 제목의 맨 앞 두글자만 조회하시오. *****
SELECT ______(Title, _, _)
FROM movie
WHERE ReleaseDate __ '2018-01-01';

# 10. 제목에 '해리' 가 포함된 영화들의 제목의 '해리포터' 부분을 '말포이'로 바꾼후 조회하시오. *****
SELECT _______(Title, '______', '____')
FROM movie
WHERE Title _____ '%____%';

# 11. 원주율 (pi) 를 소수점 둘째 자리까지 반올림하여 출력하시오.
SELECT _____(__(), _) FROM DUAL;
