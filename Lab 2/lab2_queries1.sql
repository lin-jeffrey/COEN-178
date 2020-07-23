SELECT custid, firstname || lastname AS Fullname, city FROM Customer;
SELECT * FROM Customer ORDER BY lastname ASC;
SELECT * FROM Schedule ORDER BY serviceid, custid DESC;
SELECT serviceid FROM DeliveryService MINUS SELECT serviceid FROM Schedule;
SELECT firstname || lastname as name FROM Customer WHERE custid IN (SELECT day FROM Schedule WHERE day = 'm');
SELECT lastname FROM Customer WHERE custid IN(SELECT custid FROM Schedule);
SELECT MAX(servicefee) AS Highest_Servicefee FROM DeliveryService;
SELECT A.custid, B.custid, A.city FROM Customer A, Customer B WHERE A.city = B.city AND A.custid > B.custid;
