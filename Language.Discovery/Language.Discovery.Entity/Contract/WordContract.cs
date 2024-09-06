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
    public class WordContract
    {
        List<WordContract> _WordList = null;

        [DataMember]
        public long WordID{ get; set; }
        [DataMember]
        public long WordMapID { get; set; }
        [DataMember]
        public string LanguageCode{ get; set; }
        [DataMember]
        public string Word{ get; set; }
        [DataMember]
        public string Keyword{ get; set; }
        [DataMember]
        public string PluralForm{ get; set; }
        [DataMember]
        public string SoundFile{ get; set; }
        [DataMember]
        public string ImageFile{ get; set; }
        [DataMember]
        public int SchoolID{ get; set; }
        [DataMember]
        public long PhraseCategoryID{ get; set; }
        [DataMember]
        public DateTime CreateDate{ get; set; }
        [DataMember]
        public int _CreatedBy{ get; set; }
        [DataMember]
        public int Ordinal{ get; set; }
        [DataMember]
        public Nullable<long> ParentID{ get; set; }
        [DataMember]
        public byte[] SoundBytes { get; set; }
        [DataMember]
        public List<WordContract> WordList
        {
            get
            {
                if (_WordList == null)
                {
                    _WordList = new List<WordContract>();
                }
                return _WordList;
            }
            set
            {
                _WordList = value;
            }
        }
        [DataMember]
        public string WordType { get; set; }
        public int Sequence{ get; set; }
    }
}
