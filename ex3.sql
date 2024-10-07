-- Tạo bảng
DROP TABLE IF EXISTS ex3;
CREATE TABLE ex3(
	MaVatTu CHAR(10),
	MaKho CHAR(10),
	MaLo CHAR(10),
	MaViTri CHAR(10),
	SoLuong TINYINT
);
-- Nhập dữ liệu
INSERT INTO ex3(MaVatTu, MaKho, MaLo, MaViTri, SoLuong) VALUES
	('VT1', 'K1', 'LO1', 'A12', '12'),
	('VT1', 'K1', 'LO1', 'A12', '12'),
	('VT1', 'K1', 'LO1', 'A12', '12'),
	('VT2', 'K1', 'LO1', 'A12', '15'),
	('VT2', 'K1', 'LO1', 'A12', '15')

SELECT * FROM ex3
-- Xử lý dữ liệu trong bảng
WITH CTE AS (
    SELECT 
        MaVatTu, MaKho, MaLo, MaViTri, SoLuong,
        ROW_NUMBER() OVER (PARTITION BY MaVatTu, MaKho, MaLo, MaViTri, SoLuong ORDER BY (SELECT NULL)) AS rn
    FROM ex3
)
DELETE FROM CTE WHERE rn > 1;
SELECT * FROM ex3





