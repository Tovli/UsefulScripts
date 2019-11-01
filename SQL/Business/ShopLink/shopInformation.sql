  select * from shops s join ShoppingCenters sc on s.ShoppingCenterId = sc.ShoppingCenterId
  join ShoppingCenterGroups scg on sc.ShoppingCenterGroupId = scg.ShoppingCenterGroupId
  join Chains c on s.ChainId = c.ChainId 
  join ChainGroups cg on cg.ChainGroupId = c.ChainGroupId