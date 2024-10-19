{{ config(
    materialized='view'
) }}

SELECT  [customer_id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[phone_number]
      ,[city]
      ,[country]
  FROM [Ventes_FTX].[trans_actions].[CUSTOMER]