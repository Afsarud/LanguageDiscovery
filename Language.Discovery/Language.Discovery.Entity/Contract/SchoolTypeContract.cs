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
    public class SchoolTypeContract
    {
        [DataMember]
        public int SchoolTypeID { get; set; }
        [DataMember]
        public string SchoolTypeName { get; set; }
        [DataMember]
        public bool IsDemo { get; set; }

    }
}
