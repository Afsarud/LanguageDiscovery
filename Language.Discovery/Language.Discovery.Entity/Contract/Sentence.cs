using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [Serializable]
    public class Sentence
    {
        List<Phrase> _PhraseList = null;

        public long SentenceID { get; set; }
        public long PaletteID { get; set; }
        public DateTime CreateDate { get; set; }
        public long CreatedBy { get; set; }
        public string Keyword { get; set; }
        public string SoundFile { get; set; }
        public byte[] SoundBytes { get; set; }
        public string ImageFile { get; set; }
        public string LanguageCode { get; set; }
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

        public List<SentenceSound> SentenceSoundList { get; set; }

    }
}
