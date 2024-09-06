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
    public class SearchDTO
    {
        [DataMember]
        public int RowsPerPage { get; set; }
        [DataMember]
        public int PageNumber { get; set; }
        [DataMember]
        public string Word { get; set; }
        [DataMember]
        public string Keyword { get; set; }
        [DataMember]
        public Int64 CategoryID { get; set; }
        [DataMember]
        public string LanguageCode { get; set; }
        [DataMember]
        public Int64 LevelID { get; set; }
        [DataMember]
        public Int64 SchoolID { get; set; }
        [DataMember]
        public int VirtualCount { get; set; }
        [DataMember]
        public bool IsAdmin { get; set; }
        [DataMember]
        public int TopCategoryHeaderID { get; set; }
		[DataMember]
        public Int64 UserID { get; set; }
        [DataMember]
        public string CategoryIDs { get; set; }
        [DataMember]
        public bool IsTalk { get; set; }
        [DataMember]
        public bool IsExport { get; set; }
        [DataMember]
        public string TopCategoryName { get; set; }
        [DataMember]
        public string CategoryName { get; set; }
        [DataMember]
        public string WordType { get; set; }
        [DataMember]
        public bool UserCreatedWord { get; set; }
        [DataMember]
        public bool IsUserPalette { get; set; }

    }
}
