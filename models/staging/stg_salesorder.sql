{{ config(
    materialized='view'
) }}

SELECT  [order_id]
      ,[customer_id]
      ,[order_date]
      ,[total_amount]
      ,store_id
      ,salesperson_id
  FROM [Ventes_FTX].[trans_actions].[SalesOrder]