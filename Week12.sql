-- Week12
-- 9장 View - 각 부서에서 해당 부서의 평균 급여보다 적게 받는 사원을 검색.
SELECT V.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL,
    ROUND(V.AVG_SAL, 2) "AVG_SAL",
    DENSE_RANK() OVER(PARTITION BY V.DEPTNO ORDER BY E.SAL DESC) "SAL_RANK"
FROM (SELECT DEPTNO, AVG(SAL) "AVG_SAL"
    FROM EMP
    GROUP BY DEPTNO) V, EMP E, DEPT D
WHERE V.DEPTNO = E.DEPTNO AND E.DEPTNO = D.DEPTNO AND E.SAL < V.AVG_SAL;

-- 15장 PLSQL - 528p 예제
SET SERVEROUTPUT ON;
SHOW ERRORS;

DECLARE
    V_EMPNO EMP.EMPNO%TYPE;
    V_ENAME EMP.ENAME%TYPE;
BEGIN
    SELECT EMPNO, ENAME INTO V_EMPNO, V_ENAME
    FROM EMP
    WHERE EMPNO = &EMPNO;
    DBMS_OUTPUT.PUT_LINE(V_EMPNO||' - This Member''s name is '||V_ENAME);
END;
/

-- 15장 PLSQL - 528p 예제에서 급여도 출력되도록 수정.
DECLARE
    V_EMPNO EMP.EMPNO%TYPE;
    V_ENAME EMP.ENAME%TYPE;
    V_SAL EMP.SAL%TYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL INTO V_EMPNO, V_ENAME, V_SAL
    FROM EMP
    WHERE EMPNO = &EMPNO;
    DBMS_OUTPUT.PUT_LINE('사원 번호 : '||V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원 이름 : '||V_ENAME);
    DBMS_OUTPUT.PUT_LINE('사원 급여 : '||V_SAL);
END;
/

-- 15장 PLSQL 550p 예제 - ROWTYPE 사용하기
DECLARE
    VROW DEPT%ROWTYPE;
BEGIN
    SELECT * INTO VROW
    FROM DEPT
    WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE(VROW.DEPTNO||' / '||VROW.DNAME||' / '||VROW.LOC);
END;
/

-- 15장 PLSQL 552p 예제 - ROWTYPE 사용하여 다른 테이블에 데이터 삽입하기
CREATE TABLE T_ROWTYPE1 (
    NO NUMBER,
    NAME VARCHAR2(10),
    HIREDATE DATE
);

CREATE TABLE T_ROWTYPE2
AS SELECT * FROM T_ROWTYPE1;

/*
INSERT INTO T_ROWTYPE1 VALUES(10, 'APPLE', SYSDATE);
INSERT INTO T_ROWTYPE1 VALUES(20, 'BANANA', SYSDATE);
INSERT INTO T_ROWTYPE1 VALUES(30, 'BERRY', SYSDATE);
COMMIT;
*/

DECLARE
    VRECORD T_ROWTYPE1%ROWTYPE;
BEGIN
    SELECT * INTO VRECORD
    FROM T_ROWTYPE1
    WHERE NO = 10;
    
    INSERT INTO T_ROWTYPE2 VALUES VRECORD;
END;
/

/*
TRUNCATE TABLE T_ROWTYPE2;
ALTER TABLE T_ROWTYPE2 ADD(LOC VARCHAR2(10));
*/

DECLARE
    VRECORD T_ROWTYPE1%ROWTYPE;
BEGIN
    SELECT * INTO VRECORD
    FROM T_ROWTYPE1
    WHERE NO = 10;
    
    INSERT INTO T_ROWTYPE2 VALUES(VRECORD.NO, VRECORD.NAME, VRECORD.HIREDATE, 'Seoul');    
END;
/

-- 15장 PLSQL 553p 예제 - ROWTYPE 사용하여 데이터 변경하기
DECLARE
    VRECORD T_ROWTYPE2%ROWTYPE;
BEGIN    
    SELECT * INTO VRECORD
    FROM T_ROWTYPE1
    WHERE NO = 10;
    
    VRECORD.NAME := 'ORANGE';
    
    UPDATE T_ROWTYPE2
    SET NAME = VRECORD.NAME
    WHERE NO = 10;
END;
/
