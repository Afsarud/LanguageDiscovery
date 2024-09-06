using Language.Discovery.Entity;
using Language.Discovery.MiscService;
using Language.Discovery.UserService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery
{
    public partial class FriendsRoom : System.Web.UI.Page
    {
        long m_userID = 0;
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
                    m_userID = Convert.ToInt64(Request.QueryString["fid"] != null ? Convert.ToInt64( Request.QueryString["fid"]) : m_userID);
                    hdnUserID.Value = m_userID.ToString();
                    ViewState["UserID"] = m_userID; ;
                    LoadUserDetails(m_userID);
                    BindPhoto();
                    UserMessageLikeRankingContract[] list = null;
                    list = new UserService.UserClient().GetUserMessageLikeRanking(m_userID);
                    int count = 0;
                    if (list != null && list.Length > 0)
                        count = list[0].LikeCount;

                    //lblCountLikeLabel.Text = lblCountLikeLabel.Text;
                    lblCountLike.Text = count.ToString() + "!";
                    //BindFriends();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tabbing_ilog", "SelectTab();", true);
                    //BindWhoLikedMe();
                    //btnAddPhoto.Text += "\r\n" + Resources.ProfileSub.btnAddPhoto;
                    //btnViewFriends.Text += "\r\n" + Resources.ProfileSub.btnViewFriends;
                    //lblMyPhoto.Text += "<br/>" + Resources.ProfileSub.lblMyPhoto;
                    //lblWhoLikesMe.Text += "<br/>" + Resources.ProfileSub.lblWhoLikesMe;
                    //btnSaveStatus.Text += "\r\n" + Resources.ProfileSub.btnSaveStatus;

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //private long AddUser(string username, string firstname, string lastname, string address)
        //{
        //    try
        //    {
        //        UserClient client = new UserClient();
        //        UserContract user = new UserContract();
        //        user.UserName = username;
        //        user.FirstName = firstname;
        //        user.LastName = lastname;
        //        user.MiddleName = "";
        //        user.Address= address;

        //        string json = new JavaScriptSerializer().Serialize(user);
        //        long userid = client.AddUser(json);

        //        return userid;
                
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}


        private void LoadUserDetails(long userid)
        {
            try
            {
                UserClient client = new UserClient();
                string json = client.GetUserDetails(userid);
                
                UserContract user = new JavaScriptSerializer().Deserialize<UserContract>(json);
                if (user != null)
                {
                    bool isilike = client.IsILike(userid, SessionManager.Instance.UserProfile.UserID);
                    if (isilike)
                    {
                        like.Attributes["data-ilike"] = "true";
                        like.ImageUrl = "../Images/heartunlike.png";
                    }
                    like.Attributes["data-userstatusid"] = user.UserStatusID.ToString();
                    imgAvatar.ImageUrl = !string.IsNullOrEmpty(user.Avatar) ? "../Images/avatar/" + user.Avatar : "../Images/no_avatar.png";
                    imgAvatar.Attributes["data-ilike"] = isilike.ToString();
                    linkName.Text = user.FirstName;

                   // string js = new MiscService.MiscServiceClient().GetCityOtherName(user.CityID, Constants.English);
                   // List<CityContract> clist = new JavaScriptSerializer().Deserialize<List<CityContract>>(js);

                    //lblLocation.Text = user.Address;
                    lblStatus.Text = user.StatusText;
                    //lblBirthday.Text = user.DateOfBirth.ToLocalTime().ToString("dd/MM/yyyy");
                    //lblAge.Text = CalculateAge(user.DateOfBirth, DateTime.Now).ToString();
                    lblLevel.Text = user.GradeName;
                    lblGender.Text = user.Gender;
                    lblClass.Text = user.ClassName;
                    //lblGrade.Text = user.GradeName; 

                    json = new MiscServiceClient().GetCityOtherName(user.CityID, SessionManager.Instance.UserProfile.NativeLanguage);
                    List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);
                    lblHometown.Text = (list != null && list.Count > 0) ? list[0].CityName : user.CityName;
                    lblLocation.Text = ((list != null && list.Count > 0) ? list[0].CityName : string.Empty) + "," + user.CountryName;
                    lblUserName.Text = user.UserName;

                    PopulateInterest();
                    PopulateAboutMe();

                    if (!string.IsNullOrEmpty(user.Theme) && user.Theme.ToLower() != "default")
                    {
                        hdnColor.Value = user.Theme;
                        MyStyleSheet.Attributes.Add("href", string.Format("../App_Themes/{0}/{0}.css", user.Theme));
                    }
                    if (!string.IsNullOrEmpty(user.Skin))
                    {
                        hdnSkin.Value = user.Skin;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "skingalis", string.Format("ChangeSkin('{0}');", user.Skin), true);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        private int CalculateAge(DateTime birthDate, DateTime now)
        {
            int age = now.Year - birthDate.Year;
            if (now.Month < birthDate.Month || (now.Month == birthDate.Month && now.Day < birthDate.Day)) age--;
            return age;
        }

        private bool GetUserDetailsByUserName(string username)
        {
            try
            {
                bool result = false;
                UserClient client = new UserClient();
                string json = client.GetUserDetailsByUserName(username);
                UserContract user = new JavaScriptSerializer().Deserialize<UserContract>(json);
                if (user != null)
                {
                    m_userID = user.UserID;
                    imgAvatar.ImageUrl = user.Avatar;
                    linkName.Text = user.FirstName;
                    lblLocation.Text = user.Address;
                    lblStatus.Text = user.StatusText;
                    result = true;
                }

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void PopulateInterest()
        {
            try
            {

                string json = new MiscServiceClient().GetInterestList(SessionManager.Instance.UserProfile.NativeLanguage);
                List<InterestContract> list = new JavaScriptSerializer().Deserialize<List<InterestContract>>(json);
                chkInterestGroup.DataSource = list;
                chkInterestGroup.DataBind();

                UserInterestContract[] uilist = new UserClient().GetUserInterest(m_userID, SessionManager.Instance.UserProfile.NativeLanguage);
                if (uilist == null)
                    return;

                foreach (UserInterestContract uic in uilist)
                {
                    ListItem item = chkInterestGroup.Items.FindByValue(uic.InterestID.ToString());
                    if (item != null)
                        item.Selected = true;
                }

              
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        private void PopulateAboutMe()
        {
            try
            {

                string json = new MiscServiceClient().GetAboutMeList(SessionManager.Instance.UserProfile.NativeLanguage);
                List<AboutMeContract> list = new JavaScriptSerializer().Deserialize<List<AboutMeContract>>(json);
                chkAboutMe.DataSource = list;
                chkAboutMe.DataBind();

                UserAboutMeContract[] uilist = new UserClient().GetUserAboutMe(m_userID, null);
                if (uilist == null)
                    return;

                foreach (UserAboutMeContract uac in uilist)
                {
                    AboutMeContract amc = list.Find(x => x.AboutMeHeaderID == uac.AboutMeHeaderID);
                    if (amc != null)
                    {
                        ListItem item = chkAboutMe.Items.FindByValue(amc.AboutMeID.ToString());
                        if (item != null)
                            item.Selected = true;
                    }
                }

                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void btnAddPhoto_Click(object sender, EventArgs e)
        {
            Response.Redirect("Photos");
        }

        private void BindPhoto()
        {
            UserClient client = new UserClient();
            string json = client.GetUserPhoto(m_userID, 3);

            //string url = Request.ServerVariables["URL"]; 
            List<PhotoContract> photolist = new JavaScriptSerializer().Deserialize<List<PhotoContract>>(json);
            if (photolist != null)
            {
                foreach (PhotoContract contract in photolist)
                {
                    if (string.IsNullOrEmpty(contract.Photo))
                        contract.Photo = "../Images/DefaultProfile.png";

                    contract.Photo = "../UserPhoto/" + m_userID.ToString() + "/" + contract.Photo;
                }

                listPhoto.DataSource = photolist;
                listPhoto.DataBind();

            }
            else
            {
                photolist = new List<PhotoContract>();
                photolist.Add(new PhotoContract() { Photo = "../Images/DefaultProfile.png", UserID = SessionManager.Instance.UserProfile.UserID });
                listPhoto.DataSource = photolist;
                listPhoto.DataBind();
            }


        }


        private void BindWhoLikedMe()
        {
            //UserClient client = new UserClient();
            //string json = client.GetWhoLikedMe(m_userID);

            ////string url = Request.ServerVariables["URL"]; 
            //List<WhoLikedMeContract> userlist = new JavaScriptSerializer().Deserialize<List<WhoLikedMeContract>>(json);
            //if (userlist != null)
            //{
            //    foreach (WhoLikedMeContract user in userlist)
            //    {
            //        user.Photo = "../UserPhoto/" + user.UserID.ToString() + "/" + user.Photo;
            //    }

            //    ListView1.DataSource = userlist;
            //    ListView1.DataBind();

            //}
        }

        private void BindFriends()
        {
            //UserClient client = new UserClient();
            //string json = client.GetUserFriends(m_userID);

            ////string url = Request.ServerVariables["URL"]; 
            //List<UserFriendsContract> userlist = new JavaScriptSerializer().Deserialize<List<UserFriendsContract>>(json);
            //if (userlist != null)
            //{
            //    foreach (UserFriendsContract user in userlist)
            //    {
            //        user.Photo = "../UserPhoto/" + user.UserID.ToString() + "/" + user.Photo;
            //        user.Avatar = "../Images/avatar/" + user.Avatar;
            //    }

            //    ListView1.DataSource = userlist;
            //    ListView1.DataBind();

            //}
        }


        protected void linkName_Click(object sender, EventArgs e)
        {
            GoToComposeMessagePage();
        }

        protected void imgWriteNew_Click(object sender, ImageClickEventArgs e)
        {
            GoToComposeMessagePage();
        }

        private void GoToComposeMessagePage()
        {
            long userid = ViewState["UserID"] != null ? Convert.ToInt64(ViewState["UserID"]) : 0;
            if (userid != 0)
                Response.Redirect("SendMessage?to=" + userid.ToString());
        }


    }
}