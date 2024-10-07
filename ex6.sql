-- Tạo bảng
DROP TABLE IF EXISTS ex6
CREATE TABLE ex6 (
	MaVatTu CHAR(10),
	SoLuongTu TINYINT,
	SoLuongDen TINYINT,
	SoLuongKhuyenMai INT,
	VatTuDuocKhuyenMai CHAR(10),
	SoLuong INT
);
-- Nhập dữ liệu
INSERT INTO ex7 (MaVatTu, SoLuongTu, SoLuongDen, SoLuongKhuyenMai, VatTuDuocKhuyenMai, SoLuong) VALUES
	('VT1', 1, 100, 1, NULL, NULL),
	('VT1', 101, 200, 1, 'VTKM1', 1),
	('VT1', 201, 500, 2, 'VTKM1', 1),
	('VT1', 201, 500, 2, 'VTKM2', 1),
	('VT2', 1, 100, NULL, 'VTKM1', 1),
	('VT2', 101, 300, 1, 'VTKM3', 3)

SELECT * FROM ex7

IF OBJECT_ID('zcStoreVattuKhuyenMai') IS NOT NULL
    DROP PROCEDURE zcStoreVattuKhuyenMai;

-- Procedure
CREATE PROCEDURE zcStoreVattuKhuyenMai
    @MaVatTu CHAR(10),
    @SoLuong INT
AS
BEGIN
    -- Tạo bảng tạm để lưu kết quả
    CREATE TABLE #Result (
        MaVatTu CHAR(10),
        SoLuongKhuyenMai INT
    );

    -- Truy vấn để lấy vật tư chính kèm số lượng khuyến mại
    INSERT INTO #Result (MaVatTu, SoLuongKhuyenMai)
    SELECT
        @MaVatTu AS MaVatTu,
        ISNULL(MAX(SoLuongKhuyenMai), 0) AS SoLuongKhuyenMai
    FROM
        ex7
    WHERE
        MaVatTu = @MaVatTu
        AND @SoLuong BETWEEN SoLuongTu AND SoLuongDen;

    -- Truy vấn để lấy các vật tư khuyến mại liên quan
    INSERT INTO #Result (MaVatTu, SoLuongKhuyenMai)
    SELECT
        VatTuDuocKhuyenMai AS MaVatTu,
        SoLuong AS SoLuongKhuyenMai
    FROM
        ex7
    WHERE
        MaVatTu = @MaVatTu
        AND @SoLuong BETWEEN SoLuongTu AND SoLuongDen
        AND VatTuDuocKhuyenMai IS NOT NULL;

    -- Loại bỏ dòng không mong muốn
    DELETE FROM #Result
    WHERE MaVatTu IS NULL OR SoLuongKhuyenMai = 0;

    -- Trả về kết quả
    SELECT * FROM #Result;

    -- Dọn dẹp bảng tạm
    DROP TABLE #Result;
END;
-- Thực thi
EXEC zcStoreVattuKhuyenMai 'VT1', 250;