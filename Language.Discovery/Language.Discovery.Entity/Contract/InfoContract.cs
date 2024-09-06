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
    public class InfoContract
    {
        [DataMember]
        public Int64 InfoID { get; set; }
        [DataMember]
        public string InfoMessage { get; set; }
        [DataMember]
        public string InfoType { get; set; }
        [DataMember]
        public bool IsActive { get; set; }
        [DataMember]
        public string ImageFile { get; set; }
        [DataMember]
        public byte[] ImageBytes { get; set; }
    }
}
