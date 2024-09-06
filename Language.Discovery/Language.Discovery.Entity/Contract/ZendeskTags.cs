using Newtonsoft.Json;
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
    public class ZendeskTags
    {
        [DataMember]
        [JsonProperty("tags")]
        public List<String> Tags { get; set; }
    }
}
