CREATE TABLE Orderss
(
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount INT,
    customer_id INT
);


INSERT INTO Orderss(order_id, order_date, amount, customer_id)
VALUES
(1, '2025-09-20', 500, 1),
(2, '2025-09-21', 750, 2),
(3, '2025-09-22', 300, 3),
(4, '2025-09-23', 1200, 4),
(5, '2025-09-24', 950, 5);

--.Make an inner join on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column
SELECT c.First_name, c.Laste_name, o.order_id, o.order_date, o.amount
FROM Customerr c
INNER JOIN Orderss o
ON c.Customerid = o.customer_id;


--Make left and right joins on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column
SELECT c.First_name, c.Laste_name, o.order_id, o.order_date, o.amount
FROM Customerr c
LEFT JOIN Orderss o
ON c.Customerid = o.customer_id;

--Make a full outer join on ‘Customer’ and ‘Orders’ table on the ‘customer_id’ column
SELECT c.First_name, c.Laste_name, o.order_id, o.order_date, o.amount
FROM Customerr c
FULL OUTER JOIN Orderss o
ON c.Customerid = o.customer_id;

--Update the ‘Orders’ table and set the amount to be 100 where ‘customer_id’ is 3

UPDATE Orderss
SET amount = 100
WHERE customer_id = 3;

select * from Orderss
 


 
