select * from Employee
 
select *,Grade =
case
when Salary<1500 then 'C'
when Salary<=3000 then 'B'
When Salary>3000 then 'A'
else 'Salary Not Defined'
end
from Employee
 
 
-- Order By - helps us to arrange data in ascending or descending order
-- Group By and Having  
-- Except and Intersect
-- UNION and UNION ALL
-- Ranking Functions
 
-- Order By
	-- When there is a request from the Business to deliver Reports or Metrics for some analysis
		--, they might also need data to be arranged (in a particular order).
	-- Ascending or Descending
	-- The Order By Clause in SQL helps us in achieveing this
	-- The default ordering mechanism in SQL is Ascending order
	-- If we want to force the sorting to be in descending order, we need to specify it explicitly(DESC)
	-- We can have sorting applied on more than one column in the table
	-- The second column is only used, when the first column sorting returns the same value
	-- You have to specify the sorting mechanism for each column individually
SELECT *
FROM Employee
ORDER BY Salary DESC, EmployeeId asc
 
	-- You can also sort data using the column position/index in the SELECT
	-- This is not the ideal way
	-- Cases when the SELECT statement is altered, might be bad for this kind of sorting
SELECT EmployeeFirstName, Salary, Address, EmployeeLastName
FROM Employee
ORDER BY 2 DESC-- Column Position for the Salary column
	, 1 asc -- Column Position for the EmployeeID column
 
select * from Employee
where Salary=(select max(Salary) from Employee)
 
 
/*
For integer values
1      -- -5,-30,12,25,35,0,1 --> asc -32,-5,0,1,12,25,35  desc 35,25,12,1,0,-5,-32 (int data type)
2
3
4
5
.
.
11
.
.
.
22
23
.
.
 
 
Dineshkumar    --abc, aag,bba, bac --> asc aag,abc,bac, bba  -->desc  (varachar data type --> for alphabetical values)
Dillipkumar
 
For varchar data type : 
(Special Characters)  --> Vyanktj19@gmail.com  -->
 
1             --> EmpId varachar(10) --> 1,11,333,2222  --> asc 1,11,333,2222 (int) asc 1,11,2222,333 (varchar)
11
1211    -->varchar  1,2,3,11,222,56,22,33,1111,333,2222,4,12
. int asce ---> 1,2,3,4,11,12,22,33,56,222,333,1111,2222
  varchar asc --> 1,11,1111,12, 2,22,222,2222, 33,333,4,56
.
.
2
22
222
2222
3
33
333
A  -1
B   2
C  3
D  4
 
varchar  1,2,3,11,222,56,22,33,1111,333,2222,4,12
int 
varchar  
*/
-- v@gmail.com , wow !!! , v.j@gmail.com , v-j@gmail.com, v_j@gmail.com
SELECT ASCII('!') as '!',ASCII('#') as '#', ASCII('@') as '@',ASCII('&') as '&',ASCII('-') as '-',ASCII('*') as '*'
 
--ASC= !,#,&,@ , *, -
CREATE TABLE intSort
(
	id int
)
 
INSERT INTO intSort(id)
SELECT 1 UNION ALL
SELECT 2 UNION ALL
SELECT 3 UNION ALL
SELECT 11 UNION ALL
SELECT 12 UNION ALL
SELECT 22 UNION ALL
SELECT 44 UNION ALL
SELECT 222 UNION ALL
SELECT 111 UNION ALL
SELECT -10 UNION ALL
SELECT -5 UNION ALL
SELECT -13
 
SELECT * FROM intSort
ORDER BY id desc

CREATE TABLE TextSort
(
	id varchar
)
 
INSERT INTO TextSort(id)
SELECT '!hello' UNION ALL
SELECT 'Hello' UNION ALL
SELECT 'Hhello' UNION ALL
SELECT '@hello' UNION ALL
SELECT '#hello' UNION ALL
SELECT '123.45' UNION ALL
SELECT '2.46' UNION ALL
SELECT '-10'
 
--alpha + num+ spl char -- > splchar(anscii), numeric (0-9), alph (A-Z,a-z),
 
SELECT * FROM TextSort
ORDER BY id ASC

-- Group By

