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
    public class UserSearchContract
    {
        [DataMember]
        public long UserID { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string FirstName { get; set; }
        [DataMember]
        public string LastName { get; set; }
        [DataMember]
        public string Address { get; set; }
        [DataMember]
        public string Avatar { get; set; }
        [DataMember]
        public bool IsFriend { get; set; }
        [DataMember]
        public bool IsOnline { get; set; }
        [DataMember]
        public string StatusImage { get; set; }
        [DataMember]
        public string OnlineStatusText { get; set; }
        [DataMember]
        public int UnReadMessageCount { get; set; }
        [DataMember]
        public int SchoolID { get; set; }
        [DataMember]
        public bool IsReplied { get; set; }

        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public string StatusText { get; set; }
        [DataMember]
        public bool IsCanTalk { get; set; }

        [DataMember]
        public bool ShouldIncreaseNativeUsersList { get; set; }

        [DataMember]
        public string MailIcon { get; set; }

    }
}
