--This sql file outputs in a formatted report the item order details of a certain customer past a certain order date

-- the size of one page
SET PAGESIZE 20
-- the size of a line
SET LINESIZE 175

--sets title
TTITLE CENTER "Customer Order Report"
SET UNDERLINE

--establishes customer data column headings
COLUMN CustID HEADING 'CustID';
COLUMN Name HEADING 'CustName';
COLUMN Email HEADING 'Email';
COLUMN Address HEADING 'Address';

--populates customer table
SELECT CustID, Name, Email, Address FROM StoreCustomer WHERE CustID = &CustID;

CLEAR COLUMNS	--reset column headings

--establishes order detail column headings
COLUMN OrderID HEADING 'OrderID';
COLUMN ItemID HEADING 'ItemID';
COLUMN ItemName HEADING 'Item Name';
COLUMN NumOfItems HEADING 'Quantity';
COLUMN Price FORMAT $9999999,999.99 HEADING 'Price';
COLUMN Subtotal FORMAT $9999999,999.99 HEADING 'Subtotal';
COLUMN Tax FORMAT $9999999,999.99 HEADING 'Tax';
COLUMN ShippingFee FORMAT $9999999,999.99 HEADING 'ShippingFee';
COLUMN Total FORMAT $9999999,999.99 HEADING 'Total';
COLUMN DateOfOrder HEADING 'Date Of Order';
COLUMN ShippedDate HEADING 'Shipped Date';

--computes sums of various columns 
BREAK ON REPORT ON ROW SKIP 1
COMPUTE SUM LABEL ' GrandTotal' OF Price Subtotal Tax ShippingFee Total ON REPORT;

--populates order detail columns
SELECT ItemOrder.OrderID, ItemOrder.ItemID, StoreItem.ItemName, ItemOrder.NumOfItems, StoreItem.Price, StoreItem.Price*ItemOrder.NumOfItems AS Subtotal, (StoreItem.Price*ItemOrder.NumOfItems)*0.05 AS Tax, ItemOrder.ShippingFee , ItemOrder.ShippingFee+((StoreItem.Price*ItemOrder.NumOfItems)*1.05) AS Total, ItemOrder.DateOfOrder, ItemOrder.ShippedDate FROM ItemOrder FULL JOIN StoreItem ON ItemOrder.ItemID = StoreItem.ItemId WHERE CustID = &CustID AND DateOfOrder >= '&DateOfOrder';

--resets output presets
CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF 
BTITLE OFF
SET VERIFY OFF 
SET FEEDBACK OFF
SET RECSEP OFF
SET ECHO OFF
