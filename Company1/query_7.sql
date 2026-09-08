-- This simply merges the two tables JOIN Department & Employee 
-- Based on the attribute given
-- THe number of rows depend on A in SELECT * FROM A JOIN B ON Sth
SELECT * FROM Department JOIN Employee e ON e.SSN = Mgrssn 
SELECT * FROM Employee JOIN Department d ON d.DNumber = DNo