using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    public class UserTalkSubscription
    {
        [DataMember]
        public int UserTalkSubscriptionID { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string PartnerUserName { get; set; }
        [DataMember]
        public int SessionTime { get; set; }
        [DataMember]
        public int BalanceTime { get; set; }
        [DataMember]
        public int TotalTime { get; set; }
        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public bool IsActive { get; set; }
    }
}
