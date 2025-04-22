--task 1

SELECT FirstName, LastName, Salary
FROM #Employees
WHERE Salary > (
SELECT AVG(Salary)
FROM #Employees
);

--task 2

SELECT 'Employees exist in Department 1'
WHERE EXISTS (
SELECT 1
FROM #Employees
WHERE DepartmentID = 1
);

--task 3

SELECT FirstName, LastName, DepartmentID
FROM #Employees
WHERE DepartmentID = (
SELECT DepartmentID 
FROM #Employees
WHERE FirstName = 'Rachel' AND LastName = 'Collins'
);

--task 4

SELECT FirstName, LastName, HireDate
FROM #Employees
WHERE HireDate > (
SELECT MAX(HireDate)
FROM #Employees
WHERE DepartmentID = 2
);

--task 5

SELECT FirstName, LastName, Salary, DepartmentID
FROM #Employees e
WHERE Salary > (
SELECT AVG(Salary)
FROM #Employees
WHERE DepartmentID = e.DepartmentID
);

--task 6

SELECT 
FirstName, LastName, DepartmentID,
(SELECT COUNT(*)
FROM #Employees e2
WHERE e2.DepartmentID = e1.DepartmentID) as DeptEmployeeCount
FROM #Employees e1;

--task 7

SELECT FirstName, LastName, Salary
FROM #Employees
WHERE Salary = (
SELECT MIN(Salary)
FROM #Employees
);

--task 8

SELECT FirstName, LastName, DepartmentID, Salary
FROM #Employees
WHERE DepartmentID IN (
SELECT DepartmentID
FROM #Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 65000
);

--task 9

SELECT FirstName, LastName, HireDate
FROM #Employees
WHERE HireDate >= DATEADD(YEAR, -3, (SELECT MAX(HireDate) FROM #Employees)
);

--task 10

SELECT FirstName, LastName, DepartmentID, Salary
FROM #Employees
WHERE DepartmentID IN (
SELECT DISTINCT DepartmentID
FROM #Employees
WHERE Salary >=80000
);

--task 11

SELECT FirstName, LastName, DepartmentID, Salary
FROM #Employees e
WHERE Salary = (
SELECT MAX(Salary)
FROM #Employees
WHERE DepartmentID = e.DepartmentID
);

--task 12

SELECT d.DepartmentName, e.FirstName, e.LastName, e.HireDate
FROM #Employees e
JOIN #Departments d ON e.DepartmentID = d.DepartmentID
WHERE HireDate = (
SELECT MAX(HireDate)
FROM #Employees
WHERE DepartmentID = e.DepartmentID
);

--task 13
SELECT l.LocationName, d.DepartmentName, AVG(e.Salary) as AverageSalary
FROM #Employees
JOIN #Departments d ON e.DepartmentID = d.DepartmentID
JOIN Locations l ON d.LocationID = l.LocationID
GROUP BY l.LocationName, d.DepartmentName;


--task 14

SELECT FirstName, LastName, DepartmentID, Salary
FROM #Employees
WHERE DepartmentID IN (
SELECT DepartmentID 
FROM #Employees e1
WHERE Salary = (
SELECT AVG(Salary)
FROM #Employees e2
WHERE e2.DepartmentID = e1.DepartmentID
)
);

--task 15

SELECT DepartmentID
FROM #Employees
GROUP BY DepartmentID
HAVING COUNT(*) < (
SELECT AVG(DeptCount)
FROM (
SELECT COUNT(*) AS DeptCount
FROM #Employees
GROUP BY DepartmentID
) as DeptStats
);

--task 16

SELECT FirstName, LastName, DepartmentID
FROM #Employees
WHERE DepartmentID NOT IN (
    SELECT TOP 1 DepartmentID
    FROM #Employees
    GROUP BY DepartmentID
    ORDER BY AVG(Salary) DESC
);



--task 17

SELECT DepartmentName
FROM #Departments d
WHERE EXISTS (
SELECT 1
FROM #Employees e
WHERE e.DepartmentID = d.DepartmentID
);

--task 18

WITH ExperienceData as (
SELECT departmentID, CASE WHEN DATEDIFF(YEAR, HireDate, (SELECT MAX(HireDate) 
FROM #Employees)) > 3 THEN 'Senior'
ELSE 'Junior'
END AS ExperienceLevel
FROM #Employees
),
COUNTS AS (
SELECT DepartmentID,
SUM(CASE WHEN ExperienceLevel = 'Senior' THEN 1 ELSE 0 END) AS SeniorCount,
SUM(CASE WHEN ExperienceLevel = 'Junior' THEN 1 ELSE 0 END) AS JuniorCount
FROM ExperienceData
GROUP BY DepartmentID
)
SELECT DepartmentID
FROM Counts 
WHERE SeniorCount > JuniorCount;

--task 19

SELECT FirstName, LastName, DepartmentID
FROM #Employees
WHERE DepartmentID = (
SELECT TOP 1 DepartmentID
FROM #Employees
GROUP BY DepartmentID
ORDER BY COUNT(*) DESC
);

--task 20

SELECT DepartmentID, MAX(Salary) - MIN(Salary) as SalaryRange
FROM #Employees
GROUP BY DepartmentID;

--task 21

SELECT ProjectName
FROM Projects p
WHERE NOT EXISTS (
SELECT 1
FROM EmployeeProject ep
WHERE ep.ProjectID = p.ProjectID
AND ep.Role = 'Lead'
);

--task 22

SELECT e.FirstName, e.LastName, e.Salary
FROM #Employees e
WHERE e.Salary > ALL (
SELECT AVG(e2.Salary)
FROM EmployeeProject ep
JOIN Employees_19 e2 ON e2.EmployeeID = ep.EmployeeID
WHERE ep.ProjectID IN (
SELECT ProjectID FROM EmployeeProject WHERE EmployeeID = e.EmployeeID
)
GROUP BY ep.ProjectID
);

--task 23

SELECT p.ProjectName
FROM Projects p
JOIN EmployeeProject ep ON p.ProjectID = ep.ProjectID
GROUP BY p.ProjectID, p.ProjectName
HAVING COUNT(*) = 1;

--task 24

SELECT ProjectName,
Budget,
(SELECT MAX(Budget) FROM Projects) - Budget as BudgetDifference
FROM Projects;

--task 25

SELECT ep.ProjectID
FROM EmployeeProject ep
JOIN Employees_19 e ON ep.EmployeeID = e.EmployeeID
WHERE ep.Role = 'Lead'
GROUP BY ep.ProjectID
HAVING SUM(e.Salary) > (
SELECT AVG(e2.Salary)
FROM EmployeeProject ep2
JOIN Employees_19 e2 ON ep2.EmployeeID = e2.EmployeeID
WHERE ep2.Role = 'Lead'
);
