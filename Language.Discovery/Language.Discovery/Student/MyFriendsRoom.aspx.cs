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
    public partial class MyFriendsRoom : System.Web.UI.Page
    {
        long m_userID = 0;

        private UserContract User
        {
            get
            {
                UserContract user = null;
                if (ViewState["User"] != null)
                    user = (UserContract)ViewState["User"];
                return user;
            }
            set
            {
                ViewState["User"] = value;
            }
        }

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
                    m_userID = Convert.ToInt64(Request.QueryString["fid"] != null ? Convert.ToInt64(Request.QueryString["fid"]) : m_userID);
                    Repository.UserRepository rep = new Repository.UserRepository();
                    UserContract user =  rep.GetUserDetails(m_userID);
                    this.User = user;
                    if (!string.IsNullOrEmpty(user.Skin))
                    {
                        hdnSkin.Value =user.Skin;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "skingalis", string.Format("ChangeSkin('{0}');", user.Skin), true);
                    }
                    UserMessageLikeRankingContract[] list = null;
                    list = new UserService.UserClient().GetUserMessageLikeRanking(m_userID);
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
                    
                    LoadUserDetails(m_userID);
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

                    //var selected = chkInterestGroup.Items.Cast<ListItem>().Where(x => x.Selected);
                    //bool hasyear = ddlGrade.SelectedIndex > 0;
                    //if (selected.Count() == 0 || !hasyear)
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "SetupMasterMenu", "SetupMasterMenu(false);", true);

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
            string json = client.GetClassList(this.User.SchoolID);
            List<ClassContract> classlist = new JavaScriptSerializer().Deserialize<List<ClassContract>>(json);

            ddlClass.DataSource = classlist;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassID";
            ddlClass.DataBind();

            if (this.User.ClassID > 0)
                ddlClass.SelectedValue = this.User.ClassID.ToString();
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

            if (this.User.ClassID > 0)
                ddlClass.SelectedValue = this.User.ClassID.ToString();
            UpdatePanel1.Update();
        }

        private void PopulateCity()
        {
            MiscServiceClient client = new MiscServiceClient();
            string json = client.GetCityListByCountryAndLanguage(this.User.CountryID,this.User.NativeLanguage);
            List<CityContract> citycontract = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);

            ddlHomeTown.DataSource = citycontract;
            ddlHomeTown.DataTextField = "CityName";
            ddlHomeTown.DataValueField = "CityID";
            ddlHomeTown.DataBind();

            json = new MiscServiceClient().GetCityOtherName(this.User.CityID, this.User.NativeLanguage);
            List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);
            if( list != null && list.Count > 0 )
                ddlHomeTown.SelectedValue = list[0].CityID.ToString();
            UpdatePanel1.Update();
        }

        private void PopulateInterest()
        {
            try
            {
                
                string json = new MiscServiceClient().GetInterestList(this.User.NativeLanguage);
                List<InterestContract> list = new JavaScriptSerializer().Deserialize<List<InterestContract>>(json);
                chkInterestGroup.DataSource = list;
                chkInterestGroup.DataBind();

                UserInterestContract[] uilist = new UserClient().GetUserInterest(this.User.UserID, null);
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

                string json = new MiscServiceClient().GetAboutMeList(this.User.NativeLanguage);
                List<AboutMeContract> list = new JavaScriptSerializer().Deserialize<List<AboutMeContract>>(json);
                chkAboutMe.DataSource = list;
                chkAboutMe.DataBind();

                UserAboutMeContract[] uilist = new UserClient().GetUserAboutMe(this.User.UserID, null);
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
                    linkName.Text = user.FirstName;
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
                                        
                    //json = new MiscServiceClient().GetCityOtherName(user.CityID, this.User.NativeLanguage);
                    //List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);
                    //lblHometown.Text = list.Count  > 0 ? list[0].CityName : user.CityName;
                    lblUserName.Text = user.UserName;
                    ddlGrade.SelectedValue = user.GradeID.ToString();
                    if (!user.AfterSchool)
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
            string json = client.GetUserPhoto(this.User.UserID, 3);

            //string url = Request.ServerVariables["URL"]; 
            List<PhotoContract> photolist = new JavaScriptSerializer().Deserialize<List<PhotoContract>>(json);
            if (photolist != null)
            {
                imgPhoto.ImageUrl = "../UserPhoto/" + this.User.UserID.ToString() + "/" + photolist[0].Photo;
                lblCaption.Text=photolist[0].Description;

                //foreach (PhotoContract contract in photolist)
                //{
                //    if (string.IsNullOrEmpty(contract.Photo))
                //        contract.Photo = "../Images/DefaultProfile.png";
                //    contract.Photo = "../UserPhoto/" + this.User.UserID.ToString() + "/" + contract.Photo;

                //}

                //listPhoto.DataSource = photolist;
                //listPhoto.DataBind();

            }
            else
            {
                //photolist = new List<PhotoContract>();
                //photolist.Add(new PhotoContract() { Photo = "../Images/DefaultProfile.png", UserID=this.User.UserID });
                //listPhoto.DataSource = photolist;
                //listPhoto.DataBind();
                imgPhoto.ImageUrl = "../Images/DefaultProfile.png";
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
            long userid = this.User.UserID;

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
                    LoadUserDetails(this.User.UserID);

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
                if (!string.IsNullOrEmpty(this.User.Skin) && this.User.Skin.ToLower() != "default")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "skingalis", string.Format("ChangeSkin('{0}');", this.User.Skin), true);
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
                    uic.UserID = this.User.UserID;
                    li.Add(uic);
                }

            }
            if (li.Count == 0)
            {
                li.Add(new UserInterestContract() { UserID = this.User.UserID });
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
                    uac.UserID = this.User.UserID;
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
            uc.UserID = this.User.UserID;
            if(ddlClass.SelectedValue.Length > 0)
                uc.ClassID = Convert.ToInt32(ddlClass.SelectedValue);

            uc.Gender = ddlGender.SelectedValue;
            uc.CityID = string.IsNullOrEmpty( ddlHomeTown.SelectedValue) ? 0 : Convert.ToInt32(ddlHomeTown.SelectedValue);
            uc.GradeID = Convert.ToInt32(ddlGrade.SelectedValue);
            //uc.DateOfBirth = DateTime.ParseExact(txtDateOfBirth.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);//Convert.ToDateTime(txtDateOfBirth.Text,System.Globalization.CultureInfo.InvariantCulture);
            updated = client.UpdateOtherUserInfo(uc);
            if (updated)
            {
                this.User.CityID = uc.CityID;
                this.User.Gender = uc.Gender;
                this.User.ClassID = uc.ClassID;
                this.User.GradeID = uc.GradeID;
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
                    bool success = new UserClient().UpdateUserTheme(this.User.UserID, hdnColor.Value);
                    if (success)
                    {
                        this.User.Theme = hdnColor.Value;
                        if (!string.IsNullOrEmpty(this.User.Theme) && this.User.Theme.ToLower() != "default")
                        {
                            MyStyleSheet.Attributes.Add("href", string.Format("../App_Themes/{0}/{0}.css", this.User.Theme));
                        }

                    }
                    success = new UserClient().UpdateUserSkin(this.User.UserID, hdnSkin.Value);
                    if (success)
                    {
                        this.User.Skin = hdnSkin.Value;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "skingalis", string.Format("ChangeSkin('{0}');", this.User.Skin), true);

                    }
                if(success)
                    Response.Redirect("MyRoom");

            }
            catch (Exception)
            {
                throw;
            }
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
            long userid = this.User.UserID;//ViewState["UserID"] != null ? Convert.ToInt64(ViewState["UserID"]) : 0;
            if (userid != 0)
                Response.Redirect("SendMessage?to=" + userid.ToString());
        }



    }
}