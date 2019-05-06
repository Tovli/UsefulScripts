DECLARE
	 @FromDt		DATETIME		= '2018-10-01'
	,@ToDt			DATETIME		= '2018-10-11'
	,@TraderID		INT				= 379169
	,@ChunkSize		INT				= 1000

USE MarketsPulse

SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DECLARE @LastCheckedID INT, @MsysTraderID INT
IF OBJECT_ID('tempdb..#Results') IS NOT NULL DROP TABLE #Results;
CREATE TABLE #Results (TradeActionID INT PRIMARY KEY, TradingTime DATETIME, LastCBMsysTransId INT NULL);
IF OBJECT_ID('tempdb..#Chunk') IS NOT NULL DROP TABLE #Chunk;
CREATE TABLE #Chunk (TradeActionID INT PRIMARY KEY, TradingTime DATETIME);

SELECT @MsysTraderID = tr.Id
FROM [MARKETING.HIGHLOWMGMT.NET].[MarketingSystem_1.4].[trade].[Trader] tr with (nolock)
join TP_PLAYERS AS pl with (nolock) on tr.Name = pl.player_name
WHERE pl.player_id = @TraderID


INSERT INTO #Chunk
SELECT TOP (@ChunkSize) TRADE_ACTION_ID, TRADING_TIME
FROM TFC_TRADE_ACTIONS
WHERE TRADING_TIME BETWEEN @FromDt AND @ToDt
AND TRADER_ID = @TraderID
ORDER BY TRADE_ACTION_ID ASC
OPTION (RECOMPILE);

SELECT @LastCheckedID = MAX(TradeActionID) FROM #Chunk;

WHILE @LastCheckedID IS NOT NULL
BEGIN
	RAISERROR(N'Chunk: %d', 0, 1, @LastCheckedID) WITH NOWAIT;

	INSERT INTO #Results
	SELECT c.TradeActionID, c.TradingTime, LastCBGivenTrans.Id AS LastCBMsysTransId
	FROM #Chunk AS c
	outer apply
	(
		select top 1 trans.Id, trans.ParamName, trans.OldValue, trans.NewValue, trans.Date
		FROM [MARKETING.HIGHLOWMGMT.NET].[MarketingSystem_1.4].[trade].[Transaction] trans with(nolock)
		where trans.ExternalTransId is null  -- This filter will return only record changed from: API, Screen, CSV or account created event
		and trans.ParamName in ('PendingCashbackMonthly', 'PendingCashback')
		and trans.TraderId = @MsysTraderID
		and trans.Date <= c.TradingTime
		order by trans.Date desc
	) LastCBGivenTrans
	WHERE
		NOT EXISTS (SELECT TOP 1 NULL
					FROM [MARKETING.HIGHLOWMGMT.NET].[MarketingSystem_1.4].[trade].[Transaction] AS t
					WHERE CONVERT(nvarchar(100), c.TradeActionID) = t.ExternalTransID
					)
		
	TRUNCATE TABLE #Chunk;

	INSERT INTO #Chunk
	SELECT TOP (@ChunkSize) TRADE_ACTION_ID, TRADING_TIME
	FROM TFC_TRADE_ACTIONS
	WHERE TRADING_TIME BETWEEN @FromDt AND @ToDt
	AND TRADE_ACTION_ID > @LastCheckedID
	AND TRADER_ID = @TraderID
	ORDER BY TRADE_ACTION_ID ASC
	OPTION (RECOMPILE);

	SET @LastCheckedID = NULL;
	SELECT @LastCheckedID = MAX(TradeActionID) FROM #Chunk;

END

select c.TradeActionID, c.TradingTime, c.LastCBMsysTransId, trans.ParamName, trans.OldValue, trans.NewValue, trans.Date
FROM [MARKETING.HIGHLOWMGMT.NET].[MarketingSystem_1.4].[trade].[Transaction] trans with(nolock)
INNER JOIN #Results AS c
ON trans.Id = c.LastCBMsysTransId
where trans.ExternalTransId is null  -- This filter will return only record changed from: API, Screen, CSV or account created event
and trans.ParamName in ('PendingCashbackMonthly', 'PendingCashback')
and trans.TraderId = @MsysTraderID
order by trans.Date desc
OPTION (RECOMPILE)

--SELECT * FROM #Results