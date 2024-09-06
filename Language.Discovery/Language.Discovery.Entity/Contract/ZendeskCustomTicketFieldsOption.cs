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
    public class ZendeskCustomTicketFieldsOption
    {
        [DataMember]
        [JsonProperty("name")]
        public string Name { get; set; }
        [DataMember]
        [JsonProperty("value")]
        public string Value { get; set; }
    }
}
