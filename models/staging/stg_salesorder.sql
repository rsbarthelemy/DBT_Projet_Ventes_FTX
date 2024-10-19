{{ config(
    materialized='view'  -- 'view' or 'table' depending on your needs
) }}

SELECT  [order_id]
      ,[customer_id]
      ,[order_date]
      ,[total_amount]
      ,store_id
  FROM [Ventes_FTX].[trans_actions].[SalesOrder]