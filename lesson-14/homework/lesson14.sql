--Easy tasks
--task 1
WITH Numbers AS (
SELECT 1 AS Num
UNION ALL
SELECT Num +1 
FROM Numbers 
WHERE Num < 100
)
SELECT * FROM Numbers
OPTION (MAXRECURSION 100);

--task 2
WITH Doubles AS (
SELECT 1 AS Num
UNION ALL
SELECT Num * 2
FROM Doubles
WHERE Num < 1000
)
SELECT * FROM Doubles 
OPTION (MAXRECURSION 100);

--task 3

SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees14 e
JOIN (
SELECT EmployeeID, SUM(SaleAmount) AS TotalSales
FROM Sales14
GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID;


--task 4

WITH AvgSalaryCTE AS (
SELECT AVG(Salary) AS AvgSalary FROM Employees14
)
SELECT * FROM AvgSalaryCTE;

--task 5
SELECT p.ProductID, p.ProductName, hs.MaxSale
FROM Products14 p
JOIN (
SELECT ProductID, MAX(SaleAmount) AS MaxSale
FROM Sales14
GROUP BY ProductID
) hs ON p.ProductID = hs.ProductID;

--task 6
WITH SalesCount AS (
SELECT EmployeeID, COUNT(*) AS SaleCount
FROM Sales14
GROUP BY EmployeeID
)
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees14 e
JOIN SalesCount sc ON e.EmployeeID = sc.EmployeeID
WHERE sc.SaleCount >5;

--task 7

WITH ProductSales as (
SELECT ProductID, SUM(SaleAmount) as TotalSales
FROM Sales14 
GROUP BY ProductID
)
SELECT p.ProductID, ProductName, ps.TotalSales
FROM Products14 p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500;

--task 8

WITH AvgSalary AS (
SELECT AVG(Salary) AS Avg FROM Employees14
)
SELECT * FROM Employees14
WHERE Salary > (SELECT Avg FROM AvgSalary);

--task 9
SELECT SUM(TotalSold) AS TotalProductsSold
FROM (
SELECT ProductID, SUM(SaleAmount) AS TotalSold
FROM Sales14
GROUP BY ProductID
) AS ProductTotals;


--task 10

WITH EmployeeSales AS (
SELECT DISTINCT EmployeeID FROM Sales14
)
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees14 e
WHERE e.EmployeeID NOT IN (SELECT EmployeeID FROM EmployeeSales);

--Medium Tasks

--task 1
DECLARE @Num INT = 5;

WITH FactorialCTE (N, Factorial) AS (
SELECT 1,1
UNION ALL
SELECT N+1, (N+1) * Factorial
FROM FactorialCTE
WHERE N+1 <=@Num
)
SELECT * FROM FactorialCTE;

--task 2
WITH Fibonacci (n,a,b) AS (
SELECT 1,0,1
UNION ALL
SELECT n+1, b, a+b
FROM Fibonacci
WHERE n<10
)
SELECT n, a AS FibonacciValue FROM Fibonacci;

--task 3

DECLARE @str NVARCHAR(100) = 'SQL';

WITH SplitChars AS (
SELECT 1 AS Position, SUBSTRING(@str, 1, 1) AS Character
UNION ALL
SELECT Position +1, SUBSTRING(@str, Position+1, 1)
FROM SplitChars
WHERE Position < LEN(@str)
)
SELECT * FROM SplitChars
OPTION (MAXRECURSION 100);

--task 4
WITH EmployeeSales AS (
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(s.SaleAmount) AS TotalSales
FROM Employees14 e
JOIN Sales14 s ON e.EmployeeID = s.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
) 
SELECT *, RANK() OVER (ORDER BY TotalSAles DESC) AS SalesRank
FROM EmployeeSales;

--task 5

SELECT TOP 5 e.EmployeeID, e.FirstName, e.LastName, orders.TotalOrders
FROM Employees14 e
JOIN (
SELECT EmployeeID, COUNT(*) AS TotalOrders
FROM Sales14 
GROUP BY EmployeeID
) orders ON e.EmployeeID = orders.EmployeeID
ORDER BY orders.TotalOrders DESC;

--task 6
WITH MonthlySales AS (
SELECT EmployeeID,
FORMAT (SaleDate, 'yyyy-MM') AS SaleMonth
SUM(SaleAmount) AS MonthlySales
FROM Sales14 
GROUP BY EmployeeID, FORMAT(SaleDate,'yyyy-MM')
),
SalesDiff AS (
SELECT curr.EmployeeID, curr.SaleMonth,
curr.MonyhlySales,
prev.MonthlySales AS PreviousMonthSales,
curr.MonthlySales - ISNULL(prev.MonthlySales, 0) AS SalesDifference
FROM MonthlySales curr
LEFT JOIN MonthlySales prev
ON curr.EmployeeID = prev.EmployeeID
AND DATEADD(MONTH, -1, CAST(curr.SaleMonth + '-01' AS DATE)) CAST(prev.SaleMonth + '-01' AS DATE)
)
SELECT * FROM SaleDiff;

--task 7
SELECT c.CategoryID, c.CategoryName, category_sales.TotalSAles
FROM Categories14 c
JOIN Products14 p ON c.CategoryID = p.CategoryID
JOIN ( 
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales14
GROUP BY ProductID
) category_sales ON p.ProductID = category_sales.ProductID;

--task 8

WITH ProductSales AS (
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales14
WHERE SaleDate >=DATEADD(YEAR, -1, GETDATE())
GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales,
RANK() OVER (ORDER BY ps.TotalSales DESC) AS RankInyear
FROM ProductSales ps
JOIN Products14 p ON ps.ProductID = p.ProductID;

--task 9

SELECT e.EmployeeID, e.FirstName, e.LastName, q.Quarter, q.TotalSales
FROM Employees14 e
JOIN (
SELECT EmployeeID, 
CONCAT(YEAR(SaleDate), '-Q', DATEPART(QUARTER, SaleDate)) AS Quarter,
SUM(SaleAmount) AS TotalSales
FROM Sales14
GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
) q ON e.EmployeeID = q.EmployeeID
WHERE q.TotalSales > 5000;

--task 10

SELECT TOP 3 e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees14 e
JOIN (
 SELECT EmployeeID, SUM(SaleAmount) AS TotalSales
 FROM Sales14
 WHERE SaleDate >= DATEADD(MONTH, -1, GETDATE())
 AND SaleDate < DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
 GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalSales DESC;

--Difficult Tasks

--task 1

DECLARE @n INT = 5;

WITH BuildSequence (Num, Sequence) AS (
    SELECT 1, CAST('1' AS VARCHAR(10))  
    UNION ALL
    SELECT Num + 1, CAST(Sequence + CAST(Num + 1 AS VARCHAR(10)) AS VARCHAR(10))  
    FROM BuildSequence
    WHERE Num + 1 <= @n
)
SELECT Sequence FROM BuildSequence
OPTION (MAXRECURSION 100);

--task 2

SELECT TOP 1 e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees14 e
JOIN (
SELECT EmployeeID, SUM(SaleAmount) AS TotalSales
FROM Sales14
WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalSales DESC;

--task 3
WITH NumberBalance AS (
SELECT 5 AS Value 
UNION ALL
SELECT Value +1 FROM NumberBalance WHERE Value < 10
UNION ALL
SELECT Value -1 FROM NumberBalance WHERE Value > 0
)
SELECT DISTINCT Value FROM NumberBalance
ORDER BY Value
OPTION (MAXRECURSION 100);

--task 4

SELECT 
    s.EmployeeID,
    s.StartTime,
    s.EndTime,
    ISNULL(a.ActivityName, 'Work') AS Task
FROM Schedule s
LEFT JOIN Activity a
  ON s.EmployeeID = a.EmployeeID
 AND s.StartTime = a.StartTime
 AND s.EndTime = a.EndTime;

 --task 5
 WITH DeptSales AS (
    SELECT e.DepartmentID, s.ProductID, SUM(s.SaleAmount) AS TotalSales
    FROM Employees14 e
    JOIN Sales14 s ON e.EmployeeID = s.EmployeeID
    GROUP BY e.DepartmentID, s.ProductID
)
SELECT d.DepartmentName, p.ProductName, ds.TotalSales
FROM (
    SELECT * FROM DeptSales
) ds
JOIN Departments d ON ds.DepartmentID = d.DepartmentID
JOIN Products14 p ON ds.ProductID = p.ProductID;
