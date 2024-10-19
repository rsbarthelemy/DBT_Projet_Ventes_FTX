{{ config(
    materialized='table'  -- We want to materialize this as a table
) }}

WITH dates AS (
    {{ generate_series("'2024-01-01'", "'2024-12-31'") }}  -- Modify date range as necessary
)

SELECT
    CAST(date AS INT) AS date_key,  -- Surrogate key for the Date Dimension (formatted as YYYYMMDD)
    date AS full_date,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day,
    EXTRACT(QUARTER FROM date) AS quarter,
    EXTRACT(DAYOFWEEK FROM date) AS day_of_week,
    CASE
        WHEN EXTRACT(DAYOFWEEK FROM date) IN (6, 7) THEN 1
        ELSE 0
    END AS is_weekend,
    DATEPART(WEEK, date) AS week_number,
    EXTRACT(MONTH FROM date) || '-' || EXTRACT(YEAR FROM date) AS month_year,
    CASE
        WHEN EXTRACT(MONTH FROM date) IN (1, 2, 3) THEN 'Q1'
        WHEN EXTRACT(MONTH FROM date) IN (4, 5, 6) THEN 'Q2'
        WHEN EXTRACT(MONTH FROM date) IN (7, 8, 9) THEN 'Q3'
        WHEN EXTRACT(MONTH FROM date) IN (10, 11, 12) THEN 'Q4'
    END AS fiscal_quarter,
    EXTRACT(YEAR FROM date) AS fiscal_year
FROM dates
