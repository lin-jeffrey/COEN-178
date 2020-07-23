--Question 1

Create or Replace Procedure assignJobTitlesAndSalaries
As
type titlesList IS VARRAY(6) OF AlphaCoEmp.title%type;
type salaryList IS VARRAY(6) of AlphaCoEmp.salary%type;
v_titles titlesList;
v_salaries salaryList;
Cursor Emp_cur IS
Select * from AlphaCoEmp;
l_emprec Emp_cur % rowtype;
l_title AlphaCoEmp.title%type;
l_salary AlphaCoEmp.salary%type;
l_randomnumber INTEGER := 1;
l_randomnumber2 INTEGER := 1;

BEGIN
--/* Titles are stored in the v_titles array  */
--/* Salaries for each title are stored in the v_salaries array.
--The salary of v_titles[0] title is at v_salaries[0].
--*/

--/* Added secretary */
v_titles := titlesList('advisor', 'director', 'assistant', 'manager', 'supervisor', 'secretary');

--/* Added 85000 */
v_salaries := salaryList(130000, 100000, 600000, 500000, 800000, 85000);

--/* use a for loop to iterate through the set */
for l_emprec IN Emp_cur
LOOP
--/* We get a random number between 1-6 both inclusive */
l_randomnumber := dbms_random.value(1,6);
 
--/* Get the title using the random value as the index into the v_tiles array */
l_title := v_titles(l_randomnumber);


--/* Get the salary using the same random value as the index into the v_salaries array */
l_salary := v_salaries(l_randomnumber);

--/*Update the employee title and salary using the l_title and l_salary */
update AlphaCoEmp
set title = l_title
where name = l_emprec.name;  

update AlphaCoEmp
set salary = l_salary
where name = l_emprec.name;


END LOOP;

commit;
END;
/
Show errors; 

--Question 2

Create or Replace Function calcSalaryRaise( p_name in AlphaCoEmp.name%type, percentRaise IN Integer) 
RETURN NUMBER 
IS 
l_salary AlphaCoEmp.salary%type; 
l_raise AlphaCoEmp.salary%type; 
l_cnt Integer; 

BEGIN 
	-- Find the current salary of p_name from AlphaCoEMP table. 
	Select salary into l_salary from AlphaCoEmp 
	where UPPER(name) = UPPER(p_name); 
	-- Calculate the raise amount 
	l_raise := l_salary * (percentRaise/100); 

    /* return a value from the function */
	return l_raise;

EXCEPTION 
   WHEN NO_DATA_FOUND THEN 
      dbms_output.put_line('No employee with given name found!');
	  --return 0;
   WHEN others THEN 
      dbms_output.put_line('Error!');
END; 
/ 
Show Errors;

--Question 3

Create or Replace Function countByTitle(p_title in AlphaCoEmp.title%type) 
RETURN NUMBER IS 
	l_cnt Integer; 
BEGIN
	--/* Complete the query below */ 
	Select count(*) into l_cnt from AlphaCoEmp 
	Group by title
	Having title = p_title;

	return l_cnt; 
END; 
/ 
show errors;

select countByTitle('director') from Dual; 
select countByTitle('advisor') from Dual;

--Question 4

CREATE or REPLACE procedure saveCountByTitle (p_title in AlphaCoEmp.title%type)
AS 
	l_title_cnt integer := 0; 
BEGIN 
	l_title_cnt := countByTitle(p_title); 

	delete from EmpStats; -- Any previously loaded data is deleted 
	--/* inserting count of employees with title, ‘advisor’.*/ 
	insert into EmpStats values (p_title,l_title_cnt,SYSDATE);
END; 
/ 
Show errors; 

--Question 5

CREATE or REPLACE function countBySalaryRange(lowEnd in AlphaCoEmp.salary%type, highEnd in AlphaCoEmp.salary%type)
RETURN NUMBER IS
l_employees AlphaCoEmp.name%type;
BEGIN
Select count(*) into l_employees from AlphaCoEmp
Where salary >= lowEnd AND salary <= highEnd;
return l_employees;
END;
/
Show Errors;

Select countBySalaryRange(30000,750000) From Dual;

Select countBySalaryRange(30000,750000) EmployeesWithinSalaryRange From Dual;



