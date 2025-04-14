CREATE TABLE #Cart1 ( Item VARCHAR(100) PRIMARY KEY ); 
GO

CREATE TABLE #Cart2 ( Item VARCHAR(100) PRIMARY KEY );
GO

INSERT INTO #Cart1 (Item) VALUES ('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO #Cart2 (Item) VALUES ('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit'); 
GO
CREATE TABLE #PhoneDirectory  ( CustomerID INTEGER, [Type] VARCHAR(100), PhoneNumber VARCHAR(12) NOT NULL, PRIMARY KEY (CustomerID, [Type]) ); 
GO

INSERT INTO #PhoneDirectory (CustomerID, [Type], PhoneNumber) VALUES (1001,'Cellular','555-897-5421'), (1001,'Work','555-897-6542'), (1001,'Home','555-698-9874'), (2002,'Cellular','555-963-6544'), (2002,'Work','555-812-9856'), (3003,'Cellular','555-987-6541'); 
GO

CREATE TABLE #ProcessLog ( WorkFlow VARCHAR(100), ExecutionDate DATE, PRIMARY KEY (WorkFlow, ExecutionDate) );
GO

INSERT INTO #ProcessLog (WorkFlow, ExecutionDate) VALUES ('Alpha','6/01/2018'),('Alpha','6/14/2018'),('Alpha','6/15/2018'), ('Bravo','6/1/2018'),('Bravo','6/2/2018'),('Bravo','6/19/2018'), ('Charlie','6/1/2018'),('Charlie','6/15/2018'),('Charlie','6/30/2018');
GO

CREATE TABLE #Inventory ( InventoryDate DATE PRIMARY KEY, QuantityAdjustment INTEGER NOT NULL ); 
GO

INSERT INTO #Inventory (InventoryDate, QuantityAdjustment) VALUES ('7/1/2018',100),('7/2/2018',75),('7/3/2018',-150), ('7/4/2018',50),('7/5/2018',-75);
GO

CREATE TABLE #PlayerScores ( PlayerA INTEGER, PlayerB INTEGER, Score INTEGER NOT NULL, PRIMARY KEY (PlayerA, PlayerB) );
GO

INSERT INTO #PlayerScores (PlayerA, PlayerB, Score) VALUES (1001,2002,150),(3003,4004,15),(4004,3003,125); 
GO

CREATE TABLE #BatchStarts ( Batch CHAR(1), BatchStart INTEGER, PRIMARY KEY (Batch, BatchStart) );
GO

CREATE TABLE #BatchLines ( Batch CHAR(1), Line INTEGER, Syntax VARCHAR(MAX), PRIMARY KEY (Batch, Line) ); 
GO

INSERT INTO #BatchStarts (Batch, BatchStart) VALUES ('A', 1), ('A', 5); 
GO

INSERT INTO #BatchLines (Batch, Line, Syntax) VALUES ('A', 1, 'SELECT *'), ('A', 2, 'FROM Account;'), ('A', 3, 'GO'), ('A', 4, ''), ('A', 5, 'TRUNCATE TABLE Accounts;'), ('A', 6, 'GO');
GO

CREATE TABLE #Sales ( [Year] INTEGER NOT NULL, Amount INTEGER NOT NULL );
GO

INSERT INTO #Sales ([Year], Amount) VALUES (YEAR(GETDATE()),352645), (YEAR(DATEADD(YEAR,-1,GETDATE())),165565), (YEAR(DATEADD(YEAR,-1,GETDATE())),254654), (YEAR(DATEADD(YEAR,-2,GETDATE())),159521), (YEAR(DATEADD(YEAR,-2,GETDATE())),251696), (YEAR(DATEADD(YEAR,-3,GETDATE())),111894);
GO

CREATE TABLE #Groupings ( StepNumber INTEGER PRIMARY KEY, TestCase VARCHAR(100) NOT NULL, [Status] VARCHAR(100) NOT NULL );
GO

INSERT INTO #Groupings (StepNumber, TestCase, [Status]) VALUES (1,'Test Case 1','Passed'), (2,'Test Case 2','Passed'), (3,'Test Case 3','Passed'), (4,'Test Case 4','Passed'), (5,'Test Case 5','Failed'), (6,'Test Case 6','Failed'), (7,'Test Case 7','Failed'), (8,'Test Case 8','Failed'), (9,'Test Case 9','Failed'), (10,'Test Case 10','Passed'), (11,'Test Case 11','Passed'), (12,'Test Case 12','Passed');
GO

CREATE TABLE #Spouses ( PrimaryID VARCHAR(100), SpouseID VARCHAR(100), PRIMARY KEY (PrimaryID, SpouseID) ); 
GO

