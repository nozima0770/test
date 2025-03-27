--Easy-Level Tasks

--1.Write a query to perform an INNER JOIN between Orders and Customers using AND in the ON clause to filter orders placed after 2022.


SELECT o.OrderID, o.OrderDate, c.CustomerName 
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID AND YEAR(o.OrderDate) > 2022;

--2.Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d 
ON e.EmployeeID = d.EmployeeID 
AND (d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing');

--3.Write a query to join a derived table (for example, SELECT * FROM Products WHERE Price > 100) with the Orders table to display products and their corresponding orders.

SELECT p.ProductID, p.ProductName, o.OrderID
FROM (SELECT * FROM Products WHERE Price > 100) p
INNER JOIN Orders o ON p.ProductID = o.ProductID;

--4.Write a query to join a Temp table (for example, Temp_Orders) and the Orders table to show orders that are present in both tables.

CREATE TABLE #Temp_Orders (
OrderID INT
);

INSERT INTO #Temp_Orders (OrderID)
VALUES (10248), (10249), (10250);

SELECT o.OrderID, o.OrderDate
FROM Orders o
INNER JOIN #Temp_Orders t ON o.OrderID = t.OrderID;

--5.Write a query to demonstrate a CROSS APPLY between Employees and a derived table that shows their department's top-performing sales (e.g., top 5 sales).
SELECT * FROM Sales

SELECT e.EmployeeName, d.DepartmentName, s.OrderQty
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
CROSS APPLY (
SELECT TOP 5 s.OrderQty
FROM Sales s
WHERE s.SaleID = e.EmployeeID
ORDER BY s.OrderQty DESC
) AS s;

--6.Write a query to join Customers and Orders using AND in the ON clause to filter customers who have placed orders in 2023 and have a loyalty status of 'Gold'.

ALTER TABLE Customers 
ADD LoyaltyStatus VARCHAR(50);

UPDATE Customers SET LoyaltyStatus = 'Gold' WHERE CustomerID  IN (1,2);
UPDATE Customers SET LoyaltyStatus = 'Silver' WHERE CustomerID IN (3,4);

SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID AND YEAR(o.OrderDate) = 2023
WHERE c.LoyaltyStatus = 'Gold';

--7.Write a query to join a derived table (SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID) with the Customers table to show the number of orders per customer.

SELECT c.CustomerName, oc.OrderCount
FROM Customers c
INNER JOIN (
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
) oc ON c.CustomerID = oc.CustomerID;


--8.Write a query to join Products and Suppliers using OR in the ON clause to show products supplied by either 'Supplier A' or 'Supplier B'.

SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
AND (s.SupplierName = 'Supplier A' OR s.SupplierName = 'Supplier B');

--9.Write a query to demonstrate the use of OUTER APPLY between Employees and a derived table that returns each employee's most recent order.


SELECT TOP 1 * FROM Orders;
SELECT e.EmployeeName, r.OrderID, r.OrderDate
FROM Employees e
OUTER APPLY (
SELECT TOP 1 o.OrderID, o.OrderDate
FROM Orders o
WHERE o.EmployeeID = e.EmployeeID
ORDER BY o.OrderDate DESC
) r;

--10.Write a query to perform a CROSS APPLY between Departments and a table-valued function that returns a list of employees working in that department.


CREATE FUNCTION dbo.GetEmployeesByDepartment (@DeptID INT)
RETURNS TABLE
AS
RETURN
(
SELECT EmployeeName
FROM Employees
WHERE EmployeeID = @DeptID
);


SELECT d.DepartmentName, e.EmployeeName
FROM EmployeeDepartments d
CROSS APPLY dbo.GetEmployeesByDepartment(d.EmployeeID) e;

--Medium-Level Tasks

--11.Write a query that uses the AND logical operator in the ON clause to join Orders and Customers, and filter customers who placed an order with a total amount greater than 5000.

 
SELECT o.OrderID, c.CustomerName, o.TotalAmount
FROM #Temp_Orders O
JOIN Customers c
ON o.CustomerID = c.CustomerID AND o.TotalAmount > 5000;

