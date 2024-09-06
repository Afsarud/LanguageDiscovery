using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    public class DiscoverNewFriendsDTO
    {
        [DataMember]
        public List<int> InterestIDs { get; set; }
        [DataMember]
        public long SearcheeID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string CityID { get; set; }
        [DataMember]
        public List<string> GenderList { get; set; }
    }
}
