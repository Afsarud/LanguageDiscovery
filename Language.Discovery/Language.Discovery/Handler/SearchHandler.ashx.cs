using Language.Discovery.UserService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Language.Discovery.Handler
{
    /// <summary>
    /// Summary description for SearchHandler
    /// </summary>
    public class SearchHandler : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string type = context.Request.Form["Type"];
            string json = string.Empty;
            UserClient client = new UserClient();
            if (type == "searchfriends")
            {
                json = client.SearchUser(context.Request.Form["name"], SessionManager.Instance.UserProfile.UserID);
            }
            else if (type == "MakeNewFriends")
            {
                List<int> items = context.Request.Form["items"].Split(new char[] {','},  StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList() ;
                string cityid = context.Request.Form["CityID"];
                string name = context.Request.Form["Name"];
                List<string> genders = context.Request.Form["Genders"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                Discovery.Entity.DiscoverNewFriendsDTO dto = new Entity.DiscoverNewFriendsDTO()
                {
                    InterestIDs = items,
                    CityID = cityid,
                    Name = name,
                    GenderList = genders,
                    SearcheeID = SessionManager.Instance.UserProfile.UserID
                };
                json = client.DiscoverNewFriends3(dto);
            }
                        
            context.Response.Write(json);
            context.Response.StatusCode = 200;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}