-- Add e1, e2, to differentiate the two tables of the same name
SELECT * FROM EMPLOYEE e1 JOIN EMPLOYEE e2 ON e1.Super_SSN = e2.SSN
SELECT e1.FName, e1.Minit, e1.LName, e2.FName AS SuperFName, e2.Minit AS SuperMinit, e2.LName AS SuperLName
FROM EMPLOYEE e1 JOIN EMPLOYEE e2 ON e1.Super_SSN = e2.SSN