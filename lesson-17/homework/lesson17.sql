--Easy Tasks

--task 1

SELECT * FROM Items
WHERE Price > (SELECT AVG(Price) FROM Items);

--task 2


ALTER TABLE Staff
ADD DivisionID INT;

UPDATE Staff SET DivisionID = 1 WHERE StaffID = 101;
UPDATE Staff SET DivisionID = 2 WHERE StaffID = 102;


SELECT * 
FROM Staff
WHERE DivisionID IN (
SELECT DivisionID
FROM Staff
GROUP BY DivisionID
HAVING COUNT(*) > 10
);

--task 3

SELECT *
FROM Staff s 
WHERE Salary > (
SELECT AVG(Salary)
FROM Staff
WHERE DivisionID = s.DivisionID
);

--task 4

SELECT * 
FROM Clients 
WHERE ClientID IN (
SELECT DISTINCT ClientID FROM Purchases
);

--task 5

SELECT *
FROM Purchases p
WHERE EXISTS (
SELECT 1
FROM PurchaseDetails pd
WHERE pd.PurchaseID = p.PurchaseID
);

--task 6
SELECT *
FROM Items
WHERE ItemID IN (
SELECT ItemID
FROM PurchaseDetails
GROUP BY ItemID
HAVING SUM(Quantity) > 100
);

--task 7
SELECT *
FROM Staff
WHERE Salary > (
SELECT AVG(Salary) FROM Staff
);

--task 8

SELECT *
FROM Vendors
WHERE VendorID IN (
SELECT VendorID
FROM Items
WHERE Price < 50
);

--task 9

SELECT MAX(Price) as MaxPrice
FROM Items;

--task 10

SELECT MAX(Total)
FROM (
SELECT SUM(Amount) as Total
FROM Purchases 
GROUP BY PurchaseID
) as Sub;

--task 11

SELECT *
FROM Clients
WHERE ClientID NOT IN (
SELECT DISTINCT ClientID FROM Purchases
);

--task 12

SELECT * 
FROM Items
WHERE CategoryID IN (
SELECT CategoryID
FROM Categories
WHERE CategoryName = 'Electronics'
);

--task 13

SELECT *
FROM Purchases
WHERE PurchaseDate > (
SELECT MAX(PurchaseDate)
FROM Purchases
WHERE PurchaseDate > '2025-01-01'
);

--task 14

SELECT SUM(Quantity) as TotalSold
FROM PurchaseDetails
WHERE PurchaseID = 5;

--task 15

SELECT *
FROM Staff
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5;

--task 16

SELECT * 
FROM Staff s
WHERE Salary > (
SELECT AVG(Salary)
FROM Staff
WHERE DivisionID = s.DivisionID
);

--task 17

SELECT *
FROM Purchases p
WHERE EXISTS (
SELECT 1
FROM PurchaseDetails pd
JOIN Items i ON pd.ItemID = i.ItemID
WHERE pd.PurchaseID = p.PurchaseID
);

--task 18

SELECT *
FROM Clients
WHERE ClientID IN (
SELECT DISTINCT ClientID
FROM Purchases
WHERE PurchaseDate >=DATEADD(DAY, -30, GETDATE())
);

--task 19

SELECT * 
FROM Items
WHERE CreatedDate = (
SELECT MIN(CreatedDate) FROM Items
);


--task 20

SELECT *
FROM Staff
WHERE DivisionID IS NULL;

--Medium Tasks
--task 1

SELECT * 
FROM Staff s1
WHERE EXISTS (
SELECT 1
FROM Staff s2
WHERE s2.DivisionID = s1.DivisionID AND s2.Salary > 100000
);

--task 2

SELECT *
FROM Staff s
WHERE Salary = (
SELECT MAX(Salary)
FROM Staff
WHERE DivisionID = s.DivisionID
);

--task 3

SELECT *
FROM Clients c
WHERE EXISTS (
SELECT 1
FROM Purchases p
WHERE p.ClientID = c.ClientID
)
AND NOT EXISTS (
SELECT 1
FROM Purchases p
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
WHERE p.ClientID = c.ClientID AND i.Price > 200
);

--task 4

SELECT i.*
FROM Items i
WHERE (
SELECT COUNT(*)
FROM PurchaseDetails pd
WHERE pd.ItemID = i.ItemID
) > (
SELECT AVG(OrderCount)
FROM (
SELECT COUNT(*) AS OrderCount
FROM PurchaseDetails
GROUP BY ItemID
) as AvgItemOrders
);

