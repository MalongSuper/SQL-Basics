-- CREATE SPECIAL VIEWS
USE MarketSystem;
GO

-- Return the Receipt Information and the Name of the Customer
CREATE VIEW View_ReceiptCustomer AS
SELECT r.ReceiptId, r.DateCreated, c.CustomerFName, c.CustomerLName 
FROM Receipt r JOIN Customer c ON r.CustomerId = c.CustomerId;
GO

-- Return the Receipt Information and the Name of the Employee
CREATE VIEW View_ReceiptEmployee AS
SELECT r.ReceiptId, r.DateCreated, e.EmployeeFName, e.EmployeeLName 
FROM Receipt r JOIN Employee e ON r.EmployeeId = e.EmployeeId;
GO

-- Count the total number of products, and the total price in each receipt
CREATE VIEW View_TotalProductsandPriceofReceipt AS
SELECT rp.ReceiptId, SUM(rp.Quantity) AS TotalProducts, SUM(p.Price * rp.Quantity) AS TotalPrice 
FROM ReceipthasProduct rp 
JOIN Product p ON p.ProductId = rp.ProductId GROUP BY rp.ReceiptId;
GO

-- Return the supplier name, total number of products, and the total price of each supplier
CREATE VIEW View_TotalProductsandPriceofSupplier AS
SELECT s.SuppName, COUNT(p.ProductId) AS TotalProducts, SUM(p.Price) AS TotalPrice
FROM Supplier s 
JOIN Product p ON s.SuppId = p.SupplierId GROUP BY s.SuppName;
GO

-- New View (After the ProductLevel is added), return the ProductLevel and the number of Products
CREATE VIEW View_ProductLevelProducts AS
SELECT ProductLevel, COUNT(ProductLevel) AS NumberofProducts FROM Product GROUP BY ProductLevel;
GO

-- Return the ProductName and the Stall selling the products
CREATE VIEW View_MarketStallProduct AS
SELECT p.ProductName, m.StallName FROM MarketStall m JOIN Product p ON m.StallNumber = p.StallNumber;
GO

-- Return the Stall Name, the total number of products, the total price
CREATE VIEW View_StallProductsPrice AS
SELECT m.StallName, COUNT(p.ProductId) AS TotalProducts, SUM(p.Price) AS TotalPrice FROM MarketStall m JOIN Product p ON m.StallNumber = p.StallNumber
GROUP BY m.StallName;
GO

-- Return the total price of all existing receipts
CREATE VIEW View_TotalPriceReceipt AS
SELECT rp.ReceiptId, SUM(rp.Quantity * p.Price) AS TotalPrice
FROM ReceipthasProduct rp JOIN Product p ON p.ProductId = rp.ProductId
GROUP BY rp.ReceiptId
GO


DROP VIEW View_ReceiptCustomer 
DROP VIEW View_ReceiptEmployee
DROP VIEW View_TotalProductsandPriceofReceipt
DROP VIEW View_TotalProductsandPriceofSupplier
DROP VIEW View_ProductLevelProducts
DROP VIEW View_MarketStallProduct
DROP VIEW View_StallProductsPrice
DROP VIEW View_TotalPriceReceipt;
GO



--Shows each customer and how many receipts they've made along with total spending
CREATE VIEW View_CustomerReceiptSummary AS
SELECT 
    c.CustomerId,
    c.CustomerFName,
    c.CustomerLName,
    COUNT(r.ReceiptId) AS TotalReceipts,
    ISNULL(SUM(rp.Quantity * p.Price), 0) AS TotalSpent
FROM Customer c
LEFT JOIN Receipt r ON c.CustomerId = r.CustomerId
LEFT JOIN ReceipthasProduct rp ON r.ReceiptId = rp.ReceiptId
LEFT JOIN Product p ON rp.ProductId = p.ProductId
GROUP BY c.CustomerId, c.CustomerFName, c.CustomerLName;
GO

--Lists employees grouped by role and shows average salary in each role.
CREATE VIEW View_EmployeeRoleSalarySummary AS
SELECT 
    EmployeeRole,
    COUNT(*) AS TotalEmployees,
    AVG(EmployeeSalary) AS AverageSalary,
    MAX(EmployeeSalary) AS MaxSalary,
    MIN(EmployeeSalary) AS MinSalary
FROM Employee
GROUP BY EmployeeRole;
GO

--Summarizes min, max, and average prices of products in each category.
CREATE VIEW View_ProductPriceRangeByCategory AS
SELECT 
    c.CategoryId,
    c.CategoryName,
    COUNT(p.ProductId) AS ProductCount,
    MIN(p.Price) AS MinPrice,
    MAX(p.Price) AS MaxPrice,
    AVG(p.Price) AS AvgPrice
FROM Category c
LEFT JOIN Product p ON p.CategoryId = c.CategoryId
GROUP BY c.CategoryId, c.CategoryName;
GO

--Lists receipts that have been shipped, with customer and shipping status.
CREATE VIEW View_ShippedReceipts AS
SELECT 
    r.ReceiptId,
    c.CustomerFName + ' ' + c.CustomerLName AS CustomerName,
    s.ShippingDate,
    s.ShippingStatus,
    s.ShippingAddress
FROM Receipt r
JOIN Customer c ON r.CustomerId = c.CustomerId
JOIN ShippingDetail s ON r.ReceiptId = s.ReceiptId
WHERE s.ShippingStatus IN ('Shipped', 'Delivered');
GO

--Lists top 5 most purchased products by total quantity.
CREATE VIEW View_Top5PopularProducts AS
SELECT TOP 5 
    p.ProductId,
    p.ProductName,
    SUM(rp.Quantity) AS TotalSold
FROM ReceipthasProduct rp
JOIN Product p ON p.ProductId = rp.ProductId
GROUP BY p.ProductId, p.ProductName
ORDER BY TotalSold DESC;
GO
