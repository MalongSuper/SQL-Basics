USE [AttendanceManagement]
GO

-- Insert departments
INSERT INTO [dbo].[Department] ([department_id], [department_name]) VALUES (N'P02', N'Production Department')
GO
INSERT INTO [dbo].[Department] ([department_id], [department_name]) VALUES (N'P01', N'Purchasing Department')
GO

-- Insert employees
INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV01', N'Huỳnh Thị Thúy Anh', 7000000, N'P01')
GO
INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV02', N'Lương Thị Thanh Bình', 7500000, N'P01')
GO
INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV03', N'Trần Thị Kim Duyên', 8000000, N'P02')
GO
INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV04', N'Trần Thụy Phương Đài', 7000000, N'P02')
GO
INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV05', N'Bùi Thu Hà', 7500000, N'P02')
GO
INSERT INTO [dbo].[Employee] ([employee_id], [full_name], [base_salary], [department_id]) VALUES (N'NV06', N'Nguyễn Hải Hà', 8200000, N'P02')
GO

-- Insert attendance sheets
INSERT INTO [dbo].[AttendanceSheet] ([sheet_id], [month], [department_id]) VALUES (N'B01', N'01/2025', N'P01')
GO
INSERT INTO [dbo].[AttendanceSheet] ([sheet_id], [month], [department_id]) VALUES (N'B02', N'01/2025', N'P02')
GO
INSERT INTO [dbo].[AttendanceSheet] ([sheet_id], [month], [department_id]) VALUES (N'B03', N'02/2025', N'P01')
GO
INSERT INTO [dbo].[AttendanceSheet] ([sheet_id], [month], [department_id]) VALUES (N'B04', N'02/2025', N'P02')
GO

-- Insert attendance records
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV01', N'B01', 20)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV01', N'B03', 24)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV02', N'B01', 21)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV02', N'B03', 26)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV03', N'B02', 23)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV03', N'B04', 23)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV04', N'B02', 24)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV04', N'B04', 22)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV05', N'B02', 26)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV05', N'B04', 23)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV06', N'B02', 25)
GO
INSERT INTO [dbo].[Attendance] ([employee_id], [sheet_id], [working_days]) VALUES (N'NV06', N'B04', 24)
GO
