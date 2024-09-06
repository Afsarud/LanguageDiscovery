using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [Serializable]
    public class Phrase
    {
        List<Phrase> _PhraseList = null;

        public Int64 PhraseID { get; set; }
        public Int64 SentenceID { get; set; }
        public Int64 WordMapID { get; set; }
        public string LanguageCode { get; set; }
        public string Word { get; set; }
        public string Keyword { get; set; }
        public string PluralForm { get; set; }
        public string SoundFile { get; set; }
        public string ImageFile { get; set; }
        public byte[] SoundBytes { get; set; }
        public byte[] ImageBytes { get; set; }
        public int Ordinal { get; set; }
        public Int64 PalleteID { get; set; }
        public Int64 ParentID { get; set; }

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

        public string WordType { get; set; }
        public bool DataSwapped { get; set; }



    }
}
