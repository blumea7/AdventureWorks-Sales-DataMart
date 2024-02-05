USE MAU_AdventureWorks2022_DW
GO
-- Purpose of this script: To deal with unexpected null Foreign Keys in Fact Table.

-- Insert Dummy Dimension Values for NULL Currency
IF 
	EXISTS (SELECT 1 FROM DimCurrency)
	AND NOT EXISTS (SELECT 1 FROM DimCurrency WHERE CurrencyUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimCurrency ON
	ALTER TABLE DimCurrency ALTER COLUMN CurrencyCode nchar(3) NULL 
	INSERT INTO DimCurrency (
		CurrencyUniqueID
		, CurrencyCode
		, Currency
		, DateCreated
		, DateModified)
	VALUES(
		-1
		, NULL
		, NULL
		, GETDATE()
		, GETDATE()
		)
	SET IDENTITY_INSERT DimCurrency OFF
END


-- Insert Dummy Dimension Values for NULL Customer
IF 
	EXISTS (SELECT 1 FROM DimCustomer)
	AND NOT EXISTS (SELECT 1 FROM DimCustomer WHERE CustomerUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimCustomer ON
	ALTER TABLE DimCustomer ALTER COLUMN AccountNumber nvarchar(10) NULL
	ALTER TABLE DimCustomer ALTER COLUMN GeographyUniqueID int NULL
	ALTER TABLE DimCustomer ALTER COLUMN FullName nvarchar(150) NULL
	ALTER TABLE DimCustomer ALTER COLUMN EmailAddress nvarchar(50) NULL
	ALTER TABLE DimCustomer ALTER COLUMN PhoneNumber nvarchar(25) NULL
	ALTER TABLE DimCustomer ALTER COLUMN BirthDate date NULL
	ALTER TABLE DimCustomer ALTER COLUMN MaritalStatus nchar(1) NULL
	ALTER TABLE DimCustomer ALTER COLUMN GenderCode nchar(1) NULL
	ALTER TABLE DimCustomer ALTER COLUMN Gender nvarchar(10) NULL
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
	ALTER TABLE DimCustomerStore ALTER COLUMN SalesTerritoryUniqueID int NULL
	ALTER TABLE DimCustomerStore ALTER COLUMN SalesPersonUniqueID int NULL
	ALTER TABLE DimCustomerStore ALTER COLUMN AnnualSales int NULL
	ALTER TABLE DimCustomerStore ALTER COLUMN AnnualRevenue int NULL
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
	SET IDENTITY_INSERT DimCustomerStore OFF
END


-- Insert Dummy Dimension Values for NULL date
IF
	EXISTS (SELECT 1 FROM DimDate)
	AND NOT EXISTS (SELECT 1 FROM DimDate dd WHERE dd.DateKey = 99991231)
BEGIN
	ALTER TABLE DimDate ALTER COLUMN [Date] date NULL
	ALTER TABLE DimDate ALTER COLUMN [Year] int NULL
	ALTER TABLE DimDate ALTER COLUMN YearHalfID char(6) NULL
	ALTER TABLE DimDate ALTER COLUMN YearHalf int NULL
	ALTER TABLE DimDate ALTER COLUMN QuarterID char(6) NULL
	ALTER TABLE DimDate ALTER COLUMN [Quarter] int NULL
	ALTER TABLE DimDate ALTER COLUMN MonthID char(6) NULL
	ALTER TABLE DimDate ALTER COLUMN [Month] int NULL
	ALTER TABLE DimDate ALTER COLUMN [MonthName] varchar(10) NULL
	ALTER TABLE DimDate ALTER COLUMN ShortMonthName char(3) NULL
	ALTER TABLE DimDate ALTER COLUMN WeekID char(7) NULL
	ALTER TABLE DimDate ALTER COLUMN WeekOfYear int NULL
	ALTER TABLE DimDate ALTER COLUMN WeekOfMonth int NULL
	ALTER TABLE DimDate ALTER COLUMN [DayOfYear] int NULL
	ALTER TABLE DimDate ALTER COLUMN [DayOfMonth] int NULL
	ALTER TABLE DimDate ALTER COLUMN [DayOfWeek] int NULL
	ALTER TABLE DimDate ALTER COLUMN [DayName] varchar(10) NULL
	ALTER TABLE DimDate ALTER COLUMN ShortDayName char(3) NULL
	ALTER TABLE DimDate ALTER COLUMN CurrentDayIndicator varchar(16) NULL
	ALTER TABLE DimDate ALTER COLUMN HolidayIndicator varchar(15) NULL
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
		99991231
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
		, NULL
		, NULL
	)
END

-- Insert Dummy Dimension Values for NULL Geography Key
IF 
	EXISTS (SELECT 1 FROM DimGeography)
	AND NOT EXISTS (SELECT 1 FROM DimGeography WHERE GeographyUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimGeography ON 
	ALTER TABLE DimGeography ALTER COLUMN City nvarchar(30) NULL
	ALTER TABLE DimGeography ALTER COLUMN StateCode nvarchar(3) NULL
	ALTER TABLE DimGeography ALTER COLUMN [City-State] nvarchar(80) NULL
	ALTER TABLE DimGeography ALTER COLUMN CountryCode nvarchar(3) NULL
	ALTER TABLE DimGeography ALTER COLUMN SalesTerritoryGroup nvarchar(50) NULL
	ALTER TABLE DimGeography ALTER COLUMN PostalCode nvarchar(15) NULL
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
	SET IDENTITY_INSERT DimGeography OFF 
END

-- Insert Dummy Dimension Values for NULL Product Key
IF 
	EXISTS (SELECT 1 FROM DimProduct)
	AND NOT EXISTS (SELECT 1 FROM DimProduct WHERE ProductUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimProduct  ON
	ALTER TABLE DimProduct ALTER COLUMN ProductCode nvarchar(25) NULL
	ALTER TABLE DimProduct ALTER COLUMN SalelableIndicator nvarchar(15) NULL 
	ALTER TABLE DimProduct ALTER COLUMN StandardCost float NULL 
	ALTER TABLE DimProduct ALTER COLUMN ListPrice float NULL 
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

-- Insert Dummy Dimension Values for NULL Promo Key

IF 
	EXISTS (SELECT 1 FROM DimPromo)
	AND NOT EXISTS (SELECT 1 FROM DimPromo WHERE PromoUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimPromo ON
	ALTER TABLE DimPromo ALTER COLUMN Promo nvarchar(255) NULL
	ALTER TABLE DimPromo ALTER COLUMN DiscountPct float NULL
	ALTER TABLE DimPromo ALTER COLUMN [Type] nvarchar(50) NULL
	ALTER TABLE DimPromo ALTER COLUMN Category nvarchar(50) NULL
	ALTER TABLE DimPromo ALTER COLUMN StartDate date NULL
	ALTER TABLE DimPromo ALTER COLUMN EndDate date NULL
	ALTER TABLE DimPromo ALTER COLUMN MinQuantity int NULL
	ALTER TABLE DimPromo ALTER COLUMN MaxQuantity int NULL
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
	SET IDENTITY_INSERT DimPromo OFF
END

-- Insert Dummy Dimension Values for Null SalesPerson Key

IF 
	EXISTS (SELECT 1 FROM DimSalesPerson)
	AND NOT EXISTS (SELECT 1 FROM DimSalesPerson WHERE SalesPersonUniqueID = - 1)
BEGIN
	SET IDENTITY_INSERT DimSalesPerson ON
	ALTER TABLE DimSalesPerson ALTER COLUMN FullName nvarchar(150) NULL
	ALTER TABLE DimSalesPerson ALTER COLUMN BirthDate date NULL
	ALTER TABLE DimSalesPerson ALTER COLUMN GenderCode nchar(1) NULL
	ALTER TABLE DimSalesPerson ALTER COLUMN Gender nvarchar(10) NULL
	ALTER TABLE DimSalesPerson ALTER COLUMN PhoneNumber nvarchar(25) NULL
	ALTER TABLE DimSalesPerson ALTER COLUMN Bonus float NULL
	ALTER TABLE DimSalesPerson ALTER COLUMN CommissionPct float NULL
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
	SET IDENTITY_INSERT DimSalesPerson OFF
END

-- Insert Dummy Dimension Values for NULL Sales Territory Key

IF 
	EXISTS (SELECT 1 FROM DimSalesTerritory)
	AND NOT EXISTS (SELECT 1 FROM DimSalesTerritory WHERE SalesTerritoryUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimSalesTerritory ON
	ALTER TABLE DimSalesTerritory ALTER COLUMN CountryCode nvarchar(3) NULL
	ALTER TABLE DimSalesTerritory ALTER COLUMN Country nvarchar(50) NULL
	ALTER TABLE DimSalesTerritory ALTER COLUMN TerritoryGroup nvarchar(50) NULL
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
		, NULL
		, NULL
		, GETDATE()
		, GETDATE()
	)
	SET IDENTITY_INSERT DimSalesTerritory OFF
END 