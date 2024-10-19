{{ config(
    materialized='table'  -- Create a table, not just a view
) }}

WITH base_customer AS (
    SELECT  [customer_id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[phone_number]
      ,[city]
      ,[country]
    FROM {{ ref('stg_customer') }}  -- Using the staging model as source
)

SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id_id) AS customer_key,  -- Surrogate key
    customer_id,
    [first_name] + '' +[last_name]as customer_name,
    email,
    phone_number,
    city,
    country
    FROM base_customer
