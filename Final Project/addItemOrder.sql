--This procedure adds a item to the table itemorder using the parameters listed below
Create or Replace PROCEDURE addItemOrder(OrderID IN INT, addItemID IN NUMBER, addCustID IN NUMBER, DateOrdered IN DATE, NumOrdered IN NUMBER, ShippedDate IN DATE)
AS
	--Declar variables
	AvailableCopies NUMBER(10);
	CustomerType VARCHAR(10);
	ShippingFee NUMERIC(5,2);
	
BEGIN
	--Query data into variables
	SELECT NumOfCopies INTO AvailableCopies FROM ComicBook WHERE ItemID = addItemID;
	SELECT CustType INTO CustomerType FROM StoreCustomer WHERE CustID = addCustID;

	--Compare to see if ordered amount greater than amount avaliable
	IF NumOrdered > AvailableCopies THEN
		dbms_output.put_line('The number of books ordered is greater than number of copies available, please try again.');
		RETURN;
	END IF;	
	
	--Gold customers have shipping fee set to 0 if not gold set to 10
	IF CustomerType = 'gold' THEN
		ShippingFee := 0.00;
	ELSE
		ShippingFee := 10.00;
	END IF;	

	--Insert item data into ItemOrder table
	INSERT INTO ItemOrder(OrderID, CustID, ItemID, DateofOrder, NumOfItems, ShippedDate, ShippingFee) VALUES (OrderID, addCustID, addItemID, DateOrdered, NumOrdered, NULL, ShippingFee);

	--Update comicbook table for how many books are sold
	UPDATE ComicBook SET NumOfCopies = (AvailableCopies - NumOrdered) WHERE ItemID = addItemID;

END;
/
show errors;

--EXECUTE addItemOrder(1,3,2,'13-SEP-2019',8,'03-DEC-2019');
--EXECUTE addItemOrder(2,1,1,'13-OCT-2019',3,'03-DEC-2019');
--EXECUTE addItemOrder(3,2,2,'28-NOV-2019',3,'03-DEC-2019');
