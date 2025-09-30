 ---1.Arrange the ‘Orders’ dataset in decreasing order of amount
       
       select * from Orders order by Amount DESC

 --2.Create a table with the name ‘Employee_details1’ consisting of these columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. 
--Create another table with the name ‘Employee_details2’ consisting of the same columns as the first table.

create table Employee_details1
(
Emp_id int,
Emp_name varchar(50),
Emp_salary Decimal(10,2)
)

create table Employee_details2
(
Emp_id int,
Emp_name varchar(50),
Emp_salary Decimal(10,2)
)


INSERT INTO Employee_details1 VALUES
(1, 'Rahul', 50000),
(2, 'Sneha', 60000),
(3, 'Amit', 55000);

INSERT INTO Employee_details2 VALUES
(2, 'Sneha', 60000),
(3, 'Amit', 55000),
(4, 'Priya', 65000);


select * from Employee_details1
select * from Employee_details2


-- 3.Apply the UNION operator on these two tables

select * from Employee_details1
union
select * from Employee_details2

 --4.Apply the INTERSECT operator on these two tables

 select * from Employee_details1
intersect
select * from Employee_details2

 --5.Apply the EXCEPT operator on these two tables
select * from Employee_details1
except
select * from Employee_details2