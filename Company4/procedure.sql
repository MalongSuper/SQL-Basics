USE Company;
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.

-- English translation of the original exercise comment.
DECLARE @emp_salary NUMERIC(10, 2);
SELECT @emp_salary = SUM(Salary) FROM Employee
IF @emp_salary > 300000
    PRINT 'Win'
ELSE PRINT 'Lose';
GO


-- English translation of the original exercise comment.

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
DECLARE @Gender CHAR(1);
SELECT @Gender = e.Sex FROM Employee e WHERE e.FName = 'John'
IF @Gender = 'M'
    PRINT 'Gender: Man'
ELSE
    IF @Gender = 'F'
        PRINT 'Gender: Woman'
    ELSE
        PRINT 'Gender: Les or Gay'
GO


-- English translation of the original exercise comment.

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- Create a #temp table to store the Identity 1, 1 as SSN 
-- Alternative: RowNumber()
SELECT IDENTITY(INT, 1, 1) AS RowNum, SSN, Salary INTO #temp FROM Employee
DECLARE @TotalSalary INT, @EmployeeSalary INT, @Counter INT, @LengthTable INT, @SSN VARCHAR(9)
SELECT @Counter = 1
SELECT @TotalSalary = SUM(Salary) FROM #temp
SELECT @LengthTable = COUNT(*) FROM #temp
WHILE @TotalSalary <= 300000
BEGIN
    SELECT @EmployeeSalary = Salary, @SSN = SSN FROM #temp WHERE RowNum = @Counter
    IF @EmployeeSalary < 100000
        BEGIN
            SET @EmployeeSalary = @EmployeeSalary + 1000
            PRINT 'SSN' + ' ' + @SSN + ', ' + 'Update Salary' + ' ' + CONVERT(VARCHAR, @EmployeeSalary)
            PRINT 'Total Salary' + ' ' + CONVERT(VARCHAR, @TotalSalary)
            -- Update the employee salary in the table
            UPDATE #temp SET Salary = Salary + 1000 WHERE RowNum = @Counter
            -- Add 1000 to the total Salary
            SET @TotalSalary = @TotalSalary + 1000
        END
        -- Update Counter
    SET @Counter = @Counter + 1
    IF @Counter > @LengthTable
        SET @Counter = 1    
END;
GO


-- English translation of the original exercise comment.

-- English translation of the original exercise comment.
-- begin try 
-- select 1 / 0 as error;
-- end try
-- begin catch
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
BEGIN TRY 
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT 
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO




-- English translation of the original exercise comment.
-- INSERT INTO [dbo].[Department]([DName],[DNumber],[Mgrssn],[MgrStartdate]) values('nonamenonamenoname',5,'123456789',getdate())
-- English translation of the original exercise comment.
--SQL1
BEGIN TRY
    INSERT INTO [dbo].[Department]([DName],[DNumber],[Mgrssn],[MgrStartdate]) values('nonamenonamenoname',5,'123456789',getdate());
END TRY

BEGIN CATCH
SELECT 
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO
-- English translation of the original exercise comment.

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
CREATE PROCEDURE proc_project_hours 
AS
BEGIN
    SELECT p.PName, SUM(w.Hours) AS TotalHoursperWeek
    FROM Works_On w JOIN Project p ON p.PNumber = w.Pno GROUP BY p.PName;
END


-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
EXEC proc_project_hours 
EXECUTE proc_project_hours 
BEGIN EXECUTE proc_project_hours END
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
CREATE PROCEDURE proc_search_pro_emps
@ProjectName VARCHAR(50)
AS
BEGIN
-- Check if there is any result
    IF EXISTS(SELECT * FROM Project WHERE PName = @ProjectName)
        BEGIN
            SELECT e.FName + ' ' + e.Minit + ' ' + e.LName AS FullName FROM Employee e 
            JOIN Works_On w ON w.ESSN = e.SSN 
            JOIN Project p ON p.PNumber = w.PNo
            WHERE p.PName = @ProjectName
        END
    ELSE
        PRINT 'Not Found'
END;
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
EXEC proc_search_pro_emps @ProjectName = 'ProductX'
EXEC proc_search_pro_emps @ProjectName = 'ProductY'
EXEC proc_search_pro_emps @ProjectName = 'ProductZ'
EXEC proc_search_pro_emps @ProjectName = 'ProductXZ'
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
CREATE PROCEDURE proc_insert_date_for_Project
@ProjectName VARCHAR(50),
@ProjectNumber INT,
@ProjectLocation VARCHAR(50),
@DNum INT
AS
BEGIN
    INSERT INTO Project(PName, PNumber, PLocation, DNum) 
    VALUES (@ProjectName, @ProjectNumber, @ProjectLocation, @DNum);
