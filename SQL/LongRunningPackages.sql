 SET ANSI_WARNINGS OFF
set nocount on
set transaction isolation level read uncommitted
If(OBJECT_ID('tempdb..#PackageDetails') Is Not Null)
Begin
    Drop Table #PackageDetails
End

declare @CheckTime DateTime = getutcdate();

 select environment_name, folder_name + '\' +  package_name as packageName
 into #PackageDetails
 from catalog.executions 
  where status = 2
  and datediff(minute, start_time, getdate()) > 40

select top 1 convert(varchar, @CheckTime, 120) + ' - ' +
	case when @@ROWCOUNT > 1 then 'Found ' + cast(@@ROWCOUNT as nvarchar(max)) + ' long running packages'
	else 'Package ' + packageName + ' is running for a long time in environment ' + environment_name end as WarningText
	
from #PackageDetails	