--task 5

SELECT *
FROM Clients
WHERE ClientID IN (
SELECT ClientID
FROM Purchases
GROUP BY ClientID
HAVING COUNT(*) > 3
);

--task 6

SELECT ClientID, SUM(pd.Quantity) AS TotalItemsOrdered
FROM Purchases p
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
WHERE p.PurchaseDate >= DATEADD(DAY, -30, GETDATE())
GROUP BY ClientID;

--task 7

SELECT *
FROM Staff s
WHERE Salary > (
SELECT AVG(Salary)
FROM Staff
WHERE DivisionID = s.DivisionID
);

--task 8
SELECT * 
FROM Items
WHERE ItemID NOT IN (
SELECT DISTINCT ItemID FROM PurchaseDetails
);

--task 9

SELECT *
FROM Vendors
WHERE VendorID IN (
SELECT VendorID
FROM Items 
WHERE Price > (SELECT AVG(Price) FROM Items)
);

--task 10

SELECT 
    i.ItemID, 
    SUM(pd.Quantity * i.Price) AS TotalSales
FROM PurchaseDetails pd
JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
WHERE p.PurchaseDate >= DATEADD(YEAR, -1, GETDATE())
GROUP BY i.ItemID;

--task 11

SELECT *
FROM Staff s
WHERE DATEDIFF(YEAR, s.BirthDate, GETDATE()) > (
SELECT AVG(DATEDIFF(YEAR, Birthdate, GETDATE()))
FROM Staff
);

--task 12

SELECT *
FROM Items
WHERE Price > (SELECT AVG(Price) FROM Items);

--task 13


SELECT DISTINCT c.*
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
WHERE i.CategoryID = (
SELECT CategoryID FROM Categories WHERE CategoryName = 'Electronics'
);

--task 14

SELECT * 
FROM Items
WHERE Quantity > (
SELECT AVG(Quantity) FROM Items
);

--task 15

SELECT *
FROM Staff s
WHERE EXISTS (
SELECT 1
FROM Bonuses b
JOIN Staff s2 ON b.StaffID = s2.StaffID
WHERE s2.DivisionID = s.DivisionID
);

--task 16

SELECT * 
FROM Staff
WHERE Salary >= (
SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Salary)
OVER()
);

--task 17

SELECT DivisionID
FROM Staff
GROUP BY DivisionID
HAVING COUNT(*) =(
SELECT MAX(Cnt)
FROM (
SELECT COUNT(*) AS Cnt
FROM Staff
GROUP BY DivisionID
) as sUB
);

--task 18

SELECT TOP 1 p.PurchaseID, SUM(pd.Quantity * i.Price) as TotalValue
FROM Purchases p
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
GROUP BY p.PurchaseID
ORDER BY TotalValue DESC;


--task 19

SELECT *
FROM Staff s
WHERE Salary > (
SELECT AVG(Salary)
FROM Staff
WHERE DivisionID = s.DivisionID
)
and DATEDIFF(YEAR, HireDate, GETDATE()) > 5;

--task 20

SELECT *
FROM Clients c
WHERE NOT EXISTS (
SELECT 1
FROM Purchases p
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
WHERE p.ClientID = c.ClientID AND i.Price > 100
);

--Difficult Tasks
--task 1

SELECT *
FROM Staff s
WHERE Salary > (
SELECT AVG(Salary)
FROM Staff 
WHERE DivisionID = s.DivisionID
)
AND Salary < (
SELECT MAX(Salary)
FROM Staff
WHERE DivisionID = s.DivisionID
);

--task 2

SELECT DISTINCT i.*
FROM Items i
JOIN PurchaseDetails pd ON i.ItemID = pd.ItemID
JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
WHERE p.ClientID IN (
SELECT ClientID
FROM Purchases
GROUP BY ClientID
HAVING COUNT(*) > 5
);

--task 3

SELECT * FROM Staff
WHERE DATEDIFF(YEAR, Birthdate, GETDATE()) > (
SELECT AVG(DATEDIFF(YEAR, BirthDate, GETDATE())) FROM Staff
)
AND Salary > (SELECT AVG(Salary) FROM Staff);

--task 4

SELECT *
FROM Staff s
WHERE EXISTS (
SELECT 1
FROM Staff s2
WHERE s2.DivisionID = s.DivisionID AND s2.Salary > 100000
GROUP BY s2.DivisionID
HAVING COUNT(*) > 5
);

--task 5

