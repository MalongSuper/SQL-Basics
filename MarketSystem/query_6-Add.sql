-- ALter table Employee to add Role Receptionist, Delivery Person

USE MarketSystem;
GO

-- Specify Employee Role
ALTER TABLE Employee
ADD EmployeeRole VARCHAR(7) NOT NULL,
    CONSTRAINT df_EmployeeRole DEFAULT 'Cashier' FOR EmployeeRole,
    CONSTRAINT chk_EmployeeRole CHECK(EmployeeRole IN ('Cashier', 'Shipper', 'Manager'));
GO


-- Add Shipper
INSERT INTO Employee (EmployeeId, EmployeeFName, EmployeeLName, EmployeeAddress, EmployeeRole)
VALUES 
('100000021', 'John', 'Smith', '123 Elm Street', 'Shipper'),
('100000022', 'Emily', 'Davis', '456 Oak Avenue', 'Shipper'),
('100000023', 'Michael', 'Johnson', '789 Pine Road', 'Shipper'),
('100000024', 'Sarah', 'Lee', '321 Maple Blvd', 'Shipper'),
('100000025', 'David', 'Brown', '654 Cedar Lane', 'Shipper'),
('100000026', 'Anna', 'Miller', '987 Birch Way', 'Shipper'),
('100000027', 'James', 'Wilson', '147 Spruce Ct', 'Shipper'),
('100000028', 'Laura', 'Taylor', '258 Redwood Dr', 'Shipper'),
('100000029', 'Robert', 'Anderson', '369 Fir St', 'Shipper'),
('100000030', 'Olivia', 'Thomas', '753 Aspen Loop', 'Shipper');


-- Add Manager
INSERT INTO Employee (EmployeeId, EmployeeFName, EmployeeLName, EmployeeAddress, EmployeeRole)
VALUES 
('110000011', 'Karen', 'White', '111 Executive Blvd', 'Manager'),
('110000012', 'Steven', 'Clark', '222 Leadership Ln', 'Manager'),
('110000013', 'Nancy', 'Hall', '333 Strategy St', 'Manager'),
('110000014', 'Patrick', 'Lewis', '444 Vision Ave', 'Manager'),
('110000015', 'Linda', 'Young', '555 Innovation Dr', 'Manager'),
('110000016', 'Christopher', 'King', '666 Growth Ct', 'Manager'),
('110000017', 'Barbara', 'Scott', '777 Enterprise Rd', 'Manager'),
('110000018', 'Thomas', 'Green', '888 Momentum Way', 'Manager');


ALTER TABLE MarketStall
ADD StallManager VARCHAR(9),
    CONSTRAINT df_StallManager DEFAULT NULL FOR StallManager,
    CONSTRAINT fk_StallManager FOREIGN KEY (StallManager) REFERENCES Employee(EmployeeId);
GO

UPDATE MarketStall SET StallManager = '110000011' WHERE StallNumber = 1;
UPDATE MarketStall SET StallManager = '110000012' WHERE StallNumber = 2;
UPDATE MarketStall SET StallManager = '110000013' WHERE StallNumber = 3;
UPDATE MarketStall SET StallManager = '110000014' WHERE StallNumber = 4;
UPDATE MarketStall SET StallManager = '110000015' WHERE StallNumber = 5;
UPDATE MarketStall SET StallManager = '110000016' WHERE StallNumber = 6;
UPDATE MarketStall SET StallManager = '110000017' WHERE StallNumber = 7;
UPDATE MarketStall SET StallManager = '110000018' WHERE StallNumber = 8;


ALTER TABLE Receipt
ADD ReceiptStatus VARCHAR(50) NOT NULL,
    CONSTRAINT df_ReceiptStatus DEFAULT 'In-Store Purchase' FOR ReceiptStatus,
    CONSTRAINT chk_ReceiptStatus CHECK(ReceiptStatus IN ('Unknown', 'In-Store Purchase', 'Delivery Purchase'));
GO

UPDATE Receipt SET ReceiptStatus = 'In-Store Purchase' WHERE ReceiptId = 'R001';
UPDATE Receipt SET ReceiptStatus = 'Delivery Purchase' WHERE ReceiptId = 'R002';
UPDATE Receipt SET ReceiptStatus = 'In-Store Purchase' WHERE ReceiptId = 'R003';
UPDATE Receipt SET ReceiptStatus = 'In-Store Purchase' WHERE ReceiptId = 'R004';
UPDATE Receipt SET ReceiptStatus = 'Delivery Purchase' WHERE ReceiptId = 'R005';
UPDATE Receipt SET ReceiptStatus = 'In-Store Purchase' WHERE ReceiptId = 'R006';
UPDATE Receipt SET ReceiptStatus = 'In-Store Purchase' WHERE ReceiptId = 'R007';
UPDATE Receipt SET ReceiptStatus = 'Delivery Purchase' WHERE ReceiptId = 'R008';
UPDATE Receipt SET ReceiptStatus = 'In-Store Purchase' WHERE ReceiptId = 'R009';
UPDATE Receipt SET ReceiptStatus = 'Unknown' WHERE ReceiptId = 'R010';
GO

