-- Script

-- 1) Add salary to the Employee table
ALTER TABLE Employee
ADD EmployeeSalary NUMERIC(10, 2) NOT NULL,
    CONSTRAINT df_employeesalary DEFAULT 0 FOR EmployeeSalary
GO

UPDATE Employee SET EmployeeSalary = 58200.00 WHERE EmployeeId = '100000001';
UPDATE Employee SET EmployeeSalary = 75000.00 WHERE EmployeeId = '100000002';
UPDATE Employee SET EmployeeSalary = 63400.00 WHERE EmployeeId = '100000003';
UPDATE Employee SET EmployeeSalary = 82000.00 WHERE EmployeeId = '100000004';
UPDATE Employee SET EmployeeSalary = 92800.00 WHERE EmployeeId = '100000005';
UPDATE Employee SET EmployeeSalary = 45600.00 WHERE EmployeeId = '100000006';
UPDATE Employee SET EmployeeSalary = 37000.00 WHERE EmployeeId = '100000007';
UPDATE Employee SET EmployeeSalary = 64200.00 WHERE EmployeeId = '100000008';
UPDATE Employee SET EmployeeSalary = 39400.00 WHERE EmployeeId = '100000009';
UPDATE Employee SET EmployeeSalary = 71100.00 WHERE EmployeeId = '100000010';
UPDATE Employee SET EmployeeSalary = 88500.00 WHERE EmployeeId = '100000011';
UPDATE Employee SET EmployeeSalary = 47800.00 WHERE EmployeeId = '100000012';
UPDATE Employee SET EmployeeSalary = 66000.00 WHERE EmployeeId = '100000013';
UPDATE Employee SET EmployeeSalary = 73200.00 WHERE EmployeeId = '100000014';
UPDATE Employee SET EmployeeSalary = 80300.00 WHERE EmployeeId = '100000015';
UPDATE Employee SET EmployeeSalary = 54900.00 WHERE EmployeeId = '100000016';
UPDATE Employee SET EmployeeSalary = 42600.00 WHERE EmployeeId = '100000017';
UPDATE Employee SET EmployeeSalary = 93500.00 WHERE EmployeeId = '100000018';
UPDATE Employee SET EmployeeSalary = 68400.00 WHERE EmployeeId = '100000019';
UPDATE Employee SET EmployeeSalary = 57200.00 WHERE EmployeeId = '100000020';
UPDATE Employee SET EmployeeSalary = 79800.00 WHERE EmployeeId = '100000021';
UPDATE Employee SET EmployeeSalary = 61000.00 WHERE EmployeeId = '100000022';
UPDATE Employee SET EmployeeSalary = 73100.00 WHERE EmployeeId = '100000023';
UPDATE Employee SET EmployeeSalary = 80700.00 WHERE EmployeeId = '100000024';
UPDATE Employee SET EmployeeSalary = 44600.00 WHERE EmployeeId = '100000025';
UPDATE Employee SET EmployeeSalary = 69300.00 WHERE EmployeeId = '100000026';
UPDATE Employee SET EmployeeSalary = 85300.00 WHERE EmployeeId = '100000027';
UPDATE Employee SET EmployeeSalary = 58000.00 WHERE EmployeeId = '100000028';
UPDATE Employee SET EmployeeSalary = 73900.00 WHERE EmployeeId = '100000029';
UPDATE Employee SET EmployeeSalary = 82900.00 WHERE EmployeeId = '100000030';
UPDATE Employee SET EmployeeSalary = 90100.00 WHERE EmployeeId = '100000031';
UPDATE Employee SET EmployeeSalary = 46600.00 WHERE EmployeeId = '100000032';
UPDATE Employee SET EmployeeSalary = 74800.00 WHERE EmployeeId = '100000033';
UPDATE Employee SET EmployeeSalary = 59900.00 WHERE EmployeeId = '100000034';
UPDATE Employee SET EmployeeSalary = 84400.00 WHERE EmployeeId = '100000035';
UPDATE Employee SET EmployeeSalary = 77700.00 WHERE EmployeeId = '100000036';
UPDATE Employee SET EmployeeSalary = 92100.00 WHERE EmployeeId = '100000037';
UPDATE Employee SET EmployeeSalary = 50300.00 WHERE EmployeeId = '100000038';

UPDATE Employee SET EmployeeSalary = 62200.00 WHERE EmployeeId = '110000011';
UPDATE Employee SET EmployeeSalary = 71400.00 WHERE EmployeeId = '110000012';
UPDATE Employee SET EmployeeSalary = 68500.00 WHERE EmployeeId = '110000013';
UPDATE Employee SET EmployeeSalary = 89300.00 WHERE EmployeeId = '110000014';
UPDATE Employee SET EmployeeSalary = 56900.00 WHERE EmployeeId = '110000015';
UPDATE Employee SET EmployeeSalary = 63100.00 WHERE EmployeeId = '110000016';
UPDATE Employee SET EmployeeSalary = 70200.00 WHERE EmployeeId = '110000017';
UPDATE Employee SET EmployeeSalary = 79000.00 WHERE EmployeeId = '110000018';
GO

-- Testing
SELECT * FROM Employee

-- Script: 50% Salary For Every Manager
UPDATE Employee SET EmployeeSalary = EmployeeSalary + (EmployeeSalary * 0.5) 
WHERE EmployeeRole = 'Manager'
GO

-- Script: Create a new MarketStall and assign the Manager with the lowest salary to that stall
INSERT INTO MarketStall(StallNumber, StallName, StallManager)
VALUES ('9', 'Condiments Stall', (SELECT TOP 1 EmployeeId FROM Employee 
WHERE EmployeeRole = 'Manager' ORDER BY EmployeeSalary ASC));
GO

