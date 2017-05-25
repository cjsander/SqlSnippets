--Oracle
--Find Column

SELECT *
FROM   all_tab_cols
WHERE 
UPPER(COLUMN_NAME) LIKE '%CRTE_TS%'
AND OWNER = :param
