select t2.session_id,host_name,t3.login_name,t3.status,DB_NAME(t2.database_id) DatabaseName,blocking_session_id AS Blocked_by,SUBSTRING(t1.text, (t2.statement_start_offset/2)+1,((CASE t2.statement_end_offset WHEN -1 THEN DATALENGTH(t1.text)   
WHEN 0 THEN DATALENGTH(t1.text)                      
ELSE t2.statement_end_offset END - t2.statement_start_offset)/2) + 1) AS command,t2.cpu_time,t2.reads,t2.writes,wait_time  ,t2.wait_type,last_request_end_time ,program_name    
,plan_handle
--,qp.query_plan       
from    
sys.dm_exec_requests t2   
cross APPLY sys.dm_exec_sql_text (t2.sql_handle) t1
--outer apply sys.dm_exec_query_plan (plan_handle)    qp
INNER JOIN sys.dm_exec_sessions t3 ON t3.session_id=t2.session_id   
where t2.session_id != @@SPID
ORDER BY t2.session_id ;