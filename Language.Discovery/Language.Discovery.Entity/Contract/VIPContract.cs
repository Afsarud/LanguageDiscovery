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
    public class VIPContract
    {
        [DataMember]
        public Int64 VipID { get; set; }
        [DataMember]
        public Int64 OwnerUserID { get; set; }
        [DataMember]
        public Int64 VIPUserID { get; set; }
    }
}