create table population
(Country varchar(10),city varchar(10),Town varchar(10), Population int)

insert into Population
values('C1','CT1','T1',100),
('C2','CT2','T2',23),
('C3','CT3','T3',87),
('C4','CT4','T4',10),
('C5','CT5','T5',15),
('C6','CT6','T6',60),
('C7','CT7','T7',70)

select * from population

-- total sum of population
select sum(Population)
from population

-- total polutaion based on country
select country,sum(Population) as TotalPopulation
from population
group by Country

-- total polutaion based on country
select city,sum(Population) as TotalPopulation
from population
group by City

select Country,city,sum(Population) SumOfPopulation
from population
group by Country,City

-- Filter data before Group by
	-- here the data is first filtered andthe it is grouped
select City,sum(Population) as TotalPopulation
from population
where City <> 'CT4' -- and sum(population) < 150
group by City


select City,sum(Population) as TotalPopulation
from population
where City = 'CT3' or City ='CT4' -- and sum(population) < 150
group by City

-- Filter the data after grouping (Filter aggregated data)
	-- For aggregated data filtering, we need to use the HAVING clause

select City,sum(Population) as SumOfPopulation
from population
where City <> 'CT3'
group by City
having sum(Population) < 70
order by city

--load world_population data
select * from world_population
/*
-- Sequence in which the commands need to be written
--SELECT DISTINCT TOP (n), ColumnNames, FUNCTIONS
From
[INNER/LEFT/CROSS] JOIN...ON
WHERE
GROUP BY
HAVING
ORDER BY
[INNER/LEFT/CROSS] JOIN......ON
WHERE
GROUP BY
HAVING
ORDER BY

Sequence in which the parts of a query is excuted
FROM
JOIN(INNER?OUTER?CROSS)
ON
WHERE
GROUP BY
HAVING
DISTINCT
ORDER BY
TOP
Column List/[*]/Functions
*/

-- UNION vs UNION ALL
	-- When data returned from a SELECT using a UNION, it always returns UNIQUE data in case there 
		-- are duplicates
	-- When data retruned from a SELECT using a UNION ALL, it will return duplicated data 
		-- when there are duplicate values
	-- As a reason, UNION runs slower as compared to a UNION ALL
	-- When you run UNION, UNION ALL on tables, you need to remember 2 things : 
		-- No of columns selected from the tables are the same
		-- The columns that are retunred should be of the same data type

		SELECT 1 UNION ALL
SELECT 2 UNION ALL
SELECT 2 

SELECT 1 UNION 
SELECT 2 UNION 
SELECT 2 

SELECT EmployeeId, EmployeeFirstName FROM Employee -- 9
UNION all
SELECT * FROM PrimaryKeyTest -- 2
UNION ALL
SELECT * FROM UniqueTest -- 3

SELECT EmployeeId,EmployeeFirstName FROM Employee--9
UNION 
SELECT * FROM PrimaryKeyTest--2
UNION 
SELECT * FROM UniqueTest--3

-- Except operator
	-- Return the records which are present in first SELECT only but missing in second select
	-- When you run UNION, UNION ALL, EXCEPT, INTERSECT on tables, you need to remember 2 things : 
		-- No of columns selected from the tables are the same
		-- The columns that are retunred should be of the same data type

-- F1 = Apples, Oranges, Bananas
-- F2 = Apples, Oranges, Papaya
 --F1 except F2  --> Bananas
 --F2 except F1 ---> Papaya


SELECT Id,Name
FROM DefaultTest
--select * from defaulttest
SELECT *
FROM PrimaryKeyTest

SELECT Id,Name
FROM DefaultTest
EXCEPT
SELECT Id,Name
FROM PrimaryKeyTest

SELECT *
FROM PrimaryKeyTest
EXCEPT
SELECT Id,Name
FROM DefaultTest

-- INTERSECT Operator
	-- The common records between both the SELECT statements

-- F1 = Apples, Oranges, Bananas
-- F2 = Apples, Oranges, Papaya
--F1 intersect F2 -->Apples, Oranges
--F2 intersects F1 -->Apples, Oranges

SELECT Id,Name
FROM DefaultTest
INTERSECT
SELECT *
FROM PrimaryKeyTest

