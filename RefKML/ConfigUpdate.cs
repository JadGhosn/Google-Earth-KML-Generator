using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace RefKML
{
    class ConfigUpdate
    {
        public static void ChangeConfig(string Setting,string value)
        {
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            KeyValueConfigurationCollection settings = config.AppSettings.Settings;

            // update SaveBeforeExit
            settings[Setting].Value = value;

            //save the file
            config.Save(ConfigurationSaveMode.Modified);
            //relaod the section you modified
            ConfigurationManager.RefreshSection(config.AppSettings.SectionInformation.Name);
        }

      
    }
}
