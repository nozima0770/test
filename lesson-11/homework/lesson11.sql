CREATE DATABASE H11;

--Task 1: Basic INNER JOIN
--Question: Retrieve all employee names along with their corresponding department names.


CREATE TABLE Employees_11 ( EmployeeID INT PRIMARY KEY, Name VARCHAR(50), DepartmentID INT );

CREATE TABLE Departments ( DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50) );

INSERT INTO Employees_11 VALUES (1, 'Alice', 101), (2, 'Bob', 102), (3, 'Charlie', NULL);

INSERT INTO Departments VALUES (101, 'HR'), (102, 'IT'), (103, 'Finance');

SELECT e.Name, d.DepartmentName
FROM Employees_11 e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

--Task 2: LEFT JOIN
--Question: List all students along with their class names, including students who are not assigned to any class.

CREATE TABLE Students ( StudentID INT PRIMARY KEY, StudentName VARCHAR(50), ClassID INT );

CREATE TABLE Classes ( ClassID INT PRIMARY KEY, ClassName VARCHAR(50) );


INSERT INTO Students VALUES (1, 'John', 201), (2, 'Emma', NULL), (3, 'Liam', 202);

INSERT INTO Classes VALUES (201, 'Math'), (202, 'Science');

SELECT s.StudentName, c.ClassName
FROM Students s
LEFT JOIN Classes c ON s.ClassID = c.ClassID;

--Task 3: RIGHT JOIN
--Question: List all customers and their orders, including customers who haven’t placed any orders.


CREATE TABLE Orders_11 ( OrderID INT PRIMARY KEY, CustomerID INT, OrderDate DATE );

CREATE TABLE Customers_11 ( CustomerID INT PRIMARY KEY, CustomerName VARCHAR(50) );


INSERT INTO Orders_11 VALUES (1, 301, '2024-11-01'), (2, 302, '2024-11-05');

INSERT INTO Customers_11 VALUES (301, 'Alice'), (302, 'Bob'), (303, 'Charlie');

SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Orders_11 o
RIGHT JOIN Customers_11 c ON o.CustomerID = c.CustomerID;

--Task 4: FULL OUTER JOIN
--Question: Retrieve a list of all products and their sales, including products with no sales and sales with invalid product references.

CREATE TABLE Products_11 ( ProductID INT PRIMARY KEY, ProductName VARCHAR(50) );

CREATE TABLE Sales_11 ( SaleID INT PRIMARY KEY, ProductID INT, Quantity INT );


INSERT INTO Products_11 VALUES (1, 'Laptop'), (2, 'Tablet'), (3, 'Phone');

INSERT INTO Sales_11 VALUES (100, 1, 10), (101, 2, 5), (102, NULL, 8)

SELECT p.ProductName, s.SaleID, s.Quantity
FROM Products_11 p
FULL OUTER JOIN Sales_11 s ON p.ProductID = s.ProductID;

--Task 5: SELF JOIN
--Question: Find the names of employees along with the names of their managers.

CREATE TABLE Employees11 ( EmployeeID INT PRIMARY KEY, Name VARCHAR(50), ManagerID INT );


INSERT INTO Employees11 VALUES (1, 'Alice', NULL), (2, 'Bob', 1), (3, 'Charlie', 1), (4, 'Diana', 2);

SELECT e.[Name] AS Employee, m.Name AS Manager
FROM Employees11 e
LEFT JOIN Employees11 m ON e.ManagerID = m.EmployeeID;

--Task 6: CROSS JOIN
--Question: Generate all possible combinations of colors and sizes.


CREATE TABLE Colors ( ColorID INT PRIMARY KEY, ColorName VARCHAR(50) );

CREATE TABLE Sizes ( SizeID INT PRIMARY KEY, SizeName VARCHAR(50) );


INSERT INTO Colors VALUES (1, 'Red'), (2, 'Blue');

INSERT INTO Sizes VALUES (1, 'Small'), (2, 'Medium');

SELECT col.ColorName, siz.SizeName
FROM Colors col
CROSS JOIN Sizes siz;

--Task 7: Join with WHERE Clause
--Question: Find all movies released after 2015 and their associated actors.

CREATE TABLE Movies ( MovieID INT PRIMARY KEY, Title VARCHAR(50), ReleaseYear INT );

CREATE TABLE Actors ( ActorID INT PRIMARY KEY, Name VARCHAR(50), MovieID INT );


INSERT INTO Movies VALUES (1, 'Inception', 2010), (2, 'Interstellar', 2014), (3, 'Dune', 2021);

INSERT INTO Actors VALUES (101, 'Leonardo DiCaprio', 1), (102, 'Matthew McConaughey', 2), (103, 'Timothée Chalamet', 3);

SELECT m.Title, a.Name
FROM Movies m
JOIN Actors a ON m.MovieID = a.MovieID
WHERE m.ReleaseYear > 2015;

--Task 8: MULTIPLE JOINS
--Question: Retrieve the order date, customer name, and the product ID for all orders.

CREATE TABLE Orders11 ( OrderID INT PRIMARY KEY, CustomerID INT, OrderDate DATE );

CREATE TABLE Customers11 ( CustomerID INT PRIMARY KEY, CustomerName VARCHAR(50) );

CREATE TABLE Order11Details ( OrderDetailID INT PRIMARY KEY, OrderID INT, ProductID INT );


INSERT INTO Orders11 VALUES (1, 401, '2024-11-01'), (2, 402, '2024-11-05');

INSERT INTO Customers11 VALUES (401, 'Alice'), (402, 'Bob');

INSERT INTO Order11Details VALUES (1001, 1, 501), (1002, 2, 502);

SELECT o.OrderDate, c.CustomerName, d.ProductID
FROM Orders11 o
JOIN Customers11 c ON o.CustomerID = c.CustomerID
JOIN Order11Details d ON o.OrderID = d.OrderID;


--Task 9: JOIN with Aggregation
--Question: Calculate the total revenue generated for each product.

CREATE TABLE Sales11 ( SaleID INT PRIMARY KEY, ProductID INT, Quantity INT );

CREATE TABLE Products11 ( ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10, 2) );


INSERT INTO Sales11 VALUES (1, 601, 3), (2, 602, 5), (3, 601, 2);

INSERT INTO Products11 VALUES (601, 'TV', 500.00), (602, 'Speaker', 150.00);

SELECT p.ProductName, SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Products11 p
JOIN Sales11 s ON s.ProductID = p.ProductID
GROUP BY p.ProductName;




