------------------------------------------------------------------------------
  insert into NotificationScheduling (NotificationStrategyId, notificationType, NotificationDayOfMonth, NotificationTimeOfDay, NotificationBody, NotificationTitle)
  -- Initial Email
select 
NotificationStrategyId as NotificationStrategyId,
 1 as notificationType, -- 1=email, 2=sms
2 as NotificationDayOfMonth, 
'06:00:00' as NotificationTimeOfDay, 
N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>MallShopLink reminder</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body style="margin:0;padding:0">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="padding:10px 0 30px 0">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border:1px solid #ccc;border-collapse:collapse">
<tr>
<td align="center" bgcolor="#70bbd9" style="padding:40px 0 30px 0;color:#153643;font-size:28px;font-weight:bold;font-family:Arial,sans-serif">
<img src="https://platform.mallshoplink.com/assets/logo_vertical.png" alt="דיוווח פדיון" width="300" height="230" style="display:block" />
</td>
</tr>
<tr>
<td bgcolor="#ffffff" style="padding:40px 30px 40px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#153643;font-family:Arial,sans-serif;font-size:24px">
<b>פדיונות לחודש {{{Month}}}</b>
</td>
</tr>
<tr>
<td style="padding:20px 0 30px 0;color:#153643;font-family:Arial,sans-serif;font-size:16px;line-height:20px">
לקוח נכבד. היום נשלחו על ידי מערכת מול שופ לינק הודעות תזכורות בדבר דיווח פדיון
לחודש {{{Month}}}, ללקוחות שטרם השלימו את דיווח הפדיון לחודש זה.
לנוחיותך רצ"ב לינק למערכת מול שופ לינק - לכניסה מהירה ללא יוזר וססמא
</td>
</tr>
<tr>
<td>
<table width="100%" align>
<tr>
<td align="center">
<a href="{{{MagicLink}}}" class="button" style="background-color:#008cba;border:0;color:white;padding:15px 32px;text-align:center;text-decoration:none;display:inline-block;font-size:16px">לכניסה למערכת</a>
</td>
</tr>
<tr>
<td>
ניתן גם ללחוץ או להעתיק את הלינק מפה
{{{MagicLink}}}
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td bgcolor="#ee4c50" style="padding:30px 30px 30px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#fff;font-family:Arial,sans-serif;font-size:14px" width="75%">
&reg; MallShopLink, 2020<br />
</td>
<td align="right" width="25%">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td></td>
<td style="font-size:0;line-height:0" width="20">&nbsp;</td>
<td style="font-family:Arial,sans-serif;font-size:12px;font-weight:bold">
<a href="https://www.facebook.com/mallshoplink/" style="color:#fff">
<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/fb.gif" alt="Facebook" width="38" height="38" style="display:block" border="0" />
</a>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>' as notificationBody,
N'לינק לקליטת פדיונות לחודש {{{Month}}}' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,12,2,22,5,52)
union
-----------------------------------------------------------------------------------------------
-- Initial SMS
select 
notificationstrategyId, 
 2 as notificationType, -- 1=email, 2=sms
2 as notificationdayOfMonth, 
'06:00:00' as notificationtimeofday, 
N'לחנות אחת הזינו פדיון {{{Month}}} בביג במסרון חוזר או כנסו ל {{{MagicLink}}}' as notificationBody,
N'שלום' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,13,2,23,5,53)
union
---------------------------------------------------------------------------------------------------------------------
-- 1st Email reminder
select 
notificationstrategyId, 
 1 as notificationType, -- 1=email, 2=sms
