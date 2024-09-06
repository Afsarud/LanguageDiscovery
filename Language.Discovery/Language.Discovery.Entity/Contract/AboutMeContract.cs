using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    [Serializable]
    public class AboutMeContract
    {
        [DataMember]
        public int AboutMeID { get; set; }
        [DataMember]
        public int AboutMeHeaderID { get; set; }
        [DataMember]
        public string AboutMe { get; set; }
        [DataMember]
        public string LanguageCode { get; set; }

    }
}
