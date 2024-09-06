using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    public class UserTalkHistory
    {
        [DataMember]
        public int UserTalkHistoryID { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public DateTime StartDate { get; set; }
        [DataMember]
        public DateTime EndDate { get; set; }
        [DataMember]
        public int TimeSpent { get; set; }
        [DataMember]
        public string PartnerUserName { get; set; }

    }
}
