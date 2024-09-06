using Language.Discovery.Entity.Contract;
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
    public class ZendeskTicket
    {
        [DataMember]
        [JsonProperty("ticket")]
        public Ticket Ticket { get; set; }
        [DataMember]
        public string Country { get; set; }
        public bool HasPartner { get; set; }
        public string NativeLanguage { get; set; }
        public string LearningLanguage { get; set; }

    }

    public class Comment
    {
        [DataMember]
        [JsonProperty("html_body")]
        public string Body { get; set; }
    }

    public class CustomFields : ICustomFields
    {
        [DataMember]
        [JsonProperty("id")]
        public string Id { get; set; }

        [DataMember]
        [JsonProperty("value")]
        public string Value { get; set; }
    }

    public class MultiSelectCustomFields : ICustomFields
    {
        [DataMember]
        [JsonProperty("id")]
        public string Id { get; set; }

        [DataMember]
        [JsonProperty("value")]
        public string[] Values { get; set; }
    }

    public class Ticket
    {
        [DataMember]
        [JsonProperty("comment")]
        public Comment Comment { get; set; }
        [DataMember]
        [JsonProperty("priority")]
        public string Priority { get; set; }

        [DataMember]
        [JsonProperty("subject")]
        public string Subject { get; set; }

        [DataMember]
        [JsonProperty("custom_fields")]
        public List<ICustomFields> CustomFields { get; set; }

        [DataMember]
        [JsonProperty("requester")]
        public Requester RequesterDetail { get; set; }

        [DataMember]
        [JsonProperty("type")]
        public string TicketType { get; set; }

        [DataMember]
        [JsonProperty("due_at")]
        public string DueAt { get; set; }

        [DataMember]
        [JsonProperty("updated_stamp")]
        public string UpdatedStamp { get; set; }

        [DataMember]
        [JsonProperty("safe_update")]
        public bool SafeUpdate { get; set; }


    }

    public class Requester
    {
        [DataMember]
        [JsonProperty("local_id")]
        public string LocalId { get; set; }

        [DataMember]
        [JsonProperty("name")]
        public string Name { get; set; }

        [DataMember]
        [JsonProperty("email")]
        public string Email { get; set; }

    }
}
