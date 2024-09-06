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
    public class WhoLikedMeContract
    {
        [DataMember]
        public Int64 UserID { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string FirstName { get; set; }
        [DataMember]
        public string MiddleName { get; set; }
        [DataMember]
        public string LastName { get; set; }
        [DataMember]
        public string Address { get; set; }
        [DataMember]
        public long UserPhotoID { get; set; }
        [DataMember]
        public string Photo { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public DateTime? LikeDate { get; set; }


    }
}
