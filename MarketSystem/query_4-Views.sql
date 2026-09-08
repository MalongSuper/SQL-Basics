-- Create Simple Views to return all records in each table
USE MarketSystem;
GO

CREATE VIEW View_Supplier AS
SELECT * FROM Supplier;
GO


CREATE VIEW View_Product AS
SELECT * FROM Product;
GO


CREATE VIEW View_MarketStall AS
SELECT * FROM MarketStall;
GO


CREATE VIEW View_Receipt AS
SELECT * FROM Receipt;
GO


CREATE VIEW View_Employee AS
SELECT * FROM Employee;
GO


CREATE VIEW View_Customer AS
SELECT * FROM Customer;
GO


CREATE VIEW View_ReceipthasProduct AS
SELECT * FROM ReceipthasProduct;
GO




-- Drop the View, just in case
DROP VIEW View_Supplier
DROP VIEW View_Product
DROP VIEW View_MarketStall
DROP VIEW View_Receipt
DROP VIEW View_Employee
DROP VIEW View_Customer
DROP VIEW View_ReceipthasProduct
GO



