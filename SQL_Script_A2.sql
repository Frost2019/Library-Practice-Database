create table SUPPLIERS(
SupplierID CHAR(1) NOT NULL,
CompanyName VARCHAR(15),
ContactLN	    VARCHAR(15),
ContactFN       VARCHAR(15),
Phone           VARCHAR(13),
primary key  (SupplierID));

create table BOOKS(
BookID	CHAR(1) NOT NULL,
Title	VARCHAR(50),
Unit_Price DECIMAL(4,2),
Author	VARCHAR(15),
UISTOCK INT,
SupplierID  CHAR(1) NOT NULL,
SubjectID   CHAR(1) NOT NULL,
primary key (BookID));

create table SUBJECTS(
SubjectID CHAR(1) NOT NULL,
CategoryName  VARCHAR(16),
primary key (SubjectID));

create table EMPLOYEES(
EmployeeID CHAR(1) NOT NULL,
LNAME	VARCHAR(16),
FNAME	VARCHAR(16),
primary key (EmployeeID));

create table OrderDetails(
BookID    CHAR(1) NOT NULL,
OrderID   CHAR(1) NOT NULL,
Quantity  INT,
primary key (BookID, OrderID));

create table CUSTOMERS(
CustomerID	CHAR(1) NOT NULL,
CLName		VARCHAR(15),
CFName		VARCHAR(15),
CPhone		VARCHAR(13),
primary key (CustomerID));

create table ORDERS(
OrderID	CHAR(1) NOT NULL,
CustomerID CHAR(1) NOT NULL,
EmployeeID CHAR(1) NOT NULL,
OrderDate	DATE,
ShippedDate DATE,
ShipperID	CHAR(1),
primary key (OrderID));

create table SHIPPERS(
ShipperID	CHAR(1) NOT NULL,
ShipperName VARCHAR(16),
primary key (ShipperID));

insert into SUPPLIERS values(1, "Amazon", "Hamilton", "Laurell", "605-145-1875");
insert into SUPPLIERS values(2, "Ebay", "Koontz", "Dean", "605-244-1104");
insert into SUPPLIERS values(3, "Booksamillion", "Roberts", "Nora", "916-787-3320");
insert into SUPPLIERS values(4, "University", "Carter", "Stephen", "916-412-2004");

insert into BOOKS values(1, "The Quickie", 15.94, "James", 5, 3, 1);
insert into BOOKS values(2, "Blaze", 13.24, "Richard", 2, 3, 1);
insert into BOOKS values(3, "The Navigator", 14.01, "Clive", 10, 2, 1);
insert into BOOKS values(4, "Birmingham", 19.99, "Tim", 12, 3, 2);
insert into BOOKS values(5, "North Carolina Ghosts", 7.95, "Lynne", 5, 2, 2);
insert into BOOKS values(6, "Why I still live in Louisiana", 5.95, "Ellen", 30, 1, 3);
insert into BOOKS values(7, "The World is Flat", 30, "Thomas", 17, 3, 4); 

insert into subjects values(1, "Fiction");
insert into subjects values(2, "History");
insert into subjects values(3, "Travel");
insert into subjects values(4, "Technology");

insert into employees values(1, "Larson", "Erik");
insert into employees values(2, "Steely", "John");

insert into shippers values(1, "UPS");
insert into shippers values(2, "USPS");
insert into shippers values(3, "FedEx");

insert into customers values(1, "Lee", "James", "916-541-4568");
insert into customers values(2, "Smith", "John", "605-054-0010");
insert into customers values(3, "See", "Lisa", "605-054-0010");
insert into customers values(4, "Collins", "Jackie", "605-044-6582");

insert into orders values(1, 1, 1, "2017-08-01", "2017-08-03", 1);
insert into orders values(2, 1, 2, "2017-08-04", NULL, NULL);
insert into orders values(3, 2, 1, "2017-08-01", "2017-08-03", 2);
insert into orders values(4, 4, 2, "2017-08-04", "2017-08-05", 1);

insert into orderdetails values(1, 1, 2);
insert into orderdetails values(4, 1, 1);
insert into orderdetails values(6, 2, 2);
insert into orderdetails values(7, 2, 3);
insert into orderdetails values(5, 3, 1);
insert into orderdetails values(3, 4, 1);
insert into orderdetails values(4, 4, 1);
insert into orderdetails values(7, 4, 1);

select title
from BOOKS
 WHERE UISTOCK > 5;
 
 
 
 select sum(Books.Unit_Price * orderdetails.Quantity) as TotalPriceForJohnSmith
 from Books, Orders, Customers, OrderDetails
 Where Customers.CFName = "John" AND Customers.CLName = "Smith" AND Customers.CustomerID =
 Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID;
 
 select DISTINCT Customers.CFNAME, Customers.CLNAME, sum(product_total_price) as order_total
 from customers, orders, orderdetails, books
 Where Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 AND sum(books.Unit_Price * orderdetails.Quantity) > 20.00 OR Customers.CustomerID != Orders.CustomerID;
 
 select DISTINCT  books.Title, Shippers.Shippername
 from books, orders, orderdetails, Shippers
 Where Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 AND Orders.ShippedDate = "2017-08-05" AND orders.ShipperID = Shippers.ShipperID;
 
 select DisTINCT books.Title
 from books, orders, orderdetails, employees
 Where Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 AND Orders.EmployeeID = employees.EmployeeID AND employees.FNAME = "John" and employees.LNAME = "Steely";
 
 
 select pizza
 from customers;
 
 
 select Distinct books.Title
 from books, orders, orderdetails, customers
 Where (Customers.CFName = "John" AND Customers.CLName = "Smith"   AND Customers.CustomerID =
 Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID) or 
 (Customers.CFName = "Jackie" AND Customers.CLName = "Collins" AND Customers.CustomerID =
 Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID);
 
 select books.Title, orderdetails.Quantity
 from books, orders, orderdetails
 Where  Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 Order by title ASC;
 
 select customers.CFNAME, customers.CLNAME
 from books, orders, orderdetails, customers
 where Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 AND books.Title like "%Louisiana%";
 
 select customers.CFNAME, customers.CLNAME
 from books, orders, orderdetails, customers
 where Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 AND books.Author = "Thomas";
 
 select customers.CFNAME, customers.CLNAME, books.title
 from books, orders, orderdetails, customers, subjects
 where (Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 AND books.SubjectID = subjects.subjectID AND subjects.CategoryName = "Travel") or
  (Customers.CustomerID = Orders.CustomerID AND Orders.OrderID = orderdetails.OrderID AND orderdetails.BookID = books.BookID
 AND books.SubjectID = subjects.SubjectID AND subjects.CategoryName = "Fiction");
 
 select distinct subjects.CategoryName, books.Unit_Price 
 from books, subjects
 Where subjects.SubjectID = books.subjectID AND Least(books.Unit_Price, books.Unit_Price);
 
 select books.title, orderdetails.Quantity
 from books, orderdetails;
 
 select customers.LNAME, customers.FNAME, orderdetails.Quantity
 from customers, orderdetails;
 
 select customers.LNAME, customers.FNAME, orderdetails.Quantity
 from customers, orderdetails;