select ShoppingCenterShopId, ShopName, scg.SectionExternalId 
  from shops s join ShopSections shs on s.ShopId = shs.ShopId
  join ShoppingCenters sc on s.ShoppingCenterId = sc.ShoppingCenterId
  join ShoppingCenterGroups scgr on scgr.ShoppingCenterGroupId = sc.ShoppingCenterGroupId
  join ShoppingCenterGroupSections scg on shs.SectionId = scg.SectionId and scg.ShoppingCenterGroupId = scgr.ShoppingCenterGroupId
  where scgr.ShoppingCenterGroupId = 2