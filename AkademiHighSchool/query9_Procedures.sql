USE AkademiHighSchool;
GO

-- Procedure: The input is the StudentID, and the Output is the full name and the Average grade
CREATE PROCEDURE proc_StudentAVGGrade
@StudentID VARCHAR(4)
AS
BEGIN
    DECLARE @StudentName VARCHAR(100), @AVGGrade NUMERIC(2, 1)
    SET @StudentName = (SELECT FName + ' ' + LName FROM Student WHERE StudentID = @StudentID)
    SET @AVGGrade = (SELECT AVG(Grade) FROM StudentGrade WHERE StudentID = @StudentID)
    PRINT 'Student Name:' + ' ' + CONVERT(VARCHAR, @StudentName)
    PRINT 'Average Grade:' + ' ' + CONVERT(VARCHAR, @AVGGrade)
END;
GO


-- Procedure: The input is the ClubID, return the ClubName, the number of members, and the club leader name
CREATE PROCEDURE proc_ClubInfo
@ClubID VARCHAR(4)
AS
BEGIN
    DECLARE @ClubName VARCHAR(25), @NumofMembers INT, @ClubLeaderName VARCHAR(100), @MemberName VARCHAR(100)
    SET @ClubName = (SELECT ClubName FROM Club WHERE ClubID = @ClubID)
    SET @NumofMembers = (SELECT COUNT(s.StudentID) FROM Student s 
    JOIN Club c ON c.ClubID = s.ClubNo WHERE c.ClubID = @ClubID)
    SET @ClubLeaderName = (SELECT FName + ' ' + LName FROM Student 
    WHERE StudentID IN (SELECT ClubLeaderID FROM Club WHERE ClubID = @ClubID))
    PRINT 'Club:' + ' ' + CONVERT(VARCHAR, @ClubName)
    PRINT 'Club Leader:' + ' ' + CONVERT(VARCHAR, @ClubLeaderName)
    PRINT 'Number of Members:' + ' ' + CONVERT(VARCHAR, @NumofMembers)
END;
GO


-- Procedure using cursor, the input is the clubid, return the member list, marked club leaders as (c)
CREATE PROCEDURE proc_ClubStudentInfo
@ClubID VARCHAR(4)
AS
BEGIN
    DECLARE @ClubName VARCHAR(25), @ClubLeaderID VARCHAR(4), 
    @Member VARCHAR(100), @StudentID VARCHAR(4), @FName VARCHAR(50), @LName VARCHAR(50)

    SET @ClubLeaderID = (SELECT ClubLeaderID FROM Club WHERE ClubID = @ClubID)
    SET @ClubName = (SELECT ClubName FROM Club WHERE ClubID = @ClubID)
    PRINT 'Club ID:' + ' ' + CONVERT(VARCHAR, @ClubID)
    PRINT 'Club Name:' + ' ' + CONVERT(VARCHAR, @ClubName)

    
    DECLARE clubmember_cursor CURSOR FOR SELECT StudentID, FName, LName FROM Student WHERE ClubNo = @ClubID
    OPEN clubmember_cursor
    FETCH NEXT FROM clubmember_cursor INTO @StudentID, @FName, @LName
    WHILE @@FETCH_STATUS = 0
    BEGIN

        IF @StudentID = @ClubLeaderID
            SET @Member = @FName + ' ' + @LName + ' (c)'
        ELSE 
            SET @Member = @FName + ' ' + @LName
        
        PRINT 'Student ID:' + ' ' + CONVERT(VARCHAR, @StudentID) + ', ' + CONVERT(VARCHAR, @Member)
        FETCH NEXT FROM clubmember_cursor INTO @StudentID, @FName, @LName
    END
    CLOSE clubmember_cursor
    DEALLOCATE clubmember_cursor
END;
GO

