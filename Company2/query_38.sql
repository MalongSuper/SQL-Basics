SELECT FName, Minit, LName, Salary, DNo FROM Employee 
UPDATE Employee SET Salary = ROUND(Salary * 1.10, 0)
WHERE DNo IN (SELECT DNumber FROM Department WHERE DName = 'Research');
GO
-- The result with updated Salary
SELECT FName, Minit, LName, Salary, DNo FROM Employee;
GO
