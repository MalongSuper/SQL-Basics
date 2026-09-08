SELECT FName, LName, DNo FROM Employee
SELECT FName, LName FROM Employee
SELECT DName FROM Department
SELECT FName, LName, DName FROM Employee, Department
-- Matching Relationship
SELECT FName, LName, DName FROM Employee, Department WHERE DNo = DNumber ORDER BY SSN
