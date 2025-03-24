--Easy-Level Tasks

--1. Write a query to join Employees and Departments using an INNER JOIN, and apply a WHERE clause to show only employees whose salary is greater than 5000.

SELECT e.EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE e.Salary > 5000;

--2. Write a query to join Customers and Orders using an INNER JOIN, and apply the WHERE clause to return only orders placed in 2023.

SELECT c.CustomerName, o.OrderID, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;

--3. Write a query to demonstrate a LEFT OUTER JOIN between Employees and Departments, showing all employees and their respective departments (including employees without departments).

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID;

--4. Write a query to perform a RIGHT OUTER JOIN between Products and Suppliers, showing all suppliers and the products they supply (including suppliers without products).

SELECT p.ProductName, s.SupplierName
FROM Products p
RIGHT JOIN Suppliers s ON p.SupplierID = s.SupplierID;

--5. Write a query to demonstrate a FULL OUTER JOIN between Orders and Payments, showing all orders and their corresponding payments (including orders without payments and payments without orders).

--SINCE I DON'T HAVE 'PAYMENTS' TABLE, I'VE DEMONSTRATED FULL OUTER JOIN FUNCTION IN ANOTHER WAY.

SELECT o.OrderID, od.ProductID, o.CustomerID, od.Quantity
FROM Orders o
FULL OUTER JOIN OrderDetails od ON o.OrderID = od.OrderID;

--6. Write a query to perform a SELF JOIN on the Employees table to display employees and their respective managers (showing EmployeeName and ManagerName).

ALTER TABLE Employees
ADD ManagerID INT NULL;

UPDATE Employees SET ManagerID = 1 WHERE EmployeeID IN (2,3);
UPDATE Employees SET ManagerID = 2 WHERE EmployeeID IN (4,5);

SELECT e.EmployeeName AS Employee,
m.EmployeeName AS Manager
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

--7. Write a query to demonstrate the logical order of SQL query execution by performing a JOIN between Products and Sales, followed by a WHERE clause to filter products with sales greater than 100.


SELECT p.ProductName, s.OrderQty
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.OrderQty > 100;

--8. Write a query to join Students and Courses using INNER JOIN, and use the WHERE clause to show only students enrolled in 'Math 101'.

SELECT s.StudentName, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseId = c.CourseID
WHERE c.CourseName = 'Math 101';

--9. Write a query that uses INNER JOIN between Customers and Orders, and filters the result with a WHERE clause to show customers who have placed more than 3 orders.

SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY CustomerName
HAVING COUNT(o.OrderID) >3;

--10. Write a query to join Employees and Departments using a LEFT OUTER JOIN and use the WHERE clause to filter employees in the 'HR' department.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e 
LEFT JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE d.DepartmentName = 'HR';

--11. Write a query to perform an INNER JOIN between Employees and Departments, and use the WHERE clause to show employees who belong to departments with more than 10 employees.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE d.DepartmentName IN (
SELECT DepartmentName
FROM EmployeeDepartments
GROUP BY DepartmentName
HAVING COUNT(*) > 10
);

--12. Write a query to perform a LEFT OUTER JOIN between Products and Sales, and use the WHERE clause to filter only products with no sales.

SELECT p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;

--13. Write a query to perform a RIGHT OUTER JOIN between Customers and Orders, and filter the result using the WHERE clause to show only customers who have placed at least one order.

SELECT c.CustomerName, o.OrderID
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NOT NULL;

--14. Write a query that uses a FULL OUTER JOIN between Employees and Departments, and filters out the results where the department is NULL.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
FULL OUTER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE d.DepartmentName IS NULL;


--15. Write a query to perform a SELF JOIN on the Employees table to show employees who report to the same manager.

SELECT e1.EmployeeName AS Employee1, e2.EmployeeName as Employee2, e1.ManagerID
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID <>e2.EmployeeID;

--16. Write a query that uses the logical order of SQL execution to perform a LEFT OUTER JOIN between Orders and Customers, followed by a WHERE clause to filter orders placed in the year 2022.


SELECT o.OrderID, c.CustomerName, o.OrderDate
FROM Orders o
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

