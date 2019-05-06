declare @v varbinary(max)
--select * FROM sys.dm_exec_requests
 
--Get the handle by session_id (SPID)
SELECT @v=0x020000008ff65c0a9bc034d4653f24c7d43d31cc1d706cec
--WHERE session_id = 135
 
--Get the query for the handle
SELECT s2.dbid,
    s1.sql_handle,
    (SELECT TOP 1 SUBSTRING(s2.text,statement_start_offset / 2+1 ,
      ( (CASE WHEN statement_end_offset = -1
         THEN (LEN(CONVERT(nvarchar(max),s2.text)) * 2)
         ELSE statement_end_offset END)  - statement_start_offset) / 2+1))  AS sql_statement,
    execution_count,
    plan_generation_num,
    last_execution_time,
    total_worker_time,
    last_worker_time,
    min_worker_time,
    max_worker_time,
    total_physical_reads,
    last_physical_reads,
    min_physical_reads,
    max_physical_reads,
    total_logical_writes,
    last_logical_writes,
    min_logical_writes,
    max_logical_writes
FROM sys.dm_exec_query_stats AS s1
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS s2
WHERE
    s1.sql_handle = @v
 
ORDER BY s1.sql_handle, s1.statement_start_offset, s1.statement_end_offset