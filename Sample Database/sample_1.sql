-- INIT database
CREATE TABLE Employees (
  EmployeeID INT IDENTITY(100001, 1) PRIMARY KEY,
  EmployeeName VARCHAR(50) NOT NULL,
  Password VARBINARY(64) NOT NULL
);

CREATE TABLE Purchase (
  PurchaseID VARCHAR(7) PRIMARY KEY,
  PurchaseTime DATE NOT NULL,
  Employee INT NOT NULL,
  ProductPurchased VARCHAR(100) NOT NULL,
  ProductQuantity INT NOT NULL,
  CONSTRAINT chk_PurchaseID_format CHECK(PurchaseID LIKE '[0][0-9][0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Product (
  ProductID VARCHAR(7) PRIMARY KEY,
  ProductName VARCHAR(50) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL, 
  Quantity INT NOT NULL,
  CONSTRAINT chk_ProductID_format CHECK(ProductID LIKE '[1][0-9][0-9][0-9][0-9][0-9][0-9]')
);

-- Employee Table
INSERT INTO Employees(EmployeeName, Password) VALUES ('Adam Joe',  HASHBYTES('SHA2_256', 'JoeA24'));
INSERT INTO Employees(EmployeeName, Password) VALUES ('Ben Noe', HASHBYTES('SHA2_256', 'Ben124'));
  
-- Purchase Order
INSERT INTO Purchase(PurchaseID, PurchaseTime, Employee, ProductPurchased, ProductQuantity) VALUES ('0182917', '2025-03-22', 100001, '1264566', 4);

-- Product Table
INSERT INTO Product(ProductID, ProductName, Price, Quantity) VALUES ('1264566', 'Pringles', 4.99, 12);
INSERT INTO Product(ProductID, ProductName, Price, Quantity) VALUES ('1264567', 'Oreo', 2.99, 13);
INSERT INTO Product(ProductID, ProductName, Price, Quantity) VALUES ('1264568', 'Frozen Pizza', 10.99, 11);
INSERT INTO Product(ProductID, ProductName, Price, Quantity) VALUES ('1264569', 'Potato Snack', 1.99, 15);

-- QUERY database
SELECT * FROM Employees
SELECT * FROM Product
SELECT PurchaseID, PurchaseTime, e.EmployeeName AS Employee, p.ProductName AS ProductPurchased, ProductQuantity, 
p.Price * ProductQuantity AS TotalPrice FROM Purchase pr 
JOIN Product p ON pr.ProductPurchased = p.ProductID
JOIN Employees e ON pr.Employee = e.EmployeeID