--17. Write a query to use the ON clause with INNER JOIN to return only the employees from the 'Sales' department whose salary is greater than 5000.

SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE e.Salary > 5000;

--18. Write a query to join Employees and Departments using INNER JOIN, and use WHERE to filter employees whose department's DepartmentName is 'IT'.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE d.DepartmentName = 'IT';

--19. Write a query to join Orders and Payments using a FULL OUTER JOIN, and use the WHERE clause to show only the orders that have corresponding payments.

SELECT o.OrderID, p.PaymentID, p.PaymentAmount
FROM Orders o
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID
WHERE o.OrderID IS NOT NULL AND p.PaymentID IS NOT NULL;

--20. Write a query to perform a LEFT OUTER JOIN between Products and Orders, and use the WHERE clause to show products that have no orders.

SELECT p.ProductName
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

--Hard-Level Tasks

--21. Write a query that explains the logical order of SQL execution by using a JOIN between Employees and Departments, followed by a WHERE clause to show employees whose salary is higher than the average salary of their department.


SELECT e.EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE e.Salary > (
SELECT AVG(e2.Salary)
FROM Employees e2
WHERE e2.EmployeeID = e.EmployeeID
);

--22. Write a query to perform a LEFT OUTER JOIN between Orders and Payments, and use the WHERE clause to return all orders placed before 2020 that have not been paid yet.



SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL AND YEAR(o.OrderDate) < 2020;

--23. Write a query to perform a FULL OUTER JOIN between Products and Categories, and use the WHERE clause to filter only products that have no category assigned.

SELECT p.ProductName
FROM Products p
LEFT JOIN ProductCategories pc ON p.ProductID = pc.ProductID
WHERE pc.CategoryID IS NULL;

--24. Write a query to perform a SELF JOIN on the Employees table to find employees who report to the same manager and earn more than 5000.

SELECT e1.EmployeeName AS Employee1, e2.EmployeeName AS Employee2, e1.ManagerID
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID <> e2.EmployeeID AND e1.Salary > 5000;

--25. Write a query to join Employees and Departments using a RIGHT OUTER JOIN, and use the WHERE clause to show employees from departments where the department name starts with ‘M’.

SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
RIGHT JOIN EmployeeDepartments d ON e.EmployeeID = d.EmployeeID
WHERE d.DepartmentName LIKE 'M%';

--26. Write a query to demonstrate the difference between the ON clause and the WHERE clause by joining Products and Sales, and using WHERE to filter only sales greater than 1000.


SELECT p.ProductName, s.OrderQty
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.OrderQty > 1000;


--27. Write a query to perform a LEFT OUTER JOIN between Students and Courses, and use the WHERE clause to show only students who have not enrolled in 'Math 101'.

SELECT s.StudentName
FROM Students s
LEFT JOIN StudentCourses sc ON s.StudentID = sc.StudentID
LEFT JOIN Courses c ON sc.CourseID = c.CourseID
WHERE c.CourseName IS NULL OR c.CourseName <> 'MAth 101';

--28. Write a query that explains the logical order of SQL execution by using a FULL OUTER JOIN between Orders and Payments, followed by a WHERE clause to filter out the orders with no payment.

SELECT o.OrderID, p.PaymentID
FROM Orders o
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

--29. Write a query to join Products and Categories using an INNER JOIN, and use the WHERE clause to filter products that belong to either 'Electronics' or 'Furniture'.

SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN ProductCategories pc ON p.ProductID = pc.ProductID
INNER JOIN Categories c ON pc.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

--30. Write a query to perform a CROSS JOIN between Customers and Orders, and use the WHERE clause to filter the result to show customers with more than 2 orders placed in 2023.

SELECT c.CustomerName, o.OrderID
FROM Customers c
CROSS JOIN Orders o
WHERE c.CustomerID = o.CustomerID
AND YEAR(o.OrderDate) = 2023
AND c.CustomerID IN (
SELECT CustomerID
FROM Orders
WHERE YEAR(OrderDate) = 2023
GROUP BY CustomerID
HAVING COUNT(*) >2
);
