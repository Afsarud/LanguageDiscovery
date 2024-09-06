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
    public class PhraseCategoryContract
    {
        [DataMember]
        public long PhraseCategoryID { get; set; }
        [DataMember]
        public long? GroupID { get; set; }
        [DataMember]
        public string LanguageCode { get; set; }
        [DataMember]
        public string PhraseCategoryCode { get; set; }
        [DataMember]
        public string PhraseCategoryName { get; set; }
        [DataMember]
        public int? LevelID { get; set; }
        [DataMember]
        public int? SchoolID { get; set; }
        [DataMember]
        public int? Ordinal { get; set; }
        [DataMember]
        public long? ParentID { get; set; }
        [DataMember]
        public bool IsDemo { get; set; }
        [DataMember]
        public bool DisplayInUI { get; set; }
        [DataMember]
        public int TopCategoryHeaderID { get; set; }
        [DataMember]
        public bool IsDefault { get; set; }
        [DataMember]
        public bool IsTalk { get; set; }
        [DataMember]
        public string TopCategoryName { get; set; }
        [DataMember]
        public bool HideInScheduler { get; set; }
    }
}
