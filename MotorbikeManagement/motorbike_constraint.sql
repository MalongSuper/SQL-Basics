CREATE DATABASE QUANLYTHUEXE
GO
USE QUANLYTHUEXE
GO
-----
CREATE TABLE Xe
(maxe CHAR(3) NOT NULL, 
tenxe NVARCHAR(50) NOT NULL
)
GO
CREATE TABLE Khachhang
(makhach CHAR(4) NOT NULL, 
hoten  NVARCHAR(50) NOT NULL)
GO
CREATE TABLE Hopdongthuexe
(mahopdong CHAR(6) NOT NULL, 
ngaythue DATE NOT NULL, 
makhach CHAR(4) NOT NULL
)
GO
CREATE TABLE Chitiethopdong(
mahopdong CHAR(6) NOT NULL, 
maxe CHAR(3) NOT NULL,
ngaynhan DATE NOT NULL, 
ngaytra DATE  NOT NULL, 
giathue INT  NOT NULL
)

-----
ALTER TABLE xe
ADD CONSTRAINT PK_maxe PRIMARY KEY (maxe)
GO

ALTER TABLE Khachhang
ADD CONSTRAINT PK_makhach PRIMARY KEY (makhach)
GO

GO
ALTER TABLE Hopdongthuexe
ADD CONSTRAINT PK_mahopdong PRIMARY KEY (mahopdong)
GO

GO
ALTER TABLE Chitiethopdong
ADD CONSTRAINT PK_mahopdong_maxe PRIMARY KEY (mahopdong, maxe)

GO
---
ALTER TABLE Hopdongthuexe
ADD CONSTRAINT FK_makhach FOREIGN KEY (makhach) REFERENCES Khachhang(makhach) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE Chitiethopdong
ADD CONSTRAINT FK_mahopdong FOREIGN KEY (mahopdong) REFERENCES Hopdongthuexe(mahopdong) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
ALTER TABLE Chitiethopdong
ADD CONSTRAINT FK_maxe FOREIGN KEY (maxe) REFERENCES xe(maxe) ON DELETE NO ACTION ON UPDATE NO ACTION
GO
---
ALTER TABLE Chitiethopdong
ADD CONSTRAINT CK_ngaynhan_ngaytra CHECK (ngaynhan <= ngaytra)
GO

ALTER TABLE Chitiethopdong
ADD CONSTRAINT CK_giathue CHECK (giathue>=500000)
GO 
ALTER TABLE Hopdongthuexe
ADD CONSTRAINT DF_ngaythue DEFAULT GETDATE() FOR ngaythue