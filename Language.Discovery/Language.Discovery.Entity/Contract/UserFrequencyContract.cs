using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity.Contract
{
    [DataContract]
    [Serializable]
    public class UserFrequencyContract
    {
        [DataMember]
        public Int64 UserId { get; set; }
        [DataMember]
        public int MatchedCount { get; set; }
        [DataMember]
        public int NumberOfMatching { get; set; }
        [DataMember]
        public int Month { get; set; }
        [DataMember]
        public int Year { get; set; }

    }
}
