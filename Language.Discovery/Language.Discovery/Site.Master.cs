using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.Repository;
using Language.Discovery.UserService;

namespace Language.Discovery
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }


        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (Context.Session != null)
            {
                //Tested and the IsNewSession is more advanced then simply checking if 
                // a cookie is present, it does take into account a session timeout, because 
                // I tested a timeout and it did show as a new session
                if (Session.IsNewSession)
                {
                    // If it says it is a new session, but an existing cookie exists, then it must 
                    // have timed out (can't use the cookie collection because even on first 
                    // request it already contains the cookie (request and response
                    // seem to share the collection)
                    string szCookieHeader = Request.Headers["Cookie"];
                    if ((null != szCookieHeader) && (szCookieHeader.IndexOf("ASP.NET_SessionId") >= 0))
                    {
                        Response.Redirect("~/Logout");
                    }
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionManager.Instance.UserProfile.IsCanTalk = true;
            try
            {
                if (SessionManager.Instance.UserProfile.ShouldChangePassword)
                {
                    Response.Redirect("~/ChangePassword", true);
                }

                //System.Web.UI.HtmlControls.HtmlMeta meta = new System.Web.UI.HtmlControls.HtmlMeta();
                //meta.HttpEquiv = "Refresh";
                //meta.Content = Convert.ToString((Session.Timeout * 60) + 5) + ";url=Timeout.aspx";
                //head.Controls.Add(meta);
                //Response.AppendHeader("Refresh", Convert.ToString((Session.Timeout * 20) + 5) + ";url=/Logout.aspx?t=1");
                UserClient client = new UserClient();
                if (!IsPostBack)
                {
                    imgOwner.Src = "/Images/avatar/" + (string.IsNullOrEmpty(SessionManager.Instance.UserProfile.Avatar) ? "no_avatar.png" : SessionManager.Instance.UserProfile.Avatar);
                    //linkUser.InnerText = SessionManager.Instance.UserProfile.FirstName;
                
                    int unread = client.GetUnreadMessage(SessionManager.Instance.UserProfile.UserID);

                    hdnUnreadMessage.Value = unread.ToString();

                    if (unread > 0)
                    {
                        lblUnreadMessageHeader.Attributes.Remove("style");
                        divUnreadMessageHeader.Attributes.Remove("style");
                    }
                    else
                    {
                        lblUnreadMessageHeader.Attributes.Add("style", "display:none;");
                        divUnreadMessageHeader.Attributes.Add("style", "display:none;");
                    }

                    lblUnReadMessage.Text = unread.ToString();
                    //if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
                    //    hdnHelp.Value = Resources.SiteMaster_en_US.linkHelp; //Localize("linkHelp");
                    //else
                    //    hdnHelp.Value = Resources.SiteMaster_ja_JP.linkHelp; //Localize("linkHelp");

                    hdnHelp.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "linkHelp").ToString();
                    hdnHelpPresentation.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "linkHelpPresentation").ToString();
                    lblLabelUserName.Text = SessionManager.Instance.UserProfile.FirstName;
                    //lblLabelUserNameLoggedin.Text = 
                    lblLabelLogout.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblLabelLogout").ToString();
                    lblLabelMyRoom.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblLabelMyRoom").ToString();
                    //lblWritenew.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblWritenew").ToString();
                    //lblLabelHelp.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblLabelHelp").ToString();
                    //lblLabelMailbox.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblLabelMailbox").ToString();
                    //lblLabelHome.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblLabelHome").ToString();
                    lblInfo.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblInfo").ToString();
                    lblAdmin.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblAdmin").ToString();
                    //lblTalk.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblTalk").ToString();
                    lblUnreadMessageHeader.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblUnReadMessageHeader").ToString();
                    hdnSetupProfile.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnSetupProfile").ToString();
                    hdnNewMessageNotification.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnNewMessageNotification").ToString();
                    hdnGotomailboxbutton.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnGotomailboxbutton").ToString();
                    //lblTalkHelp.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblTalkHelp").ToString();
                    hdnTalkHelpPresentation.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnTalkHelpPresentation").ToString();
                    hdnQuickStart.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnQuickStart").ToString();
                    hdnTutorial.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnTutorial").ToString();
                    hdnFaq.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnFaq").ToString();
                    hdnTalkTutorial.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnTalkTutorial").ToString();
                    hdnTalkFaq.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnTalkFaq").ToString();
                    lblQuickStart.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblQuickStart").ToString();
                    lblTutorial.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblTutorial").ToString();
                    lblFaq.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblFaq").ToString();
                    lblTalkTutorial.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblTalkTutorial").ToString();
                    lblTalkFaq.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblTalkFaq").ToString();
                    hdnBookATalk.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnBookATalk").ToString();
                    //lblPrepareTalk.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblPrepareTalk").ToString();
                    hdnTalkChecklistPresentation.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnTalkChecklistPresentation").ToString();
                    //m@s/
                    hdnTalkProcess.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnTalkProcess").ToString();
                    //m@s/
                    lblTalkSchedulerTitle.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblTalkSchedulerTitle").ToString();
                    hdnMailUsageVideo.Value= HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnMailUsageVideo").ToString();
                    lblMailUsageVideo.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblMailUsageVideo").ToString();
                    // if (SessionManager.Instance.UserProfile.NativeLanguage == "ja-JP" || SessionManager.Instance.UserProfile.NativeLanguage == "zh-CN")
                    //    lblLabelUserName.Text = SessionManager.Instance.UserProfile.FirstName + " " + HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblLabelUserNameLoggedin").ToString();
                    //else if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
                    //     lblLabelUserName.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblLabelUserNameLoggedin").ToString() + " " + SessionManager.Instance.UserProfile.FirstName;

                    hdnUser.Value = SessionManager.Instance.UserProfile.UserName;
                    hdnCurrentUserID.Value = SessionManager.Instance.UserProfile.UserID.ToString();
                    hdnDontShowQuickGuide.Value = SessionManager.Instance.UserProfile.DontShowQuickGuide.ToString().ToLower();
                    lblQuickGuideOtherInfo.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblQuickGuideOtherInfo").ToString();
                    lblDontShowQuickGuide.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblDontShowQuickGuide").ToString();
                    hdnCallAlert.Value = HttpContext.GetGlobalResourceObject("SiteMaster.master", "hdnCallAlert").ToString();
                    lblConsentMessage.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblConsentMessage").ToString();
                    lblFinePrint.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblFinePrint").ToString();
                    lblFinePrint2.Text = HttpContext.GetGlobalResourceObject("SiteMaster.master", "lblFinePrint2").ToString();


                    if (OnlineUser.OnlineUserList.Where(item => item.SessionID == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).Count() > 0)
                        OnlineUser.OnlineUserList.Remove(OnlineUser.OnlineUserList.Where(item => item.SessionID == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).FirstOrDefault());

                    ChatUser user = new ChatUser()
                    {
                        UserID = SessionManager.Instance.UserProfile.UserID,
                        UserName = SessionManager.Instance.UserProfile.UserName,
                        SessionID = HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString(),
                        IsOnline = true
                    };
                    OnlineUser.Add(user);

                    if (SessionManager.Instance.UserProfile.UserTypeID == (int)UserType.Student)
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "adminkey", "HideAdmin(true);initChatHub();", true);
                    else
                    {
                        if (SessionManager.Instance.SchoolProfile.NativeLanguage == "en-US")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "adminkey", "HideAdmin(false); HideRegisterStudents(false);initChatHub();", true);
                        }
                        else
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "adminkey", "HideAdmin(false);initChatHub();", true);
                    }

                    if (SessionManager.Instance.SchoolProfile.EnableParentInfo && !SessionManager.Instance.UserProfile.IsSupport
                            && SessionManager.Instance.UserProfile.UserTypeID == 3 && SessionManager.Instance.UserProfile.CountryCode != "JP")
                    {
                        hdnParentsInfoFlag.Value = SessionManager.Instance.UserProfile.IsParentsInfoStored.ToString();
                        lblUserName.Text = SessionManager.Instance.UserProfile.UserName;
                    }


                }

                if (SessionManager.Instance.UserProfile != null)
                    client.UpdateUserActivity(SessionManager.Instance.UserProfile.UserID);

                if (SessionManager.Instance.UserProfile.AllowTalk)
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "talkkey", "HideTalk(false);", true);

                bool istalk = Request.CurrentExecutionFilePath.ToLower().Contains("talk");
                string hideTalk = string.Empty;
                //if (SessionManager.Instance.IsTalkOpen && !istalk)
                //{
                //    hideTalk = "HideTalk(true);";
                //}

                ScriptManager.RegisterStartupScript(this, this.GetType(), "menuitemhiding", hideTalk + "HideHelpMenuItem(" + istalk.ToString().ToLower() + " , '" + SessionManager.Instance.UserProfile.NativeLanguage + "');", true);


                if (SessionManager.Instance.UserProfile != null)
                {
                    Entity.UserContract user =  client.GetLatestMessage(SessionManager.Instance.UserProfile.UserID);
                    if (user != null)
                    {
                        string page = Page.ToString().Replace("_", ".");
                        //if (page.IndexOf("mailbox.aspx", StringComparison.OrdinalIgnoreCase) == -1 && page.IndexOf("talk.aspx", StringComparison.OrdinalIgnoreCase) == -1)
                        if (page.IndexOf("home.aspx", StringComparison.OrdinalIgnoreCase) > -1)
                        {
                            string src = "/Images/avatar/" + (string.IsNullOrEmpty(user.Avatar) ? "no_avatar.png" : user.Avatar);
                            string message = Server.HtmlDecode(user.LearningLanguageMessageRecepient).Replace("'", "\"").Replace("hasSound", "");
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "shownotificationekek", string.Format("ShowNotification('{0}','{1}','{2}','{3}');",
                                src, user.UserName, user.Address, message.Replace("\n", string.Empty)), true);
                        }
                    }
                    if(SessionManager.Instance.UserProfile.UserTypeName.IndexOf("Teacher", StringComparison.OrdinalIgnoreCase) > -1 )
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "zendeskhelp0", "AddZendesk();", true);
                    }
                    if (SessionManager.Instance.UserProfile.UserTypeName.Equals("Teacher", StringComparison.OrdinalIgnoreCase))
                        hdnIsTeacher.Value = "1";

                }

            

            }
            catch (Exception ex)
            {
                Logger.ErrorLog(ex.Message + ex.StackTrace);
            }

        }

        public void UpdateMailCount()
        {
            try
            {

                UserClient client = new UserClient();
                    int unread = client.GetUnreadMessage(SessionManager.Instance.UserProfile.UserID);

                    if (unread > 0)
                    {
                        lblUnreadMessageHeader.Attributes.Remove("style");
                        divUnreadMessageHeader.Attributes.Remove("style");
                    }
                    else
                    {
                        lblUnreadMessageHeader.Attributes.Add("style", "display:none;");
                        divUnreadMessageHeader.Attributes.Add("style", "display:none;");
                    }
                lblUnReadMessage.Text = unread.ToString();
            }
            catch (Exception)
            {
                throw;
            }

        }

        public string Localize(string key)
        {
            var resourceObject = HttpContext.GetGlobalResourceObject("SiteMaster_" + SessionManager.Instance.UserProfile.NativeLanguage, key);
            if (resourceObject == null)
            {
                throw new Exception(String.Format("Resource key '{1}' could not be found in Resource class '{0}'", "SiteMaster_" + SessionManager.Instance.UserProfile.NativeLanguage, key));
            }

            return resourceObject.ToString();
        }

      

        //protected override void OnPreRender(EventArgs e)
        //{
        //    base.OnPreRender(e);
        //    UserClient client = new UserClient();
        //    int unread = client.GetUnreadMessage(SessionManager.Instance.UserProfile.UserID);

        //    lblUnReadMessage.Text = unread.ToString();

        //}

    }
}