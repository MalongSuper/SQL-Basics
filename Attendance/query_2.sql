USE Attendence -- This line tells the system to do 
-- whatever table you create or values you insert to the Attendence database
-- NVARCHAR accepts non-English name
CREATE TABLE Subject (
    SubjectId VARCHAR(9) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    CONSTRAINT chk_SubjectId CHECK(SubjectId LIKE '[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO 

CREATE TABLE Class (
    ClassId VARCHAR(12) PRIMARY KEY,
    Instructor NVARCHAR(50) NOT NULL,
    Semester VARCHAR(5),
    CONSTRAINT chk_ClassId CHECK(ClassId LIKE '[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]_[0-9][0-9]')
)
GO

CREATE TABLE Student (
    StudentId VARCHAR(9) PRIMARY KEY,
    LName NVARCHAR(50) NOT NULL,
    FName NVARCHAR(50) NOT NULL,
    CONSTRAINT chk_StudentId CHECK(StudentId LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
GO

CREATE TABLE ClassDay (
    ClassNumber TINYINT NOT NULL,
    ClassId VARCHAR(12) NOT NULL,
    ClassDate DATE NOT NULL,
    ClassTime TIME NOT NULL,
    NumberofPeriods TINYINT NOT NULL,
    CONSTRAINT chk_ClassNumber CHECK(ClassNumber >= 1),
    CONSTRAINT chk_NumberofPeriods CHECK(NumberofPeriods >= 1),
)
GO

CREATE TABLE Participate (
    StudentId VARCHAR(9) NOT NULL,
    ClassNumber TINYINT NOT NULL,
    AbsenceDetail VARCHAR(50) NOT NULL,
)
GO
