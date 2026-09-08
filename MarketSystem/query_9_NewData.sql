-- New Data
USE MarketSystem;
GO

-- Create table Category
CREATE TABLE Category (
    CategoryId VARCHAR(4) NOT NULL,
    CategoryName VARCHAR(50) NOT NULL
);
GO

-- Create table Account
CREATE TABLE Account (
    AccountId VARCHAR(20) NOT NULL,
    CustomerId INT NOT NULL,
    Password VARCHAR(50) NOT NULL
);
GO

-- Create table Cart
CREATE TABLE Cart (
    CartId VARCHAR(5) NOT NULL,
    CustomerId INT NOT NULL,
    CreatedDate DATETIME
);
GO

-- Create table CartItem
CREATE TABLE CartItem (
    CartId VARCHAR(5) NOT NULL,
    ProductId VARCHAR(4) NOT NULL,
    Quantity TINYINT NOT NULL
);
GO

-- Create table Shipping
CREATE TABLE ShippingDetail (
    ShippingId VARCHAR(5) NOT NULL,
    ReceiptId VARCHAR(4) NOT NULL,
    EmployeeId VARCHAR(9) NOT NULL,
    ShippingAddress VARCHAR(100) NOT NULL,
    ShippingDate DATE,
    ShippingStatus VARCHAR(20)
);
GO

GO

-- Constraints for Category
ALTER TABLE Category
ADD CONSTRAINT pk_Category PRIMARY KEY (CategoryId),
    CONSTRAINT up_CategoryName UNIQUE (CategoryName),
    CONSTRAINT chk_CategoryId CHECK (CategoryId LIKE 'C[0-9][0-9][0-9]');
GO

-- Add foreign key to Product
ALTER TABLE Product
ADD CategoryId VARCHAR(4) NULL,
    CONSTRAINT fk_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId),
    CONSTRAINT df_CategoryId DEFAULT 'C006' FOR CategoryId;
GO

-- Constraints for Account
ALTER TABLE Account
ADD CONSTRAINT pk_Account PRIMARY KEY (AccountId),
    CONSTRAINT up_CustomerId UNIQUE (CustomerId),
    CONSTRAINT fk_AccountCustomer FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId);
GO

-- Constraints for Cart
ALTER TABLE Cart
ADD CONSTRAINT df_CreatedDate DEFAULT GETDATE() FOR CreatedDate,
    CONSTRAINT pk_Cart PRIMARY KEY (CartId),
    CONSTRAINT fk_CartCustomer FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
    CONSTRAINT chk_CartId CHECK (CartId LIKE 'G[0-9][0-9][0-9][0-9]');
GO

-- Constraints for CartItem
ALTER TABLE CartItem
ADD CONSTRAINT df_Cartquantity DEFAULT 1 FOR Quantity,
    CONSTRAINT pk_CartItem PRIMARY KEY (CartId, ProductId),
    CONSTRAINT fk_CartItemCart FOREIGN KEY (CartId) REFERENCES Cart(CartId),
    CONSTRAINT fk_CartItemProduct FOREIGN KEY (ProductId) REFERENCES Product(ProductId),
    CONSTRAINT chk_CartItemQuantity CHECK (Quantity > 0);
GO

-- Constraints for ShippingDetail
ALTER TABLE ShippingDetail
ADD CONSTRAINT df_ShippingDate DEFAULT GETDATE() FOR ShippingDate,
    CONSTRAINT df_ShippingStatus DEFAULT 'Pending' FOR ShippingStatus,
    CONSTRAINT pk_Shipping PRIMARY KEY (ShippingId),
    CONSTRAINT fk_ShippingReceipt FOREIGN KEY (ReceiptId) REFERENCES Receipt(ReceiptId),
    CONSTRAINT fk_ShippingEmployee FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId),
    CONSTRAINT chk_ShippingId CHECK (ShippingId LIKE 'SH[0-9][0-9][0-9]'),
    CONSTRAINT uq_ShippingReceipt UNIQUE (ReceiptId);
