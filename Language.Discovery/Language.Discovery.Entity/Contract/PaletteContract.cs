using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.Serialization;
using Language.Discovery.Entity;

namespace Language.Discovery.Entity
{
    [DataContract]
    [Serializable]
    public class PaletteContract
    {
        List<Phrase> _PhraseList = null;
        List<Sentence> _SentenceList = null;
        [DataMember]
        public long PaletteID { get; set; }
        [DataMember]
        public long SchoolID { get; set; }
        [DataMember]
        public long LevelID { get; set; }
        [DataMember]
        public long PhraseCategoryID { get; set; }
        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public long CreatedBy { get; set; }
        [DataMember]
        public DateTime ModifiedDate { get; set; }
        [DataMember]
        public long ModifiedBy { get; set; }
        [DataMember]
        public DateTime ApprovedDate { get; set; }
        [DataMember]
        public long ApprovedBy { get; set; }
        [DataMember]
        public bool Approved { get; set; }
        [DataMember]
        public string DefaultLanguageCode { get; set; }
        [DataMember]
        public string Keyword { get; set; }
        [DataMember]
        public List<Sentence> SentenceList
        {
            get
            {
                if (_SentenceList == null)
                {
                    _SentenceList = new List<Sentence>();
                }
                return _SentenceList;
            }
            set
            {
                _SentenceList = value;
            }
        }

        [DataMember]
        public List<Phrase> PhraseList
        {
            get
            {
                if (_PhraseList == null)
                {
                    _PhraseList = new List<Phrase>();
                }
                return _PhraseList;
            }
            set
            {
                _PhraseList = value;
            }
        }


    }
}
