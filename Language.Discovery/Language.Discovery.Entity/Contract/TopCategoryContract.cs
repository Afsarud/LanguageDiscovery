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
    public class TopCategoryContract
    {
        [DataMember]
        public int TopCategoryID { get; set; }
        [DataMember]
        public int TopCategoryHeaderID { get; set; }
        [DataMember]
        public string TopCategoryName { get; set; }
        [DataMember]
        public string LanguageCode { get; set; }
        [DataMember]
        public bool IsMain { get; set; }
        [DataMember]
        public bool IsDefault { get; set; }
        [DataMember]
        public bool IsTalk { get; set; }
    }
}
