
-- Easy-Level Tasks
--BULK INSERT is a command in SQL Server used to import large volumes of data from an external file into a database table efficiently.
-- It is commonly used for fast data loading from text files, CSV files, or other structured data formats.
-- Purpose of BULK INSERT: Improves performance compared to multiple INSERT statements; supports importing large datasets quickly; 
--can specify data formats, field terminators, and row terminators.

-- Four file formats that can be imported into SQL Server: CSV (Comma-Separated Values), TXT (Text Files), Excel Files (.xls, .xslx), XML (Extensible Markup Language).


--Q3)Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
DROP TABLE Products;

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Laptop', 1200.50),
(2, 'Smartphone', 800.99),
(3, 'Headphones', 150.75);

-- NULL: Represents missing or unknown data; Can be used when data is not available; Can cause issues in calculations.
-- NOT NULL: Requires a value to be provided; Ensures that data is always present; Prevents missing values in important columns.
-- NAME must have a value (NOT NULL)
-- Email can be left empty (NULL is allowed)

--Q6)Add a UNIQUE constraint to the ProductName column in the Products table.
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductNAme UNIQUE (ProductName);

-- Selecting all products that have a price greater than $500

SELECT * FROM  Products WHERE Price > 500;

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50) UNIQUE
);

----------------------------------------------------------------------------------------------------------
--
-- task was done that Add a UNIQUE constraint to the ProductName column in the Products table using object explorer's export data 
--id,name,description,price
--1, Wireless Mouse, A wireless mouse with ergonomic design,29.99
--2, Bluetooth Headphones,Over-ear headphones with Bluetooth connectivity,79.99
--3, Stainless Steel Tumbler, tumbler with stainless steel body,15.49

----------------------------------------------------------------------------------------------------------

-- The IDENTITY column in SQL Server is used to generate auto-incrementing values for a column, typically the primary key. 
-- It automatically assigns a unique number to each new row.

-- Medium_Level Tasks
------------------------------------------------------------------------
--medium Q1_Use BULK INSERT to import data from a text file into the Products table.
create table Products2 (ProductID int, ProductName varchar(50), Description varchar(100), Price decimal(10,2))

BULK INSERT Products2
FROM 'C:\Users\User\Sources for Bulk\Products.txt'
WITH (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);

--MEdium Q2) Import data from an Excel file into a table called Sales using SSMS Import Wizard. --> it  done
--"C:\Users\User\Sources for Bulk\Products.txt"
Select * from Products2
truncate table products2
-----------------------------------------------------------------------

--Q3)Write a query that exports the Products table data into an XML format using FOR XML.
SELECT ProductID, ProductName, Price
FROM Products
FOR XML AUTO, ROOT('Products');

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Products';

ALTER TABLE Products
ADD CategoryID INT;

--q4)Create a FOREIGN KEY in the Products table that references the Categories table.
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);


--Q5)Add a CHECK constraint to the Products table ensuring Price > 0.
ALTER TABLE Products
ADD CONSTRAINT CHK_Product_Price CHECK (Price>0);

--Q6)Add a CHECK constraint to the Products table ensuring Price > 0.
SELECT ProductID, ProductName, Price
FROM Products
FOR JSON AUTO;

--Modify the Products table to add a column Stock (INT, NOT NULL).
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

--Use the ISNULL function to replace NULL values in a column with a default value.
SELECT ProductID, isnull(ProductName,0)
FROM Products;

-- A FOREIGN KEY enforces referential integrity by ensuring a column's values exist in another table; Prevents orphaned records.



-- Hard-Level Tasks
--Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
Name NVARCHAR(100) NOT NULL,
Age INT CHECK (Age >= 18) NOT NULL
);

--Q2)Import data from a JSON file into a table called Orders using OPENROWSET
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
---From JSON to SQL Server
DECLARE @JSON VARCHAR(MAX);

SELECT @JSON = BulkColumn
FROM OPENROWSET (
    BULK 'C:\Users\User\Sources for Bulk\json file.json',
    SINGLE_CLOB
) AS import;

SELECT * into From_json
FROM OPENJSON (@JSON)
WITH (
    fear VARCHAR(20),
    chest VARCHAR(20),
    how VARCHAR(20),
    graph VARCHAR(20),
	camp VARCHAR(20),
	plural VARCHAR(20)
	)
Select * from From_json

--Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE Products (
ProductID INT IDENTITY(100,10) PRIMARY KEY,
ProductName NVARCHAR(100) NOT NULL,
Price DECIMAL(10,2) NOT NULL
);

SELECT name AS ForeignKeyName, OBJECT_NAME(parent_object_id) AS TableName
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('dbo.Customers');

SELECT 
[name] AS ForeignKeyName,
OBJECT_NAME(parent_object_id) AS TableName
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('dbo.Customers');

ALTER TABLE Orders DROP CONSTRAINT FK__Orders__CustID__33008CF0

DROP TABLE dbo.Customers;

-- Enable Ad Hoc Distributed Queries

----
DROP TABLE dbo.Products;


--Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
CREATE TABLE OrderDetails (
OrderID INT,
ProductID INT,
Quantity INT NOT NULL,
PRIMARY KEY (OrderID, ProductID)
);

--Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
SELECT
COALESCE(NULL, NULL, 'First Non-Null') AS CoalesceResult;
ISNULL(NULL, 'Second Non-Null') AS IsNullResult;

-- COALESCE returns the first non-NULL value from multiple arguments.
-- ISNULL replaces NULL with a specified value but only accepts two arguments.
--------------------------------------------------------------------------
Select * from Products2
--drop table Products
create table products (id int, name varchar(50), description varchar(50), price decimal(10,2))



   ---------------------------------------------------------------------------------
select * from Products
select * from Products2

-- Use the MERGE statement to import data from a text file into Products, updating existing records and inserting new ones.
 BULK INSERT Products2
FROM 'C:\Users\User\Sources for Bulk\Products.txt'
WITH (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);

;Merge into products as target
using products2 as source 
on target.id = source.productID

-- Update existing records
WHEN MATCHED THEN 
    UPDATE SET 
        target.Name = source.ProductName,
        target.description = source.description,
		target.Price = source.Price
        

-- Insert new records
WHEN NOT MATCHED THEN 
    INSERT (ID, Name,description,Price)
    VALUES (source.ProductID, source.ProductName,source.description,source.Price);

select * from Products2

--Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
	CREATE TABLE Employees (
	EmpID INT PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) UNIQUE NOT NULL
	);

	ALTER TABLE Orders 
	ADD NewColumnName NVARCHAR(100);
--Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
	CREATE TABLE Orders_New(
	OrderID INT PRIMARY KEY,
	CustomerID INT,
	OrderDate DATE NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	);


