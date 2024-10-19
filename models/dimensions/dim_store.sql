{{ config(
    materialized='table'  -- Create a table, not just a view
) }}

WITH base_store AS (
    SELECT
       [store_id]
      ,[store_name]
      ,[locationstore]
      ,[store_manager]
      ,[start_date]
      ,[end_date]
      ,[is_active]
    FROM {{ ref('stg_store') }}  -- Using the staging model as source
)

SELECT
    ROW_NUMBER() OVER (ORDER BY store_id_id) AS store_key,  -- Surrogate key
    store_id,
  store_name,
   locationstore,
   store_manager,
   start_date,
   end_date,
   is_active
FROM base_store
