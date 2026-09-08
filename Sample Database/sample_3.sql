-- INIT database
CREATE TABLE StudentAccount (
  StudentID INT IDENTITY(100001, 1) PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  Grade INT NOT NULL CHECK(Grade > 0 and Grade <= 12),
  Email VARCHAR(50) NOT NULL,
  Password VARBINARY(64) NOT NULL
);

CREATE TABLE Subject(
  SubjectID VARCHAR(7) PRIMARY KEY,
  SubjectName VARCHAR(50) NOT NULL,
  Grade INT NOT NULL,
  CONSTRAINT chk_Grade CHECK(Grade > 0 and Grade <= 12),
  CONSTRAINT chk_SubjectID_format CHECK (SubjectID LIKE '[A-Z][A-Z][A-Z][1][0-2][0-9][0-9]')
);

CREATE TABLE Test(
  TestID VARCHAR(12) PRIMARY KEY,
  SubjectID VARCHAR(7) NOT NULL,
  TestName VARCHAR(50) NOT NULL,
  TestTimeinMinutes INT NOT NULL,
  NumberofQuestions INT NOT NULL,
  CONSTRAINT chk_TestTimeinMinutes CHECK(TestTimeinMinutes > 0),
  CONSTRAINT chk_NumberofQuestions CHECK(NumberofQuestions > 0),
  CONSTRAINT chk_TestID_format CHECK(TestID LIKE 'TEST[1][0-2][0-9][0-9][0-9][0-9][0-9][0-9]'),
  FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID)
);
CREATE TABLE Answer(
  QuestionNumber INT IDENTITY(1, 1) PRIMARY KEY,
  StudentOption CHAR(1) CHECK(StudentOption IN ('A', 'B', 'C', 'D')),
  CorrectAnswer CHAR(1) CHECK(CorrectAnswer IN ('A', 'B', 'C', 'D')),
  Point INT CHECK(Point <= 1 and Point >= 0),
  Flag INT CHECK(Flag <= 1 and Flag >= 0)
);
  
  
CREATE TABLE Result(
  ResultID VARCHAR(10) PRIMARY KEY,
  StudentID INT NOT NULL,
  TestID VARCHAR(12) NOT NULL,
  CorrectAnswers INT NOT NULL,
  ExamDate DATE NOT NULL DEFAULT GETDATE(),
  CONSTRAINT chk_ResultID_format CHECK(ResultID LIKE 'RES[1][0-2][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT chk_CorrectAnswers CHECK(CorrectAnswers <= 40),
  FOREIGN KEY (StudentID) REFERENCES StudentAccount(StudentID),
  FOREIGN KEY (TestID) REFERENCES Test(TestID)
);
  

-- Student Account Table
INSERT INTO StudentAccount(FirstName, LastName, Grade, 
                           Email, Password) VALUES ('Mary O.', 'Cross', 
                                                       10, 'MaryCross1134@gmail.com', HASHBYTES('SHA2_256', 'MaryCross'));
INSERT INTO StudentAccount(FirstName, LastName, Grade, 
                           Email, Password) VALUES ('James M.', 'Watterson', 11, 'JamesWatterson24@gmail.com', HASHBYTES('SHA2_256', 'James123'));
INSERT INTO StudentAccount(FirstName, LastName, Grade, 
                           Email, Password) VALUES ('Adam S.', 'Smith', 12, 'AdamSmith1234@gmail.com', HASHBYTES('SHA2_256', 'SmithAD'));
-- Subject Table
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('MAT1029', 'Algebra', 10);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('MAT1121', 'Algebra', 11);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('MAT1233', 'Algebra', 12);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('ENG1031', 'English', 10);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('ENG1123', 'English', 11);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('ENG1235', 'English', 12);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('LIT1031', 'Literature', 10);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('LIT1123', 'Literature', 11);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('LIT1235', 'Literature', 12);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('PHY1031', 'Physics', 10);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('PHY1123', 'Physics', 11);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('PHY1235', 'Physics', 12);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('CHE1031', 'Chemistry', 10);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('CHE1123', 'Chemistry', 11);
INSERT INTO Subject(SubjectID, SubjectName, Grade) VALUES ('CHE1235', 'Chemistry', 12);

-- Test Table for Grade 10
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('MAT1029', 'TEST10231121', 
                                                                                            'Algebra Mid-Term Practice 1', 90, 20);
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('MAT1029', 'TEST10231323', 
                                                                                            'Algebra Mid-Term Practice 2', 90, 20);
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('MAT1029', 'TEST10230124', 
                                                                                            'Algebra Final-Term Practice 1', 90, 20)                                                                                      
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('ENG1031', 'TEST10233292', 
                                                                                            'English Mid-Term Practice 1', 60, 20);
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('ENG1031', 'TEST10233294', 
                                                                                            'English Mid-Term Practice 2', 60, 20);
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('MAT1121', 'TEST11231119', 
                                                                                            'Algebra Mid-Term Practice 1', 90, 20);
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('MAT1121', 'TEST11231323', 
                                                                                            'Algebra Mid-Term Practice 2', 90, 20);
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('MAT1121', 'TEST11230121', 
                                                                                            'Algebra Final-Term Practice 1', 90, 20);                                                                                   
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('ENG1123', 'TEST11233297', 
                                                                                            'English Mid-Term Practice 1', 60, 20);
INSERT INTO Test(SubjectID, TestID, TestName, TestTimeinMinutes, NumberofQuestions) VALUES ('ENG1123', 'TEST11233295', 
                                                                                            'English Mid-Term Practice 2', 60, 20);
--  Result
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('A', 'D', 1);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('B', 'D', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('C', 'C', 1);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('B', 'C', 1);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('A', 'A', 1);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('B', 'B', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('C', 'A', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('D', 'D', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('D', 'D', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('A', 'A', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('B', 'B', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('C', 'D', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('C', 'C', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('B', 'B', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('D', 'D', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('A', 'A', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('B', 'B', 1);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('A', 'A', 0);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('C', 'C', 1);
INSERT INTO Answer(StudentOption, CorrectAnswer, Flag) VALUES ('B', 'A', 0);

-- Exam Result
INSERT INTO Result(ResultID, StudentID, TestID, CorrectAnswers) VALUES ('RES1012912', 100001, 'TEST10231323', 14);


-- QUERY database
SELECT * FROM StudentAccount WHERE StudentID = 100001
SELECT * FROM Subject WHERE Grade = 10
SELECT TestID, TestName, TestTimeinMinutes, NumberofQuestions FROM Test WHERE SubjectID = 'MAT1029'
SELECT QuestionNumber, StudentOption, CorrectAnswer, CASE WHEN StudentOption = CorrectAnswer THEN 1 ELSE 0 END AS Point, Flag FROM Answer
-- Update CorrectAnswers in Result table
SELECT ResultID, StudentID, TestID, CorrectAnswers, CorrectAnswers * 0.5 AS Score, ExamDate FROM Result