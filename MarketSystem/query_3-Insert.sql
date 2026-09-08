USE MarketSystem

INSERT INTO Supplier (SuppId, SuppName, SuppAddress, SuppPhone) VALUES
('S001', 'Fresh Farm Produce', '123 Greenway Blvd', '12345678'),
('S002', 'Oceanic Suppliers', '456 Coastal Road', '13456789'),
('S003', 'Golden Grains Ltd.', '789 Harvest Street', '14567890'),
('S004', 'Tropical Fruits Co.', '321 Palm Ave', '15678901'),
('S005', 'Dairy Direct', '654 Creamery Ln', '16789012'),
('S006', 'Organic Goods', '987 Wellness Rd', '17890123'),
('S007', 'Farmers First', '147 Countryside Dr', '18901234'),
('S008', 'Herbal Health', '258 Nature Trail', '19876543'),
('S009', 'Mountain Harvest', '369 Alpine Way', '12349876'),
('S010', 'Urban Growers', '741 Metro Market St', '13245768'),
('S011', 'Valley Foods', '852 Valley Rd', '14326789'),
('S012', 'EcoFresh', '963 Eco Park', '15437890'),
('S013', 'Sunshine Produce', '159 Sunrise Dr', '16548901'),
('S014', 'Crisp Veggies', '753 Salad Blvd', '17659012'),
('S015', 'Riverbank Organics', '951 Riverbank Rd', '18760123'),
('S016', 'Berry Best Co.', '357 Berry Ave', '19871234'),
('S017', 'Green Thumb Supply', '258 Garden Way', '11234567'),
('S018', 'FarmSource', '369 Tractor Ln', '12387654'),
('S019', 'Nature’s Basket', '753 Leafy Lane', '13456780'),
('S020', 'Global Agro Ltd.', '159 Harvest Circle', '14567881');


INSERT INTO MarketStall (StallNumber, StallName) VALUES
(1, 'Fresh Fruits Stall'),
(2, 'Organic Vegetables Stall'),
(3, 'Dairy & Eggs Stall'),
(4, 'Herbs & Spices Stall'),
(5, 'Beverages Stall'),
(6, 'Grains & Cereals Stall'),
(7, 'Gourmet Foods Stall'),
(8, 'Seasonal Produce Stall');



INSERT INTO Product (ProductId, ProductName, Price, SupplierId, StallNumber) VALUES
('P001', 'Apple Gala', 2.50, 'S001', 1),
('P002', 'Banana Cavendish', 1.20, 'S002', 2),
('P003', 'Broccoli Crown', 1.80, 'S003', 3),
('P004', 'Carrot Bunch', 1.30, 'S004', 4),
('P005', 'Dragon Fruit', 3.90, 'S005', 5),
('P006', 'Eggplant Purple', 2.00, 'S006', 6),
('P007', 'Fresh Milk 1L', 2.10, 'S007', 7),
('P008', 'Goat Cheese 200g', 4.50, 'S008', 8),
('P009', 'Honeydew Melon', 3.20, 'S009', 1),
('P010', 'Iceberg Lettuce', 1.50, 'S010', 2),
('P011', 'Jackfruit Slices', 2.90, 'S011', 3),
('P012', 'Kale Bunch', 1.70, 'S012', 4),
('P013', 'Lemon Yellow', 0.90, 'S013', 5),
('P014', 'Mango Sweet', 2.40, 'S014', 6),
('P015', 'Nectarine', 2.60, 'S015', 7),
('P016', 'Orange Valencia', 1.80, 'S016', 8),
('P017', 'Papaya Large', 3.30, 'S017', 1),
('P018', 'Quinoa 500g', 5.10, 'S018', 2),
('P019', 'Radish Bunch', 1.40, 'S019', 3),
('P020', 'Spinach Leaves', 1.60, 'S020', 4),
('P021', 'Tomato Cherry', 2.20, 'S001', 5),
('P022', 'Ube Yam', 3.70, 'S002', 6),
('P023', 'Vanilla Bean Pack', 6.00, 'S003', 7),
('P024', 'Watermelon Slice', 2.30, 'S004', 8),
('P025', 'Xigua Melon', 4.10, 'S005', 1),
('P026', 'Yam White', 1.90, 'S006', 2),
('P027', 'Zucchini Green', 2.00, 'S007', 3),
('P028', 'Almond Milk 1L', 3.20, 'S008', 4),
('P029', 'Brown Rice 1kg', 2.70, 'S009', 5),
('P030', 'Coconut Water', 1.90, 'S010', 6);


