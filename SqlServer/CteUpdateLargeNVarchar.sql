DECLARE @keyTable TABLE (ID int, value nvarchar(max));
DECLARE @nameTable TABLE (ID int, name nvarchar(200));
DECLARE @username nvarchar(100);
DECLARE @rowCount int = 0  ,@currentRow int = 1
INSERT INTO @nameTable
SELECT 1, '%John Doe%' ;

--select * from @nameTable;

SELECT @rowCount = COUNT(*) FROM @nameTable;

WHILE (@currentRow <= @rowCount)

BEGIN

SELECT @username = name FROM @nameTable
WHERE ID = @currentRow;
SET @currentRow = @currentRow + 1;

	DECLARE @Error int;

	BEGIN TRANSACTION

		INSERT INTO @keyTable
		SELECT ld.LOG_DTL_ID, ld.KEY_VAL_PAIR
		FROM  LOGGING.LOG_DETAIL ld with (nolock) INNER JOIN
			LOGGING.LOGS l ON ld.LOG_ID = l.LOG_ID
		WHERE (l.CDP_ID = 15) 
		AND ld.CRTE_DTTM BETWEEN '2016-12-15' AND '2017-12-01'
		AND	ld.KEY_VAL_PAIR LIKE  @username ;
		
		SELECT * FROM @keyTable
		SELECT @username = REPLACE(@username, '%','');
--		SELECT 'username: '+ @username;

		--select REPLACE(value, @username, '') from @keyTable;

		WITH cte AS (SELECT * FROM @keyTable)
		UPDATE LOGGING.LOG_DETAIL
		SET KEY_VAL_PAIR = REPLACE(x.value, @username, '')
		FROM cte as x
		WHERE LOGGING.LOG_DETAIL.LOG_DTL_ID  = x.ID;

	SET @Error = @@ERROR;

	IF (@Error<> 0)
		GOTO Error_Handler;
		SELECT 'COMMIT';
	COMMIT TRANSACTION

	Error_Handler:
	IF @Error <> 0
	BEGIN
	SELECT 'ROLLBACK';
	ROLLBACK TRANSACTION;
	END

END



