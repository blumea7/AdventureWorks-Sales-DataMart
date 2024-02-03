USE MAU_AdventureWorks2022_DW
GO
-- EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

-- Insert Dummy Dimension Attribute for NULL Currency
IF 
	EXISTS (SELECT 1 FROM DimCurrency)
	AND NOT EXISTS (SELECT 1 FROM DimCurrency WHERE CurrencyUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimCurrency ON
	ALTER TABLE DimCurrency NOCHECK CONSTRAINT ALL
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
	ALTER TABLE DimCurrency WITH CHECK CHECK CONSTRAINT ALL
END


-- Insert Dummy Dimension Attribute for NULL Customer
IF 
	EXISTS (SELECT 1 FROM DimCustomer)
	AND NOT EXISTS (SELECT 1 FROM DimCustomer WHERE CustomerUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimCustomer ON
--	ALTER TABLE DimCustomer NOCHECK CONSTRAINT ALL
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
--	ALTER TABLE DimCustomer WITH CHECK CHECK CONSTRAINT ALL
END


-- Insert Dummy Dimension Attribute for NULL Store Reseller
IF 
	EXISTS (SELECT 1 FROM DimCustomerStore) 
	AND NOT EXISTS (SELECT 1 FROM DimCustomerStore WHERE StoreUniqueID = -1)
BEGIN
	SET IDENTITY_INSERT DimCustomerStore ON
	ALTER TABLE DimCustomerStore NOCHECK CONSTRAINT ALL 
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
	ALTER TABLE DimCustomerStore WITH CHECK CHECK CONSTRAINT ALL 
END

--EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'