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
    public class WordHeaderContract
    {
        List<WordContract> _WordList = null;

        [DataMember]
        public long WordHeaderID { get; set; }
        [DataMember]
        public DateTime? CreateDate { get; set; }
        [DataMember]
        public long CreatedByID { get; set; }
        [DataMember]
        public string ImageFile { get; set; }
        [DataMember]
        public long PhraseCategoryID { get; set; }
        [DataMember]
        public string Keyword { get; set; }
        [DataMember]
        public byte[] ImageBytes { get; set; }
        [DataMember]
        public int VirtualCount { get; set; }
        [DataMember]
        public List<WordContract> Words
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
        [DataMember]
        public bool UserCreatedWord { get; set; }
        [DataMember]
        public int Sequence { get; set; }


    }
}
