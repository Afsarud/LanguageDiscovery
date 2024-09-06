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
    public class ConferenceRoomContract
    {
        [DataMember]
        public int ConferenceRoomID { get; set; }
        [DataMember]
        public string RoomName { get; set; }
        [DataMember]
        public string Caller { get; set; }
        [DataMember]
        public string Callee { get; set; }

        [DataMember]
        public string RoomKey { get; set; }

        public DateTime CreateDate { get; set; }

        public int CallerId { get; set; }
        public int CalleId { get; set; }
    }
}
