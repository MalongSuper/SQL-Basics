SELECT d.DNumber, d.DName FROM Employee e
JOIN Department d ON d.DNumber = e.DNo GROUP BY d.DNumber, d.DName 
HAVING COUNT(DNo) > 3 ORDER BY COUNT(DNo);
GO
