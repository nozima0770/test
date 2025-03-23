--Easy-Level Tasks
--1. Write a query to join the Customers and Orders tables using an INNER JOIN to get the CustomerName and their OrderDate.

SELECT c.CustomerName, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

--2. Write a query to demonstrate a One to One relationship between the EmployeeDetails and Employees tables by joining them.


SELECT e.EmployeeID, e.EmployeeName, ed.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments ed ON e.EmployeeID = ed.EmployeeID;

--3. Write a query to join the Products and Categories tables to show ProductName along with CategoryName using INNER JOIN.

SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN ProductCategories pc ON p.ProductID= pc.ProductID
INNER JOIN Categories c ON pc.CategoryID = c.CategoryID;

--4. Write a query to show all Customers and the corresponding OrderDate using LEFT JOIN between Customers and Orders.

SELECT c.CustomerName, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

--5. Write a query that demonstrates a Many to Many relationship between Orders and Products tables using an intermediate OrderDetails table.

SELECT o.OrderID, p.ProductName, od.Quantity
FROM Orders o
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID;

--6. Write a query to perform a CROSS JOIN between Products and Categories, showing all possible combinations of products and categories.

SELECT p.ProductName, c.CategoryName
FROM Products p
CROSS JOIN Categories c;

--7. Write a query to demonstrate the One to Many relationship between Customers and Orders using INNER JOIN.

SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;


--8. Write a query to filter a CROSS JOIN result using the WHERE clause, showing only combinations of Products and Orders where OrderAmount > 500.

SELECT p.ProductName, o.OrderDate, o.Quantity
FROM Products p
CROSS JOIN Orders o
WHERE o.Quantity >500;

--9. Write a query that uses INNER JOIN to join the Employees and Departments tables, showing employee names and their corresponding department names.
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID;

--10. Write a query that uses the ON clause with a <> operator to join two tables and return rows where the values in the two columns are not equal.

SELECT e1.EmployeeName AS Employee1, e2.EmployeeName AS Employee2
FROM EmployeeDepartments e1
INNER JOIN EmployeeDepartments e2 ON e1.DepartmentName <> e2.DepartmentName;

--Medium-Level Tasks

--11. Write a query to demonstrate a One to Many relationship by joining the Customers and Orders tables using INNER JOIN, showing the CustomerName and the total number of orders.

SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

--12. Write a query to demonstrate a Many to Many relationship between Students and Courses by joining through the StudentCourses table.


SELECT s.StudentName, c.CourseName
FROM SudentCourses sc
INNER JOIN Students s ON sc.StudentID = s.StudentID
INNER JOIN Courses c ON sc.CourseID = c.CourseID;

--13. Write a query to use a CROSS JOIN between Employees and Departments tables, and filter the results by Salary > 5000 using the WHERE clause.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
CROSS JOIN EmployeeDepartments d;

--14. Write a query to demonstrate a One to One relationship by joining the Employee and EmployeeDetails tables, showing each employee’s name and their details.

SELECT e.EmployeeName, ed.Address, ed.PhoneNumber
FROM Employees e
INNER JOIN EmployeeDetails ed ON e.EmployeeID = ed.EmployeeID;

--15. Write a query to perform an INNER JOIN between Products and Suppliers and use the WHERE clause to filter only products supplied by 'Supplier A'.

SELECT p.ProductID, p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName = 'Supplier A';


--16. Write a query to perform a LEFT JOIN between Products and Sales, and display all products along with their sales quantity (including products with no sales).

SELECT 
    p.ProductID, 
    p.ProductName, 
    COALESCE(SUM(s.OrderQty), 0) AS TotalSalesQuantity
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSalesQuantity DESC;


--17. Write a query to join Employees and Departments using a WHERE clause, and show all employees whose salary is greater than 4000 and who work in the ‘HR’ department.


SELECT e.EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE e.Salary > 4000 AND d.DepartmentName = 'HR';

