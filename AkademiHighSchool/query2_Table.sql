USE AkademiHighSchool;
GO

-- Create Table
CREATE TABLE Student (
    StudentID VARCHAR(4) NOT NULL,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    ClassNo VARCHAR(4) NOT NULL,
    ClubNo VARCHAR(4) NOT NULL,
    Strength VARCHAR(50) NOT NULL,
    MainPersona VARCHAR(25) NOT NULL
);
GO


CREATE TABLE Class (
    ClassID VARCHAR(4) NOT NULL,
    ClassName VARCHAR(3) NOT NULL,
    TeacherID VARCHAR(4) NOT NULL
);
GO




CREATE TABLE Club (
    ClubID VARCHAR(4) NOT NULL,
    ClubName VARCHAR(25) NOT NULL,
    ClubLeaderID VARCHAR(4) NOT NULL
);
GO

CREATE TABLE Preference (
    StudentID VARCHAR(4) NOT NULL,
    StudentLike VARCHAR(25) NOT NULL,
    StudentDislike VARCHAR(25) NOT NULL
);
GO


CREATE TABLE TeachingStaff (
    StaffID VARCHAR(4) NOT NULL,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    MainRole VARCHAR(25) NOT NULL,
    Strength VARCHAR(50) NOT NULL,
    MainPersona VARCHAR(25) NOT NULL
);
GO

CREATE TABLE Subject (
    SubjectID VARCHAR(4) NOT NULL,
    SubjectName VARCHAR(50) NOT NULL
);
GO


CREATE TABLE StudentGrade (
    StudentID VARCHAR(4) NOT NULL,
    SubjectID VARCHAR(4) NOT NULL,
    Grade INT
);
GO



-- Drop table
DROP TABLE Preference;
GO