GO


INSERT INTO Category (CategoryId, CategoryName) VALUES
('C001', N'Tropical Fruits'),
('C002', N'Leafy Greens'),
('C003', N'Root Vegetables'),
('C004', N'Stone Fruits'),
('C005', N'Gourds & Melons'), 
('C006', N'Others');
GO

UPDATE Product SET CategoryId = 'C001' WHERE ProductId IN ('P001', 'P002', 'P005', 'P009', 'P013', 'P014', 'P016', 'P017', 'P025');
UPDATE Product SET CategoryId = 'C002' WHERE ProductId IN ('P010', 'P012', 'P020');
UPDATE Product SET CategoryId = 'C003' WHERE ProductId IN ('P004', 'P019', 'P026', 'P022', 'P027');
UPDATE Product SET CategoryId = 'C004' WHERE ProductId IN ('P015', 'P011');
UPDATE Product SET CategoryId = 'C005' WHERE ProductId IN ('P003', 'P006', 'P024');
GO



INSERT INTO Account (AccountId, CustomerId, Password) VALUES
('acc10000', 10000, 'pass123'),
('acc10001', 10001, 'abc@123'),
('acc10002', 10002, 'hello456'),
('acc10003', 10003, 'secure789'),
('acc10004', 10004, 'admin@2025'),
('acc10005', 10005, 'user1005!'),
('acc10006', 10006, 'admin#1006'),
('acc10007', 10007, 'abc@1007'),
('acc10008', 10008, 'pass1008'),
('acc10009', 10009, 'user@1009'),
('acc10010', 10010, 'admin2025'),
('acc10011', 10011, 'pass#1011'),
('acc10012', 10012, 'abc!1012'),
('acc10013', 10013, 'user1013'),
('acc10014', 10014, 'admin@1014'),
('acc10015', 10015, 'pass1015!'),
('acc10016', 10016, 'abc1016'),
('acc10017', 10017, 'user#1017'),
('acc10018', 10018, 'admin1018'),
('acc10019', 10019, 'pass@1019'),
('acc10020', 10020, 'abc!1020'),
('acc10021', 10021, 'user1021'),
('acc10022', 10022, 'admin#1022'),
('acc10023', 10023, 'pass1023'),
('acc10024', 10024, 'abc@1024'),
('acc10025', 10025, 'user@1025'),
('acc10026', 10026, 'admin1026'),
('acc10027', 10027, 'pass#1027'),
('acc10028', 10028, 'abc!1028'),
('acc10029', 10029, 'user1029'),
('acc10030', 10030, 'admin@1030'),
('acc10031', 10031, 'pass1031!'),
('acc10032', 10032, 'abc1032'),
('acc10033', 10033, 'user#1033'),
('acc10034', 10034, 'admin1034'),
('acc10035', 10035, 'pass@1035'),
('acc10036', 10036, 'abc!1036'),
('acc10037', 10037, 'user1037'),
('acc10038', 10038, 'admin#1038'),
('acc10039', 10039, 'pass1039');


