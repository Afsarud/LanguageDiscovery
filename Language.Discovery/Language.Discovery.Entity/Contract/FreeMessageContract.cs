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
    public class FreeMessageContract
    {
        [DataMember]
        public long FreeMessageID { get; set; }
        [DataMember]
        public string FreeMessageText1 { get; set; }
        [DataMember]
        public string FreeMessageText2 { get; set; }
        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public long SenderID { get; set; }
        [DataMember]
        public long RecipientID { get; set; }
        [DataMember]
        public int SchoolID { get; set; }
        [DataMember]
        public string Sender { get; set; }
    }
}
