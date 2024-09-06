using Language.Discovery.Entity;
using Language.Discovery.UserService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;

namespace Language.Discovery.Student
{
    public partial class MailBox : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            if (SessionManager.Instance.UserProfile == null)
            {
                Response.Redirect("~/Logout");
                return;
            }
            UICulture = SessionManager.Instance.UserProfile.NativeLanguage;

            base.InitializeCulture();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    if (SessionManager.Instance.UserProfile.NativeLanguage.ToLower() == "zh-cn")
                        Response.Redirect("Mailboxcn", false);
                
                    string isDemo = Request.QueryString["d"];
                    string hasNewMessage = Request.QueryString["hn"];
                    string needtoreply = Request.QueryString["mnr"];
                    if (!string.IsNullOrEmpty(isDemo) && Convert.ToBoolean(isDemo))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "15minbreak", "InformUser();", true);
                    }

                    hdnCurrentLoggedUserID.Value = SessionManager.Instance.UserProfile.UserID.ToString();
                    List<UserSearchContract> list = BindResult(null, MailBoxUserType.All);
                    if (list != null && list.Count > 0)
                        hdnUserID.Value = list[0].UserID.ToString();

                   // BindResult(null, UserService.MailBoxUserType.School);
                    //BindResult(null, UserService.MailBoxUserType.VIP);
                    if (hdnUserID.Value.Length > 0)
                    {
                        UserClient client = new UserClient();
                        client.MarkMessageAsRead(0, SessionManager.Instance.UserProfile.UserID);
                        GetUserMessage();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "AutoSelectUserscript", "AutoSelectUser();", true);
                    }
                    hdnCurrentUserID.Value = SessionManager.Instance.UserProfile.UserID.ToString();
                    hdnDontShowNewTab.Value = SessionManager.Instance.UserProfile.DontShowNewTab.ToString().ToLower();
                    hdnSwitchWord.Value = SessionManager.Instance.UserProfile.SubLanguage2OptionFlag.ToString().ToLower();
                    if (!string.IsNullOrEmpty(hasNewMessage) && hasNewMessage == "1")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "shownewmessagealert_" + Guid.NewGuid().ToString().Replace("-", ""), "ShowNewMessageAlert();", true);
                    }
                    else if ((!string.IsNullOrEmpty(hasNewMessage) && hasNewMessage == "0") &&
                             (!string.IsNullOrEmpty(needtoreply) && needtoreply == "1"))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowNeedToReplyAlert_" + Guid.NewGuid().ToString().Replace("-", ""), "ShowNeedToReplyAlert();", true);
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearSessionStoragescript", "InitializeChatHub();InitializeMainTab();", true);
                }

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Initialize" + Guid.NewGuid().ToString().Replace("-", ""), "InitializeTabs();SetDefaultTab();InitializeAccordion();", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "SetDefaultTab", "SetDefaultTab();", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "SetDefaultAccordion_" + Guid.NewGuid().ToString().Replace("-", ""), "SetDefaultAccordion();", true);
           
                ScriptManager.RegisterStartupScript(this, this.GetType(), "bind_" + Guid.NewGuid().ToString().Replace("-", ""), "Bind();", true);
            }
            catch (Exception ex)
            {
                Logger.ErrorLog(ex.Message + ex.StackTrace + " METHOD:" + System.Reflection.MethodBase.GetCurrentMethod().Name);
            }


        }

        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            if (hdnSelectedTab.Value.Length > 0)
            {
                List<UserSearchContract> list = BindResult(txtSearch.Text.Length > 0 ? txtSearch.Text : null,
                    (MailBoxUserType) Convert.ToInt32(hdnSelectedTab.Value)); //all

                if (list != null && list.Count > 0)
                    hdnUserID.Value = list[0].UserID.ToString();
                
            }
        }

        private void BindSchoolResult( List<UserSearchContract> uscList)
        {
            string schooljson = new MiscService.MiscServiceClient().GetSchoolList("en-US");
            List<SchoolContract> schoolList = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(schooljson);
            rptSchool.ItemDataBound += rptSchool_ItemDataBound;
            List<SchoolContractExt> scext = new List<SchoolContractExt>();
            var distinctuserschoolid = uscList.GroupBy(x=>x.SchoolID).Select(grp=>grp.First()).ToList();
            if( distinctuserschoolid != null )
            {
                int allunreadmessagecount = 0;
                foreach( UserSearchContract u in distinctuserschoolid )
                {
                     var sc = schoolList.Find(x => x.SchoolID.Equals(u.SchoolID));
                     if (sc != null)
                     {
                         List<UserSearchContract> ulist = uscList.FindAll(x => x.SchoolID.Equals(sc.SchoolID));
                         int unread = ulist.Sum(x => x.UnReadMessageCount);
                         allunreadmessagecount += unread;

                         SchoolContractExt ext = new SchoolContractExt() { SchoolID = sc.SchoolID, SchoolCode = sc.Name1, UserList = ulist, UnReadMessageCount = unread };
                         scext.Add(ext);
                     }
                }
                lblAllUnreadMessageCount.Text = allunreadmessagecount.ToString();
                
            }
            //foreach (UserSearchContract usc in uscList)
            //{
            //    var sc = schoolList.Find(x => x.SchoolID.Equals(usc.SchoolID));
            //    if (sc != null)
            //    {
            //        List<UserSearchContract> ulist = uscList.FindAll(x=>x.SchoolID.Equals(sc.SchoolID));

            //        SchoolContractExt ext = new SchoolContractExt() { SchoolID=sc.SchoolID, SchoolCode=sc.SchoolCode };
                   
            //    }
            //}
            rptSchool.DataSource = scext;
            rptSchool.DataBind();
            UpdatePanel1.Update();
        }

        void rptSchool_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rpt = e.Item.FindControl("rptSchoolUsers") as Repeater;
                if (rpt == null)
                    return;

                SchoolContractExt ext = (SchoolContractExt)e.Item.DataItem;
                if (ext != null)
                {
                    rpt.DataSource = ext.UserList;
                    rpt.DataBind();
                    
                }
            }
        }

        private List<UserSearchContract> BindResult(string name, MailBoxUserType mailboxusertype)
        {
           
            
            string json = new UserClient().SearchUserWithMessage(name, SessionManager.Instance.UserProfile.UserID, mailboxusertype);
            List<UserSearchContract> people = new JavaScriptSerializer().Deserialize<List<UserSearchContract>>(json);
            if (people != null)
            {
                foreach (UserSearchContract person in people)
                {
                    person.Avatar = person.Avatar.Length > 0 ? "../Images/avatar/" + person.Avatar : "../Images/no_avatar.png";
                    person.StatusImage = person.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                    person.OnlineStatusText = person.IsOnline ? "Online" : "Offline";
                    if (person.UnReadMessageCount == 0)
                        person.MailIcon = "openmail.png";
                    else
                        person.MailIcon = "mail.png";
                }

                //if (people.Count() > 0)
                //    hdnUserID.Value = people[0].UserID.ToString();

                if (mailboxusertype == MailBoxUserType.All)
                {
                    rptFriends.DataSource = people;
                    rptFriends.DataBind();
                }
                else if (mailboxusertype == MailBoxUserType.School)
                {
                    //BindSchoolResult(people);
                        
                }
                else if (mailboxusertype == MailBoxUserType.VIP)
                {
                    rptVip.DataSource = people;
                    rptVip.DataBind();
                }
                
            }
            else
            {
                if (mailboxusertype == MailBoxUserType.All)
                {
                    rptFriends.DataSource = null;
                    rptFriends.DataBind();
                }
                if (mailboxusertype == MailBoxUserType.VIP)
                {
                    rptVip.DataSource = null;
                    rptVip.DataBind();
                }
                if (mailboxusertype == MailBoxUserType.School)
                {
                    //rptSchool.DataSource = null;
                    //rptSchool.DataBind();
                }
            }
            UpdatePanel1.Update();

            return people;
        }

        protected void btnGetUserMessage_Click(object sender, EventArgs e)
        {
            try
            {
                GetUserMessage();
                
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "SetDefaultAccordion_" + Guid.NewGuid().ToString().Replace("-", ""), "SetDefaultAccordion();", true);
                //divUser.Attributes.Remove("style");
                //long userid = Convert.ToInt64(hdnUserID.Value);
                //string name = hdnName.Value;
                //UserClient client = new UserClient();
                //string json = client.SearchPeople(0, 0, "Friends", name, SessionManager.Instance.UserProfile.UserID);
                //List<PeopleSearchContract> people = new JavaScriptSerializer().Deserialize<List<PeopleSearchContract>>(json);

                //if (people != null && people.Count > 0)
                //{
                //    var p = people[0];
                //    imgAvatar.ImageUrl = "../Images/avatar/" + p.Avatar;
                //    lblFirstNAme.Text = p.FirstName;
                //    lblLastName.Text = p.LastName;
                //    lblAddress.Text = p.Address;
                //    imgStatus.ImageUrl = p.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                //    lblOnlineStatusText.Text = p.IsOnline ? "Online Now" : "Offline Now";
                //    imgLike.ImageUrl = p.ILike ? "../Images/heartUnlike.png" : "../Images/heartLike.png";
                //    lblStatusText.Text = p.StatusText;
                //    lblLikeCount.Text = p.LikeCount.ToString();
                //}

                //json = client.GetMessageTrailBySenderID(userid, SessionManager.Instance.UserProfile.UserID, Convert.ToInt32(hdnPageNumber.Value), 5 );
                //List<UserMessageContract> messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                //if (messages != null)
                //{
                //    foreach (UserMessageContract msg in messages)
                //    {
                //        //msg.RecepientAvatar = msg.RecepientAvatar.Length > 0 ? "../Images/avatar/" + msg.RecepientAvatar : "../Images/avatar/no_avatar.png";
                //        //msg.SenderAvatar = msg.SenderAvatar.Length > 0 ? "../Images/avatar/" + msg.SenderAvatar : "../Images/avatar/no_avatar.png";
                //        msg.CssClass = msg.IsReply ? "bubble you" : "bubble me";
                //    }
                //    rptConversation.DataSource = messages;
                //    rptConversation.DataBind();
                //    string script = "$('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);";
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollnow", script, true);

                //    client.MarkMessageAsRead(userid, SessionManager.Instance.UserProfile.UserID);

                //    SiteMaster x = (SiteMaster)this.Master;
                //    x.UpdateMailCount();


                //    UpdatePanel1.Update();

                //}

            }
            catch (Exception ex)
            {
                Logger.ErrorLog(ex.Message + ex.StackTrace + " METHOD:" + System.Reflection.MethodBase.GetCurrentMethod().Name);
                //throw ex;
            }

        }

       
        private void GetUserMessage()
        {
            try
            {
                divUser.Attributes.Remove("style");
                long userid = hdnUserID.Value.Length > 0 ? Convert.ToInt64(hdnUserID.Value) : 0;
                string name = hdnName.Value;
                UserClient client = new UserClient();
                //string json = client.SearchPeople(0, 0, "Friends", name, SessionManager.Instance.UserProfile.UserID);
                //List<PeopleSearchContract> people = new JavaScriptSerializer().Deserialize<List<PeopleSearchContract>>(json);

                string json = client.GetUserDetails(userid);
                UserContract people = new JavaScriptSerializer().Deserialize<UserContract>(json);

                if (people != null) //&& people.Count > 0)
                {
                    var p = people;
                    imgAvatar.ImageUrl = "../Images/avatar/" + p.Avatar;
                    imgAvatar.Attributes["data-userid"] = p.UserID.ToString();
                    lblFirstNAme.Text = p.FirstName;
                    lblLastName.Text = p.UserName;
                    string js = new MiscService.MiscServiceClient().GetCityOtherName(p.CityID, Constants.English);
                    List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(js);

                    lblAddress.Text = ((list != null && list.Count > 0) ? list[0].CityName : string.Empty) + "," + p.CountryName;

                    imgStatus.ImageUrl = p.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                    lblOnlineStatusText.Text = p.IsOnline ? "Online Now" : "Offline Now";
                    //imgLike.ImageUrl = p.ILike ? "../Images/heartUnlike.png" : "../Images/heartLike.png";
                    //imgLike.ImageUrl = "../Images/heartUnlike.png" : "../Images/heartLike.png";
                    lblStatusText.Text = p.StatusText;
                    lblLikeCount.Text = p.LikeCount.ToString();
                }

                json = client.GetMessageTrailBySenderID(userid, SessionManager.Instance.UserProfile.UserID, Convert.ToInt32(hdnPageNumber.Value), 5);
                
                List<UserMessageContract> messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                if (messages == null)
                {
                    rptConversation.DataSource = messages;
                    rptConversation.DataBind();
                    //SiteMaster x = (SiteMaster)this.Master;
                    //x.UpdateMailCount();

                    UpdatePanel2.Update();
                    return;
                }

                messages.ForEach(x => x.CreateDate = x.CreateDate.ToLocalTime());
                if (messages != null)
                {
                    foreach (UserMessageContract msg in messages)
                    {
                        //msg.RecepientAvatar = msg.RecepientAvatar.Length > 0 ? "../Images/avatar/" + msg.RecepientAvatar : "../Images/avatar/no_avatar.png";
                        //msg.SenderAvatar = msg.SenderAvatar.Length > 0 ? "../Images/avatar/" + msg.SenderAvatar : "../Images/avatar/no_avatar.png";
                        //msg.CssClass = msg.IsReply ? "bubble you" : "bubble me";
                        msg.IsReply = msg.SenderID == SessionManager.Instance.UserProfile.UserID;
                        msg.CssClass = msg.IsReply ? "bubble rightpeople" : "bubble leftpeople";
                        msg.CssClass = msg.ReadDate == DateTime.MinValue && !msg.IsReply ? msg.CssClass + " new" : msg.CssClass + " old";
                        string nativemessage = string.Empty;
                        //if ( msg.IsReply )
                        //{
                            msg.NativeLanguageMessage = msg.IsReply
                                ? msg.NativeLanguageMessage : string.IsNullOrEmpty(msg.NativeLanguageMessageRecepient) ? msg.NativeLanguageMessage : msg.NativeLanguageMessageRecepient;

                            msg.LearningLanguageMessage = msg.IsReply
                                ? msg.LearningLanguageMessage
                                : string.IsNullOrEmpty(msg.LearningLanguageMessageRecepient) ? msg.LearningLanguageMessage : msg.LearningLanguageMessageRecepient;

                        //}
                        //else
                        //{
                        //    msg.LearningLanguageMessage = !msg.IsReply
                        //        ? msg.NativeLanguageMessage : string.IsNullOrEmpty(msg.NativeLanguageMessageRecepient) ? msg.NativeLanguageMessage : msg.NativeLanguageMessageRecepient;

                        //    msg.NativeLanguageMessage = !msg.IsReply
                        //        ? msg.LearningLanguageMessage
                        //        : string.IsNullOrEmpty(msg.LearningLanguageMessageRecepient) ? msg.LearningLanguageMessage : msg.LearningLanguageMessageRecepient;
                        //}


                        // = msg.IsReply ? "bubble you" : "bubble me";
                    }
                    messages[messages.Count - 1].IsLastMessage = true;
                    rptConversation.DataSource = messages;
                    rptConversation.DataBind();
                    string script = "AttachPlaysound();$('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);SwitchWords();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollnow", script, true);

                    //HM-89
                    //client.MarkMessageAsRead(userid, SessionManager.Instance.UserProfile.UserID);


                    //SiteMaster x = (SiteMaster)this.Master;
                    //x.UpdateMailCount();


                    UpdatePanel2.Update();

                }

            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void rptConversation_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Object item = e.Item.DataItem;
                if (item == null)
                    return;
                
                Image you = (Image)e.Item.FindControl("imgAvatarYou");
                Image me = (Image)e.Item.FindControl("imgAvatarMe");
                Image imgLikeMessage = (Image)e.Item.FindControl("imgLikeMessage");
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trMessage");

                UserMessageContract u = (UserMessageContract)e.Item.DataItem;

                //you.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/avatar/no_avatar.png";
                //me.ImageUrl = u.RecepientAvatar.Length > 0 ? "../Images/avatar/" + u.RecepientAvatar : "../Images/avatar/no_avatar.png";
                if (tr != null && u.ReadDate == DateTime.MinValue && !u.IsReply)
                {
                    tr.Attributes.Add("class", "message");
                    tr.Attributes.Add("data-isnew", "true");
                }

                if (u.IsReply)
                {
                    //you.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/avatar/no_avatar.png";
                    me.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/no_avatar.png";
                    you.Visible = false;
                    me.Visible = true;
                }
                else
                {
                    you.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/no_avatar.png";
                    //me.ImageUrl = u.RecepientAvatar.Length > 0 ? "../Images/avatar/" + u.RecepientAvatar : "../Images/avatar/no_avatar.png";

                    you.Visible = true;
                    me.Visible = false;
                }

                if( u.IsLike )
                {
                    string origurl = imgLikeMessage.ImageUrl;
                    imgLikeMessage.ImageUrl = imgLikeMessage.Attributes["data-swap"];
                    imgLikeMessage.Attributes["data-swap"] = origurl;
                }
            }
        }

        protected void btnWriteBack_Click(object sender, EventArgs e)
        {
            try
            {
                
                string[] userids = {};
                if (hdnUserID.Value.Length > 0)
                {
                    userids = hdnUserID.Value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                }
                if( userids.Length == 1 )
                    Response.Redirect("SendMessage?dr=1&to=" + hdnUserID.Value);
                else
                    Response.Redirect("SendMessage?dr=1&grp=" + hdnUserID.Value);
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnGoTohome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home");
        }

        protected void imgReport_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void imgAddToVIP_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                string[] flaggedusers = hdnFlaggedUsers.Value.Split(new char[] {','}, StringSplitOptions.RemoveEmptyEntries);
                List<VIPContract> viplist = new List<VIPContract>();
                foreach (string u in flaggedusers)
                {
                    var vip = new VIPContract() { OwnerUserID = SessionManager.Instance.UserProfile.UserID, VIPUserID = Convert.ToInt64(u) };
                    viplist.Add(vip);
                }

                //string state = hdnAddRemoveVipUserState.Value;
                bool success = new UserClient().AddVIPUser(viplist.ToArray());

                if (success)
                {
                    List<UserSearchContract> list = BindResult(txtSearch.Text, MailBoxUserType.VIP);
                    if(list != null && list.Count > 0)
                        hdnUserID.Value = list[0].UserID.ToString();

                }

            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnRemoveCloseFriend_Click(object sender, EventArgs e)
        {
            try
            {
                string[] flaggedusers = hdnFlaggedUsers.Value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                List<VIPContract> viplist = new List<VIPContract>();
                foreach (string u in flaggedusers)
                {
                    var vip = new VIPContract() { OwnerUserID = SessionManager.Instance.UserProfile.UserID, VIPUserID = Convert.ToInt64(u) };
                    viplist.Add(vip);
                }

                bool success = new UserClient().RemoveVIPUser(viplist.ToArray());

                if (success)
                {
                    List<UserSearchContract> list = BindResult(txtSearch.Text, MailBoxUserType.VIP);
                    if (list != null && list.Count > 0)
                        hdnUserID.Value = list[0].UserID.ToString();

                }

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "ToggleDeleteCloseFriends_" + Guid.NewGuid().ToString().Replace("-",""), "ToggleDeleteCloseFriends(event)", true);
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void imgRemoveCloseFriend_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                //string[] flaggedusers = hdnFlaggedUsers.Value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                List<string> flaggedusers = new List<string>();
                flaggedusers.Add(((ImageButton)sender).Attributes["data-userid"].ToString());

                List<VIPContract> viplist = new List<VIPContract>();
                foreach (string u in flaggedusers)
                {
                    var vip = new VIPContract() { OwnerUserID = SessionManager.Instance.UserProfile.UserID, VIPUserID = Convert.ToInt64(u) };
                    viplist.Add(vip);
                }

                bool success = new UserClient().RemoveVIPUser(viplist.ToArray());

                if (success)
                {
                    List<UserSearchContract> list = BindResult(txtSearch.Text, MailBoxUserType.VIP);
                    if (list != null && list.Count > 0)
                        hdnUserID.Value = list[0].UserID.ToString();

                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ToggleDeleteCloseFriends_123", "ToggleDeleteCloseFriends(event)", true);

            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnAddToCloseFriends_Click(object sender, EventArgs e)
        {
            try
            {
                string[] flaggedusers = hdnFlaggedUsers.Value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                List<VIPContract> viplist = new List<VIPContract>();
                foreach (string u in flaggedusers)
                {
                    var vip = new VIPContract() { OwnerUserID = SessionManager.Instance.UserProfile.UserID, VIPUserID = Convert.ToInt64(u) };
                    viplist.Add(vip);
                }

                //string state = hdnAddRemoveVipUserState.Value;
                bool success = new UserClient().AddVIPUser(viplist.ToArray());

                if (success)
                {
                    List<UserSearchContract> list = BindResult(txtSearch.Text, MailBoxUserType.VIP);
                    if (list != null && list.Count > 0)
                        hdnUserID.Value = list[0].UserID.ToString();

                }

            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnPostback_Click(object sender, EventArgs e)
        {

        }

        protected void Image2_Click(object sender, ImageClickEventArgs e)
        {
            long userid = Convert.ToInt64(hdnUserID.Value);
            UserClient client = new UserClient();
            client.MarkMessageAsRead(userid, SessionManager.Instance.UserProfile.UserID);
        }

        protected void imgDeleteMessage_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                bool deleted = false;
                StringBuilder strids = new StringBuilder();
                foreach (RepeaterItem item in rptConversation.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        CheckBox chk = (CheckBox)item.FindControl("chkDeleteMessage");
                        if (chk != null && chk.Checked)
                        {
                            strids.AppendFormat("<IDS><ID>{0}</ID></IDS>", chk.Attributes["data-usermailid"]);
                        }
                    }
                }
                //string usermailids = context.Request.Form["usermailids"];
                //List<string> mailids = usermailids.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).ToList();
                //StringBuilder strids = new StringBuilder();
                //foreach (string i in mailids)
                //{
                //    strids.AppendFormat("<IDS><ID>{0}</ID></IDS>", i);
                //}
                if (strids.Length > 0)
                {
                    strids.Insert(0, "<UserMailIDs>");
                    strids.AppendLine("</UserMailIDs>");

                    deleted = new UserClient().DeleteUserMail(strids.ToString());

                    if (deleted && hdnUserID.Value.Length > 0)
                    {
                        if (hdnSelectedTab.Value.Length > 0)
                        {
                            BindResult(txtSearch.Text.Length > 0 ? txtSearch.Text : null,
                                (MailBoxUserType)Convert.ToInt32(hdnSelectedTab.Value)); //all

                        }

                        //GetUserMessage();
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AutoSelectUserscript", "AutoSelectUser();", true);
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

                        //<asp:Button ID="btnWriteBack" CssClass="btnWriteBack_GoHome" style="background-image:url('../Images/btnWriteBack.png'); margin-left:0px !important; margin-right:25px !important;background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left; padding-left:15px;" Height="36px" BorderStyle="None" Width="128px"  runat="server" Text="Write Back" OnClientClick="return CheckRecipient();" meta:resourcekey="btnWriteBackResource1" />
                        //<asp:Button ID="btnWriteBackPostBack" style="display:none;background-image:url('../Images/btnWriteBack.png');" Height="36px" BorderStyle="None" runat="server" Text="Write Back" OnClick="btnWriteBack_Click" meta:resourcekey="btnWriteBackResource1" ClientIDMode="Static" />
                        //<asp:Button ID="btnWriteBackGroup" CssClass="btnWriteBack_GoHome" style="display:none;background-image:url('../Images/btnWriteBackGroup.png'); margin-left:0px !important; margin-right:25px !important;  background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left; padding-left:15px;" Height="36px" BorderStyle="None" Width="224px"  runat="server" Text="Write Back to Selected Friends" OnClientClick="return CheckRecipient();" OnClick="btnWriteBack_Click" meta:resourcekey="btnWriteBackResource11" />
                        //<asp:Button ID="btnGoTohome" CssClass="btnWriteBack_GoHome" style="background-image:url('../Images/btnGoHome.png'); margin-left:0px;background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left; padding-left:30px;text-align:right;" Height="36px" BorderStyle="None" runat="server" Width="120px" Text="Go to Home" OnClick="btnGoTohome_Click" meta:resourcekey="btnGoTohomeResource1" />
