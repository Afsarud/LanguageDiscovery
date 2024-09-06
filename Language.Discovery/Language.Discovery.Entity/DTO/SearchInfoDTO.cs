using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    public class SearchInfoDTO
    {
        [DataMember]
        public int RowsPerPage { get; set; }
        [DataMember]
        public int PageNumber { get; set; }
        [DataMember]
        public string InfoType { get; set; }
        [DataMember]
        public bool? IsActive { get; set; }
        [DataMember]
        public Int32 VirtualCount { get; set; }
    }
}