SELECT FName, Minit, LName, Address FROM Employee 
WHERE SSN IN 
(SELECT ESSN FROM Works_On WHERE PNo IN (SELECT PNumber FROM Project WHERE PLocation = 'Houston'))
AND DNo NOT IN (SELECT DNumber FROM Dept_Location WHERE DLocation = 'Houston');
GO
