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
    public class PhraseContract
    {
        List<Phrase> _PhraseList = null;

        [DataMember]
        public Int64 SentenceID { get; set; }
        [DataMember]
        public Int64 WordGroupID { get; set; }
        [DataMember]
        public string DefaultLanguageCode { get; set; }
        [DataMember]
        public string SoundFile { get; set; }
        [DataMember]
        public string ImageFile { get; set; }
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
