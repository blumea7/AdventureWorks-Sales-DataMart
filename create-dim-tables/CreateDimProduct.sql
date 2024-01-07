USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo. DimProduct

-- Create DimProduct Table
CREATE TABLE dbo.DimProduct (
	ProductID int IDENTITY (1,1) NOT NULL -- Autoincrementing Surrogate Key
	, ProductCode nvarchar(25) NOT NULL -- Operational Product Key
	, SalelabeIndicator nvarchar(15) NOT NULL -- 1 = Saleable , 0 = Not Saleable
	, Color nvarchar(15) -- nvarchar(15)
	, StandardCost float NOT NULL
	, ListPrice float NOT NULL
	, Size nvarchar(5) 
	, SizeUnitMeasureCode nvarchar(3) 
	, SizeUnitMeasure dbo.NameType
	, [Weight] decimal (8,2) 
	, WeightUnitMeasureCode nvarchar(3) 
	, WeightUnitMeasure dbo.NameType
	, ProductLineCode nvarchar(2) -- R = Road, M = Mountain, T = Touring, S = Standard
	, ProductLine nvarchar(15)
	, ClassCode nvarchar(2) -- 	H = High, M = Medium, L = Low
	, Class nvarchar(10)
	, StyleCode nvarchar(2)
	, Style nvarchar(15) -- W = Womens, M = Mens, U = Universal
	, SubCategory dbo.NameType
	, Category dbo.NameType
	, Model dbo.NameType
	, SellStartDate date 
	, SellEndDate date
	, DateCreated date NOT NULL
	, DateModified date NOT NULL
	, CONSTRAINT PK_DimProduct_ProductID PRIMARY KEY CLUSTERED (ProductID ASC)
	, CONSTRAINT CK_DimProduct_ProductLineCode CHECK (
		ProductLineCode IN ('R', 'M', 'T', 'S') OR 
		ProductLineCode IS NULL
	)
	, CONSTRAINT CK_DimProduct_ProductLine CHECK (
		ProductLine IN ('Road', 'Mountain', 'Touring', 'Standard') OR 
		ProductLine IS NULL
	)
	, CONSTRAINT CK_DimProduct_ClassCode CHECK (
		ClassCode IN ('H', 'M', 'L') OR 
		ClassCode IS NULL
	)
	, CONSTRAINT CK_DimProduct_Class CHECK (
		Class IN ('High', 'Medium', 'Low') OR 
		Class IS NULL
	)
	, CONSTRAINT CK_DimProduct_StyleCode CHECK (
		StyleCode IN ('W', 'M', 'U') OR 
		StyleCode IS NULL
	)
	, CONSTRAINT CK_DimProduct_Style CHECK (
		Style IN ('Womens', 'Mens', 'Universal') OR 
		Style IS NULL
	)
	, CONSTRAINT CK_DimProduct_ListPrice CHECK (
		ListPrice >= 0.00
	)
)

-- Populate DimProduct with values
INSERT INTO dbo.DimProduct
SELECT
--	ProductID int IDENTITY (1,1) NOT NULL 
	ProductCode = pp.ProductNumber
	, SalelabeIndicator = CASE WHEN pp.FinishedGoodsFlag = 0 THEN 'Not Saleable'
						  WHEN pp.FinishedGoodsFlag = 1 THEN 'Saleable'
					      END 
	, Color = pp.Color
	, StandardCost = pp.StandardCost
	, ListPrice = pp.ListPrice
	, Size = pp.Size
	, SizeUnitMeasureCode = pp.SizeUnitMeasureCode
	, SizeUnitMeasure = pumSize.[Name]
	, [Weight] = pp.[Weight]
	, WeightUnitMeasureCode = pp.WeightUnitMeasureCode
	, WeightUnitMeasure = pumWeight.[Name]
	, ProductLineCode = pp.ProductLine
	, ProductLine = CASE WHEN pp.ProductLine = 'R' THEN 'Road'
						 WHEN pp.ProductLine = 'M' THEN 'Mountain'
						 WHEN pp.ProductLine = 'T' THEN 'Touring'
						 WHEN pp.ProductLine = 'S' THEN 'Standard'
					END
	, ClassCode = pp.Class
	, Class = CASE WHEN pp.Class = 'H' THEN 'High'
				   WHEN pp.Class= 'M' THEN 'Medium'
				   WHEN pp.Class = 'L' THEN 'Low'
			  END
	, StyleCode = pp.Style
	, Style = CASE WHEN pp.Style = 'W' THEN 'Womens'
				   WHEN pp.Style= 'M' THEN 'Mens'
				   WHEN pp.Style = 'U' THEN 'Universal'
			  END
	, SubCategory = ppsc.[Name]
	, Category = ppc.[Name]
	, Model = ppm.[Name]
	, SellStartDate = pp.SellStartDate
	, SellEndDate = pp.SellEndDate
	, DateCreated = GETDATE() 
	, DateModified = GETDATE()
FROM AdventureWorks2022.Production.Product pp 
INNER JOIN AdventureWorks2022.Production.UnitMeasure pumSize ON pumSize.UnitMeasureCode = pp.SizeUnitMeasureCode
INNER JOIN AdventureWorks2022.Production.UnitMeasure pumWeight ON pumWeight.UnitMeasureCode = pp.WeightUnitMeasureCode
INNER JOIN AdventureWorks2022.Production.ProductSubcategory ppsc ON ppsc.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN AdventureWorks2022.Production.ProductCategory ppc ON ppc.ProductCategoryID = ppsc.ProductCategoryID
INNER JOIN AdventureWorks2022.Production.ProductModel ppm ON ppm.ProductModelID = pp.ProductModelID

-- Check inserted data

SELECT TOP(10) * FROM dbo.DimProduct