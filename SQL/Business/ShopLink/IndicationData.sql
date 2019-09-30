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
where MemberId in ('auth0|5d79025fb295a10c542cf98f','auth0|5d790264b295a10c542cf990','auth0|5d790266f3be1e0c59d8b345','auth0|5d790269b295a10c542cf991','auth0|5d79026b2f35ec0c538f8e51','auth0|5d79026ddced180c54115ea4','email|5d6f5a3c12d56e6b556749de','email|5d73f49112d56e6b5579cca8','email|5d7493f212d56e6b554bf976','email|5d75177712d56e6b5572d3f9','email|5d75177a12d56e6b55736017','email|5d75177b12d56e6b557392a4','sms|5d75177912d56e6b55732e8b')