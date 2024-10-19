{{ config(
    materialized='table'
) }}

WITH base AS (
    SELECT
        product_id,
        productname,
        category,
        price
        
    FROM {{ ref('stg_produits') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key, 
    product_id,
    productname,
    category,
    price
FROM base
