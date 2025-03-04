-- DDL(Data Definition Language) includes commands that define database structures (e.g., CREATE,ALTER)
-- DML (Data Manipulation Language) includes commands that modify data (e.g., INSERT, UPDATE)
-- DDL: CREATE TABLE, ALTER TABLE
-- DML: INSERT INTO, UPDATE

CREATE TABLE Employees (
EmpID INT PRIMARY KEY,
Name VARCHAR(50),
Salary DECIMAL(10,2)
);
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employees';

INSERT INTO Employees (EmpID, Name, Salary)
VALUES
(1, 'Alice', 5000.00),
(2, 'Bob', 4500.50),
(3, 'Charlie', 6000.75);

UPDATE Employees
SET Salary = 5500.00
WHERE EmpID = 1;

DELETE FROM Employees
WHERE EmpID = 2;

SELECT * FROM Employees

-- DELETE: Removes rows but keeps the table structure.
-- DROP: Deletes the table completely.
-- TRUNCATE: Removes all records but keeps the table structure.

ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

ALTER TABLE Employees
ADD Department VARCHAR(50);

EXEC sp_columns Employees;


CREATE TABLE Departments (
DeptID INT PRIMARY KEY,
DeptName VARCHAR(50),
EmpID INT,
FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

INSERT INTO Employees (EmpID, Name, Salary) VALUES (4, 'David', 4000.05);
INSERT INTO Employees (EmpID, Name, Salary) VALUES (5, 'Sarah', 6005.55);
SELECT *FROM Employees WHERE EmpID =3;
SELECT *FROM Employees WHERE EmpID =2;
SELECT *FROM Employees WHERE EmpID =4;


UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

--TRUNCATE TABLE Employees; ( cannot truncate bcs of FK)





--ALTER TABLE Departments NOCHECK CONSTRAINT FK_Departments_EmpID;

-- VARCHAR: Stores ASCII characters ( 1 byte per character).
-- NVARCHAR: Stores Unicode characters (2 bytes per character).
-- Use NVARCHAR for multilingual support.

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

ALTER TABLE Employees
DROP COLUMN Department;

ALTER TABLE Employees
ADD JoinDate DATE;

CREATE TABLE #TempEmployees (
EmpID INT,
Name VARCHAR(50)
);
INSERT INTO #TempEmployees (EmpID, Name)
VALUES(1,'David'), (2, 'Emma');
SELECT* FROM #TempEmployees

DROP TABLE Departments


CREATE TABLE Customers (
CustID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT CHECK (Age > 18)
);

DELETE FROM Employees
WHERE EmpID IN (
SELECT EmpID
FROM SalaryHistory
WHERE LastIncreaseDate < DATEADD(YEAR, -2, GETDATE())
);
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SalaryHistory';

CREATE TABLE SalaryHistory (
EmpID INT,
LastIncreaseDate DATE
);

DELETE FROM Employees
WHERE EmpID IN (
SELECT EmpID
FROM SalaryHistory
WHERE LastIncreaseDate < DATEADD(YEAR, -2, GETDATE())
);

CREATE PROCEDURE InsertEmployee (
@EmpID INT, @Name VARCHAR(50), @Salary DECIMAL(10,2)
)
AS
BEGIN
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (@EmpID, @Name, @Salary);
END;


SELECT * INTO  Employees_Backup FROM Employees;

MERGE INTO Employees AS Target
USING (SELECT EmpID, Name, Salary FROM NewEmployees) AS Source
ON Target.EmpID = Source.EmpID
WHEN MATCHED THEN UPDATE SET Target.Salary = Source.Salary
WHEN NOT MATCHED THEN INSERT (EmpID, Name, Salary)
VALUES (Source.EmpID, Source.Name, Source.Salary);

SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'NewEmployees';

CREATE TABLE NewEmployees (
EmpID INT PRIMARY KEY,
Name VARCHAR(50),
Salary DECIMAL(10,2)
);

INSERT INTO NewEmployees (EmpID, Name, Salary)
VALUES
(1, 'Alex', 50000.00),
(2, 'Bon', 60000.00);

MERGE INTO Employees AS Target
USING (SELECT EmpID, Name, Salary FROM NewEmployees) AS Source
ON Target.EmpID = Source.EmpID
WHEN MATCHED THEN UPDATE SET Target.Salary = Source.Salary
WHEN NOT MATCHED THEN INSERT (EmpID, Name, Salary)
VALUES (Source.EmpID, Source.Name, Source.Salary);


DROP DATABASE CompanyDB;
CREATE DATABASE CompanyDB2;

EXEC sp_rename 'Employees', 'StaffMembers';

Run SELECT * FROM StaffMembers;

-- CASCADE DELETE: Deletes dependent rows when the parent is deleted.
-- CASCADE UPDATE: Updates dependent rows when the parent key is updated.

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustID INT,
FOREIGN KEY (CustID) REFERENCES Customers(CustID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50) UNIQUE
);