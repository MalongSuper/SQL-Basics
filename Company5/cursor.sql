-- A cursor to retrieve the name of the department and the number of employee
USE Company;
GO

-- Declare cursor for department data
DECLARE @DNumber INT, @DName VARCHAR(50)
DECLARE @NumofEmployees INT
DECLARE csr_Department CURSOR FOR SELECT DNumber, DName FROM Department
-- Open Cursor
OPEN csr_Department
-- Fetch First row
FETCH NEXT FROM csr_Department INTO @DNumber, @DName
WHILE (@@FETCH_STATUS = 0)
    BEGIN
        PRINT @DName
        SET @NumofEmployees = (SELECT COUNT(*) FROM Employee WHERE DNo = @DNumber)
        PRINT CAST(@NumofEmployees AS VARCHAR)
        FETCH NEXT FROM csr_Department INTO @DNumber, @DName
    END  -- -2 is when the loop breaks
CLOSE csr_Department
DEALLOCATE csr_Department

-- Alternative: GROUP BY, LEFT JOIN to include Department with No Employee
SELECT d.DName, COUNT(e.SSN) FROM Department d LEFT JOIN Employee e ON e.DNo = d.DNumber GROUP BY d.DName
GO