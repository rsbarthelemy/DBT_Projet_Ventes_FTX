{{ config(
    materialized='table'  -- Create a table, not just a view
) }}

WITH base AS (
    SELECT
        product_id,
        product_name,
        category,
        unit_price,
        
    FROM {{ ref('stg_produits') }}  -- Using the staging model as source
)

SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,  -- Surrogate key
    product_id,
    product_name,
    category,
    unit_price
FROM base
