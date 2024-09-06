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
    public class FilterContract
    {
        [DataMember]
        public long FilterID { get; set; }

        [DataMember]
        public string FilterName { get; set; }

    }
}
