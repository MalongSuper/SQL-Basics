SELECT * FROM Works_On w
RIGHT OUTER JOIN Project p ON p.PNumber = w.PNo;
GO