-- Promote an Employee to Manager if they earn above the average salary when remove 25% of their salary
DECLARE @AVGSalary NUMERIC(10, 2)
SET @AVGSalary = (SELECT AVG(EmployeeSalary) FROM Employee)
UPDATE Employee SET EmployeeRole = 'Manager' WHERE EmployeeRole <> 'Manager' 
AND EmployeeSalary - (EmployeeSalary * 0.25) > @AVGSalary
GO

-- Remove 25% of the salary for the managers who manage no stall
UPDATE Employee SET EmployeeSalary = EmployeeSalary - (EmployeeSalary * 0.25) 
WHERE EmployeeRole = 'Manager' AND EmployeeID NOT IN (SELECT StallManager FROM MarketStall)
GO

SELECT * FROM MarketStall

-- +10000 bonus for Manager who manages more than one stall
UPDATE Employee SET EmployeeSalary = EmployeeSalary + 10000 WHERE EmployeeRole = 'Manager' 
AND EmployeeID IN (SELECT StallManager FROM MarketStall GROUP BY StallManager HAVING COUNT(StallNumber) > 1)


SELECT * FROM MarketStall
GO


-- Get the non-Manager employees with greater salary than at least one Manager's salary
-- A View
CREATE VIEW view_EmployeeGreaterManager AS
SELECT EmployeeFName + ' ' + EmployeeLName AS EmployeeName, EmployeeSalary FROM Employee WHERE EmployeeRole IN ('Cashier', 'Shipper')
AND EmployeeSalary >= ANY 
(SELECT EmployeeSalary FROM Employee WHERE EmployeeRole IN ('Manager'))
GO

-- Procedure with Cursor: List Employee of the Month Candidates
-- Requirement The Salary when reduced to 15% still exceeds the Average Salary of every employee
-- Not a Manager
CREATE PROCEDURE Proc_EmployeeoftheMonth
AS
BEGIN
    PRINT 'Employee of the Month Candidates'
    DECLARE @EmployeeID VARCHAR(9), @AVGSalary NUMERIC(10, 2), @ReducedSalary NUMERIC(10, 2), 
    @EmployeeName VARCHAR(100), @EmployeeSalary NUMERIC(10, 2)
    SET @AVGSalary = (SELECT AVG(EmployeeSalary) FROM Employee)
    DECLARE EmployeeCursor CURSOR FOR SELECT EmployeeID, EmployeeFName + ' ' + EmployeeLName,
    EmployeeSalary FROM Employee WHERE EmployeeRole <> 'Manager'
    OPEN EmployeeCursor
    FETCH NEXT FROM EmployeeCursor INTO @EmployeeID, @EmployeeName, @EmployeeSalary
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @ReducedSalary = @EmployeeSalary - (@EmployeeSalary * 0.15) FROM Employee WHERE EmployeeID = @EmployeeID
        IF @ReducedSalary > @AVGSalary
            BEGIN
            PRINT 'Employee ID:' + ' ' + @EmployeeID + '; Name' + ' ' + @EmployeeName
            END
        FETCH NEXT FROM EmployeeCursor INTO @EmployeeID, @EmployeeName, @EmployeeSalary
    END
    -- Close and Deallocate Cursor
    CLOSE EmployeeCursor
    DEALLOCATE EmployeeCursor
END;
GO

EXEC Proc_EmployeeoftheMonth

DROP PROCEDURE Proc_EmployeeoftheMonth
GO

-- Returns the top 3 employees with the highest salary.
CREATE PROCEDURE Proc_Top3HighestSalary
AS
BEGIN
    PRINT 'Top 3 Highest Paid Employees'
    SELECT TOP 3 EmployeeId, EmployeeFName + ' ' + EmployeeLName AS EmployeeName, EmployeeSalary
    FROM Employee
    ORDER BY EmployeeSalary DESC;
END;
GO

EXEC Proc_Top3HighestSalary;
GO

-- Finds employees that have no assigned role
CREATE PROCEDURE Proc_EmployeesWithoutRole
AS
BEGIN
    PRINT 'Employees Without a Defined Role'
    SELECT EmployeeId, EmployeeFName + ' ' + EmployeeLName AS FullName
    FROM Employee
    WHERE EmployeeRole IS NULL OR EmployeeRole = '';
END;
GO

EXEC Proc_EmployeesWithoutRole;
GO

--Calculates the total salary cost of all employees
CREATE PROCEDURE Proc_TotalSalaryBudget
AS
BEGIN
    DECLARE @Total NUMERIC(12,2)
    SET @Total = (SELECT SUM(EmployeeSalary) FROM Employee)
    PRINT 'Total Salary Budget: ' + CAST(@Total AS VARCHAR)
END;
GO

EXEC Proc_TotalSalaryBudget;
GO

--If a cashier has a salary below a certain threshold, promote them to Shipper
CREATE PROCEDURE Proc_PromoteLowCashiers
@Threshold NUMERIC(10, 2)
AS
BEGIN
    UPDATE Employee
    SET EmployeeRole = 'Shipper'
    WHERE EmployeeRole = 'Cashier' AND EmployeeSalary < @Threshold;

    PRINT 'Cashiers with salary below ' + CAST(@Threshold AS VARCHAR) + ' were promoted to Shipper.';
END;
GO

-- Example execution:
EXEC Proc_PromoteLowCashiers @Threshold = 60000;

DROP PROCEDURE IF EXISTS Proc_Top3HighestSalary;
DROP PROCEDURE IF EXISTS Proc_EmployeesWithoutRole;
DROP PROCEDURE IF EXISTS Proc_TotalSalaryBudget;
DROP PROCEDURE IF EXISTS Proc_PromoteLowCashiers;
