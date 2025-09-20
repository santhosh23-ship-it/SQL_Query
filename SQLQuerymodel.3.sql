-- ALTER a table
	-- Add a column
	-- Remove a column
	-- Alter a column

-- Add a column
	-- You cannot add a new column in an existing table with a NOT NULL constraint
	-- Whenever we add a new column to a table, the column stores NULL in it for all the existing rows: 
	-- If we set it to NOT NULL, SQL Server wouldn't know as to what data should be in the new column
	-- We can add a new column with NOT NULL, only when it has a DEFAULT constraint attached to it
--Add a not nullable column

create table canteen_access
(E_Id int , name char(15))

insert into canteen_access
select 1, 'Sandeep' union all
select 2, 'Akash' union all
select 3, 'Vikas'

select * from canteen_access


ALTER TABLE canteen_access
ADD limit int NOT NULL DEFAULT(100)

insert into canteen_access
select 4, 'Ganesh',200

insert into canteen_access(E_Id,Name)
select 5, 'Yashas'

SELECT * FROM canteen_access


-- Drop a column
	-- For columns which do not have a constraint, you can directly drop the column
	-- For column with constraints, you need to drop the constraint first and then the column
	-- Exceptions - (NOT NULL, IDENTITY)

create table canteen
(E_Id int,name char(15),salary int check(salary>0),address nvarchar(50) unique)

insert into canteen
select 1, 'Sandeep',2000,'Mumbai' union all
select 2, 'Akash',3000,'Bengalore' union all
select 3, 'Vikas',5000,'Pune' union all
select 4, 'Yashas',3500,'Chennai'


SELECT * FROM canteen

alter table canteen 
drop column  E_id -- to drop a column

alter table canteen 
drop column salary -- drop a cloumn that contains constraint of check

alter table canteen
drop constraint CK__canteen__salary__5A1A5A11 -- droping a constraint

-- Alter a column
	-- Make sure that the data in the column clearly obeys the constraint or key rules that 
	-- you apply
	-- in altering a table, we can change the data type of column, char length of the column,constraint of the column

select * from employee

-- lets change char length for employee first_name column to 50 char and add a constraint not null

alter table employee
alter column first_name char(50) not null

alter table employee
alter column employee_id int not null

ALTER TABLE employee -- adding primary key constraint to employee_id
ADD CONSTRAINT pk_employee PRIMARY KEY (employee_id)

-- Replacement of Alt+F1
sp_help Employee


-- Temporary tables
	-- Temporary tables are temp storage units to store and transform data from the source before 
		-- it is moved to the destination/displayed on the application
	-- The temp tables are created in the tempdb
	-- Advantages : 
		-- The source and destination table have complete availability
		-- Specific to the creator
	-- Types of Temp Tables : 
		-- Local Temp Table
		-- Global Temp Table

-- Local Temp Table
	-- The local temp table is identified by a single # before the name of the table
	-- You can create indexes, keys, constraints exactly like a physical table in the DB
	-- The scope of a local temp table is only in the session/query window where it is created
	-- We can create n number of local temp tables with the same name in different sessions
	-- We can either manually drop the local temp table 
		-- or it gets dropped automatically once the session is closed

CREATE TABLE #LocalTempTable
(
	Id int
	, Name varchar(100)
)

INSERT INTO #LocalTempTable(Id,Name)
SELECT 1,'Dinesh' UNION ALL
SELECT 2,'John' UNION ALL
SELECT 3,'Steve' 

SELECT * FROM #LocalTempTable AS x
INNER JOIN Employee AS emp 
ON emp.EmployeeId = x.Id

DROP TABLE #LocalTempTable

-- Global Temp Table
	-- The global temp table is identified by double ## before the name of the table
	-- You can create indexes, keys, constrints exactly like a physical table in the DB
	-- The scope of a global temp table is across all the sessions and for all users who have access to the database
	-- We can either manually drop the global temp table from any session
		-- or it gets dropped automatically once the parent session is closed

CREATE TABLE ##GlobalTempTable
(
	Id int
	, Name varchar(100)
)

INSERT INTO ##GlobalTempTable(Id,Name)
SELECT 1,'Dinesh' UNION ALL
SELECT 2,'John' UNION ALL
SELECT 3,'Steve' 

