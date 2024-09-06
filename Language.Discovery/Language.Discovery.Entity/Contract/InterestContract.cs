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
    public class InterestContract
    {
        [DataMember]
        public long InterestID { get; set; }
        [DataMember]
        public long WordMapID { get; set; }
        [DataMember]
        public string InterestName { get; set; }
        [DataMember]
        public string LanguageCode { get; set; }
    }
}
