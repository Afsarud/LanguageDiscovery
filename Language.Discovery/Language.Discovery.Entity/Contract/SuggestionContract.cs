using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;

namespace Language.Discovery.Entity
{
    [DataContract]
    [Serializable]
    public class SuggestionContract
    {
        [DataMember]
        public long PaletteSuggestionID { get; set; }
        [DataMember]
        public long PaletteID { get; set; }
        [DataMember]
        public DateTime StartDate { get; set; }
        [DataMember]
        public DateTime EndDate { get; set; }
        [DataMember]
        public bool IsActive { get; set; }
    }
}
