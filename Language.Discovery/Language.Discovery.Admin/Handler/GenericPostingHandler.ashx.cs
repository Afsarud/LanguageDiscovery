using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using Language.Discovery.Admin.UserService;
using Language.Discovery.Entity;
using Language.Discovery.Entity.Contract;
using Language.Discovery.Repository;


namespace Language.Discovery.Admin.Handler
{
    /// <summary>
    /// Summary description for GenericPostingHandler
    /// </summary>
    public class GenericPostingHandler : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            UserClient client = new UserClient();
            long userid = SessionManager.Instance.UserProfile != null ? SessionManager.Instance.UserProfile.UserID : 0;
            string type = context.Request.Form["Type"];
            bool success = false;
            bool? isactive = null;
            string json = "";
            switch (type)
            {
                case "user":
                    
                    json = client.GetUserDetailsByUserName(context.Request.Form["username"]);

                    UserContract userContract = new JavaScriptSerializer().Deserialize<UserContract>(json);
                    if (userContract == null)
                    {
                        isactive = false;
                        success = true;
                        break;
                    }

                    if (userContract.UserTypeName == "Teacher")
                        isactive = userContract.IsActive;
                    else
                        isactive = true;
                    success = true;

                    break;
                case "student":

                    json = client.GetUserDetailsByUserName(context.Request.Form["username"]);
                    string json2 = client.GetUserDetailsByUserName(context.Request.Form["partner"]);

                    UserContract user = new JavaScriptSerializer().Deserialize<UserContract>(json);
                    UserContract user2 = new JavaScriptSerializer().Deserialize<UserContract>(json2);

                    long id = 0;
                    long id2 = 0;
                    success = true;
                    if(user != null)
                    {
                        id = user.UserID;
                    }
                    if(user2 != null)
                    {
                        id2 = user2.UserID;
                    }
                    if(context.Request.Form["partner"].Trim() == "")
                    {
                        id2 = -1;
                    }
                    context.Response.Write(string.Format("{{\"Status\": \"{0}\", \"UserId\": \"{1}\",  \"PartnerId\": \"{2}\"}}", (id > 0 && id2 !=0).ToString(), id.ToString(), id2.ToString()));
                    context.Response.StatusCode = 200;
                    return;
                case "getstudenttime":

                    json = client.GetUserDetailsByUserName(context.Request.Form["username"]);

                    UserContract u = new JavaScriptSerializer().Deserialize<UserContract>(json);

                    success = true;
                    if (u != null)
                    {
                        context.Response.Write(string.Format("{{\"Status\": \"{0}\", \"Time\": \"{1}\"}}", (u.UserID > 0).ToString(), u.SessionTime.ToString()));
                    }
                    else
                    {
                        context.Response.Write(string.Format("{{\"Status\": \"{0}\", \"Time\": \"{1}\"}}", "False", ""));
                    }
                    context.Response.StatusCode = 200;

                    return;
                case "getvideokey":
                    string key = new TokenGenerator().GenerateToken(SessionManager.Instance.UserProfile.UserName.Replace("@", "_"));
                    if (!string.IsNullOrEmpty(key))
                    {
                        context.Response.Write(string.Format("{{\"key\": \"{0}\", \"Status\": \"{1}\"}}", key, !string.IsNullOrEmpty(key)));
                        context.Response.StatusCode = 200;
                        return;
                    }

                    break;
                case "getchat":
                    string caller = Convert.ToString(context.Request.Form["Caller"]);
                    string calle = Convert.ToString(context.Request.Form["Callee"]);
                    DateTime startdate = DateTime.Now.AddHours(-(DateTime.Now.Hour)).AddMinutes(-(DateTime.Now.Minute)).AddSeconds(-(DateTime.Now.Second));
                    List< UserMessageContract> userMessages = new UserRepository().GetMailExchangeForMonitoring(caller, calle, startdate, DateTime.Now.AddDays(1));
                    //messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                    if (userMessages != null)
                    {
                        foreach (UserMessageContract msg in userMessages)
                        {
                            msg.NativeLanguageMessage = HttpUtility.HtmlDecode(msg.NativeLanguageMessage);
                            msg.LearningLanguageMessage = HttpUtility.HtmlDecode(msg.LearningLanguageMessage);
                        }
                        json = new JavaScriptSerializer().Serialize(userMessages);
                    }
                    else
                        json = "";

                    

                    context.Response.StatusCode = 200;
                    break;
                case "getalltime":
                    List<TimeScheduleAuxContract> times = new MatchMakerRepository().GetAllTime();
                    json = new  JavaScriptSerializer().Serialize(times);
                    context.Response.Write(json.TrimEnd(new char[] { '"' }).TrimStart(new char[] { '"' }));
                    context.Response.StatusCode = 200;
                    return;
                case "getexistingtime":
                    string dateentry = Convert.ToString(context.Request.Form["Date"]);
                    List<CustomScheduleContract> existingtime = new MatchMakerRepository().GetCustomSchedule(Convert.ToDateTime(dateentry), Convert.ToDateTime(dateentry));
                    json = new JavaScriptSerializer().Serialize(existingtime);
                    context.Response.Write(json.TrimEnd(new char[] { '"' }).TrimStart(new char[] { '"' }));
                    context.Response.StatusCode = 200;
                    return;
            }
            if(type == "getchat")
            {
                if (string.IsNullOrEmpty(json))
                    context.Response.Write(string.Format("{{ \"Status\": \"True\", \"Message\" : {0}}}", string.Empty));
                else
                    context.Response.Write(string.Format("{{ \"Status\": \"True\", \"Message\" : {0}}}", json.TrimEnd(new char[] { '"' }).TrimStart(new char[] { '"' })));
            }
            else if (success && isactive.HasValue)
            {
                string stat = isactive.HasValue && isactive.Value ? "active" : "inactive";
                context.Response.Write(string.Format("{{\"Status\": \"{0}\"}}", stat));
            }
            else
                context.Response.Write(string.Format("{{\"Status\": \"{0}\"}}", success.ToString()));

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