--Easy Tasks
--task 1


CREATE VIEW vwStaff AS
SELECT * FROM StaffMembers;


SELECT * FROM vwStaff;

--task 2

CREATE TABLE Items (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Quantity INT
);

INSERT INTO Items (ItemID, ItemName, Category, Price, Quantity) VALUES
(1, 'Laptop', 'Electronics', 999.99, 10),
(2, 'Headphones', 'Electronics', 199.99, 25),
(3, 'Desk Chair', 'Furniture', 149.50, 8),
(4, 'Notebook', 'Stationery', 2.99, 100),
(5, 'Pen Set', 'Stationery', 4.99, 50);


CREATE VIEW vwItemPrices AS
SELECT ItemID, ItemName, Price
FROM Items;

--task 3
CREATE TABLE #TempPurchases (
PurchaseID INT,
ClientID INT,
ItemID INT,
Quantity INT,
PurchaseDate DATE
);

INSERT INTO #TempPurchases VALUES 
(1, 101, 10, 2, '2025-04-01'),
(2, 102, 11, 1, '2025-04-02');

--task 4
DECLARE @currentRevenue DECIMAL(10,2);

--task 5
CREATE FUNCTION fnSquare (@num FLOAT)
RETURNS FLOAT
AS
BEGIN
RETURN @num * @num;
END;

--task 6

CREATE PROCEDURE spGetClients
AS
BEGIN
SELECT * FROM Clients;
END;

--task 7
Create table Purchases (
ClientID INT,
PurchaseDate DATE
);

CREATE TABLE Clients (
ClientID INT PRIMARY KEY,
LastPurchaseDate DATE
);

INSERT INTO Clients (ClientID, LastPurchaseDate)
VALUES
(1, '2024-12-15'),
(3, '2025-01-20');


MERGE INTO Clients as Target
USING Purchases as Source
ON Target.clientID = Source.ClientID
WHEN MATCHED THEN 
UPDATE SET Target.LastPurchaseDate = Source.PurchaseDate
WHEN NOT MATCHED BY TARGET THEN
INSERT (ClientID)
VALUES (Source.ClientID);

--task 8

CREATE TABLE #StaffInfo (
StaffID INT,
Name NVARCHAR(100),
Department NVARCHAR(50)
);

INSERT INTO #StaffInfo VALUES
(1, 'Alice', 'HR'),
(2, 'Bob', 'IT');

--task 9

CREATE FUNCTION fnEvenOdd (@num INT)
RETURNS NVARCHAR(10)
AS
BEGIN
RETURN CASE WHEN @num % 2 =0 THEN 'Even' ELSE 'Odd' END;
END;

--task 10
ALTER TABLE Purchases
ADD Amount DECIMAL(10,2);


CREATE PROCEDURE spMonthlyRevenue @Month INT, @Year INT
AS 
BEGIN
SELECT SUM(Amount) as TotalRevenue
FROM Purchases
WHERE MONTH(PurchaseDate) = @Month AND YEAR(PurchaseDate) = @Year;
END;

--task 11
ALTER TABLE Purchases
ADD ItemID INT;




CREATE VIEW vwRecentItemSales as 
SELECT ItemID, SUM(Amount) as TotalQuantity
FROM Purchases
WHERE PurchaseDate >=DATEADD(MONTH, -1, GETDATE())
GROUP BY ItemID;

--task 12

DECLARE @currentDate DATE = GETDATE();
PRINT @currentDate;

--task 13

CREATE VIEW vwHighQuantityItems as 
SELECT * FROM Items
WHERE Quantity > 100;

--task 14

CREATE TABLE #ClientOrders (
OrderID INT,
ClientID INT,
ItemID INT,
Quantity INT
);

INSERT INTO #ClientOrders VALUES (1,101,10,2);

SELECT c.ClientID, c.ItemID, i.ItemName, c.Quantity
FROM #ClientOrders c
JOIN Items i ON c.ItemID = i.ItemID;

--task 15

CREATE PROCEDURE spStaffDetails @StaffID INT
AS
BEGIN
SELECT Name, Department
FROM Staff
WHERE StaffID = @StaffID;
END;

--task 16

CREATE FUNCTION fnAddNumbers (@a FLOAT, @b FLOAT)
RETURNS FLOAT
AS
BEGIN
RETURN @a +@b;
END;

--task 17
CREATE TABLE #NewItemPrices (
ItemiD INT,
ItemName NVARCHAR(100),
Price DECIMAL(10,2)
);