-- Procedure using Cursor: Return every club, and the member list, marked club leaders as (c)
-- Use a nested cursor
CREATE PROCEDURE proc_AllClubInfo
AS
BEGIN
    DECLARE @ClubID VARCHAR(4), @ClubName VARCHAR(25), 
    @ClubLeaderID VARCHAR(4), @Member VARCHAR(100), @StudentID VARCHAR(4), @FName VARCHAR(50), @LName VARCHAR(50)
    DECLARE club_cursor CURSOR FOR SELECT ClubID, ClubName, ClubLeaderID FROM Club
    OPEN club_cursor
    FETCH NEXT FROM club_cursor INTO @ClubID, @ClubName, @ClubLeaderID
    WHILE @@FETCH_STATUS = 0
    BEGIN 
        PRINT 'Club ID:' + ' ' + CONVERT(VARCHAR, @ClubID)
        PRINT 'Club Name:' + ' ' + CONVERT(VARCHAR, @ClubName)

        -- A nested cursor to return the member of each club
        DECLARE member_cursor CURSOR FOR SELECT StudentID, FName, LName FROM Student WHERE ClubNo = @ClubID
        OPEN member_cursor
        FETCH NEXT FROM member_cursor INTO @StudentID, @FName, @LName
        WHILE @@FETCH_STATUS = 0
        BEGIN 
            IF @StudentID = @ClubLeaderID
                SET @Member = @FName + ' ' + @LName + ' (c)'
            ELSE
                SET @Member = @FName + ' ' + @LName

            PRINT 'Student ID:' + ' ' + CONVERT(VARCHAR, @StudentID) + ', ' + CONVERT(VARCHAR, @Member)
            FETCH NEXT FROM member_cursor INTO @StudentID, @FName, @LName
        END

        CLOSE member_cursor
        DEALLOCATE member_cursor

        PRINT ' '

        FETCH NEXT FROM club_cursor INTO @ClubID, @ClubName, @ClubLeaderID

    END
    CLOSE club_cursor
    DEALLOCATE club_cursor
END;
GO


-- IF ELSE with Stored Procedure
-- Input: StudentID, Output is the Student FullName and the ClubName, return "Clubless" if the student has no club
CREATE PROCEDURE proc_StudentClub
@StudentID VARCHAR(4)
AS
BEGIN
    DECLARE @FullName VARCHAR(100), @ClubName VARCHAR(25)
    SET @FullName = (SELECT FName + ' ' + LName FROM Student WHERE StudentID = @StudentID)
    SET @ClubName = (SELECT ClubName FROM Club c JOIN Student s ON c.ClubID = s.ClubNo WHERE StudentID = @StudentID)
    IF @ClubName IS NULL
        SET @ClubName = 'Clubless'
    PRINT 'Student Name:' + ' ' + @FullName
    PRINT 'Club:' + ' ' + @ClubName
END;
GO


-- Procedure: Input is the studentid, return the classname and the teacher
CREATE PROCEDURE proc_StudentClass
@StudentID VARCHAR(4)
AS
BEGIN
    DECLARE @FullName VARCHAR(100), @ClassName VARCHAR(3), @TeacherName VARCHAR(100)
    SET @FullName = (SELECT FName + ' ' + LName FROM Student WHERE StudentID = @StudentID)
    
    SELECT @ClassName = c.ClassName, @TeacherName = t.FName + ' ' + t.LName FROM Class c
    JOIN TeachingStaff t ON t.StaffID = c.TeacherID
    JOIN Student s ON s.ClassNo = c.ClassID WHERE StudentID = @StudentID

    PRINT 'Student Name:' + ' ' + @FullName
    PRINT 'Class:' + ' ' + @ClassName
    PRINT 'Teacher Name:' + ' ' + @TeacherName

END;
GO

