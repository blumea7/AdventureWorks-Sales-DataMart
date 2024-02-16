USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.FactInternetSales

;WITH ConvertedPrices AS  ( -- Intermediate table to compute for converted prices
SELECT 
	SalesOrderID = ssoh.SalesOrderID 
	, SalesOrderDetailID = ssod.SalesOrderDetailID
	, ConvertedUnitPrice = 
		CASE WHEN scr.CurrencyRateID IS NULL THEN ssod.UnitPrice -- When CurrencyRateID is NULL, Price is already in USD. No need to convert.
			 ELSE ssod.UnitPrice / scr.AverageRate
		END
	, ConvertedLineTotal = 
		CASE WHEN scr.CurrencyRateID IS NULL THEN ssod.LineTotal -- When CurrencyRateID is NULL, Price is already in USD. No need to convert.
			ELSE ssod.LineTotal / scr.AverageRate
		END
	, CurrencyUniqueID = 100 -- ALL costs are converted to USD
	, ConvertedTaxAmount = 
		CASE WHEN scr.CurrencyRateID IS NULL THEN (ssoh.TaxAmt)*(ssod.LineTotal/ssoh.SubTotal)  -- When CurrencyRateID is NULL, Price is already in USD. No need to convert.
			 ELSE (ssoh.TaxAmt/scr.AverageRate)*(ssod.LineTotal/ssoh.SubTotal)
		END
	, ConvertedFreight = 
		CASE WHEN scr.CurrencyRateID IS NULL THEN (ssoh.Freight)*(ssod.LineTotal/ssoh.SubTotal)  -- When CurrencyRateID is NULL, Price is already in USD. No need to convert.
			 ELSE (ssoh.Freight/scr.AverageRate)*(ssod.LineTotal/ssoh.SubTotal)
		END
	, ConvertedProductCost = 
		CASE WHEN scr.CurrencyRateID IS NULL THEN pp.StandardCost
			 ELSE pp.StandardCost/scr.AverageRate
		END
FROM AdventureWorks2022.Sales.SalesOrderDetail ssod
INNER JOIN AdventureWorks2022.Sales.SalesOrderHeader ssoh ON ssoh.SalesOrderID = ssod.SalesOrderID
LEFT JOIN AdventureWorks2022.Sales.CurrencyRate scr ON scr.CurrencyRateID = ssoh.CurrencyRateID
LEFT JOIN MAU_AdventureWorks2022_DW.dbo.DimCurrency ddc ON ddc.CurrencyCode = scr.ToCurrencyCode
LEFT JOIN AdventureWorks2022.Production.Product pp ON pp.ProductID = ssod.ProductID
WHERE ssoh.OnlineOrderFlag = 1 -- get only Sales data from Internet
)

SELECT 
	OrderID = ssoh.SalesOrderNumber -- Degenerate Key 
	, SalesOrderDetailID = cp.SalesOrderDetailID -- DegenerateKey
	, PONumber = CASE WHEN ssoh.PurchaseOrderNumber IS NULL THEN 'NO PO Number'
					  ELSE ssoh.PurchaseOrderNumber
				 END
	, OrderDate = ddd1.DateKey
	, DueDate = ddd2.DateKey
	, ShipDate = ddd3.DateKey
	, CustomerKey = ddc.CustomerUniqueID
	, ProductKey = ddp.ProductUniqueID
	, CurrencyKey = cp.CurrencyUniqueID
	, PromoKey = ddp2.PromoUniqueID
	, UnitPrice = cp.ConvertedUnitPrice
	, Quantity = ssod.OrderQty
	, LinePrice = cp.ConvertedUnitPrice*ssod.OrderQty
	, Discount = ssod.UnitPriceDiscount
	, UnitPriceDiscount = ssod.UnitPriceDiscount * cp.ConvertedUnitPrice
	, LineDiscount =  ssod.UnitPriceDiscount * cp.ConvertedUnitPrice * ssod.OrderQty
	, SalesAmount = cp.ConvertedLineTotal
	, TaxAmount = cp.ConvertedTaxAmount
	, Freight = cp.ConvertedFreight
	, TotalDue = cp.ConvertedLineTotal + cp.ConvertedTaxAmount + cp.ConvertedFreight
	, UnitCost = cp.ConvertedProductCost
	, LineCost = cp.ConvertedProductCost * ssod.OrderQty
	, NetSalesAmount =  cp.ConvertedLineTotal - cp.ConvertedProductCost * ssod.OrderQty
INTO dbo.FactInternetSales -- automatically creates FactInternetSales table
FROM ConvertedPrices cp 
INNER JOIN AdventureWorks2022.Sales.SalesOrderHeader ssoh ON ssoh.SalesOrderID = cp.SalesOrderID
INNER JOIN AdventureWorks2022.Sales.SalesOrderDetail ssod ON ssod.SalesOrderDetailID = cp.SalesOrderDetailID
INNER JOIN AdventureWorks2022.Production.Product pp ON pp.ProductID = ssod.ProductID
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimProduct ddp ON ddp.ProductCode = pp.ProductNumber
INNER JOIN AdventureWorks2022.Sales.SpecialOffer sso ON sso.SpecialOfferID	= ssod.SpecialOfferID
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimPromo ddp2 ON ddp2.Promo = sso.[Description]
INNER JOIN AdventureWorks2022.Sales.Customer sc ON sc.CustomerID = ssoh.CustomerID 
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimCustomer ddc ON ddc.AccountNumber = sc.AccountNumber
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimDate ddd1 ON ddd1.[Date] = ssoh.OrderDate
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimDate ddd2 ON ddd2.[Date] = ssoh.DueDate
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimDate ddd3 ON ddd3.[Date] = ssoh.ShipDate

-- View Sample Date
SELECT TOP(10) * FROM dbo.FactInternetSales

