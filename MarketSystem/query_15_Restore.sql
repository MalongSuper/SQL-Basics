USE MarketSystem;
GO

RESTORE DATABASE MarketSystem
FROM DISK = 'D:\MarketSystem\MarketSystem.bak'
WITH REPLACE;