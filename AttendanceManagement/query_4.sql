-- Proc 1:

CREATE PROCEDURE Proc1
@EmployeeID CHAR(4),
@Month CHAR(7),
@WorkingDays INT OUTPUT,
@SalaryPerMonth INT OUTPUT
AS
BEGIN
    SELECT @WorkingDays = SUM(working_days), @SalaryPerMonth = (e.base_salary * SUM(working_days))/ 26
    FROM Attendance a JOIN AttendanceSheet att ON a.sheet_id = att.sheet_id
    JOIN Employee e ON e.employee_id = a.employee_id
    WHERE @EmployeeID = e.employee_id AND @Month = att.month
    GROUP BY e.employee_id, e.base_salary, month
END;
GO

DECLARE @EmployeeID CHAR(4), @Month CHAR(7), @WorkingDays INT, @SalaryPerMonth INT 
SET @EmployeeID = 'NV01'
SET @Month = '01/2025'
EXEC Proc1 @EmployeeID = @EmployeeID, @Month = @Month, @WorkingDays = @WorkingDays OUTPUT, @SalaryPerMonth = @SalaryPerMonth OUTPUT
PRINT 'Employee ID:' + ' ' + CONVERT(VARCHAR, @EmployeeID)
PRINT 'Month:' + ' ' + CONVERT(VARCHAR, @Month)
PRINT 'Working Days:' + ' ' + CONVERT(VARCHAR, @WorkingDays)
PRINT 'SalaryPerMonth:' + ' ' + CONVERT(VARCHAR, @SalaryPerMonth)



-- Testing Query
SELECT employee_id, SUM(working_days) FROM Attendance WHERE employee_id = 'NV01' 
GROUP BY employee_id

SELECT e.employee_id, SUM(working_days), (e.base_salary * SUM(working_days))/ 26
FROM Attendance a JOIN AttendanceSheet att ON a.sheet_id = att.sheet_id
JOIN Employee e ON e.employee_id = a.employee_id
GROUP BY e.employee_id, e.base_salary, month
GO




-- Proc 2
CREATE PROCEDURE Proc2
@DepartmentID CHAR(3),
@Month CHAR(7),
@TotalSalary INT OUTPUT
AS
BEGIN
    SELECT @TotalSalary = SUM(e.base_salary) FROM Attendance a 
    JOIN AttendanceSheet att ON a.sheet_id = att.sheet_id
    JOIN Employee e ON e.employee_id = a.employee_id
    JOIN Department d ON d.department_id = e.department_id
    WHERE d.department_id = @DepartmentID AND @Month = att.month
END;
GO


DECLARE @DepartmentID CHAR(3), @Month CHAR(7), @TotalSalary INT 
SET @DepartmentID = 'P01'
SET @Month = '01/2025'
EXEC Proc2 @DepartmentID = @DepartmentID, @Month = @Month, @TotalSalary = @TotalSalary OUTPUT
PRINT 'Department ID:' + ' ' + CONVERT(VARCHAR, @DepartmentID)
PRINT 'Month:' + ' ' + CONVERT(VARCHAR, @Month)
PRINT 'Total Salary:' + ' ' + CONVERT(VARCHAR, @TotalSalary)

DROP PROCEDURE Proc2

-- Testing Query
SELECT d.department_id, att.month, SUM(e.base_salary) AS TotalDepartmentSalary 
FROM Attendance a 
JOIN AttendanceSheet att ON a.sheet_id = att.sheet_id
JOIN Employee e ON e.employee_id = a.employee_id
JOIN Department d ON d.department_id = e.department_id
GROUP BY d.department_id, att.month

SELECT SUM(e.base_salary) AS TotalDepartmentSalary 
FROM Attendance a 
JOIN AttendanceSheet att ON a.sheet_id = att.sheet_id
JOIN Employee e ON e.employee_id = a.employee_id
JOIN Department d ON d.department_id = e.department_id
WHERE d.department_id = 'P01' AND att.month = '01/2025'

SELECT COUNT(e.employee_id) FROM Employee e 
JOIN department d ON d.department_id = e.department_id
GROUP BY d.department_id HAVING COUNT(e.employee_id) > 3


SELECT * FROM Employee

SELECT * FROM Attendance
SELECT * FROM Department



SELECT * FROM Department 
SELECT * FROM Employee e JOIN Department d ON e.department_id = d.department_id
SELECT * FROM Attendance
GO


-- Proc 3
CREATE PROCEDURE Proc3
@EmployeeID CHAR(4),
@NewDepartmentID CHAR(3),
@ChangedMonth CHAR(7)
AS
BEGIN
    UPDATE Employee SET department_id = @NewDepartmentID
    WHERE employee_id = @EmployeeID
    PRINT 'Update Successful for table Employee'
    
    UPDATE Att SET month = @ChangedMonth, department_id = @NewDepartmentID
    FROM AttendanceSheet Att
    JOIN Attendance A ON Att.sheet_id = A.sheet_id
    WHERE A.employee_id = @EmployeeID
    PRINT 'Update Successful for table AttendanceSheet'

