SELECT * FROM Employee
SELECT * FROM Department
SELECT FName FROM Employee WHERE DNo = 5
-- Suppose we do not know the DNo of the Research Department
SELECT FName FROM Employee WHERE DNo IN (SELECT DNumber FROM Department WHERE DName = 'Research')
