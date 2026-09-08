USE Attendence
ALTER TABLE Class
ADD SubjectId VARCHAR(9) NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subject(SubjectId);
GO

ALTER TABLE ClassDay
ADD CONSTRAINT PK_ClassDay PRIMARY KEY(ClassNumber, ClassId),
    FOREIGN KEY (ClassId) REFERENCES Class(ClassId);
GO

ALTER TABLE Participate
ADD ClassId VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Participate PRIMARY KEY(StudentId, ClassNumber, ClassId),
    FOREIGN KEY (StudentId) REFERENCES Student(StudentId),
    FOREIGN KEY (ClassNumber, ClassId) REFERENCES ClassDay(ClassNumber, ClassId);
GO
