{{ config(
    materialized='table'
) }}

WITH sales_base AS (
    SELECT
        o.Order_ID AS sales_order_id,
        o.Order_Date AS order_date,
        
        p.Product_ID AS product_id,
        c.Customer_ID AS customer_id,
        s.Store_ID AS store_id,
        sp.Salesperson_ID AS salesperson_id,
        od.Quantity AS quantity_sold,
        od.Unit_Price AS unit_price,
        (od.Quantity * od.Unit_Price) AS total_amount
    FROM {{ ref('stg_salesorder') }} o
    JOIN {{ ref('stg_salesorderdetail') }} od ON o.Order_ID = od.Order_ID
    JOIN {{ ref('stg_produits') }} p ON od.Product_ID = p.Product_ID
    JOIN {{ ref('stg_customer') }} c ON o.Customer_ID = c.Customer_ID
    JOIN {{ ref('stg_store') }} s ON o.Store_ID = s.Store_ID
    JOIN {{ ref('stg_sales_person') }} sp ON o.Salesperson_ID = sp.Salesperson_ID
    JOIN {{ ref('dim_date') }} dd ON dd.date_key = o.order_date
)

SELECT
    ROW_NUMBER() OVER (ORDER BY sales_order_id) AS sales_key,  -- Surrogate key for fact table
    sales_order_id,
    order_date,
    product_id,
    customer_id,
    store_id,
    salesperson_id,
    quantity_sold,
    unit_price,
    total_amount
FROM sales_base

