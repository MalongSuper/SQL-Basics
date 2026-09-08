USE MarketSystem;
GO

-- Fully backup
Backup Database MarketSystem
To Disk = 'D:\MarketSystem\MarketSystem.bak'
With Format,
	Name = 'Full Backup of MarketSystem'
	
--Differential backup
Backup Database MarketSystem
To Disk = 'D:\MarketSystem\MarketSystem.bak'
With Differential,
	Name = 'Full Backup of MarketSystem'