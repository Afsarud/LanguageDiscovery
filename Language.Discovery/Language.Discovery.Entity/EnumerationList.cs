using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    public enum MailBoxUserType
    {
        [EnumMember]
        All = 0,
        [EnumMember]
        School = 1,
        [EnumMember]
        VIP = 2
    }
}
