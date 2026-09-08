SELECT e1.FName, e1.LName FROM Employee e1 
JOIN Dependent d1 ON e1.SSN = d1.ESSN 
JOIN Dependent d2 ON d1.Dependent_Name = d2.Dependent_Name
JOIN Employee e2 ON e2.SSN = d2.ESSN
WHERE e1.SSN <> e2.SSN AND d1.Dependent_Name = d2.Dependent_Name;
GO