MERGE INTO Items as Target
USING #NewItemPrices as Source
ON Target.ItemID = Source.ItemID
WHEN MATCHED THEN
UPDATE SET Target.Price = Source.Price
WHEN NOT MATCHED THEN
INSERT (ItemID, ItemName, Price)
VALUES (Source.ItemID, Source.ItemName, Source.Price);

--task 18
CREATE TABLE Staff (
StaffID INT,
Name NVARCHAR(100),
Salary DECIMAL(10,2)
);


CREATE VIEW vwStaffSalaries as
SELECT Name, Salary
FROM Staff;

--task 19

CREATE PROCEDURE spClientPurchases @ClientID INT
AS
BEGIN
SELECT * FROM Purchases
WHERE ClientID = @ClientID;
END;

--task 20

CREATE FUNCTION fnStringLength (@input NVARCHAR(MAX))
RETURNS INT
AS
BEGIN
RETURN LEN (@input);
END;

--Medium Tasks

--task 1


CREATE VIEW vwClientOrderHistory  as 
SELECT ClientID, PurchaseDate, Amount
FROM Purchases;

--task 2
SELECT * FROM Purchases;

ALTER TABLE Purchases
ADD Quantity INT;

CREATE TABLE #YearlyItemSales (
ItemID INT,
TotalQuantity INT, 
TotalAmount DECIMAL(10,2)
);

INSERT INTO #YearlyItemSales (ItemID, TotalQuantity, TotalAmount)
SELECT ItemID, SUM(Quantity), SUM(Amount)
FROM Purchases
WHERE YEAR(PurchaseDate) = YEAR(GETDATE())
GROUP BY ItemID;

--task 3
ALTER TABLE Purchases
ADD PurchaseID INT IDENTITY(1,1) PRIMARY KEY;

ALTER TABLE Purchases
ADD Status NVARCHAR(50);

CREATE PROCEDURE spUpdatePurchaseStatus @PurchaseID INT, @Status NVARCHAR(50)
AS
BEGIN
UPDATE Purchases
SET Status = @Status
WHERE PurchaseID = @PurchaseID;
END;


--task 4

CREATE TABLE #NewPurchases (
PurchaseID INT,
ClientID INT,
ItemID INT,
Quantity INT,
Amount DECIMAL(10,2),
PurchaseDate DATE
);

MERGE INTO Purchases as Target
USING #NewPurchases as Source
ON Target.PurchaseID = Source.PurchaseID
WHEN MATCHED THEN 
UPDATE SET 
Target.Amount = Source.Amount, 
Target.PurchaseDate = Source.PurchaseDate
WHEN NOT MATCHED THEN 
INSERT (ClientID, ItemID, Quantity, Amount, PurchaseDate)
VALUES (Source.ClientID, Source.ItemID, Source.Quantity, Source.Amount, Source.PurchaseDate);

--task 5

DECLARE @AvgItemSale DECIMAL(10,2);

SELECT @AvgItemSale = AVG(Amount)
FROM Purchases
WHERE ItemID = 1; 

--task 6

CREATE VIEW vwItemOrderDetails AS 
SELECT p.ItemID, i.ItemName, SUM(p.Quantity) as TotalQuantity
FROM Purchases p
JOIN Items i ON p.ItemID = i.ItemID
GROUP BY p.ItemID, i.ItemName;

--task 7

CREATE FUNCTION fnCalcDiscount (
@amount DECIMAL(10,2),
@discountPercent FLOAT
)
RETURNS DECIMAL(10,2)
AS
BEGIN 
RETURN @amount * @discountPercent / 100;
END;

--task 8

CREATE PROCEDURE spDeleteOldPurchases @CutoffDate DATE
AS
BEGIN
DELETE FROM Purchases
WHERE PurchaseDate < @CutoffDate;
END;

--task 9

CREATE TABLE #SalaryUpdates (
    EmployeeID INT,
    NewSalary DECIMAL(10, 2),
    EffectiveDate DATE
);

INSERT INTO #SalaryUpdates (EmployeeID, NewSalary, EffectiveDate) VALUES
(101, 55000.00, '2025-05-01'),
(102, 62000.00, '2025-05-01'),
(103, 58000.00, '2025-05-01');



MERGE INTO Staff AS Target
USING #SalaryUpdates AS Source
ON Target.StaffID = Source.EmployeeID
WHEN MATCHED THEN
    UPDATE SET Target.Salary = Source.NewSalary;


