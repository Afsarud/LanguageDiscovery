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
    public class ScheduleContract
    {
        [DataMember]
        public int ScheduleId { get; set; }
        [DataMember]
        public DateTime Schedule { get; set; }
        [DataMember]
        public Int64 UserId { get; set; }
        [DataMember]
        public Int64? PartnerId { get; set; }
        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public string TimeSchedule { get; set; }
        [DataMember]
        public int GradeID { get; set; }
        [DataMember]
        public int MatchedCount { get; set; }
        [DataMember]
        public int NumberOfMatching { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string PartnerName { get; set; }
        [DataMember]
        public int? PartnerGradeID { get; set; }
        public Guid UserConfirmationToken { get; set; }
        [DataMember]
        public bool? IsUserConfirmed { get; set; }
        [DataMember]
        public DateTime? UserConfirmationDateTime { get; set; }
        [DataMember]
        public Guid PartnerConfirmationToken { get; set; }
        [DataMember]
        public bool? IsPartnerConfirmed { get; set; }
        [DataMember]
        public DateTime? PartnerConfirmationDateTime { get; set; }
        [DataMember]
        public int? PhraseCategoryID{ get; set; }
        [DataMember]
        public int? PartnerPhraseCategoryID { get; set; }

    }
}
