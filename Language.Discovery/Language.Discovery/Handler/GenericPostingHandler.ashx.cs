using Language.Discovery.PaletteService;
using Language.Discovery.UserService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Language.Discovery.Entity;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.Configuration;
using System.Text;
using System.Net;
using System.Net.Mime;
using System.Collections;
using System.Text.RegularExpressions;
using Google.Cloud.Translation.V2;

namespace Language.Discovery
{
    /// <summary>
    /// Summary description for GenericPostingHandler
    /// </summary>
    public class GenericPostingHandler : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.Redirect("Profile.aspx?fid=4");

            context.Response.ContentType = "text/plain";
            
            UserClient client = new UserClient();
            long userid = SessionManager.Instance.UserProfile != null ? SessionManager.Instance.UserProfile.UserID : 0;
            string type = context.Request.Form["Type"];
            bool success = false;
            bool hasfoul = false;
            bool? isactive = null;
            PaletteServiceClient ps = new PaletteServiceClient();
            switch (type)
            {
                case "status":
                    
                    hasfoul = ps.HasFoulWords(context.Request.Form["status"]);

                    if (hasfoul)
                        success = false;
                    else
                        success = client.UpdateUserStatus(userid, context.Request.Form["status"]);
                    break;
                case "skin":
                    string skin = context.Request.Form["skin"];
                    Repository.UserRepository srep = new Repository.UserRepository();
                    success = srep.UpdateUserSkin(SessionManager.Instance.UserProfile.UserID, skin);
                    if(success)
                    {
                        SessionManager.Instance.UserProfile.Skin = skin;
                    }
                    break;
                case "avatar":
                    string avatar = context.Request.Form["avatar"];
                    //avatar = avatar.Substring(avatar.LastIndexOf("/"), )
                    avatar = VirtualPathUtility.GetFileName(avatar.Replace("..", "~"));
                    
                    success = client.UpdateUserAvatar(userid, avatar);
                    if (success)
                        SessionManager.Instance.UserProfile.Avatar = avatar;
                    break;
                case "add":
                    success = client.AddFriend(userid, Convert.ToInt64(context.Request.Form["useridtoprocess"]));
                    break;
                case "remove":
                    success = client.UnFriend(userid, Convert.ToInt64(context.Request.Form["useridtoprocess"]));
                    break;
                case "description":
                    hasfoul = ps.HasFoulWords(context.Request.Form["description"]);

                    if (hasfoul)
                        success = false;
                    else
                        success = client.UpdatePhotoDescription(Convert.ToInt64(context.Request.Form["userphotoid"]), context.Request.Form["description"]);
                    break;
                case "like":
                    bool iscurrentlike = Convert.ToBoolean(context.Request.Form["ilike"]);
                    success = client.LikeUnLike(userid, Convert.ToInt64(context.Request.Form["userid"]), Convert.ToInt64(context.Request.Form["userstatusid"]), iscurrentlike );
                    break;
                case "likephoto":
                    bool iscurrentlikephoto = Convert.ToBoolean(context.Request.Form["ilike"]);
                    success = client.LikeUnLikePhoto(userid, Convert.ToInt64(context.Request.Form["userphotoid"]), iscurrentlikephoto);
                    break;
                case "user":
                     string json = client.GetUserDetailsByUserName(context.Request.Form["username"]);

                    UserContract userContract = new JavaScriptSerializer().Deserialize<UserContract>(json);
                    if (userContract != null)
                    {
                        isactive = userContract.HasAgreedTC;
                        success = true;
                    }
                    else
                    {
                        isactive = false;
                        success = false;
                    }
                    break;
                case "UserAfterSchoolAccess":
                    string js = client.GetUserDetailsByUserName(context.Request.Form["username"]);
                    bool isafterschool = false;
                    bool isschoolAfterschoolOn = false;
                    string password = context.Request.Form["password"];
                    UserContract u = new JavaScriptSerializer().Deserialize<UserContract>(js);
                    Repository.Security sec = new Repository.Security();
                    
                    if (u != null && sec.Encrypt(password, ConfigurationManager.AppSettings["Salt"]) == u.Password)
                    {
                        isafterschool = client.IsAfterSchoolTime(u.UserID);
                        SchoolContract school = new SchoolService.SchoolServiceClient().GetByID(u.SchoolID);
                        if (school != null)
                        {
                            isschoolAfterschoolOn = school.AfterSchool;
                        }

                        //isactive = isafterschool;
                        success = true;
                    }
                    else
                    {
                        isafterschool = false;
                        success = false;
                    }
                    if (success)
                    {
                        context.Response.Write(string.Format("{{\"AfterSchool\": \"{0}\",\"NativeLanguage\" : \"{1}\",\"UserTypeName\" : \"{2}\", \"IsDemo\" : \"{3}\", \"HasAgreedTC\" : \"{4}\", \"IsTrialExpired\" : \"{5}\",  \"IsSchoolAfterSchoolOn\" : \"{6}\",  \"PermissionStatus\" : \"{7}\", \"FromRegistrationPage\" : \"{8}\", \"IsActive\" : \"{9}\"}}",
                            isafterschool.ToString(), u.NativeLanguage, u.UserTypeName, u.IsDemo, u.HasAgreedTC, u.IsTrialExpired, isschoolAfterschoolOn,u.PermissionStatus, !string.IsNullOrEmpty(u.Reference), u.IsActive.ToString() ));
                        context.Response.StatusCode = 200;
                        return;
                    }
                    break;
                case "reportmessage":
                    long usermailid = Convert.ToInt64(context.Request.Form["usermailid"]);
                    string mailto = context.Request.Form["mailto"];
                    string jsn = client.GetMessageDetailByUserMailID(usermailid);
                    if (jsn != "null")
                    {
                        UserMessageContract umc = new JavaScriptSerializer().Deserialize<UserMessageContract>(jsn);
                        if (umc != null)
                        {
                            success = MailProblemMessage(umc, mailto);
                        }
                    }
                    break;
                case "markmessageasread":
                    long uid = Convert.ToInt64(context.Request.Form["userid"]);
                    bool result = client.MarkMessageAsRead(uid, SessionManager.Instance.UserProfile.UserID);
                    success = result;
                    break;
                case "markmessageasunread":
                    long id = Convert.ToInt64(context.Request.Form["userid"]);
                    var ids = context.Request.Form["usermailid"].Split(new char[] {','}, StringSplitOptions.RemoveEmptyEntries).Select(long.Parse).ToArray();
                    bool res = client.MarkMessageAsUnRead(id, SessionManager.Instance.UserProfile.UserID, ids);
                    success = res;
                    break;
                case "likemessage":
                    //bool iscurrentlike = Convert.ToBoolean(context.Request.Form["ilike"]);
                    success = client.LikeUnLikeMessage(Convert.ToInt64(context.Request.Form["usermailid"]));
                    break;
                case "useroptions":

                    bool sequenceOptionFlag = Convert.ToBoolean(context.Request.Form["SequenceOptionFlag"]);
                    bool nativeOptionFlag = Convert.ToBoolean(context.Request.Form["NativeOptionFlag"]);
                    bool subLanguageOptionFlag = Convert.ToBoolean(context.Request.Form["SubLanguageOptionFlag"]);
                    bool subLanguage2OptionFlag = Convert.ToBoolean(context.Request.Form["SubLanguage2OptionFlag"]);
                    bool soundandmail = Convert.ToBoolean(context.Request.Form["SoundAndMail"]);
                    bool stepOptionFlag = Convert.ToBoolean(context.Request.Form["StepOptionFlag"]);
                    bool orderByLearningLanguageFlag = Convert.ToBoolean(context.Request.Form["OrderByLearning"]);

                    UserContract usr = new UserContract()
                    {
                        UserID = userid,
                        SequenceOptionFlag = sequenceOptionFlag,
                        NativeOptionFlag = nativeOptionFlag,
                        SubLanguageOptionFlag = subLanguageOptionFlag,
                        SubLanguage2OptionFlag = subLanguage2OptionFlag,
                        SoundAndMail = soundandmail,
                        StepOptionFlag = stepOptionFlag,
                        OrderByLearningLanguageFlag = orderByLearningLanguageFlag

                    };

                    bool updated = client.UpdateUserOptions(usr);
                    if (updated)
                    {
                        js = client.GetUserDetailsByUserName(SessionManager.Instance.UserProfile.UserName);
                        u = new JavaScriptSerializer().Deserialize<UserContract>(js);
                        SessionManager.Instance.UserProfile.SequenceOptionFlag = u.SequenceOptionFlag;
                        SessionManager.Instance.UserProfile.SubLanguageOptionFlag = u.SubLanguageOptionFlag;
                        SessionManager.Instance.UserProfile.SubLanguage2OptionFlag = u.SubLanguage2OptionFlag;
                        SessionManager.Instance.UserProfile.NativeOptionFlag = u.NativeOptionFlag;
                        SessionManager.Instance.UserProfile.IsOptionUpdated = u.IsOptionUpdated;
                        SessionManager.Instance.UserProfile.SoundAndMail = u.SoundAndMail;
                        SessionManager.Instance.UserProfile.StepOptionFlag = u.StepOptionFlag;
                        SessionManager.Instance.UserProfile.OrderByLearningLanguageFlag = u.OrderByLearningLanguageFlag;
                    }

                    

                    success = updated;
                    break;
                case "deleteusermessage":
                    bool deleted = false;
                    string usermailids = context.Request.Form["usermailids"];
                    List<string> mailids = usermailids.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
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
                case "getvideokey":
                    string key = new TokenGenerator().GenerateToken(SessionManager.Instance.UserProfile.UserName.Replace("@", "_") );
                    if (!string.IsNullOrEmpty(key) )
                    {
                        context.Response.Write(string.Format("{{\"key\": \"{0}\", \"Status\": \"{1}\"}}", key, !string.IsNullOrEmpty(key) ));
                        context.Response.StatusCode = 200;
                        return;
                    }

                    break;
                case "savemessage":
                    string native = context.Request.Form["Native"];
                    string learning = context.Request.Form["Learning"];
                    string savemessageid = context.Request.Form["SaveMessageId"];
                    string senderid = context.Request.Form["SenderId"];
                    native = HttpUtility.UrlDecode(native);
                    learning = HttpUtility.UrlDecode(learning);

                    UserMessageContract us = new UserMessageContract();
                    us.UserMailID = Convert.ToInt32(savemessageid);
                    us.SenderID = Convert.ToInt32(senderid);
                    us.LearningLanguageMessage = learning;
                    us.NativeLanguageMessage = native;
                    
                    Repository.UserRepository rep = new Repository.UserRepository();
                    id = rep.SaveMessageForLaterUser(us);
                    if (id > 0)
                    {
                        context.Response.Write(string.Format("{{\"Id\": \"{0}\", \"Status\": \"True\"}}", id.ToString()));
                        context.Response.StatusCode = 200;
                        return;
                    }


                    break;
                case "saveword":
                    string nativeword = context.Request.Form["Native"];
                    string learningword = context.Request.Form["Learning"];
                    WordHeaderContract whc = new WordHeaderContract();
                    whc.WordHeaderID = 0;
                    whc.PhraseCategoryID = 0;
                    whc.CreatedByID = SessionManager.Instance.UserProfile.UserID;
                    whc.Keyword = nativeword + ";" + learningword;
                    whc.UserCreatedWord = true;
                    whc.Words.Add(new WordContract()
                    {
                        Word = nativeword,
                        LanguageCode =SessionManager.Instance.UserProfile.NativeLanguage,
                        PhraseCategoryID = 0
                    });
                    whc.Words.Add(new WordContract()
                    {
                        Word = learningword,
                        LanguageCode = SessionManager.Instance.UserProfile.LearningLanguage,
                        PhraseCategoryID = 0
                    });

                    Repository.WordRepository r = new Repository.WordRepository();
                    if (Convert.ToInt64(r.Add(whc)) > 0)
                    {
                        success = true;
                    }

                    break;
                case "deleteword":
                    WordHeaderContract w = new WordHeaderContract();
                    w.WordHeaderID = Convert.ToInt32(context.Request.Form["id"]);

                    Repository.WordRepository re = new Repository.WordRepository();
                    if (re.Delete(w) )
                    {
                        success = true;
                    }

                    break;
                case "updatetalksubscription":
                    Repository.UserRepository ur = new Repository.UserRepository();
                    UserTalkSubscription subs = new UserTalkSubscription();
                    subs.UserTalkSubscriptionID = Convert.ToInt32( context.Request.Form["UserTalkSubscriptionID"]);
                    subs.UserName = context.Request.Form["UserName"];
                    subs.PartnerUserName= context.Request.Form["PartnerUserName"];
                    if (context.Request.Form["SessionTime"].Length == 0)
                    {
                        success = true;
                        context.Response.StatusCode = 200;
                        break;
                    }
                        
                    subs.SessionTime = Convert.ToInt32(context.Request.Form["SessionTime"]);
                    if(ur.UpdateTalkSubscription(subs))
                    {
                      
                        UserTalkSubscription sub = ur.GetUserTalkSubscription(SessionManager.Instance.UserProfile.UserName);
                        if(sub != null)
                        {
                            context.Response.Write(string.Format("{{\"UserTalkSubscriptionID\": \"{0}\", \"UserID\": \"{1}\",\"SessionTime\": \"{2}\",\"BalanceTime\": \"{3}\", \"TotalTime\": \"{4}\",\"IsActive\": \"{5}\",\"Status\": \"{6}\"}}",
                                sub.UserTalkSubscriptionID.ToString(), "0",sub.SessionTime.ToString(), sub.BalanceTime.ToString(),sub.TotalTime.ToString(), sub.IsActive.ToString(), "True" ));
                            context.Response.StatusCode = 200;
                            return;
                        }
                        else
                        {
                            context.Response.Write(string.Format("{{\"UserTalkSubscriptionID\": \"{0}\", \"UserID\": \"{1}\",\"SessionTime\": \"{2}\",\"BalanceTime\": \"{3}\", \"TotalTime\": \"{4}\",\"IsActive\": \"{5}\",\"Status\": \"{6}\"}}",
                            "0", "0", "0", "0", "0", "False", "True"));
                            context.Response.StatusCode = 200;
                            return;
                        }
                    }
                    
                    break;
                case "updatetalkstatus":
                    userid = Convert.ToInt64(context.Request.Form["UserID"]);
                    bool status = Convert.ToBoolean(context.Request.Form["Status"]);
                    res = new Repository.UserRepository().UpdateTalkStatus(userid, status);
                    SessionManager.Instance.UserProfile.IsCanTalk = status;
                    success = res;
                    break;
                case "addconferenceroom":
                    string room = context.Request.Form["Room"];
                    string caller = context.Request.Form["Caller"];
                    string callee = context.Request.Form["Callee"];
                    string roomKey = context.Request.Form["RoomKey"];
                    res = new Repository.UserRepository().AddConferenceRoom(room, caller, callee, roomKey);
                    success = res;
                    break;
                case "deleteconferenceroom":
                    string room2 = context.Request.Form["room"];
                    res = new Repository.UserRepository().DeleteConferenceRoom(room2);
                    success = true;
                    break;
                case "signout":
                    long uidtologout = Convert.ToInt64(context.Request.Form["UserID"]);
                    res = new Repository.UserRepository().SignOut(uidtologout);
                    success = res;
                    break;
                case "keepalive":
                    success = true;
                    break;
                case "dontshowquickguide":
                    userid = Convert.ToInt64(context.Request.Form["UserID"]);
                    bool dontshow = Convert.ToBoolean(context.Request.Form["dontshow"]);
                    res = new Repository.UserRepository().UpdateUserDontShowQuickGuide(userid, true);
                    SessionManager.Instance.UserProfile.DontShowQuickGuide = true;
                    success = res;
                    break;
                case "checkmessage":
                    
                    string natives = HttpUtility.UrlDecode(context.Request.Form["Native"]);
                    string learnings = HttpUtility.UrlDecode(context.Request.Form["Learning"]);
                    string freeNatives = HttpUtility.UrlDecode(context.Request.Form["FreeNative"]);
                    string freeLearnings = HttpUtility.UrlDecode(context.Request.Form["FreeLearning"]);
                    string otherMessage = HttpUtility.UrlDecode(context.Request.Form["OtherMessage"]);
                    //native = HttpUtility.UrlDecode(natives);
                    //learning = HttpUtility.UrlDecode(learnings);
                    res = CheckMessage(natives, learnings, freeNatives, freeLearnings, otherMessage);
                    success = res;
                    break;
                case "saveownpalette":
                    string ownpalette = HttpUtility.UrlDecode(context.Request.Form["SelectedPalette"]);
                    List<long> ownPalette = ownpalette.Split(new char[] {','}, StringSplitOptions.RemoveEmptyEntries).Select(long.Parse).ToList();
                    Repository.UserRepository userrep = new Repository.UserRepository();
                    success = userrep.SaveUserPalette(SessionManager.Instance.UserProfile.UserID, ownPalette);
                    
                    break;
                case "deleteownpalette":
                    string deleteownpalette = HttpUtility.UrlDecode(context.Request.Form["SelectedPalette"]);
                    List<long> toDeleteOwnPalette = deleteownpalette.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(long.Parse).ToList();
                    Repository.UserRepository userrep2 = new Repository.UserRepository();
                    success = userrep2.DeleteUserPalette(SessionManager.Instance.UserProfile.UserID, toDeleteOwnPalette);

                    break;
                case "updateownpalette":
                    string ownphrase = context.Request.Form["phrases"];
                    List<WordReplace> obj = new JavaScriptSerializer().Deserialize<List<WordReplace>>(ownphrase);
                    
                    Repository.UserRepository userrep3 = new Repository.UserRepository();
                    success = userrep3.UpdateUserPhrase(SessionManager.Instance.UserProfile.UserID, obj);

                    break;
                case "translate":
                    string apikey = ConfigurationManager.AppSettings["TranslationApiKey"];
                    string sourceText = context.Request.Form["sourceText"];
                    string sourceLang = context.Request.Form["sourceLang"];
                    string targetLang = context.Request.Form["targetLang"];
                    string translatedText = "";
                    if (!string.IsNullOrEmpty(apikey))
                    {
                        TranslationClient tc = TranslationClient.CreateFromApiKey(apikey);
                        var response = tc.TranslateText(
                            text: sourceText,
                            targetLanguage: targetLang, 
                            sourceLanguage: sourceLang);

                        translatedText = response.TranslatedText;

                        context.Response.Write(string.Format("{{\"translatedText\": \"{0}\", \"Status\": \"{1}\"}}", translatedText,  "True"));
                        context.Response.StatusCode = 200;
                        return;

                    }
                    break;
                case "filtermessage":
                    hasfoul = ps.HasFoulWords(context.Request.Form["message"]);
                    success = true;
                    if (hasfoul)
                        success = false;
                    break;

            }
            if (!success && hasfoul)
                context.Response.Write(string.Format("{{\"Status\": \"{0}\"}}", "foul"));
            else if (success && isactive.HasValue)
            {
                string stat = isactive.HasValue && isactive.Value ? "active" : "inactive";
                context.Response.Write(string.Format("{{\"Status\": \"{0}\"}}", stat));
            }
            else
                context.Response.Write(string.Format("{{\"Status\": \"{0}\"}}", success.ToString()));
            context.Response.StatusCode = 200;
        }

        private bool MailProblemMessage(UserMessageContract umc, string mailto)
        {
            bool success = false;
            try
            {
                //for testing
                //SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"])
                //{
                //    Credentials = new NetworkCredential("", ""),
                //    EnableSsl = true
                //};

                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"]);

                MailMessage msg = new MailMessage("No_Reply_ProblemMessage_Reporter@languageDiscovery.org", mailto);//ConfigurationManager.AppSettings["PasswordRecoveryEmail"]);

                msg.IsBodyHtml = true;
                //string username = ((TextBox)Login1.FindControl("txtRequestUserName")).Text;
                msg.Subject = "Please Investigate the message I received";
                StringBuilder body = new StringBuilder();
                body.AppendFormat("Please Investigate the message I receive from {0} on {1}", umc.Sender, umc.CreateDate.ToString("dd/MM/yyyy HH:mm:ss"));
                body.Append("<br/>");
                body.Append("Please see the message below:<br/>");
                body.Append("Native :<br/>");
                
                body.Append(HttpUtility.HtmlDecode(umc.NativeLanguageMessage) + "<br/>");
                body.AppendLine("Translation :<br/>");
                body.AppendLine(HttpUtility.HtmlDecode(umc.LearningLanguageMessage) + "<br/>");
                body.AppendLine("<br/>");
                body.AppendLine("Thank you <br/>");
                body.AppendLine(umc.Recepient);
                int count = 0;
                //string x = ExtractImages(body.ToString(), ref count);
                string b = body.ToString();
                string oldChar = ExtractImages(b, ref count);
                Random RGen = new Random();
                List<LinkedResource> linkList = new List<LinkedResource>();
                while (oldChar != "")
                {
                    string imgPath = oldChar;
                    int startIndex = imgPath.ToLower().IndexOf("images/");
                    if (startIndex > 0)
                    {
                        imgPath = imgPath.Substring(startIndex);
                        imgPath = imgPath.Replace("/", "\\");
                        //System.Net.Mail.Attachment A = new Attachment(HttpContext.Current.Request.PhysicalApplicationPath + "\\" + imgPath);
                        LinkedResource lres = new LinkedResource(HttpContext.Current.Request.PhysicalApplicationPath + "\\" + imgPath, MediaTypeNames.Image.Jpeg);

                        lres.ContentId = RGen.Next(100000, 9999999).ToString();
                        b = b.Replace(oldChar, "cid:" + lres.ContentId);
                        //msg.Attachments.Add(A);
                        linkList.Add(lres);
                        linkList.Add(lres);
                        oldChar = ExtractImages(b, ref count);
                    }
                    else
                    {
                        oldChar = ExtractImages(b, ref count);
                    }
                }

                AlternateView avhtml = AlternateView.CreateAlternateViewFromString(b, null, MediaTypeNames.Text.Html);
                foreach (LinkedResource l in linkList)
                {
                    avhtml.LinkedResources.Add(l);
                }
                msg.AlternateViews.Add(avhtml);
                //msg.Body = b;
                //smtp.Port = 587; //for testing
                smtp.Port = 25;
                smtp.Send(msg);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertUser", "alert('An Email has been sent to admin.')", true);
                success = true;
            }
            catch (Exception ex)
            {
                success = false;
            }
            return success;
        }

        public static void SendEmail(string from, string to, string cc, string subject, string body, string attachedFiles)
        {
            try
            {
                MailMessage mailMsg = new MailMessage();
                SmtpClient mailObj = new SmtpClient(ConfigurationManager.AppSettings["SmtpClient"]);//"192.168.1.145"

                mailMsg.From = new MailAddress(from);

                string[] temp = to.Split(';');
                for (int i = 0; i < temp.Length; i++)
                {
                    if (temp[i].ToString().Length > 1)
                        mailMsg.To.Add(temp[i].ToString());
                }

                temp = cc.Split(';');
                for (int i = 0; i < temp.Length; i++)
                {
                    if (temp[i].ToString().Length > 1)
                        mailMsg.CC.Add(temp[i].ToString());
                }
                temp = attachedFiles.Split(';');
                for (int i = 0; i < temp.Length; i++)
                {
                    if (temp[i].ToString().Length > 1)
                        mailMsg.Attachments.Add(new Attachment(temp[i].ToString()));
                }

                mailMsg.Subject = subject;
                mailMsg.Body = body;
                mailMsg.IsBodyHtml = true;
                int count = 0;
                string oldChar = ExtractImages(body, ref count);
                Random RGen = new Random();
                while (oldChar != "")
                {
                    string imgPath = oldChar;
                    int startIndex = imgPath.ToLower().IndexOf("images/");
                    if (startIndex > 0)
                    {
                        imgPath = imgPath.Substring(startIndex);
                        imgPath = imgPath.Replace("/", "\\");
                        System.Net.Mail.Attachment A = new Attachment(HttpContext.Current.Request.PhysicalApplicationPath + "\\" + imgPath);
                        A.ContentId = RGen.Next(100000, 9999999).ToString();
                        body = body.Replace(oldChar, "cid:" + A.ContentId);
                        mailMsg.Attachments.Add(A);
                        oldChar = ExtractImages(body, ref count);
                    }
                    else
                    {
                        oldChar = ExtractImages(body, ref count);
                    }
                }
                mailMsg.Body = body;
                mailObj.Send(mailMsg);
            }
            catch (Exception ex)
            {
                //WriteLog(ex);
            }
        }

        private static string ExtractImages(string body, ref int count)
        {
            int startIndex = body.ToLower().IndexOf("src=\"", count);
            int endIndex;
            if (startIndex >= 0)
            {
                endIndex = body.IndexOf("\"", startIndex + 5);
            }
            else
            {
                return "";
            }
            startIndex = startIndex + 5;
            string imgurl = body.Substring(startIndex, (endIndex - (startIndex)));
            count = startIndex;
            return imgurl;
        }

        private bool CheckMessage(string native, string learning, string freeNative, string freeLearning, string otherLanguage)
        {
            
            bool result = false;
            try
            {
                //([a-zA-Z0-9])\1\1+
                string learningsentence = native;
                string nativesentence = learning;
                List<OtherMessage> othermessages = new JavaScriptSerializer().Deserialize<List<OtherMessage>>(otherLanguage.Replace("\\", "/"));

                string[] ls = learningsentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                string[] ns = nativesentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                string[] oll;
                string[] oln;
                List<string> normalls = ls.ToList().FindAll(x => !x.Contains("data-isfreemessage"));
                List<string> normalns = ns.ToList().FindAll(x => !x.Contains("data-isfreemessage"));
                List<string> freels = ls.ToList().FindAll(x => x.Contains("data-isfreemessage"));
                List<string> freens = ns.ToList().FindAll(x => x.Contains("data-isfreemessage"));

                Hashtable ht = new Hashtable();
                int sentencecountls = 1;
                int sentencecountns = 1;

                int emojicountls = 1;
                int emojicountns = 1;

                foreach (var s in normalls)
                {
                    if (s.IndexOf("data-isemoji", StringComparison.OrdinalIgnoreCase) > -1)
                        emojicountls++;

                    if (ht.Contains(s))
                    {
                        sentencecountls++;
                        continue;
                    }
                    ht.Add(s, s);
                }
                foreach (var s in normalns)
                {
                    if (s.IndexOf("emoji", StringComparison.OrdinalIgnoreCase) > -1)
                        emojicountns++;

                    if (ht.Contains(s))
                    {
                        sentencecountns++;
                        continue;
                    }
                    ht.Add(s, s);
                }
                //---------------------
                string learningfree = freeNative;
                string nativefree = freeLearning;


                //string[] freels = learningfree.Split(new char[] { '|', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                //string[] freens = nativefree.Split(new char[] { '|', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);

                bool islsInvalid = false;
                bool isnsInvalid = false;
                int invalidlsCharCount = 0;
                int invalidnsCharCount = 0;
                int invalidlsSameCharCount = 0;
                int invalidnsSameCharCount = 0;
                int freesentencecountls = 1;
                int freesentencecountns = 1;
                int lsrepeatitive = 0;
                int nsrepeatitive = 0;
                string pattern = @"([a-zA-Z0-9!@#$%^&*()])\1{9,}";

                //List<string> excludelList =
                //    ConfigurationManager.AppSettings["ExcludeWordForRejection"].Split(new char[] { ',' },
                //        StringSplitOptions.RemoveEmptyEntries).ToList();

                if (SessionManager.Instance.UserProfile.NativeLanguage != "en-US")
                {
                    ht = new Hashtable();
                    foreach (var ss in freens)
                    {
                        string s = ss.Replace("<span data-isfreemessage=\"1\">", "").Replace("</span>", "").Replace("&nbsp;", "");
                        if (s.Length > 20 && !s.Contains(" "))
                        {
                            islsInvalid = true;
                            break;
                        }
                        if (ht.Contains(s))
                        {
                            freesentencecountls++;
                            continue;
                        }
                        ht.Add(s, s);

                        
                        RegexOptions options = RegexOptions.Multiline;
                        if (Regex.Matches(s, pattern, options).Count > 0)
                        {
                            nsrepeatitive++;
                        }

                        //foreach (var c in s.ToCharArray())
                        //{
                        //    if (!Char.IsLetterOrDigit(c) && !Char.IsWhiteSpace(c))
                        //        invalidlsCharCount++;
                        //}
                        //if (Regex.Match(s, @"(.)\1\1", RegexOptions.IgnoreCase).Success)
                        //{
                        //    invalidlsSameCharCount++;
                        //}

                    }
                }
                else if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
                {
                    ht = new Hashtable();
                    foreach (var ss in freels)
                    {
                        string s = ss.Replace("<span data-isfreemessage=\"1\">", "").Replace("</span>", "").Replace("&nbsp;", "");
                        if (s.Length > 20 && !s.Contains(" "))
                        {
                            islsInvalid = true;
                            break;
                        }
                        if (!s.Contains(" ") && s.Length > 10)
                        {
                            isnsInvalid = true;
                            break;
                        }
                        if (ht.Contains(s))
                        {
                            freesentencecountls++;
                            continue;
                        }
                        ht.Add(s, s);

                        RegexOptions options = RegexOptions.Multiline;
                        if(Regex.Matches(s, pattern, options).Count > 0)
                        {
                            lsrepeatitive++;
                        }


                        //foreach (var c in s.ToCharArray())
                        //{
                        //    if (!Char.IsLetterOrDigit(c) && !Char.IsWhiteSpace(c))
                        //        invalidnsCharCount++;
                        //}
                        //if (Regex.Match(s, @"(.)\1\1", RegexOptions.IgnoreCase).Success)
                        //{
                        //    invalidnsSameCharCount++;
                        //}

                    }
                }
                //result = (emojicountls > 3 || emojicountns > 3 || sentencecountls > 3 || sentencecountns > 3 || freesentencecountls > 3 || freesentencecountns > 3 || islsInvalid || isnsInvalid || invalidnsCharCount >= 10 || invalidlsCharCount >= 10 || invalidnsSameCharCount > 0 || invalidlsSameCharCount > 0);
                result = (emojicountls > 3 || emojicountns > 3 || sentencecountls > 3 || sentencecountns > 3 || freesentencecountls > 3 || freesentencecountns > 3 || islsInvalid || isnsInvalid || lsrepeatitive > 0 || nsrepeatitive > 0 || invalidnsSameCharCount > 0 || invalidlsSameCharCount > 0);

            }
            catch (Exception)
            {
                throw;
            }
            return result;
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
