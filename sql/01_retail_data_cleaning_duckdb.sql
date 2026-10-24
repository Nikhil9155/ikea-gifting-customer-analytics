-- CHECK ROW COUNT AFTER IMPORT

select
	count(*)
from
	main.year_2009_2010 ;

select
	count(*)
from
	main.year_2010_2011 ;

-- COMBINE BOTH YEARS AND CONVERT DATA TYPES SAFELY

CREATE TABLE main.RetailCombined AS

SELECT
    Invoice,
    StockCode,
    Description,
    TRY_CAST(Quantity AS INTEGER) AS Quantity,
    TRY_STRPTIME(
        TRIM(InvoiceDate),
        '%d-%m-%Y %H:%M'
    ) AS InvoiceDate,
    TRY_CAST(Price AS DECIMAL(10,2)) AS Price,
    TRY_CAST("Customer ID" AS BIGINT) AS Customer_ID,
    Country,
    '2009-2010' AS SourceSheet
FROM main.year_2009_2010

UNION ALL

SELECT
    Invoice,
    StockCode,
    Description,
    TRY_CAST(Quantity AS INTEGER) AS Quantity,
    TRY_STRPTIME(
        TRIM(InvoiceDate),
        '%d-%m-%Y %H:%M'
    ) AS InvoiceDate,
    TRY_CAST(Price AS DECIMAL(10,2)) AS Price,
    TRY_CAST("Customer ID" AS BIGINT) AS Customer_ID,
    Country,
    '2010-2011' AS SourceSheet
FROM main.year_2010_2011;

-- CONFIRM THE CONVERSION WORKED CLEANLY
SELECT
	count(*) as Total_Rows
from
	main.RetailCombined ;

SELECT
	count(*) as Total_Rows
from
	main.RetailCombined
WHERE
	InvoiceDate is null ;

SELECT
	count(*) as Total_Rows
from
	main.RetailCombined
WHERE
	Price is null ;


-- CHECK 1 - MISSING CUSTOMER ID
SELECT
	COUNT(*) AS Missing_CustomerID
FROM
	main.RetailCombined
WHERE
	Customer_ID IS NULL;


-- CHECK 2 - NEGATIVE OR ZERO QUANTITY
SELECT
	COUNT(*) AS Negative_Qty
FROM
	main.RetailCombined
WHERE
	Quantity <= 0;


-- CHECK 3 - MISSING DESCRIPTION
SELECT
	COUNT(*) AS Missing_Description
FROM
	main.RetailCombined
WHERE
	Description IS NULL;


-- CHECK 4 - EXACT DUPLICATE ROWS
SELECT
	Invoice,
	StockCode,
	Description,
	Quantity,
	InvoiceDate,
	Price,
	Customer_ID,
	Country,
	COUNT(*) AS ExactDupeCount
FROM
	main.RetailCombined
GROUP BY
	Invoice ,
	StockCode ,
	Description ,
	Quantity ,
	InvoiceDate ,
	Price ,
	Customer_ID ,
	Country
HAVING
	COUNT(*) > 1;


-- DEDUPLICATE AND PRODUCE THE FINAL CLEANED TABLE

CREATE TABLE main.RetailCleaned AS
WITH Deduped AS (
SELECT
	*,
	ROW_NUMBER() OVER (
            PARTITION BY
                Invoice,
	StockCode,
	Description,
	Quantity,
	InvoiceDate,
	Price,
	Customer_ID,
	Country
ORDER BY
	SourceSheet
        ) AS RowNum
FROM
	main.RetailCombined
)
SELECT
	Invoice,
	StockCode,
	Description,
	Quantity,
	InvoiceDate,
	Price,
	Customer_ID,
	Country,
	SourceSheet
FROM
	Deduped
WHERE
	RowNum = 1;

SELECT * from main.RetailCleaned rc ;