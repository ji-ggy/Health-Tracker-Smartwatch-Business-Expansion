
SELECT * FROM corruption
SELECT * FROM state_income

--1. Calculate the percentage of income by state and corruption convictions per capita in relation to the total amount of income by state and corruption convictions per capita.

SELECT
    c.state_usa,
    ROUND((SUM(c.maximum_income) / SUM(SUM(c.maximum_income)) OVER ()) * 100, 2) AS income_percentage,
    ROUND((SUM(co.convictions_per_capita) / SUM(SUM(co.convictions_per_capita)) OVER ()) * 100, 2) AS convictions_percentage
FROM state_income AS c
INNER JOIN corruption AS co ON c.state_usa = co.state_usa
GROUP BY c.state_usa
ORDER BY income_percentage DESC;

--2. Identify the states with the highest and lowest average income.

WITH highest_income AS (
    SELECT state_usa, average_income, 'Highest' AS income_type
    FROM state_income
    ORDER BY average_income DESC
    LIMIT 5
),
lowest_income AS (
    SELECT state_usa, average_income, 'Lowest' AS income_type
    FROM state_income
    ORDER BY average_income ASC
    LIMIT 5
)
SELECT * FROM highest_income
UNION ALL
SELECT * FROM lowest_income;




--3.Identify the states with the highest and lowest corruption conviction rates.

WITH highest_income AS (
    SELECT state_usa, convictions_per_capita,'Highest' AS conviction_rate
    FROM corruption
    ORDER BY convictions_per_capita DESC
    LIMIT 5
),
lowest_income AS (
    SELECT state_usa, convictions_per_capita,'Lowest' AS conviction_rate
    FROM corruption
    ORDER BY convictions_per_capita ASC
    LIMIT 5
)
SELECT * FROM highest_income
UNION ALL
SELECT * FROM lowest_income;