INSERT INTO #Spouses (PrimaryID, SpouseID) VALUES ('Pat','Charlie'),('Jordan','Casey'), ('Ashley','Dee'),('Charlie','Pat'), ('Casey','Jordan'),('Dee','Ashley'); 
GO

CREATE TABLE #Strings ( QuoteId INTEGER IDENTITY(1,1) PRIMARY KEY, String VARCHAR(100) NOT NULL );
GO

INSERT INTO #Strings (String) VALUES ('SELECT EmpID FROM Employees;'),('SELECT * FROM Transactions;');
GO

CREATE TABLE #WorkflowSteps ( StepID INTEGER PRIMARY KEY, Workflow VARCHAR(50), [Status] VARCHAR(50) );
GO

INSERT INTO #WorkflowSteps (StepID, Workflow, [Status]) VALUES (1, 'Alpha', 'Open'), (2, 'Alpha', 'Open'), (3, 'Alpha', 'Inactive'), (4, 'Alpha', 'Open'), (5, 'Bravo', 'Closed'), (6, 'Bravo', 'Closed'), (7, 'Bravo', 'Open'), (8, 'Bravo', 'Inactive');
GO

CREATE TABLE #BowlingResults ( GameID INTEGER, Bowler VARCHAR(50), Score INTEGER, PRIMARY KEY (GameID, Bowler) );
GO

INSERT INTO #BowlingResults (GameID, Bowler, Score) VALUES (1, 'John', 167), (1, 'Susan', 139), (1, 'Ralph', 95), (1, 'Mary', 90), (2, 'Susan', 187), (2, 'John', 155), (2, 'Dennis', 100), (2, 'Anthony', 78); 
GO

CREATE TABLE #Boxes ( Box CHAR(1), [Length] INTEGER, Width INTEGER, Height INTEGER ); 
GO

INSERT INTO #Boxes (Box, [Length], Width, Height) VALUES ('A', 10, 25, 15), ('B', 15, 10, 25), ('C', 10, 15, 25), ('D', 20, 30, 30), ('E', 30, 30, 20); 
GO

CREATE TABLE lag ( BusinessEntityID INT ,SalesYear INT ,CurrentQuota DECIMAL(20,4) ) 
GO

INSERT INTO lag SELECT 275 , 2005 , '367000.00' UNION ALL SELECT 275 , 2005 , '556000.00' UNION ALL SELECT 275 , 2006 , '502000.00' UNION ALL SELECT 275 , 2006 , '550000.00' UNION ALL SELECT 275 , 2006 , '1429000.00' UNION ALL SELECT 275 , 2006 , '1324000.00'

-Create a sample movie table CREATE TABLE [Movie] (

[MName] [varchar] (10) NULL, [AName] [varchar] (10) NULL, [Roles] [varchar] (10) NULL )

GO

--Insert data in the table

INSERT INTO Movie(MName,AName,Roles) SELECT 'A','Amitabh','Actor' UNION ALL SELECT 'A','Vinod','Villan' UNION ALL SELECT 'B','Amitabh','Actor' UNION ALL SELECT 'B','Vinod','Actor' UNION ALL SELECT 'D','Amitabh','Actor' UNION ALL SELECT 'E','Vinod','Actor'

CREATE TABLE NthHighest ( Name varchar(5) NOT NULL, Salary int NOT NULL )

--Insert the values 
INSERT INTO NthHighest(Name, Salary) VALUES ('e5', 45000), ('e3', 30000), ('e2', 49000), ('e4', 36600), ('e1', 58000)

CREATE TABLE dbo.AlternateMaleFemale ( ID INT ,NAME VARCHAR(10) ,GENDER VARCHAR(1) )
GO

--Insert data 
INSERT INTO dbo.AlternateMaleFemale(ID,NAME,GENDER) VALUES (1,'Neeraj','M'), (2,'Mayank','M'), (3,'Pawan','M'), (4,'Gopal','M'), (5,'Sandeep','M'), (6,'Isha','F'), (7,'Sugandha','F'), (8,'kritika','F')

INSERT INTO Movie(MName,AName,Roles) SELECT 'A','Amitabh','Actor' UNION ALL SELECT 'A','Vinod','Villan' UNION ALL SELECT 'B','Amitabh','Actor' UNION ALL SELECT 'B','Vinod','Actor' UNION ALL SELECT 'D','Amitabh','Actor' UNION ALL SELECT 'E','Vinod','Actor'

--Easy tasks

