USE Company;
GO

-- Create a trigger that handels the case that: An Employee can only works at 40 hours at maximum
-- INSERTED: Check the inserted with the existing values
CREATE TRIGGER trg_MaximumHours
ON Works_On
FOR INSERT, UPDATE
AS
IF EXISTS(SELECT ESSN, SUM(Hours) AS T FROM Works_On WHERE ESSN IN (SELECT ESSN FROM INSERTED) 
GROUP BY ESSN HAVING SUM(Hours) > 40)
BEGIN
    RAISERROR('Error: An Employee cannot work for more than 40 hours', 16, 1)
    ROLLBACK TRANSACTION
END;
GO



-- Create a trigger that handles the case that: A Project can have at most 5 employees
CREATE TRIGGER trg_ProjectEmployees
ON Works_On
FOR INSERT, UPDATE
AS
IF EXISTS (SELECT PNo, COUNT(ESSN) FROM Works_On WHERE PNo IN (SELECT PNo FROM INSERTED) 
GROUP BY PNo HAVING COUNT(ESSN) > 5)
BEGIN
    RAISERROR('Error: A Project can have at most 5 employees', 16, 1)
    ROLLBACK TRANSACTION
END;
GO


-- Create Trigger that: If the Dependent is a Female: only use Daughter, Wife
-- The Dependent is a Male: only use Son, Husband
-- Spouse is used for both genders
-- Only for the inserted value -> USE INSERTED 
CREATE TRIGGER trg_Dependent
ON Dependent
FOR INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED WHERE Sex = 'F' AND Relationship NOT IN ('Daughter', 'Wife', 'Spouse'))
    BEGIN
        RAISERROR('Error: Female Dependent must be Daughter, Wife', 16, 1)
        ROLLBACK TRANSACTION
    END

ELSE
    IF EXISTS (SELECT * FROM INSERTED WHERE Sex = 'M' AND Relationship NOT IN ('Son', 'Husband', 'Spouse'))
        BEGIN
            RAISERROR('Error: Male Dependent must be Son, Husband', 16, 1)
            ROLLBACK TRANSACTION
        END
GO
    
