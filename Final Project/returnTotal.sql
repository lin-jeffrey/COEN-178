--This function returns the grand total of a certain orderid
Create or Replace FUNCTION returnTotal(newOrderID IN INT) 
RETURN NUMBER IS
	--declare variables
	OrderedItemID INT;
	OrderedItemPrice NUMERIC(5,2);
	OrderedAmount NUMBER(10);
	OrderCustID NUMBER(10);
	OrderCustType VARCHAR(10); 
	OrderShippingFee NUMERIC(5,2);	
	OrderTotal NUMERIC(10,2);

BEGIN
	--fills in variables with data from tables
	SELECT ItemID INTO OrderedItemID FROM ItemOrder WHERE OrderID = newOrderID; 
	SELECT Price INTO OrderedItemPrice FROM StoreItem WHERE ItemID = OrderedItemID; 
	SELECT NumOfItems INTO OrderedAmount FROM ItemOrder WHERE OrderID = newOrderID; 
	SELECT CustID INTO OrderCustID FROM ItemOrder WHERE OrderID = newOrderID;
	SELECT CustType INTO OrderCustType FROM StoreCustomer WHERE CustID = OrderCustID;
	SELECT ShippingFee INTO OrderShippingFee FROM ItemOrder WHERE OrderID = newOrderID;

	--order calculations
	OrderTotal := 0;
	OrderTotal := (OrderedItemPrice * OrderedAmount);
	OrderTotal := OrderTotal * 1.05;
	OrderTotal := OrderTotal + OrderShippingFee;

	--gold >=100 10% discount
	IF(OrderCustType = 'gold' AND OrderTotal >= 100) THEN
		OrderTotal := OrderTotal * 0.9;
	END IF;

	RETURN OrderTotal;
END;
/
show errors;