INSERT INTO Employee (EmployeeId, EmployeeFName, EmployeeLName, EmployeeAddress) VALUES
('100000001', 'Alice', 'Johnson', '123 Maple St'),
('100000002', 'Bob', 'Smith', '456 Oak Rd'),
('100000003', 'Carol', 'Davis', '789 Pine Ln'),
('100000004', 'David', 'Martinez', '321 Birch Ave'),
('100000005', 'Ella', 'Brown', '654 Cedar Blvd'),
('100000006', 'Frank', 'Wilson', '987 Elm St'),
('100000007', 'Grace', 'Taylor', '213 Ash Dr'),
('100000008', 'Henry', 'Lee', '345 Spruce Ct'),
('100000009', 'Ivy', 'Clark', '567 Cherry Pl'),
('100000010', 'Jack', 'Lewis', '789 Willow Way'),
('100000011', 'Karen', 'Young', '124 Plum Rd'),
('100000012', 'Leo', 'Hall', '312 Palm St'),
('100000013', 'Mia', 'King', '432 Forest Dr'),
('100000014', 'Noah', 'Green', '654 Bamboo Blvd'),
('100000015', 'Olivia', 'Wright', '876 Poplar Ln'),
('100000016', 'Paul', 'Scott', '543 Cypress Ave'),
('100000017', 'Quinn', 'Adams', '765 Magnolia St'),
('100000018', 'Ruby', 'Hill', '231 Vine Rd'),
('100000019', 'Sam', 'Nelson', '987 Peach Way'),
('100000020', 'Tina', 'Perez', '321 Walnut Blvd');

INSERT INTO Customer (CustomerFName, CustomerLName, CustomerAddress, CustomerPhone) VALUES
('Adam', 'Ray', '101 Green Rd', '0123456789'),
('Bea', 'Stone', '202 Blue St', '0234567890'),
('Carl', 'Frost', '303 Red Blvd', '0345678901'),
('Dana', 'Moon', '404 White Ave', '0456789012'),
('Evan', 'Pine', '505 Silver Ln', '0567890123'),
('Faith', 'Olsen', '606 Gold Dr', '0678901234'),
('Gabe', 'Knight', '707 Bronze Ct', '0789012345'),
('Holly', 'Fox', '808 Amber Way', '0890123456'),
('Ivan', 'Hart', '909 Emerald Pl', '0901234567'),
('Jade', 'Bell', '111 Garnet St', '0112345678'),
('Kyle', 'Snow', '112 Topaz Ln', '0223456789'),
('Luna', 'Dale', '113 Coral Blvd', '0334567890'),
('Max', 'Reed', '114 Opal Dr', '0445678901'),
('Nina', 'Stone', '115 Ruby St', '0556789012'),
('Omar', 'King', '116 Onyx Ave', '0667890123'),
('Pia', 'Day', '117 Quartz Rd', '0778901234'),
('Quinn', 'Lee', '118 Diamond Ct', '0889012345'),
('Rita', 'Mills', '119 Pearl Way', '0990123456'),
('Sean', 'Drew', '120 Jet Ln', '0101234567'),
('Tara', 'Hope', '121 Moonstone Ave', '0212345678'),
('Uma', 'West', '122 Jade St', '0323456789'),
('Vik', 'Page', '123 Sun Blvd', '0434567890'),
('Wyn', 'Nash', '124 Fire Rd', '0545678901'),
('Xena', 'Cole', '125 Rain Ln', '0656789012'),
('Yuri', 'Gale', '126 Wind Ave', '0767890123'),
('Zane', 'Fox', '127 Snow Dr', '0878901234'),
('Amy', 'Grant', '128 Heat Blvd', '0989012345'),
('Ben', 'Chase', '129 Cold Ln', '0190123456'),
('Cleo', 'Banks', '130 Ice St', '0201234567'),
('Duke', 'Lane', '131 Flame Rd', '0312345678'),
('Elle', 'Brooks', '132 Mist Ave', '0423456789'),
('Finn', 'Norris', '133 Cloud Dr', '0534567890'),
('Gina', 'Short', '134 Fog Ct', '0645678901'),
('Hank', 'Knight', '135 Thunder Ln', '0756789012'),
('Iris', 'Cruz', '136 Storm Rd', '0867890123'),
('Jett', 'Pierce', '137 Breeze Blvd', '0978901234'),
('Kira', 'Voss', '138 Rainfall Ave', '0089012345'),
('Liam', 'Scott', '139 Glacier Ct', '0190123456'),
('Mara', 'Knight', '140 Aurora Blvd', '0301234567'),
('Nico', 'Blake', '141 Solar Ln', '0412345678');


