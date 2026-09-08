USE MarketSytem;
GO
-- Make sure to drop and recreate the view in case a new column is added

-- Create Procedure that returns the Employee with a certain role
CREATE PROCEDURE SelectEmployeeRole
@EmployeeRole VARCHAR(7)
AS
BEGIN 
    SELECT * FROM Employee WHERE EmployeeRole = @EmployeeRole
END;
GO

EXEC SelectEmployeeRole @EmployeeRole = 'Cashier'
EXEC SelectEmployeeRole @EmployeeRole = 'Shipper'
EXEC SelectEmployeeRole @EmployeeRole = 'Manager'
GO

-- Create Procedure that creates a new Employee and assign their role
CREATE PROCEDURE InsertEmployee
@EmployeeId VARCHAR(9), 
@EmployeeFName VARCHAR(50), 
@EmployeeLName VARCHAR(50), 
@EmployeeAddress VARCHAR(100),
@EmployeeRole VARCHAR(7)
AS
BEGIN TRY -- Used for Insert Into
    INSERT INTO Employee (EmployeeId, EmployeeFName, EmployeeLName, EmployeeAddress, EmployeeRole) 
    VALUES (@EmployeeId, @EmployeeFName, @EmployeeLName, @EmployeeAddress, @EmployeeRole)
END TRY
BEGIN CATCH
    PRINT 'Insert Employee Failed.'
    PRINT ERROR_MESSAGE()  -- Reason for Fail
END CATCH;
GO

EXEC InsertEmployee 
  @EmployeeId = '100000036', 
  @EmployeeFName = 'Alice', 
  @EmployeeLName = 'Nguyen', 
  @EmployeeAddress = '123 Main St', 
  @EmployeeRole = 'Cashier'
GO

EXEC InsertEmployee 
  @EmployeeId = '100000038', 
  @EmployeeFName = 'Bob', 
  @EmployeeLName = 'Tran', 
  @EmployeeAddress = '456 Oak Ave', 
  @EmployeeRole = 'Shipper'
GO


-- Create Procedure that classifies the Product into Level A, B, C, or D
-- Level A if < 1.00; Level B if 1.00 to < 2.50, Level C if 2.50 to < 4.00, Level D if > 4.00
-- Then sort the table based on Product Level
ALTER TABLE Product 
ADD ProductLevel VARCHAR(10),
    CONSTRAINT chk_ProductLevel CHECK (ProductLevel LIKE 'Tier_[ABCD]');
GO


UPDATE Product SET ProductLevel = 
CASE WHEN Price >= 4.00 THEN 'Tier_D' 
    WHEN (Price >= 2.50 AND Price < 4.00) THEN 'Tier_C'
    WHEN (Price >= 1.00 AND Price < 2.50) THEN 'Tier_B'
    WHEN (Price < 1.00) THEN 'Tier_A'
    END;
GO


CREATE PROCEDURE SortByProductLevel
AS 
BEGIN
    SELECT ProductId, ProductName, Price, SupplierId, StallNumber, ProductLevel, CategoryId
    FROM Product ORDER BY RIGHT(ProductLevel, 1);
END;
GO

EXEC SortByProductLevel
GO

-- Optional: Get Product Level with IF ELSE
CREATE PROCEDURE GetProductLevel
@ProductId VARCHAR(4),
@ProductLevel VARCHAR(10) OUTPUT
AS
BEGIN 
    IF EXISTS (SELECT ProductLevel FROM Product WHERE ProductId = @ProductId)
        BEGIN
        SELECT @ProductLevel = ProductLevel FROM Product WHERE @ProductId = ProductId
        END 
    ELSE
        PRINT @ProductId + ' ' + 'does not exist'
END;
GO

