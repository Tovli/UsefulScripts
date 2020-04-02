select * into #firstPriority
from notificationScheduling 
where memberId in (select memberId from notificationScheduling where dayofweek )