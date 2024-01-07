USE MAU_AdventureWorks2022_DW
GO

SET DATEFIRST 7 -- 1 = Monday, 7 = Sunday
SET DATEFORMAT ymd -- yyyy-mm-dd
SET LANGUAGE English

DROP TABLE IF EXISTS dbo.DimDate

-- Create Date Dimension Table
CREATE TABLE dbo.DimDate (
	DateKey int -- 20230101
	, [Date] date UNIQUE NOT NULL -- 2023-01-01
	, [Year] int NOT NULL -- 2023
	, YearHalfID char(6) NOT NULL -- 2023H1
	, YearHalf int NOT NULL -- 1 or 2
	, QuarterID char(6) NOT NULL -- 2023Q1
	, [Quarter] int NOT NULL -- 1, 2, 3, 4
	, MonthID char(6) NOT NULL -- 202301 
	, [Month] int NOT NULL -- 1 to 12
	, [MonthName] varchar(10)  NOT NULL -- JANUARY TO DECEMBER
	, ShortMonthName char(3) NOT NULL -- JAN TO DEC
	, WeekID char(7) NOT NULL -- 2023W01 
	, WeekofYear int NOT NULL -- 1 to 53
	, WeekofMonth int NOT NULL -- 1, 2, 3, 4, 5, 6
	, [DayOfYear] int NOT NULL -- 1 to 366
	, [DayOfMonth] int NOT NULL -- 1 to 31
	, [DayOfWeek] int NOT NULL -- 1 to 7
	, [DayName] varchar(10) NOT NULL -- SUNDAY TO SATURDAY
	, ShortDayName char(3) NOT NULL -- SUN TO SAT
	, CurrentDayIndicator varchar(16) NOT NULL
	, HolidayIndicator varchar(15) NOT NULL -- Holiday or Non-Holiday
	CONSTRAINT PK_DimDate_DateKey PRIMARY KEY CLUSTERED (DateKey ASC)
)

DECLARE @start_date date = '2010-01-01'
DECLARE @end_date date = DATEADD(day, -1, DATEADD(year, 40, @start_date)) -- 2049-12-31

-- Create a set of dates from the set of numbers in dbo.Numbers Table
;WITH DatesCTE AS (
	SELECT 
		[Date] = DATEADD(day, n.Number, @start_date)
	FROM dbo.Numbers n
	WHERE n.Number <= DATEDIFF(day, @start_date, @end_date)
)

-- Compute common date attrbiutes
, DateAttributesCTE AS (
SELECT 
	[Date]
	, MonthNum = RIGHT(('00' + CAST(DATEPART(m,[Date]) AS varchar)), 2)
	, DayNum = RIGHT(('00'+CAST(DATEPART(d,[Date]) AS varchar)),2)
	, [Year] = CAST(DATEPART(yy, [Date]) AS varchar)
	, YearHalfChar = CASE WHEN DATEPART(m, [Date]) <= 6 THEN 'H1' ELSE 'H2' END
	, YearHalfInt = CASE WHEN DATEPART(m, [Date]) <= 6 THEN 1 ELSE 2 END
	, QuarterChar = 'Q' + CAST(DATEPART(q, [Date]) AS varchar)
	, [MonthName] = UPPER(DATENAME(month, [Date]))
	, WeekofYearChar = 'W' + RIGHT('00'+CAST(DATEPART(wk, [Date]) AS varchar),2)
	, WeekOfYearInt = DATEPART(wk, [Date])
		/*
			Sample values of computation of WeekOfMonth
			Var	or Statement	|	Value	|	Description or Comment
			===============================================================
			[Date]	     		| 2024-12-31	| Date currently being considered
			EOMONTH([Date],-1)      | 2024-11-30	| 2nd argumnet represents the months before or after the first argument.
						|		| So in words, this statement is equivalent to End of Month of 1 month prior 2010-12
						|		| or End of Month of 2009-11
			StartOfMonth            | 2010-12-01	| Add 1 day to EOMONTH(@iterator,-1) 
			BaselineWeek		| 49		| Week of Year of 2010-12-01
			WeekOfMonth 		| 5		| Week of Month of 2010-12-31
		*/
	, StartofMonth = DATEADD(Day, 1, EOMONTH([Date],-1))
	, BaselineWeek = DATEPART(wk, DATEADD(Day, 1, EOMONTH([Date],-1))) -- BaselineWeek = DATEPART(wk, StartofMonth)
	, [DayName] = UPPER(DATENAME(dw, [Date]))
FROM DatesCTE
)


