using Language.Discovery.Entity;
using Language.Discovery.UserService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.MiscService;


namespace Language.Discovery
{
    public partial class Profile : System.Web.UI.Page
    {
        //long m_userID = 3;
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
                    if (!string.IsNullOrEmpty(SessionManager.Instance.UserProfile.Theme) && SessionManager.Instance.UserProfile.Theme.ToLower() != "default")
                    {
                        hdnColor.Value = SessionManager.Instance.UserProfile.Theme;
                        MyStyleSheet.Attributes.Add("href", string.Format("../App_Themes/{0}/{0}.css", SessionManager.Instance.UserProfile.Theme));
                    }
                    if (!string.IsNullOrEmpty(SessionManager.Instance.UserProfile.Skin))
                    {
                        hdnSkin.Value = SessionManager.Instance.UserProfile.Skin;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "skingalis", string.Format("ChangeSkin('{0}');", SessionManager.Instance.UserProfile.Skin), true);
                    }
                    UserMessageLikeRankingContract[] list = null;
                    list = new UserService.UserClient().GetUserMessageLikeRanking(SessionManager.Instance.UserProfile.UserID);
                    int count = 0;
                    if (list != null && list.Length > 0)
                        count = list[0].LikeCount;

                    lblCountLikeLabel.Text = lblCountLikeLabel.Text + " " + count.ToString();
                    //m_userID = Convert.ToInt64(Request.QueryString["fid"] != null ? Convert.ToInt64( Request.QueryString["fid"]) : m_userID);

                    ////Start Tweak for the meantime---------------------------------------
                    //string username = Request.QueryString["un"];
                    //string firstname = Request.QueryString["fn"];
                    //string lastname = Request.QueryString["ln"];
                    //string address = Request.QueryString["ad"];


                    //bool isUserNameExists = false;
                    //if (!string.IsNullOrEmpty(username))
                    //{
                    //    isUserNameExists = GetUserDetailsByUserName(username);

                    //    Session["UserID"] = m_userID;
                    //    if (!isUserNameExists)
                    //    {
                    //        m_userID = AddUser(username, firstname, lastname, address);
                    //    }
                    //}
                    ////End Tweak for the meantime----------------------------------------
                    //Session["UserID"] = m_userID;
                    
                    LoadUserDetails(SessionManager.Instance.UserProfile.UserID);
                    BindPhoto();
                    //BindFriends();
                    PopulateInterest();
                    PopulateAboutMe();
                    PopulateClass();
                    PopulateCity();
                    PopulateGrade();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tabbing_ilog", "SelectTab();InitializeDateOfbirth();", true);
                    //BindWhoLikedMe();
                    //btnAddPhoto.Text += "\r\n" + Resources.ProfileSub.btnAddPhoto;
                    //btnViewFriends.Text += "\r\n" + Resources.ProfileSub.btnViewFriends;
                    //lblMyPhoto.Text += "<br/>" + Resources.ProfileSub.lblMyPhoto;
                    //lblWhoLikesMe.Text += "<br/>" + Resources.ProfileSub.lblWhoLikesMe;
                    //btnSaveStatus.Text += "\r\n" + Resources.ProfileSub.btnSaveStatus;

