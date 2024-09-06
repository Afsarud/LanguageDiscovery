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
    public class CityContract
    {
        [DataMember]
        public int CityID { get; set; }
        [DataMember]
        public string CityName { get; set; }
        [DataMember]
        public int CountryID { get; set; }
        [DataMember]
        public int CityHeaderID { get; set; }
        [DataMember]
        public string LanguageCode { get; set; }
    }
}