--task 10
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    StaffID INT,
    Amount DECIMAL(10, 2),
    SaleDate DATE
);

INSERT INTO Sales (SaleID, StaffID, Amount, SaleDate) VALUES
(1, 101, 250.00, '2025-04-01'),
(2, 102, 300.00, '2025-04-02'),
(3, 101, 150.00, '2025-04-03'),
(4, 103, 400.00, '2025-04-04'),
(5, 102, 100.00, '2025-04-05');



CREATE VIEW vwStaffRevenue AS 
SELECT s.StaffID, s.Name, SUM(sales.Amount) as TotalSales
FROM Staff s
JOIN Sales sales ON s.StaffID = sales.StaffID
GROUP BY s.StaffID, s.Name;

--task 11

CREATE FUNCTION fnWeekdayName (@inputDate DATE)
RETURNS NVARCHAR(20)
AS
BEGIN
RETURN DATENAME(WEEKDAY, @inputDate);
END;

--task 12

SELECT * FROM Staff;

ALTER TABLE Staff
ADD Department VARCHAR(100);


CREATE TABLE #TempStaff (
StaffID INT,
Name NVARCHAR(100),
Department NVARCHAR(50)
);

INSERT INTO #TempStaff
SELECT StaffID, Name, Department
FROM Staff;

--task 13

DECLARE @totalPurchases INT;

SELECT @totalPurchases = COUNT(*)
FROM Purchases
WHERE ClientID = 1;

PRINT 'Total Purchases: ' + CAST(@totalPurchases AS NVARCHAR);

--task 14

CREATE PROCEDURE spClientDetails @ClientID INT
AS
BEGIN
SELECT * FROM Clients WHERE ClientID = @ClientID;
SELECT * FROM Purchases WHERE ClientID = @ClientID;
END;

--task 15

CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY,
    ItemID INT,
    Quantity INT,
    DeliveryDate DATE
);

INSERT INTO Delivery (DeliveryID, ItemID, Quantity, DeliveryDate) VALUES
(1, 1, 10, '2025-04-15'),
(2, 2, 5, '2025-04-15'),
(3, 3, 20, '2025-04-16');


MERGE INTO Items as Target
USING Delivery as Source
ON Target.ItemID = Source.ItemID
WHEN MATCHED THEN
UPDATE SET Target.Quantity = Target.Quantity + Source.Quantity;

--task 16

CREATE PROCEDURE spMultiply @a FLOAT, @b FLOAT
AS
BEGIN
PRINT @a * @b;
END;

--task 17

CREATE FUNCTION fnCalcTax (@amount DECIMAL(10,2), @taxRate FLOAT)
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN @amount * @taxRate / 100;
END;

--task 18

SELECT * FROM Staff;
SELECT * FROM Purchases;

ALTER TABLE Purchases
ADD StaffID INT;

UPDATE Purchases
SET StaffID = 101 
WHERE PurchaseID = 1;


CREATE VIEW vwTopPerformingStaff AS 
SELECT s.StaffID, s.Name, COUNT(p.PurchaseID) as TotalOrders
FROM Staff s
JOIN Purchases p ON s.StaffID = p.StaffID
GROUP BY s.StaffID, s.Name;

--task 19

CREATE TABLE #ClientDataTemp (
    ClientID INT,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

INSERT INTO #ClientDataTemp (ClientID, Name, Email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Charlie Lee', 'charlie@example.com');

SELECT * FROM Clients;

ALTER TABLE Clients
ADD Name VARCHAR(100),
    Email VARCHAR(100);




MERGE INTO Clients as Target
USING #ClientDataTemp as Source
ON Target.ClientID = Source.ClientID
WHEN MATCHED THEN
UPDATE SET Target.Name = Source.Name, Target.Email = Source.Email
WHEN NOT MATCHED THEN
INSERT (ClientID, Name, Email)
VALUES (Source.ClientID, Source.Name, Source.Email);

--task 20

CREATE PROCEDURE spTopItems
AS
BEGIN
SELECT TOP 5 ItemID, SUM(Quantity) as TotalSold
FROM Purchases
GROUP BY ItemID
ORDER BY TotalSold desc;
END;

--Difficult Tasks

--task 1

CREATE PROCEDURE spTopSalesStaff @Year INT
AS
BEGIN
SELECT TOP 1 StaffID, SUM(Amount) as TotalRevenue
FROM Sales
WHERE YEAR(SaleDate) = @Year
GROUP BY StaffID
ORDER BY TotalRevenue DESC;
END;

