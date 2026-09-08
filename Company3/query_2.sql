-- B. Views
-- Create views and complete the following requirements.
-- 14. Create v_EmpSuperSSN showing department, supervisor, and employee names.
USE Company;
GO
CREATE VIEW [v_EmpSuperSSN] AS
SELECT d.DName, e1.FName AS EmpFName, e1.Minit AS EmpMinit, e1.LName AS EmpLName,
e2.FName AS SuperFName, e2.Minit AS SuperMinit, e2.LName AS SuperLName
FROM Employee e1
JOIN Department d ON e1.DNo = d.DNumber
JOIN Employee e2 ON e1.SSN = e2.Super_SSN;
GO
-- Check whether the view already exists.
-- Execution - verification result
-- Query the view to verify the result.

-- 15. Create v_DepEmp showing the department name, manager name, and employee names for each department.
CREATE VIEW [v_DepEmp] AS
SELECT d.DName AS Dept, e1.FName AS MgrFName, e1.LName AS MgrLName,
e2.FName AS EmpFName, e2.LName AS EmpLName FROM Employee e1
JOIN Employee e2 ON e1.SSN = e2.Super_SSN
JOIN Department d ON d.Mgrssn = e1.SSN;
GO
-- Execution - verification result

-- 16. Create v_PrjEmp showing the project name, location, and assigned employee names.
CREATE VIEW [v_PrjEmp] AS
SELECT p.PName AS ProjectName, p.PLocation AS ProjectLocation,
e.FName AS EmpFName, e.Minit AS EmpMinit, e.LName AS EmpLName FROM Project p
JOIN Works_On w ON p.PNumber = w.PNo
JOIN Employee e ON w.ESSN = e.SSN;
GO
-- Execution - verification result

-- 17. Create v_EmpDep showing each employee name, dependent name if available, and relationship.
CREATE VIEW [v_EmpDep] AS
SELECT e.Fname, e.Minit, e.LName, d.Dependent_Name, d.Relationship
FROM Employee e
LEFT JOIN Dependent d ON e.SSN = d.ESSN;
GO
-- Execution - verification result

-- 18. Create v_DeptPrj showing department, project, location, employee count, and total project hours.
CREATE VIEW [v_DeptPrj] AS
SELECT d.DName, p.PName, p.PLocation,
COUNT(DISTINCT w.ESSN) AS NumofEmployees, SUM(w.Hours) AS TotalHours FROM Department d
JOIN Project p ON d.DNumber = p.DNum
LEFT JOIN Works_On w ON w.PNo = p.PNumber
GROUP BY d.DName, p.PName, p.PLocation;
GO
-- Execution - verification result

-- 19. List the views just created.
SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS;

-- 20. Query data from the views created in questions 1, 2, 3, 4, and 5.
SELECT * FROM v_EmpSuperSSN;
SELECT * FROM v_DepEmp;
SELECT * FROM v_PrjEmp;
SELECT * FROM v_EmpDep;
SELECT * FROM v_DeptPrj;

-- 21. Drop the views created in questions 1, 2, 3, 4, and 5.
DROP VIEW v_EmpSuperSSN;
DROP VIEW v_DepEmp;
DROP VIEW v_PrjEmp;
DROP VIEW v_EmpDep;
DROP VIEW v_DeptPrj;

-- C. Indexes
-- Create indexes and complete the following requirements.
-- 22. List the SQL index types that you know.
-- Execution - verification result

-- 23. Create a Single Column Index named idx_fname on FName in Employee.
CREATE INDEX idx_fname ON Employee(FName);
GO
-- 24. Create a Single Column Index named idx_DepdName on Dependent_Name in Dependent.
CREATE INDEX idx_DepdName ON Dependent(Dependent_Name);
GO
-- 25. Create a Single Column Index named idx_Dloca on DLocation in Dept_Location.
CREATE INDEX idx_Dloca ON Dept_Location(DLocation);
GO
-- 26. Create a Single Column Index named idx_PrjLoc on PLocation in Project.
CREATE INDEX idx_PrjLoc ON Project(PLocation);
GO
-- 27. Create a Unique Index named idx_ssn on SSN in Employee.
CREATE UNIQUE INDEX idx_ssn ON Employee(SSN);
GO
-- 28. Create a Unique Index named idx_address on Address in Employee.
CREATE INDEX idx_address ON Employee(Address);
GO
-- 29. Create a Composite Index named idx_EmpFLName on FName and LName in Employee.
CREATE INDEX idx_EmpFLName ON Employee(FName, LName);
GO
-- 30. Create a Composite Index named idx_EmpLFName on LName and FName in Employee.
CREATE INDEX idx_EmpLFName ON Employee(LName, FName);
GO
-- 31. List implicit indexes automatically created for primary-key or unique constraints in Company.
SELECT * FROM sys.tables;
SELECT * FROM sys.indexes;
SELECT * FROM sys.key_constraints;
SELECT
    t.name AS TableName,
    i.name AS IndexName,
    kc.type_desc AS ConstraintType
FROM sys.key_constraints kc
JOIN sys.tables t ON kc.parent_object_id = t.object_id
JOIN sys.indexes i ON kc.parent_object_id = i.object_id AND kc.unique_index_id = i.index_id
WHERE kc.type IN ('PK', 'UQ');
GO

-- 32. View execution time after creating indexes. List employee table information and capture a screenshot.
SET STATISTICS TIME ON;
SELECT * FROM Employee;
SET STATISTICS TIME OFF;
GO
-- Result

-- 33. List the indexes just created.
SELECT
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name
FROM sys.indexes ind
INNER JOIN sys.index_columns ic ON ind.object_id = ic.object_id AND ind.index_id = ic.index_id
INNER JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id
INNER JOIN sys.tables t ON ind.object_id = t.object_id
WHERE ind.is_primary_key = 0
  AND ind.is_unique = 0
  AND ind.is_unique_constraint = 0
  AND t.is_ms_shipped = 0
ORDER BY t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

-- 34. Drop at least three of the indexes just created.
DROP INDEX idx_fname;
DROP INDEX idx_DepdName;
DROP INDEX idx_Dloca;
DROP INDEX idx_PrjLoc;
DROP INDEX idx_ssn;
DROP INDEX idx_address;
DROP INDEX idx_EmpFLName;
DROP INDEX idx_EmpLFName;
GO