--12.Write a query that uses the OR logical operator in the ON clause to join Products and Sales to filter products that were either sold in 2022 or have a discount greater than 20%.
SELECT * FROM Sales


CREATE TABLE #TempSales (
SaleID INT,
ProductID INT,
SaleDate DATE,
Discount DECIMAL(5,2)
);

INSERT INTO #TempSales (SaleID, ProductID, SaleDate, Discount)
VALUES
(1, 101, '2022-05-01', 10.00),
(2, 102, '2023-01-15', 25.00),
(3, 103, '2022-07-10', 15.00),
(4, 104, '2021-12-20', 30.00);



SELECT p.ProductName, s.SaleDate, s.Discount
FROM Products p
JOIN #TempSales s
ON p.ProductID = s.ProductID
AND (YEAR(s.SaleDate) = 2022 OR s.Discount > 20);

--13.Write a query to join a derived table that calculates the total sales (SELECT ProductID, SUM(Amount) FROM Sales GROUP BY ProductID) with the Products table to show total sales for each product.


SELECT p.ProductName, s.TotalSales
FROM Products p
JOIN (
SELECT ProductID, SUM(OrderQty) AS TotalSales
FROM Sales
GROUP BY ProductID
) s ON p.ProductID = s.ProductID;


--14.Write a query to join a Temp table (Temp_Products) and the Products table to show the products that have been discontinued in the Temp table.


CREATE TABLE #Temp_Products (
ProductsID INT,
Isdiscontinued BIT
);

INSERT INTO #Temp_Products (ProductsID, IsDiscontinued)
VALUES
(1,1),
(2,0),
(3,1),
(4,0);


SELECT p.ProductID, p.ProductName
FROM Products p
JOIN #Temp_Products tp ON p.ProductID = tp.ProductsID
WHERE tp.Isdiscontinued = 1;

--15.Write a query to demonstrate CROSS APPLY by applying a table-valued function to each row of the Employees table to return the sales performance for each employee.

CREATE FUNCTION dbo.GetSalesPerformance(@EmpID INT)
RETURNS TABLE
AS
RETURN
(
SELECT 
 @EmpID AS EmployeeID,
(@EmpID * 10) % 100 AS PerformanceScore  
);

SELECT e.EmployeeName, sp.PerformanceScore
FROM Employees e
CROSS APPLY dbo.GetSalesPerformance(e.EmployeeID) sp;



--16.Write a query to join Employees and Departments using AND in the ON clause to filter employees who belong to the 'HR' department and whose salary is greater than 5000.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID 
AND d.DepartmentName = 'HR'
AND e.Salary > 5000;

--17.Write a query to join Orders and Payments using OR in the ON clause to show orders that have either been paid fully or partially.


SELECT o.OrderID, p.PaymentStatus
FROM Orders o
JOIN #Temp_Payments p ON o.OrderID = p.OrderID
AND (p.PaymentStatus = 'Full' OR p.PaymentStatus = 'Partial');

--18.Write a query to use OUTER APPLY to return all customers along with their most recent orders, including customers who have not placed any orders.

SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c 
OUTER APPLY (
SELECT TOP 1 o.OrderID, o.OrderDate
FROM Orders o
WHERE o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC 
) o;

--19.Write a query to join Products and Sales using AND in the ON clause to filter products that were sold in 2023 and have a rating greater than 4.

SELECT p.ProductName, s.SaleDate, s.Rating
FROM Products p
JOIN #Temp_Sales s
ON p.ProductID= s.ProductID
AND YEAR(s.SaleDate) = 2023
AND s.Rating > 4;


--20.Write a query to join Employees and Departments using OR in the ON clause to show employees who either belong to the 'Sales' department or have a job title that contains 'Manager'.


SELECT e.EmployeeName, d.DepartmentName, e.JobTitle
FROM #Temp_Employees e
JOIN EmployeeDepartments d
ON e.EmployeeID = d.EmployeeID
AND (d.DepartmentName = 'Sales' OR e.JobTitle LIKE '%Manager%');

--Hard-Level Tasks

