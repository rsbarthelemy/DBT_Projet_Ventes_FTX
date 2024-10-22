{{ config(
    materialized='view'
) }}

SELECT  [salesperson_id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[store_id]
  FROM [Ventes_FTX].[trans_actions].[salesperson]