select CategoryName,Description 
from Categories
order by 1   


/* Create a report that shows the ContactName, CompanyName, ContactTitle and Phone number from the customers table 
sorted by Phone. */ 

select ContactName, CompanyName, ContactTitle,Phone 
from Customers 
order by Phone 


/*Create a report that shows the capitalized FirstName and capitalized LastName renamed as FirstName and Lastname 
respectively and HireDate from the employees table sorted from the newest to the oldest employee. */  

SELECT 
    UPPER(SUBSTRING(FirstName, 1, 1)) + LOWER(SUBSTRING(FirstName, 2, LEN(FirstName))) AS FirstName,
    UPPER(SUBSTRING(LastName, 1, 1)) + LOWER(SUBSTRING(LastName, 2, LEN(LastName))) AS LastName,
    HireDate
FROM Employees
ORDER BY HireDate DESC;

/*Create a report that shows the top 10 OrderID, OrderDate, ShippedDate, CustomerID, Freight from the orders table sorted 
by Freight in descending order. */ 

select top 10 OrderID,OrderDate, ShippedDate, CustomerID, Freight
from Orders
order by Freight desc 

/*Create a report that shows all the CustomerID in lowercase letter and renamed as ID from the customers table.*/ 
select LOWER(CustomerID) as ID 
from Customers

/*Create a report that shows the CompanyName, Fax, Phone, Country, HomePage from the suppliers table sorted by the 
Country in descending order then by CompanyName in ascending order. */ 

select  CompanyName, Fax, Phone, Country, HomePage 
from Suppliers 
order by Country desc , CompanyName asc 

/* Create a report that shows CompanyName, ContactName of all customers from ‘Buenos Aires' only.*/ 
select CompanyName, ContactName 
from Customers
where City = 'Buenos Aires'


/*8 Create a report showing ProductName, UnitPrice, QuantityPerUnit of products that are out of stock*/

select ProductName, UnitPrice, QuantityPerUnit
from Products 
where UnitsInStock = 0 

/* 9 Create a report showing all the ContactName, Address, City of all customers not from Germany, Mexico, Spain.*/ 
select  ContactName, Address, City 
from Customers 
where Country not In ('Germany','Mexico','Spain')


/*10 Create a report showing OrderDate, ShippedDate, CustomerID, Freight of all orders placed on 21 May 1996. */ 
select OrderDate, ShippedDate, CustomerID, Freight
from Orders 
where OrderDate = '1996-05-21'

/*11 Create a report showing FirstName, LastName, Country from the employees not from United States.*/ 
select FirstName, LastName, Country 
from Employees 
where Country !='USA'


/*12 Create a report that shows the EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate from all orders shipped later 
than the required date. */ 

select EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate 
from Orders 
where ShippedDate > RequiredDate  

/* 13  Create a report that shows the City, CompanyName, ContactName of customers from cities starting with A or B */ 
select City, CompanyName, ContactName 
from Customers 
where City like 'A%' OR  City like 'B%'

/* 14  Create a report showing all the even numbers of OrderID from the orders table.*/
select OrderID 
from Orders 
where OrderID %2 = 0 

/*15 Create a report that shows all the orders where the freight cost more than $500. */ 
select *
from Orders 
where Freight > 500 

/* 16 Create a report that shows the ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel of all products that are up for 
reorder.*/ 
select ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel
from Products 
where ReorderLevel > 0 

/* Create a report that shows the CompanyName, ContactName number of all customer that have no fax number. */ 
select CompanyName, ContactName 
from Customers 
where Fax is null 

/*18 Create a report that shows the FirstName, LastName of all employees that do not report to anybody.*/ 
select FirstName ,LastName 
from Employees 
where ReportsTo is null

/* 19 Create a report showing all the odd numbers of OrderID from the orders table. */ 

select OrderID 
from Orders 
where OrderID %2 != 0

/*20 Create a report that shows the CompanyName, ContactName, Fax of all customers that do not have Fax number and sorted 
by ContactName.*/ 

select CompanyName, ContactName, Fax 
from Customers 
where Fax is null 
order by 2

/* Create a report that shows the City, CompanyName, ContactName of customers from cities that has letter L in the name 
sorted by ContactName.*/

