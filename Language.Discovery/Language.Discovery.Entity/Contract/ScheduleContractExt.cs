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
    public class ScheduleContractExt: ScheduleContract 
    {
        [DataMember]
        public string UserSchedule { get; set; }
        [DataMember]
        public string PartnerSchedule { get; set; }

        [DataMember]
        public string ScheduleJP { get; set; }
        [DataMember]
        public string ScheduleAU { get; set; }
        [DataMember]
        public string ScheduleUK { get; set; }
        [DataMember]
        public int UserSessionTime { get; set; }
        [DataMember]
        public int PartnerSessionTime { get; set; }
        [DataMember]
        public string Comment { get; set; }
        [DataMember]
        public string UserColor { get; set; } = "#FFFFFF";
        [DataMember]
        public string PartnerColor { get; set; } = "#FFFFFF";
        [DataMember]
        public string UserCountryCode { get; set; }
        [DataMember]
        public string PartnerCountryCode { get; set; }


    }
}