--task 1
SELECT 
COALESCE(c1.Item, c2.Item) as ItemID,
c1.Item as Cart1_Item,
c2.Item as Cart2_Item
FROM #Cart1 c1
FULL OUTER JOIN #Cart2 c2
ON c1.Item =c2.Item;

--task2
WITH ExecutionDiffs AS (
SELECT 
Workflow,
ExecutionDate,
DATEDIFF(DAY, LAG(ExecutionDate) OVER (PARTITION BY Workflow ORDER BY ExecutionDate), ExecutionDate) AS DayDiff
FROM #ProcessLog
)
SELECT 
Workflow,
AVG(DayDiff) AS AvgDaysBetween
FROM ExecutionDiffs
GROUP BY Workflow;

--task 3
SELECT DISTINCT m1.MName
FROM Movie m1
JOIN Movie m2 ON m1.MName = m2.MName
WHERE m1.AName = 'Amitabh' AND m1.Roles = 'actor'
AND m2.AName = 'Vinod' AND m2.Roles = 'actor';

--task 4
SELECT 
CustomerID,
MAX(CASE WHEN PhoneNumber ='Home' THEN PhoneNumber END) AS Home,
MAX(CASE WHEN PhoneNumber = 'Mobile' THEN PhoneNumber END) AS Mobile,
MAX(CASE WHEN PhoneNumber = 'Work' THEN PhoneNumber END) AS Work
FROM #PhoneDirectory
GROUP BY CustomerID;

--task 5
DECLARE @n INT = 100;
WITH Numbers As (
SELECT 1 AS num
UNION ALL
SELECT num +1 FROM Numbers WHERE  num+1 <=@n
)
SELECT num
FROM Numbers
WHERE num% 9 =0
OPTION (MAXRECURSION 0);

--task 6
SELECT 
bs.Batch,
bs.BatchStart,
MIN(bl.Line) as EndLine
FROM #BatchStarts bs
JOIN #BatchLines bl ON bs.Batch =bl.Batch
WHERE bl.Line > bs.BatchStart AND bl.Syntax = 'GO'
GROUP BY bs.Batch, bs.BatchStart;

--task 7
SELECT 
ItemID
InventoryDate,
QuantityAdjustment,
SUM(QuantityAdjustment) OVER (PARTITION BY ItemID ORDER BY Date) AS RunningBalance
FROM #Inventory;

--task 8

SELECT MAX(Salary)
FROM NthHighest
WHERE Salary < (SELECT MAX(Salary) FROM NthHighest);

--task 9
SELECT
    SUM(CASE WHEN YEAR = YEAR(GETDATE()) THEN Amount ELSE 0 END) AS ThisYear,
    SUM(CASE WHEN YEAR = YEAR(GETDATE()) - 1 THEN Amount ELSE 0 END) AS LastYear,
    SUM(CASE WHEN YEAR = YEAR(GETDATE()) - 2 THEN Amount ELSE 0 END) AS TwoYearsAgo
FROM #Sales;

--Medium Tasks 

--task 1

SELECT [Length], Width, Height, COUNT(*) AS BoxCount
FROM #Boxes
GROUP BY [Length], Width, Height
HAVING COUNT(*) > 1;

--task 2
WITH Numbers AS (
SELECT 1 AS num
UNION ALL
SELECT CASE WHEN num * 2 < 100 THEN num * 2
ELSE num + 1
END 
FROM Numbers
WHERE num < 100
)
SELECT * FROM Numbers;

--task 3
SELECT ws1.StepID, ws1.Status,
(SELECT COUNT(DISTINCT ws2.Status)
FROM #WorkflowSteps ws2
WHERE ws2.StepID <=ws1.StepID) AS UniqueStatuses
FROM #WorkflowSteps ws1;

--task 4

WITH Males as (
SELECT Name, ROW_NUMBER() OVER (ORDER BY ID) AS rn 
FROM AlternateMaleFemale WHERE Gender = 'Male'
),
Females as (
SELECT Name, ROW_NUMBER() OVER (ORDER BY ID) AS rn 
FROM AlternateMaleFemale 
WHERE Gender = 'Female'
)
SELECT M.Name as MaleName, F.Name as FemaleName
FROM Males M
FULL JOIN Females F ON M.rn = F.rn;

--task 5

WITH Grouped as (
SELECT *, 
CASE WHEN LAG(Status) OVER (ORDER BY StepNumber) = Status THEN 0
ELSE 1
END AS StatusChange
FROM #Groupings
),
Numbered as (
SELECT *, SUM(StatusChange) OVER (ORDER BY StepNumber) as GroupID
FROM Grouped
)
SELECT MIN(StepNumber) as MinStep,
       MAX(StepNumber) as MaxStep,
	   Status,
	   COUNT(*) AS StepCount
	   FROM Numbered
	   GROUP BY GroupID, Status;

