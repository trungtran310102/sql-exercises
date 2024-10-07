-- Tạo bảng
DROP TABLE IF EXISTS ex6
CREATE TABLE ex6 (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(255),
    City NVARCHAR(255),
    Street NVARCHAR(255),
    SoNha INT
);
-- Nhập dữ liệu
INSERT INTO ex6 (CustomerID, CustomerName, City, Street, SoNha) VALUES
(1, N'Ngyễn Văn A', N'Hà Nội', N'Trần Duy Hưng', 1),
(2, N'Lê Văn B', N'Hà Nội', N'Lê Đức Thọ', 2),
(3, N'Trần Tiến Đạt', N'Nam Định', N'Trần HƯng Đạo', 25),
(4, N'Nguyễn Tiến Trọng', N'Vĩnh Phúc', N'Đỗ Mười', 29),
(5, N'Lê Bảo Bình', N'Vĩnh Phúc', N'Đỗ Mười', 29),
(6, N'Hà Thủ Ô', N'Lạng Sơn', N'Trần HƯng Đạo', 18),
(7, N'Omega', N'Vĩnh Phúc', N'Đỗ Mười', 29),
(8, N'Iphone', N'Việt Nam', N'Trần HƯng Đạo', 18),
(9, N'Nokia', N'Áo', N'Đỗ Mười', 29),
(10, N'Samsung', N'Trung Quốc', N'Trần HƯng Đạo', 18),
(11, N'Lenovo', N'Hàn Quốc', N'Đỗ Mười', 29),
(12, N'Tosiba', N'Việt Nam', N'Trần HƯng Đạo', 18),
(13, N'Honda', N'Việt Nam', N'Đỗ Mười', 29),
(14, N'Suzuki', N'Việt Nam', N'Trần Hưng Đạo', 18);

SELECT * FROM ex6

-- Truy vấn dữ liệu
SELECT * FROM ex6
WHERE CONCAT(City, Street, ' ', SoNha) IN (
  SELECT CONCAT(City, Street, ' ', SoNha)
  FROM ex6
  GROUP BY City, Street, SoNha
  HAVING COUNT(*) > 1
);

SELECT * FROM ex6
WHERE City IN (
  SELECT City
  FROM ex6
  GROUP BY City
  HAVING COUNT(*) > 1
);