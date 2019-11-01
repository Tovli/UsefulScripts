select 
ShoppingCenterName, ShopName, count(1) numOfDuplicates
from ShoppingCenters sc join shops s on s.ShoppingCenterId = sc.ShoppingCenterId
group by ShoppingCenterName, ShopName
having count(1) > 1