USE MarketSystem;
GO

-- Trigger: The ReceiptId who created the Receipt must be a Cashier
CREATE TRIGGER trg_ReceiptcreatedbyCashier
ON Receipt
FOR INSERT, UPDATE
AS 
BEGIN
    -- Check if any inserted/updated record violates the rule
    IF EXISTS (SELECT * FROM INSERTED r JOIN Employee e ON e.EmployeeId = r.EmployeeId WHERE EmployeeRole <> 'Cashier')
    BEGIN
        RAISERROR(N'Only employees with the role "Cashier" can create a receipt', 16, 1)
    ROLLBACK TRANSACTION;
    END
END;
GO

ENABLE TRIGGER trg_ReceiptcreatedbyCashier ON Receipt;
GO
-- Try Trigger 
INSERT INTO Receipt (ReceiptId, DateCreated, CustomerId, EmployeeId)
VALUES ('R021', '2024-01-03', 10020, '100000022');
GO

-- Trigger: The EmployeeID in the ShippingDetail must be a Shipper
CREATE TRIGGER trg_ShipperShippingDetail
ON ShippingDetail
FOR INSERT, UPDATE
AS 
BEGIN
    -- Check if any inserted/updated record violates the rule
    IF EXISTS (SELECT * FROM INSERTED r JOIN Employee e ON e.EmployeeId = r.EmployeeId WHERE EmployeeRole <> 'Shipper')
    BEGIN
        RAISERROR(N'Only employees with the role Shipper are allowed', 16, 1)
    ROLLBACK TRANSACTION;
    END
END;
GO

ENABLE TRIGGER trg_ReceiptcreatedbyCashier ON Receipt;
GO

ENABLE TRIGGER trg_ShipperShippingDetail ON ShippingDetail;
GO

-- Try Trigger
INSERT INTO ShippingDetail (ShippingId, ReceiptId, EmployeeId, ShippingAddress, ShippingDate, ShippingStatus)
VALUES 
('SH132', 'R007', '100000027', '707 Bronze Ct', '2024-01-03', 'Pending');
GO