-- 'SET': Assign a value to a variable so that it can be can be used as an input or returned as an output
-- 'DECLARE' is used to define variables, making us know that this value is used in the EXEC, it must be aligned with the Procedure
DECLARE @ProductLevel VARCHAR(10), @ProductId VARCHAR(4)
SET @ProductId = 'P016' 
EXEC GetProductLevel @ProductId = @ProductId, @ProductLevel = @ProductLevel OUTPUT
    PRINT @ProductId
    PRINT @ProductLevel
GO

-- The Whole Supplier is High Quality if the number of Tier_C or Tier_D Product is the highest
-- Else, it is considered Normal Quality
CREATE PROCEDURE SupplierQuality
AS
BEGIN
    -- Declare a table to store top tier result
    -- Syntax DECLARE @TABLEVARIABLE TABLE(column1 datatype, column2 datatype, columnN datatype)
    DECLARE @TopTiers TABLE (ProductLevel VARCHAR(10))
    -- Get the Tier with the highest number of products
    -- Insert Into SELECT to create a table with the query call
    INSERT INTO @TopTiers (ProductLevel) 
    SELECT TOP 1 WITH TIES p.ProductLevel FROM Supplier s JOIN Product p ON s.SuppId = p.SupplierId 
    GROUP BY p.ProductLevel ORDER BY COUNT(p.ProductLevel) DESC;

    IF EXISTS (SELECT ProductLevel FROM @TopTiers WHERE ProductLevel IN ('Tier_C', 'Tier_D'))
        PRINT 'High Quality'
    ELSE 
        PRINT 'Normal Quality'
END;
GO

EXEC SupplierQuality;
GO

-- Create Procedure that takes the MarketStall ID, and return the Stall Manager Name
CREATE PROCEDURE MarketStallManager
@StallNumber TINYINT,
@StallManagerName VARCHAR(100) OUTPUT
AS 
BEGIN
    IF EXISTS (SELECT * FROM MarketStall m JOIN Employee e ON e.EmployeeId = m.StallManager 
    WHERE m.StallNumber = @StallNumber)
        SELECT @StallManagerName = e.EmployeeFName + ' ' + '' + e.EmployeeLName 
        FROM MarketStall m JOIN Employee e ON e.EmployeeId = m.StallManager 
        WHERE m.StallNumber = @StallNumber
    ELSE
        PRINT 'Manager Name not found for Stall Number' + ' ' + @StallNumber
END
GO

-- Create a Procedure to execute the MarketStallManager Procedure
CREATE PROCEDURE Exec_MarketStallManager
@StallNumber TINYINT
AS
BEGIN
    DECLARE @StallManagerName VARCHAR(100)
    SET @StallNumber = @StallNumber -- Use Set to print an input
    EXEC MarketStallManager @StallNumber = @StallNumber, @StallManagerName = @StallManagerName OUTPUT
    PRINT 'Stall Number:' + ' ' + CONVERT(VARCHAR, @StallNumber)
    PRINT 'Manager:' + ' ' + CONVERT(VARCHAR, @StallManagerName)
END;
GO

EXEC Exec_MarketStallManager @StallNumber = 1
EXEC Exec_MarketStallManager @StallNumber = 2
GO


-- Create Procedure that calculates the total price of the input receipt
CREATE PROCEDURE TotalPrice
@Receipt VARCHAR(4),
@TotalPrice NUMERIC(10, 2) OUTPUT
AS
BEGIN 
    SELECT @TotalPrice = SUM(rp.Quantity * p.Price) FROM ReceipthasProduct rp 
    JOIN Product p ON p.ProductId = rp.ProductId WHERE @Receipt = rp.ReceiptId
    GROUP BY rp.ReceiptId
END;
GO

DECLARE @Receipt VARCHAR(4), @TotalPrice NUMERIC(10, 2)
SET @Receipt = 'R002'
EXEC TotalPrice @Receipt = @Receipt, @TotalPrice = @TotalPrice OUTPUT
    PRINT 'Receipt:' + ' ' + CONVERT(VARCHAR, @Receipt)
    PRINT 'Total Price:' + ' ' + CONVERT(VARCHAR, @TotalPrice)
