--Beginner level
--task 1
SELECT SUBSTRING('DATABASE', 1, 4);
--task 2
SELECT CHARINDEX('SQL', 'I love SQL Server')

-- task 3
SELECT REPLACE('Hello World', 'World',  'SQL')  

--task 4
SELECT LEN('Microsoft SQL Server')

--task 5
SELECT RIGHT('Database', 3)

--task 6
SELECT  word,
 LEN(word) - LEN(REPLACE(word, 'a', '')) AS a_count
FROM 
    (VALUES 
        ('apple'), 
        ('banana'), 
        ('grape')
    ) AS words(word);

--task 7
SELECT RIGHT('abcdefg', LEN('abcdefg') -5 )

--task 8
SELECT PARSENAME(REPLACE('SQL is powerful', ' ', '.'),2)
SELECT PARSENAME(REPLACE('I love databases', ' ', '.'),2)

--task 9
SELECT ROUND(15.6789,2)

--task 10
SELECT ABS(-345.67)

--Intermediate Level

--task 11
SELECT SUBSTRING('ABCDEFGHI', 4, 3)

--task 12
SELECT 'XXX' + SUBSTRING('Microsoft', 4, LEN('Microsoft') -3);

--task 13

SELECT CHARINDEX(' ', 'SQL Server 2025');

--task 14
SELECT 'John' + ',' + 'Smith';

--task 15
SELECT PARSENAME(REPLACE( 'The database is very efficient', ' ', '.'),3);

--task 16
SELECT RIGHT('INV1234', LEN('INV1234') - 3);
SELECT RIGHT('ORD5678', LEN ('ORD5678') - 3);

--task 17
SELECT ROUND(CAST(99.5 AS NUMERIC), 0);

--task 18
SELECT DATEDIFF(DAY, '2025-01-01', '2025-03-15');

--task 19
SELECT DATENAME(MONTH, '2025-06-10');

--task 20
SELECT DATEPART(WEEK, '2025-04-22');

--Advanced Level

--task 21
SELECT SUBSTRING('user1@gmail.com', CHARINDEX('@','user1@gmail.com') + 1, LEN('user1@gmail.com'))
SELECT SUBSTRING('admin@company.org', CHARINDEX('@', 'admin@company.org') +1, LEN('admin@company.org'))
--task 22

SELECT LEN('experience') - CHARINDEX('e', REVERSE('experience')) +1;

--task 23

SELECT FLOOR(RAND() * (500-100+1)) + 100;

--task 24

SELECT FORMAT(9876543, 'N0');

--task 25

CREATE TABLE Customers1 (FullName VARCHAR(100)); 
INSERT INTO Customers1 VALUES ('John Doe'), ('Jane Smith')
SELECT LEFT(FullName, CHARINDEX(' ', FullName) - 1) as FirstName From Customers1;

--task 26
SELECT REPLACE('SQL Server is great', ' ', '-');

--task 27

SELECT RIGHT('00000' + CAST(42 AS VARCHAR), 5);

--task 28

SELECT MAX(LEN(value)) AS LongestWordLenght
FROM string_split('SQL is fast and efficient', ' ');

--task 29

SELECT SUBSTRING('Error: Connection failed', CHARINDEX(' ', 'Error: Connection failed') + 1, LEN('Error: Connection failed'));

--task 30
SELECT DATEDIFF(MINUTE, '08:15:00' , '09:45:00');
