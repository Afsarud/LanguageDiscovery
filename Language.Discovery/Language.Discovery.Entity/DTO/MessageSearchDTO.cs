using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    public class MessageSearchDTO
    {
        [DataMember]
        public int RowsPerPage { get; set; }
        [DataMember]
        public int PageNumber { get; set; }
        [DataMember]
        public string Sender { get; set; }
        [DataMember]
        public string Recepient { get; set; }
        [DataMember]
        public Int64 SchoolID { get; set; }
        [DataMember]
        public DateTime? StartDate { get; set; }
        [DataMember]
        public DateTime? EndDate { get; set; }
        [DataMember]
        public int VirtualCount { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string FirstName { get; set; }
        [DataMember]
        public string LastName { get; set; }
    }
}
