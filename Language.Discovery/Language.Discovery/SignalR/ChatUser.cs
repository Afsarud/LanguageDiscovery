using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Language.Discovery.Entity;

namespace Language.Discovery
{
    public class ChatUser 
    {
        
        public string ConnectionID { get; set; }
        public long UserID { get; set; }
        public string UserName { get; set; }
        public bool IsOnline { get; set; }
        public string SessionID { get; set; }
    }
}