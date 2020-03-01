  insert into NotificationScheduling (memberId, notificationType, dayofmonth, TimeOfDay, NotificationBody, NotificationTitle)
select MemberId, case when Email is null then 2 else 1 end as notificationType, 12 as dayOfMonth, '15:00:00' as timeofday, 
N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>MallShopLink reminder</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>
<body style="margin: 0; padding: 0;">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">	
		<tr>
			<td style="padding: 10px 0 30px 0;">
				<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border: 1px solid #cccccc; border-collapse: collapse;">
					<tr>
						<td align="center" bgcolor="#70bbd9" style="padding: 40px 0 30px 0; color: #153643; font-size: 28px; font-weight: bold; font-family: Arial, sans-serif;">
							<img src="" alt="תזכורת להכנסת פדיון" width="300" height="230" style="display: block;" />
						</td>
					</tr>
					<tr>
						<td bgcolor="#ffffff" style="padding: 40px 30px 40px 30px;">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td style="color: #153643; font-family: Arial, sans-serif; font-size: 24px;">
										<b>הכנסת פדיון לחודש {{{Month}}}</b>
									</td>
								</tr>
								<tr>
									<td style="padding: 20px 0 30px 0; color: #153643; font-family: Arial, sans-serif; font-size: 16px; line-height: 20px;">
										שלום רב. המועד לדיווח פדיונות חודש {{{Month}}} חלף וטרם הוזנו הפדיונות כמתחייב על פי החוזה וכמו כן הם לא דווחו גם באמצעים אחרים. אנו מצרפים פעם נוספת לינק להזנת הפדיונות. בכל שאלה ניתן ליצור קשר במייל חוזר או בטלפון 077-6001701
									</td>
								</tr>
								<tr>
									<td>
                    <table width="100%" align>
                      <tr>
                       
                        <td align="center">
                          <a href="{{{MagicLink}}}" class="button" style="background-color: #008CBA; border: none;color: white;
                                    padding: 15px 32px;
                                    text-align: center;
                                    text-decoration: none;
                                    display: inline-block;
                                    font-size: 16px;">להזנת פדיון</a>
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
						<td bgcolor="#ee4c50" style="padding: 30px 30px 30px 30px;">
							<table border="0" cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td style="color: #ffffff; font-family: Arial, sans-serif; font-size: 14px;" width="75%">
										&reg; MallShopLink, 2019<br/>
										
									</td>
									<td align="right" width="25%">
										<table border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td style="font-family: Arial, sans-serif; font-size: 12px; font-weight: bold;">
													<a href="http://www.twitter.com/" style="color: #ffffff;">
														<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/tw.gif" alt="Twitter" width="38" height="38" style="display: block;" border="0" />
													</a>
												</td>
												<td style="font-size: 0; line-height: 0;" width="20">&nbsp;</td>
												<td style="font-family: Arial, sans-serif; font-size: 12px; font-weight: bold;">
													<a href="http://www.twitter.com/" style="color: #ffffff;">
														<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/210284/fb.gif" alt="Facebook" width="38" height="38" style="display: block;" border="0" />
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
N'בקשה דחופה להזנת פדיונות' as notificationTitle
from members
where MemberId in ('auth0|5d79025fb295a10c542cf98f','auth0|5d790264b295a10c542cf990','auth0|5d790266f3be1e0c59d8b345','auth0|5d790269b295a10c542cf991','auth0|5d79026b2f35ec0c538f8e51','auth0|5d79026ddced180c54115ea4','auth0|5d79026f35410b0c5c24e39b','auth0|5d790272b295a10c542cf993','auth0|5d790274766a0b0dcec0d4f6','auth0|5d79027635410b0c5c24e39d','auth0|5d790278409bcd0dfac2d4b6','auth0|5d79027ba8a7100de74d96d6','auth0|5d79027d766a0b0dcec0d4f9','auth0|5d79027f2f35ec0c538f8e54','auth0|5d790281a8a7100de74d96d7','auth0|5d790283dced180c54115ea7','auth0|5d790286dced180c54115ea9','auth0|5d790288409bcd0dfac2d4b8','auth0|5d79028adced180c54115eab')
-- dereg 2
--and MemberId not in ('auth0|5d790272b295a10c542cf993','auth0|5d79027635410b0c5c24e39d','auth0|5d79027ba8a7100de74d96d6','auth0|5d79027d766a0b0dcec0d4f9','auth0|5d790286dced180c54115ea9','auth0|5d79028adced180c54115eab')
--dereg 3
--and MemberId  not in ('auth0|5d79027f2f35ec0c538f8e54','auth0|5d790281a8a7100de74d96d7')
-- moshe
and MemberId not in ('auth0|5d790266f3be1e0c59d8b345')
