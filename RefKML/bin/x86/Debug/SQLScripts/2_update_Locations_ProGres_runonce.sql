
-- *************Script to add new locationIds to configLocationLevel and kml_T_ConfigLocation***********

use [ProGres]

	-- ****** Adding to configLocationLevel   ******

DECLARE @SiteID nvarchar(5)
set @SiteID = (SELECT SiteID FROM configSiteID)

		-- ** Adding "Bire" **
	INSERT INTO [configLocationLevel]
           ([LocationLevelID]
           ,[SiteID]
           ,[LocationLevelDescription]
           ,[LocationLevelActive]
           ,[IsCamp]
           ,[CountryCode]
           ,[ParentID]
           ,[UserIDCreate]
           ,[CreateDate]
           ,[UserIDUpdate]
           ,[UpdateDate]
           ,[SiteIDCreate]
           ,[SiteIDUpdate]
           ,[SiteIDOwner]
           ,[OwnerDate]
           ,[SiteIDReplicate])
     VALUES
           ('LE0401011528',@SiteId,'Bire', 1, 0 ,null,'LE040101'
           ,'DataFix', getdate(),'DataFix',getdate()
           ,'LEBBE','LEBBE','LEBBE', getdate(), 'None')
            
      -- ** Adding "AL Faour" **
           
     INSERT INTO [configLocationLevel]
           ([LocationLevelID]
           ,[SiteID]
           ,[LocationLevelDescription]
           ,[LocationLevelActive]
           ,[IsCamp]
           ,[CountryCode]
           ,[ParentID]
           ,[UserIDCreate]
           ,[CreateDate]
           ,[UserIDUpdate]
           ,[UpdateDate]
           ,[SiteIDCreate]
           ,[SiteIDUpdate]
           ,[SiteIDOwner]
           ,[OwnerDate]
           ,[SiteIDReplicate])
     VALUES
           ('LE0215011099',@SiteId,'Al Faour', 1, 0 ,null,'LE021501'
           ,'DataFix', getdate(),'DataFix',getdate()
           ,'LEBBE','LEBBE','LEBBE', getdate(), 'None')

	-- ****** Adding to kml_T_ConfigLocation   ******

		-- ** Adding "Bire" **
    DELETE from [kml_TConfigLocation] where [LocationLevelID]='LE0401011528'
	INSERT INTO [kml_TConfigLocation]
           ([LocationLevelID]
           ,[Country]
           ,[LocationLevel1Description]
           ,[LocationLevel2Description]
           ,[LocationLevel4Description]
           ,[Longitude]
           ,[Latitude])
     VALUES
           ('LE0401011528','Lebanon','North', 'Akkar','Bire',36.239294,34.589291)
      
       -- ** Adding "AL Faour" **
    DELETE from [kml_TConfigLocation] where [LocationLevelID]='LE0215011099'
    
	INSERT INTO [kml_TConfigLocation]
           ([LocationLevelID]
           ,[Country]
           ,[LocationLevel1Description]
           ,[LocationLevel2Description]
           ,[LocationLevel4Description]
           ,[Longitude]
           ,[Latitude])
     VALUES
           ('LE0215011099','Lebanon','Bekaa', 'Zahle','Al Faour',35.97069241,33.78106187)

-- ***************** End of script *******************

USE [ProGres]


-- ** change TalBire to Bire **
UPDATE [dataAddress]
   SET 
       [LocationLevel4ID] = 'LE0401011528'
       
 WHERE [AddressType] = 'COA' and  [LocationLevel4ID] = 'LE0401011458'

-- ** change Mansoura (Bekaa) to Mansoura (Akkar) to Bire **

UPDATE [dataAddress]
   SET       
       [LocationLevel1ID] = 'LE04'
      ,[LocationLevel2ID] = 'LE0401'
      ,[LocationLevel3ID] = 'LE040101'
      ,[LocationLevel4ID] = 'LE0401011514'
       
 WHERE [AddressType] = 'COA' and  [LocationLevel4ID] = 'LE0217011016'

GO