INSERT INTO Receipt (ReceiptId, DateCreated, CustomerId, EmployeeId)
VALUES
('R001', '2024-01-01', 10000, '100000001'),
('R002', '2024-01-01', 10001, '100000002'),
('R003', '2024-01-01', 10002, '100000003'),
('R004', '2024-01-01', 10003, '100000004'),
('R005', '2024-01-01', 10004, '100000005'),
('R006', '2024-01-02', 10005, '100000006'),
('R007', '2024-01-03', 10006, '100000007'),
('R008', '2024-01-04', 10007, '100000008'),
('R009', '2024-01-05', 10008, '100000009'),
('R010', '2024-01-06', 10009, '100000010');

INSERT INTO ReceipthasProduct (ReceiptId, ProductId, Quantity)
VALUES
-- Receipt R001
('R001', 'P001', 2),
('R001', 'P005', 1),
('R001', 'P009', 3),
('R001', 'P013', 2),
('R001', 'P017', 1),

-- Receipt R002
('R002', 'P002', 1),
('R002', 'P006', 2),
('R002', 'P010', 1),
('R002', 'P014', 2),
('R002', 'P018', 1),
('R002', 'P022', 1),

-- Receipt R003
('R003', 'P003', 3),
('R003', 'P007', 2),
('R003', 'P011', 1),
('R003', 'P015', 1),
('R003', 'P019', 2),

-- Receipt R004
('R004', 'P004', 1),
('R004', 'P008', 1),
('R004', 'P012', 2),
('R004', 'P016', 2),
('R004', 'P020', 2),
('R004', 'P024', 1),

-- Receipt R005
('R005', 'P001', 2),
('R005', 'P009', 1),
('R005', 'P018', 2),
('R005', 'P025', 1),
('R005', 'P028', 2),

-- Receipt R006
('R006', 'P002', 1),
('R006', 'P010', 2),
('R006', 'P021', 1),
('R006', 'P026', 2),
('R006', 'P030', 1),

-- Receipt R007
('R007', 'P003', 2),
('R007', 'P011', 1),
('R007', 'P019', 1),
('R007', 'P027', 2),
('R007', 'P029', 1),

-- Receipt R008
('R008', 'P004', 2),
('R008', 'P012', 2),
('R008', 'P020', 1),
('R008', 'P028', 2),
('R008', 'P023', 1),

-- Receipt R009
('R009', 'P005', 1),
('R009', 'P013', 2),
('R009', 'P021', 2),
('R009', 'P025', 1),
('R009', 'P030', 1),

-- Receipt R010
('R010', 'P006', 2),
('R010', 'P014', 2),
('R010', 'P022', 1),
('R010', 'P026', 2),
('R010', 'P029', 2),
('R010', 'P016', 1);