SELECT Id,Name
FROM PrimaryKeyTest
INTERSECT
SELECT Id,Name
FROM DefaultTest

-- Ranking Functions
	-- Ranking Functions helps us in assigning rank to each of the rows based on certain values
	-- Types of Ranking Functions : 
		-- ROW_NUMBER
		-- RANK
		-- DENSE_RANK
--SELECT * INTO Ranking 

Event Javeline Throw

Player  Score(Desc)    ROW_NUMBER   RANK              DENSE_RANK
A        89.8           1            1 GOLD MEDAL       1
B        89.6           2            2 SILVER MEDAL     2 
C        89.6           3            2 SILVER MEDAL     2
D        89.4           4            4    


CREATE TABLE Ranking (
    Country CHAR(3),
    City VARCHAR(50),
    Population INT
)
INSERT INTO Ranking (Country, City, Population) VALUES
('A', 'Z', 452345),
('A', 'M', 687688),
('A', 'G', 687688),
('B', 'N', 935676),
('B', 'O', 126863),
('B', 'P', 445678),
('B', 'Q', 434645),
('B', 'R', 789768),
('B', 'S', 345324),
('B', 'H', 345324);
select * from Ranking;

SELECT * FROM Ranking

-- ORDER BY
SELECT *
	, ROW_NUMBER() OVER(ORDER BY Population DESC) AS Row_Value 
FROM Ranking
SELECT *
	, RANK() OVER(ORDER BY Population DESC) AS RnkValue
FROM Ranking
SELECT *
	, DENSE_RANK() OVER(ORDER BY Population DESC) AS Dense_Rank
FROM Ranking

SELECT *
	, ROW_NUMBER() OVER(ORDER BY Population DESC) AS Row_Value 
	, RANK() OVER(ORDER BY Population DESC) AS RnkValue
	, DENSE_RANK() OVER(ORDER BY Population DESC) AS Dense_Rank
FROM Ranking
-- ORDER BY combined with the Partition By

-- ROW_NUMBER
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Population DESC) AS Rows_Number
FROM Ranking

-- RANK
SELECT *,
	RANK() OVER(PARTITION BY Country ORDER BY Population DESC) AS RankValue
FROM Ranking

-- DENSE_RANK
SELECT *,
	DENSE_RANK() OVER(PARTITION BY Country ORDER BY Population DESC) AS RankValue
FROM Ranking
where Country='A'

-- CTE (Common Table Expression)
-- It is a temp object
-- It has a very limited scope
-- Can be used only in the first statement right after it is created
-- In the memory
-- Connected object

-- To get the third highest populated city across countries
;with RankedPopulation
AS
(
	SELECT *,
		DENSE_RANK() OVER(PARTITION BY Country ORDER BY Population DESC) AS RankValue
	FROM Ranking
)
SELECT * FROM RankedPopulation
WHERE RankValue IN (3)
-- How to get the 3rd highest populated cities in the whole table
with RankedPopulation
AS
(
	SELECT *,
		DENSE_RANK() OVER(ORDER BY Population DESC) AS RankValue
	FROM Ranking
)
SELECT * FROM RankedPopulation
WHERE RankValue IN (3)

SELECT * FROM RankedPopulation
WHERE RankValue IN (2)

select * from world_population
-- Ques:applying ranking functions on based 2022 population column
-- partition by continent

select Continent, Country_Territory,_2022_Population,
Rank() over(Order by _2022_population desc) As World_Rank,
Dense_Rank() over(Order by _2022_population desc) As World_DenseRank,
Row_Number() over(Order by _2022_population desc) As World_Row_Rank
from world_population

select Continent, Country_Territory _2022_Population,
Rank() over(partition by Continent Order by _2022_population desc) As World_Rank,
Dense_Rank() over(Order by _2022_population desc) As World_DenseRank,
Row_Number() over(Order by _2022_population desc) As World_Row_Rank
from world_population

select Continent , Count(*) as Country_Count from world_population
group by Continent

select count(distinct Continent) as total_Continents
from world_population

select Continent , sum(Cast(_2022_Population as bigint)) as Total_2022_Population
from world_population
group by Continent
order by Total_2022_Population desc
