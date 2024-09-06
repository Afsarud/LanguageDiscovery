using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using Language.Discovery.Entity;
using Language.Discovery.UserService;
using Language.Discovery.Repository;
namespace Language.Discovery.Handler
{
    /// <summary>
    /// Summary description for MailboxHandler
    /// </summary>
    public class MailboxHandler : IHttpHandler, IReadOnlySessionState
    {
        public void ProcessRequest(HttpContext context)
        {
            UserClient client = new UserClient();
            List<UserMessageContract> messages;
            bool success = false;
            string type = context.Request.Form["Type"];
            long senderuserid = 0;
            string json = "";
            switch (type)
            {
                case "loadprevious":
                    json = client.GetMessageTrailBySenderID(Convert.ToInt32(context.Request.Form["userid"]), SessionManager.Instance.UserProfile.UserID, Convert.ToInt32(context.Request.Form["page"]), 5);
                    messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                    if (messages != null)
                    {
                        foreach (UserMessageContract msg in messages)
                        {
                            msg.CssClass = msg.IsReply ? "bubble you" : "bubble me";
                        }
                    }

                    json =  new JavaScriptSerializer().Serialize(messages);
                    //json = json.Replace("\"", Convert.ToString('"'));
                    break;
                case "removevip":
                    bool deleted = false;
                    string usermailid = context.Request.Form["userid"];
                    List<string> usermailids = usermailid.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                    List<VIPContract> viplist = new List<VIPContract>();
                    foreach (string u in usermailids)
                    {
                        var vip = new VIPContract() { OwnerUserID = SessionManager.Instance.UserProfile.UserID, VIPUserID = Convert.ToInt64(u) };
                        viplist.Add(vip);
                    }

                    success = new UserClient().RemoveVIPUser(viplist.ToArray());

                    //success = deleted;
                    break;
                case "getincomingmail":
                    senderuserid = Convert.ToInt64(context.Request.Form["senderuserid"]);
                    json = client.GetMailMessages("incoming", senderuserid, SessionManager.Instance.UserProfile.UserID, Convert.ToInt32(context.Request.Form["page"]), 100);
                    messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                    if (messages != null)
                    {

                        json = client.GetUserDetails(senderuserid);
                        UserContract sender = new JavaScriptSerializer().Deserialize<UserContract>(json);
                        if (sender != null)
                        {
                            if (sender.NativeLanguage == "en-US")
                            {
                                messages.ForEach(x => x.CreateDate = x.CreateDate.ToLocalTime());
                                if (messages != null)
                                {
                                    foreach (UserMessageContract msg in messages)
                                    {
                                        msg.CssClass = msg.ReadDate == DateTime.MinValue && !msg.IsReply ? msg.CssClass + " new" : msg.CssClass + " old";
                                        msg.EnglishLanguageMessage = HttpUtility.HtmlDecode(msg.NativeLanguageMessage); ; //string.IsNullOrEmpty(msg.LearningLanguageMessageRecepient) ? HttpUtility.HtmlDecode(msg.LearningLanguageMessage) : HttpUtility.HtmlDecode(msg.LearningLanguageMessageRecepient);
                                    }
                                }
                            }
                            else if (sender.LearningLanguage == "en-US")
                            {
                                messages.ForEach(x => x.CreateDate = x.CreateDate.ToLocalTime());
                                if (messages != null)
                                {
                                    foreach (UserMessageContract msg in messages)
                                    {
                                        msg.CssClass = msg.ReadDate == DateTime.MinValue && !msg.IsReply ? msg.CssClass + " new" : msg.CssClass + " old";
                                        msg.EnglishLanguageMessage = HttpUtility.HtmlDecode(msg.LearningLanguageMessage);
                                    }
                                }
                            }
                            else
                            {
                                messages.ForEach(x => x.CreateDate = x.CreateDate.ToLocalTime());
                                if (messages != null)
                                {
                                    foreach (UserMessageContract msg in messages)
                                    {
                                        msg.CssClass = msg.ReadDate == DateTime.MinValue && !msg.IsReply ? msg.CssClass + " new" : msg.CssClass + " old";
                                        msg.EnglishLanguageMessage = HttpUtility.HtmlDecode(msg.LearningLanguageMessage);
                                    }
                                }

                            }

                        }


                        json = new JavaScriptSerializer().Serialize(messages);
                    }
                    else
                        json = "";

                    break;
                case "getoutgoingmail":
                    senderuserid = Convert.ToInt64(context.Request.Form["senderuserid"]);
                    json = client.GetMailMessages("outgoing", senderuserid, SessionManager.Instance.UserProfile.UserID, Convert.ToInt32(context.Request.Form["page"]), 100);
                    messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                    if (messages != null)
                    {
                        json = client.GetUserDetails(senderuserid);
                        UserContract sender = new JavaScriptSerializer().Deserialize<UserContract>(json);
                        if (sender != null)
                        {
                        }

                        messages.ForEach(x => x.CreateDate = x.CreateDate.ToLocalTime());
                        
                        foreach (UserMessageContract msg in messages)
                        {
                            msg.EnglishLanguageMessage = HttpUtility.HtmlDecode(msg.LearningLanguageMessage);
                        }

                        json = new JavaScriptSerializer().Serialize(messages);
                    }
                    else
                        json = "";

                    break;
                case "getuserdetails":
                    
                    long userid = Convert.ToInt64(context.Request.Form["senderuserid"]);
                    json = client.GetUserDetails(userid);
                    UserContract people = new JavaScriptSerializer().Deserialize<UserContract>(json);
                    if (people != null)
                    {
                        var p = people;
                        p.Avatar = "../Images/avatar/" + p.Avatar;
                        string js = new MiscService.MiscServiceClient().GetCityOtherName(p.CityID, Constants.English);
                        List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(js);
                        p.Address = ((list != null && list.Count > 0) ? list[0].CityName : string.Empty) + "," + p.CountryName;
                        p.StatusImage = p.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                        p.OnlineStatusText = p.IsOnline ? "Online Now" : "Offline Now";

                        json = new JavaScriptSerializer().Serialize(p);

                    }
                    else
                        json = "";

                    break;
                case "getmessagedetails":

                    long umailid = Convert.ToInt64(context.Request.Form["usermailid"]);
                    bool isOutGoing = Convert.ToBoolean(context.Request.Form["isoutgoing"]);
                    json = client.GetMessageDetailByUserMailID(umailid);
                    UserMessageContract ms = new JavaScriptSerializer().Deserialize<UserMessageContract>(json);
                    if (ms != null)
                    {
                        //bool isOutgoing = false;
                        //if(ms.SenderID == SessionManager.Instance.UserProfile.UserID)
                        //{

                        //}

                        //json = client.GetUserDetails(ms.SenderID);
                        //UserContract sender = new JavaScriptSerializer().Deserialize<UserContract>(json);
                        //if(sender != null)
                        //{
                        //    if(sender.NativeLanguage == "en-US")
                        //    {

                        //    }
                        //}
                        
                        ms.CssClass = isOutGoing ? "bubble you" : "bubble me";
                        ms.NativeLanguageMessage = isOutGoing
                                ? HttpUtility.HtmlDecode(ms.NativeLanguageMessage)
                                //: msg.NativeLanguageMessageRecepient;
                                : string.IsNullOrEmpty(ms.NativeLanguageMessageRecepient) ? HttpUtility.HtmlDecode(ms.NativeLanguageMessage) : HttpUtility.HtmlDecode(ms.NativeLanguageMessageRecepient);

                            ms.LearningLanguageMessage = isOutGoing
                                ? HttpUtility.HtmlDecode(ms.LearningLanguageMessage)
                                //: msg.LearningLanguageMessageRecepient;
                                : string.IsNullOrEmpty(ms.LearningLanguageMessageRecepient) ? HttpUtility.HtmlDecode(ms.LearningLanguageMessage) : HttpUtility.HtmlDecode(ms.LearningLanguageMessageRecepient);
                        

                        json = new JavaScriptSerializer().Serialize(ms);
                    }
                    else
                        json = "";

                    break;
                case "getlastmessagedetailsbyuseridandsenderid":

                    long uid = Convert.ToInt64(context.Request.Form["userid"]);
                    long sid= Convert.ToInt64(context.Request.Form["senderid"]);
                    bool isincoming = Convert.ToBoolean(context.Request.Form["isincoming"]);
                    UserMessageContract ums = new UserRepository().GetLastMessageDetailByUserIDAndSenderID(uid, sid);
                    if (ums != null)
                    {
                        
                        ums.NativeLanguageMessage = !isincoming
                                ? HttpUtility.HtmlDecode(ums.NativeLanguageMessage)
                                //: msg.NativeLanguageMessageRecepient;
                                : string.IsNullOrEmpty(ums.NativeLanguageMessageRecepient) ? HttpUtility.HtmlDecode(ums.NativeLanguageMessage) : HttpUtility.HtmlDecode(ums.NativeLanguageMessageRecepient);

                        ums.LearningLanguageMessage = !isincoming
                            ? HttpUtility.HtmlDecode(ums.LearningLanguageMessage)
                            //: msg.LearningLanguageMessageRecepient;
                            : string.IsNullOrEmpty(ums.LearningLanguageMessageRecepient) ? HttpUtility.HtmlDecode(ums.LearningLanguageMessage) : HttpUtility.HtmlDecode(ums.LearningLanguageMessageRecepient);


                        json = new JavaScriptSerializer().Serialize(ums);
                    }
                    else
                        json = "";

                    break;
                case "deleteusermessage":
                    deleted = false;
                    string ids = context.Request.Form["usermailids"];
                    List<string> mailids = ids.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                    StringBuilder strids = new StringBuilder();
                    foreach (string i in mailids)
                    {
                        strids.AppendFormat("<IDS><ID>{0}</ID></IDS>", i);
                    }
                    if (strids.Length > 0)
                    {
                        strids.Insert(0, "<UserMailIDs>");
                        strids.AppendLine("</UserMailIDs>");

                        deleted = client.DeleteUserMail(strids.ToString());
                    }

                    success = deleted;
                    break;

            }

            context.Response.ContentType = "text/plain";
            if(type == "getincomingmail" || type == "getoutgoingmail" || type == "getmessagedetails" || type == "getlastmessagedetailsbyuseridandsenderid")
            {
                if( string.IsNullOrEmpty(json) )
                    context.Response.Write("");
                else
                    context.Response.Write(string.Format("{{ \"Message\" : {0}}}", json.TrimEnd(new char[] { '"' }).TrimStart(new char[] { '"' })));
            }
            else if(type == "getuserdetails")
            {
                if (string.IsNullOrEmpty(json))
                    context.Response.Write("");
                else
                    context.Response.Write(string.Format("{{ \"UserDetails\" : {0}}}", json.TrimEnd(new char[] { '"' }).TrimStart(new char[] { '"' })));
            }
            else
            {
                context.Response.Write(string.Format("{{\"Status\": \"{0}\"}}", success.ToString()));
            }
            //context.Response.Write(string.Format("{{ \"Message\" : {0}}}", json.TrimEnd(new char[] {'"'}).TrimStart(new char[] {'"'})));
            //context.Response.StatusCode = 200;
            
            context.Response.StatusCode = 200;
        }

        public string ToJson<T>(/* this */ T value, Encoding encoding)
        {
            var serializer = new DataContractJsonSerializer(typeof(T));

            using (var stream = new MemoryStream())
            {
                using (var writer = JsonReaderWriterFactory.CreateJsonWriter(stream, encoding))
                {
                    serializer.WriteObject(writer, value);
                }

                return encoding.GetString(stream.ToArray());
            }
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