select  City, CompanyName, ContactName 
from Customers 
where City like '%L%'
order by 3

/*22 Create a report that shows the FirstName, LastName, BirthDate of employees born in the 1950s. */ 
select FirstName, LastName, BirthDate
from Employees 
where year(BirthDate ) between  1950 and 1959

/* 23 Create a report that shows the FirstName, LastName, the year of Birthdate as birth year from the employees table. */
select FirstName, LastName ,year(BirthDate )
from Employees

/* 24 Create a report showing OrderID, total number of Order ID as NumberofOrders from the orderdetails table grouped by 
OrderID and sorted by NumberofOrders in descending order. HINT: you will need to use a Groupby statement. */ 

select sum (OrderID ) as NumberofOrders
from [Order Details]
group by OrderID 
order by 1 desc 


/* 25 Create a report that shows the SupplierID, ProductName, CompanyName from all product Supplied by Exotic Liquids, 
Specialty Biscuits, Ltd., Escargots Nouveaux sorted by the supplier ID */ 

select Products.SupplierID, Products.ProductName, Suppliers.CompanyName 
from Products left join Suppliers
on Suppliers.SupplierID = Products.SupplierID


/* 26 Create a report that shows the ShipPostalCode, OrderID, OrderDate, RequiredDate, ShippedDate, ShipAddress of all orders 
with ShipPostalCode beginning with "98124". */  

select OrderID , OrderDate, RequiredDate, ShippedDate, ShipAddress, ShipPostalCode 
from Orders
where ShipPostalCode like '98124%'

/* 27 Create a report that shows the ContactName, ContactTitle, CompanyName of customers that the has no "Sales" in their 
ContactTitle. */ 

select ContactName, ContactTitle, CompanyName 
from Customers
where ContactTitle not like 'Sales%' 

/*28 Create a report that shows the LastName, FirstName, City of employees in cities other than "Seattle"; */

select LastName, FirstName, City 
from Employees
where City != 'Seattle'

/* 29 Create a report that shows the CompanyName, ContactTitle, City, Country of all customers in any city in Mexico or other 
cities in Spain other than Madrid.*/ 

select CompanyName, ContactTitle, City, Country 
from Customers 
where City  in ('México D.F.' , 'Spain' , 'Madrid' )

/* 31 Create a report that shows the ContactName of all customers that do not have letter A as the second alphabet in their 
Contactname. */

select ContactName 
from Customers
where Contactname not like '_A%'

/* 32 Create a report that shows the average UnitPrice rounded to the next whole number, total price of UnitsInStock and 
maximum number of orders from the products table. All saved as AveragePrice, TotalStock and MaxOrder respectively. */

select avg(UnitPrice) as AveragePrice ,sum(UnitsInStock ) as TotalStock ,max(UnitsOnOrder) as MaxOrder
from Products

/* 33 Create a report that shows the SupplierID, CompanyName, CategoryName, ProductName and UnitPrice from the products, 
suppliers and categories table. */ 

select Suppliers.SupplierID, CompanyName, CategoryName, ProductName ,UnitPrice
from Products , Suppliers , Categories 


/* 34  Create a report that shows the CustomerID, sum of Freight, from the orders table with sum of freight greater $200, grouped 
by CustomerID. HINT: you will need to use a Groupby and a Having statement. */ 

select CustomerID , sum (Freight) as Total_Freight
from Orders 
group by CustomerID
having sum (Freight) > 200

/*35 Create a report that shows the OrderID ContactName, UnitPrice, Quantity, Discount from the order details, orders and 
customers table with discount given on every purchase. */ 


select od.OrderID , c.ContactName , od.UnitPrice,od.Quantity,od.Discount
from [Order Details] od inner join Orders  o on  od.OrderID =o.OrderID  
inner join Customers c on o.CustomerID = c.CustomerID 
where Discount > 0

/*36 Create a report that shows the EmployeeID, the LastName and FirstName as employee, and the LastName and FirstName of 
who they report to as manager from the employees table sorted by Employee 
ID. HINT: This is a SelfJoin.  */ 

select e.EmployeeID ,e.LastName ,e.FirstName as employee ,m.FirstName ,m.LastName as manger 
from Employees e inner join  Employees m 
on m.EmployeeID = e.EmployeeID

