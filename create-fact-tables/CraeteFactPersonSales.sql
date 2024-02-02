USE MAU_AdventureWorks2022_DW
GO

--SELECT * FROM AdventureWorks2022.Sales.SalesOrderDetail
--SELECT * FROM AdventureWorks2022.Sales.SalesOrderHeader 

;WITH ConvertedPrices AS  (
	SELECT 
		ssoh.SalesOrderID 
		, ssod.SalesOrderDetailID
		, ssoh.CurrencyRateID
	FROM AdventureWorks2022.Sales.SalesOrderDetail ssod
	INNER JOIN AdventureWorks2022.Sales.SalesOrderHeader ssoh ON ssoh.SalesOrderID = ssod.SalesOrderID

)

SELECT * FROM ConvertedPrices

SELECT TOP(100)
	SalesOrderUniqueID = ssod.SalesOrderID
	, SalesOrderNumber = ssoh.SalesOrderNumber -- Degenerate Key
	, PurchaseOrderNumber = ssoh.PurchaseOrderNumber -- Degenerate Key
	, ProductUniqueID = ddp.ProductUniqueID
	, PromoUniqueID = ddpromo.PromoUniqueID
	, Quantity = ssod.OrderQty
	, UnitPrice = ssod.UnitPrice
	, TotalOriginalPrice = ssod.OrderQty * ssod.UnitPrice -- Total Line Price before promo discount
	, UnitDiscountPercentage = ssod.UnitPriceDiscount
	, UnitDiscountAmount = ssod.UnitPrice * ssod.UnitPriceDiscount
	, TotalDiscountAmount = ssod.UnitPrice * ssod.UnitPriceDiscount * ssod.OrderQty
	, LineTotal = ssod.LineTotal  -- Total Line Price after promo discount
	, LineTaxAmount =  (ssod.LineTotal/ssoh.SubTotal)*ssoh.TaxAmt
	, LineFreight = (ssod.LineTotal/ssoh.SubTotal)*ssoh.Freight
	, LineTotalPayment = -- LineTotal + Line Tax Amount + LineFreight
		ssod.LineTotal 
		+ (ssod.LineTotal/ssoh.SubTotal)*ssoh.TaxAmt 
		+ (ssod.LineTotal/ssoh.SubTotal)*ssoh.Freight
FROM AdventureWorks2022.Sales.SalesOrderDetail ssod
INNER JOIN AdventureWorks2022.Production.Product pp ON pp.ProductID = ssod.ProductID
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimProduct ddp ON  ddp.ProductCode = pp.ProductNumber
INNER JOIN AdventureWorks2022.Sales.SpecialOffer sso ON sso.SpecialOfferID = ssod.SpecialOfferID
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimPromo ddpromo ON ddpromo.Promo = sso.[Description]
INNER JOIN AdventureWorks2022.Sales.SalesOrderHeader ssoh ON ssoh.SalesOrderID = ssod.SalesOrderID

