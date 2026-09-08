INSERT INTO Project(PName, PNumber, PLocation) VALUES ('ProjectExtra', 40, 'Stafford');
UPDATE Project SET DNum = 4 WHERE PNumber = 40
SELECT PNumber FROM Project
EXCEPT
SELECT PNo FROM Works_On;
GO
