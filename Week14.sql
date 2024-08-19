-- Week14
SET SERVEROUTPUT ON;
SHOW ERRORS;

-- 20장 PLSQL 서브프로그램 강의자료 문제 - 프로시저 생성하기.
-- 부서 번호를 입력받아 해당 부서에서 전체 사원의 평균 급여보다 더 많은 급여를 받는
-- 사원 정보(사원번호, 급여, 부서번호)를 출력하는 프로시저 생성하기.
CREATE OR REPLACE PROCEDURE MORE_AVG_SAL (DNO EMP.DEPTNO%TYPE)
IS
    CURSOR CUR1 IS
        SELECT EMPNO, SAL, DEPTNO
        FROM EMP
        WHERE DEPTNO = DNO
            AND SAL > (SELECT AVG(SAL) FROM EMP);
BEGIN
    FOR REC IN CUR1
    LOOP
        DBMS_OUTPUT.PUT_LINE('사원번호 : '||REC.EMPNO||', 사원급여 : '||REC.SAL||', 부서번호 : '||REC.DEPTNO);
    END LOOP;
END;
/

SELECT EMPNO, SAL, DEPTNO
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

EXEC MORE_AVG_SAL(10);
EXEC MORE_AVG_SAL(20);
EXEC MORE_AVG_SAL(30);

