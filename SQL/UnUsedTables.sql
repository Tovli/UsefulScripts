 with Unused (TableName , [RowCount], DateCreated, DateModified)

AS (

SELECT unusedTable.name AS TableName

,PS.row_count AS [RowCount]

,unusedTable.create_date AS DateCreated

,unusedTable.modify_date AS DateModified

FROM sys.all_objects UnusedTable

JOIN sys.dm_db_partition_stats PS ON OBJECT_NAME(PS.object_id)=unusedTable.name

WHERE unusedTable.type ='U'

AND NOT EXISTS (SELECT OBJECT_ID

FROM sys.dm_db_index_usage_stats

WHERE OBJECT_ID = unusedTable.object_id )

)

SELECT TableName , [RowCount], DateCreated, DateModified

FROM Unused

ORDER BY [RowCount]