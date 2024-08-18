-- 3장 강의 실습문제
-- Q1. 같은 업무를 담당하는 업무 별 사원수 검색
SELECT JOB, COUNT(*) "업무 별 사원수"
FROM EMP
GROUP BY JOB;

-- Q2. 20번 부서에 속한 사원들의 업무 별 사원수와 평균 급여 검색
SELECT JOB, COUNT(*) "업무 별 사원수", ROUND(AVG(SAL), 2) "평균 급여"
FROM EMP
WHERE DEPTNO = 20
GROUP BY JOB;

-- Q3. 입사년도가 같은 입사년도별 사원수 검색
SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도", COUNT(*) "입사년도 별 사원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY')
ORDER BY 1;

-- Q4. 급여가 1000 이상인 사원들의 업무 별 사원수와 평균 급여 검색
SELECT JOB, COUNT(*) "업무 별 사원수", ROUND(AVG(SAL), 2) "평균 급여"
FROM EMP
WHERE SAL >= 1000
GROUP BY JOB
ORDER BY 1;

-- Q5. 입사년도별 사원수가 3명 이상인 입사년도와 사원수 검색
SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도", COUNT(*) "입사년도 별 사원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY') HAVING COUNT(*) >= 3
ORDER BY 1;

-- Q6. 81년도에 입사한 사원들의 평균 급여가 2000 이상인 업무명과 평균 급여 검색
SELECT JOB "업무명", ROUND(AVG(SAL), 2) "평균 급여"
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YY') = 81
GROUP BY JOB HAVING AVG(SAL) >= 2000
ORDER BY 1;

-- Q7. 급여가 3000인 사원의 급여 순위 검색 (오름차순)
SELECT RANK(3000) WITHIN GROUP(ORDER BY SAL) "급여 3000인 사원의 급여 순위"
FROM EMP;

-- Q8. 입사일자가 '81/09/08' 인 사원의 입사 순위 검색
SELECT RANK('81/09/08') WITHIN GROUP(ORDER BY HIREDATE) "입사일자 '81/09/08' 사원의 입사 순위"
FROM EMP;

-- Q9. EMPNO, ENAME, DEPTNO, SAL, 같은 부서 내 급여 순위 (내림차순)
SELECT EMPNO, ENAME, DEPTNO, SAL,
    RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)"부서 별 급여 순위"
FROM EMP;

-- Q10. 전체 사원의 급여 순위(오름차순)를 DENSE_RANK() 함수를 사용하여 검색
SELECT EMPNO, ENAME, SAL, DENSE_RANK() OVER(ORDER BY SAL DESC) "급여 순위"
FROM EMP;
