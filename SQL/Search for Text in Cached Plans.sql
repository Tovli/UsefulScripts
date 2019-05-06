/*========================================================================================================================

Description:	Search for text in cached plans
Scope:			Instance
Author:			Ian Stirk (http://www.sqlservercentral.com/articles/Performance+Tuning/66729/)
Created:		22/06/2012
Last Updated:	13/02/2014
Notes:			

=========================================================================================================================*/


DECLARE
	@StringToSearchFor AS NVARCHAR(MAX) = N'@p0 int,@p1 int,@p2 datetime,@p3 int,@p4 int,@p5 int,@p6 int)%t0%OPTION_INSTANCE_ID%TFC_OPTION_INSTANCE_MARGIN%TFC_OPTION_INSTANCES%TFC_OPTION_DEFINITION';

SELECT TOP (20)
	BatchText		= BatchTexts.text ,
	StatementText	= SUBSTRING(BatchTexts.text, QueryStats.statement_start_offset/2+1,
						((CASE WHEN QueryStats.statement_end_offset = -1 THEN DATALENGTH(BatchTexts.text)
						 ELSE QueryStats.statement_end_offset END - QueryStats.statement_start_offset)/2)+1),
	BatchPlan		= QueryPlans.query_plan ,
	CacheObjectType	= CachedPlans.cacheobjtype ,
	ObjectType		= CachedPlans.objtype ,
	DatabaseName	= DB_NAME (BatchTexts.dbid) ,
	UseCount		= CachedPlans.usecounts ,
	ExecutionCount	= QueryStats.execution_count ,
	TotalElapsedTime = CONVERT(DECIMAL(19,2), QueryStats.total_elapsed_time) ,
	AverageElapsedTime	= CONVERT(DECIMAL(19,2), QueryStats.total_elapsed_time) / CONVERT(DECIMAL(19,2), QueryStats.execution_count) ,
	RelativeImpactPercent = CONVERT(DECIMAL(19,2), QueryStats.total_elapsed_time) * 100 / SUM(CONVERT(DECIMAL(19,2), QueryStats.total_elapsed_time)) OVER () ,
	QueryStats.creation_time ,
	QueryStats.last_execution_time
FROM
	sys.dm_exec_cached_plans AS CachedPlans
CROSS APPLY
	sys.dm_exec_sql_text (CachedPlans.plan_handle) AS BatchTexts
CROSS APPLY
	sys.dm_exec_query_plan (CachedPlans.plan_handle) AS QueryPlans
LEFT OUTER JOIN sys.dm_exec_query_stats AS QueryStats
ON
	CachedPlans.plan_handle = QueryStats.plan_handle
WHERE
	
	BatchTexts.text LIKE N'%' + @StringToSearchFor + N'%'
AND	BatchTexts.text NOT LIKE N'/*==================================%Description:	Search for text in cached plans%'
ORDER BY
	RelativeImpactPercent DESC;
GO

