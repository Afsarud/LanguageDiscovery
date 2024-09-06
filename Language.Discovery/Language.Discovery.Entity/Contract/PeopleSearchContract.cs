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
    public class PeopleSearchContract
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
        public string OnlineStatusText { get; set; }
        [DataMember]
        public string StatusText { get; set; }
        [DataMember]
        public DateTime StatusDate { get; set; }
        [DataMember]
        public string StatusDateText { get; set; }
        [DataMember]
        public long UserStatusID { get; set; }
        [DataMember]
        public string Photo { get; set; }
        [DataMember]
        public int LikeCount { get; set; }
        [DataMember]
        public string City { get; set; }
        [DataMember]
        public string Country { get; set; }
        [DataMember]
        public int NumberOfMail { get; set; }
        [DataMember]
        public string StatusImage { get; set; }
        [DataMember]
        public bool ILike { get; set; }
        [DataMember]
        public string LikeImage { get; set; }
        [DataMember]
        public int MessageCount { get; set; }
        [DataMember]
        public int CountryID { get; set; }
        [DataMember]
        public int CityID { get; set; }
        [DataMember]
        public int CityHeaderID { get; set; }

    }
}
