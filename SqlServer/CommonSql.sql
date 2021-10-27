select * from sys.schemas

select * from INFORMATION_SCHEMA.TABLES

--get rowcounts
SELECT SCHEMA_NAME(a.schema_id), a.name, sum(b.rows)
FROM sys.objects a
INNER JOIN sys.partitions b ON a.object_id = b.object_id
WHERE a.type = 'U'   
GROUP BY a.schema_id, a.name
HAVING sum(b.rows) > 0

--find column name in tables
select distinct TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
 FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%bin%'
order by table_schema, table_name
