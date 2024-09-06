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
    public class UserTypeContract
    {
        [DataMember]
        public int UserTypeID { get; set; }
        [DataMember]
        public string UserTypeName { get; set; }
    }
}
