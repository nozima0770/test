--Easy-level tasks:
CREATE TABLE CompanyData (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10,2),
    Department VARCHAR(100),
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10,2),
    CustomerID INT,
    CustomerName VARCHAR(100)
);

INSERT INTO CompanyData (EmployeeName, Salary, Department, ProductID, ProductName, Category, Price, CustomerID, CustomerName)
VALUES 
    ('Alice Johnson', 5000.00, 'Sales', 1, 'Laptop', 'Electronics', 1200.00, 101, 'John Smith'),
    ('Bob Williams', 4800.00, 'Marketing', 2, 'Smartphone', 'Electronics', 800.00, 102, 'Emma Davis'),
    ('Charlie Brown', 5200.00, 'IT', 3, 'Monitor', 'Electronics', 300.00, 103, 'Michael Johnson'),
    ('David Miller', 5500.00, 'HR', 4, 'Office Chair', 'Furniture', 150.00, 104, 'Sophia Lee'),
    ('Ella Scott', 4700.00, 'Finance', 5, 'Printer', 'Office Supplies', 250.00, 105, 'Daniel Wilson'),
    ('Frank Thomas', 4900.00, 'Support', 6, 'Headphones', 'Accessories', 100.00, 106, 'Olivia Martinez'),
    ('Grace White', 5300.00, 'Operations', 7, 'Coffee Machine', 'Appliances', 200.00, 107, 'William Brown');

--	Write a query to select the top 5 employees from the Employees table.

SELECT TOP 5 *
FROM Employees;

--Use SELECT DISTINCT to select unique ProductName values from the Products table.
SELECT DISTINCT ProductName
FROM Products;

--Write a query that filters the Products table to show products with Price > 100.
SELECT *
FROM Products
WHERE Price > 100;

SELECT * FROM CompanyData;

--Write a query to select all CustomerName values that start with 'A' using the LIKE operator.

ALTER TABLE Customers
ADD CustomerName NVARCHAR(200);

SELECT CustomerName
FROM Customers
WHERE CustomerName LIKE 'A%';

--Order the results of a Products query by Price in ascending order.
SELECT *
FROM Products
ORDER BY Price ASC;

--Write a query that uses the WHERE clause to filter for employees with Salary >= 5000 and Department = 'HR'.

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employees';

ALTER TABLE Employees
ADD Salary DECIMAL(10,2),
Department VARCHAR(100);


SELECT *
FROM Employees
WHERE Salary >= 5000 AND Department = 'HR';

--Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".

SELECT EmpID, [Name], ISNULL(Email, 'noemail@example.com') AS Email
FROM Employees;

--Write a query that shows all products with Price BETWEEN 50 AND 100.

SELECT *
FROM Products
WHERE Price BETWEEN 50 AND 100;

--Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Products';

ALTER TABLE Products ADD Category VARCHAR(100);

SELECT DISTINCT Category, ProductName
FROM Products;

--Order the results by ProductName in descending order.

SELECT DISTINCT Category, ProductName
FROM Products
ORDER BY ProductName DESC;


--Medium-Level Tasks

--Write a query to select the top 10 products from the Products table, ordered by Price DESC.

SELECT TOP 10 *
FROM Products
ORDER BY Price DESC;

--Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.
--Since I don't have separate FirstName and LastName columns, I will show the work of COALESCE function in another way.


SELECT EmpID, COALESCE([Name], 'Unknown') 
FROM Employees;


--Write a query that selects distinct Category and Price from the Products table.

SELECT DISTINCT Category, Price
FROM Products;

--Write a query that filters the Employees table to show employees whose Age is either between 30 and 40 or Department = 'Marketing'.
ALTER TABLE Employees
ADD Age INT;

UPDATE Employees
SET Age = FLOOR(RAND() * (50-20+1)+20);

SELECT *
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR (Department = 'Marketing');

--Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.

SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

--Write a query to display all products with Price <= 1000 and Stock > 50, sorted by Stock in ascending order.

ALTER TABLE CompanyData
ADD Stock INT;

UPDATE Products
SET Stock = 50
WHERE ProductID = 101;

UPDATE CompanyData
SET STOCK = 120
WHERE ProductID = 102;



SELECT *
FROM CompanyData
WHERE Price <= 1000 AND Stock >50
ORDER BY Stock ASC;

--Write a query that filters the Products table for ProductName values containing the letter 'e' using LIKE.

