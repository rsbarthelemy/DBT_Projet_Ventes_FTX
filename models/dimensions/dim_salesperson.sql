{{ config(
    materialized='table'  -- Create a table, not just a view
) }}

WITH base_person AS (
    SELECT
        [salesperson_id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[store_id]
    FROM {{ ref('stg_sales_person') }}  -- Using the staging model as source
)

SELECT
    ROW_NUMBER() OVER (ORDER BY salesperson_id) AS salesperson_key,  -- Surrogate key
    salesperson_id,
    fisrt_name,
    last_name,
    email,
    store_id
FROM base_person
