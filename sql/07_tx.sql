-- *************************** 주의사항 :두 트랜잭션 모두 커맨드로 실행 할것!!! ***************************
USE SSAFYDB;


SELECT @@TRANSACTION_ISOLATION, @@autocommit , @@innodb_lock_wait_timeout;
SET SESSION innodb_lock_wait_timeout = 1000;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; 
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        

DROP TABLE  IF EXISTS tb_accounts;
CREATE TABLE tb_accounts(
	id int  primary key,
	balance int
);
INSERT into tb_accounts values(100,10000),(200,20000),(300,30000);

SELECT * FROM tb_accounts;

---------------------------------------------------------------------------------------
-- 고립레벨 테스트 
---------------------------------------------------------------------------------------

-- #Tx1
START TRANSACTION;
SELECT * FROM tb_accounts WHERE id >= 200;

    -- #Tx2 
    START TRANSACTION;

    update tb_accounts set balance = 22000 where id = 200;
    insert into tb_accounts values(250,25000); 


-- #Tx1
SELECT * FROM tb_accounts WHERE id >= 200;  

    -- # Tx2
    ROLLBACK; -- case1
    COMMIT;-- case2

-- # Tx1
SELECT * FROM tb_accounts WHERE id >= 200;                                              
ROLLBACK;

---------------------------------------------------------------------------------------
-- 레코드 기반의 잠금
---------------------------------------------------------------------------------------
-- # Tx1
START TRANSACTION;
SELECT * FROM tb_accounts WHERE id = 100;

    -- # Tx2
    START TRANSACTION;
    SELECT * FROM tb_accounts WHERE id = 100; 
    UPDATE tb_accounts SET balance = balance - 100 WHERE id = 100;

-- # Tx1
UPDATE tb_accounts SET balance = balance - 100 WHERE id = 200; 

    -- # Tx2
    ROLLBACK;

-- # Tx1
ROLLBACK;