END;
GO

EXEC Proc3 @EmployeeID = 'NV01', @NewDepartmentID = 'P02', @ChangedMonth = '03/2025'
SELECT * FROM Employee



SELECT * FROM Employee e JOIN department d ON d.department_id = e.department_id
SELECT * FROM Attendance
SELECT * FROM AttendanceSheet
SELECT * FROM Attendance a JOIN AttendanceSheet att ON att.sheet_id = a.sheet_id
SELECT * FROM Employee e JOIN AttendanceSheet att ON e.department_id = att.department_id


-- Proc 4
-- Total working days = sum of all employees’ attendance days recorded in that month.
-- Total salary paid = sum of (daily salary × number of attendance days) 
-- for all employees in that month.
CREATE PROCEDURE Proc4
@Month CHAR(7)
AS
BEGIN
    DECLARE @TotalWorkingDays INT, @TotalSalaryPaid INT
    SET @TotalWorkingDays = SELECT SUM()

SELECT * FROM AttendanceSheet att JOIN Attendance a ON a.sheet_id = att.sheet_id




SELECT * FROM Employee


INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV07', N'Alice Nguyen', 4500000, N'P01')
GO
INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV08', N'Nguyen Cai Do', 3200000, N'P02')
GO


-- Proc 6
CREATE PROCEDURE Proc6
@TotalOverallSalary INT
AS 
DECLARE @NewSalary INT, @TotalEmployeeSalary INT, @Percentage DECIMAL(5, 2), 
@TotalSalaryBefore INT, @TotalSalaryAfter INT, @Result INT
SET @TotalEmployeeSalary = (SELECT SUM(base_salary) FROM Employee)
IF @TotalOverallSalary > @TotalEmployeeSalary
BEGIN
    SET @Percentage = 10.0
    SET @TotalSalaryBefore = (SELECT SUM(base_salary) FROM Employee WHERE base_salary < 5000000)
    SET @TotalSalaryAfter = (SELECT SUM(base_salary + (base_salary * (@Percentage / 100.0))) FROM Employee WHERE base_salary < 5000000)
    SET @Result = @TotalSalaryAfter - @TotalSalaryBefore
    SET @NewSalary = @TotalEmployeeSalary + @Result
    WHILE @NewSalary > @TotalOverallSalary
        BEGIN
            SET @Percentage = @Percentage - 0.1
            IF @Percentage <= 0.1 BREAK;
            SET @TotalSalaryBefore = (SELECT SUM(base_salary) FROM Employee WHERE base_salary < 5000000)
            SET @TotalSalaryAfter = (SELECT SUM(base_salary + (base_salary * (@Percentage / 100.0))) FROM Employee WHERE base_salary < 5000000)
            SET @Result = @TotalSalaryAfter - @TotalSalaryBefore
            SET @NewSalary = @TotalEmployeeSalary + @Result
        END

    PRINT @NewSalary
    PRINT @Percentage
    -- Update the table to reflect the new salary
    SELECT SUM(base_salary) AS TotalSalaryLess FROM Employee WHERE base_salary < 5000000
    SELECT SUM(base_salary + (base_salary * (@Percentage / 100.0))) AS TotalSalaryLessNew FROM Employee WHERE base_salary < 5000000
END;
GO

DECLARE @TotalOverallSalary INT
EXEC Proc6 @TotalOverallSalary = 81900000

DROP PROCEDURE Proc6 
GO


SELECT base_salary FROM Employee 
SELECT * FROM Employee
SELECT base_salary FROM Employee WHERE base_salary < 5000000
SELECT base_salary + (base_salary * 0.1) FROM Employee WHERE base_salary < 5000000
SELECT SUM(base_salary) FROM Employee 
DECLARE @NewSalary INT, @TotalEmployeeSalary INT, @Percentage DECIMAL(5, 1), 
@TotalSalaryBefore INT, @TotalSalaryAfter INT, @Result INT
SET @Percentage = 10.0
SET @TotalSalaryBefore = (SELECT SUM(base_salary) FROM Employee WHERE base_salary < 5000000)
SET @TotalSalaryAfter = (SELECT SUM(base_salary + (base_salary * (@Percentage / 100))) FROM Employee WHERE base_salary < 5000000)
SET @Result = @TotalSalaryAfter - @TotalSalaryBefore
SET @TotalEmployeeSalary = (SELECT SUM(base_salary) FROM Employee)
SET @NewSalary = @TotalEmployeeSalary + @Result
PRINT @NewSalary