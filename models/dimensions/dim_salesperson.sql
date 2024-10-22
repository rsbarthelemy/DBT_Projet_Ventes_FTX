{{ config(
    materialized='table'
) }}

WITH base_person AS (
    SELECT
        [salesperson_id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[store_id]
    FROM {{ ref('stg_sales_person') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY salesperson_id) AS salesperson_key, 
    salesperson_id,
    first_name,
    last_name,
    email,
    store_id
FROM base_person
