-- Tạo bảng
DROP TABLE IF EXISTS ex4;
CREATE TABLE ex4 (
    MaVatTu CHAR(10),
    TenVatTu NVARCHAR(100)
);
-- Nhập dữ liệu
INSERT INTO ex4 (MaVatTu, TenVatTu) VALUES
    ('VT1', N'Tên vật tư 1'),
    ('VT2', N'Tên vật tư 2'),
    ('VT3', N'Tên vật tư 3'),
    ('VT4', N'Tên vật tư 4'),
    ('VT5', N'Tên vật tư 5'),
    ('VT6', N'Tên vật tư 6'),
    ('VT7', N'Tên vật tư 7'),
    ('VT8', N'Tên vật tư 8'),
    ('VT9', N'Tên vật tư 9'),
    ('VT10', N'Tên vật tư 10'),
    ('VT11', N'Tên vật tư 11'),
    ('VT12', N'Tên vật tư 12'),
    ('VT13', N'Tên vật tư 13'),
    ('VT14', N'Tên vật tư 14'),
    ('VT15', N'Tên vật tư 15'),
    ('VT16', N'Tên vật tư 16'),
    ('VT17', N'Tên vật tư 17'),
    ('VT18', N'Tên vật tư 18'),
    ('VT19', N'Tên vật tư 19'),
    ('VT20', N'Tên vật tư 20'),
    ('VT21', N'Tên vật tư 21'),
    ('VT22', N'Tên vật tư 22'),
    ('VT23', N'Tên vật tư 23'),
    ('VT24', N'Tên vật tư 24'),
    ('VT25', N'Tên vật tư 25'),
    ('VT26', N'Tên vật tư 26'),
    ('VT27', N'Tên vật tư 27'),
    ('VT28', N'Tên vật tư 28');

SELECT * FROM ex4;

IF OBJECT_ID('getRecordPage', 'P') IS NOT NULL
    DROP PROCEDURE getRecordPage;

-- Procedure phân trang
CREATE PROCEDURE GetRecordPage
    @PageSize INT,
    @CurrentPage INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartRow INT, @EndRow INT;

    SET @StartRow = (@CurrentPage - 1) * @PageSize + 1;
    SET @EndRow = @CurrentPage * @PageSize;

    ;WITH NumberedRecords AS (
        SELECT 
            MaVatTu,
            TenVatTu,
            ROW_NUMBER() OVER (ORDER BY CAST(SUBSTRING(MaVatTu, 3, LEN(MaVatTu)) AS INT)) AS RowNum
        FROM 
            ex4
    )
    SELECT 
        MaVatTu,
        TenVatTu
    FROM 
        NumberedRecords
    WHERE 
        RowNum BETWEEN @StartRow AND @EndRow;
END
-- Thực thi procedure
EXEC GetRecordPage 5, 3;