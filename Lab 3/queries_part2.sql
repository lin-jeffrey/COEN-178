SELECT deptid AS deptno, count(*) AS empcount FROM L_EMP GROUP BY deptid;
SELECT deptno, deptname, empcount FROM (SELECT deptid AS deptno, count(*) AS empcount FROM L_EMP GROUP BY deptid), L_DEPT WHERE deptno = L_DEPT.deptid;
SELECT deptno, deptname, empcount FROM (SELECT deptid AS deptno, count(*) AS empcount FROM L_EMP GROUP BY deptid), L_DEPT WHERE deptno = L_DEPT.deptid ORDER BY empcount ASC;
SELECT deptid, max(count(*)) from L_EMP GROUP BY deptid;
SELECT deptid FROM L_EMP GROUP BY deptid HAVING count(*) = ANY(SELECT count(*) FROM L_EMP GROUP BY deptid);
SELECT deptname FROM L_DEPT WHERE deptid = (SELECT deptid FROM L_EMP GROUP BY deptid HAVING count(*) = (SELECT MAX(count(*)) FROM L_EMP GROUP BY deptid));
SELECT * FROM L_EMP NATURAL JOIN L_DEPT;
SELECT L_EMP.deptid, empno, empname, deptname FROM L_EMP, L_DEPT WHERE L_EMP.deptid = L_DEPT.deptid;
