--Easy-Level Tasks

--1. Write a query that uses an alias to rename the ProductName column as Name in the Products table.

SELECT ProductName AS [Name]
FROM Products;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DimProduct';

SELECT EnglishProductName AS [Name]
FROM DimProduct;

--2. Write a query that uses an alias to rename the Customers table as Client for easier reference.

SELECT *
FROM DimCustomer AS Client;

--3. Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discontinued.

SELECT EnglishProductName AS ProductName
FROM DimProduct
WHERE EndDate IS NULL -- Active Products

UNION

SELECT EnglishProductName AS ProductName
FROM DimProduct
WHERE EndDate IS NOT NULL; -- Discontinued products

--4. Write a query to find the intersection of Products and Products_Discontinued tables using INTERSECT.

SELECT EnglishProductName 
FROM DimProduct
WHERE EndDate IS NULL

INTERSECT

SELECT EnglishProductName 
FROM DimProduct
WHERE EndDate IS NOT NULL;

--5. Use UNION ALL to combine two tables, Products and Orders, that have the same structure.

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DimProduct';

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FactResellerSales';

SELECT ProductKey FROM DimProduct
UNION ALL
SELECT ProductKey FROM FactResellerSales;

--6. Write a query to select distinct customer names (CustomerName) and their corresponding Country using SELECT DISTINCT.

SELECT DISTINCT c.CustomerKey, g.EnglishCountryRegionName
FROM DimCustomer c
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey;

--7. Write a query that uses CASE to create a conditional column that displays 'High' if Price > 100, and 'Low' if Price <= 100.

SELECT 
p.EnglishProductName,
f.UnitPrice,
CASE
WHEN f.UnitPrice > 100 THEN 'High'
ELSE 'Low'
END AS PriceCategory
FROM dbo.FactResellerSales f
JOIN dbo.DimProduct p ON f.ProductKey = p.ProductKey;

--8. Write a query to filter Employees by Department and group them by Country.

SELECT g.SalesTerritoryRegion, COUNT (*) AS EmployeeCount
FROM DimEmployee e
JOIN DimSalesTerritory g ON e.SalesTerritoryKey = g.SalesTerritoryKey
WHERE e.SalesPersonFlag = 1 -- Filters only sales employees
GROUP BY g.SalesTerritoryRegion;

--9. Use GROUP BY to find the number of products (ProductID) in each Category.

SELECT c.EnglishProductCategoryName, COUNT(p.ProductKey) AS ProductCount
FROM DimProduct p
JOIN DimProductSubcategory s ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
JOIN DimProductCategory c ON s.ProductCategoryKey = c.ProductCategoryKey
GROUP BY c.EnglishProductCategoryName;

--10. Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise.
-- The DimProduct table does not have a stock column, but inventory data is in FactProductInventory.

SELECT p.EnglishProductName, f.UnitCost,
IIF(f.UnitCost > 100, 'Yes', 'No') AS HighStock
FROM FactProductInventory f
JOIN DimProduct p ON f.ProductKey = p.ProductKey;

--Medium-Level Tasks (10)
--11. Write a query that joins the Orders and Customers tables using INNER JOIN and aliases the CustomerName as ClientName.

SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT c.FirstName + ' ' + c.LastName AS ClientName, 
o.SalesOrderNumber, 
o.OrderDate
FROM DimCustomer c
INNER JOIN FactInternetSales o ON c.CustomerKey = o.CustomerKey;

--12. Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.

SELECT p.EnglishProductName AS ProductName 
FROM DimProduct p
WHERE EXISTS (SELECT 1 FROM FactProductInventory f WHERE f.ProductKey = p.ProductKey)
UNION
SELECT p.EnglishProductName
FROM DimProduct p
WHERE NOT EXISTS( SELECT 1 FROM FactProductInventory f WHERE f.ProductKey = p.ProductKey);

--13. Write a query that returns the difference between the Products and DiscontinuedProducts tables using EXCEPT.

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DiscontinuedProducts';

SELECT ProductKey, EnglishProductName FROM DimProduct
EXCEPT
SELECT ProductKey, EnglishProductName FROM DimProduct WHERE Status = 'Discontinued';

--14. Write a query that uses CASE to assign a value of 'Eligible' to customers who have placed more than 5 orders, otherwise 'Not Eligible'.

SELECT c.CustomerKey, c.FirstName + ' ' + c.LastName AS ClientName,
COUNT(o.SalesOrderNumber) AS TotalOrders,
CASE WHEN COUNT(o.SalesOrderNumber) > 5 THEN 'Eligible' 
ELSE 'Not Eligible' 
END AS Eligibility
FROM DimCustomer c
LEFT JOIN FactInternetSales o ON c.CustomerKey = o.CustomerKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName;

--15. Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 100, and 'Affordable' if less.

SELECT EnglishProductName, ListPrice,
IIF(ListPrice > 100, 'Expensive', 'Affordable') AS PriceCategory
FROM DimProduct;

--16. Write a query that uses GROUP BY to count the number of orders per CustomerID in the Orders table.

SELECT CustomerKey, 
COUNT(SalesOrderNumber) AS OrderCount
FROM FactInternetSales
GROUP BY CustomerKey;

--17. Write a query to find employees in the Employees table who have either Age < 25 or Salary > 6000.

SELECT EmployeeKey,
FirstName,
LastName,
DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age,
BaseRate AS Salary
FROM DimEmployee
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) < 25 OR BaseRate > 6000;

--18. Use GROUP BY to find the total sales (SalesAmount) per Region in the Sales table.

SELECT s.SalesTerritoryRegion, SUM(f.SalesAmount) AS Totalsales
FROM DimSalesTerritory s
JOIN FactResellerSales f ON s.SalesTerritoryKey = f.SalesTerritoryKey
GROUP BY s.SalesTerritoryRegion;

