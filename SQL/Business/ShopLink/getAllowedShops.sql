
select roleid, rolename
 shopId, shopName
 from (
 select 
 --MemberId, 
 --MemberFirstName, 
 --Email, 
 --PhoneNumber,
 r.roleid,
 RoleName,
 shopId, shopName
from roles r  
--join members m on m.RoleId = r.RoleId
join RoleChains rc on r.RoleId = rc.RoleId
join Chains c on rc.ChainId = c.ChainId
join shops cs on cs.ChainId = c.ChainId


union
select 
--MemberId, 
 --MemberFirstName, 
 --Email, 
 --PhoneNumber,
 r.roleid,
 RoleName,
 s.shopId, shopName
from roles r  
--join members m on m.RoleId = r.RoleId
join RoleShops rs on r.RoleId = rs.RoleId
join shops s on rs.ShopId = s.ShopId

union
select 
--MemberId, 
 --MemberFirstName, 
 --Email, 
 --PhoneNumber,
 r.roleid,
 RoleName,
 shopId, shopName
from roles r  
--join members m on m.RoleId = r.RoleId
join RoleShoppingCenters rsc on r.RoleId = rsc.RoleId
join shops srsc on rsc.ShoppingCenterId = srsc.ShoppingCenterId
) a 


