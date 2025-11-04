create table Cities
(
   City_id int Primary key,
   City_name varchar(100)

)
create table Resturants 
(
  Resturant_id int primary key ,
  Resturant_name varchar(100),
  City_id int foreign key references Cities(City_id),
  Resturant_type varchar(50)
)
create table Meal_Types
(
  Meal_type_id int primary key ,
  Meal_type_name varchar(50)

)
create table Meals
(
 Meal_id int primary key,
 Meal_name varchar(50),
 Price decimal(10,2),
 Meal_type_id  int foreign key references Meal_Types(Meal_type_id),
 Resturant_id int foreign key references Resturants(Resturant_id )

)
create table Customers 
(
   Customer_id int primary key ,
   Customer_name varchar(50),
   Email varchar (50),
   City_id int foreign key references Cities(City_id),
)
create table Orders 
(
  Order_id int primary key ,
  Customer_id int  foreign key references Customers(Customer_id),
  Resturant_id int foreign key references Resturants(Resturant_id ),
  Order_date date
)

create table Order_Details 
(
   Order_detail_id int primary key ,
   Order_id int foreign key references Orders(Order_id),
   Meal_id int foreign key references Meals( Meal_id) ,
   Quantity int 
)

create table monthely_members_totals 
(
   Customer_id int ,
   [Month] date,
   Total_spent Decimal(10,2)

)

/* questions for customers*/
/* numbers of customers in each city */ 

select  distinct count( Customer_id )
from Customers cust ,Cities C
where C.City_id = cust.City_id 

/* most 5 customers by number of orders   */
SELECT TOP 5  C.Customer_name, COUNT(*) AS Order_Count
FROM Orders O
JOIN Customers C ON O.Customer_id = C.Customer_id
GROUP BY C.Customer_name
ORDER BY Order_Count DESC;
/* or */
SELECT TOP 5 Customer_id, COUNT(*) AS Order_Count
FROM Orders
GROUP BY Customer_id
ORDER BY Order_Count DESC;

/* q3 average budject of customers in each city*/
select avg(mmt.Total_spent) as average_spent  , c.City_name 
from monthely_members_totals mmt join Customers cust on cust.Customer_id = mmt.Customer_id 
join Cities c on c.City_id = cust.City_id 
group by City_name 


/* how many customers that their budget greater than 100*/
select count (DISTINCT Customer_id) number_of_customers 
from monthely_members_totals 
where Total_spent >100

/* insert into monthly mrmbers*/
insert into monthely_members_totals (Customer_id,Month,Total_spent)
select 
o.Customer_id ,
DATEFROMPARTS( year(o.Order_date), MONTH(o.Order_date),1) as[Month] ,
SUM(m.Price) as total_spent 
from Orders o join Order_Details od on o.Order_id = od.Order_id 
join Meals m on m.Meal_id = od.Meal_id 
group by o.Customer_id , YEAR(o.Order_date), MONTH(o.Order_date);


/* *********** Questions on meals****************/
/*q1 meals types of most orderd meals */

select mt.Meal_type_name , count(*) as numbers_of_ordered
from Meal_Types mt join Meals m on mt.Meal_type_id = m.Meal_type_id 
join Order_Details od on m.Meal_id = od.Meal_id 
group by mt.Meal_type_name
ORDER BY numbers_of_ordered DESC;


/*q2 numbers of different meals offered by the resturant */

select r.Resturant_name ,count (distinct m.Meal_id) as number_of_meals 
from Meals m join Resturants r on r.Resturant_id = m.Resturant_id 
join Order_Details od on m.Meal_id = od.Meal_id 
group by Resturant_name
order by number_of_meals desc

/*q3 avg price of each meal type  on   resturant */
 
 select  mt.Meal_type_name, r.Resturant_name , avg(m.Price) as avg_price  
 from Meal_Types mt join Meals m ON mt.Meal_type_id = m.Meal_type_id  
 join Resturants r on r.Resturant_id = m.Resturant_id
group by  Meal_type_name ,Resturant_name


/* q4 what is the minimum and maxmum price in each meal*/
select mt.Meal_type_name, min(m.Price) as min_price, max(m.Price) as max_price 
from Meal_Types mt join Meals m ON mt.Meal_type_id = m.Meal_type_id  
group by Meal_type_name

