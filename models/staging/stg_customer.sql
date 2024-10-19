{{ config(
    materialized='view'  -- 'view' or 'table' depending on your needs
) }}

SELECT  [customer_id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[phone_number]
      ,[city]
      ,[country]
  FROM [Ventes_FTX].[trans_actions].[CUSTOMER]