--18. Write a query to show how to use the >= operator in the ON clause to join two tables and return rows where the values meet the condition.

SELECT o.OrderID, p.ProductName, o.Quantity
FROM Orders o
INNER JOIN Products p ON o.Quantity >= p.MinimumOrderQuantity;

--19. Write a query to demonstrate INNER JOIN and use the >= operator to find all products with a price greater than or equal to 50, and their respective suppliers.

SELECT p.ProductName, p.Price, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.Price >=50;

--20. Write a query to demonstrate a CROSS JOIN between Sales and Regions, and use the WHERE clause to show only regions with sales greater than 1000.

SELECT s.ProductID, r.RegionName, s.OrderQty
FROM Sales s
CROSS JOIN Regions r
WHERE s.OrderQty >1000;

--Hard-Level Tasks

--21. Write a query that demonstrates a Many to Many relationship between Authors and Books using the intermediate AuthorBooks table, showing the AuthorName and the BookTitle.

SELECT a.AuthorName, b.BookTitle
FROM Authors a
INNER JOIN AuthorBooks ab ON a.AuthorID = ab.AuthorID
INNER JOIN Books b ON ab.BookID = b.BookID;

--22. Write a query to join Products and Categories using INNER JOIN, and filter the result to only include products where the CategoryName is not ‘Electronics’.

SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.ProductID = c.CategoryID
WHERE c.CategoryName <> 'Electronics';

--23. Write a query to perform a CROSS JOIN between Orders and Products, and filter the result with a WHERE clause to show only orders where the quantity is greater than 100.

SELECT o.OrderID, p.ProductName, o.Quantity
FROM Orders o
CROSS JOIN Products p
WHERE o.Quantity > 100;

--24. Write a query that joins the Employees and Departments tables and uses a logical operator in the ON clause to only return employees who have been with the company for over 5 years.

ALTER TABLE Employees
ADD HireDAte DATE;

UPDATE Employees
SET HireDate = DATEADD(YEAR, -FLOOR(RAND() * 10), GETDATE());


SELECT e.EmployeeName, d.DepartmentName, e.HireDate
FROM Employees e
INNER JOIN EmployeeDepartments d
ON e.EmployeeID = d.EmployeeID 
WHERE DATEDIFF(YEAR, e.HireDate, GETDATE()) > 5;

--25. Write a query to show the difference between INNER JOIN and LEFT JOIN by returning employees and their departments, ensuring that employees without departments are included in the left join.

--INNER JOIN: Only employees with a department
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID;

--LEFT JOIN: Includes employees without a department

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID;

--26. Write a query that uses a CROSS JOIN between Products and Suppliers, and filters the result using WHERE to include only suppliers that supply products in 'Category A'.

SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s
JOIN ProductCategories pc ON p.ProductID = pc.ProductID
JOIN Categories c ON pc.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Category A';

--27. Write a query to demonstrate a One to Many relationship using INNER JOIN between Orders and Customers, and apply the >= operator to filter only customers with at least 10 orders.

SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(o.OrderID) >=10;

--28. Write a query to demonstrate the Many to Many relationship between Courses and Students, showing all courses and the number of students enrolled using the COUNT function.

SELECT c.CourseName, COUNT(cs.StudentID) as StudentCount
FROM Courses c 
LEFT JOIN CourseStudent cs ON c.CourseID = cs.CourseID
GROUP BY c.CourseName;

--29. Write a query to use a LEFT JOIN between Employees and Departments tables, and filter the result using the WHERE clause to show only employees in the 'Marketing' department.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE d.DepartmentName = 'Marketing';

--30. Write a query that uses the ON clause with <= operator to join two tables and return rows where the values in the columns meet the condition.

SELECT o.OrderID, p.ProductName, o.Quantity, p.MinimumOrderQuantity
FROM Orders o
INNER JOIN Products p ON o.Quantity <= p.MinimumOrderQuantity;
