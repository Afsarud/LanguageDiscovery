using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    public class SearchUserDTO
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
        public string FirstName { get; set; }
        [DataMember]
        public string LastName { get; set; }
        [DataMember]
        public Int32 ClassID { get; set; }
        [DataMember]
        public Int32 CountryID { get; set; }
        [DataMember]
        public Int32 CityID { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public Int32 VirtualCount { get; set; }
    }
}