--task 2

CREATE VIEW vwClientOrderStats AS 
SELECT ClientID, COUNT(*) as PurchaseCount, SUM(Amount) as TotalSpent
FROM Purchases
GROUP BY ClientID;

--task 3

ALTER TABLE Items
ADD LastSoldDate DATE,
    SalesCount INT;


MERGE INTO Items as Target
USING Purchases as Source
ON Target.ItemID = Source.ItemID
WHEN MATCHED THEN 
UPDATE SET Target.LastSoldDate = Source.PurchaseDate,
Target.SalesCount = ISNULL(Target.SalesCount, 0) +1 
WHEN NOT MATCHED THEN 
INSERT (ItemID, ItemName)
VALUES (Source.ItemID, 'Unknown');

--task 4

CREATE FUNCTION fnMonthlyRevenue(@Year INT, @Month INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @Revenue DECIMAL(10,2);
SELECT @Revenue = SUM(Amount)
FROM Purchases
WHERE YEAR(PurchaseDate) = @Year AND MONTH(PurchaseDate) = @Month;
RETURN ISNULL (@Revenue, 0);
END;

--task 5

ALTER TABLE OrderDetails
ADD Amount DECIMAL(10, 2);


ALTER TABLE Orders
ADD TotalAmount DECIMAL(10, 2),
    Status VARCHAR(50);


CREATE PROCEDURE spProcessOrderTotals
@OrderID INT,
@Discount FLOAT,
@TaxRate FLOAT
AS
BEGIN
DECLARE @Total DECIMAL(10,2);
SELECT @Total = SUM(Amount) FROM OrderDetails WHERE OrderID = @OrderID;

SET @Total = @Total - (@Total * @Discount / 100);
SET @Total = @Total - (@Total * @TaxRate / 100);

UPDATE Orders SET TotalAmount = @Total, Status = 'Processed'
WHERE OrderID = @OrderID;
END;

--task 6

CREATE TABLE #StaffSalesData (
StaffID INT,
Name NVARCHAR(100),
TotalSales DECIMAL(10,2)
);
INSERT INTO #StaffSalesData
SELECT s.StaffID, s.Name, SUM(sa.Amount)
FROM Staff s 
JOIN Sales sa ON s.StaffID = sa.StaffID
GROUP BY s.StaffID, s.Name;

--task 7


CREATE TABLE #SalesTemp (
    SaleID INT,
    StaffID INT,
    Amount DECIMAL(10, 2),
    SaleDate DATE
);

INSERT INTO #SalesTemp (SaleID, StaffID, Amount, SaleDate) VALUES
(1, 101, 200.00, '2025-04-15'),
(2, 102, 350.00, '2025-04-15'),
(3, 103, 180.00, '2025-04-16');

MERGE INTO Sales as Target
USING #SalesTemp as Source
ON Target.SaleID = Source.SaleID
WHEN MATCHED THEN
UPDATE SET Target.Amount = Source.Amount
WHEN NOT MATCHED THEN
INSERT (SaleID, StaffID,Amount, SaleDate)
VALUES (Source.SaleID, Source.StaffID, Source.Amount, Source.SaleDate);

--task 8

CREATE PROCEDURE spOrdersByDateRange @StartDate DATE, @EndDate DATE
AS
BEGIN
SELECT * FROM Purchases
WHERE PurchaseDate BETWEEN @StartDate AND @EndDate;
END;

--task 9

