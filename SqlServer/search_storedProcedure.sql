--search for stored procedures

select 
 [database name] = db_name() 
,[schema name] =  SCHEMA_NAME([schema_id])
,name [stored proc name]
,create_date [create date]
,modify_date [last modify date]
from sys.objects
where type = 'P'

SELECT 
  ROUTINE_SCHEMA,
  ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE = 'PROCEDURE';

SELECT 
  SCHEMA_NAME(schema_id) AS [Schema],
  name
FROM sys.objects
WHERE type_desc = 'SQL_STORED_PROCEDURE';
