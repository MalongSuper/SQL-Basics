USE Company;
GO

-- 1. Create trigger trg_check_lblank to trim leading spaces from employee FName and LName during inserts or updates.

--SQL1
CREATE TRIGGER trg_check_lblank
ON Employee
FOR INSERT, UPDATE
AS
BEGIN
    UPDATE Employee SET FName = LTRIM(FName) WHERE FName IN (SELECT FName FROM INSERTED) AND FName LIKE ' %'
    UPDATE Employee SET LName = LTRIM(LName) WHERE LName IN (SELECT LName FROM INSERTED) AND LName LIKE ' %'
END;
GO




-- Insert null FName/LName or update names with leading spaces to verify the trigger.

--SQL1
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES (' John', 'B', ' Dean', '123456797', '1955-01-11', 'Houston, TX', 'M', 31000);
GO

-- 2. Create trigger trg_check_number to validate SSN and Super_SSN on employee inserts or updates.
-- Each value must contain exactly nine digits. Invalid input must be rejected.
-- Display a message instructing the user to enter the value in the format 111111111.
CREATE TRIGGER trg_check_number
ON Employee
INSTEAD OF INSERT, UPDATE
AS
IF EXISTS (SELECT SSN FROM Employee WHERE SSN IN (SELECT SSN FROM INSERTED) 
AND SSN NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
        RAISERROR('Invalid SSN, must be 9-digit long, e.g., 111111111', 16, 1)
        ROLLBACK TRANSACTION
    END
ELSE
    IF EXISTS (SELECT Super_SSN FROM Employee WHERE Super_SSN IN (SELECT Super_SSN FROM INSERTED) 
    AND Super_SSN NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    BEGIN
        RAISERROR('Invalid Super_SSN, must be 9-digit long, e.g., 111111111', 16, 1)
        ROLLBACK TRANSACTION
    END 
GO
--SQL1
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('John', 'D', ' Roose', '123456733ee', '1955-07-21', 'Houston, TX', 'M', 31000);
GO

-- Execution - verification result

-- 3. Create trigger trg_NoDel_Dept to prevent deletion from the Department table.
-- When a delete is attempted, display 'Deletion of Department is not allowed'
-- and restore the original state as if nothing had been deleted.
-- Instead of: Override the Trigger error before checking constraint
CREATE TRIGGER trg_NoDel_Dept
ON Department
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Deletion of Department is not allowed', 16, 1)
    ROLLBACK TRANSACTION
END;
GO

--SQL1
DELETE FROM Department WHERE Dnumber = 5
GO
-- Execution - verification result

-- 4. Create trigger trg_NoUpdateName_Dept to prevent department names from being changed.

-- Hint:
-- a. Create a Temp table with the same structure as Department.

-- CREATE TABLE Temp
-- (
--     [DName] varchar(15),
--     [DNumber] numeric(4,0),
--     [Mgrssn] char(9),
--     [MgrStartdate] datetime
-- )

-- b. Then create an INSTEAD OF UPDATE trigger that inserts data into this Temp table.

--SQL1

-- Execution - verification result

-- 5. Assume Student A created a database named mysales with the tbl_product and tbl_order tables below.

--SQL1
create database mysales
use mysales
CREATE TABLE tbl_product
(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	productID varchar(15) NOT NULL UNIQUE,
	productName NVARCHAR(200) NOT NULL UNIQUE,
	productQTY DECIMAL(6,2),
	productPrice DECIMAL(10,2) NOT NULL,
	lineTotal DECIMAL(18,2),
	productDate DATETIME NOT NULL
)
CREATE TABLE tbl_order
(
	orderID INT NOT NULL,
	productID varchar(15) NOT NULL,
	orderQty DECIMAL(6,2),
	productName NVARCHAR(100),
	TOTAL DECIMAL(18,2),
	orderDate DATETIME DEFAULT GETDATE(),
	CONSTRAINT PK_tbl_Order_OrderID_productID PRIMARY KEY(orderID,productID), 
	CONSTRAINT FK_tbl_Order_productID FOREIGN KEY(productID) REFERENCES tbl_product(productID)
)
GO

-- Requirements:
-- a. Create a trigger that automatically calculates lineTotal = productQTY * productPrice whenever tbl_product is inserted or updated.
CREATE TRIGGER trg_LineTotal
ON tbl_product
FOR INSERT, UPDATE
AS
BEGIN
    UPDATE tbl_product SET lineTotal = productQTY * productPrice
END;
GO

--SQL1
-- --- part a
INSERT INTo 

-- b. Create a trigger that automatically decreases productQTY in tbl_product whenever data is inserted into tbl_order,
-- grouped by productID.

--SQL1
-- --- part b

-- c. Create a trigger that automatically updates productQTY in tbl_product whenever tbl_order is updated,
-- grouped by productID.

--SQL1
-- --- part c

-- 6. Disable the trigger created in question 1.

--SQL1
DISABLE TRIGGER trg_check_lblank ON Employee;
GO

DISABLE TRIGGER trg_NoDel_Dept ON Department;
GO

DISABLE TRIGGER trg_check_number ON Employee;
GO

-- 7. Enable the trigger created in question 1.

--SQL1
ENABLE TRIGGER trg_check_lblank ON Employee;
GO

ENABLE TRIGGER trg_NoDel_Dept ON Department;
GO

ENABLE TRIGGER trg_check_number ON Employee;
GO
-- 8. Drop the trigger created in question 1.
--SQL1
DROP TRIGGER trg_check_lblank
GO

DROP TRIGGER trg_NoDel_Dept
GO

DROP TRIGGER trg_check_number
GO