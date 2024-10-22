{{ config(
    materialized='view'
) }}

SELECT  [product_id]
      ,[productname]
      ,[category]
      ,[price]
      ,[supplier_id]
  FROM [Ventes_FTX].[trans_actions].[produit]