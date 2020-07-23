SELECT MAX(salary) AS Maximum_Salary FROM staff_2020;
SELECT MIN(salary) AS Minimum_Salary FROM staff_2020;
SELECT first || last AS Name FROM staff_2020 WHERE last LIKE 'Ki%';
SELECT first || last AS Name FROM staff_2020 WHERE salary >= ALL(SELECT salary FROM staff_2020);
SELECT title FROM staff_2020 WHERE salary >= (SELECT MAX(salary) FROM staff_2020);


