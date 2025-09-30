create table Salesman
(
SalesmanId int primary key,
SalesmanName varchar(50),
Commission int,
City varchar(50) default('No City'),
Age int
)

insert into Salesman(SalesmanId,SalesmanName,Commission,City,Age)
values
(101,'Joe',50,'California',17),
(102,'Simon',75,'Texas',25),
(103,'Jessie',105,'Florida',35),
(104,'Danny',100,'Texas',22),
(105,'Lia',65,'New Jersy',30)

select * from Salesman
drop table Salesman



create table Customer
(
SalesmanId int FOREIGN KEY REFERENCES Salesman(SalesmanId),
CustomerId int,
CustomerName varchar(50) not null,
PurchaseAmount int
);

insert into Customer(SalesmanId,CustomerId,CustomerName,PurchaseAmount)
values
(101,2345,'Andrew',550),
(103,1575,'Luck',4500),
(104,2345,'Andrew',4000),
(105,3747,'Remona',2700)


create table Orders
(
 OrderId INT,
 CustomerId INT,
 SalesmanId int FOREIGN KEY REFERENCES Salesman(SalesmanId),
 OrderDate DATE,
 Amount INT,
 )

 insert into Orders
 values
 (5001,2345,101,'2021-07-04',550),
 (5003,1234,105,'2022-02-15',1500)
 select * from Orders


 
select * from Customer 
where CustomerName like '%N' 
and PurchaseAmount>500

--unique SalesmanId values from two tables

select SalesmanId FROM Customer
UNION
select SalesmanId FROM Orders


--union all SalesmanId with duplicates from two tables
select SalesmanId FROM Customer
UNION ALL
select SalesmanId FROM Orders


--Display matching data for PurchaseAmount between 500 and 1500

SELECT o.OrderDate, s.SalesmanName, c.CustomerName, s.Commission, s.City
FROM Orders o
JOIN Customer c ON o.CustomerId = c.CustomerId
JOIN Salesman s ON o.SalesmanId = s.SalesmanId
WHERE c.PurchaseAmount BETWEEN 500 AND 1500;


--Right join to fetch all results from Salesman and Orders

SELECT o.OrderId, o.OrderDate, s.SalesmanName, o.Amount
FROM Orders o
RIGHT JOIN Salesman s ON o.SalesmanId = s.SalesmanId;
