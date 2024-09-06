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
    public class PhraseCategoryHeaderContract
    {
        List<PhraseCategoryContract> _phraselist = null;

        [DataMember]
        public long PhraseCategoryHeaderID {get;set;}
        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public long CreatedByID { get; set; }
        [DataMember]
        public long SchoolID { get; set; }
        [DataMember]
        public int LevelID { get; set; }
        [DataMember]
        public DateTime ModifiedDate { get; set; }
        [DataMember]
        public long ModifiedByID { get; set; }
        [DataMember]
        public int Ordinal { get; set; }
        [DataMember]
        public string FolderName { get; set; }
        [DataMember]
        public bool IsDemo { get; set; }
        [DataMember]
        public bool DisplayInUI { get; set; }
        [DataMember]
        public int TopCategoryHeaderID { get; set; }
        [DataMember]
        public bool HideInScheduler { get; set; }

        [DataMember]
        public List<PhraseCategoryContract> PhraseCategories
        {
            get
            {
                if (_phraselist == null)
                {
                    _phraselist = new List<PhraseCategoryContract>();
                }
                return _phraselist;
            }
            set
            {
                _phraselist = value;
            }
        }
    }
}
