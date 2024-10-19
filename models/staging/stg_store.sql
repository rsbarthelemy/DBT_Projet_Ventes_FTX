{{ config(
    materialized='view'
) }}

SELECT  [store_id]
      ,[store_name]
      ,[locationstore]
      ,[store_manager]
      ,[start_date]
      ,[end_date]
      ,[is_active]
  FROM [Ventes_FTX].[trans_actions].[store]
