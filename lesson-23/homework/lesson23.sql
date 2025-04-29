--task 1
CREATE TABLE Dates (
    Id INT,
    Dt DATETIME
);
INSERT INTO Dates VALUES
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');

SELECT 
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS formatted_month
FROM Dates;

-- task 2
CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);


WITH MaxValsPerGroup AS (
    SELECT 
        Id, rId, 
        MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rId
)
SELECT 
    COUNT(*) AS Unique_Id_Count,
    SUM(MaxVal) AS SumOfMaxVals
FROM MaxValsPerGroup;

--task 3
CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');

SELECT *
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

--task 4

CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);

SELECT ID, Item, Vals
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY Id ORDER BY Vals DESC) AS rnk
    FROM TestMaximum
) AS ranked
WHERE rnk = 1;

--task 5

CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);

SELECT Id, SUM(MaxValue) AS TotalMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxValue
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS grouped
GROUP BY Id;

--task 6

CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

SELECT 
    Id,
    a,
    b,
    CASE 
        WHEN a - b <> 0 THEN a - b 
        ELSE NULL 
    END AS Diff
FROM TheZeroPuzzle;


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50)
);
INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region)
VALUES
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North'),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North'),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East'),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West'),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South'),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South'),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East'),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North'),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West'),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East'),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South'),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North'),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West'),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South'),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East'),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North'),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South'),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East'),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West'),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North');

--task 7

SELECT SUM(UnitPrice * QuantitySold) as TotalRevenue
FROM Sales;

--task 8

SELECT AVG(UnitPrice) as AverageUnitPrice
FROM Sales;

--task 9

SELECT COUNT(*) AS TotalTransactions
FROM Sales;

--task 10

SELECT MAX(QuantitySold) as MaxUnitsSold
FROM Sales;

--task 11
SELECT Category, COUNT(DISTINCT Product) as ProductsSold
FROM Sales
GROUP BY Category; 

--task 12

SELECT r.RegionName, SUM(s.UnitPrice * s.Quantity) as TotalRevenue
FROM Sales s 
JOIN Customers c ON s.CustomerID = c.CustomerID
JOIN Regions r ON c.RegionID = r.RegionID
GROUP BY r.RegionName;

--task 13

SELECT FORMAT(s.SaleDate, 'yyyy-MM') as Month, SUM(s.QuantitySold) as TotalQuantity
FROM Sales s
GROUP BY FORMAT(s.SaleDate, 'yyyy-MM')
ORDER BY Month;

--task 14

SELECT TOP 1 p.ProductName, SUM(s.UnitPrice * s.QuantitySold) as Revenue
FROM Sales s
JOIN Products p ON s.Product = p.ProductID
GROUP BY p.ProductName
ORDER BY REVENUE DESC;
--task 15

SELECT s.SaleDate,
SUM(s.UnitPrice * s.QuantitySold) OVER (ORDER BY s.SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningRevenue
FROM Sales s;

--task 16

WITH CategoryRevenue AS (
  SELECT c.CategoryName, SUM(s.UnitPrice * s.QuantitySold) AS Revenue
  FROM Sales s
  JOIN Products p ON s.Product = p.ProductID
  JOIN Categories c ON p.Category = c.CategoryID
  GROUP BY c.CategoryName
)
SELECT CategoryName,
       Revenue,
       Revenue * 100.0 / SUM(Revenue) OVER() AS PercentageContribution
FROM CategoryRevenue
ORDER BY PercentageContribution DESC;

--task 17

CREATE TABLE Customers23 (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);
INSERT INTO Customers23 (CustomerName, Region, JoinDate)
VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');

SELECT s.SaleID, c.CustomerName, s.Product, s.QuantitySold, s.UnitPrice, s.SaleDate
FROM Sales s
JOIN Customers23 c ON s.CustomerID = c.CustomerID;

--task 18

SELECT c.CustomerID, c.CustomerName
FROM Customers23 c
WHERE c.CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Sales);

--task 19

SELECT c.CustomerName, SUM(s.UnitPrice * s.QuantitySold) AS TotalRevenue
FROM Sales s
JOIN Customers23 c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;

--task 20

SELECT TOP 1 c.CustomerName, SUM(s.UnitPrice * s.QuantitySold) AS TotalRevenue
FROM Sales s
JOIN Customers23 c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

--task 21

SELECT c.CustomerName, FORMAT(s.SaleDate, 'yyyy-MM') AS Month, 
       SUM(s.UnitPrice * s.QuantitySold) AS TotalSales
FROM Sales s
JOIN Customers23 c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName, FORMAT(s.SaleDate, 'yyyy-MM')
ORDER BY c.CustomerName, Month;

--task 22

CREATE TABLE Products23 (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);
INSERT INTO Products23 (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);

SELECT DISTINCT p.ProductID, p.ProductName
FROM Products23 p
WHERE p.ProductID IN (SELECT DISTINCT ProductID FROM Sales);

--task 23

SELECT TOP 1 ProductID, ProductName, SellingPrice
FROM Products23
ORDER BY SellingPrice DESC;

--task 24

SELECT s.SaleID, s.CustomerID, s.ProductID, s.QuantitySold, s.UnitPrice, p.CostPrice, s.SaleDate
FROM Sales s
JOIN Products23 p ON s.ProductID = p.ProductID;

--task 25

SELECT p.ProductID, p.ProductName, p.SellingPrice
FROM Products23 p
WHERE p.SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products23
    WHERE Category = p.Category
);