5 as notificationdayOfMonth, 
'06:00:00' as notificationtimeofday, 
N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>MallShopLink reminder</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin:0;padding:0">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="padding:10px 0 30px 0">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border:1px solid #ccc;border-collapse:collapse">
<tr>
<td align="center" bgcolor="#70bbd9" style="padding:40px 0 30px 0;color:#153643;font-size:28px;font-weight:bold;font-family:Arial,sans-serif">
<img src="https://platform.mallshoplink.com/assets/logo_vertical.png" alt="תזכורת לדיווח פדיון" width="300" height="230" style="display:block" />
</td>
</tr>
<tr>
<td bgcolor="#ffffff" style="padding:40px 30px 40px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#153643;font-family:Arial,sans-serif;font-size:24px">
<b>דיווח פדיון לחודש {{{Month}}}</b>
</td>
</tr>
<tr>
<td style="padding:20px 0 30px 0;color:#153643;font-family:Arial,sans-serif;font-size:16px;line-height:20px">
שלום רב. לנוחיותך אנו מצרפים פעם נוספת את הלינק באמצעותו הנך מתבקש לדווח את הפדיונות לחודש {{{Month}}}. נודה על הזנת הפדיון בהקדם. בכל שאלה ניתן ליצור קשר במייל חוזר או בטלפון 077-6001701 או ווצאפ 055-2677777
</td>
</tr>
<tr>
<td>
<table width="100%" align>
<tr>
<td align="center">
<a href="{{{MagicLink}}}" class="button" style="background-color:#008cba;border:0;color:white;padding:15px 32px;text-align:center;text-decoration:none;display:inline-block;font-size:16px">להזנת פדיון</a>
</td>
</tr>
<tr>
<td>
ניתן גם ללחוץ או להעתיק את הלינק מפה
{{{MagicLink}}}
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td bgcolor="#ee4c50" style="padding:30px 30px 30px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#fff;font-family:Arial,sans-serif;font-size:14px" width="75%">
&reg; MallShopLink, 2020<br/>
</td>
<td align="right" width="25%">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td></td>
<td style="font-size:0;line-height:0" width="20">&nbsp;</td>
<td style="font-family:Arial,sans-serif;font-size:12px;font-weight:bold">
<a href="https://www.facebook.com/mallshoplink/" style="color:#fff">
<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/fb.gif" alt="Facebook" width="38" height="38" style="display:block" border="0" />
</a>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>' as notificationBody,
N'תזכורת בדבר לינק לקליטת פדיונות לחודש {{{Month}}}' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,12,5,52)
union
----------------------------------------------------------------------------------------------------------
-- 1st Phone reminder
select 
notificationstrategyId, 
 2 as notificationType, -- 1=email, 2=sms
5 as notificationdayOfMonth, 
'06:00:00' as timeofday, 
N'נודה להזנת הפדיון לביג בהתאם להודעה שקבלתם בתחילת החודש' as notificationBody,
N'שלום' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,13,5,53)
union
---------------------------------------------------------------------------------
-- 2nd Email reminder
select 
notificationstrategyId, 
 1 as notificationType, -- 1=email, 2=sms
10 as notificationdayOfMonth, 
'06:00:00' as notificationtimeofday, 
N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>MallShopLink reminder</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin:0;padding:0">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="padding:10px 0 30px 0">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border:1px solid #ccc;border-collapse:collapse">
<tr>
<td align="center" bgcolor="#70bbd9" style="padding:40px 0 30px 0;color:#153643;font-size:28px;font-weight:bold;font-family:Arial,sans-serif">
<img src="https://platform.mallshoplink.com/assets/logo_vertical.png" alt="תזכורת לדיווח פדיון" width="300" height="230" style="display:block" />
</td>
</tr>
<tr>
<td bgcolor="#ffffff" style="padding:40px 30px 40px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#153643;font-family:Arial,sans-serif;font-size:24px">
<b>דיווח פדיון לחודש {{{Month}}}</b>
</td>
</tr>
<tr>
<td style="padding:20px 0 30px 0;color:#153643;font-family:Arial,sans-serif;font-size:16px;line-height:20px">
שלום רב. לנוחיותך אנו מצרפים פעם נוספת את הלינק באמצעותו הנך מתבקש לדווח את הפדיונות לחודש {{{Month}}}. נודה על הזנת הפדיון בהקדם. בכל שאלה ניתן ליצור קשר במייל חוזר או בטלפון 077-6001701 או ווצאפ 055-2677777
</td>
</tr>
<tr>
<td>
<table width="100%" align>
<tr>
<td align="center">
<a href="{{{MagicLink}}}" class="button" style="background-color:#008cba;border:0;color:white;padding:15px 32px;text-align:center;text-decoration:none;display:inline-block;font-size:16px">להזנת פדיון</a>
</td>
</tr>
<tr>
<td>
ניתן גם ללחוץ או להעתיק את הלינק מפה
{{{MagicLink}}}
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td bgcolor="#ee4c50" style="padding:30px 30px 30px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#fff;font-family:Arial,sans-serif;font-size:14px" width="75%">
&reg; MallShopLink, 2020<br/>
</td>
<td align="right" width="25%">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td></td>
<td style="font-size:0;line-height:0" width="20">&nbsp;</td>
<td style="font-family:Arial,sans-serif;font-size:12px;font-weight:bold">
<a href="https://www.facebook.com/mallshoplink/" style="color:#fff">
<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/fb.gif" alt="Facebook" width="38" height="38" style="display:block" border="0" />
</a>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>' as notificationBody,
N'תזכורת בדבר לינק לקליטת פדיונות לחודש {{{Month}}}' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,12,5,52)
union
----------------------------------------------------------------------------------------------------------
-- 2nd Phone reminder
select 
notificationstrategyId, 
 2 as notificationType, -- 1=email, 2=sms
