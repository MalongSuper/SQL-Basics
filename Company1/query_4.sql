SELECT * FROM Employee WHERE FName = 'Franklin'
SELECT * FROM Department
SELECT DName FROM Department WHERE Mgrssn IN (SELECT SSN FROM Employee WHERE FName = 'Franklin')