-- 20장 PLSQL 서브프로그램 강의자료 문제 - 함수 생성하기.
-- 부서 번호를 입력받아 부서의 인원수를 반환하는 count_mem 함수 만들기.
CREATE OR REPLACE FUNCTION COUNT_MEM (DNO EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
    CNT NUMBER;
BEGIN
    SELECT COUNT(*) INTO CNT
    FROM EMP
    WHERE DEPTNO = DNO;
    RETURN CNT;
END;
/

SELECT DISTINCT DEPTNO, COUNT_MEM(DEPTNO) "부서 별 사원수"
FROM EMP;

-- 20장 PLSQL 서브프로그램 강의자료 문제 - 함수 생성하기.
-- 부서 번호를 입력 받아 부서별로 평균 급여를 구해주는 함수 만들기.
CREATE OR REPLACE FUNCTION AVG_SAL (DNO EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
    AVG_SAL_VALUE EMP.SAL%TYPE;
BEGIN
    SELECT ROUND(AVG(SAL), 2) INTO AVG_SAL_VALUE
    FROM EMP
    WHERE DEPTNO = DNO;
    RETURN AVG_SAL_VALUE;
END;
/

CREATE OR REPLACE FUNCTION AVG_SAL (DNO EMP.DEPTNO%TYPE)
RETURN VARCHAR2
IS
    AVG_SAL_VALUE VARCHAR2(30);
    CURSOR CUR IS
        SELECT TO_CHAR(ROUND(AVG(SAL), 2), 'L99,999.99') "AVG_SAL"
        FROM EMP
        WHERE DEPTNO = DNO;
BEGIN
    FOR REC IN CUR
    LOOP
        AVG_SAL_VALUE := REC.AVG_SAL;
    END LOOP;
    RETURN AVG_SAL_VALUE;
END;
/

SELECT DISTINCT DEPTNO, AVG_SAL(DEPTNO) "부서 별 평균 급여"
FROM EMP;

-- 20장 PLSQL 서브프로그램 강의자료 문제 - 트리거 생성하기.
-- NEW_EMP 테이블에 대한 삽입 이벤트에 대해 삽입한 내용(EMPNO, ENAME, SAL, 삽입 발생 날짜)를
-- EMP_LOG 테이블에 백업하는 트리거 만들기.
CREATE TABLE NEW_EMP AS SELECT EMPNO, ENAME, SAL FROM EMP;
CREATE TABLE EMP_LOG AS SELECT * FROM NEW_EMP WHERE 1 = 2;
ALTER TABLE EMP_LOG ADD(IN_DATE DATE);

CREATE OR REPLACE TRIGGER EMP_BAK
AFTER INSERT ON NEW_EMP
FOR EACH ROW
BEGIN
    INSERT INTO EMP_LOG VALUES(:NEW.EMPNO, :NEW.ENAME, :NEW.SAL, SYSDATE);
END;
/

INSERT INTO NEW_EMP VALUES(1234, 'shl', 7890);

-- 20장 PLSQL 서브프로그램 648p - 1. MAX_SAL 함수 생성하기.
CREATE OR REPLACE FUNCTION MAX_SAL (DNO EMP.DEPTNO%TYPE)
RETURN NUMBER
IS
    MAX_SAL_VALUE EMP.SAL%TYPE;
BEGIN
    SELECT MAX(SAL) INTO MAX_SAL_VALUE
    FROM EMP
    WHERE DEPTNO = DNO;
    RETURN MAX_SAL_VALUE;
END;
/

SELECT MAX_SAL(10) FROM DUAL;

SELECT DEPTNO, MAX_SAL(DEPTNO)
FROM EMP
GROUP BY DEPTNO;

-- 20장 PLSQL 서브프로그램 669p - 1. 테이블에 데이터를 입력할 수 있는 시간을 지정하는 트리거 만들기.
CREATE TABLE TAB_ORDER(
    ORD_NO NUMBER,
    ORD_NAME VARCHAR2(10),
    ORD_DATE DATE
);

CREATE OR REPLACE TRIGGER TRI_ORDER
BEFORE INSERT ON TAB_ORDER
BEGIN
    IF (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '15:00' AND '16:00') THEN
        RAISE_APPLICATION_ERROR(-20100, 'INSERT 작업을 수행할 수 없는 시간입니다.');
    END IF;
END;
/

INSERT INTO TAB_ORDER VALUES(2, 'Apple', SYSDATE);

-- 20장 PLSQL 서브프로그램 670p - 2. 테이블에 입력될 데이터 값을 지정하고 그 값 이외에는 오류를 발생시키는 트리거 만들기.
CREATE OR REPLACE TRIGGER TRI_ORDER2
BEFORE INSERT ON TAB_ORDER
FOR EACH ROW
BEGIN
    IF (:NEW.ORD_NAME) NOT IN ('Apple') THEN
        RAISE_APPLICATION_ERROR(-20200, '올바르지 않은 이름입니다.');
    END IF;
END;
/

INSERT INTO TAB_ORDER VALUES(2, 'Apple', SYSDATE);
INSERT INTO TAB_ORDER VALUES(3, 'Orange', SYSDATE); -- 오류 발생

-- 20장 PLSQL 서브프로그램 670p - 2. 테이블에 입력될 데이터 값을 지정하고 그 값 이외에는 오류를 발생시키는 트리거 만들기.
CREATE OR REPLACE TRIGGER TRI_ORDER2
BEFORE INSERT ON TAB_ORDER
FOR EACH ROW
BEGIN
    IF (:NEW.ORD_NAME) NOT IN ('Apple') THEN
        RAISE_APPLICATION_ERROR(-20200, '올바르지 않은 이름입니다.');
    END IF;
END;
/

-- 20장 PLSQL 서브프로그램 673p - 5. UPDATE 되면 기존 데이터를 백업하는 트리거 만들기.
CREATE TABLE TAB_ORDER2 AS SELECT * FROM TAB_ORDER WHERE 1 = 2;

CREATE OR REPLACE TRIGGER MOVE_DATA
BEFORE UPDATE ON TAB_ORDER
FOR EACH ROW
BEGIN
    INSERT INTO TAB_ORDER2 VALUES(:OLD.ORD_NO, :OLD.ORD_NAME, SYSDATE);
END;
/

UPDATE TAB_ORDER SET ORD_NAME = 'Banana' WHERE ORD_NO = 3;
UPDATE TAB_ORDER SET ORD_NAME = 'Orange' WHERE ORD_NO = 4;