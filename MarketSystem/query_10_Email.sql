-- Add Email
USE MarketSystem;
GO

ALTER TABLE Customer 
ADD Email VARCHAR(100) NOT NULL,
    CONSTRAINT chk_CustomerEmail DEFAULT 'unknown@company.com' FOR Email
GO


ALTER TABLE Employee 
ADD Email VARCHAR(100) NOT NULL,
    CONSTRAINT chk_EmployeeEmail DEFAULT 'unknown@company.com' FOR Email
GO


-- Update Employee Email taking their first name and last name
UPDATE Employee
SET Email = EmployeeFName + '.' + EmployeeLName + '@company.com'
WHERE EmployeeId IN (SELECT EmployeeId FROM Employee);
GO
 
-- Update Customer Email taking their first name and last name
UPDATE Customer
SET Email = CustomerFName + '.' + CustomerLName + '@user.com'
WHERE CustomerId IN (SELECT CustomerId FROM Customer);
GO

-- New View, retrieve customer and their email
CREATE VIEW View_CustomerEmail AS
SELECT CustomerId, CustomerFName + ' ' + CustomerLName AS FullName, Email FROM Customer
GO


-- New View, retrieve Employee and their email
CREATE VIEW View_EmployeeEmail AS
SELECT EmployeeId, EmployeeFName + ' ' + EmployeeLName AS FullName, Email FROM Employee
GO


DROP VIEW View_CustomerEmail
DROP VIEW View_EmployeeEmail
GO
