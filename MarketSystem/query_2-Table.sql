USE MarketSystem

CREATE TABLE Supplier (
  SuppId VARCHAR(4) NOT NULL,
  SuppName VARCHAR(50) NOT NULL,
  SuppAddress VARCHAR(100) NULL,
  SuppPhone VARCHAR(8) NULL
);
GO

CREATE TABLE Product (
  ProductId VARCHAR(4) NOT NULL,
  ProductName VARCHAR(50) NOT NULL,
  Price NUMERIC(10, 2) NOT NULL
);
GO

CREATE TABLE MarketStall (
  StallNumber TINYINT NOT NULL,
  StallName VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Receipt (
  ReceiptId VARCHAR(4) NOT NULL,
  DateCreated DATE NULL
);
GO

CREATE TABLE Employee (
  EmployeeId VARCHAR(9) NOT NULL,
  EmployeeFName VARCHAR(50) NOT NULL,
  EmployeeLName VARCHAR(50) NOT NULL,
  EmployeeAddress VARCHAR(100) NULL
);
GO

CREATE TABLE Customer (
  CustomerId INT IDENTITY(10000, 1) NOT NULL,
  CustomerFName VARCHAR(50) NOT NULL,
  CustomerLName VARCHAR(50) NOT NULL,
  CustomerAddress VARCHAR(100) NULL,
  CustomerPhone VARCHAR(10) NOT NULL
);
GO

CREATE TABLE ReceipthasProduct (
  Quantity TINYINT NOT NULL
);
GO
 
-- ALTER TABLE 
ALTER TABLE Supplier 
ADD CONSTRAINT pk_SuppId PRIMARY KEY (SuppId),
	CONSTRAINT chk_SuppId CHECK (SuppId LIKE 'S[0-9][0-9][0-9]'),
    CONSTRAINT chk_SuppPhone CHECK (SuppPhone LIKE '1[0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), 
    CONSTRAINT uq_SuppName UNIQUE (SuppName);
GO

ALTER TABLE Product
ADD SupplierId VARCHAR(4) NOT NULL,
	StallNumber TINYINT NOT NULL,
	CONSTRAINT pk_ProductId PRIMARY KEY (ProductId),
    CONSTRAINT chk_ProductId CHECK (ProductId LIKE 'P[0-9][0-9][0-9]'),
    CONSTRAINT chk_Price CHECK (Price > 0),
    CONSTRAINT uq_ProductName UNIQUE (ProductName),
    CONSTRAINT fk_SupplierId FOREIGN KEY (SupplierId) REFERENCES Supplier(SuppId),
    CONSTRAINT fk_StallNumber FOREIGN KEY (StallNumber) REFERENCES MarketStall(StallNumber);
GO

ALTER TABLE MarketStall
ADD CONSTRAINT pk_StallNumber PRIMARY KEY (StallNumber),
	CONSTRAINT chk_StallNumber CHECK (StallNumber > 0), 
    CONSTRAINT uq_StallName UNIQUE (StallName);
GO

ALTER TABLE Receipt
ADD CustomerId INT NOT NULL,
	EmployeeId VARCHAR(9) NOT NULL,
	CONSTRAINT pk_ReceiptId PRIMARY KEY (ReceiptId),
	CONSTRAINT chk_ReceiptId CHECK (ReceiptId LIKE 'R[0-9][0-9][0-9]'), 
    CONSTRAINT df_DateCreated DEFAULT GETDATE() FOR DateCreated,
    CONSTRAINT fk_Customer FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId),
    CONSTRAINT fk_Employee FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId);
GO

ALTER TABLE Employee
ADD CONSTRAINT pk_EmployeeId PRIMARY KEY (EmployeeId),
	CONSTRAINT chk_EmployeeId CHECK (EmployeeId LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
GO

ALTER TABLE Customer
ADD CONSTRAINT pk_CustomerId PRIMARY KEY (CustomerId),
	CONSTRAINT chk_CustomerPhone CHECK (CustomerPhone LIKE '0[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');
GO

ALTER TABLE ReceipthasProduct
ADD ReceiptId VARCHAR(4) NOT NULL,
	ProductId VARCHAR(4) NOT NULL,
	CONSTRAINT pk_ReceiptId_ProductId PRIMARY KEY (ReceiptId, ProductId),
    CONSTRAINT chk_Quantity CHECK (Quantity > 0),
    CONSTRAINT df_Quantity DEFAULT 1 FOR Quantity,
    CONSTRAINT fk_ReceiptId FOREIGN KEY (ReceiptId) REFERENCES Receipt(ReceiptId),
    CONSTRAINT fk_ProductId FOREIGN KEY (ProductId) REFERENCES Product(ProductId);
GO

