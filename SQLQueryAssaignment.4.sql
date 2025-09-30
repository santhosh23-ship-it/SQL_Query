---1.Use the inbuilt functions and find the minimum, maximum and average amount from the orders table


select MAX(amount) as Maximum_Amount from Orders
select MIN(amount) as Minnimum_Amount from Orders
select AVG(amount) as Average_Amount from Orders

 --2.Create a user-defined function which will multiply the given number with 10
 
create function dbo.MultiplyByTen(@Number INT)
returns int
as 
begin 
   return @Number * 10
end
go

select dbo.MultiplyByTen(7) as result 
 --3.Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value.

select case 
       when 100 < 200 then '100 is Less than 200'
       when 100 > 200 then '100 is Greater than 200'
       else '100 is Equal to 200'
  end as ComparisonResult
 --4.Using a case statement, find the status of the amount. Set the status of the amount as high amount, low amount or medium amount based upon the condition.
   
select 
    order_id,
    customer_id,
    Amount,
    case 
       when Amount < 500 then 'Low Amount'
       when Amount Between 500 and 1000 then 'Medium Amount'
       else 'High Amount'
  end as Amount_Status
from Orderss
  
 --5.Create a user-defined function, to fetch the amount greater than then given input
 CREATE FUNCTION dbo.GetAmountGreaterThan (@InputAmount DECIMAL(10,2))
RETURNS TABLE
AS
RETURN
(
    SELECT OrderID, CustomerId, Amount
    FROM Orders
    WHERE Amount > @InputAmount
)
GO

SELECT * FROM dbo.GetAmountGreaterThan(1000);