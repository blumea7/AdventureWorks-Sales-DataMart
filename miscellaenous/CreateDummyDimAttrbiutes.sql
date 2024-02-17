USE MAU_AdventureWorks2022_DW
GO

-- Insert Dummy Dimension Values for NULL Customer
IF 
	EXISTS (SELECT 1 FROM DimCustomer)
	AND NOT EXISTS (SELECT 1 FROM DimCustomer WHERE CustomerUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimCustomer ON
	INSERT INTO DimCustomer(
		CustomerUniqueID
		, AccountNumber
		, GeographyUniqueID
		, FirstName
		, MiddleName
		, LastName
		, FullName
		, NameSuffix
		, EmailAddress
		, PhoneNumber
		, BirthDate
		, MaritalStatus
		, YearlyIncome
		, GenderCode
		, Gender
		, TotalChildren
		, NumberChildrenAtHome
		, Occupation
		, HomeOwnerIndicator
		, NumberCarsOwned
		, CommuteDistance
		, DateCreated
		, DateModified
	)
	VALUES(
		-1
		, 'AW00000000'
		, -1
		, 'Unknown'
		, 'Unknown'
		, 'Unknown'
		, 'Unknown'
		, NULL
		, 'Unknown'
		, 'Unknown'
		, DATEFROMPARTS(9999,12,31)
		, NULL
		, NULL
		, NULL
		, 'Unknown'
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimCustomer OFF
END


-- Insert Dummy Dimension Values for NULL Store Reseller
IF 
	EXISTS (SELECT 1 FROM DimCustomerStore) 
	AND NOT EXISTS (SELECT 1 FROM DimCustomerStore WHERE StoreUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimCustomerStore ON
	INSERT INTO DimCustomerStore(
		StoreUniqueID
		, SalesTerritoryUniqueID
		, SalesPersonUniqueID
		, StoreName
		, AnnualSales
		, AnnualRevenue
		, BankName
		, BusinessType
		, YearOpened
		, Specialty
		, SquareFeet
		, Brands
		, Internet
		, NumberEmployees
		, DateCreated
		, DateModified
	)
	VALUES (
		-1 
		, -1 
		, -1
		, 'Unknown'
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimCustomerStore OFF
END


-- Insert Dummy Dimension Values for NULL date
DECLARE @DummyDate date = DATEFROMPARTS(9999,12,31) --DATEFROMPARTS(9999,12,31)
DECLARE @Year int = YEAR(@DummyDate)
DECLARE @Month int = DATEPART(m, @DummyDate)
DECLARE @MonthChar char(2) = RIGHT(CONCAT('00', @Month),2)
DECLARE @YearHalfChar char(2) = CASE WHEN @Month <= 6 THEN 'H1' ELSE 'H2' END
DECLARE @Quarter int = DATEPART(q, @DummyDate)
DECLARE @StartOfMonth date = DATEADD(Day, 1, EOMONTH(@DummyDate,-1))
DECLARE @WeekOfYear int = DATEPART(wk, @DummyDate)
DECLARE @WeekfOfYearChar char(3) = RIGHT(CONCAT('00', @WeekOfYear),2)
DECLARE @WeekOfMonth int = @WeekOfYear - DATEPART(wk, @StartOfMonth) + 1
DECLARE @DayOfMonth int = DATEPART(d, @DummyDate)

IF
	EXISTS (SELECT 1 FROM DimDate)
	AND NOT EXISTS (SELECT 1 FROM DimDate dd WHERE dd.DateKey = 99991231)
BEGIN
	INSERT INTO DimDate (
		DateKey
		, Date
		, Year
		, YearHalfID
		, YearHalf
		, QuarterID
		, Quarter
		, MonthID
		, Month
		, MonthName
		, ShortMonthName
		, WeekID
		, WeekofYear
		, WeekofMonth
		, DayOfYear
		, DayOfMonth
		, DayOfWeek
		, DayName
		, ShortDayName
		, CurrentDayIndicator
		, HolidayIndicator
	)
	VALUES (
		CONCAT(@Year, @Month, @DayOfMonth)
		, @DummyDate
		, @Year
		, CONCAT(@Year, @YearHalfChar)
		, CASE WHEN @Month <= 6 THEN 1 ELSE 2 END
		, CONCAT(@Year,'Q', @Quarter)
		, @Quarter
		, CONCAT(@Year, @MonthChar)
		, @Month
		, UPPER(DATENAME(month, @DummyDate))
		, LEFT(UPPER(DATENAME(month, @DummyDate)),3)
		, CONCAT(@Year, 'W', @WeekfOfYearChar)
		, @WeekOfYear
		, @WeekOfMonth
		, DATEPART(dy, @DummyDate) 
		, DATEPART(d, @DummyDate)
		, DATEPART(dw, @DummyDate)
		, UPPER(DATENAME(dw, @DummyDate))
		, LEFT(UPPER(DATENAME(dw, @DummyDate)),3)
		, CASE WHEN @DummyDate = FORMAT(GETDATE(),'yyyy-MM-dd') 
		     THEN 'Current Date' 
		     ELSE 'Not Current Date'
		END
		, CASE WHEN @Month = 1 AND @DayOfMonth = 1 THEN 'Holiday'
			 WHEN @Month = 2 AND @DayOfMonth = 10 THEN 'Holiday'
			 WHEN @Month = 4 AND @DayOfMonth = 9 THEN 'Holiday'
			 WHEN @Month = 5 AND @DayOfMonth = 1 THEN 'Holiday'
			 WHEN @Month = 6 AND @DayOfMonth = 12 THEN 'Holiday'
			 WHEN @Month = 8 AND @DayOfMonth = 21 THEN 'Holiday'
			 WHEN @Month  = 8 AND @DayOfMonth = 26 THEN 'Holiday'
			 WHEN @Month  = 11 AND @DayOfMonth = 1 THEN 'Holiday'
			 WHEN @Month  = 11 AND @DayOfMonth = 2 THEN 'Holiday'
			 WHEN @Month  = 11 AND @DayOfMonth = 30 THEN 'Holiday'
			 WHEN @Month  = 12 AND @DayOfMonth = 8 THEN 'Holiday'
			 WHEN @Month  = 12 AND @DayOfMonth = 24 THEN 'Holiday'
			 WHEN @Month  = 12 AND @DayOfMonth = 25 THEN 'Holiday'
			 WHEN @Month  = 12 AND @DayOfMonth = 30 THEN 'Holiday'
			 WHEN @Month  = 12 AND @DayOfMonth = 31 THEN 'Holiday'
			 ELSE 'Non-Holiday'
		END
	)
END

-- Insert Dummy Dimension Values for NULL Geography 
IF 
	EXISTS (SELECT 1 FROM DimGeography)
	AND NOT EXISTS (SELECT 1 FROM DimGeography WHERE GeographyUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimGeography ON 
	INSERT INTO DimGeography (
		GeographyUniqueID
		, City
		, StateCode
		, State
		, [City-State]
		, CountryCode
		, Country
		, SalesTerritory
		, SalesTerritoryGroup
		, PostalCode
		, DateCreated
		, DateModified
	) 
	VALUES (
		-1
		, 'Unknown'
		, NULL
		, 'Unknown'
		, 'Unknown'
		, NULL
		, NULL
		, NULL
		, 'Unknown'
		, 'Unknown'
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimGeography OFF 
END

-- Insert Dummy Dimension Values for NULL Product 
IF 
	EXISTS (SELECT 1 FROM DimProduct)
	AND NOT EXISTS (SELECT 1 FROM DimProduct WHERE ProductUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimProduct  ON
	INSERT INTO DimProduct (
		ProductUniqueID
		, ProductCode
		, ProductName
		, SalelableIndicator
		, Color
		, StandardCost
		, ListPrice
		, Size
		, SizeUnitMeasureCode
		, SizeUnitMeasure
		, [Weight]
		, WeightUnitMeasureCode
		, WeightUnitMeasure
		, ProductLineCode
		, ProductLine
		, ClassCode
		, Class
		, StyleCode
		, Style
		, SubCategory
		, Category
		, Model
		, SellStartDate
		, SellEndDate
		, IsActive
		, DateCreated
		, DateModified
	)
	VALUES (
		-1 
		, 'Unknown'
		, 'Unknown'
		, 'Unknown'
		, NULL
		, 0
		, 0
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, NULL
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimProduct  OFF
END

-- Insert Dummy Dimension Values for NULL Promo 

IF 
	EXISTS (SELECT 1 FROM DimPromo)
	AND NOT EXISTS (SELECT 1 FROM DimPromo WHERE PromoUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimPromo ON
	INSERT INTO DimPromo (
		PromoUniqueID
		, Promo
		, DiscountPct
		, [Type]
		, Category
		, StartDate
		, EndDate
		, MinQuantity
		, MaxQuantity
		, DateCreated
		, DateModified
	)
	VALUES (
		-1
		, 'Unknown'
		, 0
		, 'Unknown'
		, 'Unknown'
		, DATEFROMPARTS(9999,12,31)
		, DATEFROMPARTS(9999,12,31)
		, 0
		, 0
		, 0
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimPromo OFF
END

-- Insert Dummy Dimension Values for Null SalesPerson 

IF 
	EXISTS (SELECT 1 FROM DimSalesPerson)
	AND NOT EXISTS (SELECT 1 FROM DimSalesPerson WHERE SalesPersonUniqueID = - 1)
BEGIN
	SET IDENTITY_INSERT DimSalesPerson ON
	INSERT INTO DimSalesPerson (
		SalesPersonUniqueID
		, FirstName
		, MiddleName
		, LastName
		, FullName
		, NameSuffix
		, JobTitle
		, BirthDate
		, GenderCode
		, Gender
		, PhoneNumber
		, EmailAddress
		, SalesQuota
		, Bonus
		, CommissionPct
		, DateCreated
		, DateModified
	)
	VALUES (
		-1 
		, 'Unknown'
		, 'Unknown'
		, 'Unknown'
		, 'Unknown'
		, NULL
		, NULL
		, DATEFROMPARTS(9999,12,31)
		, NULL
		, 'Unknown'
		, 'Unknown'
		, NULL
		, NULL
		, 0
		, 0
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimSalesPerson OFF
END

-- Insert Dummy Dimension Values for NULL Sales Territory 

IF 
	EXISTS (SELECT 1 FROM DimSalesTerritory)
	AND NOT EXISTS (SELECT 1 FROM DimSalesTerritory WHERE SalesTerritoryUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimSalesTerritory ON
	INSERT INTO DimSalesTerritory (
		SalesTerritoryUniqueID
		, SalesTerritory
		, CountryCode
		, Country
		, TerritoryGroup
		, DateCreated
		, DateModified
	)
	VALUES (
		-1
		, NULL
		, NULL
		, 'Unkown'
		, 'Unkown'
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimSalesTerritory OFF
END 