--21.Write a query to demonstrate the use of the AND logical operator in the ON clause between Orders and Customers, and filter orders made by customers who are located in 'New York' and have made more than 10 orders.

--As in the Customers table I have the column 'Country' not the column 'City', in the following query I will show the result with the column 'Country'.

SELECT o.OrderID, c.CustomerName, c.Country
FROM Orders o
JOIN (
SELECT CustomerID, COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
) co ON o.CustomerID = co.CustomerID
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND c.Country = 'USA' AND co.OrderCount >10;

--22.Write a query to demonstrate the use of OR in the ON clause when joining Products and Sales to show products that are either part of the 'Electronics' category or have a discount greater than 15%.
SELECT * FROM ProductCategories
SELECT * FROM Sales
SELECT * FROM Products

SELECT p.ProductName, pc.CategoryName, pd.DiscountPercentage
FROM Products p
JOIN ProductCategories pc
ON p.ProductID = pc.CategoryID
JOIN ProductDiscounts pd
ON p.ProductID = pd.ProductID
AND (pc.CategoryName = 'Electronics' OR pd.DiscountPercentage > 15);

--23.Write a query to join a derived table that returns a count of products per category (SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID) with the Categories table to show the count of products in each category.

SELECT pc.CategoryName, pcount.ProductCount
FROM ProductCategories pc
JOIN (
SELECT CategoryID, COUNT(*) AS ProductCount
FROM #Temp_Products
GROUP BY CategoryID
) pcount ON pc.CategoryID = pcount.CategoryID;

--24.Write a query to join a Temp table (Temp_Employees) with the Employees table using a complex condition in the ON clause (e.g., salary > 4000 AND department = 'IT').


SELECT e.EmployeeName, t.Salary, t.Department
FROM Employees e
JOIN #Temp_Employees t
ON e.EmployeeID =t.EmployeeID
AND t.Salary > 4000 AND t.Department = 'IT';

--25.Write a query to demonstrate CROSS APPLY by applying a table-valued function that returns the number of employees working in each department for every row in the Departments table.



CREATE FUNCTION dbo.GetEmployeeCountByDepartment (@DeptiD INT)
RETURNS TABLE
AS 
RETURN (
SELECT COUNT(*) AS EmployeeCount
FROM Employees
WHERE DepartmentID = @DeptID
);

SELECT d.DepartmentName, ec.EmployeeCount
FROM EmployeeDepartments d
CROSS APPLY dbo.GetEmployeeCountByDepartment(d.DepartmentID) ec;

--26.Write a query to join Orders and Customers using AND in the ON clause to show orders where the customer is from 'California' and the order amount is greater than 1000.
SELECT * FROM Orders


SELECT o.OrderID, c.CustomerName, o.Quantity, c.Country
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
AND c.Country = 'USA'
AND o.Quantity > 1000;

--27.Write a query to join Employees and Departments using a complex OR condition in the ON clause to show employees who are in the 'HR' or 'Finance' department, or have an 'Executive' job title.

SELECT e.EmployeeName, d.DepartmentName, e.JobTitle
FROM Employees e
JOIN EmployeeDepartments d
ON e.EmployeeID = d.EmployeeID
AND (d.DepartmentNameIN('HR', 'FINANCE') OR e.JobTitke LIKE '%Executive%');

--28.Write a query to use OUTER APPLY between Customers and a table-valued function that returns all orders placed by each customer, and show customers who have not placed any orders.

SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
OUTER APPLY (
SELECT o.OrderID, o.OrderDate
FROM Orders o
WHERE o.CustomerID = c.CustomerID
) o;


--29.Write a query to join Sales and Products using AND in the ON clause to filter products that have both a sales quantity greater than 100 and a price above 50.


SELECT p.ProductName, s.OrderQty, p.Price
FROM Sales s
JOIN Products p
ON s.ProductID = p.ProductID
AND s.OrderQty > 100
AND p.Price > 50;

--30.Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department, and with a salary greater than 6000.

SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN EmployeeDepartments d
ON e.EmployeeID = d.EmployeeID
AND (d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing')
WHERE e.Salary > 6000;
