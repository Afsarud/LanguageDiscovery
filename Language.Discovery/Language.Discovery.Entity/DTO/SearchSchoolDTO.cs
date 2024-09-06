using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    public class SearchSchoolDTO
    {
        [DataMember]
        public int RowsPerPage { get; set; }
        [DataMember]
        public int PageNumber { get; set; }
        [DataMember]
        public int SchoolID { get; set; }
        [DataMember]
        public string SchoolCode { get; set; }
        [DataMember]
        public string Name1 { get; set; }
        [DataMember]
        public string Name2 { get; set; }
        [DataMember]
        public Int32 CountryID { get; set; }
        [DataMember]
        public Int32 VirtualCount { get; set; }
    }
}