/*
Stored Procedures
Calculation of Salaries of employees
	 You might need the list of active employees from the employee table	 
	 You have the salary divided into HRA, DA, Basic -- Additional Amount	 
	 You also have to pay bonuses/incentives -- Additional Amount
	 You need the leaves
	 You also have LOP's -- Deductible Amount
	 You have to encash their leaves -- Additional Amount
	 They have to pay taxes -- Deductible amount
SQL Stored Procedures are block or batch(es) of SQL statements 
	That are executed together
	In a specific sequence
	To serve definite business purpose
which can be reused as and when required and it is accessible to everyone
who has access to the database 
WHAT ? A stored Proc can do whatever a normal T-SQL statement can do 
	unlike functions which can only perform retrivals of data from tables.
WHERE ? It is created and becomes a part of the database. It is stored in the 
	schema where it is created. The default schema like other db objects is dbo
	unless we specify another schema where it should be created.
WHY ? 
1. Encapsulation : OOPS(Object Oriented Programming concepts). Binds 
	complicated business logic into a single unit without exposing the internal
	content.
2. Reusuability : SP's are reusuable and can be called multiple number of times
	based on need by users having execute permissions on them.
3. Maintainabilty : The logic inside the SP can be controlled/maintained
	from a centralized location.
4. Execution Plan Caching : 
	- Parsing  (20%) - X
	- Compiled (40%) - X
	- Executes (40%)
	 The SP when created is parsed and compiled. So it does not compile everytime it is run.
	 It also caches the best execution plan in the few initial runs.
		a. Execution plan is the path used by SQL optimizer to execute your query
			and return the result.
		b. SQL server creates the execution plan during the query execution
		c. SQL Server takes that little bit of extra time in compiling your code 
			+ creating the execution plan
*/

-- Creation of Stored Procedure
CREATE OR ALTER PROCEDURE csp_GetData
AS
BEGIN
	SELECT *
	FROM Employee
END
 
--Execute the Stored Procedure
EXEC csp_GetData 

--ALTERING SP to add/remove columns
CREATE OR ALTER PROCEDURE dbo.csp_GetData
AS
BEGIN
	SELECT EmployeeId,EmployeeFirstName,EmployeeLastName,Address
	FROM Employee
END
EXEC csp_GetData

--Adding a paramter
ALTER PROCEDURE dbo.csp_GetData
(
	@EmployeeId int = 0 -- Default value to a parameter makes it optional
)
AS
BEGIN
	SELECT emp.EmployeeId,dbo.fn_GetEmployeeFullName(EmployeeFirstName,EmployeeLastName) AS FullName
				,Address,EmployeeDOB
	FROM Employee AS emp
	LEFT JOIN EmployeeDOB AS edob ON edob.EmployeeID = emp.EmployeeId
	WHERE emp.EmployeeId = @EmployeeId OR @EmployeeId = 0 --(FALSE OR TRUE)
END
EXEC csp_GetData @EmployeeId = 4
GO
SELECT * FROM EmployeeDOB

--Adding an additional paramter
CREATE OR ALTER PROCEDURE dbo.csp_GetData
(
	@EmployeeId int = 0 -- Optional Paramter
	,@EmployeeAddress varchar(100) -- Mandatory Parameter
)

/*

Date		ModifiedBy	Comments

15-05-2021	Dinesh		CreatedNew proc

20-05-2021	John		Modifed to add Salary Column

07-12-2022	Dinesh		ExplainedProc

*/

AS

BEGIN

	SELECT EmployeeId,dbo.fn_GetEmployeeFullName(EmployeeFirstName,EmployeeLastName) AS FullName

		,Address

	FROM Employee

	WHERE (EmployeeId = @EmployeeId OR @EmployeeId = 0)

	AND Address = @EmployeeAddress

END
 
EXEC csp_GetData  @EmployeeAddress = 'US',@EmployeeId = 2
 
SELECT * FROM Employee
 
-- To view the definition of the SP

sp_helptext csp_GetData
 
CREATE OR ALTER PROCEDURE csp_SetData

(

	@EmployeeID INT

	, @EmployeeFirstName varchar(100)

	, @EmployeeLastName varchar(100)

	, @Salary INT

	, @Address varchar(200)

)

AS

BEGIN

	IF NOT EXISTS(SELECT * FROM Employee WHERE EmployeeId = @EmployeeID)	

		INSERT INTO Employee(EmployeeId, EmployeeFirstName,EmployeeLastName,Salary,Address)

		SELECT @EmployeeID, @EmployeeFirstName,@EmployeeLastName,@Salary,@Address

	ELSE

		PRINT 'EmployeeID Already exists!! Please choose a new ID'

END
 
EXEC csp_SetData 10,'Leo','Smith',2000,'US'
 
EXEC csp_SetData 8,'James','Harmes',5000,'UK'
 
SELECT * FROM Employee

sp_helptext csp_SetData

-- Views

	-- View could be looked as an additional layer on top of a table which enables us to protect

		-- sensitive information based on our needs

	-- View is just a query on top of a table

	-- As this is just a layer on top of a table, views do not store any data physically in the server

	-- Instead, the data when requested, the query is executed and the data is returned