USE MarketSystem;
GO

-- Remove the sa by creating a new login
CREATE LOGIN super_admin WITH PASSWORD = 'admin123!'
GO

-- Grant this new login the sysadmin role
ALTER SERVER ROLE sysadmin ADD MEMBER super_admin
GO

-- Default Database MarketSystem
ALTER LOGIN super_admin WITH DEFAULT_DATABASE = MarketSystem
GO

ALTER LOGIN sa WITH NAME = old_sa;
GO

-- Create three new server logins
CREATE LOGIN customer_login WITH PASSWORD = 'Customer@123'
GO

CREATE LOGIN employee_login WITH PASSWORD = 'Employee@123'
GO

CREATE LOGIN manager_login WITH PASSWORD = 'Manager@123'
GO

-- Create User
CREATE USER customer_user FOR LOGIN customer_login
GO

CREATE USER employee_user FOR LOGIN employee_login
GO

CREATE USER manager_user FOR LOGIN manager_login
GO

-- Create Roles
CREATE ROLE customer_role;
GO

CREATE ROLE employee_role;
GO

CREATE ROLE manager_role;
GO

-- New roles HR_Staff
CREATE LOGIN HR_login WITH PASSWORD = 'HumanResource@123'
GO

CREATE USER HR_user FOR LOGIN HR_login
GO

CREATE ROLE HR_staff;
GO


-- Add users to roles with EXEC
EXEC sp_addrolemember 'employee_role', employee_user;
EXEC sp_addrolemember 'manager_role', manager_user;
EXEC sp_addrolemember 'customer_role', customer_user;
EXEC sp_addrolemember 'HR_staff', HR_user;
GO

-- Security: GRANT, REVOKE, and DENY
-- Employee Role: Can Read and Update Products
GRANT SELECT, UPDATE ON dbo.Product TO employee_role;
GO

GRANT SELECT ON dbo.Employee TO employee_role;
GO

GRANT SELECT ON dbo.Employee TO manager_role;
GO

-- Manager Role: Full access to the product
GRANT INSERT, SELECT, UPDATE, DELETE ON dbo.Product TO manager_role;
GO

GRANT SELECT ON dbo.Customer TO customer_role;
GO



-- Customer Role: Can only see their own data

CREATE PROCEDURE ClearAllSessionContext
AS
BEGIN
    EXEC sp_set_session_context @Key = 'employee_id', @Value = NULL, @Read_only = 0;
    EXEC sp_set_session_context @Key = 'customer_id', @Value = NULL, @Read_only = 0;
    EXEC sp_set_session_context @Key = 'manager_id', @Value = NULL, @Read_only = 0;
END;
GO

CREATE PROCEDURE CustomerSessionContext
@CustomerId INT
AS
BEGIN
    EXEC ClearAllSessionContext;
    DECLARE @CustomerName VARCHAR(100)
    IF EXISTS(SELECT * FROM Customer WHERE CustomerId = @CustomerId)
        BEGIN
        SET @CustomerName = (SELECT CustomerFName + ' ' + CustomerLName FROM Customer WHERE CustomerId = @CustomerId)
        EXEC sp_set_session_context @Key = 'customer_id', @Value = @CustomerId, @Read_only = 0;
        PRINT 'Welcome Back' + ' ' + CONVERT(VARCHAR, @CustomerName)
        END
    ELSE
        PRINT 'Customer with ID' + ' ' + CONVERT(VARCHAR, @CustomerId) + ' ' + 'does not exist'
END;
GO


EXEC CustomerSessionContext 10004; 

-- In case the procedure has problem
DROP PROCEDURE CustomerSessionContext
GO


-- Grant Access on the Procedure
GRANT EXECUTE ON CustomerSessionContext TO customer_user;
GO

-- Same with Manager, Employee
CREATE PROCEDURE EmployeeSessionContext
@EmployeeId VARCHAR(9)
AS
BEGIN
    EXEC ClearAllSessionContext;
    DECLARE @EmployeeName VARCHAR(100)
    IF EXISTS(SELECT * FROM Employee WHERE EmployeeId = @EmployeeId AND EmployeeRole IN ('Cashier', 'Shipper'))
        BEGIN
        SET @EmployeeName = (SELECT EmployeeFName + ' ' + EmployeeLName FROM Employee 
        WHERE EmployeeId = @EmployeeId AND EmployeeRole IN ('Cashier', 'Shipper'))
        EXEC sp_set_session_context @Key = 'employee_id', @Value = @EmployeeId, @Read_only = 0;
        PRINT 'Hello' + ' ' + CONVERT(VARCHAR, @EmployeeName)
        END
    ELSE
        PRINT 'Employee with ID' + ' ' + CONVERT(VARCHAR, @EmployeeId) + ' ' + 'does not exist or is a Manager'
