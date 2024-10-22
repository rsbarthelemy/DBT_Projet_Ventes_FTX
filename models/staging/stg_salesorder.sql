{{ config(
    materialized='view'
) }}

SELECT  [order_id]
      ,[customer_id]
      ,CAST(CONVERT(VARCHAR(10), order_date, 112) AS INT) as order_date
      ,[total_amount]
      ,store_id
      ,salesperson_id
  FROM [Ventes_FTX].[trans_actions].[SalesOrder]