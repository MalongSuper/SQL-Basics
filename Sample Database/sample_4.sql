-- INIT database
CREATE TABLE Teacher (
  Account VARCHAR(9) PRIMARY KEY,
  Name VARCHAR(50) NOT NULL,
  Password VARBINARY(64) NOT NULL,
  CONSTRAINT chk_Account_format CHECK(Account LIKE '123[0-9][0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE SchoolLevel (
  SubjectID VARCHAR(10) PRIMARY KEY,
  Grade INT NOT NULL,
  SubjectName VARCHAR(50) NOT NULL,
  CONSTRAINT chk_Grade CHECK(Grade <= 12),
  CONSTRAINT chk_SubjectID_format CHECK(SubjectID LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Test (
  TestID VARCHAR(5) PRIMARY KEY,
  TestName VARCHAR(50) NOT NULL,
  NumberofQuestions INT NOT NULL, 
  TestTime INT NOT NULL, 
  QuestionBank VARCHAR(10) NOT NULL,
  CONSTRAINT chk_QuestionBank_format CHECK(QuestionBank LIKE 'Click Here'),
  CONSTRAINT chk_TestID_format CHECK(TestID LIKE '[0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Question (
  QuestionNumber VARCHAR(3) PRIMARY KEY,
  Content VARCHAR(50) NOT NULL,
  Detail VARCHAR(10) NOT NULL,
  CONSTRAINT chk_QuestionNumber_format CHECK(QuestionNumber LIKE 'Q[0-9][0-9]'),
);

CREATE TABLE QuestionDetail (
  Number VARCHAR(3) PRIMARY KEY,
  QuestionDetail VARCHAR(100) NOT NULL,
  QuestionTeacher INT NOT NULL
);
  
-- Employee Table
INSERT INTO Teacher(Account, Name, Password) VALUES ('123916405', 'Ho Thi My Linh', HASHBYTES('SHA2_256', 'Linh123'));
INSERT INTO Teacher(Account, Name, Password) VALUES ('123916443', 'Tran Thi Kim Ngan', HASHBYTES('SHA2_256', 'Ngan123'));
INSERT INTO Teacher(Account, Name, Password) VALUES ('123916530', 'Ho Quang Hai', HASHBYTES('SHA2_256', 'Hai25012'));
INSERT INTO Teacher(Account, Name, Password) VALUES ('123916579', 'Le Duc Anh', HASHBYTES('SHA2_256', 'DucAnh1102'));
INSERT INTO Teacher(Account, Name, Password) VALUES ('123916453', 'Nguyen Thi Huyen', HASHBYTES('SHA2_256', 'Huyen91'));
-- Grade Table
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('MAT0639112', 'Math', 6);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('MAT0739214', 'Math', 7);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('MAT0839423', 'Math', 8);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('MAT0939724', 'Math', 9);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('MAT1039928', 'Math', 10);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('MAT1139824', 'Math', 11);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('MAT1283841', 'Math', 12);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('ENG0634214', 'English', 6);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('ENG0734216', 'English', 7);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('ENG0834218', "English", 8);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('ENG0934219', 'English', 9);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('ENG1034221', 'English', 10);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('ENG1134222', 'English', 11);
INSERT INTO SchoolLevel(SubjectID, SubjectName, Grade) VALUES ('ENG1234225', 'English', 12);
-- Test Table
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('09124', 'Math Practice Quiz 1', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('09126', 'Math Practice Quiz 2', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('09131', 'Math Mid-Term Exam', 50, 90, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('10193', 'Math Practice Quiz 1', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('10211', 'Math Practice Quiz 2', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('10434', 'Math Mid-Term Exam', 50, 90, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('11296', 'Math Practice Quiz 1', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('11193', 'Math Practice Quiz 2', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('11299', 'Math Mid-Term Exam', 50, 90, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('12106', 'Math Practice Quiz 2', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('12393', 'Math Practice Quiz 1', 25, 60, "Click Here")
INSERT INTO Test(TestID, TestName, NumberofQuestions, TestTime, QuestionBank) VALUES ('12879', 'Math Mid-Term Exam', 50, 90, "Click Here")
-- Question Table
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q01', 'Subtraction', '200 - 120')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q02', 'Subtraction', '134 - 111')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q03', 'Addition', '135 + 432')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q04', 'Subtraction', '230 - 123')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q05', 'Divide', '200 / 10')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q06', 'Addition', '193 + 132')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q07', 'Addition', '194 + 193')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q08', 'Subtraction', '183 - 312')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q09', 'Divide', '104 / 91')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q10', 'Multiply', '193 * 49')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q11', 'Multiply', '194 * 32')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q12', 'Multiply', '124 * 88')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q13', 'Multiply', '134 * 43')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q14', 'Divide', '124 / 19')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q15', 'Multiply', '124 * 99')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q16', 'Addition', '124 + 134')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q17', 'Multiply', '123 * 34')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q18', 'Divide', '199 / 98')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q19', 'Multiply', '123 * 88')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q20', 'Addition', '144 + 322')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q21', 'Addition', '234 + 124')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q22', 'Multiply', '124 * 43')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q23', 'Subtraction', '234 - 134')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q24', 'Subtraction', '412 - 233')
INSERT INTO Question(QuestionNumber, Content, Detail) VALUES ('Q25', 'Divide', '122 / 21')
-- Question Detail Table
INSERT INTO QuestionDetail(Number, QuestionDetail, QuestionTeacher) Select QuestionNumber, Detail, '123916443' from Question

-- QUERY database
SELECT * FROM Teacher WHERE Account = '123916443'
SELECT SubjectID, SubjectName, Grade FROM SchoolLevel WHERE Grade > 9
SELECT * FROM Test WHERE TestID LIKE '09%'   
SELECT QuestionNumber, Content, 'Click here for more detail' as Detail FROM Question
SELECT Number, QuestionDetail, 'A' as [Option1], 'B' as [Option2], 'C' as [Option3], 'D' as [Option4], 
t.Name as QuestionTeacher, 'Tran Quang Tien' as QuestionApprover FROM QuestionDetail qd
JOIN Teacher t ON qd.QuestionTeacher = t.Account