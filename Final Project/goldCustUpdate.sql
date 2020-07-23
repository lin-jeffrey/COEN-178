--This trigger sees if a customer type has been changed to gold and then updates the shipping fee of pending order accordingly
CREATE OR REPLACE TRIGGER goldCustUpdate
	AFTER UPDATE ON StoreCustomer
	FOR EACH ROW
BEGIN
	--See if updated customer type is gold
	IF :NEW.CustType = 'gold' THEN
		UPDATE ItemOrder SET ShippingFee = 0.00 WHERE CustID = :NEW.CustID;
	ELSE
		UPDATE ItemOrder SET ShippingFee = 10.00 WHERE CustID = :NEW.CustID;
	END IF;
END;
/
show errors;

--update storecustomer set custtype = 'gold' where custid = 1;
