SELECT e1.FName, e1.Minit, e1.LName FROM Employee e1 
WHERE Super_SSN IN (SELECT SSN FROM Employee e2 WHERE e2.FName = 'Franklin' AND e2.LName = 'Wong');
GO