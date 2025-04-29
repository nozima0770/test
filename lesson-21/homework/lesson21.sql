CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    CustomerID INT NOT NULL
);

INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID)
VALUES 
(1, 'Product A', '2023-01-01', 150.00, 2, 101),
(2, 'Product B', '2023-01-02', 200.00, 3, 102),
(3, 'Product C', '2023-01-03', 250.00, 1, 103),
(4, 'Product A', '2023-01-04', 150.00, 4, 101),
(5, 'Product B', '2023-01-05', 200.00, 5, 104),
(6, 'Product C', '2023-01-06', 250.00, 2, 105),
(7, 'Product A', '2023-01-07', 150.00, 1, 101),
(8, 'Product B', '2023-01-08', 200.00, 8, 102),
(9, 'Product C', '2023-01-09', 250.00, 7, 106),
(10, 'Product A', '2023-01-10', 150.00, 2, 107),
(11, 'Product B', '2023-01-11', 200.00, 3, 108),
(12, 'Product C', '2023-01-12', 250.00, 1, 109),
(13, 'Product A', '2023-01-13', 150.00, 4, 110),
(14, 'Product B', '2023-01-14', 200.00, 5, 111),
(15, 'Product C', '2023-01-15', 250.00, 2, 112),
(16, 'Product A', '2023-01-16', 150.00, 1, 113),
(17, 'Product B', '2023-01-17', 200.00, 8, 114),
(18, 'Product C', '2023-01-18', 250.00, 7, 115),
(19, 'Product A', '2023-01-19', 150.00, 3, 116),
(20, 'Product B', '2023-01-20', 200.00, 4, 117),
(21, 'Product C', '2023-01-21', 250.00, 2, 118),
(22, 'Product A', '2023-01-22', 150.00, 5, 119),
(23, 'Product B', '2023-01-23', 200.00, 3, 120),
(24, 'Product C', '2023-01-24', 250.00, 1, 121),
(25, 'Product A', '2023-01-25', 150.00, 6, 122),
(26, 'Product B', '2023-01-26', 200.00, 7, 123),
(27, 'Product C', '2023-01-27', 250.00, 3, 124),
(28, 'Product A', '2023-01-28', 150.00, 4, 125),
(29, 'Product B', '2023-01-29', 200.00, 5, 126),
(30, 'Product C', '2023-01-30', 250.00, 2, 127);

--task 1

SELECT *,
ROW_NUMBER() OVER (ORDER BY SaleDate) as SaleRowNumber
FROM ProductSales;

--task 2

SELECT ProductName,
SUM(Quantity) as TotalQuantitySold,
DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) as QuantityRank
FROM ProductSales
GROUP BY ProductName;

--task 3

WITH RankedSales AS (
    SELECT 
        CustomerID,
        SaleID,
        SaleAmount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS SaleRank
    FROM 
        ProductSales
)
SELECT 
    CustomerID,
    SaleID,
    SaleAmount
FROM 
    RankedSales
WHERE 
    SaleRank = 1;

--task 4

SELECT SaleID, SaleAmount, LEAD(SaleAmount) OVER (ORDER BY SaleDate) as NextSaleAmount
FROM ProductSales;

--task 5

SELECT SaleID, SaleAmount, LAG(SaleAmount) OVER (ORDER BY SaleDate) as PrevSaleAmount
FROM ProductSales;

--task 6

SELECT ProductName, SaleID, SaleAmount, RANK() OVER (PARTITION BY ProductName ORDER BY SaleAmount DESC) AS SaleRank
FROM ProductSales;

--task 7

WITH SalesWithPrevious as (
SELECT SaleID, SaleAmount, LAG(SaleAmount) OVER (ORDER BY SaleDate) as  PreviousSaleAmount
FROM ProductSales
)
SELECT SaleID, SaleAmount, PreviousSaleAmount
FROM SalesWithPrevious
WHERE SaleAmount > PreviousSaleAmount;

--task 8

SELECT ProductName, SaleID, SaleAmount,
SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as DifferenceFromPrevious
FROM ProductSales;

