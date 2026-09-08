SELECT FName, Minit, LName FROM Employee e 
INNER JOIN Department d ON e.DNo = d.Dnumber
INNER JOIN Works_On w ON w.ESSN = e.SSN
INNER JOIN Project p ON p.PNumber = w.PNo
WHERE e.DNo = 5 AND p.PName = 'ProductX' AND Hours >= 10;
GO
