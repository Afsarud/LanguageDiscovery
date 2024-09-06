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
    public class ZendeskUser
    {
        [DataMember]
        [JsonProperty("user")]
        public User User { get; set; }
    }

    public class User
    {
        [DataMember]
        [JsonProperty("id")]
        public long Id { get; set; }
        [DataMember]
        [JsonProperty("url")]
        public Uri Url { get; set; }

        [DataMember]
        [JsonProperty("name")]
        public string Name { get; set; }

        [DataMember]
        [JsonProperty("email")]
        public string Email { get; set; }

        [DataMember]
        [JsonProperty("created_at")]
        public DateTimeOffset CreatedAt { get; set; }

        [DataMember]
        [JsonProperty("updated_at")]
        public DateTimeOffset UpdatedAt { get; set; }

        [DataMember]
        [JsonProperty("time_zone")]
        public string TimeZone { get; set; }

        [DataMember]
        [JsonProperty("iana_time_zone")]
        public string IanaTimeZone { get; set; }

        [JsonProperty("phone")]
        public string Phone { get; set; }

        [DataMember]
        [JsonProperty("shared_phone_number")]
        public object SharedPhoneNumber { get; set; }

        [DataMember]
        [JsonProperty("photo")]
        public object Photo { get; set; }

        [DataMember]
        [JsonProperty("locale_id")]
        public long LocaleId { get; set; }

        [DataMember]
        [JsonProperty("locale")]
        public string Locale { get; set; }

        [DataMember]
        [JsonProperty("organization_id")]
        public object OrganizationId { get; set; }

        [DataMember]
        [JsonProperty("role")]
        public string Role { get; set; }

        [DataMember]
        [JsonProperty("verified")]
        public bool? Verified { get; set; }

        [DataMember]
        [JsonProperty("external_id")]
        public object ExternalId { get; set; }

        [DataMember]
        [JsonProperty("tags")]
        public List<object> Tags { get; set; }

        [DataMember]
        [JsonProperty("alias")]
        public string Alias { get; set; }

        [DataMember]
        [JsonProperty("active")]
        public bool? Active { get; set; }

        [DataMember]
        [JsonProperty("shared")]
        public bool? Shared { get; set; }

        [DataMember]
        [JsonProperty("shared_agent")]
        public bool? SharedAgent { get; set; }

        [DataMember]
        [JsonProperty("last_login_at")]
        public DateTimeOffset? LastLoginAt { get; set; }

        [DataMember]
        [JsonProperty("two_factor_auth_enabled")]
        public bool? TwoFactorAuthEnabled { get; set; }

        [DataMember]
        [JsonProperty("signature")]
        public object Signature { get; set; }

        [DataMember]
        [JsonProperty("details")]
        public string Details { get; set; }

        [DataMember]
        [JsonProperty("notes")]
        public string Notes { get; set; }

        [DataMember]
        [JsonProperty("role_type")]
        public object RoleType { get; set; }

        [DataMember]
        [JsonProperty("custom_role_id")]
        public object CustomRoleId { get; set; }

        [DataMember]
        [JsonProperty("moderator")]
        public bool? Moderator { get; set; }

        [DataMember]
        [JsonProperty("ticket_restriction")]
        public string TicketRestriction { get; set; }

        [DataMember]
        [JsonProperty("only_private_comments")]
        public bool? OnlyPrivateComments { get; set; }

        [DataMember]
        [JsonProperty("restricted_agent")]
        public bool? RestrictedAgent { get; set; }

        [DataMember]
        [JsonProperty("suspended")]
        public bool? Suspended { get; set; }

        [DataMember]
        [JsonProperty("default_group_id")]
        public object DefaultGroupId { get; set; }

        [DataMember]
        [JsonProperty("report_csv")]
        public bool? ReportCsv { get; set; }

        [DataMember]
        [JsonProperty("user_fields")]
        public UserFields UserFields { get; set; }
    }

    public partial class UserFields
    {
        [DataMember]
        [JsonProperty("parents_name")]
        public string ParentsName { get; set; }
    }


}