SELECT * FROM ##GlobalTempTable
	
DROP TABLE ##GlobalTempTable

-- Copying the data from Source to the temp table
SELECT *
INTO #EmployeeData
FROM Employee

SELECT * FROM #EmployeeData AS x

DROP TABLE #EmployeeData

-- Functions
	-- It is a database object which has a set of SQL Statements that accepts input 
		-- parameters and returns the result
	-- At a given point in time, function will definitely return something
	-- It can be a scalar value or a table valued
	-- We cannot use a function to Insert, Update or Delete records from physical
		-- tables in the database
/*
Advantages : 
	1. Reusuability aspect - We are able to reuse the encapsulated logic whereever required
	2. Maintainability - We no longer have to maintain the same piece of code at different places

Types of Functions
1. System Defined Functions : 
	a. Scalar Functions
	b. Aggregate Functions
2. User Defined Functions(UDF) : 
	a. Scalar Functions
	b. Table-Valued Functions
		i. Inline table-Valued function
		ii. Multiline table-valued function
*/
-- 1. System Defined Functions
--	a. Scalar Functions
	-- These functions operate on none, one or more input values and returns a scalar output value
-- DateTime Functions
	-- The date time functions are really helpful when you want to build date range metrics
SELECT GETDATE() -- This function returns the current server date time
SELECT GETUTCDATE() -- This gets us the UTC date and time(Universal Time Coordinated/Greenwich Mean Time)
SELECT GETDATE() + 2 -- This will add 2 days to my current date
SELECT GETDATE() - 2 -- This will subtract 2 days from my current date
SELECT DATEADD(hour,2,GETDATE()) -- This will add 2 hours to now
SELECT DATEADD(hour,-2,GETDATE()) -- This will deduct 2 hours from the current date time
SELECT DATEADD(year,2,GETDATE()) -- This adds 2 years to the current date time
SELECT DATEADD(year,-2,GETDATE()) -- This will deduct 2 years from the current date time
SELECT DATEADD(month,2,GETDATE()) -- This adds 2 months to the current date time
SELECT format (DATEADD(month,3,'2004-03-19'),'dd-mm-yyyy')as dob
SELECT DATEADD(month,2,DATEADD(hour,3,GETDATE())) -- This adds 3 hours and 2 months to the current date
SELECT YEAR(GETDATE()) -- Returns the year of the specified date
SELECT MONTH(GETDATE()) -- Returns the month of the specified date
SELECT DAY(GETDATE())
SELECT DATEPART(day,GETDATE()) -- Returns the date part of the current datetime
SELECT DATEPART(hour,GETDATE()) -- Returns the hour part of current datetime
SELECT DATEPART(minute,GETDATE())
SELECT DATEPART(year,GETDATE())
SELECT DATEPART(month,GETDATE()) month
SELECT DATEDIFF(day,'2022-09-01','2022-09-07') -- Returns the difference in days between the start and end date
SELECT DATEDIFF(hour,'2022-09-01','2022-09-07')
SELECT DATEDIFF(minute,'2022-09-01 20:00','2022-09-01 23:00')
SELECT DATENAME(MONTH,GETDATE())
SELECT DATENAME(WEEKDAY, GETDATE())


create table Stu(
	StudentID int
	, First_Name varchar(50) not null
	, Last_Name varchar(50) not null 
	, Email varchar(100) unique
	, Age int check(age>=18)
	, Course varchar(50) default 'general' 
	, AdmissionDate date not null
)

INSERT INTO Stu (StudentID, First_Name, Last_Name, Email, Age, Course, AdmissionDate)
VALUES
(1, 'Ravi', 'Kumar', 'ravi.kumar@example.com', 20, 'Computer Science', '2023-07-10'),
(2, 'Anita', 'Sharma', 'anita.sharma@example.com', 22, 'Data Science', '2023-07-12'),
(3, 'Vikram', 'Reddy', 'vikram.reddy@example.com', 19, DEFAULT, '2023-07-15'),
(4, 'Priya', 'Nair', 'priya.nair@example.com', 21, 'Mathematics', '2023-07-20'),
(5, 'Arjun', 'Mehta', 'arjun.mehta@example.com', 23, 'Physics', '2023-08-01'),
(6, 'Sneha', 'Patel', 'sneha.patel@example.com', 20, DEFAULT, '2023-08-05'),
(7, 'Rahul', 'Das', 'rahul.das@example.com', 25, 'Statistics', '2023-08-10')

