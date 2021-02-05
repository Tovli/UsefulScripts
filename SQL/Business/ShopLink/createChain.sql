declare @CHAINNAME nvarchar(50)
set @CHAINNAME = N'שוקה בעיר (צ''ק פוסט)' 
if not exists (select 1 from ChainGroups where ChainGroupName = @CHAINNAME)
begin
	insert into ChainGroups(ChainGroupName)
	Values(@CHAINNAME)
end

insert into Chains(ChainName, ChainGroupId)
values(@CHAINNAME, (select chaingroupid from ChainGroups where ChainGroupName = @CHAINNAME))