SELECT * FROM Employee
SELECT * FROM Project WHERE PName = 'ProductX'
-- Get the Employee who belongs to the Department that has Project 'ProductX'
SELECT * FROM Employee WHERE DNo IN (SELECT DNum FROM Project WHERE PName = 'ProductX')
SELECT * FROM Works_On
-- Correct Query
SELECT PNumber FROM Project WHERE PName = 'ProductX'
SELECT * FROM Employee WHERE SSN IN (SELECT ESSN FROM Works_On WHERE PNo 
IN (SELECT PNumber FROM Project WHERE PName = 'ProductX'))