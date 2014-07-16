-- V_ForKML is modified with each KML Generated depending on Location Level
USE [NproGresInstanceName]
GO
IF EXISTS (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME='v_forKml') DROP view [v_forKml]
GO

USE [NproGresInstanceName]
/****** Object:  View [dbo].[v_forKml]    Script Date: 04/10/2012 10:34:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_forKml]
AS
SELECT     CASE WHEN dbo.kml_TConfigLocation.LocationLevelID IS NULL THEN '000000' ELSE dbo.kml_TConfigLocation.LocationLevelID END AS Expr1, 
                      CASE WHEN dbo.Case_AddressCoA.LocationLevel[ReplaceInCodeLLID]Description IS NULL 
                      THEN 'Village Location Not Defined' ELSE dbo.Case_AddressCoA.LocationLevel[ReplaceInCodeLLID]Description END AS Location, 
                      CASE WHEN dbo.kml_TConfigLocation.Longitude IS NULL THEN 'NaLocationLongitude' ELSE dbo.kml_TConfigLocation.Longitude END AS Longitude, 
                      CASE WHEN dbo.kml_TConfigLocation.Latitude IS NULL THEN 'NaLocationLatitude' ELSE dbo.kml_TConfigLocation.Latitude END AS Latitude, 
                      SUM(CASE WHEN dbo.vIndividual.RelationshipToPrincipalRepresentative = 'pa' THEN 1 ELSE 0 END) AS Cases, COUNT(dbo.vIndividual.IndividualID) 
                      AS Persons, SUM(CASE WHEN dbo.vIndividual.sexcode = 'F' THEN 1 ELSE 0 END) AS Female, 
                      SUM(CASE WHEN dbo.vIndividual.sexcode = 'M' THEN 1 ELSE 0 END) AS Male, SUM(CASE WHEN dbo.vIndividual.sexcode = 'F' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 0 AND 4 THEN 1 ELSE 0 END) AS F0_4, SUM(CASE WHEN dbo.vIndividual.sexcode = 'F' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 5 AND 11 THEN 1 ELSE 0 END) AS F5_11, SUM(CASE WHEN dbo.vIndividual.sexcode = 'F' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS F12_17, SUM(CASE WHEN dbo.vIndividual.sexcode = 'F' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 18 AND 59 THEN 1 ELSE 0 END) AS F18_59, SUM(CASE WHEN dbo.vIndividual.sexcode = 'F' AND 
                      dbo.vIndividual.IndividualAge > 59 THEN 1 ELSE 0 END) AS F60_plus, SUM(CASE WHEN dbo.vIndividual.sexcode = 'M' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 0 AND 4 THEN 1 ELSE 0 END) AS M0_4, SUM(CASE WHEN dbo.vIndividual.sexcode = 'M' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 5 AND 11 THEN 1 ELSE 0 END) AS M5_11, SUM(CASE WHEN dbo.vIndividual.sexcode = 'M' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS M12_17, SUM(CASE WHEN dbo.vIndividual.sexcode = 'M' AND 
                      dbo.vIndividual.IndividualAge BETWEEN 18 AND 59 THEN 1 ELSE 0 END) AS M18_59, SUM(CASE WHEN dbo.vIndividual.sexcode = 'M' AND 
                      dbo.vIndividual.IndividualAge > 59 THEN 1 ELSE 0 END) AS M60_plus, NULL AS Description
FROM         dbo.vIndividual INNER JOIN
                      dbo.Case_AddressCoA ON dbo.vIndividual.ProcessingGroupNumber = dbo.Case_AddressCoA.ProcessingGroupNumber LEFT OUTER JOIN
                      dbo.kml_TConfigLocation ON dbo.Case_AddressCoA.LocationLevel[ReplaceInCodeLLID]ID = dbo.kml_TConfigLocation.LocationLevelID
WHERE     (dbo.vIndividual.ProcessStatusCode = N'a') and (dbo.vIndividual.OriginCountryCode like N'%CoOCode%') and (dbo.vIndividual.ReligionCode like N'%CReligionCode%') and (dbo.Vindividual.IndividualAge Between CAgeFrom and CAgeTo)

GROUP BY dbo.kml_TConfigLocation.Longitude, dbo.kml_TConfigLocation.Latitude, dbo.Case_AddressCoA.LocationLevel[ReplaceInCodeLLID]Description, 
                  dbo.kml_TConfigLocation.LocationLevelID

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[25] 2[21] 3) )"
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
         Begin Table = "vIndividual"
            Begin Extent = 
               Top = 0
               Left = 8
               Bottom = 313
               Right = 305
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Case_AddressCoA"
            Begin Extent = 
               Top = 35
               Left = 374
               Bottom = 270
               Right = 593
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "kml_TConfigLocation"
            Begin Extent = 
               Top = 37
               Left = 660
               Bottom = 152
               Right = 881
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
      Begin ColumnWidths = 20
         Width = 284
         Width = 1710
         Width = 1860
         Width = 1305
         Width = 1650
         Width = 765
         Width = 705
         Width = 525
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
      Begin ColumnWidths = 12
         Column = 3480
         Alias = 1185
         Table = 2085
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_forKml'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_forKml'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_forKml'
GO



	
