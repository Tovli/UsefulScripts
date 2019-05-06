-- Top 10 Batches Based on Average Elapsed Time

SELECT TOP (10)
	BatchText						= BatchTexts.text ,
	ExecuutionCount					= QueryStats.execution_count ,
	LastExecutionTime				= QueryStats.last_execution_time ,
	AverageElapsedTime_MicroSeconds	= CAST ((CAST (QueryStats.total_elapsed_time AS DECIMAL(19,2)) / CAST (QueryStats.execution_count AS DECIMAL(19,2))) AS DECIMAL(19,2))
FROM
	sys.dm_exec_query_stats AS QueryStats
CROSS APPLY
	sys.dm_exec_sql_text (QueryStats.sql_handle) AS BatchTexts
ORDER BY
	AverageElapsedTime_MicroSeconds DESC;
GO


-- Top 10 Batches Based on Total Elapsed Time

SELECT TOP (10)
	BatchText						= BatchTexts.text ,
	ExecuutionCount					= QueryStats.execution_count ,
	LastExecutionTime				= QueryStats.last_execution_time ,
	TotalElapsedTime_MicroSeconds	= QueryStats.total_elapsed_time
FROM
	sys.dm_exec_query_stats AS QueryStats
CROSS APPLY
	sys.dm_exec_sql_text (QueryStats.sql_handle) AS BatchTexts
ORDER BY
	TotalElapsedTime_MicroSeconds DESC;
GO


-- Top 10 Batches Based on Total Processor Time

SELECT TOP (10)
	BatchText						= BatchTexts.text ,
	ExecuutionCount					= QueryStats.execution_count ,
	LastExecutionTime				= QueryStats.last_execution_time ,
	TotalProcessorTime_MicroSeconds	= QueryStats.total_worker_time
FROM
	sys.dm_exec_query_stats AS QueryStats
CROSS APPLY
	sys.dm_exec_sql_text (QueryStats.sql_handle) AS BatchTexts
ORDER BY
	TotalProcessorTime_MicroSeconds DESC;
GO


-- Top 10 Batches Based on Total Logical Reads

SELECT TOP (10)
	BatchText			= BatchTexts.text ,
	ExecuutionCount		= QueryStats.execution_count ,
	LastExecutionTime	= QueryStats.last_execution_time ,
	TotalLogicalReads	= QueryStats.total_logical_reads
FROM
	sys.dm_exec_query_stats AS QueryStats
CROSS APPLY
	sys.dm_exec_sql_text (QueryStats.sql_handle) AS BatchTexts
ORDER BY
	TotalLogicalReads DESC;
GO
