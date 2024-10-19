{{ config(
    materialized='table'  -- We want to materialize this as a table
) }}

WITH dates AS (
    SELECT
        DATEADD(DAY, number, '2024-01-01') AS date  -- Generates a series of dates
    FROM master..spt_values
    WHERE type = 'P' AND number <= DATEDIFF(DAY, '2024-01-01', '2024-12-31')  -- Adjust date range as necessary
)

SELECT
    CAST(CONVERT(VARCHAR(10), date, 112) AS INT) AS date_key,  -- Surrogate key for the Date Dimension (formatted as YYYYMMDD)
    date AS full_date,
    YEAR(date) AS year,
    MONTH(date) AS month,
    DAY(date) AS day,
    DATEPART(QUARTER, date) AS quarter,
    DATEPART(WEEKDAY, date) AS day_of_week,
    CASE
        WHEN DATEPART(WEEKDAY, date) IN (6, 7) THEN 1
        ELSE 0
    END AS is_weekend,
    DATEPART(WEEK, date) AS week_number,
    CONVERT(VARCHAR, MONTH(date)) + '-' + CONVERT(VARCHAR, YEAR(date)) AS month_year,
    CASE
        WHEN MONTH(date) IN (1, 2, 3) THEN 'Q1'
        WHEN MONTH(date) IN (4, 5, 6) THEN 'Q2'
        WHEN MONTH(date) IN (7, 8, 9) THEN 'Q3'
        WHEN MONTH(date) IN (10, 11, 12) THEN 'Q4'
    END AS fiscal_quarter,
    YEAR(date) AS fiscal_year
FROM dates
