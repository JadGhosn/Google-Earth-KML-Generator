USE [NproGresInstanceName]
GO
GO
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='kml_ConfigLocation_All') DROP view [kml_ConfigLocation_All]

/****** Object:  View [dbo].[kml_ConfigLocation]    Script Date: 03/30/2012 12:18:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/****** Object:  View [dbo].[kml_ConfigLocation_All]    Script Date: 04/18/2012 14:58:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[kml_ConfigLocation_All]
AS
SELECT     REPLACE(LocationLevel1ID, '_PK', '') AS LocationLevelID, 'FCountryname' AS Country, REPLACE(LocationLevel1Description, 'Ncountrycode ', '') 
                      AS LocationLevel1Description, '' AS LocationLevel2Description, '' AS LocationLevel3Description, '' AS LocationLevel4Description
FROM         dbo.dataviewConfigLocationLevel1_
WHERE     (LocationLevel1ID LIKE 'Ncountrycode%')
union 
SELECT     REPLACE(dbo.dataviewConfigLocationLevel12_.LocationLevel12ID, '_PK', '') AS LocationLevelID, 'FCountryname' AS Country, 
                      REPLACE(dbo.dataviewConfigLocationLevel1_.LocationLevel1Description, 'Ncountrycode ', '') AS LocationLevel1Description, 
                      dbo.dataviewConfigLocationLevel12_.LocationLevel2Description, '' AS LocationLevel3Description, '' AS asLocationLevel4Description
FROM         dbo.dataviewConfigLocationLevel1_ INNER JOIN
                      dbo.dataviewConfigLocationLevel12_ ON 
                      dbo.dataviewConfigLocationLevel1_.LocationLevel1ID = dbo.dataviewConfigLocationLevel12_.LocationLevel1ID
WHERE     (dbo.dataviewConfigLocationLevel1_.LocationLevel1ID LIKE 'Ncountrycode%')
union
SELECT     REPLACE(dbo.dataviewConfigLocationLevel123_.LocationLevel123ID, '_PK', '') AS LocationLevelID, 'FCountryname' AS Country, 
                      REPLACE(dbo.dataviewConfigLocationLevel1_.LocationLevel1Description, 'Ncountrycode ', '') AS LocationLevel1Description, 
                      dbo.dataviewConfigLocationLevel12_.LocationLevel2Description, dbo.dataviewConfigLocationLevel123_.LocationLevel3Description, 
                      '' AS LocationLevel4Description
FROM         dbo.dataviewConfigLocationLevel1_ INNER JOIN
                      dbo.dataviewConfigLocationLevel12_ ON 
                      dbo.dataviewConfigLocationLevel1_.LocationLevel1ID = dbo.dataviewConfigLocationLevel12_.LocationLevel1ID INNER JOIN
                      dbo.dataviewConfigLocationLevel123_ ON 
                      dbo.dataviewConfigLocationLevel1_.LocationLevel1ID = dbo.dataviewConfigLocationLevel123_.LocationLevel1ID AND 
                      dbo.dataviewConfigLocationLevel12_.LocationLevel2ID = dbo.dataviewConfigLocationLevel123_.LocationLevel2ID
WHERE     (dbo.dataviewConfigLocationLevel1_.LocationLevel1ID LIKE 'Ncountrycode%')
union
SELECT     REPLACE(dbo.dataviewConfigLocationLevel1234_.LocationLevel1234ID, '_PK', '') AS LocationLevelID, 'FCountryname' AS Country, 
                      REPLACE(dbo.dataviewConfigLocationLevel1_.LocationLevel1Description, 'Ncountrycode ', '') AS LocationLevel1Description, 
                      dbo.dataviewConfigLocationLevel12_.LocationLevel2Description, dbo.dataviewConfigLocationLevel123_.LocationLevel3Description, 
                      dbo.dataviewConfigLocationLevel1234_.LocationLevel4Description
FROM         dbo.dataviewConfigLocationLevel1_ INNER JOIN
                      dbo.dataviewConfigLocationLevel12_ ON 
                      dbo.dataviewConfigLocationLevel1_.LocationLevel1ID = dbo.dataviewConfigLocationLevel12_.LocationLevel1ID INNER JOIN
                      dbo.dataviewConfigLocationLevel123_ ON 
                      dbo.dataviewConfigLocationLevel1_.LocationLevel1ID = dbo.dataviewConfigLocationLevel123_.LocationLevel1ID AND 
                      dbo.dataviewConfigLocationLevel12_.LocationLevel2ID = dbo.dataviewConfigLocationLevel123_.LocationLevel2ID INNER JOIN
                      dbo.dataviewConfigLocationLevel1234_ ON 
                      dbo.dataviewConfigLocationLevel1_.LocationLevel1ID = dbo.dataviewConfigLocationLevel1234_.LocationLevel1ID AND 
                      dbo.dataviewConfigLocationLevel12_.LocationLevel2ID = dbo.dataviewConfigLocationLevel1234_.LocationLevel2ID AND 
                      dbo.dataviewConfigLocationLevel123_.LocationLevel3ID = dbo.dataviewConfigLocationLevel1234_.LocationLevel3ID
WHERE     (dbo.dataviewConfigLocationLevel1_.LocationLevel1ID LIKE 'Ncountrycode%')


GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[25] 2[37] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'kml_ConfigLocation_All'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'kml_ConfigLocation_All'
GO



USE [NproGresInstanceName]
Go
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.Tables WHERE TABLE_NAME='kml_TConfigLocation') DROP Table [kml_TConfigLocation]	

SELECT [LocationLevelID]
      ,[Country]
      ,[LocationLevel1Description]
      ,[LocationLevel2Description]
      ,[LocationLevel3Description]
      ,[LocationLevel4Description]
      ,cast(0.0 as float) as Longitude
      ,cast (0.0 as float) as Latitude
      into kml_TConfigLocation
  FROM [kml_ConfigLocation_All]
  
  
  USE [NproGresInstanceName]
Go


IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='Case_AddressCoA') DROP view [Case_AddressCoA]

USE [NproGresInstanceName]
GO

/****** Object:  View [dbo].[Case_AddressCoA]    Script Date: 04/04/2012 17:36:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Case_AddressCoA]
AS
SELECT     dbo.vIndividual.ProcessingGroupNumber, dbo.vdataAddressCOA.SiteIDOwner, dbo.vdataAddressCOA.AddressComments, 
                      dbo.vdataAddressCOA.AddressEmail, dbo.vdataAddressCOA.AddressPhone, dbo.vdataAddressCOA.LocationLevel6, 
                      dbo.vdataAddressCOA.LocationLevel5ID, dbo.vdataAddressCOA.LocationLevel4ID, dbo.vdataAddressCOA.LocationLevel3ID, 
                      dbo.vdataAddressCOA.LocationLevel2ID, dbo.vdataAddressCOA.LocationLevel1ID, dbo.vdataAddressCOA.LocationLevel5Description, 
                      dbo.vdataAddressCOA.LocationLevel4Description, dbo.vdataAddressCOA.LocationLevel3Description, 
                      dbo.vdataAddressCOA.LocationLevel2Description, dbo.vdataAddressCOA.LocationLevel1Description, dbo.vdataAddressCOA.AddressPostal, 
                      dbo.vdataAddressCOA.AddressCountry, dbo.vdataAddressCOA.AddressRegion, dbo.vdataAddressCOA.IamHereNow, 
                      dbo.vdataAddressCOA.ReportLocationCode, dbo.vdataAddressCOA.AddressType
FROM         dbo.vdataAddressCOA INNER JOIN
                      dbo.vIndividual ON dbo.vdataAddressCOA.IndividualGUID = dbo.vIndividual.IndividualGUID
WHERE     (dbo.vIndividual.RelationshipToPrincipalRepresentative = N'pa')

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[20] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "vdataAddressCOA"
            Begin Extent = 
               Top = 1
               Left = 344
               Bottom = 260
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "vIndividual"
            Begin Extent = 
               Top = 10
               Left = 6
               Bottom = 322
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2295
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Case_AddressCoA'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Case_AddressCoA'
GO

