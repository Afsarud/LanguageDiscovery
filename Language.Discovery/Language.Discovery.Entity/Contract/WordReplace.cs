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
    public class WordReplace
    {
        [DataMember]
        public long ID { get; set; }

        [DataMember]
        public string Word { get; set; }

        [DataMember]
        public string Sound { get; set; }
        [DataMember]
        public string ImageFile { get; set; }
    }
}
