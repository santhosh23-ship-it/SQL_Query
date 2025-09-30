create table Customerr
(
Customerid int,
First_name varchar(60) not null,
Laste_name varchar(50) not null,
Email nvarchar(200),
Address nvarchar(50),
City varchar(100),
State varchar(100),
zip int
)
 
 --drop table Customerr

insert into Customerr
values
(1, 'George', 'Smith', 'george.smith@gmail.com', '123 Main St', 'San Jose', 'CA', 95112),
(2, 'Grace', 'Adams', 'grace.adams@yahoo.com', '456 Oak Ave', 'San Jose', 'CA', 95123),
(3, 'Gary', 'Johnson', 'gary.johnson@gmail.com', '789 Pine Rd', 'Los Angeles', 'CA', 90001),
(4, 'Helen', 'Garcia', 'helen.garcia@gmail.com', '101 Maple St', 'San Jose', 'CA', 95124),
(5, 'Gina', 'Mendoza', 'gina.mendoza@gmail.com', '202 Elm St', 'San Jose', 'CA', 95125)

select * from Customerr


--.Select only the ‘first_name’ and ‘last_name’ columns 

SELECT First_name, Laste_name
FROM Customerr


--.Select those records where ‘first_name’ starts with “G” and city is ‘San Jose’

select * from Customerr
where First_name like 'G%' and City='San Jose'


--Select those records where Email has only ‘gmail’
select * from Customerr
where Email like '%gmail%'


--Select those records where the ‘last_name’ doesn't end with “A”

select * from Customerr
where Laste_name not like '%A'
