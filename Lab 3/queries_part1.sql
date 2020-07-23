/*exercise 1*/
SELECT first || last AS fullname FROM Staff_2020 WHERE salary >= ALL(SELECT salary FROM Staff_2020);
SELECT first || last AS fullname FROM Staff_2020 WHERE salary = (SELECT max(salary) FROM Staff_2020);
/*exercise 2*/
SELECT last, salary FROM Staff_2020 WHERE salary = (SELECT salary FROM Staff_2020 WHERE UPPER(last) = 'ZICHAL');
SELECT last, salary FROM Staff_2020 WHERE salary = ANY(SELECT salary FROM Staff_2020 WHERE UPPER(last) = 'YOUNG');
/*exercise 3*/
SELECT count(salary) AS SALARIES_100K_ABOVE FROM Staff_2020 WHERE salary >= ANY(SELECT salary FROM Staff_2020 WHERE salary > 100000);
SELECT salary, count(salary) AS SALARIES_100K_ABOVE FROM Staff_2020 WHERE salary >= ANY(SELECT salary FROM Staff_2020 WHERE salary > 100000) GROUP BY salary HAVING count(salary) >= 10;
SELECT last FROM Staff_2020 WHERE REGEXP_LIKE(last, '([aeiou])\1','i');

