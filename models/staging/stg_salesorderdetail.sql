{{ config(
    materialized='view'
) }}

SELECT  [SalesOrderDetailID]
      ,[Order_ID]
      ,[Product_ID]
      ,[Quantity]
      ,[unit_price]
  FROM [Ventes_FTX].[trans_actions].[salesorderdetail]
