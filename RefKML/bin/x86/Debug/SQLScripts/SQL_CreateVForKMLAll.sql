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
                      CASE WHEN dbo.AllCase_AddressCoA.LocationLevel[ReplaceInCodeLLID]Description IS NULL 
                      THEN 'Village Location Not Defined' ELSE dbo.AllCase_AddressCoA.LocationLevel[ReplaceInCodeLLID]Description END AS Location, 
                      CASE WHEN dbo.kml_TConfigLocation.Longitude IS NULL THEN 'NaLocationLongitude' ELSE dbo.kml_TConfigLocation.Longitude END AS Longitude, 
                      CASE WHEN dbo.kml_TConfigLocation.Latitude IS NULL THEN 'NaLocationLatitude' ELSE dbo.kml_TConfigLocation.Latitude END AS Latitude, 
                      SUM(CASE WHEN dbo.AllVindividual.RelationshipToPrincipalRepresentative = 'pa' THEN 1 ELSE 0 END) AS Cases, COUNT(dbo.AllVindividual.IndividualID) 
                      AS Persons, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'F' THEN 1 ELSE 0 END) AS Female, 
                      SUM(CASE WHEN dbo.AllVindividual.sexcode = 'M' THEN 1 ELSE 0 END) AS Male, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'F' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 0 AND 4 THEN 1 ELSE 0 END) AS F0_4, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'F' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 5 AND 11 THEN 1 ELSE 0 END) AS F5_11, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'F' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS F12_17, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'F' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 18 AND 59 THEN 1 ELSE 0 END) AS F18_59, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'F' AND 
                      dbo.AllVindividual.IndividualAge > 59 THEN 1 ELSE 0 END) AS F60_plus, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'M' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 0 AND 4 THEN 1 ELSE 0 END) AS M0_4, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'M' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 5 AND 11 THEN 1 ELSE 0 END) AS M5_11, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'M' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS M12_17, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'M' AND 
                      dbo.AllVindividual.IndividualAge BETWEEN 18 AND 59 THEN 1 ELSE 0 END) AS M18_59, SUM(CASE WHEN dbo.AllVindividual.sexcode = 'M' AND 
                      dbo.AllVindividual.IndividualAge > 59 THEN 1 ELSE 0 END) AS M60_plus, NULL AS Description
FROM         dbo.AllVindividual INNER JOIN
                      dbo.AllCase_AddressCoA ON dbo.AllVindividual.ProcessingGroupNumber = dbo.AllCase_AddressCoA.ProcessingGroupNumber LEFT OUTER JOIN
                      dbo.kml_TConfigLocation ON dbo.AllCase_AddressCoA.LocationLevel[ReplaceInCodeLLID]ID = dbo.kml_TConfigLocation.LocationLevelID
WHERE     dbo.AllVindividual.ProcessStatusCode = N'a' 
and dbo.AllVindividual.OriginCountryCode like N'%CoOCode%' 
and dbo.AllVindividual.ReligionCode like N'%CReligionCode%'
and dbo.AllVindividual.IndividualAge Between CAgeFrom and CAgeTo

GROUP BY dbo.kml_TConfigLocation.Longitude, dbo.kml_TConfigLocation.Latitude, dbo.AllCase_AddressCoA.LocationLevel[ReplaceInCodeLLID]Description, 
                  dbo.kml_TConfigLocation.LocationLevelID

GO


	
