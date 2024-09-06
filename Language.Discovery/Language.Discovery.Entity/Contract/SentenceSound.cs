using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
     [Serializable]
    public class SentenceSound
    {

         public int SentenceSoundID { get; set; }
         public long SentenceID { get; set; }
         public string LearningLanguageCode { get; set; }
         public string SoundFile { get; set; }

    }
}
