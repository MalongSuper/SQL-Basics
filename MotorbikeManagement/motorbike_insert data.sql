USE [QUANLYTHUEXE]
GO
INSERT [dbo].[Xe] ([maxe], [tenxe]) VALUES (N'X01', N'Toyota Vios')
GO
INSERT [dbo].[Xe] ([maxe], [tenxe]) VALUES (N'X02', N'Toyota Camry')
GO
INSERT [dbo].[Xe] ([maxe], [tenxe]) VALUES (N'X03', N'Hyundai i10 2024')
GO
INSERT [dbo].[Xe] ([maxe], [tenxe]) VALUES (N'X04', N'Hyundai Venue 2023')
GO
INSERT [dbo].[Xe] ([maxe], [tenxe]) VALUES (N'X05', N'Ford Everest')
GO
INSERT [dbo].[Khachhang] ([makhach], [hoten]) VALUES (N'KH01', N'Bùi Thu Hà')
GO
INSERT [dbo].[Khachhang] ([makhach], [hoten]) VALUES (N'KH02', N'Nguyễn Hải Hà')
GO
INSERT [dbo].[Hopdongthuexe] ([mahopdong], [ngaythue], [makhach]) VALUES (N'HD0001', CAST(N'2025-02-01' AS Date), N'KH01')
GO
INSERT [dbo].[Hopdongthuexe] ([mahopdong], [ngaythue], [makhach]) VALUES (N'HD0002', CAST(N'2025-03-07' AS Date), N'KH02')
GO
INSERT [dbo].[Chitiethopdong] ([mahopdong], [maxe], [ngaynhan], [ngaytra], [giathue]) VALUES (N'HD0001', N'X01', CAST(N'2025-02-03' AS Date), CAST(N'2025-02-06' AS Date), 3000000)
GO
INSERT [dbo].[Chitiethopdong] ([mahopdong], [maxe], [ngaynhan], [ngaytra], [giathue]) VALUES (N'HD0001', N'X02', CAST(N'2025-02-03' AS Date), CAST(N'2025-02-06' AS Date), 3000000)
GO
INSERT [dbo].[Chitiethopdong] ([mahopdong], [maxe], [ngaynhan], [ngaytra], [giathue]) VALUES (N'HD0001', N'X03', CAST(N'2025-02-04' AS Date), CAST(N'2025-02-06' AS Date), 2000000)
GO
INSERT [dbo].[Chitiethopdong] ([mahopdong], [maxe], [ngaynhan], [ngaytra], [giathue]) VALUES (N'HD0002', N'X01', CAST(N'2025-03-08' AS Date), CAST(N'2025-03-09' AS Date), 1000000)
GO
INSERT [dbo].[Chitiethopdong] ([mahopdong], [maxe], [ngaynhan], [ngaytra], [giathue]) VALUES (N'HD0002', N'X04', CAST(N'2025-03-10' AS Date), CAST(N'2025-03-31' AS Date), 15000000)
GO