GO

DECLARE @Receipt VARCHAR(4), @TotalPrice NUMERIC(10, 2)
SET @Receipt = 'R004'
EXEC TotalPrice @Receipt = @Receipt, @TotalPrice = @TotalPrice OUTPUT
    PRINT 'Receipt:' + ' ' + CONVERT(VARCHAR, @Receipt)
    PRINT 'Total Price:' + ' ' + CONVERT(VARCHAR, @TotalPrice)
GO

DECLARE @Receipt VARCHAR(4), @TotalPrice NUMERIC(10, 2)
SET @Receipt = 'R008'
EXEC TotalPrice @Receipt = @Receipt, @TotalPrice = @TotalPrice OUTPUT
    PRINT 'Receipt:' + ' ' + CONVERT(VARCHAR, @Receipt)
    PRINT 'Total Price:' + ' ' + CONVERT(VARCHAR, @TotalPrice)
GO


-- Create Procedure that calculates the total price of every receipt with Cursor
CREATE PROCEDURE AllTotalPrice
AS
BEGIN 
    DECLARE @Receipt VARCHAR(4)
    DECLARE @TotalPrice NUMERIC(10, 2)
    -- Declare Cursor
    DECLARE PriceCursor CURSOR FOR (SELECT DISTINCT ReceiptId FROM Receipt)
    OPEN PriceCursor
    FETCH NEXT FROM PriceCursor INTO @Receipt
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Receipt:' + ' ' + CONVERT(VARCHAR, @Receipt)
        SELECT @TotalPrice = SUM(rp.Quantity * p.Price) FROM ReceipthasProduct rp 
        JOIN Product p ON p.ProductId = rp.ProductId WHERE rp.ReceiptId = @Receipt 
        GROUP BY rp.ReceiptId
        PRINT 'Total Price:' + ' ' + CONVERT(VARCHAR, @TotalPrice)
        FETCH NEXT FROM PriceCursor INTO @Receipt
    END

    CLOSE PriceCursor
    DEALLOCATE PriceCursor
END;
GO

EXEC AllTotalPrice
GO

-- Procedure that updates the shipping status for a specific shipping ID
CREATE PROCEDURE UpdateShippingStatus
@ShippingId VARCHAR(5),
@NewStatus VARCHAR(20)
AS
BEGIN
    UPDATE ShippingDetail
    SET ShippingStatus = @NewStatus
    WHERE ShippingId = @ShippingId
END;

EXEC UpdateShippingStatus @ShippingId = 'SH002', @NewStatus = 'Delivered';
GO


--Lists all products in a given category.
CREATE PROCEDURE ListProductsByCategory
@CategoryId VARCHAR(4)
AS
BEGIN
    SELECT ProductId, ProductName, Price, ProductLevel
    FROM Product
    WHERE CategoryId = @CategoryId
    ORDER BY ProductName
END;
GO
    

EXEC ListProductsByCategory @CategoryId = 'C001';
GO


--Returns customer info based on their phone number.
CREATE PROCEDURE GetCustomerByPhone
@CustomerPhone VARCHAR(10)
AS
BEGIN
    SELECT CustomerId, CustomerFName, CustomerLName, CustomerAddress
    FROM Customer
    WHERE CustomerPhone = @CustomerPhone
END;

EXEC GetCustomerByPhone @CustomerPhone = '0123456789';


-- In case the Procedure raises error
DROP PROCEDURE SelectEmployeeRole
DROP PROCEDURE InsertEmployee
DROP PROCEDURE SortByProductLevel
DROP PROCEDURE GetProductLevel
DROP PROCEDURE MarketStallManager
DROP PROCEDURE Exec_MarketStallManager
DROP PROCEDURE TotalPrice
DROP PROCEDURE AllTotalPrice
GO
