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
    public class MatchContract
    {
        [DataMember]
        public int ScheduleId { get; set; }
        [DataMember]
        public Int64 UserId { get; set; }
        [DataMember]
        public string Name { get; set; }
        public Int64 PartnerId { get; set; }
        [DataMember]
        public string PartnerName { get; set; }
        [DataMember]
        public int Grade { get; set; }
        [DataMember]
        public int PartnerGrade { get; set; }
        [DataMember]
        public string Gender { get; set; }
        [DataMember]
        public string PartnerGender { get; set; }
        [DataMember]
        public string Country { get; set; }
        [DataMember]
        public string PartnerCountry{ get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string PartnerUserName { get; set; }
        [DataMember]
        public string Password { get; set; }
        [DataMember]
        public string PartnerPassword { get; set; }
        [DataMember]
        public DateTime Schedule { get; set; }
        [DataMember]
        public string UserLinkKey { get; set; }
        [DataMember]
        public string PartnerLinkKey { get; set; }
        [DataMember]
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
        public string UserTopic { get; set; }
        [DataMember]
        public string PartnerTopic { get; set; }


    }
}
