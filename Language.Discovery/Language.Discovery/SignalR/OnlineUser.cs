using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Language.Discovery
{
    public static class OnlineUser
    {
        public static List<ChatUser> OnlineUserList = new List<ChatUser>();

        public static void Add(ChatUser cuser)
        {
            //ChatUser user = OnlineUserList.Find(x => x.UserID.Equals(cuser.UserID));
            //if (user != null)
            //{
            //    Remove(user);
            //}
            OnlineUserList.Add(cuser);

        }
        public static void Remove(ChatUser user)
        {
            if (user != null)
                OnlineUserList.Remove(user);
        }
    }
}