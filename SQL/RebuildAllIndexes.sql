DECLARE @Database VARCHAR(255)   
DECLARE @Table VARCHAR(255)  
DECLARE @cmd NVARCHAR(500)  
DECLARE @fillfactor INT 

SET @fillfactor = 90 
	IF OBJECT_ID('tempdb..#HeapTables') IS NOT NULL DROP TABLE #HeapTables;
SELECT object_name(sys.tables.object_id) as TableName into #HeapTables
 FROM sys.indexes
INNER JOIN sys.tables
ON sys.indexes.object_ID=sys.tables.OBJECT_ID
WHERE sys.indexes.type=0

DECLARE DatabaseCursor CURSOR FOR  
SELECT name FROM master.dbo.sysdatabases   
WHERE name NOT IN ('master','msdb','tempdb','model','distribution')   
ORDER BY 1  

OPEN DatabaseCursor  

FETCH NEXT FROM DatabaseCursor INTO @Database  
WHILE @@FETCH_STATUS = 0  
BEGIN  

   SET @cmd = 'DECLARE TableCursor CURSOR FOR SELECT ''['' + table_catalog + ''].['' + table_schema + ''].['' + 
  table_name + '']'' as tableName FROM [' + @Database + '].INFORMATION_SCHEMA.TABLES 
  WHERE table_type = ''BASE TABLE'''   

   -- create table cursor  
   EXEC (@cmd)  
   OPEN TableCursor   

   FETCH NEXT FROM TableCursor INTO @Table   
   WHILE @@FETCH_STATUS = 0   
   BEGIN   

       IF (@@MICROSOFTVERSION / POWER(2, 24) >= 9)
       BEGIN
			IF Exists (select 1 from #HeapTables where TableName = @Table)
			BEGIN
				SET @cmd =	'alter table ' + @Table + ' Rebuild;'
			END
			ELSE
			BEGIN
				-- SQL 2005 or higher command 
				SET @cmd = 'ALTER INDEX ALL ON ' + @Table + ' REBUILD WITH (FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ');' 
		   END
           EXEC (@cmd) 
       END
       ELSE
       BEGIN
          -- SQL 2000 command 
          DBCC DBREINDEX(@Table,' ',@fillfactor)  
       END

       FETCH NEXT FROM TableCursor INTO @Table   
   END   

   CLOSE TableCursor   
   DEALLOCATE TableCursor  

   FETCH NEXT FROM DatabaseCursor INTO @Database  
END  
CLOSE DatabaseCursor   
DEALLOCATE DatabaseCursor