--task 9
SELECT SaleID, SaleAmount, LEAD(SaleAmount) OVER (ORDER BY SaleDate) as NextSaleAmount,
CASE 
WHEN LEAD(SaleAmount) OVER (ORDER BY SaleDate) IS NOT NULL THEN 
(LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount
END AS PercentageChange
FROM ProductSales;

--task 10

SELECT ProductName, SaleID, SaleAmount, 
SaleAmount * 1.0 / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as RatioToPrevious
FROM ProductSales;

--task 11

WITH FirstSales as (
SELECT ProductName, MIN(SaleDate) as FirstSaleDate
FROM ProductSales
GROUP BY ProductName
)
SELECT 
ps.ProductName,
ps.SaleID,
ps.SaleAmount,
ps.SaleAmount - FIRST_VALUE(ps.SaleAmount) OVER (PARTITION BY ps.ProductName ORDER BY ps.SaleDate)
FROM ProductSales ps;


--task 12

WITH SalesWithLag as (
SELECT ProductName, SaleID, SaleAmount, LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) as PreviousSaleAmount
FROM ProductSales)
SELECT ProductName, SaleID, SaleAmount
FROM SalesWithLag
WHERE SaleAmount > PreviousSaleAmount;

--task 13

SELECT SaleID, SaleAmount, SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ClosingBalance
FROM ProductSales;

--task 14

SELECT SaleId, SaleAmount, AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverageLast3
FROM ProductSales;

--task 15

SELECT SaleID, SaleAmount, AVG(SaleAmount) OVER () AverageSaleAmount,
SaleAmount - AVG(SaleAmount) OVER () as DifferenceFromAverage
FROM ProductSales;
-------------------------------------------------
CREATE TABLE Employees1 (
    EmployeeID   INT PRIMARY KEY,
    Name         VARCHAR(50),
    Department   VARCHAR(50),
    Salary       DECIMAL(10,2),
    HireDate     DATE
);

INSERT INTO Employees1 (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'John Smith', 'IT', 60000.00, '2020-03-15'),
(2, 'Emma Johnson', 'HR', 50000.00, '2019-07-22'),
(3, 'Michael Brown', 'Finance', 75000.00, '2018-11-10'),
(4, 'Olivia Davis', 'Marketing', 55000.00, '2021-01-05'),
(5, 'William Wilson', 'IT', 62000.00, '2022-06-12'),
(6, 'Sophia Martinez', 'Finance', 77000.00, '2017-09-30'),
(7, 'James Anderson', 'HR', 52000.00, '2020-04-18'),
(8, 'Isabella Thomas', 'Marketing', 58000.00, '2019-08-25'),
(9, 'Benjamin Taylor', 'IT', 64000.00, '2021-11-17'),
(10, 'Charlotte Lee', 'Finance', 80000.00, '2016-05-09'),
(11, 'Ethan Harris', 'IT', 63000.00, '2023-02-14'),
(12, 'Mia Clark', 'HR', 53000.00, '2022-09-05'),
(13, 'Alexander Lewis', 'Finance', 78000.00, '2015-12-20'),
(14, 'Amelia Walker', 'Marketing', 57000.00, '2020-07-28'),
(15, 'Daniel Hall', 'IT', 61000.00, '2018-10-13'),
(16, 'Harper Allen', 'Finance', 79000.00, '2017-03-22'),
(17, 'Matthew Young', 'HR', 54000.00, '2021-06-30'),
(18, 'Ava King', 'Marketing', 56000.00, '2019-04-16'),
(19, 'Lucas Wright', 'IT', 65000.00, '2022-12-01'),
(20, 'Evelyn Scott', 'Finance', 81000.00, '2016-08-07');

--task 16

SELECT EmployeeID, Name, Salary,
DENSE_RANK() OVER(ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;

--task 17
WITH RankedSalaries as (
SELECT EmployeeID, Name, Department, Salary,
DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
)
SELECT EmployeeID, Name, Department, Salary
FROM RankedSalaries
WHERE SalaryRank <=2;

--task 18

WITH RankedSalaries as (
SELECT EmployeeID, Name, Department, Salary, RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
FROM Employees1
)
SELECT EmployeeID, Name, Department, Salary
FROM RankedSalaries
WHERE SalaryRank = 1;

--task 19

SELECT EmployeeID, Name, Department, Salary, SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Employees1;

--task 20

SELECT EmployeeID, Name, Department, Salary, SUM(Salary) OVER (PARTITION BY Department) as TotalDepartmentSalary
FROM Employees1;

--task 21

SELECT EmployeeID, Name, Department, Salary, SUM(Salary) OVER (PARTITION BY Department) as AverageDepartmentSalary
FROM Employees1;

--task 22

SELECT EmployeeID, Name, Department, Salary, Salary - AVG(Salary) OVER (PARTITION BY Department) as DifferenceFromAverage
FROM Employees1;

--task 23

SELECT EmployeeID, Name, Salary, AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAverageSalary
FROM Employees1;

--task 24

WITH RankedEmployees as (
SELECT EmployeeID, Name, Salary, RANK() OVER (ORDER BY HireDate DESC) AS HireRank
FROM Employees1
)
SELECT SUM(Salary) as TotalSalaryLast3
FROM RankedEmployees
WHERE HireRank <=3;