select * from stu

alter table stu
add phonenumber varchar(15)

UPDATE Stu
SET Age = 21
WHERE StudentID = 3

SELECT *
INTO students_backup
FROM Stu

select * from students_backup

update stu
set phonenumber = 9450325691

select * from stu where course = 'data science'

update students_backup
set students_backup.phonenumber=stu.phonenumber
from students_backup
join stu on students_backup.studentid = stu.studentid

select * from students_backup


select * from EmployeeDOB

-- filtering by year

select * from EmployeeDOB
where year(EmployeeDOB) <=2000


select * from EmployeeDOB
where month(EmployeeDOB) between 3 and 5

select * from EmployeeDOB
where month(EmployeeDOB)= month(getdate())

select * from employee
where salary >= 25000

-- string functions 
  -- converts text to upper and lower cases

select upper('dinesh')
select lower('SANTOSH')
select len ('    santosh1774687     ') 
select 'Santosh ' + ' Reddy'
select left('dinesh',3) -- returns 3 characters from left
select right('dinesh',3) -- returns 3 characters from right
select trim ('         dinesh         kumar         '
select replace('dinesh','nesh','X') -- replace nesh with X
select reverse('Santosh')
select substring('dinesh12334567',3,10) -- returns the part of text from starting position 
select charindex('i','Dinesh')
select concat('Dinesh ', null,' Kumar')

-- extract domain from email address
create table EmpTbl(ID int, EmailID varchar(200))
insert into EmpTbl(ID,EmailID)
select 1,'dinesh@gmail.com' union all
select 2,'santosh@gmail.com' union all
select 3,'smith@gmail.com' union all
select 4,'sumit@yahoo.com' union all
select 5,'peter@microsoft.com'

select * 
	, substring(EmailID,1,charindex('@',EmailID)-1) as UserName
	, substring(EmailID,Charindex('@',EmailID) + 1,Len(EmailID)) as DomainName
	from EmpTbl

-- import scalar functions
--converting integer to string
select 'dinesh'+'kumar'
select 21+21
select '21'+'21'
select 'dinesh'+21

select EmployeeID,Address+City+State+cast(Pincode as varchar) as completeaddress
from Employee

select 'Dinesh' +cast(21 as varchar) -- ANSI standard SQL Function
select 'Dinesh' +convert(varchar,21) -- Specific to SQL

select isnull(null,'The First Value is Null')

-- null values can never be compared in SQL Server
select EmployeeID, EmployeeFirstName from Employee

-- where id is null -- extract the null records
where isnull (EmployeeID,0)<1

-- Aggregrate Functions
  -- These functions operate on a collection of values and returns a single value
select max(salary) as MaximumSalary from Employee
where address = 'India'
select min(salary) as MinimumSalary from EMployee 
select avg(salary) from Employee
select sum(salary) from Employee

-- == User Defined Functions(UDF):
-- Types of User Defined Functions:
	-- 1.Scalar valued function
	-- 2.table valued function
	   -- a.Inline/Single line table valued function
	   -- b.Multiline/Multi statement table valued function

-- 1.scalar valued UD function:
	-- Functions which are write,that accepts input parameters and returns a single value
	-- It can be return any data type
	-- A single function at a single point in time will return only one data type

-- ALT+F1 - To see the metadata of your object


CREATE FUNCTION fn_GetEmployeeFullName
(
    @FirstName VARCHAR(50),
    @LastName  VARCHAR(50)
)
RETURNS VARCHAR(101)
AS
BEGIN
    RETURN (concat(trim(@FirstName),' ',trim(@LastName)))
END

-- call Scaler Valued Defined Function
-- You need to specify the dbo(schema name) before your UD Scaler valued Function call
	-- optimizer tries to look into the list of user defined functions and not int the system
SELECT dbo.fn_GetEmployeeFullName('John','Smith') as FullName
SELECT dbo.fn_GetEmployeeFullName('Dinesh','Kumar') as FullName

CREATE  FUNCTION fn_AddNumbers
(
	@number1 int
	, @number2 int
)
RETURNS int
AS
BEGIN
	RETURN(ISNULL(@number1,0)+ISNULL(@number2,0))
END

-- The dbo is mandatory during the call of a scalar valued function because if we dont
	-- search for the function in the system defined function list
select dbo.fn_AddNumbers(1,2)
select dbo.fn_AddNumbers(10,15)
select dbo.fn_AddNumbers(11,null)

-- use sclar valued function in slect query
SELECT EmployeeID,EmployeeFirstName,EmployeeLastName
	, dbo.fn_GetEmployeeFullName(EmployeeFirstName, EmployeeLastName) AS FullName
FROM Employee AS emp
WHERE dbo.fn_GetEmployeeFullName(EmployeeFirstName, EmployeeLastName) = 'Santosh Reddy'

-- 2.a)Inline/Single Line table valued function 
	-- returns a table as a result of actions from given input parameters
	-- the value of table should be derived from a single SELECT statement
