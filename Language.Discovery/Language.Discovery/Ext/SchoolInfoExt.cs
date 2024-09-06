using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Language.Discovery.Entity;

namespace Language.Discovery
{
    public class SchoolContractExt : SchoolContract
    {
        public List<UserSearchContract> UserList { get; set; }
        public int UnReadMessageCount { get; set; }
    }
}