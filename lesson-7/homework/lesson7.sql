--Easy-Level Tasks (10)
--1. Write a query to find the minimum (MIN) price of a product in the Products table.

SELECT MIN(ListPrice) AS MinPrice
FROM Production.Product;

--2. Write a query to find the maximum (MAX) Salary from the Employees table.

SELECT MAX(RATE) AS MaxSalary
FROM HumanResources.EmployeePayHistory;

--3. Write a query to count the number of rows in the Customers table using COUNT(*).

SELECT COUNT(*) AS CustomerCount
FROM Sales.Customer;

--4. Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table.


SELECT COUNT(DISTINCT ProductSubcategoryID) AS UniqueCategories
FROM Production.Product;

--5. Write a query to find the total (SUM) sales for a particular product in the Sales table.
-- ProductID = 1

SELECT SUM(LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail
WHERE ProductID = 1;

--6. Write a query to calculate the average (AVG) age of employees in the Employees table.

 SELECT AVG(DATEDIFF( YEAR, BirthDate, GETDATE())) AS AvgAge
 FROM HumanResources.Employee
 WHERE BirthDate IS NOT NULL;
  
  --7. Write a query that uses GROUP BY to count the number of employees in each department.

SELECT DepartmentID, COUNT (*) AS EmployeeCount
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY DepartmentID;

--8. Write a query to show the minimum and maximum Price of products grouped by Category.

SELECT ProductSubcategoryID,
MIN(ListPrice) AS MinPrice,
MAX(ListPrice) AS MaxPrice
FROM Production.Product
GROUP BY ProductSubcategoryID;

--9. Write a query to calculate the total (SUM) sales per Region in the Sales table.
SELECT TerritoryID,
SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID;

--10. Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.

SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM HumanResources.EmployeeDepartmentHistory
GROUP BY DepartmentID
HAVING COUNT(*) >5;

--Medium-Level Tasks (10)

--11. Write a query to calculate the total sales and average sales for each product category from the Sales table.

SELECT pc.Name AS CategoryName,
SUM(sod.LineTotal) AS TotalSales,
AVG(sod.LineTotal) AS AvgSales
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name;

--12. Write a query that uses COUNT(columnname) to count the number of employees with a specific JobTitle.


SELECT JobTitle,
COUNT(*) AS EmployeeCount
FROM HumanResources.Employee
WHERE JobTitle = 'Benefits Specialist'
GROUP BY JobTitle;

--13. Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table.

SELECT d.Name AS Department,
MAX(eph.Rate) AS MaxSalary,
MIN(eph.Rate) AS MinSalary
FROM HumanResources.EmployeePayHistory eph
JOIN HumanResources.Employee e ON eph.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name;

--14. Write a query that uses GROUP BY to calculate the average salary per Department.

SELECT d.Name AS Department,
AVG(eph.Rate) AS AvgSalary
FROM HumanResources.EmployeePayHistory eph
JOIN HumanResources.Employee e ON eph.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name;

--15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.

SELECT d.Name AS Department,
AVG(eph.Rate) AS AvgSalary,
COUNT(*) AS EmployeeCount
FROM HumanResources.EmployeePayHistory eph
JOIN HumanResources.Employee e ON eph.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name;

--16. Write a query that uses HAVING to filter products with an average price greater than 100.

SELECT p.Name AS ProductName,
AVG(sod.UnitPrice) AS AvgPrice
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
HAVING AVG(sod.UnitPrice) > 100;

--17. Write a query to count how many products have sales above 100 units using COUNT(DISTINCT ProductID).

SELECT COUNT(DISTINCT ProductID) AS ProductCount
FROM Sales.SalesOrderDetail
WHERE OrderQty > 100;

--18. Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.

SELECT YEAR(soh.OrderDate) AS SalesYear,
SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY YEAR(soh.OrderDate)
ORDER BY SalesYear;

--19. Write a query that uses COUNT to show the number of customers who placed orders in each region.

SELECT st.Name AS Region,
COUNT(DISTINCT soh.CustomerID) AS CustomerCount
FROM Sales.SalesOrderHeader soh
JOIN Person.Address a ON soh.BillToAddressID = a.AddressID
JOIN Person.StateProvince st ON a.StateProvinceID = st.StateProvinceID
GROUP BY st.Name;

--20. Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 100,000.


SELECT d.Name AS Region,
SUM(eph.Rate) AS TotalSalary
FROM HumanResources.EmployeePayHistory eph
JOIN HumanResources.Employee e ON eph.BusinessEntityID = e.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name
HAVING SUM(eph.Rate) > 100000;

--Hard-Level Tasks (10)

--21. Write a query that shows the average (AVG) sales for each product category, and then uses HAVING to filter categories with an average sales amount greater than 200.

SELECT psc.Name AS ProductCategory,
AVG(sod.LineTotal) AS AvgSales
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
GROUP BY psc.Name
HAVING AVG(sod.LineTotal) > 200;

--22. Write a query to calculate the total (SUM) sales for each employee, then filter the results using HAVING to include only employees with total sales over 5000.

SELECT e.BusinessEntityID, SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN HumanResources.Employee e ON soh.SalesPersonID = e.BusinessEntityID
GROUP BY e.BusinessEntityID
HAVING SUM(soh.TotalDue) > 5000;

--23. Write a query to find the total (SUM) and average (AVG) salary of employees grouped by department, and use HAVING to include only departments with an average salary greater than 6000.

SELECT d.Name AS Department,
SUM(eph.Rate) AS TotalSalary,
AVG(eph.Rate) AS AvgSalary
FROM HumanResources.EmployeePayHistory eph
JOIN HumanResources.EmployeeDepartmentHistory edh ON eph.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
GROUP BY d.Name
HAVING AVG(eph.Rate) > 6000;

--24. Write a query that finds the maximum (MAX) and minimum (MIN) order value for each customer, and then applies HAVING to exclude customers with an order value less than 50.

SELECT CustomerID,
MAX(TotalDue) AS MaxOrderValue,
MIN(TotalDue) AS MinOrderValue
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING MIN(TotalDue) >=50;

--25. Write a query that calculates the total sales (SUM) and counts distinct products sold in each Region, and then applies HAVING to filter regions with more than 10 products sold.

SELECT st.Name AS Region,
SUM(sod.LineTotal) AS TotalSales,
COUNT(DISTINCT sod.ProductID) AS ProductCount
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Person.StateProvince st ON soh.BillToAddressID = st.StateProvinceID
GROUP BY st.Name
HAVING COUNT(DISTINCT sod.ProductID)>10;

--26. Write a query to find the MIN and MAX order quantity per product, and then use GROUP BY to group the results by ProductCategory.

SELECT pc.Name AS ProductCategory,
p.ProductID,
MIN(od.OrderQty) AS MinOrderQty,
MAX(od.OrderQty) AS MinOrderQty
FROM Sales.SalesOrderDetail od
JOIN Production.Product p ON od.ProductID = p.ProductID
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name, p.ProductID;


--27. Write a query to pivot the Sales table by Year and show the sum of SalesAmount for each Region.


--28. Write a query to unpivot the Sales table, converting Q1, Q2, Q3, and Q4 columns into rows showing total sales per quarter.

--29. Write a query to count the number of orders per product, filter those with more than 50 orders using HAVING, and group them by ProductCategory.

SELECT pc.Name AS ProductCategory, p.ProductID, COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory ps  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY pc.Name, p.ProductID
HAVING COUNT(soh.SalesOrderID) >50;

--30. Write a query to pivot the EmployeeSales table, displaying the total sales per employee for each quarter (Q1, Q2, Q3, Q4).
