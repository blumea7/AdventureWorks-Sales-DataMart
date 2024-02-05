USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo. DimProduct

-- Create DimProduct Table
CREATE TABLE dbo.DimProduct (
	ProductUniqueID int IDENTITY (1,1) NOT NULL -- Autoincrementing Surrogate Key
	, ProductCode nvarchar(25) NOT NULL -- Operational Product Key
	, ProductName dbo.NameType
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
	, IsActive int -- 1 = Active, 0 = Not Active
	, DateCreated date NOT NULL
	, DateModified date NOT NULL
	, CONSTRAINT PK_DimProduct_ProductID PRIMARY KEY CLUSTERED (ProductUniqueID ASC)
)


-- Populate DimProduct with values
INSERT INTO dbo.DimProduct
SELECT
--	ProductUniqueID int IDENTITY (1,1) NOT NULL 
	ProductCode = pp.ProductNumber
	, ProductName = pp.[Name]
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
	, IsActive = CASE WHEN pp.SellStartDate <= GETDATE() AND (pp.SellEndDate IS NULL OR pp.SellEndDate >= GETDATE()) THEN 1
					  WHEN pp.SellStartDate > GETDATE() OR pp.SellStartDate IS NULL OR pp.SellEndDate < GETDATE() THEN 0
				 END
	, DateCreated = GETDATE() 
	, DateModified = GETDATE()
FROM AdventureWorks2022.Production.Product pp 
LEFT JOIN AdventureWorks2022.Production.UnitMeasure pumSize ON pumSize.UnitMeasureCode = pp.SizeUnitMeasureCode
LEFT JOIN AdventureWorks2022.Production.UnitMeasure pumWeight ON pumWeight.UnitMeasureCode = pp.WeightUnitMeasureCode
LEFT JOIN AdventureWorks2022.Production.ProductSubcategory ppsc ON ppsc.ProductSubcategoryID = pp.ProductSubcategoryID
INNER JOIN AdventureWorks2022.Production.ProductCategory ppc ON ppc.ProductCategoryID = ppsc.ProductCategoryID
LEFT JOIN AdventureWorks2022.Production.ProductModel ppm ON ppm.ProductModelID = pp.ProductModelID

-- Check inserted data

SELECT TOP(10) * FROM dbo.DimProduct