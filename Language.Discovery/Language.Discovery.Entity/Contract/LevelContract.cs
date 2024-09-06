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
    public class LevelContract
    {
        [DataMember]
        public long LevelID { get; set; }
        [DataMember]
        public string LevelName { get; set; }

    }
}