END;
GO

EXEC EmployeeSessionContext '100000010'; 
DROP PROCEDURE EmployeeSessionContext


-- Grant Access on the Procedure
GRANT EXECUTE ON EmployeeSessionContext TO employee_user;
GO


CREATE PROCEDURE ManagerSessionContext
@ManagerId VARCHAR(9)
AS
BEGIN
    EXEC ClearAllSessionContext;
    DECLARE @ManagerName VARCHAR(100)
    IF EXISTS (SELECT * FROM Employee WHERE EmployeeId = @ManagerId AND EmployeeRole = 'Manager')
    BEGIN
        SET @ManagerName = (SELECT EmployeeFName + ' ' + EmployeeLName FROM Employee 
        WHERE EmployeeId = @ManagerId AND EmployeeRole = 'Manager')
        EXEC sp_set_session_context @Key = 'manager_id', @Value = @ManagerId, @Read_only = 0;
        PRINT 'Hello Manager' + ' ' + CONVERT(VARCHAR, @ManagerName)
    END
    ELSE
        PRINT 'Manager with ID' + ' ' + CONVERT(VARCHAR, @ManagerId) + ' ' + 'does not exist'
END;
GO

EXEC ManagerSessionContext '110000015'; 

DROP PROCEDURE ManagerSessionContext
GO

-- Grant Access on the Procedure
GRANT EXECUTE ON ManagerSessionContext TO manager_user;
GO


-- Verify
SELECT SESSION_CONTEXT(N'customer_id') AS CurrentCustomerID, 
    SESSION_CONTEXT(N'employee_id') AS CurrentEmployeeID, 
    SESSION_CONTEXT(N'manager_id') AS CurrentManagerID;


-- HR_Staff has full access to the Employee Table
GRANT ALTER, INSERT, SELECT, UPDATE, DELETE ON dbo.Employee TO HR_staff;
GO

-- Login as Manager
SELECT * FROM Product
GO


-- PRoblem: We do not want to grant access to the employee table for the Employee or Manager 
-- but still allow them to retrieve their info. Use View
CREATE VIEW uqview_managerinfo AS
SELECT EmployeeId, EmployeeFName + ' ' + EmployeeLName AS EmployeeName, 
EmployeeAddress, EmployeeRole, Email, EmployeeSalary FROM Employee 
WHERE EmployeeId = CONVERT(VARCHAR, SESSION_CONTEXT(N'manager_id')) AND EmployeeRole = 'Manager';
GO
-- Grant the manager to use this view
GRANT SELECT ON uqview_managerinfo TO manager_role
GO

-- Same with Customer and Employee
CREATE VIEW uqview_customerinfo AS
SELECT CustomerId, CustomerFName + ' ' + CustomerLName AS CustomerName, 
CustomerAddress, CustomerPhone, Email FROM Customer 
WHERE CustomerId = CONVERT(INT, SESSION_CONTEXT(N'customer_id'))
GO

GRANT SELECT ON uqview_customerinfo TO customer_role
GO

CREATE VIEW uqview_employeeinfo AS
SELECT EmployeeId, EmployeeFName + ' ' + EmployeeLName AS EmployeeName, 
EmployeeAddress, EmployeeRole, Email, EmployeeSalary FROM Employee 
WHERE EmployeeId = CONVERT(VARCHAR, SESSION_CONTEXT(N'employee_id')) 
AND EmployeeRole IN ('Cashier', 'Shipper');
GO
-- Grant the manager to use this view
GRANT SELECT ON uqview_employeeinfo TO employee_role
GO

-- HR_Staff can select to the employee view, and can insert new employee
GRANT EXECUTE ON InsertEmployee TO HR_Staff
GO

GRANT SELECT ON View_Employee TO HR_Staff
GO

GRANT SELECT ON View_EmployeeEmail TO HR_Staff
GO

GRANT SELECT ON view_EmployeeGreaterManager TO HR_Staff
GO

-- Testing
SELECT * FROM uqview_managerinfo
GO

SELECT * FROM uqview_customerinfo
GO

SELECT * FROM uqview_employeeinfo
GO

