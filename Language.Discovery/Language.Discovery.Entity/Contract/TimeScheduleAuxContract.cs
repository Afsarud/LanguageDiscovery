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
    public class TimeScheduleAuxContract
    {
        [DataMember]
        public int TimeId { get; set; }
        [DataMember]
        public string TimeSchedule { get; set; }
        [DataMember]
        public bool Active { get; set; }
        [DataMember]
        public int MaxSlot { get; set; }
        [DataMember]
        public string SlotsAvailable { get; set; }
        [DataMember]
        public DateTime ActualDateTime { get; set; }
        [DataMember]
        public bool HasSchedule { get; set; }
        [DataMember]
        public bool HasMatched { get; set; }
        [DataMember]
        public bool DisableRegisterButton { get; set; }
        [DataMember]
        public string CountryIds { get; set; }
        [DataMember]
        public bool HasPartner { get; set; }
        [DataMember]
        public DateTime CustomDate { get; set; }

    }
}
