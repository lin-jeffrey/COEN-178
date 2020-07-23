--This procedure outputs all the item order details of a certain customer with a order date after a inputted day
Create or Replace PROCEDURE itemOrderDetails(newCustID IN NUMBER, newDateOfOrder IN DATE)
AS
	--Customer details
	custName VARCHAR(20);
	custEmail VARCHAR(20);
	custAddress VARCHAR(20);
	--Order details
	CURSOR afterDateOrders IS
		SELECT OrderID, ItemID, NumOfItems, DateofOrder, ShippedDate, ShippingFee FROM ItemOrder WHERE DateofOrder > newDateOfOrder AND CustID = newCustID;
	OrderedOrderID INT;
	OrderedItemID INT;
	OrderedNumOfItems NUMBER(10);
	OrderedDateofOrder DATE;
	OrderedShippedDate DATE;
	OrderShippingFee NUMERIC(5,2);	
	OrderItemName VARCHAR(20);
	--Payment details
	OrderSubtotal NUMERIC(5,2);
	OrderTax NUMERIC(5,2);
	OrderedItemPrice NUMERIC(5,2);
	OrderDiscount NUMERIC(5,2);
	OrderTotal NUMERIC(5,2);

BEGIN
	--Customer details
	SELECT Name INTO custName FROM StoreCustomer WHERE CustID = newCustID; 
	SELECT Email INTO custEmail FROM StoreCustomer WHERE CustID = newCustID; 
	SELECT Address INTO custAddress FROM StoreCustomer WHERE CustID = newCustID;
	--Customer details output
	dbms_output.put_line(newCustID || '	' || custName || '	' || custEmail || '	' || custAddress);
	
	OPEN afterDateOrders;
	LOOP
	FETCH afterDateOrders INTO OrderedOrderID, OrderedItemID, OrderedNumOfItems, OrderedDateofOrder, OrderedShippedDate, OrderShippingFee;
		EXIT WHEN afterDateOrders%NOTFOUND;
		--Order details		
		SELECT ItemName INTO OrderItemName FROM StoreItem WHERE ItemID = OrderedItemID;
		SELECT Price INTO OrderedItemPrice FROM StoreItem WHERE ItemID = OrderedItemID;
		--Order details	output
		dbms_output.put_line(OrderedOrderID || '	' || OrderedItemID || '	' || OrderItemName || '	' || OrderedItemPrice || '	' || 
			OrderedDateofOrder || '	' || OrderedShippedDate);
		--Payment details		
		OrderSubtotal := (OrderedNumOfItems * OrderedItemPrice);
		OrderTax := OrderSubTotal * 0.05;
		IF(OrderShippingFee = 0 AND OrderSubtotal >= 100) THEN
			OrderDiscount := OrderSubtotal * 0.9;
		END IF;
		OrderTotal := returnTotal(OrderedOrderID);
		--Payment details output
		dbms_output.put_line('Total: ' || OrderSubTotal || '	Tax: ' || OrderedItemID || '	Shipping Fee: ' || OrderShippingFee || 
		 '	Discount: ' || OrderDiscount ||'	Grand Total: ' || OrderTotal);
	END LOOP;
	CLOSE afterDateOrders;

END;
/
show errors;

