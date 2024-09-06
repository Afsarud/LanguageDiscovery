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
    public class ZendeskCustomTicketFields
    {
        [DataMember]
        [JsonProperty("custom_field_options")]
        public List<ZendeskCustomTicketFieldsOption> Options { get; set; }
    }
}
