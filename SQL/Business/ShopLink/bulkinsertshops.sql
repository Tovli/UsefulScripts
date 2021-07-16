declare @SHOPPINGCENTERGROUPID int = 14

CREATE TABLE #tempshops(
   Role           NVARCHAR(30) NOT NULL 
  ,shop           NVARCHAR(31) NOT NULL
  ,chain          NVARCHAR(31) NOT NULL
  ,shoppingcenter NVARCHAR(17) NOT NULL
  ,contract       NVARCHAR(9) NOT NULL PRIMARY KEY
);
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'ארומה (צים בית שאן)',N'ארומה (צים בית שאן)',N'ארומה (צים בית שאן)',N'בית שאן',N'100001001');
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'ריקושט',N'ריקושט',N'ריקושט',N'בית שאן',N'100002001');
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'גליתה',N'גליתה',N'גליתה',N'בית שאן',N'100003001');
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'נובו פארם',N'נובו פארם',N'נובו פארם',N'בית שאן',N'100005001');
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'אלקטרו קובי',N'ביג אלקטריק',N'אלקטרו קובי',N'בית שאן',N'100006001');
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'קבוצת אופיס דיפו ג''ויסטיק',N'אופיס דיפו',N'אופיס דיפו',N'בית שאן',N'100008001');
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'הסטוק (צים ערד)',N'הסטוק (צים ערד)',N'הסטוק (צים ערד)',N'בית שאן',N'100009001');
INSERT INTO #tempshops(Role,shop,chain,shoppingcenter,contract) VALUES (N'כפר השעשועים - אבי זדה',N'כפר השעשועים - אבי זדה',N'כפר השעשועים - אבי זדה',N'בית שאן',N'100011001');



insert into Roles(RoleName)
select distinct v.role
from #tempshops v
  left join roles t on t.RoleName = v.role
where t.roleid is null;

insert into ChainGroups(ChainGroupName)
select distinct v.chain
from #tempshops v
  left join Chains t on t.chainName = v.chain
where t.ChainName is null
and ChainName not in (select chaingroupname from ChainGroups)

insert into Chains(ChainName, ChainGroupId)
select distinct v.chain, cg.ChainGroupId
from #tempshops v
  left join Chains t on t.chainName = v.chain
  left join ChainGroups cg on v.chain = cg.ChainGroupName
where t.ChainName is null;

declare @SHOPPINGCENTERGROUPID int = 20
insert into Sections(SectionName, SectionExternalId, ShoppingCenterGroupId)
select distinct category, externalcategory, @SHOPPINGCENTERGROUPID
from #tempshops t left join Sections s on s.SectionName = t.category and s.ShoppingCenterGroupId = @SHOPPINGCENTERGROUPID
where s.SectionName is null

------ Checking shops for duplicate contract
select shop, ShoppingCenter, count(distinct contract)
from #tempshops
group by shop, ShoppingCenter
having count(distinct contract)>1




declare @SHOPPINGCENTERGROUPID int = 20
insert into shops ( shopname, shoppingcenterid, chainid, shoppingcentershopid, creationdate, isdeactivationcandidate)
select distinct shop as shopname, shoppingcenterid, chainid, contract as shoppingcentershopid, dateadd(m,-1, getutcdate()) as creationdate, 0 as isdeactivationcandidate
from #tempshops s
left join chains c on s.chain = c.chainname
left join shoppingcenters sc on sc.shoppingcentername = s.shoppingcenter and shoppingcentergroupid = @SHOPPINGCENTERGROUPID
where not exists (select 1 from shops where shopname = s.shop and shoppingcenterid = sc.shoppingcenterid)



declare @SHOPPINGCENTERGROUPID int = 20
insert into shopsections (shopid, sectionid)
select shopid, se.SectionId
from #tempshops t join shops s on t.shop = s.ShopName and t.contract = s.ShoppingCenterShopId
join shoppingcenters sc on s.shoppingcenterid = sc.shoppingcenterid
join Sections se on se.SectionName = t.category and se.SectionExternalId = cast(t.externalcategory as  nvarchar)
where sc.shoppingcentergroupid = @SHOPPINGCENTERGROUPID
and se.ShoppingCenterGroupId = @SHOPPINGCENTERGROUPID
and shopid not in (select shopid from shopsections)


insert into RoleShops (ShopId, RoleId)
select distinct s.ShopId
, r.RoleId
from
#tempshops t left join shops s on t.contract = s.ShoppingCenterShopId
left join roles r on t.role = r.RoleName