/*another solution max price of each meal type */ 
SELECT * 
FROM (
    SELECT 
        mt.Meal_type_name, 
        m.Meal_name, 
        m.Price, 
        ROW_NUMBER() OVER (PARTITION BY mt.Meal_type_name ORDER BY m.Price DESC) AS rn
    FROM Meal_Types mt 
    JOIN Meals m ON mt.Meal_type_id = m.Meal_type_id
) AS new_table
WHERE rn = 1;

/*q5 average price of meals in each city*/
select c.City_name ,AVG(m.Price) as Average_Price 
from Meals m join Order_Details od  ON  m.Meal_id = od.Meal_id 
inner join Orders o ON o.Order_id = od.Order_id 
join Customers cust ON cust.Customer_id = o.Customer_id 
join Cities c ON  c.City_id = cust.City_id 
group BY City_name
ORDER BY  Average_Price DESC


/************************* Questions for orders ***********************************/ 


/*q1   number of orders for each resturant */ 

select r.Resturant_name , count(DISTINCT o.Order_id ) as Number_of_orders 
from Orders o join Resturants r on r.Resturant_id = o.Resturant_id 
group by Resturant_name
order by  Number_of_orders desc

/*q2 avg of orders for each customers */
select c.Customer_name , count (o.Order_id ) as avg_orders
from Customers c join Orders o on c.Customer_id = o.Customer_id 
group by Customer_name
order by avg_orders desc

/*q3 most popular cities for meals*/

select c.City_name ,count (m.Meal_id) as number_of_meals
from Meals m join Resturants r on r.Resturant_id = m.Resturant_id join Cities c on c.City_id = r.City_id 
group by c.City_name
order by number_of_meals desc

/*q4 what is the months that have most number of orders*/

select MONTH(Order_date ) as month_number ,count (Order_id)
from Orders 
group by MONTH(Order_date )


/******************************************Questions in Revenue ************************************/



/*q1 total revenue for each resturant */

select r.Resturant_name ,FORMAT(o.Order_date,'yyyy-MM') as month , 
       sum(m.Price * od.Quantity ) as monthly_revenue 
from Meals m join Order_Details od on m.Meal_id = od.Meal_id 
join Orders o on o.Order_id = od.Order_id 
join Resturants r on r.Resturant_id  = o.Resturant_id 
group by r.Resturant_name, FORMAT(o.Order_date, 'yyyy-MM')

/* Q2 Who is the Customer who achieved the highest total spending */ 
Select top 1 c.Customer_name ,sum(m.Price * od.Quantity ) as total_spending 
from Meals m join Order_Details od on m.Meal_id = od.Meal_id 
join Orders o on o.Order_id = od.Order_id 
join Customers c on c.Customer_id = o.Customer_id 
group by c.Customer_name 
order by total_spending  desc

/* Q3 which city has the highest monthly return */

select c.City_name ,sum(mmt.Total_spent) as monthly_return 
from Cities c join Customers cust on c.City_id = cust.City_id 
join monthely_members_totals mmt on cust.Customer_id = mmt.Customer_id 
group by c.City_name 
order by monthly_return desc 

/*Q4  What is the difference between resturant revenue depends on meal type   */
select r.Resturant_name ,mt.Meal_type_name ,sum(m.Price * od.Quantity) as total_revenue 
from Meals m join  Meal_Types mt  on mt.Meal_type_id = m.Meal_type_id 
join Order_Details od on m.Meal_id = od.Meal_id
join Orders o on o.Order_id = od.Order_id
join Resturants r on r.Resturant_id = o.Resturant_id 
group by r.Resturant_name ,mt.Meal_type_name
order by total_revenue desc


/**********************************************various questions ***********************************/
/*q1 how many customers didn't order */
select count (c.Customer_id) as number_of_customers
from Orders  o join Customers c on c.Customer_id = o.Customer_id
where c.Customer_id  != o.Customer_id



Select  c.Customer_name  ,sum (mmt.Total_spent) 
from monthely_members_totals mmt join Customers c on  c.Customer_id = mmt.Customer_id 
group by c.Customer_name 



























