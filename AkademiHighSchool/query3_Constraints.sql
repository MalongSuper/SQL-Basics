USE AkademiHighSchool;
GO

-- Insert new columns

ALTER TABLE Student
ADD Birthday DATE NOT NULL,
    Gender VARCHAR(1) NOT NULL;
GO


-- Change data type of a column
ALTER TABLE StudentGrade
ALTER COLUMN Grade NUMERIC(2, 1);
GO

-- Alter column ClubNo to accept NULL
ALTER TABLE Student
ALTER COLUMN ClubNo VARCHAR(4) NULL;
GO

ALTER TABLE Club
ALTER COLUMN ClubLeaderID VARCHAR(4) NULL;
GO

ALTER TABLE TeachingStaff 
ADD CONSTRAINT pk_staffid PRIMARY KEY (StaffID),
    CONSTRAINT chk_staffid CHECK (StaffID LIKE 'T[0-9][0-9][0-9]'),
    CONSTRAINT chk_teachermainpersona DEFAULT 'Strict' FOR MainPersona,
    CONSTRAINT df_staffrole DEFAULT 'Teacher' FOR MainRole;
GO

ALTER TABLE Class
ADD CONSTRAINT pk_classid PRIMARY KEY (ClassID),
    CONSTRAINT chk_classid CHECK (ClassID LIKE 'C[0-9][0-9][0-9]'),
    CONSTRAINT chk_classteacherid CHECK (TeacherID LIKE 'T[0-9][0-9][0-9]'),
    CONSTRAINT chk_classname CHECK (ClassName LIKE '[123]-[0-9]'),
    CONSTRAINT uq_classname UNIQUE (ClassName),
    CONSTRAINT fk_teacherid FOREIGN KEY (TeacherID) REFERENCES TeachingStaff(StaffID);
GO



ALTER TABLE Student
ADD CONSTRAINT pk_studentid PRIMARY KEY (StudentID),
    CONSTRAINT chk_studentd CHECK (StudentID LIKE 'S[0-9][0-9][0-9]'),
    CONSTRAINT chk_classno CHECK (ClassNo LIKE 'C[0-9][0-9][0-9]'),
    CONSTRAINT chk_studentclubid CHECK (ClubNo LIKE 'B[0-9][0-9][0-9]'),
    CONSTRAINT chk_gender CHECK (Gender IN ('F', 'M')),
    CONSTRAINT df_gender DEFAULT 'F' FOR Gender,
    CONSTRAINT df_studentmainpersona DEFAULT 'Normal' FOR MainPersona,
    CONSTRAINT fk_classno FOREIGN KEY (ClassNo) REFERENCES Class(ClassID),
    CONSTRAINT fk_studentclubid FOREIGN KEY (ClubNo) REFERENCES Club(ClubID);
GO


ALTER TABLE Club
ADD CONSTRAINT pk_clubid PRIMARY KEY (ClubID),
    CONSTRAINT chk_clubid CHECK (ClubID LIKE 'B[0-9][0-9][0-9]'),
    CONSTRAINT chk_clubleaderid CHECK (ClubLeaderID LIKE 'S[0-9][0-9][0-9]'),
    CONSTRAINT uq_clubname UNIQUE (ClubName),
    CONSTRAINT fk_clubleaderid FOREIGN KEY (ClubLeaderID) REFERENCES Student(StudentID);
GO


ALTER TABLE Subject
ADD CONSTRAINT pk_subjectid PRIMARY KEY (SubjectID),
    CONSTRAINT chk_subjectid CHECK (SubjectID LIKE 'ST[0-9][0-9]'),
    CONSTRAINT uq_subjectname UNIQUE (SubjectName);
GO

ALTER TABLE StudentGrade
ADD CONSTRAINT pk_studentsubjectid PRIMARY KEY (SubjectID, StudentID),
    CONSTRAINT chk_studengradetid CHECK (StudentID LIKE 'S[0-9][0-9][0-9]'),
    CONSTRAINT chk_subjectgradeid CHECK (SubjectID LIKE 'ST[0-9][0-9]'), 
    CONSTRAINT chk_grade CHECK (Grade >= 0 AND Grade <= 10),
    CONSTRAINT df_grade DEFAULT 0.0 FOR Grade,
    CONSTRAINT fk_studentgradeid FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    CONSTRAINT fk_subjectid FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID);
GO


ALTER TABLE student
ADD CONSTRAINT df_birthday DEFAULT GETDATE() FOR Birthday;
GO