CREATE FUNCTION fn_GetEmployeeDetails
(
	@Address varchar(100)
)
RETURNS TABLE
AS
	RETURN (SELECT dbo.fn_GetEmployeeFullName(EmployeeFirstName,EmployeeLastName)as FullName
				, Salary
				, Address
				, EmployeeDOB
			From Employee as emp
			LEFT JOIN EmployeeDOB as edob
			ON edob.EmployeeID = emp.EmployeeId
			where emp.Address = @Address
		)

-- == call Table valued function

select * from dbo.fn_GetEmployeeDetails('US')
select * from Employee where EmployeeID = 2

-- 2.b) Multi Line/Multi Statement table valued function
	-- returns a table variable as a result of actions performed on the i/p parameters
	-- the design of table is explicity declared and defined in the returns section
	-- we can derive the data/table using multiple sql statements
CREATE OR ALTER FUNCTION fn_GetEmployeeDetailsML
(
    @EmployeeID INT
)
RETURNS @Emp TABLE 
(
    EmployeeId INT,
    EmployeeFullName VARCHAR(101),
    Salary INT
)
AS
BEGIN
    INSERT INTO @Emp (EmployeeId, EmployeeFullName, Salary)
    SELECT emp.EmployeeID,
           dbo.fn_GetEmployeeFullName(emp.EmployeeFirstName, emp.EmployeeLastName),
           emp.Salary
    FROM Employee AS emp
    WHERE emp.EmployeeID <> @EmployeeID;


	UPDATE @Emp
	SET Salary = 5000
	WHERE EmployeeId IN (2,5)

	DELETE FROM @Emp
	WHERE EmployeeId IN (6,3)

	INSERT INTO @Emp
	SELECT 100,'Dinesh Kumar',2000

    RETURN;
END;

-- where ALT +F! shortcut doesnt work , use sp_help Employee


SELECT * FROM fn_GetEMployeeDetailsMl(4)
Select * from employee

--Using the table valued User defined functions in JOINS

SELECT * 
FROM fn_GetEMployeeDetailsML(4) AS fn
INNER JOIN EmployeeDOB AS emp 
    ON fn.EmployeeId = emp.EmployeeId;



-- To view your results in Text, use Ctrl+T, to view it in Grid use Ctrl+D

sp_help fn_GetEmployeeDetailsM

-- Remove a function from the DB
DROP FUNCTION fn_GetEmployeeDetailsML

SELECT * FROM Employee

--CASE Statement
	--Case is a typical conditional statement that is used during retrieval of the data

SELECT *
	,CASE WHEN EmployeeId % 21 THEN 'Odd' ELSE 'Even' END AS EvenOROdd
FROM Employee

SELECT 13%4

SELECT *	
	,CASE WHEN Salary 1000 THEN '0 to 1000'
	WHEN Salary > 1000 AND Salary <=3000 THEN '1000 to 3000'
	WHEN Salary 3000 AND Salary 4000 THEN '3000 to 4000'
	ELSE > '4000' END AS SalaryGrade
FROM Employee

SELECT FROM Employee

SELECT *
	,IIF(EmployeeId%2= 1, 'EID is Odd', 'EID is Even') AS IIFCondition
FROM Employee

--Program flow of Query Executions

IF(1=2)	
	SELECT 'First Statement'
ELSE IF (2=3)
	SELECT 'Second Statement'