END;
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
EXEC proc_insert_date_for_Project @ProjectName = 'ProjectAI', @ProjectNumber = 40, 
@ProjectLocation = 'Sugarland', @DNum = 5;
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
-- Cach 1
CREATE PROCEDURE proc_salary_review
AS
BEGIN
    SELECT MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, 
    AVG(Salary) AS AverageSalary FROM Employee
END;
GO

EXEC proc_salary_review 
GO
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
CREATE PROCEDURE proc_execute_proc_salary_review 
AS
BEGIN
    EXEC proc_salary_review
END;
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
EXEC proc_execute_proc_salary_review;
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
CREATE PROCEDURE proc_Project_salary_total
@ProjectName VARCHAR(50),
@TotalEmployees INT OUTPUT,
@TotalHours NUMERIC(3, 1) OUTPUT
AS
BEGIN
    IF EXISTS(SELECT * FROM Project WHERE PName = @ProjectName)
        BEGIN
        SELECT @TotalEmployees = COUNT(ESSN), @TotalHours = SUM(Hours) FROM Works_On w
        JOIN Project p ON p.PNumber = w.PNo WHERE p.PName = @ProjectName
        END
    ELSE
        PRINT 'Not Found'
END;
GO


-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
CREATE PROCEDURE proc_exec_Project_salary_total
@ProjectName VARCHAR(50)
AS
BEGIN -- USe Declare to return an output value
    DECLARE @TotalEmployees INT, @TotalHours INT 
    EXEC proc_Project_salary_total @ProjectName = @ProjectName, 
    @TotalEmployees = @TotalEmployees OUTPUT, @TotalHours = @TotalHours OUTPUT
    PRINT @TotalEmployees
    PRINT @TotalHours
END;
GO

EXEC proc_exec_Project_salary_total @ProjectName = 'ProductX'

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- --SQL1
DROP PROCEDURE proc_project_hours 
DROP PROCEDURE proc_search_pro_emps
DROP PROCEDURE proc_insert_date_for_Project 
DROP PROCEDURE proc_salary_review
DROP PROCEDURE proc_execute_proc_salary_review 
DROP PROCEDURE proc_Project_salary_total 
DROP PROCEDURE proc_exec_Project_salary_total 
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.


-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1
CREATE FUNCTION salary_increase (@Salary NUMERIC(10, 0))
RETURNS NUMERIC(10, 0)
AS 
BEGIN
    RETURN @Salary * 1.10
END;
GO


-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1
-- Remember to add dbo.FunctionName()
SELECT Salary, dbo.salary_increase(Salary) AS SalaryTenPercent FROM Employee;
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1 Inline Table-Valued Function always return a table
CREATE FUNCTION fx_review_salary()
RETURNS TABLE
AS
    RETURN (SELECT * FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee));
GO
-- Caution (SELECT * FROM Employee WHERE Salary > AVG(Salary)) Is invalid
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1
SELECT * FROM dbo.fx_review_salary();
GO


-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1
CREATE FUNCTION fx_emp_project(@FullName VARCHAR(100))
RETURNS TABLE
AS
    RETURN (SELECT p.PName, p.PNumber, p.PLocation, p.DNum FROM Works_On w 
    JOIN Employee e ON w.ESSN = e.SSN 
    JOIN Project p ON p.PNumber = w.PNo
    WHERE (e.FName + e.LName) = @FullName)
GO


-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1
SELECT * FROM dbo.fx_emp_project('JohnSmith');
GO

SELECT * FROM dbo.fx_emp_project('FranklinWong');
GO

-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1
CREATE FUNCTION fx_emp_project2(@FullName VARCHAR(100))
RETURNS @TemproraryTable TABLE (PName VARCHAR(50), PNumber INT, PLocation VARCHAR(50), DNum INT)
AS
    BEGIN
    INSERT INTO @TemproraryTable SELECT p.PName, p.PNumber, p.PLocation, p.DNum FROM Works_On w 
    JOIN Employee e ON w.ESSN = e.SSN 
    JOIN Project p ON p.PNumber = w.PNo
    WHERE (e.FName + e.LName) = @FullName
    RETURN
    END
GO


-- English translation of the original exercise comment.
-- English translation of the original exercise comment.
-- SQL1
SELECT * FROM dbo.fx_emp_project2('JohnSmith');
GO

SELECT * FROM dbo.fx_emp_project2('FranklinWong');
GO
