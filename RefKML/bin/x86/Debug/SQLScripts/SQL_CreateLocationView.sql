USE @proGresInstanceName
GO

/****** Object:  View [dbo].[kml_ConfigLocation]    Script Date: 03/30/2012 12:18:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[kml_ConfigLocation]

AS
SELECT     REPLACE(dbo.dataviewConfigLocationLevel1234_.LocationLevel1234ID, '_PK', '') AS LocationLevelID, @country AS Country, 
                      REPLACE(dbo.dataviewConfigLocationLevel1_.LocationLevel1Description, 'Ncountrycode ', '') AS LocationLevel1Description, 
                      dbo.dataviewConfigLocationLevel12_.LocationLevel2Description, dbo.dataviewConfigLocationLevel1234_.LocationLevel4Description
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
         Configuration = "(H (1[27] 4[21] 2[28] 3) )"
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
         Begin Table = "dataviewConfigLocationLevel1_"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dataviewConfigLocationLevel12_"
            Begin Extent = 
               Top = 6
               Left = 281
               Bottom = 121
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dataviewConfigLocationLevel123_"
            Begin Extent = 
               Top = 6
               Left = 524
               Bottom = 121
               Right = 729
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dataviewConfigLocationLevel1234_"
            Begin Extent = 
               Top = 151
               Left = 154
               Bottom = 266
               Right = 359
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
         Width = 2160
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3825
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'kml_ConfigLocation'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'kml_ConfigLocation'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'kml_ConfigLocation'
GO


