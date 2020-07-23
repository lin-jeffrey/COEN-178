//Question 0
create table EMP7(empid varchar(5) Primary Key, empName varchar(20), deptId varchar(5),salary NUMBER (10,2));
Create table Project7 (projectID varchar(5) Primary Key, title varchar(20), budget NUMBER(10,2),startDate Date,endDate Date, managerId varchar(5));
Create table EMP_Project (projectID varchar(5),empid varchar(5), commission NUMBER(10,2));

insert into EMP7 values ('e1','J.Smith','d1',100000);
insert into EMP7 values ('e2','M.Jones','d1',120000);
insert into EMP7 values ('e3','D.Clark','d2',200000);
insert into  Project7 values ('pj1','Research', 1000000, '10-Jan-2019','20-Feb-2020','e1');
insert into  Project7 values ('pj2','Research', 100000, '10-Feb-2019','20-Apr-2019','e2');
insert into  EMP_Project values ('pj2','e2',10000);

insert into EMP7 values ('e4','J.Lin','d2',130000);
insert into EMP7 values ('e5','E.Paek','d1',180000);
insert into  Project7 values ('pj3','Research', 500000, '28-Apr-2019','20-Feb-2020','e3');
insert into  Project7 values ('pj4','Research', 250000, '11-Nov-2019','20-Apr-2020','e4');
insert into  EMP_Project values ('pj1','e4',30000);
insert into  EMP_Project values ('pj3','e1',20000);

//Question 1
CREATE VIEW CurrentProjects AS SELECT projectid, title, managerid FROM Project7 WHERE endDate > sysdate;
CREATE VIEW PastProjects AS SELECT title, managerid FROM Project7 WHERE endDate < sysdate;
Select * From CurrentProjects;
Select * From PastProjects;

insert into CurrentProjects values ('p99','Testing','e2');
Select * From Project7;

CREATE VIEW ManagedProjects AS SELECT Project7.projectID AS Project_Title, EMP7.empName AS ManagerName FROM EMP7, Project7 WHERE EMP7.empid = Project7.managerId;
Select * From ManagedProjects;

//Question 4
Create table ItemOrder (orderNo VARCHAR(5) Primary key, qty Integer);

CREATE OR REPLACE TRIGGER ItemOrder_after_insert_trig
AFTER INSERT
   ON ItemOrder
   FOR EACH ROW

DECLARE
   v_quantity Integer;

BEGIN
   SELECT qty
   INTO v_quantity
   FROM ItemOrder
   WHERE orderNo = 'o1';

END;
/
Show Errors;

//Question 5

CREATE TABLE Course
(
    courseNo   INTEGER PRIMARY KEY,
    courseName VARCHAR(20)
);
CREATE TABLE Course_Prereq
(
    courseNo   INTEGER ,
    prereqNo Integer,
	Foreign Key(prereqNo) references Course (courseNo)
);

insert into Course values (10,'C++');
insert into Course values (11,'Java');
insert into Course values (12,'Python');
insert into Course values (121,'Web');
insert into Course values (133,'Software Eng');

CREATE OR REPLACE TRIGGER LimitTest
    BEFORE INSERT OR UPDATE ON Course_Prereq
    FOR EACH ROW  -- A row level trigger
DECLARE
     v_MAX_PREREQS CONSTANT INTEGER := 2;
     v_CurNum INTEGER;	
BEGIN
	BEGIN
		SELECT COUNT(*) INTO v_CurNum FROM Course_Prereq 
		WHERE courseNo = :new.CourseNo Group by courseNo;
		EXCEPTION
-- Before you enter the first row, no data is found
			WHEN no_data_found THEN
                 DBMS_OUTPUT.put_line('not found');
				 v_CurNum := 0;
	END;	
	if v_curNum > 0 THEN
		IF v_CurNum + 1 > v_MAX_PREREQS THEN
			RAISE_APPLICATION_ERROR(-20000,'Only 2 prereqs for course');
		END IF;
	END IF;	
END;
/
SHOW ERRORS;

insert into Course_Prereq values (121,11);

insert into Course_Prereq values (121,10);

Select * FROM Course_PreReq;

insert into Course_Prereq values (121,12);