CREATE FUNCTION fnCompoundInterest (
@Principal DECIMAL(10,2),
@Rate FLOAT,
@Time INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN @Principal * POWER(1 + @Rate / 100, @Time);
END;

--task 10


ALTER TABLE Staff
ADD Quota DECIMAL(10, 2);

UPDATE Staff SET Quota = 500.00 WHERE StaffID = 101;
UPDATE Staff SET Quota = 300.00 WHERE StaffID = 102;


CREATE VIEW vwQuotaExceeders AS
SELECT 
    s.StaffID, 
    s.Name, 
    s.Quota,
    SUM(sa.Amount) AS TotalSales
FROM Staff s
JOIN Sales sa ON s.StaffID = sa.StaffID
GROUP BY s.StaffID, s.Name, s.Quota
HAVING SUM(sa.Amount) > s.Quota;

--task 11

CREATE PROCEDURE spSyncProductStock
AS
BEGIN
MERGE INTO Products as Target
USING StockUpdates as Source
ON Target.ProductID = Source.ProductID
WHEN MATCHED THEN 
UPDATE SET Target.Stock = Source.Stock
WHEN NOT MATCHED THEN
INSERT (ProductID, ProductName, Stock)
VALUES (Source.ProductID, Source.ProductName, Source.Stock);
END;

--task 12

CREATE TABLE ExternalStaffData (
    StaffID INT,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

INSERT INTO ExternalStaffData (StaffID, Name, Department) VALUES
(101, 'Alice', 'Sales'),
(102, 'Bob', 'Marketing'),
(103, 'Charlie', 'IT');

MERGE INTO Staff AS Target
USING ExternalStaffData AS Source
ON Target.StaffID = Source.StaffID
WHEN MATCHED THEN
    UPDATE SET 
        Target.Name = Source.Name, 
        Target.Department = Source.Department
WHEN NOT MATCHED THEN
    INSERT (StaffID, Name, Department)
    VALUES (Source.StaffID, Source.Name, Source.Department);


--task 13

CREATE FUNCTION fnDateDiffDays (@StartDate DATE, @EndDate DATE)
RETURNS INT
AS
BEGIN
RETURN DATEDIFF(DAY, @StartDate, @EndDate);
END;

--task 14

SELECT * FROM Sales;

CREATE PROCEDURE spUpdateItemPrices
AS
BEGIN
    UPDATE Items
    SET Price = Price * 1.10
    WHERE ItemID IN (
        SELECT s.ItemID
        FROM Sales s
        GROUP BY s.ItemID
        HAVING SUM(s.Amount) > 1000
    );

    SELECT ItemID, ItemName, Price FROM Items;
END;

--task 15

CREATE TABLE #ClientData (
    ClientID INT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    RegistrationDate DATE
);


INSERT INTO #ClientData (ClientID, Name, Email, Phone, RegistrationDate) VALUES
(1, 'Alice Johnson', 'alice@example.com', '123-456-7890', '2024-01-15'),
(2, 'Bob Smith', 'bob@example.com', '987-654-3210', '2024-02-20'),
(3, 'Charlie Lee', 'charlie@example.com', '555-111-2222', '2024-03-10');


MERGE INTO Clients as Target
USING #ClientData AS Source
ON Target.ClientID = Source.ClientID
WHEN MATCHED THEN 
UPDATE SET Target.Name = Source.Name, Target.Email = Source.Email
WHEN NOT MATCHED THEN 
INSERT (ClientID, Name, Email)
VALUES (Source.ClientID, Source.Name, Source.Email);

--task 16

SELECT * FROM Sales;

ALTER TABLE Sales
ADD Region VARCHAR(100);

UPDATE Sales
SET Region = 'North'
WHERE SaleID = 1;

UPDATE Sales
SET Region = 'South'
WHERE SaleID = 2;


CREATE PROCEDURE spRegionalSalesReport
AS
BEGIN 
SELECT Region, SUM(Amount) as TotalRevenue, AVG(Amount) as AvgSale,
COUNT(DISTINCT StaffID) as StaffCount
FROM Sales
GROUP BY Region;
END;

--task 17

CREATE FUNCTION fnProfitMargin(@Cost DECIMAL(10,2), @Price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN (@Price - @Cost) / @Price * 100;
END;

--task 18

CREATE TABLE #TempStaffMerge (
StaffID INT,
Name NVARCHAR(100),
department NVARCHAR(100)
);


MERGE INTO Staff as Target
USING #TempStaffMerge as Source
ON Target.StaffID = Source.StaffID
WHEN MATCHED THEN 
UPDATE SET Target.Name = Source.Name, Target.Department = Source.Department
WHEN NOT MATCHED THEN 
INSERT (StaffID, Name, Department)
values (Source.StaffID, Source.Name, Source.Department);


--task 19

CREATE PROCEDURE spBackupData
AS
BEGIN 
INSERT INTO Purchases_Backup
SELECT * FROM Purchases;
PRINT 'Bachup complete.';
END;

--task 20

CREATE PROCEDURE spTopSalesReport
AS
BEGIN
SELECT TOP 10
ROW_NUMBER() OVER (ORDER BY SUM(Amount) DESC) AS Rank,
StaffID,
SUM(Amount) as TotalSales
FROM Sales
GROUP BY StaffID
ORDER BY TotalSales DESC;
END;