                    var selected = chkInterestGroup.Items.Cast<ListItem>().Where(x => x.Selected);
                    bool hasyear = ddlGrade.SelectedIndex > 0;
                    if (selected.Count() == 0 || !hasyear)
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SetupMasterMenu", "SetupMasterMenu(false);", true);

                }
                if (SessionManager.Instance.UserProfile.UserTypeID == (int)UserType.Student)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "adminkey", "HideAdmin(true);", true);
                }


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void PopulateClass()
        {
            AuxilliaryServices.AuxilliaryServicesClient client = new AuxilliaryServices.AuxilliaryServicesClient();
            string json = client.GetClassList(SessionManager.Instance.UserProfile.SchoolID);
            List<ClassContract> classlist = new JavaScriptSerializer().Deserialize<List<ClassContract>>(json);

            ddlClass.DataSource = classlist;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassID";
            ddlClass.DataBind();

            if (SessionManager.Instance.UserProfile.ClassID > 0)
                ddlClass.SelectedValue = SessionManager.Instance.UserProfile.ClassID.ToString();
            UpdatePanel1.Update();
        }

        private void PopulateGrade()
        {
            AuxilliaryServices.AuxilliaryServicesClient client = new AuxilliaryServices.AuxilliaryServicesClient();
            GradeContract[] grades = client.GetGradeList();
            List<GradeContract> list = new List<GradeContract>();
            if (grades != null)
            {
                list = grades.ToList();
                list.Insert(0, new GradeContract() { GradeID = 0, GradeName = "[Select Grade]" });
            }

            ddlGrade.DataSource = list;
            ddlGrade.DataTextField = "GradeName";
            ddlGrade.DataValueField = "GradeID";
            ddlGrade.DataBind();

            if (SessionManager.Instance.UserProfile.ClassID > 0)
                ddlClass.SelectedValue = SessionManager.Instance.UserProfile.ClassID.ToString();
            UpdatePanel1.Update();
        }

        private void PopulateCity()
        {
            MiscServiceClient client = new MiscServiceClient();
            string json = client.GetCityListByCountryAndLanguage(SessionManager.Instance.UserProfile.CountryID,SessionManager.Instance.UserProfile.NativeLanguage);
            List<CityContract> citycontract = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);

            ddlHomeTown.DataSource = citycontract;
            ddlHomeTown.DataTextField = "CityName";
            ddlHomeTown.DataValueField = "CityID";
            ddlHomeTown.DataBind();

            json = new MiscServiceClient().GetCityOtherName(SessionManager.Instance.UserProfile.CityID, SessionManager.Instance.UserProfile.NativeLanguage);
            List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);
            if( list != null && list.Count > 0 )
                ddlHomeTown.SelectedValue = list[0].CityID.ToString();
            UpdatePanel1.Update();
        }

        private void PopulateInterest()
        {
            try
            {
                
                string json = new MiscServiceClient().GetInterestList(SessionManager.Instance.UserProfile.NativeLanguage);
                List<InterestContract> list = new JavaScriptSerializer().Deserialize<List<InterestContract>>(json);
                chkInterestGroup.DataSource = list;
                chkInterestGroup.DataBind();

                UserInterestContract[] uilist = new UserClient().GetUserInterest(SessionManager.Instance.UserProfile.UserID, null);
                if (uilist == null)
                    return;

                foreach (UserInterestContract uic in uilist)
                {
                    ListItem item = chkInterestGroup.Items.FindByValue(uic.InterestID.ToString());
                    if (item != null)
                        item.Selected = true;
                }

                UpdatePanel1.Update();
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

                UserAboutMeContract[] uilist = new UserClient().GetUserAboutMe(SessionManager.Instance.UserProfile.UserID, null);
                if (uilist == null)
                    return;

                foreach (UserAboutMeContract uac in uilist)
                {
                    ListItem item = chkAboutMe.Items.FindByValue(uac.AboutMeID.ToString());
                    if (item != null)
                        item.Selected = true;
                }

                UpdatePanel1.Update();
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
                    
                    imgAvatar.ImageUrl = !string.IsNullOrEmpty(user.Avatar) ? "../Images/avatar/" + user.Avatar : "../Images/avatar/no_avatar.png";
                    lblName.Text = user.FirstName;
                    string js = new MiscService.MiscServiceClient().GetCityOtherName(user.CityID, Constants.English);
                    List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(js);
                    if (list != null)
                    {
                        lblLocation.Text = (list != null ? list[0].CityName : string.Empty) + "," + user.CountryName;
                    }
                    else
                    {
                        lblLocation.Text = user.CountryName;
                    }
                    txtStatus.Text = user.StatusText;
                    lblLikeCount.Text = user.LikeCount.ToString();
                    //lblBirthday.Text = user.DateOfBirth.ToString("dd/MM/yyyy");
                    //txtDateOfBirth.Text = user.DateOfBirth.ToLocalTime().ToString("dd/MM/yyyy");
                    //lblAge.Text = CalculateAge(user.DateOfBirth, DateTime.Now).ToString();
                    lblLevel.Text = user.LevelName;
                    ddlGender.SelectedValue= user.Gender;
                    lblSchool.Text = user.NativeLanguage == "en-US" ? SessionManager.Instance.SchoolProfile.Name1 : SessionManager.Instance.SchoolProfile.Name2;
                                        
                    //json = new MiscServiceClient().GetCityOtherName(user.CityID, SessionManager.Instance.UserProfile.NativeLanguage);
                    //List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);
                    //lblHometown.Text = list.Count  > 0 ? list[0].CityName : user.CityName;
                    lblUserName.Text = user.UserName;
                    ddlGrade.SelectedValue = user.GradeID.ToString();
                    if (!SessionManager.Instance.UserProfile.AfterSchool)
                        linkChangePassword.Visible = false;
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
                    //m_userID = user.UserID;
                    imgAvatar.ImageUrl = user.Avatar;
                    lblName.Text = user.FirstName;
                    lblLocation.Text = user.Address;
                    txtStatus.Text = user.StatusText;
                    result = true;
                }

                return result;
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
            string json = client.GetUserPhoto(SessionManager.Instance.UserProfile.UserID, 3);

            //string url = Request.ServerVariables["URL"]; 
            List<PhotoContract> photolist = new JavaScriptSerializer().Deserialize<List<PhotoContract>>(json);
            if (photolist != null)
            {
                foreach (PhotoContract contract in photolist)
                {
                    if (string.IsNullOrEmpty(contract.Photo))
                        contract.Photo = "../Images/DefaultProfile.png";
                    contract.Photo = "../UserPhoto/" + SessionManager.Instance.UserProfile.UserID.ToString() + "/" + contract.Photo;

                }

                listPhoto.DataSource = photolist;
                listPhoto.DataBind();

            }
            else
            {
                photolist = new List<PhotoContract>();
                photolist.Add(new PhotoContract() { Photo = "../Images/DefaultProfile.png", UserID=SessionManager.Instance.UserProfile.UserID });
                listPhoto.DataSource = photolist;
                listPhoto.DataBind();
            }


        }


        private void BindWhoLikedMe()
        {
            //UserClient client = new UserClient();
            //string json = client.GetWhoLikedMe(SessionManager.Instance.UserProfile.UserID);

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
            //string json = client.GetUserFriends(SessionManager.Instance.UserProfile.UserID);

            ////string url = Request.ServerVariables["URL"]; 
            //List<UserFriendsContract> userlist = new JavaScriptSerializer().Deserialize<List<UserFriendsContract>>(json);
            //if (userlist != null)
            //{
            //    foreach (UserFriendsContract user in userlist)
            //    {
            //        user.Photo = "../UserPhoto/" + user.UserID.ToString() + "/" + user.Photo;
            //        user.Avatar= "../Images/avatar/" + user.Avatar;
            //        user.LikeImage = user.ILike ? "../Images/heartUnlike.png" : "../Images/heartLike.png";
            //    }

            //    ListView1.DataSource = userlist;
            //    ListView1.DataBind();

            //}
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //string error = string.Empty;
            //if (imageUpload.PostedFile.ContentLength > 0)
            //    UploadPhoto(imageUpload.PostedFile, txtDescription.Text);

            //BindPhoto();
        }

        private bool UploadPhoto(HttpPostedFile postedFile, string description)
        {
            long userid = SessionManager.Instance.UserProfile.UserID;

            //HttpPostedFile postedFile = FileUpload1.PostedFile.ContentLength > 0 ? FileUpload1.PostedFile : null; //HttpContext.Current.Request.Files["Filedata"];

            //int filesize = postedFile.ContentLength / 1024;
            //if (filesize > 2048)
            //{
            //    lblMessage.Text = "Some of the files is greater than 2MB.";
            //    lblMessage.Visible = true;
            //    return false;
            //}

            string filename = postedFile.FileName;
            UserClient userService = new UserClient();
            Byte[] bytes = new Byte[postedFile.ContentLength];

            postedFile.InputStream.Read(bytes, 0, postedFile.ContentLength);
            PhotoContract photo = new PhotoContract() { Photo = filename, Description = description, ImageBytes = bytes };
            bool uploaded = userService.SaveImage(userid, photo);

            return uploaded;

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (hdnShouldValidate.Value == "1" && !Page.IsValid)
                    return;

                if (hdnShouldValidate.Value == "1")
                {
                    rfvPassword.Enabled = true;
                    revPassword.Enabled = true;
                }
                else
                {
                    rfvPassword.Enabled = false;
                    revPassword.Enabled = false;
                }
                if (Update())
                {
                    imgSuccess.Visible = true;
                    LoadUserDetails(SessionManager.Instance.UserProfile.UserID);

                    var selected = chkInterestGroup.Items.Cast<ListItem>().Where(x => x.Selected);
                    bool hasyear = ddlGrade.SelectedIndex > 0;
                    if (selected.Count() == 0 || !hasyear)
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SetupMasterMenu", "SetupMasterMenu(false);", true);
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SetupMasterMenu", "SetupMasterMenu(true);", true);


                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "tabbing_ilog", "SelectTab();InitializeDateOfbirth();", true);
                if (!string.IsNullOrEmpty(SessionManager.Instance.UserProfile.Skin) && SessionManager.Instance.UserProfile.Skin.ToLower() != "default")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "skingalis", string.Format("ChangeSkin('{0}');", SessionManager.Instance.UserProfile.Skin), true);
                }

                UpdatePanel1.Update();

            }
        }


        private bool UpdateUserInterest()
        {
            bool updated = false;

            UserClient client = new UserClient();
            List<UserInterestContract> li = new List<UserInterestContract>();

            foreach (ListItem item in chkInterestGroup.Items)
            {
                UserInterestContract uic = new UserInterestContract();
                if (item.Selected)
                {
                    uic.InterestID = Convert.ToInt32(item.Value);
                    uic.UserID = SessionManager.Instance.UserProfile.UserID;
                    li.Add(uic);
                }

            }
            if (li.Count == 0)
            {
                li.Add(new UserInterestContract() { UserID = SessionManager.Instance.UserProfile.UserID });
            }
            updated = client.UpdateUserInterest(li.ToArray());
            return updated;
        }

        private bool UpdateUserAboutMe()
        {
            bool updated = false;

            UserClient client = new UserClient();
            List<UserAboutMeContract> li = new List<UserAboutMeContract>();

            foreach (ListItem item in chkAboutMe.Items)
            {
                UserAboutMeContract uac = new UserAboutMeContract();
                if (item.Selected)
                {
                    uac.AboutMeID= Convert.ToInt32(item.Value);
                    uac.UserID = SessionManager.Instance.UserProfile.UserID;
                    li.Add(uac);
                }

            }
            updated = client.UpdateUserAboutMe(li.ToArray());
            return updated;
        }

        private bool UpdateOtherUserInfo()
        {
            bool updated = false;

            UserClient client = new UserClient();
            UserContract uc = new UserContract();

            uc.Password = txtPassword.Text.Length > 0 ? txtPassword.Text : null;
            uc.UserID = SessionManager.Instance.UserProfile.UserID;
            if(ddlClass.SelectedValue.Length > 0)
                uc.ClassID = Convert.ToInt32(ddlClass.SelectedValue);

            uc.Gender = ddlGender.SelectedValue;
            uc.CityID = string.IsNullOrEmpty( ddlHomeTown.SelectedValue) ? 0 : Convert.ToInt32(ddlHomeTown.SelectedValue);
            uc.GradeID = Convert.ToInt32(ddlGrade.SelectedValue);
            //uc.DateOfBirth = DateTime.ParseExact(txtDateOfBirth.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);//Convert.ToDateTime(txtDateOfBirth.Text,System.Globalization.CultureInfo.InvariantCulture);
            updated = client.UpdateOtherUserInfo(uc);
            if (updated)
            {
                SessionManager.Instance.UserProfile.CityID = uc.CityID;
                SessionManager.Instance.UserProfile.Gender = uc.Gender;
                SessionManager.Instance.UserProfile.ClassID = uc.ClassID;
                SessionManager.Instance.UserProfile.GradeID = uc.GradeID;
            }
            return updated;
        }

        private bool Update()
        {
            try
            {
                bool result = false;
                result = UpdateUserInterest();
                result = UpdateUserAboutMe();
                result = UpdateOtherUserInfo();

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnReload_Click(object sender, EventArgs e)
        {
            try
            {
                    bool success = new UserClient().UpdateUserTheme(SessionManager.Instance.UserProfile.UserID, hdnColor.Value);
                    if (success)
                    {
                        SessionManager.Instance.UserProfile.Theme = hdnColor.Value;
                        if (!string.IsNullOrEmpty(SessionManager.Instance.UserProfile.Theme) && SessionManager.Instance.UserProfile.Theme.ToLower() != "default")
                        {
                            MyStyleSheet.Attributes.Add("href", string.Format("../App_Themes/{0}/{0}.css", SessionManager.Instance.UserProfile.Theme));
                        }

                    }
                    success = new UserClient().UpdateUserSkin(SessionManager.Instance.UserProfile.UserID, hdnSkin.Value);
                    if (success)
                    {
                        SessionManager.Instance.UserProfile.Skin = hdnSkin.Value;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "skingalis", string.Format("ChangeSkin('{0}');", SessionManager.Instance.UserProfile.Skin), true);

                    }
                if(success)
                    Response.Redirect("Profile");

            }
            catch (Exception)
            {
                throw;
            }
        }


    }
}