-- Procedure: Input is StudentID, return the name and True if the student or a teacher is a rival
CREATE PROCEDURE proc_isrival
@ID VARCHAR(4)
AS
BEGIN 
    DECLARE @Name VARCHAR(100)

    IF @ID IN (SELECT StudentID FROM Student WHERE StudentID = @ID)
        BEGIN
        SET @Name = (SELECT FName + ' ' + LName FROM Student WHERE StudentID = @ID)
        PRINT 'Student Name:' + ' ' + @Name
        IF @ID IN (SELECT StudentID FROM Student WHERE StudentID = @ID AND MainPersona = 'Lovestruck')
            BEGIN
                PRINT 'Rival: TRUE'
            END
        ELSE PRINT 'Rival: FALSE'
        END

    ELSE IF @ID IN (SELECT StaffID FROM TeachingStaff WHERE StaffID = @ID)
        BEGIN
            SET @Name = (SELECT FName + ' ' + LName FROM TeachingStaff WHERE StaffID = @ID)
            PRINT 'Teacher Name:' + ' ' + @Name
            IF @ID IN (SELECT StaffID FROM TeachingStaff WHERE StaffID = @ID AND MainPersona = 'Lovestruck')
            BEGIN
                PRINT 'Rival: TRUE'
            END
        ELSE PRINT 'Rival: FALSE'
        END
END;
GO


-- Input is the StudentID, return the student's subject score, and the GradeLevel for each subject
-- If Grade >= 8.0 -> A; If Grade >= 6.5 -> B; If Grade >= 4.0 -> C; If Grade < 4.0 -> D
CREATE PROCEDURE proc_studentgradelevel
@StudentID VARCHAR(4)
AS 
BEGIN  
    DECLARE @StudentName VARCHAR(100), @Grade NUMERIC(2, 1), @SubjectName VARCHAR(50), @GradeLevel VARCHAR(1)
    SET @StudentName = (SELECT FName + ' ' + LName FROM Student WHERE StudentID = @StudentID)
    PRINT 'Student Name:' + ' ' + CONVERT(VARCHAR, @StudentName)

    DECLARE gradelevel_cursor CURSOR 
    FOR (SELECT sg.Grade, st.SubjectName,
    CASE 
        WHEN sg.Grade >= 8.0 THEN 'A'
        WHEN sg.Grade >= 6.5 THEN 'B'
        WHEN sg.Grade >= 4.0 THEN 'C'
        WHEN sg.Grade < 4.0 THEN 'D'
        ELSE 'F'
    END AS GradeLevel
    FROM StudentGrade sg 
    JOIN Subject st ON sg.SubjectID = st.SubjectID WHERE StudentID = @StudentID)

    OPEN gradelevel_cursor
    FETCH NEXT FROM gradelevel_cursor INTO @Grade, @SubjectName, @GradeLevel

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT CONVERT(VARCHAR, @SubjectName) + ': ' + CONVERT(VARCHAR, @Grade) + ' (' + CONVERT(VARCHAR, @GradeLevel) + ') '
        FETCH NEXT FROM gradelevel_cursor INTO @Grade, @SubjectName, @GradeLevel
    END

    CLOSE gradelevel_cursor
    DEALLOCATE gradelevel_cursor
END;
GO 

SELECT sg.Grade, st.SubjectName FROM StudentGrade sg JOIN Subject st ON sg.SubjectID = st.SubjectID




EXEC proc_StudentClub 'S101';
GO

EXEC proc_StudentClub 'S119';
GO

EXEC proc_ClubInfo 'B001';
GO


EXEC proc_StudentAVGGrade 'S101';
GO

EXEC proc_StudentAVGGrade 'S111';
GO

EXEC proc_ClubStudentInfo 'B005';
GO

EXEC proc_AllClubInfo;
GO

EXEC proc_StudentClass 'S101';
GO

EXEC proc_isrival 'S119';
GO

EXEC proc_isrival 'T001';
GO

EXEC proc_studentgradelevel 'S118';
GO

EXEC proc_studentgradelevel 'S117';
GO



SELECT * FROM TeachingStaff

DROP PROCEDURE proc_ClubStudentInfo 
DROP PROCEDURE proc_AllClubInfo
DROP PROCEDURE proc_StudentClub;
DROP PROCEDURE proc_StudentClass;
DROP PROCEDURE proc_isrival;
DROP PROCEDURE proc_studentgradelevel;
GO


