--Executed DbCommand ("406"ms) [Parameters=["@__startDate_Day_0='?' (DbType = Int16), @__startDate_TimeOfDay_1='?' (DbType = Time), @__endDate_TimeOfDay_2='?' (DbType = Time), @__startDate_Month_3='?' (Size = 1) (DbType = Byte), @__startDate_Year_4='?' (DbType = Int16)"], CommandType='Text', CommandTimeout='30']"
SELECT [n].[NotificationId], [n].[TimeOfDay] AS [NotificationTime]
FROM [NotificationScheduling] AS [n]
INNER JOIN [Members] AS [m] ON [n].[MemberId] = [m].[MemberId]
INNER JOIN [Roles] AS [r] ON [m].[RoleId] = [r].[RoleId]
WHERE ((([n].[DayOfMonth] = 10) AND ([n].[TimeOfDay] >= '06:20:00')) AND ([n].[TimeOfDay] <= '23:59:59')) AND (EXISTS (
    SELECT 1
    FROM [RoleShops] AS [r0]
    INNER JOIN [Shops] AS [s] ON [r0].[ShopId] = [s].[ShopId]
    WHERE ([r].[RoleId] = [r0].[RoleId]) AND EXISTS (
        SELECT 1
        FROM [ShopSections] AS [s0]
        WHERE ([s].[ShopId] = [s0].[ShopId]) AND (CASE
            WHEN EXISTS (
                SELECT 1
                FROM [MonthlyRevenueIndications] AS [m0]
                WHERE (([s0].[ShopId] = [m0].[ShopId]) AND ([s0].[SectionId] = [m0].[SectionId])) AND (([m0].[RevenueMonth] = 5) AND ([m0].[RevenueYear] = 2020))) THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
        END = CAST(0 AS bit)))) OR EXISTS (
    SELECT 1
    FROM [RoleShoppingCenters] AS [r1]
    INNER JOIN [ShoppingCenters] AS [s1] ON [r1].[ShoppingCenterId] = [s1].[ShoppingCenterId]
    WHERE ([r].[RoleId] = [r1].[RoleId]) AND EXISTS (
        SELECT 1
        FROM [Shops] AS [s2]
        WHERE ([s1].[ShoppingCenterId] = [s2].[ShoppingCenterId]) AND EXISTS (
            SELECT 1
            FROM [ShopSections] AS [s3]
            WHERE ([s2].[ShopId] = [s3].[ShopId]) AND (CASE
                WHEN EXISTS (
                    SELECT 1
                    FROM [MonthlyRevenueIndications] AS [m1]
                    WHERE (([s3].[ShopId] = [m1].[ShopId]) AND ([s3].[SectionId] = [m1].[SectionId])) AND (([m1].[RevenueMonth] = 5) AND ([m1].[RevenueYear] = 2020))) THEN CAST(1 AS bit)
                ELSE CAST(0 AS bit)
            END = CAST(0 AS bit))))))