--task 6

WITH BinaryPermutations AS (
SELECT CAST('0' AS VARCHAR(MAX)) AS bin
UNION ALL
SELECT CAST('1' AS VARCHAR(MAX))
UNION ALL
SELECT bin + '0' FROM BinaryPermutations WHERE LEN(bin) < 4
UNION ALL
SELECT bin + '1' FROM BinaryPermutations WHERE LEN(bin) < 4
)
SELECT * FROM BinaryPermutations
WHERE LEN(bin) = 4;

--task 7
SELECT *, 
CONCAT(LEAST(PrimaryID, SpouseID), '-', GREATEST(PrimaryID, SpouseID)) AS GroupKey
FROM #Spouses;

--task 8
SELECT QuoteID, String,
LAG(String) OVER (ORDER BY QuoteID) AS PreviousQuota
FROM #Strings;

--task 9


SELECT 
    BR1.Bowler AS Player1, 
    BR2.Bowler AS Player2, 
    COUNT(*) AS TimesAdjacent
FROM #BowlingResults BR1
JOIN #BowlingResults BR2
    ON BR1.GameID = BR2.GameID
    AND ABS(BR1.Score - BR2.Score) = 1
    AND BR1.Bowler < BR2.Bowler
GROUP BY BR1.Bowler, BR2.Bowler
HAVING COUNT(*) >= 2;

--task 10

WITH Numbers as (
SELECT 2 AS num
UNION ALL
SELECT num +1 FROM Numbers WHERE num < 100
)
SELECT num
FROM Numbers n
WHERE NOT EXISTS (
SELECT 1 FROM Numbers d
WHERE d.num < n.num AND d.num > 1 AND n.num % d.num = 0
)
OPTION (MAXRECURSION 1000);

--Difficult Tasks 

--task 1
DECLARE @n INT = 4;

WITH BinaryPermutations AS (
SELECT CAST ('0' AS VARCHAR(MAX)) AS bin
UNION ALL
SELECT '1'
UNION ALL
SELECT bin + '0' FROM BinaryPermutations WHERE LEN(bin) < @n
UNION ALL
SELECT bin + '1' FROM BinaryPermutations WHERE LEN(bin) < @n
)
SELECT bin FROM BinaryPermutations
WHERE LEN(bin) = @n;

--task 2

SELECT PlayerA,PlayerB, Score,
NTILE(2) OVER (ORDER BY Score DESC) AS RankGroup
FROM #PlayerScores;

--task 3


WITH Numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master.dbo.spt_values
),
SplitWords AS (
    SELECT
        s.QuoteId, 
        TRIM(w.value) AS Word,
        CHARINDEX(TRIM(w.value), s.String) AS StartPos,
        CHARINDEX(TRIM(w.value), s.String) + LEN(w.value) - 1 AS EndPos,
        ROW_NUMBER() OVER (
            PARTITION BY s.QuoteId 
            ORDER BY CHARINDEX(TRIM(w.value), s.String)
        ) AS WordPosition
    FROM #Strings s
    CROSS APPLY STRING_SPLIT(s.String, ' ') AS w
    WHERE w.value <> ''
)
SELECT QuoteID, Word, WordPosition, StartPos, EndPos
FROM SplitWords
ORDER BY QuoteID, WordPosition;

--task 4
WITH Digits as (
SELECT CAST('1' AS VARCHAR(MAX)) AS val
UNION ALL SELECT '2'
UNION ALL SELECT '3'
),
Permutations as (
SELECT CAST(val as VARCHAR(MAX)) AS perm, val as used
FROM Digits
UNION ALL
SELECT p.perm + d.val,
       p.used + d.val
FROM Permutations p
JOIN Digits d ON CHARINDEX(d.val, p.used) = 0
WHERE LEN(p.perm) <3
)
SELECT perm FROM Permutations
WHERE LEN(perm) =3;

--task 5


WITH Numbers AS (
    SELECT TOP 10000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS num
    FROM master.dbo.spt_values a, master.dbo.spt_values b
),
DivisorSums AS (
    SELECT 
        n.num, 
        SUM(d.num) AS SumDivisors
    FROM Numbers n
    JOIN Numbers d 
        ON d.num < n.num AND n.num % d.num = 0
    GROUP BY n.num
)
SELECT num AS ThreePerfectNumber
FROM DivisorSums
WHERE SumDivisors = 3 * num;