--19. Write a query that combines data from the Customers and Orders tables using LEFT JOIN, and create an alias for OrderDate.

SELECT TOP 5 * FROM FactInternetSales;

SELECT c.CustomerKey, c.FirstName + ' ' + c.LastName AS ClientName,
o.SalesOrderNumber,
o.SalesOrderLineNumber AS Order_Count
FROM DimCustomer c
JOIN FactInternetSales o ON c.CustomerKey = o.CustomerKey;

--20. Use IF statement to update the salary of an employee based on their department, increase by 10% if they work in 'HR'.

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DimEmployee';


UPDATE DimEmployee
SET BaseRate = BaseRate * 1.10
WHERE DepartmentName = 'HR';

--Hard-Level Tasks
--21. Write a query that uses UNION ALL to combine two tables, Sales and Returns, and calculate the total sales and returns for each product.

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'FactResellerSales';

SELECT ProductKey, SUM(SalesAmount) AS TotalSales, 0 AS TotalReturns
FROM FactInternetSales
GROUP BY ProductKey
UNION ALL
SELECT ProductKey, 0, SUM(CASE WHEN SalesAmount <0 THEN -SalesAmount ELSE 0 END) AS TotalReturns
FROM FactResellerSales
GROUP BY ProductKey;

--22. Use INTERSECT to show products that are common between Products and DiscontinuedProducts tables.

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%Product%';

SELECT * FROM DimProduct;

SELECT ProductKey
FROM DimProduct
WHERE Status = 'Discontinued'
INTERSECT
SELECT ProductKey 
FROM FactProductInventory;

--23. Write a query that uses CASE to assign 'Top Tier' if TotalSales > 10000, 'Mid Tier' if TotalSales BETWEEN 5000 AND 10000, and 'Low Tier' otherwise.

SELECT ProductKey, SUM(SalesAmount) AS TotalSales,
CASE
WHEN SUM(SalesAmount) > 10000 THEN 'Top Tier'
WHEN SUM(SalesAmount) BETWEEN 5000 AND 10000 THEN 'Mid Tier'
ELSE 'Low Tier'
END AS SalesCategory
FROM FactInternetSales 
GROUP BY ProductKey;

--24. Write a query that combines multiple conditions using IF and WHILE to iterate over all rows of the Employees table and update their salary based on certain criteria.

DECLARE @EmployeeID INT, @BaseRate DECIMAL(10,2);
DECLARE cur CURSOR FOR
SELECT EmployeeKey, BaseRate FROM DimEmployee;
OPEN cur;
FETCH NEXT FROM cur INTO @EmployeeID, @BaseRate;
WHILE @@FETCH_STATUS = 0
BEGIN
IF @BaseRate < 50000
UPDATE DimEmployee SET BaseRate = BaseRate * 1.10 
WHERE EmployeeKey = @EmployeeID;
ELSE IF @BaseRate BETWEEN 50000 AND 100000
UPDATE DimEmployee SET BaseRate = BaseRate * 1.05 
WHERE EmployeeKey = @EmployeeID;
ELSE
UPDATE DimEmployee SET BaseRate = BaseRate * 1.02 
WHERE EmployeeKey = @EmployeeID;

FETCH NEXT FROM cur INTO @EmployeeID, @BaseRate;
END;

CLOSE cur;
DEALLOCATE cur;

--25. Use EXCEPT to find customers who have placed orders but do not have a corresponding record in the Invoices table.

SELECT TOP 5 * FROM FactInternetSales;
SELECT TOP 5 * FROM FactResellerSales;

SELECT CustomerKey FROM FactInternetSales
EXCEPT
SELECT CustomerKey FROM DimCustomer;

--26. Write a query that uses GROUP BY on three columns: CustomerID, ProductID, and Region, and calculates the total sales.

SELECT CustomerKey, ProductKey, SalesTerritoryKey, SUM(SalesAmount) AS TotalSales
FROM FactInternetSales
GROUP BY CustomerKey, ProductKey, SalesTerritoryKey;

--27. Write a query that uses CASE to apply multiple conditions and returns a Discount column based on the Quantity purchased.

SELECT ProductKey, OrderQuantity,
CASE
WHEN OrderQuantity >= 100 THEN 0.20
WHEN OrderQuantity BETWEEN 50 AND 99 THEN 0.10
ELSE 0.05
END AS Discount
FROM FactInternetSales;

--28. Use UNION and INNER JOIN to return all products that are either in the Products or DiscontinuedProducts table and also show if they are currently in stock.


SELECT 
    p.ProductKey, 
    p.EnglishProductName, 
    i.UnitsBalance, 
    'Available' AS StockStatus
FROM DimProduct p
INNER JOIN FactProductInventory i ON p.ProductKey = i.ProductKey

UNION

SELECT 
    p.ProductKey, 
    p.EnglishProductName, 
    0 AS UnitsBalance, 
    'Discontinued' AS StockStatus
FROM DimProduct p
LEFT JOIN FactProductInventory i ON p.ProductKey = i.ProductKey
WHERE i.ProductKey IS NULL;  

--29. Write a query that uses IIF to create a new column StockStatus, where the status is 'Available' if Stock > 0, and 'Out of Stock' if Stock = 0.

SELECT 
    ProductKey, 
    UnitsBalance, 
    IIF(UnitsBalance > 0, 'Available', 'Out of Stock') AS StockStatus
FROM FactProductInventory;

--30. Write a query that uses EXCEPT to find customers in the Customers table who are not in the VIP_Customers table based on CustomerID.
SELECT CustomerKey 
FROM DimCustomer
EXCEPT 
SELECT CustomerKey 
FROM VIP_Customers;



