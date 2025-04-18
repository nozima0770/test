--task 1

SELECT *
FROM employees_18
WHERE Salary = (
SELECT MIN(Salary) 
FROM employees_18
);

--task 2

SELECT *
FROM products_18
WHERE price > ( 
SELECT AVG(Price)
FROM products_18
);

--task 3


SELECT *
FROM employees18 e
JOIN departments d ON e.id = d.id
WHERE d.department_name = 'Sales';

--task 4

SELECT c.name 
FROM customers_18 c
LEFT JOIN orders_18 o ON c.customer_id = o.customer_id
WHERE order_id IS NULL;

--task 5


SELECT *
FROM products18
WHERE price = (
SELECT MAX(price)
FROM products18 p
WHERE category_id = p.category_id
);

--task 6


SELECT e.*
FROM employees_18 e
JOIN departments_18 d ON e.department_id = d.id
WHERE d.department_name = (
    SELECT TOP 1 d2.department_name
    FROM employees_18 e2
    JOIN departments_18 d2 ON e2.department_id = d2.id
    GROUP BY d2.department_name
    ORDER BY AVG(e2.salary) DESC
);

--task 7

SELECT *
FROM employees_18 e
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees_18 e2
    WHERE e2.department_id = e.department_id
);

--task 8


SELECT s.student_id, s.name, g.course_id, g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);

--task 9



WITH RankedItems AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY Price DESC) AS rnk
    FROM products18
)
SELECT *
FROM RankedItems
WHERE rnk = 3;

--task 10

SELECT *
FROM employees_18 e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees_18
)
AND salary < (
    SELECT MAX(e2.salary)
    FROM employees_18 e2
    WHERE e2.department_id = e.department_id
);
