using Language.Discovery.Entity;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.UserService;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Admin.SchoolService;
using Language.Discovery.Repository;
using System.Configuration;

namespace Language.Discovery.Admin
{
    public partial class User : BasePage
    {

        private int UserID
        {
            get
            {
                int sid = 0;

                if (ViewState["UserID"] != null)
                {
                    sid = Convert.ToInt32(ViewState["UserID"]);
                }
                
                return sid;
            }
            set
            {
                ViewState["UserID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                txtDateOfBirth.Text = string.Empty;//DateTime.Now.ToString("dd/MM/yyyy");
                PopulateDropDownList();
                BindResult();
                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    HideNotImportantFields();
                }
            }

            //if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            //{
            //    btnSave.Enabled = false;
            //    btnDelete.Enabled = false;
            //    btnClear.Enabled = false;
            //}
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setupdates1", "InitializeDate();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideOtherInfo_xxxxx", "HideOtherInfo();", true);
            ckbIsPalleteVisible.Visible = false;
        }

        private void PopulateDropDownList()
        {
            try
            {
                MiscServiceClient mclient = new MiscServiceClient();

                string json = mclient.GetCountryList();
                List<CountryContract> countrylist = new JavaScriptSerializer().Deserialize<List<CountryContract>>(json);
                if (countrylist == null)
                {
                    countrylist = new List<CountryContract>();
                }
                List<CountryContract> countrylist1 = countrylist.ToList();
                countrylist.Insert(0, new CountryContract() { CountryID = 0, CountryName = hdnAll.Value });
                ddlSearchCountry.DataSource = countrylist;
                ddlSearchCountry.DataTextField = "CountryName";
                ddlSearchCountry.DataValueField = "CountryID";
                ddlSearchCountry.DataBind();

                countrylist1.Insert(0, new CountryContract() { CountryID = 0, CountryName = hdnSelectCountry.Value });
                ddlCountry.DataSource = countrylist1;
                ddlCountry.DataTextField = "CountryName";
                ddlCountry.DataValueField = "CountryID";
                ddlCountry.DataBind();
                if( SessionManager.Instance.UserProfile.UserTypeName == "Teacher" )
                    json = new AuxilliaryService.AuxilliaryServicesClient().GetClassList(SessionManager.Instance.UserProfile.SchoolID);
                else
                    json = mclient.GetClassList();
                List<ClassContract> classlist = new JavaScriptSerializer().Deserialize<List<ClassContract>>(json);
                if (classlist == null)
                {
                    classlist = new List<ClassContract>();
                }
                List<ClassContract> classlist1 = classlist.ToList();
                classlist.Insert(0, new ClassContract() { ClassID = 0, ClassName = hdnAll.Value });
                
                ddlSearchClass.DataSource = classlist;
                ddlSearchClass.DataTextField = "ClassName";
                ddlSearchClass.DataValueField = "ClassID";
                ddlSearchClass.DataBind();

                classlist1.Insert(0, new ClassContract() { ClassID = 0, ClassName = hdnSelectClass.Value });
                classlist1.Insert(1, new ClassContract() { ClassID = -1, ClassName = "None" });
                ddlClass.DataSource = classlist1;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassID";
                ddlClass.DataBind();

                //json = mclient.GetCityList();
                json = mclient.GetCityList();
                List<CityContract> citylist = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);
                if (citylist == null)
                {
                    citylist = new List<CityContract>();
                }
                List<CityContract> citylist1 = citylist.ToList();
                citylist.Insert(0, new CityContract() { CityID = 0, CityName = hdnAll.Value });
                ddlSearchCity.DataSource = citylist;
                ddlSearchCity.DataTextField = "CityName";
                ddlSearchCity.DataValueField = "CityID";
                ddlSearchCity.DataBind();

                citylist1.Insert(0, new CityContract() { CityID = 0, CityName = hdnSelectCity.Value });
                ddlCity.DataSource = citylist1;
                ddlCity.DataTextField = "CityName";
                ddlCity.DataValueField = "CityID";
                ddlCity.DataBind();

                json = mclient.GetLevelList("");
                List<LevelContract> levellist = new JavaScriptSerializer().Deserialize<List<LevelContract>>(json);
                if (levellist == null)
                {
                    levellist = new List<LevelContract>();
                }
                levellist.Insert(0, new LevelContract() { LevelID = 0, LevelName = hdnSelectLevel.Value });
                ddlLevel.DataSource = levellist;
                ddlLevel.DataTextField = "LevelName";
                ddlLevel.DataValueField = "LevelID";
                ddlLevel.DataBind();

                List<GradeContract> gradelist = new AuxilliaryService.AuxilliaryServicesClient().GetGradeList().ToList();
                if (gradelist == null)
                {
                    gradelist = new List<GradeContract>();
                }
                gradelist.Insert(0, new GradeContract() { GradeID = 0, GradeName= hdnSelectGrade.Value });
                ddlGrade.DataSource = gradelist;
                ddlGrade.DataTextField = "GradeName";
                ddlGrade.DataValueField = "GradeID";
                ddlGrade.DataBind();


                json = mclient.GetSchoolList("");
                List<SchoolContract> schoollist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                if (schoollist == null)
                {
                    schoollist = new List<SchoolContract>();
                }
                schoollist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnSelectSchool.Value, Name2 = hdnSelectSchool.Value });
                ddlSchool.DataSource = schoollist;
                ddlSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSchool.DataValueField = "SchoolID";
                ddlSchool.DataBind();

              
                var sc = schoollist.Find(x => x.SchoolID == 0);
                sc.Name1 = hdnAll.Value;
                ddlSearchSchool.DataSource = schoollist;
                ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();

                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSearchSchool.Enabled = false;
                    ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();

