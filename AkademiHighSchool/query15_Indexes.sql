USE AkademiHighSchool;
GO

-- This code raises error
CREATE CLUSTERED INDEX idx_Student_StudentID ON Student(StudentID);
GO

-- This code raises error
CREATE CLUSTERED INDEX idx_Student_StudentID ON Student(LName);
GO

CREATE NONCLUSTERED INDEX idx_Student_ClubNo ON Student(ClubNo);
GO

CREATE NONCLUSTERED INDEX idx_Class_ClassName ON Class(ClassName);
GO

CREATE NONCLUSTERED INDEX idx_Scholarship_ScholarshipType ON Scholarship(ScholarshipType);
GO
