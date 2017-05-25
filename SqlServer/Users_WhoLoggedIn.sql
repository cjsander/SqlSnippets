--SQL Server
--Determine who is logged in to db

--max allowed
select @@MAX_CONNECTIONS;

--currently open
SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame;

--who is active
sp_who2 'Active';