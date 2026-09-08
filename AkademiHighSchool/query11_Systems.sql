USE AkademiHighSchool;
GO

-- Try to access the views
SELECT * FROM syscomments
SELECT * FROM sysobjects

SELECT o.name, s.text FROM syscomments s JOIN sysobjects o ON s.id = o.id

SELECT * FROM syscolumns
SELECT * FROM sysindexes
SELECT * FROM sysusers
SELECT * FROM syspermissions