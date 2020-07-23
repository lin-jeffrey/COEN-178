CREATE TABLE Customer(
custid VARCHAR(5) PRIMARY KEY,
firstname VARCHAR(10),
lastname VARCHAR(15),
city VARCHAR(10)
);

CREATE TABLE DeliveryService(
serviceid VARCHAR(10) PRIMARY KEY,
item CHAR(15),
location VARCHAR(15),
servicefee NUMERIC(5,2)
);

CREATE TABLE Schedule(
serviceid VARCHAR(10),
custid VARCHAR(5),
day VARCHAR(2) NOT NULL CHECK(day in ('m','t','w','r','f')),
FOREIGN KEY (custid) REFERENCES Customer(custid),
FOREIGN KEY (serviceid) REFERENCES DeliveryService(serviceid)
);

INSERT INTO Customer VALUES ('c1','John','Smith','SJ');
INSERT INTO Customer VALUES ('c2','Mary', 'Jones','SFO');
INSERT INTO Customer VALUES ('a1','Vincent','Chen','SJ');
INSERT INTO Customer VALUES ('a12','Greg', 'King','SJ');
INSERT INTO Customer VALUES ('c7','James','Bond','LA');
INSERT INTO Customer VALUES ('x10','Susan','Blogg','SFO');
INSERT INTO Customer VALUES ('y23','Eason','Liu','LA');
INSERT INTO Customer VALUES ('a11','Ethan','Paik','SJ');

INSERT INTO DeliveryService VALUES ('dsg1','grocery','SJ',25.0);
INSERT INTO DeliveryService VALUES ('dsb1','books','SJ',10.0);
INSERT INTO DeliveryService VALUES ('dsm2','movies','LA',10.0);
INSERT INTO DeliveryService VALUES ('dby3','babygoods','SFO',15.0);
INSERT INTO DeliveryService VALUES ('dsg2','grocery','SFO',20.0);
INSERT INTO DeliveryService VALUES ('dg5','greengoods','SFO',30.0);
INSERT INTO DeliveryService VALUES ('dsw4','notebooks','SJ',25.0);
INSERT INTO DeliveryService VALUES ('deg5','furniture','LA',20.0);

INSERT INTO Schedule VALUES ('dsg1','c1','m');
INSERT INTO Schedule VALUES ('dsg2','a12','w');
INSERT INTO Schedule VALUES ('dby3','x10','f');
INSERT INTO Schedule VALUES ('deg5','a11','r');
INSERT INTO Schedule VALUES ('dsw4','c7','t');
INSERT INTO Schedule VALUES ('dsm2','y23','t');



