-- Xóa bảng nếu đã tồn tại
DROP TABLE IF EXISTS Bang1, Bang2;

-- Tạo bảng Bang1
CREATE TABLE Bang1 (
    MaKhach VARCHAR(10) PRIMARY KEY,
    TenKhach VARCHAR(255),
    DiaChi VARCHAR(255),
    NhaCungCap INT, -- Giá trị 1 nếu là nhà cung cấp, 0 nếu không phải
    KhachHang INT   -- Giá trị 1 nếu là khách hàng, 0 nếu không phải
);

-- Tạo bảng Bang2
CREATE TABLE Bang2 (
    MaKhach VARCHAR(10) PRIMARY KEY,
    TenKhach VARCHAR(255),
    DiaChi VARCHAR(255),
    NhaCungCap INT -- Giá trị 1 nếu là nhà cung cấp
);

-- Nhập dữ liệu vào Bang1
INSERT INTO Bang1 (MaKhach, TenKhach, DiaChi, NhaCungCap, KhachHang) VALUES
    ('KH01', 'Cong ty FAST', 'Tang 3 - CT1B - Khu VOV - Me Tri', 1, 0),
    ('KH02', 'Cong ty FAST', 'Ha Noi', 0, 1);

-- Nhập dữ liệu vào Bang2
INSERT INTO Bang2 (MaKhach, TenKhach, DiaChi, NhaCungCap) VALUES
    ('KH01', 'Cong ty FAST', 'Tang 3 - CT1B - Khu VOV - Me Tri', 1);

-- Truy vấn dữ liệu từ Bang1
SELECT * FROM Bang1;

-- Truy vấn dữ liệu từ Bang2
SELECT * FROM Bang2;

-- Trigger cho thao tác INSERT và UPDATE trên Bang1
CREATE TRIGGER trg_after_insert_update_bang1
ON Bang1
AFTER INSERT, UPDATE
AS
BEGIN
    -- Xóa các dòng dữ liệu trong Bang2 tương ứng với các dòng đã bị thay đổi trong Bang1
    DELETE FROM Bang2
    WHERE MaKhach IN (SELECT MaKhach FROM deleted);

    -- Chèn lại các dòng dữ liệu mới vào Bang2 từ Bang1
    INSERT INTO Bang2 (MaKhach, TenKhach, DiaChi, NhaCungCap)
    SELECT MaKhach, TenKhach, DiaChi, NhaCungCap
    FROM inserted
    WHERE NhaCungCap = 1;
END;

-- Trigger cho thao tác DELETE trên Bang1
CREATE TRIGGER trg_after_delete_bang1
ON Bang1
AFTER DELETE
AS
BEGIN
    -- Xóa dữ liệu từ Bang2 khi dữ liệu bị xóa khỏi Bang1
    DELETE FROM Bang2
    WHERE MaKhach IN (SELECT MaKhach FROM deleted);
END;

INSERT INTO Bang1 (MaKhach, TenKhach, DiaChi, NhaCungCap, KhachHang)
VALUES ('KH03', 'Cong ty FAST', 'HN', 1, 0);
