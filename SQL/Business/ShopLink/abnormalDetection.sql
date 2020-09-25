set transaction isolation level read UNCOMMITTED
-- abnormal notifications
select * from members m join [dbo].[MemberNotificationStrategy] mns on m.MemberId = mns.memberid 
where mns.NotificationStrategyid in (1,12,2,22,3,32,5,52) and m.email like '%mallshoplinkinternal%' 

-----------------  No mail but notification is mail related FIX
--update [MemberNotificationStrategy] set NotificationStrategyid = 53
--where NotificationStrategyid in (5,52) and MemberId in 
--(select m.memberid from members m join [dbo].[MemberNotificationStrategy] mns on m.MemberId = mns.memberid 
--where mns.NotificationStrategyid in (1,12,2,22,3,32,5,52) and m.email like '%mallshoplinkinternal%' )


--update MemberNotificationStrategy set NotificationStrategyId = 13
--where NotificationStrategyid in (1,12) and MemberId in 
--(select m.memberid from members m join [dbo].[MemberNotificationStrategy] mns on m.MemberId = mns.memberid 
--where mns.NotificationStrategyid in (1,12,2,22,3,32,5,52) and m.email like '%mallshoplinkinternal%'


select * from members m join [dbo].[MemberNotificationStrategy] mns on m.MemberId = mns.memberid 
where mns.NotificationStrategyid in (1,13,2,23,3,33,5,53) and m.PhoneNumber = 0

-----------------  No phone but notification is phone related FIX
--update MemberNotificationStrategy set NotificationStrategyid = 52
--where NotificationStrategyid in (5,53) and MemberId in 
--(select m.MemberId from members m join [dbo].[MemberNotificationStrategy] mns on m.MemberId = mns.memberid 
--where mns.NotificationStrategyid in (1,13,2,23,3,33,5,53) and m.PhoneNumber = 0)

--update MemberNotificationStrategy set NotificationStrategyid = 12
--where NotificationStrategyid in (1,13) and MemberId in 
--(select m.MemberId from members m join [dbo].[MemberNotificationStrategy] mns on m.MemberId = mns.memberid 
--where mns.NotificationStrategyid in (1,13,2,23,3,33,5,53) and m.PhoneNumber = 0)

--update MemberNotificationStrategy set NotificationStrategyid = 22
--where NotificationStrategyid in (2,23) and MemberId in 
--(select m.MemberId from members m join [dbo].[MemberNotificationStrategy] mns on m.MemberId = mns.memberid 
--where mns.NotificationStrategyid in (1,13,2,23,3,33,5,53) and m.PhoneNumber = 0)


-- shops without attached member
select * from shops s left join 
(select * from roleshops where roleid > 29) rs on rs.ShopId = s.ShopId left join 
members m on m.RoleId = rs.RoleId 
where m.MemberId is null and (rs.RoleId is null)
and (deactivationdate > GETDATE() or DeactivationDate is null)

-- Members without attached shops
select * from Members m left join RoleShops rs on m.RoleId = rs.RoleId
where rs.RoleId is null
and MemberId > 40

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

--------------- Missing sections FIX--------------------
--insert into ShopSections (ShopId,SectionId)
--select s.shopId, 1 from shops s left join ShopSections shs on s.ShopId = shs.ShopId
--where shs.ShopId is null

-- Missing shopping center group sections
select * from shops s left join 
ShopSections shs on s.ShopId = shs.ShopId join
ShoppingCenters sc on s.ShoppingCenterId = sc.ShoppingCenterId left join
ShoppingCenterGroupSections scgs on scgs.ShoppingCenterGroupId = sc.ShoppingCenterGroupId and scgs.SectionId = shs.SectionId
where scgs.SectionExternalId is null

--------- Missing shopping center group sections Naive Fix -----------------
--insert into ShoppingCenterGroupSections (ShoppingCenterGroupId, SectionId, SectionExternalId)
--select distinct sc.shoppingcentergroupid, shs.sectionid, shs.sectionid as SectionExternalId
--from shops s left join 
--ShopSections shs on s.ShopId = shs.ShopId join
--ShoppingCenters sc on s.ShoppingCenterId = sc.ShoppingCenterId left join
--ShoppingCenterGroupSections scgs on scgs.ShoppingCenterGroupId = sc.ShoppingCenterGroupId and scgs.SectionId = shs.SectionId
--where scgs.SectionExternalId is null

-- Check for duplicate roles
select rolename from roles 
group by rolename
having count(1) > 1

--------------- Duplicate notifications
select * from NotificationScheduling A left join NotificationScheduling b on a.NotificationStrategyId = b.NotificationStrategyId and a.NotificationDayOfMonth = b.NotificationDayOfMonth
and a.NotificationType = b.NotificationType
and a.NotificationId != b.NotificationId
where not b.NotificationId is null

------------------ Duplicate sections
select ShoppingCenterGroupId, SectionName from Sections
  group by ShoppingCenterGroupId, SectionName 
  having count(1) > 1


  --------------- Check if there is section belong to other group
   select *
    from ShopSections ssec
  join shops s on ssec.ShopId = s.ShopId
  join ShoppingCenters sc on s.ShoppingCenterId = sc.ShoppingCenterId
  join Sections sec on sec.SectionId = ssec.SectionId
  where sc.ShoppingCenterGroupId != sec.ShoppingCenterGroupId

  -- update ssec
 -- set SectionId = sec2.SectionId
  --   from ShopSections ssec
  -- join shops s on ssec.ShopId = s.ShopId
  -- join ShoppingCenters sc on s.ShoppingCenterId = sc.ShoppingCenterId
  -- join Sections sec on sec.SectionId = ssec.SectionId
  -- join sections sec2 on sec.SectionName = sec2.SectionName and sc.ShoppingCenterGroupId = sec2.ShoppingCenterGroupId
  -- where sc.ShoppingCenterGroupId != sec.ShoppingCenterGroupId