SELECT *
FROM Items
WHERE ItemID NOT IN (
SELECT DISTINCT pd.ItemID
FROM PurchaseDetails pd
JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
WHERE p.PurchaseDate >=DATEADD(YEAR, -1, GETDATE())
);

--task 6

SELECT ClientID
FROM Purchases p
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
GROUP BY p.ClientID
HAVING COUNT(DISTINCT i.CategoryID) >=2;

--task 7

SELECT * FROM Staff;
SELECT *
FROM Staff s
WHERE Salary > (
SELECT AVG(Salary)
FROM Staff
WHERE JobTitle = s.JobTitle
);

--task 8

SELECT *
FROM Items
WHERE Price >= (
SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Price)
OVER()
);

--task 9

SELECT *
FROM Staff s1
WHERE Salary >= (
SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY s2.Salary)
OVER()
FROM Staff s2
WHERE s2.DivisionID = s1.DivisionID
);

--task 10

SELECT *
FROM Staff s
WHERE NOT EXISTS (
SELECT 1
FROM Bonuses b
WHERE b.StaffID = s.StaffID AND b.BonusDate >= DATEADD(MONTH, -6, GETDATE())
);

--task 11
SELECT i.*
FROM Items i
WHERE (
SELECT COUNT(*)
FROM PurchaseDetails pd
WHERE pd.ItemID = i.ItemID
) > (
SELECT AVG(OrderCount)
FROM (
SELECT COUNT(*) AS OrderCount
FROM PurchaseDetails
GROUP BY ItemID
) as AvgOrders
);

--task 12

SELECT DISTINCT c.*
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID
JOIN PurchaseDetails pd ON p.PurchaseID = pd.PurchaseID
JOIN Items i ON pd.ItemID = i.ItemID
WHERE YEAR(p.PurchaseDate) = YEAR(DATEADD(YEAR, -1, GETDATE()))
AND i.Price > (SELECT AVG(Price) FROM Items);

--task 13

SELECT DivisionID
FROM Staff
GROUP BY DivisionID 
HAVING AVG(Salary) = (
SELECT MAX(AvgSalary)
FROM (
SELECT AVG(Salary) as AvgSalary
FROM Staff
GROUP BY DivisionID
) as DivisionAvgs
);

--task 14

SELECT DISTINCT i.*
FROM Items i
JOIN PurchaseDetails pd ON i.ItemID = pd.ItemID
JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
WHERE p.ClientID IN (
SELECT ClientID
FROM Purchases
GROUP BY ClientID
HAVING COUNT(*) > 10
);

--task 15

SELECT *
FROM Staff s
WHERE DivisionID = (
SELECT TOP 1 DivisionID
FROM Staff s2
JOIN Sales sa ON s2.StaffID = sa.StaffID
GROUP BY s2.DivisionID
ORDER BY SUM(sa.Amount) DESC
);

--task 16

SELECT *
FROM Staff
WHERE Salary >= (
SELECT PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Salary)
OVER ()
);

--task 17

SELECT *
FROM Items
WHERE ItemID NOT IN (
SELECT DISTINCT pd.ItemID
FROM PurchaseDetails pd
JOIN Purchases p ON pd.PurchaseID = p.PurchaseID
WHERE p.PurchaseDate >=DATEADD(MONTH, -1, GETDATE())
);

--task 18

SELECT *
FROM Staff s
WHERE DivisionID IN (
SELECT DivisionID
FROM Staff s2
JOIN Purchases p ON s2.StaffID = p.StaffID
GROUP BY s2.DivisionID
HAVING SUM(p.Amount) = (
SELECT MAX(Total)
FROM (
SELECT SUM(p2.Amount) as Total
FROM Staff s3
JOIN Purchases p2 ON s3.StaffID = p2.StaffID
GROUP BY s3.DivisionID
) as Totals
)
);

--task 19

SELECT *
FROM Clients c
WHERE NOT EXISTS (
SELECT 1
FROM Purchases p
WHERE p.ClientID = c.ClientID AND p.PurchaseDate >= DATEADD(MONTH, -6, GETDATE())
)
AND (
SELECT ISNULL(SUM(Amount), 0)
FROM Purchases
WHERE ClientID = c.ClientID
) < 100;

--task 20

SELECT DISTINCT s.*
FROM Staff s
JOIN Purchases p ON s.StaffID = p.StaffID
WHERE DATEDIFF(YEAR, s.HireDate, GETDATE()) > 10
AND p.Amount > 1000;
