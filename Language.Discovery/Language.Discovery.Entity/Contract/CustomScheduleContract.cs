using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;

namespace Language.Discovery.Entity.Contract
{
    [DataContract]
    [Serializable]
    public class CustomScheduleContract
    {
        [DataMember]
        public long CustomScheduleId { get; set; }
        [DataMember]
        public int TimeId { get; set; }
        [DataMember]
        public string TimeSchedule { get; set; }
        [DataMember]
        public DateTime CustomDate { get; set; }
        [DataMember]
        public String Day { get; set; }

        [DataMember]
        public String CountryIds { get; set; }

        [DataMember]
        public string TimeIds { get; set; }
        [DataMember]
        public string ScheduleAU { get; set; }
        [DataMember]
        public string ScheduleUK { get; set; }


    }
}
