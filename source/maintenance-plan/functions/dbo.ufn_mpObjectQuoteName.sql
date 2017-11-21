RAISERROR('Drop function: [dbo].[ufn_mpObjectQuoteName]', 10, 1) WITH NOWAIT
GO
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[ufn_mpObjectQuoteName]') AND xtype in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_mpObjectQuoteName]
GO
