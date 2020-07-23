-- part1
-- question 1
CREATE TABLE AlphaCoEmp(Name VARCHAR(25) Primary Key, Title VARCHAR(20) DEFAULT NULL, Salary Number(10,2) DEFAULT 0);

INSERT INTO AlphaCoEmp (name) SELECT DISTINCT last from Staff_2020;

-- question 2
Create Table Emp_Work(name VARCHAR(25) Primary Key, Project VARCHAR(20) default NULL, Constraint FK_AlphaCo Foreign Key (name) REFERENCES AlphaCoEmp(name));

insert into Emp_Work(name) Select Name from AlphaCoEmp where REGEXP_LIKE(name,'(^[ags])','i'); 

Select Name from AlphaCoEmp where REGEXP_LIKE(name,'(^[ags])','i');

Delete from AlphaCoEmp Where name='Smith';

-- question 3
alter table Emp_Work drop constraint FK_AlphaCo;

Alter table Emp_Work add constraint FK_AlphaCo FOREIGN KEY (name)references AlphaCoEmp(name) on delete cascade;

delete from AlphaCoEmp where name='Smith';


-- part 2
-- question 4
set serveroutput on
Create or Replace Procedure DisplayMessage(message in VARCHAR)
As
BEGIN
	DBMS_OUTPUT.put_line('Hello '||message);
END;
/
Show Errors;

exec DisplayMessage('include a message');

-- question 5
-- a
Select ROUND(DBMS_RANDOM.value (10,100)) from DUAL;
-- b
select * from AlphaCoEmp;
-- c
Create or Replace Procedure setSalaries(low in INTEGER, high in INTEGER)
As
Cursor Emp_cur IS
	Select * from AlphaCoEmp;

	-- Local variables
	l_emprec Emp_cur%rowtype;
	l_salary AlphaCoEmp.salary%type;

BEGIN
	for l_emprec IN Emp_cur
	loop
		l_salary := ROUND(dbms_random.value(low,high));
		
		 update AlphaCoEmp
		 set salary = l_salary
		 where name = l_emprec.name;
		 
   END LOOP;
   commit;
END;
/
show errors;

execute setSalaries(50000, 100000);

select * from AlphaCoEmp;

-- question 6 
SELECT Salary, name FROM AlphaCoEmp WHERE Salary In (SELECT Salary FROM AlphaCoEmp WHERE Salary < 100000 AND Salary > 80000);

--question 7
Create or Replace FUNCTION getEmpSalary(p_name in VARCHAR)

Return NUMBER IS

	l_salary AlphaCoEmp.salary%type;     -- Give the data type
	
BEGIN

	Select salary into l_salary
	from AlphaCoEmp 
	WHERE name = p_name;
	
			 
   	return l_salary;
END;
/
show errors;

-- to test
Select getEmpSalary('') From Dual;

