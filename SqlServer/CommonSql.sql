select * from sys.schemas

select * from INFORMATION_SCHEMA.TABLES

--get row counts
SELECT SCHEMA_NAME(a.schema_id), a.name, sum(b.rows)
FROM sys.objects a
INNER JOIN sys.partitions b ON a.object_id = b.object_id
WHERE a.type = 'U'
GROUP BY a.schema_id, a.name

--find column name in tables
select * FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%bin%'
