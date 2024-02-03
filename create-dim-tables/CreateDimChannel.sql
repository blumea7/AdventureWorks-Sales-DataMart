USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.DimChannel

-- Create DimChannel Table
CREATE TABLE dbo.DimChannel (
	UniqueChannelID int IDENTITY(1,1)
	, ChannelCode nvarchar(5) UNIQUE NOT NULL
	, Channel dbo.NameType
	, DateCreated date NOT NULL
	, DateModified date NOT NULL
	, CONSTRAINT PK_DimChannel_UniqueChannelID PRIMARY KEY CLUSTERED (UniqueChannelID ASC)
)


-- Populate Table
INSERT INTO dbo.DimChannel
SELECT ChannelCode = 'IN' , Channel = 'Internet' , DateCreated = GETDATE() , DateModified = GETDATE()
UNION 
SELECT ChannelCode = 'SR' , Channel = 'Store Reseller' , DateCreated = GETDATE() , DateModified = GETDATE()


-- View Data
SELECT * FROM dbo.DimChannel