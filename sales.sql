create database if not exists SALESDB;
drop database SalesDB;
use SALESDB;

CREATE TABLE IF NOT EXISTS SALESPERSON
(
SNUM INT UNSIGNED NOT NULL,
SNAME VARCHAR(10) UNIQUE NOT NULL,
CITY VARCHAR(10) NOT NULL,
COMM INT UNSIGNED NOT NULL,
PRIMARY KEY (SNUM)
);

CREATE TABLE IF NOT EXISTS CUSTOMERS
(
CNUM INT UNSIGNED NOT NULL,
CNAME VARCHAR(15) NOT NULL,
CCITY VARCHAR(10) NOT NULL,
SNUM INT UNSIGNED NOT NULL,
PRIMARY KEY (CNUM),
FOREIGN KEY (SNUM) REFERENCES SALESPERSON(SNUM)
);

CREATE TABLE IF NOT EXISTS ORDERS
(
ONUM INT UNSIGNED NOT NULL,
AMT DECIMAL(7,2) NOT NULL DEFAULT '0.0',
ODATE DATE NOT NULL DEFAULT '0000-00-00',
CNUM INT UNSIGNED NOT NULL,
SNUM INT UNSIGNED NOT NULL,
PRIMARY KEY (ONUM),
FOREIGN KEY (CNUM) REFERENCES CUSTOMERS (CNUM),
FOREIGN KEY (SNUM) REFERENCES SALESPERSON (SNUM)
);

INSERT INTO SALESPERSON VALUES
(1001,"Peel", "London", 12),
(1002, "Serres","Sanjose",13),
(1004, "Motika","London",11),
(1007, "Rifkin","Barcelona",15),
(1003, "Axelrod"," Newyork",10);

INSERT INTO CUSTOMERS VALUES
(2001, "Hoffman", "London",1001),
(2002, "Giovanni", "Rome", 1003),
(2003, "Liu", "Sanjose", 1002),
(2004, "Grass", "Berlin", 1002),
(2006, "Clemens", "London", 1001),
(2008, "Cisneros", "Sanjose", 1007),
(2007, "Pereira", "Rome", 1004);

INSERT INTO ORDERS VALUES
(3001, 18.69, "2021-03-10", 2008, 1007),
(3003, 767.19, "2021-03-10", 2001, 1001),
(3002, 1900.10, "2021-03-10", 2007, 1004),
(3005, 5160.45, "2021-03-10", 2003, 1002),
(3006, 1098.16, "2021-03-10", 2008, 1007),
(3009, 1713.23, "2021-04-10", 2002, 1003),
(3007, 75.75, "2021-04-10", 2004, 1002),
(3008, 4273.00, "2021-05-10", 2006, 1001),
(3010, 1309.95, "2021-06-10", 2004, 1002),
(3011, 9891.88, "2021-06-10", 2006, 1001);

/*Count the number of Salesperson whose name begin with ‘a’/’A’.*/

SELECT count(*), SNAME FROM SALESPERSON WHERE SNAME regexp '^(A|a)';

/*Display all the Salesperson whose all orders worth is more than Rs. 2000.*/

SELECT sum(ORDERS.AMT), ORDERS.SNUM, SALESPERSON.SNAME
FROM ORDERS
INNER JOIN SALESPERSON WHERE SALESPERSON.SNUM = ORDERS.SNUM
GROUP BY ORDERS.SNUM
HAVING sum(ORDERS.AMT) >2000
ORDER BY SUM(ORDERS.AMT);

/* Count the number of Salesperson belonging to Newyork. */

SELECT count(*), SNAME,CITY FROM SALESPERSON WHERE CITY REGEXP "NEWYORK|newyork|Newyork";

/*Display the number of Salespeople belonging to London and belonging to Paris.*/
SELECT count(*), SNAME,CITY FROM SALESPERSON WHERE CITY REGEXP "LONDON|london|London" and "PARIS|paris|Paris";

/*Display the number of orders taken by each Salesperson and their date of orders.*/

SELECT
COUNT(SNUM), 
SNUM AS "SALESPERSON NUMBER",
ONUM AS "ORDER NUMBER",
ODATE AS "ORDER DATE"  
FROM ORDERS
GROUP BY ONUM
ORDER BY SNUM