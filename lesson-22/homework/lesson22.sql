CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

--Aggregated Window Functions

--Task 1

SELECT customer_id, order_date, quantity_sold, SUM(quantity_sold) OVER (PARTITION BY customer_id ORDER BY order_date) as RunningTotal
FROM sales_data;

--task 2

SELECT sale_id, product_category, COUNT(*) OVER (PARTITION BY product_category) as OrderPerCategory
FROM sales_data;

--task 3

SELECT product_category, product_name, quantity_sold, 
MAX(quantity_sold) OVER (PARTITION BY product_category) as MaxSalePerCategory
FROM sales_data;

--task 4

SELECT product_name, product_category, unit_price,  MIN(unit_price) OVER (PARTITION BY product_category) as MinPricePerCategory
FROM sales_data;

--task 5

SELECT order_date, quantity_sold, AVG(quantity_sold) OVER (
ORDER BY order_date
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAverage3Days
FROM sales_data;

--task 6

SELECT region, quantity_sold, SUM(quantity_sold) OVER (PARTITION BY region) as TotalSalesPerRegion
FROM sales_data;

--task 7
WITH TotalPerCustomer as (
SELECT customer_id, SUM(quantity_sold) as TotalPurchase
FROM Sales_data
GROUP BY customer_id
)
SELECT customer_id, TotalPurchase, RANK() OVER (ORDER BY TotalPurchase DESC) AS PurchaseRank
FROM TotalPerCustomer;

--task 8

SELECT customer_id, order_date, quantity_sold, quantity_sold - LAG(quantity_sold) OVER( PARTITION BY customer_id ORDER BY order_date) as DifferenceFromPrevious
FROM sales_data;

--task 9

SELECT * FROM (
SELECT product_name, product_category, unit_price, DENSE_RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS PriceRank
FROM sales_data
) Ranked 
WHERE PriceRank <=3;

--task 10

SELECT region, order_date, quantity_sold, SUM(quantity_sold) OVER (
PARTITION BY region
ORDER BY order_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS CumulativeSales
FROM sales_data;

--Medium quaestions

--task 11

SELECT 
    product_category,
    order_date,
    quantity_sold,
    SUM(quantity_sold) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeRevenue
FROM 
    sales_data;

	--task 12

	SELECT 
    sale_id,
    SUM(sale_id) OVER (ORDER BY sale_id) AS SumPreValues
FROM 
    sales_data;

	--task 13

	CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);


SELECT 
    Value,
    SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM 
    OneColumn;

	--task 14
CREATE TABLE Row_Nums (
    Id INT,
    Vals VARCHAR(10)
);
INSERT INTO Row_Nums VALUES
(101,'a'), (102,'b'), (102,'c'), (103,'f'), (103,'e'), (103,'q'), (104,'r'), (105,'p');

WITH PartitionBase AS (
    SELECT DISTINCT Id
    FROM Row_Nums
),
OddStart AS (
    SELECT 
        Id,
        (ROW_NUMBER() OVER (ORDER BY Id) * 2) - 1 AS StartNumber
    FROM PartitionBase
),
NumberedRows AS (
    SELECT 
        rn.Id,
        rn.Vals,
        ROW_NUMBER() OVER (PARTITION BY rn.Id ORDER BY rn.Vals) AS rn,
        os.StartNumber
    FROM Row_Nums rn
    JOIN OddStart os ON rn.Id = os.Id
)
SELECT 
    Id,
    Vals,
    StartNumber + rn - 1 AS RowNumber
FROM 
    NumberedRows
ORDER BY 
    Id, rn;


--task 15

SELECT customer_id
FROM sales_data
GROUP BY customer_id
HAVING COUNT (DISTINCT product_category) > 1;

--task 16

SELECT s.customer_id, s.region, s.total_amount
FROM sales_data s
JOIN (
SELECT region, AVG(total_amount) as avg_region_spending
FROM sales_data
GROUP BY region
) r_avg ON s.region = r_avg.region
WHERE s.total_amount > r_avg.avg_region_spending;

--task 17

SELECT customer_id, region, SUM(total_amount) as total_spending,
DENSE_RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM sales_data
GROUP BY region, customer_id;

--task 18

SELECT customer_id, order_date, total_amount, SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) as cumulative_sales
FROM sales_data;

--task 19

WITH MonthlySales AS (
    SELECT 
        CAST(DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS DATE) AS month,
        SUM(total_amount) AS monthly_sales
    FROM 
        sales_data
    GROUP BY 
        YEAR(order_date), MONTH(order_date)
)
SELECT 
    month,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY month) AS prev_month_sales,
    ROUND(
        (monthly_sales - LAG(monthly_sales) OVER (ORDER BY month)) 
        / NULLIF(LAG(monthly_sales) OVER (ORDER BY month), 0), 2
    ) AS growth_rate
FROM 
    MonthlySales
ORDER BY 
    month;

--task 20

SELECT 
    customer_id,
    order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_total_amount
FROM 
    sales_data
WHERE 
    total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date);

--Hard Questions

--task 21

SELECT 
    product_name,
    unit_price
FROM 
    sales_data
WHERE 
    unit_price > (SELECT AVG(unit_price) FROM sales_data);

	--task 22

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

SELECT 
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS Tot
FROM MyData;

--task 23

CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

SELECT 
    ID,
    SUM(Cost) AS TotalCost,
    SUM(DISTINCT Quantity) AS TotalQuantity
FROM 
    TheSumPuzzle
GROUP BY 
    ID;

--task 24

CREATE TABLE testSuXVI (
    Level TINYINT, TyZe TINYINT, Result CHAR(1)
);
INSERT INTO testSuXVI VALUES
(0, 1 ,'X'), (1, 5 ,'X'), (2, 2 ,'X'), (3, 2 ,'Z'), (1, 8 ,'X'), (2, 6 ,'Z'),
(1, 20 ,'X'), (2, 9 ,'X'), (3, 32 ,'X'), (4, 91 ,'Z'), (2, 21 ,'Z'), (3, 30 ,'Z');

WITH RankedData AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rnk
    FROM testSuXVI
),
RunningTotal AS (
    SELECT 
        e.TyZe, 
        e.Result, 
        e.rnk,
        (SELECT SUM(z.TyZe) 
         FROM RankedData z 
         WHERE z.rnk <= e.rnk AND z.Result = 'Z') AS RunningSum
    FROM RankedData e
),
FinalOutput AS (
    SELECT 
        TyZe,
        Result,
        RunningSum,
        LAG(RunningSum, 1, 0) OVER (ORDER BY rnk) AS PrevRunningSum
    FROM RunningTotal
)
SELECT 
    TyZe,
    Result,
    RunningSum - PrevRunningSum AS Diff
FROM FinalOutput
ORDER BY Diff;

--task 25

WITH source AS (
  SELECT *
  FROM (VALUES 
    (101, 'a'), 
    (102, 'b'),
    (102, 'c'),
    (103, 'e'),
    (103, 'f'),
    (103, 'q'),
    (104, 'r'),
    (105, 'p')
  ) AS t(Id, Vals)
),
numbered AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
  FROM source
)
SELECT 
  Id,
  Vals,
  CASE rn
    WHEN 1 THEN 2
    WHEN 2 THEN 4
    WHEN 3 THEN 5
    WHEN 4 THEN 7
    WHEN 5 THEN 8
    WHEN 6 THEN 9
    WHEN 7 THEN 11
    WHEN 8 THEN 13
  END AS Changed
FROM numbered;