                    ddlSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                    ddlSchool.Enabled = false;
                    ChangeOtherInfo();
                    ddlUserType.Enabled = false;                    
                }

                json = mclient.GetUserTypeList();
                List<UserTypeContract> usertypelist = new JavaScriptSerializer().Deserialize<List<UserTypeContract>>(json);
                if (usertypelist == null)
                {
                    usertypelist = new List<UserTypeContract>();
                }
                usertypelist.Insert(0, new UserTypeContract() { UserTypeID = 0, UserTypeName =  hdnSelectUserType.Value});
                ddlUserType.DataSource = usertypelist;
                ddlUserType.DataTextField = "UserTypeName";
                ddlUserType.DataValueField = "UserTypeID";
                ddlUserType.DataBind();

                json = mclient.GetLanguageList();
                List<LanguageContract> llist = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);

                //List<LanguageContract> llist = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);
                ddlNativeLanguage.DataSource = llist;
                ddlNativeLanguage.DataTextField = "LanguageName";
                ddlNativeLanguage.DataValueField = "LanguageCode";
                ddlNativeLanguage.DataBind();

                ddlLearningLanguage.DataSource = llist;
                ddlLearningLanguage.DataTextField = "LanguageName";
                ddlLearningLanguage.DataValueField = "LanguageCode";
                ddlLearningLanguage.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Clear()
        {
            UserID = 0;
            txtUserName.Text = string.Empty;
            txtFirstName.Text = string.Empty;
            txtMiddleName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtDateOfBirth.Text = string.Empty;//DateTime.Now.ToString("dd/MM/yyyy");
            txtTelephone.Text = string.Empty;
            txtFax.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtPassword2.Text = string.Empty;
            ddlClass.SelectedValue = "0";
            ddlUserType.SelectedValue = "0";
            ddlCountry.SelectedValue = "0";
            ddlCity.SelectedValue = "0";
            if (SessionManager.Instance.UserProfile.UserTypeName != "Teacher")
            {
                ddlSchool.SelectedValue = "0";
            }
            ddlLevel.SelectedValue = "0";
            ckbIsPalleteVisible.Checked = false;
            //txtNativeLanguage.Text = string.Empty;
            //txtLearningLanguage.Text = string.Empty;
            //txtSubNativeLanguage.Text = string.Empty;
            txtTeachersName.Text = string.Empty;
            txtParentsName.Text = string.Empty;
            chkActivate.Checked = false;
            chkAfterSchool.Checked = false;
            ClearPasswordField(true);
            btnCancelChangePassword.Visible = false;
            chkRobot.Checked = false;
            chkAllowTalk.Checked = false;
            chkTCRead.Checked = false;
            txtSchoolEntry.Text = string.Empty;
            txtClass2.Text = string.Empty;
            txtClass3.Text = string.Empty;
            txtNote1.Text = string.Empty;
            txtNote2.Text = string.Empty;
            txtNote3.Text = string.Empty;
            txtNote4.Text = string.Empty;
            chkEnabledFreeMessage.Checked = false;
            chkOrderByLearningLanguage.Checked = false;
            chkSoundAndMail.Checked = false;
            ddlSeparator.SelectedIndex = 0;
            txtMatchingFrequency.Text = string.Empty;
            chkParentsInfoStored.Checked = false;

        }

        private void BindResult()
        {
            try
            {
                UserService.UserClient client = new UserService.UserClient();
                SearchUserDTO dto = new SearchUserDTO();

                if (txtSearchFirstName.Text != string.Empty)
                {
                    dto.FirstName = txtSearchFirstName.Text;
                }
                if (txtSearchLastName.Text != string.Empty)
                {
                    dto.LastName = txtSearchLastName.Text;
                }
                if (txtSearchUserName.Text != string.Empty)
                {
                    dto.UserName = txtSearchUserName.Text;
                }
                dto.SchoolID = Convert.ToInt32(ddlSearchSchool.SelectedValue);
                if (ddlSearchCountry.SelectedValue != string.Empty)
                {
                    dto.CountryID = Convert.ToInt32(ddlSearchCountry.SelectedValue);
                }
                if (ddlSearchClass.SelectedValue != string.Empty)
                {
                    dto.ClassID = Convert.ToInt32(ddlSearchClass.SelectedValue);
                }
                if (ddlSearchCity.SelectedValue != string.Empty)
                {
                    dto.CityID = Convert.ToInt32(ddlSearchCity.SelectedValue);
                }
                dto.PageNumber = grdResult.PageIndex == 0 ? 1 : grdResult.PageIndex + 1;
                dto.RowsPerPage = 10;

                int virtualcount = 0;
                string json = client.SearchUserAdmin(dto, out virtualcount);
                List<UserContract> list = new JavaScriptSerializer().Deserialize<List<UserContract>>(json);
                grdResult.VirtualItemCount = virtualcount;
                grdResult.DataSource = list;
                grdResult.DataBind();
                upSearch.Update();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool Save()
        {
            try
            {
                if (!btnChangePassword.Visible && !btnCancelChangePassword.Visible) {
                    EncryptDecrypt();
                }
                
                UserService.UserClient client = new UserService.UserClient();
                UserContract uc = new UserContract();

                string uname = txtUserName.Text;

                if (ddlSchool.SelectedValue != "0")
                {
                    SchoolContract school = new SchoolServiceClient().GetByID(Convert.ToInt64(ddlSchool.SelectedValue));
                    uname = uname.Replace("@" + school.SchoolCode, "").Replace("." + school.SchoolCode, "") + ddlSeparator.SelectedValue + school.SchoolCode;

                    //if (uname.Contains(ddlSeparator.SelectedValue))
                    //    uname = uname.Remove(uname.IndexOf(ddlSeparator.SelectedValue)) + ddlSeparator.SelectedValue + school.SchoolCode;
                    //else
                    //    uname = uname + ddlSeparator.SelectedValue + school.SchoolCode;

                    //uname = uname + "@" + school.SchoolCode;
                }
                    
                if (UserID == 0)
                {

                    string json = client.GetUserDetailsByUserName(uname);
                    if (json != "null")
                    {
                        ShowMessage("UserName already in use", true);
                        return false;
                    }
                }

                uc.UserName = uname; //txtUserName.Text;
                uc.FirstName = txtFirstName.Text;
                uc.MiddleName = txtMiddleName.Text;
                uc.LastName = txtLastName.Text;
                uc.Address = txtAddress.Text;
                DateTime dtDateOfBirth;
                if (txtDateOfBirth.Text.Length == 0 && !DateTime.TryParse(txtDateOfBirth.Text, out dtDateOfBirth))
                {
                    txtDateOfBirth.Text = string.Empty;//DateTime.Now.ToString("dd/MM/yyyy");
                }
                else
                {
                    uc.DateOfBirth = txtDateOfBirth.Text.Length > 0 ? DateTime.ParseExact(txtDateOfBirth.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : DateTime.Now;
                }
                Security sec = new Security();
                
                uc.Telephone = txtTelephone.Text;
                uc.Fax = txtFax.Text;
                uc.Email = txtEmail.Text;
                if (txtPassword.Text != hdnPassword.Value)
                {
                    uc.Password = txtPassword.Text.Length > 0 ? sec.Encrypt(txtPassword.Text, ConfigurationManager.AppSettings.Get("Salt")) : hdnPassword.Value;
                }
                else
                {
                    uc.Password = txtPassword.Text;
                }
                uc.Password2 = txtPassword2.Text;
                uc.Gender = ddlGender.SelectedValue;
                if (UserID== 0 && uc.Gender == "Male")
                    uc.Avatar = "AB-1.png";
                else if (UserID == 0 && uc.Gender == "Female")
                    uc.Avatar = "JG-1.png";

                if (ddlClass.SelectedValue != string.Empty)
                {
                    uc.ClassID = ddlClass.SelectedValue == "-1" ? 0 : Convert.ToInt32(ddlClass.SelectedValue);
                }
                if (ddlUserType.SelectedValue != string.Empty)
                {
                    uc.UserTypeID = Convert.ToInt32(ddlUserType.SelectedValue);
                }
                if (ddlCountry.SelectedValue != string.Empty)
                {
                    uc.CountryID = Convert.ToInt32(ddlCountry.SelectedValue);
                }
                if (ddlCity.SelectedValue != string.Empty)
                {
                    uc.CityID = Convert.ToInt32(ddlCity.SelectedValue);
                }
                if (ddlSchool.SelectedValue != string.Empty)
                {
                    uc.SchoolID = Convert.ToInt32(ddlSchool.SelectedValue);
                }
                if (ddlLevel.SelectedValue != string.Empty)
                {
                    uc.LevelID = Convert.ToInt32(ddlLevel.SelectedValue);
                }
                if (ddlGrade.SelectedValue != string.Empty)
                {
                    uc.GradeID  = Convert.ToInt32(ddlGrade.SelectedValue);
                }
                uc.Custom1 = ddlClass.SelectedIndex > 0 ?  ddlClass.SelectedItem.Text : "";
                uc.Custom2 = txtClass2.Text;
                uc.Custom3 = txtClass3.Text;
                uc.Note1= txtNote1.Text;
                uc.Note2 = txtNote2.Text;
                uc.Note3 = txtNote3.Text;
                uc.Note4 = txtNote4.Text;
                uc.IsPalleteVisible = ckbIsPalleteVisible.Checked;
                //uc.NativeLanguage = txtNativeLanguage.Text;
                //uc.LearningLanguage = txtLearningLanguage.Text;
                //uc.SubNativeLanguage = txtSubNativeLanguage.Text;
                uc.TeachersName = txtTeachersName.Text;
                uc.ParentsName = txtParentsName.Text;
                uc.IsActive = chkActivate.Checked;
                uc.AfterSchool = chkAfterSchool.Checked;
                uc.IsRobot = chkRobot.Checked;
                uc.AllowTalk = chkAllowTalk.Checked;
                uc.HasAgreedTC = chkTCRead.Checked;
                uc.EnabledFreeMessage = chkEnabledFreeMessage.Checked;
                uc.SoundAndMail = chkSoundAndMail.Checked;
                uc.OrderByLearningLanguageFlag= chkOrderByLearningLanguage.Checked;
                uc.ShouldUpdateTalkTime = chkUpdateTalkTime.Checked;
                uc.NumberOfMatching = Convert.ToInt32(txtMatchingFrequency.Text);
                uc.LinkKey = txtLinkKey.Text;
                uc.IsParentsInfoStored = chkParentsInfoStored.Checked;
                uc.SubLanguageOptionFlag = chkShowRomanji.Checked;
                string totaltime = txtTotalTime.Text.Trim().Length == 0 ? "0" : txtTotalTime.Text;
                string balancetime = txtBalanceTime.Text.Trim().Length == 0 ? "0" : txtBalanceTime.Text;
                string sessiontime = txtTalkSessionTime.Text.Trim().Length == 0 ? "0" : txtTalkSessionTime.Text;

                uc.TotalTime = Convert.ToInt32(totaltime);
                if(chkUpdateTalkTime.Checked)
                    uc.BalanceTime= Convert.ToInt32(totaltime);
                else
                    uc.BalanceTime = Convert.ToInt32(balancetime);
                uc.SessionTime = Convert.ToInt32(sessiontime);
                bool updated = false;

                if (UserID == 0)
                {
                    int Userid = client.AddUser(uc);
                    UserID = Userid;
                }
                else
                {
                    uc.UserID = UserID;
                    updated = client.UpdateUser(uc);
                }
                btnShowPassword.Visible = true;

                return true;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindResult();
        }

        protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdResult.PageIndex = e.NewPageIndex;
            BindResult();
        }

        protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(grdResult, "Select$" + e.Row.RowIndex.ToString()));
                e.Row.Style.Add("cursor", "pointer");

                e.Row.Attributes.Add("onmouseover",
               "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='teal';this.originalcolor=this.style.color;this.style.color='white'");

                // when mouse leaves the row, change the bg color to its original value   
                e.Row.Attributes.Add("onmouseout",
                "this.style.backgroundColor=this.originalstyle;this.style.color=this.originalcolor;");
            }
        }

        protected void grdResult_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadSelected();
        }

        private void LoadSelected()
        {
            try
            {
                GridViewRow gvRow = grdResult.SelectedRow;
                int Userheaderid = Convert.ToInt32(((HiddenField)gvRow.FindControl("hdnSearchUserHeaderID")).Value);
                UserID = Userheaderid;
                UserService.UserClient client = new UserService.UserClient();
                UserContract uc = client.GetByID(Userheaderid);

                //if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")// && SessionManager.Instance.UserProfile.UserID == UserID)
                //{
                //    btnSave.Enabled = true;
                //    btnDelete.Enabled = false;
                //    btnClear.Enabled = false;
                //}
                //else// if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher" && SessionManager.Instance.UserProfile.UserID != UserID)
                //{
                //    btnSave.Enabled = true;
                //    btnDelete.Enabled = true;
                //    btnClear.Enabled = true;

                //}
                if (uc != null)
                {

                    hdnUserSchoolId.Value = uc.SchoolID.ToString();
                    txtUserName.Text = uc.UserName;
                    txtFirstName.Text = uc.FirstName;
                    txtMiddleName.Text = uc.MiddleName;
                    txtLastName.Text = uc.LastName;
                    txtAddress.Text = uc.Address;
                    if (uc.DateOfBirth != DateTime.MinValue)
                        txtDateOfBirth.Text = uc.DateOfBirth.ToString("dd/MM/yyyy");
                    else
                        txtDateOfBirth.Text = string.Empty;

                    txtTelephone.Text = uc.Telephone;
                    txtFax.Text = uc.Fax;
                    txtEmail.Text = uc.Email;
                    txtPassword.Text = uc.Password;
                    txtConfirmPassword.Text = uc.Password;
                    hdnPassword.Value = uc.Password;
                    ClearPasswordField(false);
                    txtPassword2.Text = uc.Password2;
                    ListItem clitem = ddlClass.Items.FindByValue(uc.ClassID.ToString());
                    if (clitem != null && clitem.Value != "0")
                        ddlClass.SelectedValue = uc.ClassID.ToString();
                    else
                        ddlClass.SelectedValue = "-1";

                    ddlUserType.SelectedValue = uc.UserTypeID.ToString();
                    ddlCountry.SelectedValue = uc.CountryID.ToString();
                    ddlGender.SelectedValue = uc.Gender;

                    string json = new MiscServiceClient().GetCityOtherName(uc.CityID, Constants.English);
                    List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);

                    if (list != null && list.Count > 0)
                        ddlCity.SelectedValue = list[0].CityID.ToString();

                    ListItem item = ddlSchool.Items.FindByValue(uc.SchoolID.ToString());
                    if (item != null)
                        ddlSchool.SelectedValue = uc.SchoolID.ToString();

                    ddlLevel.SelectedValue = uc.LevelID.ToString();
                    ddlGrade.SelectedValue = uc.GradeID.ToString();
                    ckbIsPalleteVisible.Checked = uc.IsPalleteVisible;
                    //txtNativeLanguage.Text = uc.NativeLanguage;
                    //txtLearningLanguage.Text = uc.LearningLanguage;
                    //txtSubNativeLanguage.Text = uc.SubNativeLanguage;
                    txtTeachersName.Text = uc.TeachersName;
                    txtParentsName.Text = uc.ParentsName;
                    txtClass2.Text = uc.Custom2;
                    txtClass3.Text = uc.Custom3;
                    txtNote1.Text = uc.Note1;
                    txtNote2.Text = uc.Note2;
                    txtNote3.Text = uc.Note3;
                    txtNote4.Text = uc.Note4;
                    chkActivate.Checked = uc.IsActive;
                    chkAfterSchool.Checked = uc.AfterSchool;
                    chkRobot.Checked = uc.IsRobot;
                    chkAllowTalk.Checked = uc.AllowTalk;
                    txtSchoolEntry.Text = uc.SchoolEntry;
                    chkTCRead.Checked = uc.HasAgreedTC;
                    ddlNativeLanguage.SelectedValue = uc.NativeLanguage;
                    ddlLearningLanguage.SelectedValue = uc.LearningLanguage;
                    chkEnabledFreeMessage.Checked = uc.EnabledFreeMessage;
                    chkSoundAndMail.Checked = uc.SoundAndMail;
                    chkOrderByLearningLanguage.Checked = uc.OrderByLearningLanguageFlag;
                    txtTalkSessionTime.Text = uc.SessionTime.ToString();
                    txtBalanceTime.Text = uc.BalanceTime == -1 ? "" : uc.BalanceTime.ToString();
                    txtTotalTime.Text = uc.TotalTime.ToString();
                    txtMatchingFrequency.Text = uc.NumberOfMatching.ToString();
                    txtLinkKey.Text = uc.LinkKey;
                    chkParentsInfoStored.Checked = uc.IsParentsInfoStored;
                    chkShowRomanji.Checked = uc.SubLanguageOptionFlag;
                    if (uc.UserName.Contains("@"))
                        ddlSeparator.SelectedValue = "@";
                    else
                        ddlSeparator.SelectedValue = ".";
                    Validator();

                    btnShowPassword.Attributes.Add("data-text", "");
                    btnChangePassword.Visible = true;
                    btnShowPassword.Text = "Decrypt Password";
                }

                upDetail.Update();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "HideOtherInfo_xxxxx", "HideOtherInfo();", true);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //{
            //    FileUpload file = (FileUpload)e.Item.FindControl("fileupload");

            //    if (file != null)
            //    {

            //        byte[] buffer = new byte[file.PostedFile.ContentLength];
            //        file.PostedFile.InputStream.Read(buffer, 0, file.PostedFile.ContentLength);

            //    }
            //}
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                {
                    return;
                }
                
                if (UserID == 0 && SessionManager.Instance.UserProfile.UserTypeName == "Teacher" && SessionManager.Instance.SchoolProfile.StudentCount == SessionManager.Instance.SchoolProfile.License)
                {
                    ShowMessage("Save failed: Your school already reach the maximum number of license users.", true);
                    return;
                }
                if (chkUpdateTalkTime.Checked)
                {
                    SchoolRepository rep = new SchoolRepository();
                    SchoolContract school = rep.GetByID(Convert.ToInt32(hdnUserSchoolId.Value));
                    if (school != null)
                    {
                        int talktime = school.TalkTime;
                        int totalTime = txtTotalTime.Text.Trim().Length == 0 ? 0 : Convert.ToInt32(txtTotalTime.Text);
                        if (talktime < totalTime)
                        {
                            ShowMessage("Save failed: your school have only " + talktime.ToString() + " Talk time remaining.", true);
                            return;
                        }
                    }
                }

                if (Save())
                {
                    chkUpdateTalkTime.Checked = false;
                    ShowMessage(false);
                    ClearPasswordField(false);
                    LoadSelected();
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (UserID != 0)
                {
                    UserService.UserClient client = new UserService.UserClient();
                    bool deleted = client.DeleteUser(UserID);
                    if (deleted)
                    {
                        Clear();
                        BindResult();
                        ShowMessage(false);
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private void ShowMessage(bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            lblMessage.Text = "Action Successfull.";
            lblMessage.Visible = true;
        }
        private void ShowMessage(string message,bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }

        private void ClearPasswordField( bool enable )
        {
            txtPassword.Enabled = enable;
            txtConfirmPassword.Enabled = enable;
            rfvPassword.Enabled = enable;
            //revPassword.Enabled = enable;
            rfvConfirmPassword.Enabled = enable;
            rfvPasswordValidator.Enabled = enable;
            cvConfirmPassword.Enabled = enable;
            btnChangePassword.Visible = !enable;
            btnCancelChangePassword.Visible = enable;
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            ClearPasswordField(true);
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            btnShowPassword.Visible = false;
        }

        protected void btnCancelChangePassword_Click(object sender, EventArgs e)
        {
            ClearPasswordField(false);
            btnShowPassword.Visible = true;
            txtPassword.Text = hdnPassword.Value;
            txtConfirmPassword.Text = hdnPassword.Value;
        }

        private void Validator()
        {
            string usertype = ddlUserType.SelectedValue;

             if (usertype == "1") //Admin
            {
                 rfvFirstName.Enabled = true;
                 //rfvLastName.Enabled = true;
                 //rfvTelephone.Enabled = true;
                 //rfvEmail.Enabled = true;

                 //rfvAddress.Enabled = false;
                 //rfvDateOfBirth.Enabled = false;
                 //cvClass.Enabled = false;
                 cvCountry.Enabled = false;
                 cvSchool.Enabled = false;
                 //cvCity.Enabled = false;
                 cvLevel.Enabled = false;
                 //rfvTeacher.Enabled  =false;
                 //rfvParentsName.Enabled = false;

            }
            else if (usertype == "2") //Teacher
            {
                rfvFirstName.Enabled = true;
                 //rfvLastName.Enabled = true;
                 //rfvTelephone.Enabled = true;
                 //rfvEmail.Enabled = true;

                 //rfvAddress.Enabled = true;
                 //rfvDateOfBirth.Enabled = true;
                 cvCountry.Enabled = true;
                 cvSchool.Enabled = true;
                 //cvCity.Enabled = true;
                 cvLevel.Enabled = true;

                //cvClass.Enabled = false;
                 //rfvTeacher.Enabled  =false;
                 //rfvParentsName.Enabled = false;
            }
            else if (usertype == "3") //Student
            {
                   rfvFirstName.Enabled = true;
                 //rfvLastName.Enabled = true;
                 //rfvTelephone.Enabled = true;
                 //rfvTelephone.Enabled = true;
                 //rfvEmail.Enabled = true;

                 //rfvAddress.Enabled = true;
                 //rfvDateOfBirth.Enabled = true;
                 cvCountry.Enabled = true;
                 cvSchool.Enabled = true;
                 //cvCity.Enabled = true;
                 cvLevel.Enabled = true;

                 //cvClass.Enabled = true;
                 //rfvTeacher.Enabled  =true;
                 //rfvParentsName.Enabled = true;
            }
        }

        protected void ddlUserType_SelectedIndexChanged(object sender, EventArgs e)
        {
            Validator();
        }

        protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ChangeOtherInfo();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
            
        }

        //private void ChangeSchoolCode()
        //{
        //    SchoolContract school = new SchoolServiceClient().GetByID(Convert.ToInt64(ddlSchool.SelectedValue));
        //    if (school != null)
        //        lblSchoolCode.Text = "@" + school.SchoolCode;
        //    else
        //        lblSchoolCode.Text = string.Empty;
        //}

        private void ChangeOtherInfo()
        {
            try
            {
                SchoolServiceClient client = new SchoolServiceClient();
                if (ddlSchool.SelectedValue == "0")
                {
                    ddlLevel.SelectedValue = "0";
                    return;
                }

                SchoolContract sc = client.GetByID(Convert.ToInt64(ddlSchool.SelectedValue));
                if (sc != null && sc.SchoolID > 0)
                {
                    ddlLevel.SelectedValue = sc.LevelID.ToString();
                    ddlCountry.SelectedValue = sc.CountryID.ToString();
                    ddlLearningLanguage.SelectedValue = sc.LearningLanguage;
                    ddlNativeLanguage.SelectedValue = sc.NativeLanguage;
                }

                

            }
            catch (Exception ex)
            {
                
                throw ex;
            }
           
        }

        protected void btnGoToReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UserListReport?auto=1");
        }

        private void HideNotImportantFields()
        {
            lblMiddleName.Visible = false;
            txtMiddleName.Visible = false;
            lblLastName.Visible = false;
            txtLastName.Visible = false;
            lblAddress.Visible = false;
            txtAddress.Visible = false;
            lblDateOfBirth.Visible = false;
            txtDateOfBirth.Visible = false;
            lblTelephone.Visible = false;
            txtTelephone.Visible = false;
            lblFax.Visible = false;
            txtFax.Visible = false;
            //lblEmail.Visible = false;
            //txtEmail.Visible = false;
            lblCountry.Visible = false;
            ddlCountry.Visible = false;
            lblCity.Visible = false;
            ddlCity.Visible = false;
            lblSchool.Visible = false;
            ddlSchool.Visible = false;
            lblLevel.Visible = false;
            ddlLevel.Visible = false;
            ddlGrade.Visible = false;
            lblTeachersName.Visible = false;
            txtTeachersName.Visible = false;
            //lblParentsName.Visible = false;
            //txtParentsName.Visible = false;
            chkAfterSchool.Visible = false;
            //chkActivate.Visible = false;

            lblTCRead.Visible = chkTCRead.Visible  = false;
            lblAllowTalk.Visible = chkAllowTalk.Visible = false;
            lblRobot.Visible = chkRobot.Visible = false;
            lblSoundAndMail.Visible = chkSoundAndMail.Visible = false;

        }

        protected void btnShowPassword_Click(object sender, EventArgs e)
        {
            EncryptDecrypt();
            //upDetail.Update();
        }

        private void EncryptDecrypt() {
            Security sec = new Security();

            if (btnShowPassword.Attributes["data-text"].Length == 0)
            {
                btnShowPassword.Attributes.Add("data-text", "encrypt");
                string password = sec.Decrypt(txtPassword.Text, ConfigurationManager.AppSettings.Get("Salt"));
                txtPassword.Text = password;
                txtConfirmPassword.Text = password;
                btnChangePassword.Visible = false;
                btnShowPassword.Text = "Encrypt Password";
            }
            else
            {
                btnShowPassword.Attributes.Add("data-text", "");
                string password = sec.Encrypt(txtPassword.Text, ConfigurationManager.AppSettings.Get("Salt"));
                txtPassword.Text = password;
                txtConfirmPassword.Text = password;
                btnChangePassword.Visible = true;
                btnShowPassword.Text = "Decrypt Password";
            }
        }
    }
}