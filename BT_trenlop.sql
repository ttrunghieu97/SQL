USE master
GO
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'GiaoVu'
)
CREATE DATABASE GiaoVu
GO

USE GiaoVu

IF OBJECT_ID('[dbo].[GiangVien]', 'U') IS NOT NULL
DROP TABLE [dbo].[GiangVien]
GO

CREATE TABLE [dbo].[GiangVien]
(
    MaGV INT NOT NULL PRIMARY KEY, -- Primary Key column
    HoLot NVARCHAR(30) NOT NULL,
    Ten NVARCHAR(10) NOT NULL,
    DiaChi NVARCHAR(100) NOT NULL,
    Luong int,
);
GO

IF OBJECT_ID('[dbo].[HocPhan]', 'U') IS NOT NULL
DROP TABLE [dbo].[HocPhan]
GO

CREATE TABLE [dbo].[HocPhan]
(
    MaHP INT NOT NULL PRIMARY KEY, -- Primary Key column
    TenHP NVARCHAR(50) NOT NULL,
    SoTC INT NOT NULL
);
GO

IF OBJECT_ID('[dbo].[GiangVien]', 'U') IS NOT NULL
CREATE TABLE [dbo].[PhanCongCM] (
    [MaGV] INT NOT NULL,
    [MaHP] INT NOT NULL,
    CONSTRAINT [PK_PhanCongCM] PRIMARY KEY ([MaGV] , [MaHP] ),
    CONSTRAINT FK_PhanCongCM_GiangVien FOREIGN KEY (MaGV) REFERENCES GiangVien(MaGV),
    CONSTRAINT FK_PhanCongCM_HocPhan FOREIGN KEY (MaHP) REFERENCES HocPhan(MaHP),

);
GO

INSERT INTO [dbo].[GiangVien]
(
    [MaGV], [HoLot], [Ten], [DiaChi], Luong
)
VALUES
    (001, N'Trần Hồng', N'Dung', N'Số nhà 27, Tổ 22, Minh Xuân, Tuyên Quang', 8000000),
    (002, N'Vũ', N'Hà', N'Số nhà 24, Tổ 22, Minh Xuân, Tuyên Quang', 9000000),
    (003, N'Nguyễn Thị', N'Lan', N'Sn 345, tổ 2, phường Minh Xuân, Tp Tuyên Quang', 7000000),
    (004, N'Lương Văn ', N'Quỳnh', N'Sn 110, tổ 9, phường Tân Hà, Tp Tuyên Quang', 7000000),
    (005, N'Hoàng Thu', N'Xuân', N'Sn 23, tổ 17, phường Tân Quang, Tp Tuyên Quang', 8000000);
GO

INSERT INTO [dbo].[HocPhan]
(
    [MaHP], [TenHP], [SoTC]
)
VALUES
    (2001,N'Toán rời rạc', 2),
    (2002,N'Lập trình Pascal', 3),
    (2003,N'Cấu trúc Dữ liệu và Giải thuật', 4),
    (2004,N'Khai Phá dữ liệu', 2),
    (2005,N'HQTCSDL SQL Server', 2);
GO

INSERT INTO [dbo].[PhanCongCM]
(
    [MaGV], [MaHP]
)
VALUES
    (001,2003),
    (003,2001),
    (002,2004),
    (004,2002),
    (001,2005);
GO


select * from dbo.Giangvien  --hiển thị thông tin của bảng đang chỉ định

select holot, ten, luong from dbo.Giangvien where (luong >= 8000000)

select holot, ten, luong, diachi from dbo.Giangvien 
where luong >= 8000000 order by luong desc

select * from dbo.Giangvien 
where luong >(select avg(luong) from Giangvien) -- select lồng
GO

-- truy vấn danh sách sinh viên và lớp sinh viên đang học
select holot, ten from Giangvien, PhancongCM 
where Giangvien.magv = PhancongCM.magv

SELECT * FROM HocPhan
-- inner join select <cot> from <b1> inner join <b2>
-- ON B1.ID=B2.ID

SELECT * FROM [dbo].[GiangVien] INNER JOIN PhanCongCM
ON GiangVien.MaGV = PhanCongCM.MaGV
GO

SELECT * FROM GiangVien

-- Full Join
-- SELECT <cot1> <cot2> <cotn> FROM <bang1> FULL JOIN <bang2>
-- ON B1.ID=B2.ID