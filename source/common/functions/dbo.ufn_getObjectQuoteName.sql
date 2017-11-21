RAISERROR('Create function: [dbo].[ufn_getObjectQuoteName]', 10, 1) WITH NOWAIT
GO
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[ufn_getObjectQuoteName]') AND xtype in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_getObjectQuoteName]
GO

CREATE FUNCTION [dbo].[ufn_getObjectQuoteName]
(		
	@objectName	[nvarchar](1024),
	@quoteFor	[nvarchar](8) = NULL /* possible values: filter, xml, sql */
)
RETURNS [nvarchar](1024)
/* WITH ENCRYPTION */
AS

-- ============================================================================
-- Copyright (c) 2004-2017 Dan Andrei STEFAN (danandrei.stefan@gmail.com)
-- ============================================================================
-- Author			 : Dan Andrei STEFAN
-- Create date		 : 2004-2017
-- Module			 : Database Analysis & Performance Monitoring
-- ============================================================================

begin
	DECLARE @quoteName [sysname]

	IF @quoteFor = 'filter' OR @quoteFor IS NULL
		SET @quoteName = '[' + REPLACE(@objectName, ']', ']]') + ']'
	IF @quoteFor = 'sql' 
		SET @quoteName = REPLACE(@objectName, '''', '''''')
	IF @quoteFor = 'xml' 
		begin
			SET @quoteName = @objectName
			SET @quoteName = REPLACE(@quoteName, '&', '&amp;')
			SET @quoteName = REPLACE(@quoteName, '<', '&lt;')
			SET @quoteName = REPLACE(@quoteName, '>', '&gt;')
			SET @quoteName = REPLACE(@quoteName, '''', '&apos;')
			SET @quoteName = REPLACE(@quoteName, '"', '&quot;')
		end

	RETURN @quoteName
end
GO
