select * from members m join RoleShops rs on m.RoleId = rs.RoleId
join ShopSections s on rs.ShopId = s.ShopId
left join MonthlyRevenueIndications mri on s.ShopId = mri.ShopId and s.SectionId = mri.SectionId
where email like N'%topop%'