CREATE DATABASE GradeManagement
GO

USE GradeManagement
GO

-- Create Monhoc (Subject)
CREATE TABLE Subject (
    SubjectCode CHAR(9) NOT NULL, 
    SubjectName NVARCHAR(50) NOT NULL
)
GO

-- Create Lop (Class)
CREATE TABLE Class (
    ClassCode CHAR(12) NOT NULL, 
    SubjectCode CHAR(9) NOT NULL, 
    Semester CHAR(5) NOT NULL, 
    Lecturer NVARCHAR(50) NOT NULL
)
GO

-- Create Sinhvien (Student)
CREATE TABLE Student (
    StudentID CHAR(7) NOT NULL, 
    FullName NVARCHAR(50) NOT NULL, 
    Major CHAR(4) NOT NULL
)
GO

-- Create Hoc (Enrollment)
CREATE TABLE Enrollment (
    StudentID CHAR(7) NOT NULL, 
    ClassCode CHAR(12) NOT NULL, 
    Grade DECIMAL(5,2) NOT NULL
)
GO

-- Primary Keys and Unique Constraints
ALTER TABLE Subject
ADD CONSTRAINT PK_SubjectCode PRIMARY KEY (SubjectCode)
GO

ALTER TABLE Subject
ADD CONSTRAINT UQ_SubjectName UNIQUE (SubjectName)
GO

ALTER TABLE Class
ADD CONSTRAINT PK_ClassCode PRIMARY KEY (ClassCode)
GO

ALTER TABLE Student
ADD CONSTRAINT PK_StudentID PRIMARY KEY (StudentID)
GO

ALTER TABLE Enrollment
ADD CONSTRAINT PK_StudentID_ClassCode PRIMARY KEY (StudentID, ClassCode)
GO

-- Foreign Keys
ALTER TABLE Class
ADD CONSTRAINT FK_Class_SubjectCode FOREIGN KEY (SubjectCode) REFERENCES Subject(SubjectCode) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE Enrollment
ADD CONSTRAINT FK_Enrollment_StudentID FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE Enrollment
ADD CONSTRAINT FK_Enrollment_ClassCode FOREIGN KEY (ClassCode) REFERENCES Class(ClassCode) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- Check Constraints
ALTER TABLE Enrollment
ADD CONSTRAINT CK_Grade CHECK (Grade >= 0 AND Grade <= 10)
GO

ALTER TABLE Subject
ADD CONSTRAINT CK_SubjectCode CHECK (SubjectCode LIKE '[A-Z][A-Z][0-9][0-9][0-9]D[VE][0-9][0-9]')
GO

ALTER TABLE Student
ADD CONSTRAINT CK_StudentID CHECK (StudentID LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
GO


ALTER TABLE Class
ADD CONSTRAINT CK_ClassCode CHECK (ClassCode LIKE '[A-Z][A-Z][0-9][0-9][0-9]D[VE][0-9][0-9]_[0-9][0-9]')
GO

ALTER TABLE Class
ADD CONSTRAINT CK_Semester CHECK (Semester LIKE '[0-9][0-9].[12][AB]')
GO


-- Default Value
ALTER TABLE Student
ADD CONSTRAINT DF_Major DEFAULT 'CNTT' FOR Major
GO

ALTER TABLE Enrollment
ADD CONSTRAINT DF_Grade DEFAULT 5 FOR Grade
GO

DROP DATABASE GradeManagement
GO


