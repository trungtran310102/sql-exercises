
DROP TABLE IF EXISTS ex1;


CREATE TABLE ex1 (
    Char NVARCHAR(1),
    Count INT
);

DECLARE @string NVARCHAR(100) = '@#$%!e!';
DECLARE @len INT = LEN(@string);
DECLARE @i INT = 1;

WHILE @i <= @len
BEGIN
    DECLARE @char NVARCHAR(1) = SUBSTRING(@string, @i, 1);
    
    IF EXISTS (SELECT 1 FROM ex1 WHERE Char = @char)
    BEGIN
        UPDATE ex1
        SET Count = Count + 1
        WHERE Char = @char;
    END
    ELSE
    BEGIN
        INSERT INTO ex1(Char, Count)
        VALUES (@char, 1);
    END
    
    SET @i = @i + 1;
END;

SELECT ROW_NUMBER() OVER (ORDER BY Char) AS STT, 
       Char AS [Ký tự], 
       Count AS [Số lần xuất hiện]
FROM ex1;
