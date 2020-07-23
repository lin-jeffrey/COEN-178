--this procedure enters a shipping date for a pending itemorder using the following parameters
Create or Replace PROCEDURE shippingDate(newOrderID IN INT, ShippingDate IN DATE)
AS
	--declare variable
	OrderDate DATE;
BEGIN
	--populates variable with data
	SELECT DateofOrder INTO OrderDate FROM ItemOrder WHERE OrderID = newOrderID; 
	
	--make sure shipping date is after order date
	IF(ShippingDate > OrderDate) THEN
		--updates itemorder table with correct shipping date for the certain orderid
		UPDATE ItemOrder SET ShippedDate = ShippingDate WHERE OrderID = newOrderID;
	ELSE
		dbms_output.put_line('Shipping date must be after order date, please try again.');
		RETURN;
	END IF;

END;
/
show errors;

--execute shippingDate(1, '27-SEP-2019');
--execute shippingDate(2, '23-NOV-2019');
--execute shippingDate(3, '05-DEC-2019');
