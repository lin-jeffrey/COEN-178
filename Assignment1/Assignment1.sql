
CREATE TABLE MyExpenses(
CDATE	DATE,
FOOD	NUMERIC(5,2),
COMMUTE	NUMERIC(5,2),
MISC	NUMERIC(5,2)
);

insert into MyExpenses values ('21-OCT-19',30.00,7.00,13.00);
insert into MyExpenses values ('23-OCT-19',20.00,2.00,18.00);
insert into MyExpenses values ('08-NOV-03',23.00,3.00,16.00);
insert into MyExpenses values ('30-DEC-14',43.00,6.00,12.00);
insert into MyExpenses values ('23-FEB-30',12.00,5.00,23.00);
insert into MyExpenses values ('26-JAN-24',28.00,8.00,19.00);


Create or Replace Function getExpensesByDate(v_date In Date)
Return Number 
IS
l_food MyExpenses.food%type; 
l_commute MyExpenses.commute%type; 
l_misc MyExpenses.misc%type; 
l_totalExpenses Integer;

BEGIN
	Select food into l_food from MyExpenses where cdate = v_date;
	Select commute into l_commute from MyExpenses where cdate = v_date;
	Select misc into l_misc from MyExpenses where cdate = v_date;
	l_totalExpenses := l_food + l_commute + l_misc;
	return l_totalExpenses;
END;
/ 
Show Errors;

Create or Replace Function getExpensesBetweenDates(v_fromdate In Date, v_toDate In Date)
Return Number
IS
l_food MyExpenses.food%type; 
l_commute MyExpenses.commute%type; 
l_misc MyExpenses.misc%type; 
l_totalExpenses Integer;

BEGIN
	Select sum(food) into l_food from MyExpenses where cdate >= v_fromdate and cdate <= v_todate;
	Select sum(commute) into l_commute from MyExpenses where cdate >= v_fromdate and cdate <= v_todate;
	Select sum(misc) into l_misc from MyExpenses where cdate >= v_fromdate and cdate <= v_todate;
	l_totalExpenses := l_food + l_commute + l_misc;
	return l_totalExpenses;
END;
/ 
Show Errors;