INSERT INTO Account (AccountId, CustomerId, Password) VALUES
('acc11001', 11001, 'pass1101!'),
('acc11002', 11002, 'abc@1102'),
('acc11003', 11003, 'admin#1103'),
('acc11004', 11004, 'user1104'),
('acc11005', 11005, 'pass#1105'),
('acc11006', 11006, 'abc1106'),
('acc11007', 11007, 'admin1107'),
('acc11008', 11008, 'user@1108'),
('acc11009', 11009, 'pass1109'),
('acc11010', 11010, 'abc!1110'),
('acc11011', 11011, 'admin@1111'),
('acc11012', 11012, 'user#1112'),
('acc11013', 11013, 'pass1113!'),
('acc11014', 11014, 'abc1114'),
('acc11015', 11015, 'admin1115'),
('acc11016', 11016, 'user@1116'),
('acc11017', 11017, 'pass#1117'),
('acc11018', 11018, 'abc1118'),
('acc11019', 11019, 'admin1119'),
('acc11020', 11020, 'user1100'),
('acc11021', 11021, 'pass1121!'),
('acc11022', 11022, 'abc@1122'),
('acc11023', 11023, 'admin#1123'),
('acc11024', 11024, 'user1124'),
('acc11025', 11025, 'pass#1125'),
('acc11026', 11026, 'abc1126'),
('acc11027', 11027, 'admin1127'),
('acc11028', 11028, 'user@1128'),
('acc11029', 11029, 'pass1129'),
('acc11030', 11030, 'abc!1130'),
('acc11031', 11031, 'admin@1131'),
('acc11032', 11032, 'user#1132'),
('acc11033', 11033, 'pass1133!'),
('acc11034', 11034, 'abc1134'),
('acc11035', 11035, 'admin1135'),
('acc11036', 11036, 'user@1136'),
('acc11037', 11037, 'pass#1137'),
('acc11038', 11038, 'abc1138'),
('acc11039', 11039, 'admin1139'),
('acc11040', 11040, 'user1140');
GO


INSERT INTO Account (AccountId, CustomerId, Password) VALUES
('acc12001', 12001, 'pass1201!'),
('acc12002', 12002, 'abc@1202'),
('acc12003', 12003, 'admin#1203'),
('acc12004', 12004, 'user1204'),
('acc12005', 12005, 'pass#1205'),
('acc12006', 12006, 'pass1206!'),
('acc12007', 12007, 'abc@1207'),
('acc12008', 12008, 'admin#1208'),
('acc12009', 12009, 'user1209'),
('acc12010', 12010, 'pass#1210'),
('acc12011', 12011, 'pass1211!'),
('acc12012', 12012, 'abc@1212'),
('acc12013', 12013, 'admin#1213'),
('acc12014', 12014, 'user1214'),
('acc12015', 12015, 'pass#1215'),
('acc12016', 12016, 'pass1216!'),
('acc12017', 12017, 'abc@1217'),
('acc12018', 12018, 'admin#1218'),
('acc12019', 12019, 'user1219'),
('acc12020', 12020, 'pass#1220'),
('acc12021', 12021, 'pass1221!'),
('acc12022', 12022, 'abc@1222'),
('acc12023', 12023, 'admin#1223'),
('acc12024', 12024, 'user1224'),
('acc12025', 12025, 'pass#1225'),
('acc12026', 12026, 'pass1226!'),
('acc12027', 12027, 'abc@1227'),
('acc12028', 12028, 'admin#1228'),
('acc12029', 12029, 'user1229'),
('acc12030', 12030, 'pass#1230'),
('acc12031', 12031, 'pass1231!'),
('acc12032', 12032, 'abc@1232'),
('acc12033', 12033, 'admin#1233'),
('acc12034', 12034, 'user1234'),
('acc12035', 12035, 'pass#1235'),
('acc12036', 12036, 'pass1236!'),
('acc12037', 12037, 'abc@1237'),
('acc12038', 12038, 'admin#1238'),
('acc12039', 12039, 'user1239'),
('acc12040', 12040, 'pass#1240');


INSERT INTO Cart (CartId, CustomerId, CreatedDate) VALUES
('G0001', 10000, '2024-01-01'),
('G0002', 10001, '2024-01-01'),
('G0003', 10002, '2024-01-01'),
('G0004', 10003, '2024-01-01'),
('G0005', 10004, '2024-01-01'),
('G0006', 10005, '2024-01-02'),
('G0007', 10006, '2024-01-03'),
('G0008', 10007, '2024-01-04'),
('G0009', 10008, '2024-01-05'),
('G0010', 10009, '2024-01-06');
GO


