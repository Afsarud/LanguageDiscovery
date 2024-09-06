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
    public class UserMessageLikeRankingContract
    {
        [DataMember]
        public long UserID { get; set; }
        [DataMember]
        public long Ranking { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string Flag { get; set; }
        [DataMember]
        public string SchoolName { get; set; }
        [DataMember]
        public int LikeCount { get; set; }
        [DataMember]
        public string LevelName { get; set; }
        [DataMember]
        public string Avatar { get; set; }
        [DataMember]
        public int StarCount { get; set; }
        [DataMember]
        public string FirstName { get; set; }
        [DataMember]
        public string SchoolCode { get; set; }

        [DataMember]
        public int Points { get; set; }
        [DataMember]
        public int LevelID { get; set; }



    }
}
