-- Tạo bảng
 DROP TABLE IF EXISTS ct70;
 CREATE TABLE ct70 (
    MaVatTu VARCHAR(10),
    MaKho VARCHAR(10),
    SoLuong INT
);
-- Nhập dữ liệu
INSERT INTO ct70 (MaVatTu, MaKho, SoLuong) VALUES 
('VT1', 'K1', 10),
('VT2', 'K2', 12),
('VT3', 'K3', 11),
('VT4', 'K1', 14),
('VT1', 'K3', 15)

select * from ct70

-- Tạo bảng xoay
SELECT 
    MaVatTu,
    ISNULL([K1], 0) AS K1,
    ISNULL([K2], 0) AS K2,
    ISNULL([K3], 0) AS K3
FROM 
    (SELECT ct70.MaKho, ct70.MaVatTu, ct70.SoLuong 
     FROM dbo.ct70) AS temp
PIVOT
    (MIN(SoLuong) 
     FOR MaKho IN ([K1], [K2], [K3])
    ) AS pivotdemo;


