create table stg_pan_numbers_dataset
(
pan_number text
);
select *
from stg_pan_numbers_dataset

/* scheck for missing values */ 
select * 
from stg_pan_numbers_dataset
where Pan_Numbers is null 

/*check for duplicates */
select Pan_numbers,count(1)
from stg_pan_numbers_dataset 
group by Pan_numbers 
having count(1) > 1

--handling leading and tralling spaces 

select * from stg_pan_numbers_dataset where Pan_Numbers <> TRIM(Pan_Numbers)

-- handling upper leter case 
select * from stg_pan_numbers_dataset where Pan_Numbers <> upper(Pan_Numbers)

-- cleaning pannumbers from null and duplicates and spaces and lower letters
select distinct upper(TRIM(Pan_Numbers)) as pan_number
from stg_pan_numbers_dataset 
where Pan_Numbers is not null and  TRIM(Pan_Numbers) <> ''

-- function to check if adjecent character is the same 
CREATE FUNCTION dbo.fn_check_adjacent_characters (@p_str varchar(50))
RETURNS BIT
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @len INT = LEN(@p_str);
    DECLARE @result BIT = 0;

    WHILE @i < @len
    BEGIN
        IF SUBSTRING(@p_str, @i, 1) = SUBSTRING(@p_str, @i + 1, 1)
        BEGIN
            SET @result = 1;
            BREAK;
        END
        SET @i = @i + 1;
    END

    RETURN @result;
END;
GO

SELECT 
    Pan_Numbers,
    dbo.fn_check_adjacent_characters(Pan_Numbers) AS HasAdjacentCharacters
FROM stg_pan_numbers_dataset; 

-- function to check if sequantial characters are used 
alter FUNCTION dbo.fn_check_sequance_characters (@p_str varchar(50))
RETURNS BIT
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @len INT = LEN(@p_str);
    DECLARE @result BIT = 0;

    WHILE @i < @len
    BEGIN
        IF ascii (SUBSTRING(@p_str, @i+1, 1)) - ascii(SUBSTRING(@p_str, @i , 1)) = 1
        BEGIN
            SET @result = 1 ;-- this mean it's a sequance string
            BREAK;
        END
        SET @i = @i + 1;
    END

    RETURN @result;
END;
GO

select dbo.fn_check_sequance_characters('abcd')

-- Regular expression to validate the pattern or structure of pan numbers --AAAAA1234A
SELECT *
FROM stg_pan_numbers_dataset
WHERE Pan_Numbers LIKE '[A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][A-Z]';


-- Valid and invalid pan categorization 
create view vw_valid_invalid_pans
as
with cte_cleaned_pan as (
     select distinct upper(trim(Pan_Numbers)) as pan_number
	 from stg_pan_numbers_dataset 
	 where Pan_Numbers is not null
	 and trim(Pan_Numbers) <> ''),

vaild_pans as(

select * 
from cte_cleaned_pan
where dbo.fn_check_adjacent_characters(pan_number) = 0
and dbo.fn_check_sequance_characters(SUBSTRING(pan_number,1,5)) = 0
and dbo.fn_check_sequance_characters(SUBSTRING(pan_number,6,4)) = 0
and pan_number LIKE '[A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][A-Z]'
)

select cln.pan_number , 
case when vld.pan_number is not null 
then 'Vaild Pan' else 'Invalid Pan' END AS status

from cte_cleaned_pan cln 
left join vaild_pans vld on vld.pan_number = cln.pan_number

CREATE VIEW vw_valid_invalid_pans
AS
WITH cte_cleaned_pan AS (
    SELECT DISTINCT UPPER(LTRIM(RTRIM(Pan_Numbers))) AS pan_number
    FROM stg_pan_numbers_dataset 
    WHERE Pan_Numbers IS NOT NULL
      AND LTRIM(RTRIM(Pan_Numbers)) <> ''
),
valid_pans AS (
    SELECT * 
    FROM cte_cleaned_pan
    WHERE dbo.fn_check_adjacent_characters(pan_number) = 0
      AND dbo.fn_check_sequance_characters(SUBSTRING(pan_number, 1, 5)) = 0
      AND dbo.fn_check_sequance_characters(SUBSTRING(pan_number, 6, 4)) = 0
      AND pan_number LIKE '[A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][A-Z]'
)
SELECT 
    cln.pan_number, 
    CASE 
        WHEN vld.pan_number IS NOT NULL THEN 'Valid Pan' 
        ELSE 'Invalid Pan' 
    END AS status
FROM cte_cleaned_pan cln 
LEFT JOIN valid_pans vld 
    ON vld.pan_number = cln.pan_number;
GO

select * from vw_valid_invalid_pans

-- summary report
SELECT 
   
   status,count(*) as total_number ,
   (select count(*) from stg_pan_numbers_dataset) as total_processed_records
   from vw_valid_invalid_pans
   group by status