/*37  Create a report that shows the average, minimum and maximum UnitPrice of all products as AveragePrice, MinimumPrice 
and MaximumPrice respectively. */ 

select avg(UnitPrice) as AveragePrice , min(UnitPrice) as MinimumPrice , max(UnitPrice) as MaximumPrice
from [Order Details]


/* 38  Create a view named CustomerInfo that shows the CustomerID, CompanyName, ContactName, ContactTitle, Address, City, 
Country, Phone, OrderDate, RequiredDate, ShippedDate from the customers and orders table. HINT: Create a View*/

select c.CustomerID , c.CompanyName, c.ContactName , c.ContactTitle , c.Address , c.City, c.Country , c.Phone , o.OrderDate , o.RequiredDate , o.ShippedDate 
from Customers c left join Orders o 
on c.CustomerID = o.CustomerID

/*39 Change the name of the view you created from customerinfo to customer details.*/ 
select c.* 
from Customers c 

/* 40 Create a view named ProductDetails that shows the ProductID, CompanyName, ProductName, CategoryName, Description, 
QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued from the supplier, products and 
categories tables. HINT: Create a View */ 

select P.ProductID,S.CompanyName,P.ProductName , C.CategoryName,C.Description ,P.QuantityPerUnit, P.UnitPrice, P.UnitsInStock,P.UnitsOnOrder, P.ReorderLevel, P.Discontinued
from Products P left join Categories C on C.CategoryID = P.CategoryID inner join Suppliers S on S.SupplierID = P.SupplierID

/* Drop the customer details view.*/
/* to know names of forign key*/
SELECT 
    f.name AS ForeignKeyName,
    OBJECT_NAME(f.parent_object_id) AS ReferencingTable
FROM 
    sys.foreign_keys AS f
JOIN 
    sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id
WHERE 
    OBJECT_NAME(f.referenced_object_id) = 'Customers';

/* drop forign key first */
ALTER TABLE Orders DROP CONSTRAINT   FK_Orders_Customers
ALTER TABLE CustomerCustomerDemo DROP CONSTRAINT   FK_CustomerCustomerDemo_Customers
DROP TABLE Customers;

/* 42 Create a report that fetch the first 5 character of categoryName from the category tables and renamed as ShortInfo*/ 
select substring (CategoryName,1,5) as ShortInfo
from Categories

/* 43 Create a copy of the shipper table as shippers_duplicate. Then insert a copy of shippers data into the new table HINT: Create 
a Table, use the LIKE Statement and INSERT INTO statement.*/

select * into Shippers_duplicate 
from Shippers 
where 1 = 0

insert into Shippers_duplicate
select * from Shippers

SET IDENTITY_INSERT Shippers_duplicate ON;
INSERT INTO Shippers_duplicate(ShipperID,CompanyName,Phone)
SELECT ShipperID ,CompanyName ,Phone
FROM Shippers;
    
select * from Shippers_duplicate

/*45 Create a report that shows the CompanyName and ProductName from all product in the Seafood category.*/

select s.CompanyName ,p.ProductName 
from  Products p inner join  Suppliers s on  s.SupplierID = p.SupplierID left join  Categories C on c.CategoryID = p.CategoryID 
where c.CategoryName = 'Seafood'

/* 46 Create a report that shows the CategoryID, CompanyName and ProductName from all product in the categoryID 5. */
select c.CategoryID, s.CompanyName , p.ProductName
from  Products p inner join  Suppliers s on  s.SupplierID = p.SupplierID left join  Categories c on c.CategoryID = p.CategoryID 
where c.CategoryID = 5


/* 47 Delete the shippers_duplicate table.*/ 
delete Shippers_duplicate

/* 48 Create a select statement that ouputs the following from the employees table. */ 
select LastName , FirstName , Title ,BirthDate, DATEDIFF(YEAR, BirthDate, GETDATE())  + 0 AS age
from Employees

/* 49 Create a report that the CompanyName and total number of orders by customer renamed as number of orders since 
December 31, 1994. Show number of Orders greater than 10. */ 
SELECT 
    c.CompanyName, 
    COUNT(o.OrderID) AS [Number of Orders]
FROM 
    Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderDate > '1994-12-31'
GROUP BY 
    c.CompanyName
HAVING 
    COUNT(o.OrderID) > 10;
