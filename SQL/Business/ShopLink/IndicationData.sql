SELECT mri.InsertedDate, mri.ShopId, s.ShopName, sc.ShoppingCenterName, scg.ShoppingCenterGroupName, ContractId, RevenueMonth, RevenueYear, MadeByUser
  FROM [dbo].[MonthlyRevenueIndication] mri
  join Shops s on mri.ShopId = s.ShopId
  join ShoppingCenters sc on sc.ShoppingCenterId = s.ShoppingCenterId
  join ShoppingCenterGroup scg on sc.ShoppingCenterGroupId = scg.ShoppingCenterGroupId


  --------------------------------------------------
  insert into NotificationScheduling (memberId, notificationType, dayofmonth, TimeOfDay, NotificationBody, NotificationTitle)
select MemberId, case when Email is null or Email = 'moshe@ris-il.co.il' then 2 else 1 end as notificationType, 1 as dayOfMonth, '10:00:00' as timeofday, 
N'שלום רב. זוהי הודעת מערכת מחברת ביג אליה מצורף לינק בו הנך יכול להזין את דיווח הפדיון לחודש {{{Month}}} לחנות {{{ShopName}}} במרכז המסחרי {{{ShoppingCenterName}}}. נשמח להזנת הפדיון בהקדם' as notificationBody,
N'הודעה מקדימה' as notificationTitle
from members
where MemberId in ('')
