--Question 1

CREATE or REPLACE TRIGGER display_customer_trig
   AFTER  INSERT on BankCust_6
   FOR EACH ROW	
BEGIN    
	DBMS_OUTPUT.PUT_LINE('From Trigger '||'Customer NO: '||:new.custno||' Customer Name: '||:new.custname||' Customer City: ' ||:new.city);
END;
/
show errors;

--Question 2

Create Or Replace Trigger Acct_Cust_Trig
AFTER INSERT ON Accounts_6
FOR EACH ROW	
BEGIN	
/*If the custno is already in the Totals_6 table, the update will succeed */
	update totals_6
	set totalAmount = totalAmount + :new.amount
	where custno = :new.custno;	
		
/*If the custno is not in the Totals_6 table, we insert a row into
Totals_6 table. Complete the missing part in the subquery */
insert into totals_6 (select :new.custno, :new.amount from dual
	where not exists (select * from TOTALS_6 where custno=:new.custno));							
END;
/
Show Errors;

--Question 4

Create Or Replace Trigger Acct_Cust_Trig
AFTER INSERT OR UPDATE ON Accounts_6
FOR EACH ROW	
BEGIN	
	If inserting then
		update totals_6
		set totalAmount = totalAmount + :new.amount
		where custno = :new.custno;	
		
		insert into totals_6 (select :new.custno, :new.amount from dual
	where not exists (select * from TOTALS_6 where custno=:new.custno));
	END IF;
	if updating then
	-- If we are updating we want to correctly set the totalAmount 
		--to the new amount that may be >= or < old amount
		--Complete the query */ 
		
		update totals_6
		set totalAmount = totalAmount + :new.amount	
		where custno = :new.custno;		
	end if; 
END;
/
Show Errors;

--Question 5

Create Or Replace Trigger NoUpdatePK_trig
After UPDATE ON BANKCUST_6
For each row
BEGIN
 if updating ('custno')  then
	raise_application_error (-20999,'Cannot update a Primary Key');	
	End if;
END;
/
show errors;

--Question 6

CREATE or Replace TRIGGER CheckPrereq_Trig

    AFTER insert ON M_CourseRegister

    FOR EACH ROW
	
	DECLARE
		--/* local variables you will need */

		l_cnt Integer;
		l_no Integer;

	BEGIN
		--/* Check if the course has a prereq.in M_PrereqCourse table
		--	If it does not have a prerequisite, it will 
		--	Have a null for prereq. Complete this query

		Select Count(prereq) into l_no 
		from M_PrereqCourse 
		WHERE CourseNo = :NEW.courseno 
			And prereq IS NOT NULL;
		--/* prereq not null. */
	
		--/* If there are prereqs */
		IF  l_no > 0 THEN

			Select Count(prereq) into l_cnt 
			from M_PrereqCourse 
			WHERE CourseNo=:NEW.courseno
				AND 
			prereq NOT IN (Select courseno from 
			M_CoursesTaken where stNo = :NEW.stNo);



			IF l_cnt > 0 THEN
				--/* There are prereqs not taken by the student*/

				DBMS_OUTPUT.PUT_LINE ('No prereq');
				RAISE_APPLICATION_ERROR(-20010,'prereqs not done');
			END IF;
		END IF;

	--	/* If prereqs have been taken by the student, registration 
	--	Is successful and the new course is entered into M_CoursesTaken table.
	insert into M_CoursesTaken values (:NEW.stNo,:NEW.CourseNo);
	
	END CheckPrereq_Trig;
	
	/
	Show Errors;

insert into M_Student values ('s1','smith');
insert into M_Student values ('s2','jones');

insert into M_course values ('c1',4);
insert into M_Course values ('c2',2);
insert into M_course values ('c3',4);
insert into M_Course values ('c4',2);

insert into M_PrereqCourse values('c3','c1');
insert into M_PrereqCourse values('c4','c1');
insert into M_PrereqCourse values('c4','c2');
insert into M_PrereqCourse values('c1',NULL);
insert into M_PrereqCourse values('c2',NULL);

insert into M_CourseRegister values ('s1','c1');

insert into M_courseRegister values('s1','c3');

Select * from M_CoursesTaken;

insert into M_courseRegister values('s1','c4');

Select * from M_CoursesTaken;

insert into M_courseRegister values('s1','c2');

insert into M_courseRegister values('s1','c4');

Select * from M_CoursesTaken;

insert into M_courseRegister values('s2','c4');	

