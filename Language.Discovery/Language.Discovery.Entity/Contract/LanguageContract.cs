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
    public class LanguageContract
    {
        [DataMember]
        public long LanguageID { get; set; }
        [DataMember]
        public string LanguageCode { get; set; }
        [DataMember]
        public string LanguageName { get; set; }
        [DataMember]
        public string SubLanguageCode { get; set; }
        [DataMember]
        public string SubLanguageCode2 { get; set; }
        [DataMember]
        public int CountryID { get; set; }
    }
}
