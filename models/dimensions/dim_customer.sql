{{ config(
        materialized='table'
) }}

WITH base_customer AS (
    SELECT  
        [customer_id],
        [first_name],
        [last_name],
        [email],
        [phone_number],
        [city],
        [country]
    FROM {{ ref('stg_customer') }}  
)

SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,  -- Surrogate key
    customer_id,
    [first_name] + ' ' + [last_name] AS customer_name,  -- Added space between names
    email,
    phone_number,
    city,
    country
FROM base_customer
