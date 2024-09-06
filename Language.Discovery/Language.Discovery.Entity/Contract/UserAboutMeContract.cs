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
    public class UserAboutMeContract
    {
        [DataMember]
        public int AboutMeID { get; set; }
        [DataMember]
        public long UserID { get; set; }
        [DataMember]
        public int AboutMeHeaderID { get; set; }
    }
}
