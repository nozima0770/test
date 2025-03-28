--Easy Questions
--task 1
SELECT ASCII('A');

--task 2

SELECT LEN('Hello World');

--task 3

SELECT REVERSE('OpenAI');

--task 4

SELECT SPACE(5) + 'FUNCTION';

--task 5
SELECT LTRIM('  SQL SERVER');

--task 6
SELECT UPPER('sql');

--task 7
SELECT LEFT('Database', 3);

--task 8
SELECT RIGHT('Technology',4);

--task 9
SELECT SUBSTRING('Programming',3,6);

--task10
SELECT CONCAT('SQL','Server');

--task11
SELECT REPLACE('apple pie', 'apple', 'orange');

--task12
SELECT CHARINDEX('learn', 'Learn SQL with LearnSQL');

--task 13
SELECT CHARINDEX('er', 'Server');

--task 14
SELECT value
FROM string_split('apple,orange,banana', ',');

--task 15
SELECT POWER(2,3);

--task 16
SELECT SQRT(16);

--task 17
SELECT GETDATE();

--task 18
SELECT GETUTCDATE();

--task 19
SELECT DAY('2025-02-03');

--task 20
SELECT DATEADD(DAY, 10, '2025-02-03');

--Medium Questions

--task 1
SELECT CHAR(65);

--task 2
--LTRIM() removes leading spaces
--RTRIM() removes trailing spaces
SELECT LTRIM('  Hello');
SELECT RTRIM('Hello  ');

--task 3
SELECT CHARINDEX('SQL', 'Learn SQL basics');

--task 4
SELECT CONCAT_WS(',','SQL', 'Server');

--task 5
SELECT STUFF('test123',1,4,'exam');

--task 6
SELECT SQUARE(7);

--task 7
SELECT LEFT('International', 5);

--task 8
SELECT RIGHT('Database', 2);

--task 9
SELECT PATINDEX('%n%','Learn SQL');

--task 10
SELECT DATEDIFF(DAY, '2025-01-01', '2025-02-03');

--task 11
SELECT MONTH('2025-02-03');

--task 12
SELECT DATEPART(YEAR, '2025-02-03');

--task 13
SELECT CONVERT(TIME, GETDATE());

--task 14
SELECT SYSDATETIME(); --returns current date and time with fractional seconds (high precision)

--task 15
SELECT DATEADD(DAY,(7+3-DATEPART(WEEKDAY, GETDATE())) % 7, GETDATE()) AS NextWednesday;

--task 16
--GETDATE() - returns local date and time
--GETUTDATE() - returns UTC(Coordinated Universal Time)

--task 17
SELECT ABS(-15);

--task 18
SELECT CEILING(4.57);

--task 19
SELECT CURRENT_TIMESTAMP;

--task 20
SELECT DATENAME(WEEKDAY,'2025-02-03');

--Difficult Questions

--task 1
SELECT REPLACE(REVERSE('SQL Server'), ' ', '');

--task 2

CREATE TABLE #Temp_cities (City VARCHAR(50));

INSERT INTO #Temp_cities (City)
VALUES ('New York'), ('London'), ('Tokyo'), ('Paris');

SELECT STRING_AGG(City, ',') AS AllCities
FROM #Temp_cities;

--task 3
SELECT
CASE 
WHEN CHARINDEX('SQL', 'This is SQL Server') >0
AND CHARINDEX('Server', 'This is SQL Server') >0
THEN 'Yes'
ELSE 'No'
END AS ContainsBoth;

--task 4
SELECT POWER(5, 3);

--task 5
SELECT VALUE
FROM string_split('apple;orange;banana', ';');

--task 6
SELECT TRIM('  SQL  ');

--task 7
SELECT DATEDIFF(HOUR, '2025-03-28 08:00:00', '2025-03-28 16:30:00');

--task 8
SELECT DATEDIFF(MONTH,'2023-05-01', '2025-02-03');

--task 9
SELECT LEN('Learn SQL Server') - CHARINDEX('SQL', REVERSE('Learn SQL Server')) +1;

--task 10
SELECT VALUE
FROM string_split('apple,orange,banana', ',');

--task 11
SELECT DATEDIFF(DAY, '2025-01-01', GETDATE());

--task 12
SELECT LEFT('Data Science', 4);

--task 13
SELECT CEILING(SQRT(225));

--task 14
SELECT CONCAT_WS('|', 'SQL', 'Server');

--task 15
SELECT PATINDEX('%[0-9]%', 'abc123xyz');

--task 16
SELECT CHARINDEX('SQL', 'SQL Server SQL', CHARINDEX('SQL', 'SQL Server SQL') +1);

--task 17
SELECT DATEPART(YEAR, GETDATE());

--task 18
SELECT DATEADD(DAY, -100, GETDATE());

--task 19
SELECT DATENAME(WEEKDAY,  '2025-02-03');

--task 20
SELECT POWER(9, 2) AS SquareOfNine;

