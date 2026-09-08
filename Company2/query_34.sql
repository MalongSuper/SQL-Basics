INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('333445555', 1, 10.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('333445555', 30, 30.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('333445555', 40, 30.0);
SELECT e.FName, e.Minit, e.LName FROM Employee e 
JOIN Works_On w ON e.SSN = w.ESSN GROUP BY e.FName, e.Minit, e.LName 
HAVING COUNT(w.PNo) IN (SELECT COUNT(PNumber) FROM Project);
GO