-- Trigger: The CustomerID and Address in ShippingDetail and Customer must match
-- For the ShippingDetail, any mismatch to the Customer raised error
CREATE TRIGGER trg_ShippingDetail
ON ShippingDetail
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED s JOIN Receipt r ON s.ReceiptID = r.ReceiptId
    JOIN Customer c ON c.CustomerId = r.CustomerId WHERE NOT c.CustomerAddress = s.ShippingAddress)
    BEGIN
        RAISERROR('Shipping Address does not match customer address', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO

ENABLE TRIGGER trg_ShippingDetail ON ShippingDetail;
GO

-- Try Trigger
INSERT INTO ShippingDetail (ShippingId, ReceiptId, EmployeeId, ShippingAddress, ShippingDate, ShippingStatus)
VALUES 
('SH005', 'R007', '100000023', '505 Silver Ln', '2024-01-01', 'Pending');
GO

-- Trigger: The ShippingDate and The Receipt Created Date must match
CREATE TRIGGER trg_ShippingwithReceiptDate
ON ShippingDetail
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED s JOIN Receipt r ON s.ReceiptId = r.ReceiptId 
    WHERE NOT r.DateCreated = s.ShippingDate)
    BEGIN
        RAISERROR('Shipping Date does not match Receipt Created Date', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO

ENABLE TRIGGER trg_ShippingwithReceiptDate ON ShippingDetail;
GO

DROP TRIGGER trg_ShippingwithReceiptDate
GO

INSERT INTO ShippingDetail (ShippingId, ReceiptId, EmployeeId, ShippingAddress, ShippingDate, ShippingStatus)
VALUES 
('SH122', 'R009', '100000024', '909 Emerald Pl', '2024-01-01', 'Pending');
GO

INSERT INTO ShippingDetail (ShippingId, ReceiptId, EmployeeId, ShippingAddress, ShippingDate, ShippingStatus)
VALUES 
('SH034', 'R010', '100000025', '111 Garnet St', '2024-01-02', 'Pending');
GO

DROP TRIGGER trg_ShippingwithReceiptDate
GO


-- Trigger: The price cannot be negative
CREATE TRIGGER trg_check_product_price
ON Product
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED WHERE Price < 0)
    BEGIN
        RAISERROR('Price cannot be negative', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO

ENABLE TRIGGER trg_check_product_price ON Product;
GO

DROP TRIGGER trg_check_product_price 
GO

-- Try the Trigger
INSERT INTO Product (ProductId, ProductName, Price, SupplierId, StallNumber) VALUES
('P031', 'Guava', -2.50, 'S002', 1);
GO



-- Trigger: CustomerName and PhoneNumber cannot be blank
CREATE TRIGGER trg_check_customer_info
ON Customer
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT CustomerFName + CustomerLName AS FullName, CustomerPhone FROM INSERTED 
    WHERE CustomerFName IS NULL OR CustomerLName IS NULL OR CustomerPhone IS NULL)
    BEGIN
        RAISERROR(N'Name and Phone Number cannot be empty', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

ENABLE TRIGGER trg_check_customer_info ON Customer;
GO


INSERT INTO Customer (CustomerFName, CustomerLName, CustomerAddress, CustomerPhone) VALUES
('Adam', 'Ray', '101 Green Rd', NULL);
GO

DROP TRIGGER trg_check_customer_info
GO

-- Trigger: Automatically set shipping status to Pending
CREATE TRIGGER trg_set_default_order_status
ON ShippingDetail
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE s SET s.ShippingStatus = 'Pending' FROM ShippingDetail s
    JOIN INSERTED i ON s.ShippingId = i.ShippingId
END;
GO

ENABLE TRIGGER trg_set_default_order_status ON ShippingDetail
GO

INSERT INTO ShippingDetail (ShippingId, ReceiptId, EmployeeId, ShippingAddress, ShippingDate, ShippingStatus)
VALUES 
('SH035', 'R006', '100000038', '606 Gold Dr', '2024-01-02', 'Pending');
GO

INSERT INTO ShippingDetail (ShippingId, ReceiptId, EmployeeId, ShippingAddress, ShippingDate, ShippingStatus)
VALUES 
('SH036', 'R003', '100000038', '303 Red Blvd', '2024-01-01', 'Pend');
GO

-- Testing Query
SELECT * FROM ShippingDetail
GO


-- Trigger: No two Customers have the same emails
CREATE TRIGGER trg_unique_customeremail
ON Customer
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED i JOIN Customer c ON i.Email = c.Email 
    WHERE NOT i.CustomerId = c.CustomerId)
    BEGIN
        RAISERROR(N'Customer Duplicate Email!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Same for Employee
CREATE TRIGGER trg_unique_employeeemail
ON Employee
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED i JOIN Employee e ON i.Email = e.Email 
    WHERE NOT i.EmployeeId = e.EmployeeId)
    BEGIN
        RAISERROR(N'Employee Duplicate Email!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

ENABLE TRIGGER trg_unique_customeremail ON Customer;
GO

ENABLE TRIGGER trg_unique_employeeemail ON Employee;
GO

DROP TRIGGER trg_unique_customeremail
GO

DROP TRIGGER trg_unique_employeeemail
GO

-- Try Trigger
UPDATE Customer SET Email = 'Bea.Stone@user.com'
WHERE CustomerId = '10002';
GO


UPDATE Employee SET Email = 'Alice.Johnson@company.com'
WHERE EmployeeId = '100000002';
GO


-- Trigger: Change the ShippingDate in ShippingDetail when the Receipt Date in Receipt is updated
CREATE TRIGGER trg_update_shippingdate
ON Receipt
AFTER UPDATE
AS
BEGIN
    UPDATE s SET s.ShippingDate = r.DateCreated FROM ShippingDetail s JOIN 
    INSERTED r ON r.ReceiptId = s.ReceiptId
END;
GO

ENABLE TRIGGER trg_update_shippingdate ON Receipt;
GO

-- Try Trigger
UPDATE Receipt SET DateCreated = '2024-01-08' WHERE ReceiptId = 'R009'
