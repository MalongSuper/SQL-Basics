SELECT * FROM Project p
LEFT OUTER JOIN Works_On w ON p.PNumber = w.PNo;
GO
