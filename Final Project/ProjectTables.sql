/*
DROP TABLE ITEMORDER;
DROP TABLE STORECUSTOMER;
DROP TABLE TSHIRT;
DROP TABLE COMICBOOK;
DROP TABLE STOREITEM;
*/

CREATE TABLE StoreItem(
ItemId INT PRIMARY KEY,
ItemName VARCHAR(20),
Price NUMERIC(5,2)
);

CREATE TABLE ComicBook(
ISBN NUMBER(13),
Title VARCHAR(20),
PublishDate DATE,
NumOfCopies NUMBER(10),
ItemId NUMBER(10),
FOREIGN KEY (ItemId) REFERENCES StoreItem(ItemId)
);

CREATE TABLE TShirt(
ShirtSize CHAR(1),
ItemId NUMBER(10),
FOREIGN KEY (ItemId) REFERENCES StoreItem(ItemId)
);

CREATE TABLE StoreCustomer(
CustID NUMBER(10) PRIMARY KEY,
Name VARCHAR(20),
Email VARCHAR(20) NOT NULL UNIQUE,
Address	VARCHAR(20),
CustType VARCHAR(10),
DateJoined DATE
);

CREATE TABLE ItemOrder(
OrderID NUMBER(10) PRIMARY KEY,
CustID NUMBER(10),
ItemID INT,
DateofOrder DATE,
NumOfItems NUMBER(10),
ShippedDate	DATE ,
ShippingFee NUMERIC(5,2),
FOREIGN KEY (ItemId) REFERENCES StoreItem(ItemId),
FOREIGN KEY (Custid) REFERENCES StoreCustomer(Custid)
);

INSERT INTO StoreCustomer VALUES (1,'John Smith','jsmith@scu.edu','100 El Camino Real','regular',NULL);
INSERT INTO StoreCustomer VALUES (2,'Michael Smith','msmith@scu.edu','101 El Camino Real','regular',NULL);
INSERT INTO StoreCustomer VALUES (3,'Maria Garcia','mgarcia@scu.edu','102 El Camino Real','regular',NULL);
INSERT INTO StoreCustomer VALUES (4,'Mary Rodriguez','mrodriguez@scu.edu','103 El Camino Real','gold','10-MAY-2019');
INSERT INTO StoreCustomer VALUES (5,'James Johnson','jjohnson@scu.edu','104 El Camino Real','gold','14-JUN-2019');
INSERT INTO StoreCustomer VALUES (6,'Bob Martinez','mmartinez@scu.edu','105 El Camino Real','gold','19-JUL-2019');

INSERT INTO StoreItem VALUES (1,'Spiderman Comic Book',5.00);
INSERT INTO StoreItem VALUES (2,'Superman Comic Book',7.00);
INSERT INTO StoreItem VALUES (3,'Ironman Comic Book',6.00);
INSERT INTO StoreItem VALUES (4,'Small T-shirt',20.00);
INSERT INTO StoreItem VALUES (5,'Medium T-shirt',25.00);
INSERT INTO StoreItem VALUES (6,'Large T-shirt',30.00);

INSERT INTO ComicBook VALUES (000000000001,'Spiderman','15-FEB-2019',213,1);
INSERT INTO ComicBook VALUES (000000000002,'Superman','08-MAR-2019',234,2);
INSERT INTO ComicBook VALUES (000000000003,'Ironman','19-APR-2019',287,3);

INSERT INTO TShirt VALUES ('s',4);
INSERT INTO TShirt VALUES ('m',5);
INSERT INTO TShirt VALUES ('l',6);


