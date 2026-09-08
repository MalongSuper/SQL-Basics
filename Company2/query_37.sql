SELECT FName, Minit, LName FROM Employee 
WHERE SSN IN (SELECT Mgrssn FROM Department) AND SSN NOT IN (SELECT ESSN FROM Dependent);
GO