10 as notificationdayOfMonth, 
'06:00:00' as notificationtimeofday, 
N'נודה להזנת הפדיון לביג בהתאם להודעה שקבלתם בתחילת החודש' as notificationBody,
N'שלום' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,13,5,53)
union
--------------------------------------------------------------------------------------
-- 3rd Email reminder
select 
notificationstrategyId, 
 1 as notificationType, -- 1=email, 2=sms
16 as notificationdayOfMonth, 
'06:00:00' as notificationtimeofday, 
N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>MallShopLink reminder</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin:0;padding:0">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="padding:10px 0 30px 0">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border:1px solid #ccc;border-collapse:collapse">
<tr>
<td align="center" bgcolor="#70bbd9" style="padding:40px 0 30px 0;color:#153643;font-size:28px;font-weight:bold;font-family:Arial,sans-serif">
<img src="https://platform.mallshoplink.com/assets/logo_vertical.png" alt="תזכורת לדיווח פדיון" width="300" height="230" style="display:block" />
</td>
</tr>
<tr>
<td bgcolor="#ffffff" style="padding:40px 30px 40px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#153643;font-family:Arial,sans-serif;font-size:24px">
<b>דיווח פדיון לחודש {{{Month}}}</b>
</td>
</tr>
<tr>
<td style="padding:20px 0 30px 0;color:#153643;font-family:Arial,sans-serif;font-size:16px;line-height:20px">
שלום רב. לנוחיותך אנו מצרפים פעם נוספת את הלינק באמצעותו הנך מתבקש לדווח את הפדיונות לחודש {{{Month}}}. נודה על הזנת הפדיון בהקדם. בכל שאלה ניתן ליצור קשר במייל חוזר או בטלפון 077-6001701 או ווצאפ 055-2677777
</td>
</tr>
<tr>
<td>
<table width="100%" align>
<tr>
<td align="center">
<a href="{{{MagicLink}}}" class="button" style="background-color:#008cba;border:0;color:white;padding:15px 32px;text-align:center;text-decoration:none;display:inline-block;font-size:16px">להזנת פדיון</a>
</td>
</tr>
<tr>
<td>
ניתן גם ללחוץ או להעתיק את הלינק מפה
{{{MagicLink}}}
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td bgcolor="#ee4c50" style="padding:30px 30px 30px 30px">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td style="color:#fff;font-family:Arial,sans-serif;font-size:14px" width="75%">
&reg; MallShopLink, 2020<br/>
</td>
<td align="right" width="25%">
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td></td>
<td style="font-size:0;line-height:0" width="20">&nbsp;</td>
<td style="font-family:Arial,sans-serif;font-size:12px;font-weight:bold">
<a href="https://www.facebook.com/mallshoplink/" style="color:#fff">
<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/fb.gif" alt="Facebook" width="38" height="38" style="display:block" border="0" />
</a>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>' as notificationBody,
N'תזכורת בדבר לינק לקליטת פדיונות לחודש {{{Month}}}' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,12,5,52)
union
----------------------------------------------------------------------------------------------------------
-- 3rd Phone reminder
select 
notificationstrategyId, 
 2 as notificationType, -- 1=email, 2=sms
16 as notificationdayOfMonth, 
'06:00:00' as notificationtimeofday, 
N'נודה להזנת הפדיון לביג בהתאם להודעה שקבלתם בתחילת החודש' as notificationBody,
N'שלום' as notificationTitle
from [dbo].[NotificationStrategies]
where NotificationStrategyid in (1,13,5,53)

  insert into NotificationScheduling (NotificationStrategyId, notificationType, NotificationDayOfMonth, NotificationTimeOfDay, NotificationBody, NotificationTitle)
select distinct -1 as notificationstrategyid, NotificationType, NotificationDayOfMonth, N'04:00:00' as notificationtimeofday, NotificationBody, NotificationTitle from NotificationScheduling