INSERT INTO CartItem (CartId, ProductId, Quantity) VALUES
-- Cart G0001 → Receipt R001
('G0001', 'P001', 2),
('G0001', 'P005', 1),
('G0001', 'P009', 3),
('G0001', 'P013', 2),
('G0001', 'P017', 1),
('G0002', 'P002', 1),
('G0002', 'P006', 2),
('G0002', 'P010', 1),
('G0002', 'P014', 2),
('G0002', 'P018', 1),
('G0002', 'P022', 1),
('G0003', 'P003', 3),
('G0003', 'P007', 2),
('G0003', 'P011', 1),
('G0003', 'P015', 1),
('G0003', 'P019', 2),
('G0004', 'P004', 1),
('G0004', 'P008', 1),
('G0004', 'P012', 2),
('G0004', 'P016', 2),
('G0004', 'P020', 2),
('G0004', 'P024', 1),
('G0005', 'P001', 2),
('G0005', 'P009', 1),
('G0005', 'P018', 2),
('G0005', 'P025', 1),
('G0005', 'P028', 2),
('G0006', 'P002', 1),
('G0006', 'P010', 2),
('G0006', 'P021', 1),
('G0006', 'P026', 2),
('G0006', 'P030', 1),
('G0007', 'P003', 2),
('G0007', 'P011', 1),
('G0007', 'P019', 1),
('G0007', 'P027', 2),
('G0007', 'P029', 1),
('G0008', 'P004', 2),
('G0008', 'P012', 2),
('G0008', 'P020', 1),
('G0008', 'P028', 2),
('G0008', 'P023', 1),
('G0009', 'P005', 1),
('G0009', 'P013', 2),
('G0009', 'P021', 2),
('G0009', 'P025', 1),
('G0009', 'P030', 1),
('G0010', 'P006', 2),
('G0010', 'P014', 2),
('G0010', 'P022', 1),
('G0010', 'P026', 2),
('G0010', 'P029', 2),
('G0010', 'P016', 1);


INSERT INTO ShippingDetail (ShippingId, ReceiptId, EmployeeId, ShippingAddress, ShippingDate, ShippingStatus)
VALUES 
('SH002', 'R002', '100000022', '202 Blue St', '2024-01-01', 'Pending'),
('SH003', 'R005', '100000023', '505 Silver Ln', '2024-01-01', 'Delivered'),
('SH004', 'R008', '100000024', '808 Amber Way', '2024-01-01', 'In Transit');
GO


-- New Views
CREATE VIEW View_Category AS
SELECT * FROM Category;
GO

CREATE VIEW View_Account As
SELECT * FROM Account;
GO

CREATE VIEW View_Cart AS
SELECT * FROM Cart;
GO

CREATE VIEW View_CartItem As
SELECT * FROM CartItem;
GO

CREATE VIEW View_ShippingDetail AS
SELECT * FROM ShippingDetail;
GO


-- Get the name of those customers whose receipt has a delivery purchase, also display the shipping status
CREATE VIEW View_DeliveryReceiptCustomer AS
SELECT s.ShippingID, r.ReceiptId, c.CustomerFName + ' ' + c.CustomerLName AS CustomerName, c.CustomerAddress 
FROM ShippingDetail s 
JOIN Receipt r ON r.ReceiptId = s.ReceiptId
JOIN Customer c ON c.CustomerId = r.CustomerId;
GO

-- Get the ReceiptId, the customer name, email, shipping address, and shipping date
CREATE VIEW View_ShippingCustomerAddress AS
SELECT r.ReceiptId, c.CustomerFName + ' ' + c.CustomerLName AS CustomerFullName, 
c.Email, s.ShippingAddress, s.ShippingDate 
FROM Receipt r 
JOIN Customer c ON r.CustomerId = c.CustomerId 
JOIN ShippingDetail s ON s.ReceiptId = r.ReceiptId;
GO

-- Get the Customer AccountID, Email and Password
CREATE VIEW View_CustomerAccount AS
SELECT a.AccountId, c.Email, a.Password FROM Customer c 
JOIN Account a ON a.CustomerId = c.CustomerId
GO

DROP VIEW View_CustomerAccount
GO
