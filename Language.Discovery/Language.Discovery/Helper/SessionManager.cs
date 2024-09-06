using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Language.Discovery.Entity;
using System.Web.Security;

namespace Language.Discovery
{
    public sealed class SessionManager
    {
        private static readonly SessionManager _sessionManager = new SessionManager();

        public SessionManager()
        {
        }

        public static SessionManager Instance
        {
            get { return _sessionManager; }
        }

        public UserContract UserProfile
        {
            get
            {
                UserContract user = null;
                if (HttpContext.Current.Session["UserProfile"] != null)
                    user = (UserContract)HttpContext.Current.Session["UserProfile"];

                return user;
            }
            set
            {
                HttpContext.Current.Session["UserProfile"] = value;
            }
        }

        public SchoolContract SchoolProfile
        {
            get
            {
                SchoolContract user = null;
                if (HttpContext.Current.Session["SchoolContract"] != null)
                    user = (SchoolContract)HttpContext.Current.Session["SchoolContract"];

                return user;
            }
            set
            {
                HttpContext.Current.Session["SchoolContract"] = value;
            }
        }

        public string Roles
        {
            get
            {
                string roles= null;
                if (HttpContext.Current.Session["Roles"] != null)
                    roles = HttpContext.Current.Session["Roles"].ToString();

                return roles;
            }
            set
            {
                HttpContext.Current.Session["Roles"] = value;
            }
        }

        public bool IsFriendsRoom
        {
            get
            {
                bool isFriendRoom = false;
                if (HttpContext.Current.Session["IsFriendsRoom"] != null)
                    isFriendRoom = Convert.ToBoolean( HttpContext.Current.Session["IsFriendsRoom"]);

                return isFriendRoom;
            }
            set
            {
                HttpContext.Current.Session["IsFriendsRoom"] = value;
            }
        }

        public bool IsTalkOpen
        {
            get
            {
                bool isTalkOpen = false;
                if (HttpContext.Current.Session["IsTalkOpen"] != null)
                    isTalkOpen = Convert.ToBoolean(HttpContext.Current.Session["IsTalkOpen"]);

                return isTalkOpen;
            }
            set
            {
                HttpContext.Current.Session["IsTalkOpen"] = value;
            }
        }

        //public static string MakeHash(string password)
        //{
        //    return FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
        //}
    }
}
