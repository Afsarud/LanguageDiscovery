using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace Language.Discovery.Repository
{
    public class ConfigSettings
    {
        public static string ConnectionString 
        { 
            get
            {
                return ConfigurationManager.ConnectionStrings["LanguageDiscoveryConnectionString"].ConnectionString;
            } 
            
        }
    }
}
