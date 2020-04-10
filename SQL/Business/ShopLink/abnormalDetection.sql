-- abnormal notifications
select * from members where NotificationStrategy in (1,12,2,22,3,32,5,52) and email like '%mallshoplinkinternal%' 
select * from members where NotificationStrategy in (1,13,2,23,3,33,5,53) and PhoneNumber = 0



-- shops without attached member
select * from shops s left join 
(select * from roleshops where roleid > 29) rs on rs.ShopId = s.ShopId left join 
members m on m.RoleId = rs.RoleId 
where m.MemberId is null and (rs.RoleId is null)

-- Duplicate shops name
select 
sc.ShoppingCenterId, ShoppingCenterName, ShoppingCenterGroupId, ShopName, count(1) numOfDuplicates
from ShoppingCenters sc join shops s on s.ShoppingCenterId = sc.ShoppingCenterId
group by sc.ShoppingCenterId,ShoppingCenterName,ShoppingCenterGroupId, ShopName
having count(1) > 1

-- Duplicate contract
select * from shops where ShoppingCenterShopId in (
select ShoppingCenterShopId from (
  select 
shoppingcentergroupname ,shoppingcentershopid, count(1) numOfDuplicates
from ShoppingCenters sc join shops s on s.ShoppingCenterId = sc.ShoppingCenterId
join shoppingcentergroups scg on sc.shoppingcentergroupid = scg.shoppingcentergroupid
where s.ShopId > 99
group by shoppingcentergroupname ,shoppingcentershopid
having count(1) > 1) a )

-- Duplicate phone number
select email, phonenumber
from members
where PhoneNumber in (
select PhoneNumber
from members 
where PhoneNumber != 0
group by PhoneNumber
having count(1) >1)
order by phonenumber

-- Duplicate email
select email, phonenumber
from members
where email in (
select email
from members
group by Email
having count(1) >1)
order by email

-- Missing sections
select * from shops s left join ShopSections shs on s.ShopId = shs.ShopId
where shs.ShopId is null

-- Missing shopping center group sections
select * from shops s left join 
ShopSections shs on s.ShopId = shs.ShopId join
ShoppingCenters sc on s.ShoppingCenterId = sc.ShoppingCenterId left join
ShoppingCenterGroupSections scgs on scgs.ShoppingCenterGroupId = sc.ShoppingCenterGroupId and scgs.SectionId = shs.SectionId
where scgs.SectionExternalId is null