SELECT *
FROM CompanyData 
WHERE ProductName LIKE '%e%';

  --Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.

  SELECT *
  FROM CompanyData
  WHERE Department IN ('HR', 'IT', 'Finance');

  --Write a query that uses the ANY operator to find employees who earn more than the average salary of all employees.

  SELECT *
  FROM CompanyData
  WHERE Salary > ANY (SELECT AVG(Salary) FROM CompanyData);

 -- Use ORDER BY to display a list of customers ordered by City in ascending and PostalCode in descending order.
 --Since I don't have the columns "City" and "PostalCode", I've decided to the ORDER BY function in another way.
 SELECT *
 FROM CompanyData
 ORDER BY CustomerName ASC, CustomerID DESC; 

  
  

  --Hard-Level Tasks 

  --Write a query that selects the top 10 products with the highest sales, using TOP(10) and ordered by SalesAmount DESC.

  CREATE TABLE Products_ (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(100),
  SalesAmount DECIMAL(10,2)
  );

  INSERT INTO Products_(ProductID, ProductName,SalesAmount)
  VALUES 
  (1, 'Laptop', 25000.00),
    (2, 'Smartphone', 15000.00),
    (3, 'Tablet', 8000.00),
    (4, 'Headphones', 1200.00),
    (5, 'Smartwatch', 5500.00),
    (6, 'Gaming Console', 18000.00),
    (7, 'Camera', 9000.00),
    (8, 'Printer', 4000.00),
    (9, 'Monitor', 6000.00),
    (10, 'Keyboard', 2000.00),
    (11, 'Mouse', 1500.00),
    (12, 'Drone', 11000.00);

	SELECT * FROM Products_

	SELECT TOP(10) ProductName, SalesAmount
	FROM Products_
	ORDER BY SalesAmount DESC;

	--Use COALESCE to combine FirstName and LastName into one column named FullName in the Employees table.

	ALTER TABLE CompanyData
	ALTER COLUMN EmployeeName VARCHAR(100);

	ALTER TABLE CompanyData
	ADD FirstName VARCHAR(50),
	LastName VARCHAR(50);

	SELECT * 
	FROM CompanyData;

	SELECT COALESCE(FirstName, ' ') + ' ' + COALESCE(LastName, ' ') AS FULLNAME
	FROM CompanyData;

	--Write a query to select the distinct Category, ProductName, and Price for products that are priced above $50, using DISTINCT on three columns.

	SELECT DISTINCT Category, ProductName, Price
	FROM CompanyData
	WHERE Price > 50;

	--Write a query that selects products whose Price is within 10% of the average price in the Products table.

	SELECT *
	FROM CompanyData
	WHERE Price BETWEEN (SELECT AVG(Price) * 0.9 FROM CompanyData)
	AND (SELECT AVG(Price) * 1.1 FROM CompanyData);

	SELECT AVG(Price) AS AveragePrice
	FROM CompanyData;

	--Use WHERE clause to filter for employees whose Age is less than 30 and who work in either the 'HR' or 'IT' department.
	ALTER TABLE CompanyData
	ADD Age INT;

	UPDATE CompanyData
	SET Age = 25
	WHERE EmployeeName = 'Alice Johnson';

	UPDATE CompanyData
	SET Age = 34
	WHERE EmployeeName = 'Bob Williams';

	UPDATE CompanyData
	SET Age = 32
	WHERE EmployeeName = 'Charlie Brown';

	UPDATE CompanyData
	SET Age = 23
	WHERE EmployeeName = 'David Miller';

	UPDATE CompanyData
	SET Age = 40
	WHERE EmployeeName = 'Ella Scott';

	UPDATE CompanyData
	SET Age = 43
	WHERE EmployeeName = 'Frank Thomas';

	UPDATE CompanyData
	SET Age = 22
	WHERE EmployeeName = 'Grace White';

	SELECT *
	FROM CompanyData
	WHERE Age <30
	AND Department IN ('HR', 'IT');

	--Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.
	ALTER TABLE CompanyData
	ADD Email VARCHAR(100);

	UPDATE CompanyData
	SET Email = 'alice@gmail.com'
	WHERE CustomerID = 101;


	UPDATE CompanyData
	SET Email = 'bob@gmail.com'
	WHERE CustomerID = 102;

	UPDATE CompanyData
	SET Email = 'charlie@gmail.com'
	WHERE CustomerID = 103;

	UPDATE CompanyData
	SET Email = 'david@gmail.com'
	WHERE CustomerID = 104;

	UPDATE CompanyData
	SET Email = 'ella@gmail.com'
	WHERE CustomerID = 105;

	UPDATE CompanyData
	SET Email = 'frank@gmail.com'
	WHERE CustomerID = 106;

	UPDATE CompanyData
	SET Email = 'grace@gmail.com'
	WHERE CustomerID = 107;

	SELECT *
	FROM CompanyData
	WHERE Email LIKE '%@gmail.com';


	-- Write a query that uses the ALL operator to find employees whose salary is greater than all employees in the 'Sales' department.

	SELECT *
	FROM CompanyData
	WHERE Salary > ALL (SELECT Salary FROM CompanyData WHERE Department = 'Sales');

	-- Use ORDER BY with OFFSET-FETCH to show employees with the highest salaries, displaying 10 employees at a time (pagination).
	SELECT *
	FROM CompanyData
	ORDER BY salary DESC
	OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


	--Write a query that filters the Orders table for orders placed in the last 30 days using BETWEEN and CURRENT_DATE.
DROP TABLE Orders;

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
OrderDate DATE,
CustomerID INT
);

INSERT INTO Orders (OrderID, OrderDate, CustomerID)
VALUES
    (1, '2025-02-25', 101), 
    (2, '2025-03-01', 102), 
    (3, '2025-01-15', 103), 
    (4, '2025-03-10', 104), 
    (5, '2025-02-01', 105); 

	SELECT *
	FROM Orders
	WHERE OrderDate BETWEEN DATEADD (DAY, -30, GETDATE()) AND GETDATE();

	--Use ANY with a subquery to select all employees who earn more than the average salary for their department.
	SELECT e1. *
	FROM CompanyData AS e1
	WHERE e1.Salary > ANY (
	SELECT AVG(e2.Salary)
	FROM CompanyData AS e2
	WHERE e2.Department = e1.Department
	GROUP BY e2.Department
	);