-- Populate DimDate table 
INSERT INTO dbo.DimDate
SELECT
	DateKey = CAST(CONCAT([Year], MonthNum, DayNum) AS INT)
	, [Date] = [Date]
	, [Year] = DATEPART(yyyy, [Date])
	, YearHalfID = CONCAT([Year], YearHalfChar)
	, YearHalf = [YearHalfInt]
	, QuarterID = CONCAT([Year], QuarterChar)
	, [Quarter] = DATEPART(q, [Date])
	, MonthID = CONCAT([Year], MonthNum)
	, [Month] = DATEPART(m, [Date])
	, [MonthName] = [MonthName]
	, ShortMonthName = LEFT([MonthName],3)
	, WeekID = CONCAT([Year], WeekofYearChar)
	, WeekOfYear = WeekOfYearInt
	, WeekOfMonth = WeekOfYearInt - BaselineWeek + 1
	, [DayOfYear] = DATEPART(dy, [Date]) 
	, [DayOfMonth] = DATEPART(d, [Date])
	, [DayOfWeek] = DATEPART(dw, [Date])
	, [DayName] = [DayName]
	, ShortDayName = LEFT([DayName],3)
	, CurrentDayIndicator = 
		CASE WHEN [Date] = FORMAT(GETDATE(),'yyyy-MM-dd') 
		     THEN 'Current Date' 
		     ELSE 'Not Current Date'
		END
	, HolidayIndicator = 
		CASE WHEN MonthNum = '01' AND DayNum = '01' THEN 'Holiday'
			 WHEN MonthNum = '02' AND DayNum = '10' THEN 'Holiday'
			 WHEN MonthNum = '04' AND DayNum = '09' THEN 'Holiday'
			 WHEN MonthNum = '05' AND DayNum = '01' THEN 'Holiday'
			 WHEN MonthNum = '06' AND DayNum = '12' THEN 'Holiday'
			 WHEN MonthNum = '08' AND DayNum = '21' THEN 'Holiday'
			 WHEN MonthNum  = '08' AND DayNum = '26' THEN 'Holiday'
			 WHEN MonthNum  = '11' AND DayNum = '01' THEN 'Holiday'
			 WHEN MonthNum  = '11' AND DayNum = '02' THEN 'Holiday'
			 WHEN MonthNum  = '11' AND DayNum = '30' THEN 'Holiday'
			 WHEN MonthNum  = '12' AND DayNum = '08' THEN 'Holiday'
			 WHEN MonthNum  = '12' AND DayNum = '24' THEN 'Holiday'
			 WHEN MonthNum  = '12' AND DayNum = '25' THEN 'Holiday'
			 WHEN MonthNum  = '12' AND DayNum = '30' THEN 'Holiday'
			 WHEN MonthNum  = '12' AND DayNum = '31' THEN 'Holiday'
			 ELSE 'Non-Holiday'
		END
FROM DateAttributesCTE da


-- Check Data 
SELECT TOP(366) * FROM dbo.DimDate


-- Incorporate Moving Holidays (Lenten)
/*
	Context:
		Easter is a moving feast which may happen any time between March 22 and April 25.
		For this reason, it is not practical to populate the Lenten Holidays every year.
		https://en.wikipedia.org/wiki/Date_of_Easter offers various algorithms to compute the date of Easter Sunday.
		The code below follows the Anonymous Gregorian algorithm found in the aforesaid wikipage.

*/

;WITH ComputationCTE AS (
	SELECT
		[Year]
		, a = [Year]%19
		, b = [Year]/100
		, c = [Year]%100
		, d = [Year]/400
		, e = ([Year]/100)%4
		, f = ([Year]/100 + 8)/25
		, g = (8*[Year]/100 + 13)/25   --	, g = (8*b+13)/25
		-- h = (19*a + b - d - ((b - f + 1)/3) + 15 ) % 30
		, h = ( 19*([Year]%19) 
			  + [Year]/100
			  - [Year]/400
			  - (([Year]/100) - ([Year]/100 + 8)/25 + 1)/3
			  + 15 ) % 30
		, i =  ([Year]%100)/4 -- i = c/4
		, k = ([Year]%100)%4 -- k = c%4
		-- l = (32 + 2*e + 2*i - h -k)%7
		, l = (	32  
				+ 2*(([Year]/100)%4)
				+ 2* (([Year]%100)/4)
				- (( 19*([Year]%19) + [Year]/100 - [Year]/400 - (([Year]/100) - ([Year]/100 + 8)/25 + 1)/3 + 15 ) % 30)
			  ) % 7
		--  m = (a + 11*h + 19*l)/453
		, m = (
				[Year]%19
				+ 11* (( 19*([Year]%19) + [Year]/100- [Year]/400 - (([Year]/100) - ([Year]/100 + 8)/25 + 1)/3 + 15 ) % 30)
				+ 19* (( 32  + 2*(([Year]/100)%4) + 2* (([Year]%100)/4) - (( 19*([Year]%19) + [Year]/100 - [Year]/400 - (([Year]/100) - ([Year]/100 + 8)/25 + 1)/3 + 15 ) % 30)) % 7)
			  )/453

	FROM dbo.DimDate
	GROUP BY [Year] 
)

, ComputationCTE2 AS (
	SELECT
		*
		, n = (h + l - 7*m +90)/25 -- Month when Easter Sunday occurs
		-- p = (h + l - 7*m + 33*n + 19)%32
		, p = ( h + l - 7*m + 33*((h + l - 7*m +90)/25) + 19) % 32 -- Day of Easter Sunday
	FROM ComputationCTE
)
, ComputationCTE3 AS (
	SELECT
		*
		, EasterSunday = DATEFROMPARTS([Year], n, p)
	FROM ComputationCTE2
)

UPDATE dbo.DimDate
SET HolidayIndicator = 'Holiday'
FROM dbo.DimDate dd
LEFT JOIN ComputationCTE3 ccte3 ON ccte3.[Year] = dd.[Year]
WHERE [Date] = EasterSunday   -- Easter Sunday
	  OR [Date] = DATEADD(day, -1, EasterSunday) -- Black Saturday
	  OR [Date] = DATEADD(day, -2, EasterSunday) -- Good Friday
	  OR [Date] = DATEADD(day, -3, EasterSunday) -- Maundy Thursday
