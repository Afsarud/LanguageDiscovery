using Language.Discovery.Entity;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.SchoolService;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Repository;

namespace Language.Discovery.Admin
{
    public partial class School : BasePage
    {

        private int SchoolID
        {
            get
            {
                int sid = 0;

                if (ViewState["SchoolID"] != null)
                {
                    sid = Convert.ToInt32(ViewState["SchoolID"]);
                }

                return sid;
            }
            set
            {
                ViewState["SchoolID"] = value;
            }
        }

        private List<LanguageContract> LanguageList
        {
            get
            {
                List<LanguageContract> languageList = null;
                if (ViewState["LanguageList"] != null)
                {
                    languageList = (List<LanguageContract>)ViewState["LanguageList"];
                }
                return languageList;
            }
            set
            {
                ViewState["LanguageList"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDownList();
                BindResult();
                SetupTime();
            }
            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                txtSchoolCode.Enabled = false;
                txtEnglishName.Enabled = false;
                txtJapaneseName.Enabled = false;
                txtLicense.Enabled = false;
                //btnSave.Enabled = false;
                btnDelete.Enabled = false;
                btnClear.Enabled = false;
                chkSchoolPalette.Enabled = false;
                ddlCountry.Enabled = false;
                ddlSchoolType.Enabled = false;
                txtAddress.Enabled = false;
                txtTelephone.Enabled = false;
                txtUrl.Enabled = false;
                txtEmail.Enabled = false;
                txtPreparedBy.Enabled = false;
                ddlStartTime.Enabled = false;
                ddlEndTime.Enabled = false;
                ddlLevel.Enabled = false;
                chkAfterSchool.Enabled = false;
                ckbSchoolKey.Enabled = false;
                chkAllowSameCountry.Enabled = false;
                chkEnableParentInfo.Enabled = false;
            }


        }

        private void SetupTime()
        {
            for (int i = 0; i <= 24; i++)
            {
                string timetext = i.ToString();//.PadLeft(2,'0') + ":" + ((i % 2 == 0) ? "00" : "30");
                ddlStartTime.Items.Add(new ListItem(timetext, timetext));
                ddlEndTime.Items.Add(new ListItem(timetext, timetext));
            }
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

                json = mclient.GetLevelList("");
                List<LevelContract> levellist = new JavaScriptSerializer().Deserialize<List<LevelContract>>(json);
                if (levellist == null)
                {
                    levellist = new List<LevelContract>();
                }
                levellist.Insert(0, new LevelContract() { LevelID = 0, LevelName = hdnSelectLevel.Value});
                ddlLevel.DataSource = levellist;
                ddlLevel.DataTextField = "LevelName";
                ddlLevel.DataValueField = "LevelID";
                ddlLevel.DataBind();


                //json = mclient.GetSchoolList("");
                //List<SchoolContract> schoollist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                List<SchoolContract> schoollist = new MiscRepository().GetSchoolList("", true);
                schoollist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnSelectSchool.Value, Name2 = hdnSelectSchool.Value });
                ddlSearchSchool.DataSource = schoollist;
                ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();

                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSearchSchool.Enabled = false;
                    ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                }

                //MiscServiceClient mclient = new MiscServiceClient();
                json = mclient.GetLanguageList();
                List<LanguageContract> llist = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);
                ddlLanguage.DataSource = llist;
                ddlLanguage.DataTextField = "LanguageName";
                ddlLanguage.DataValueField = "LanguageCode";
                ddlLanguage.DataBind();


                //List<LanguageContract> llist = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);
                ddlNativeLanguage.DataSource = llist;
                ddlNativeLanguage.DataTextField = "LanguageName";
                ddlNativeLanguage.DataValueField = "LanguageCode";
                ddlNativeLanguage.DataBind();

                ddlLearningLanguage.DataSource = llist;
                ddlLearningLanguage.DataTextField = "LanguageName";
                ddlLearningLanguage.DataValueField = "LanguageCode";
                ddlLearningLanguage.DataBind();

                LanguageList = llist; 


                SchoolTypeContract[] stypes= new SchoolServiceClient().GetSchoolTypeList();
                List<SchoolTypeContract> stypelist = stypes.ToList();
                if (stypelist == null)
                {
                    stypelist = new List<SchoolTypeContract>();
                }
                stypelist.Insert(0, new SchoolTypeContract() { SchoolTypeID = 0, SchoolTypeName= "", IsDemo=false });
                ddlSchoolType.DataSource = stypelist;
                ddlSchoolType.DataTextField = "SchoolTypeName";
                ddlSchoolType.DataValueField = "SchoolTypeID";
                ddlSchoolType.DataBind();

                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Clear()
        {
            SchoolID = 0;
            txtSchoolCode.Text = string.Empty;
            txtEnglishName.Text = string.Empty;
            txtJapaneseName.Text = string.Empty;
            ddlCountry.SelectedValue = "0";
            ddlLevel.SelectedValue = "0";
            txtAddress.Text = string.Empty;
            txtTelephone.Text = string.Empty;
            txtUrl.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPreparedBy.Text = string.Empty;
            //txtPassword.Text = string.Empty;
            txtLicense.Text = string.Empty;
            ddlStartTime.SelectedIndex = 0;
            ddlEndTime.SelectedIndex = 0;
            //txtStartTime.Text = string.Empty;
            //txtEndTime.Text = string.Empty;
            chkSchoolPalette.Checked = false;
            chkAfterSchool.Checked = false;
            ckbMailCheck.Checked = false;
            ckbShowPhraseOrder.Checked = false;
            ckbShowNativeLanguage.Checked = false;
            ckbSchoolKey.Checked = false;
            ddlSchoolType.SelectedIndex = 0;
            chkAllowSameCountry.Checked = false;
            chkSendPasswordToTeacher.Checked = false;
            txtTeachersEmail.Text = string.Empty;
            chkShowRomanji.Checked = false;
            chkEnableFreeMessage.Checked = false;
            chkSoundAndMail.Checked = false;
            chkOrderByLearningLanguage.Checked = false;
            chkAllowTalk.Checked = false;
            chkEnableParentInfo.Checked= false;

        }

        private void BindResult()
        {
            try
            {
                SchoolServiceClient client = new SchoolServiceClient();
                SearchSchoolDTO dto = new SearchSchoolDTO();
                if (txtSearchSchoolCode.Text != string.Empty)
                {
                    dto.SchoolCode = txtSearchSchoolCode.Text;
                }
                if (txtSearchEnglishName.Text != string.Empty)
                {
                    dto.Name1 = txtSearchEnglishName.Text;
                }
                if (txtSearchJapaneseName.Text != string.Empty)
                {
                    dto.Name2 = txtSearchJapaneseName.Text;
                }
                if (ddlSearchCountry.SelectedValue != string.Empty)
                {
                    dto.CountryID = Convert.ToInt32(ddlSearchCountry.SelectedValue);
                }
                dto.SchoolID = Convert.ToInt32(ddlSearchSchool.SelectedValue);
                dto.PageNumber = grdResult.PageIndex == 0 ? 1 : grdResult.PageIndex + 1;
                dto.RowsPerPage = 10;

                int virtualcount = 0;
                string json = client.SearchSchool(dto, out virtualcount);
                List<SchoolContract> list = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
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
                SchoolServiceClient client = new SchoolServiceClient();
                SchoolContract sc = new SchoolContract();

                sc.SchoolCode = txtSchoolCode.Text;
                sc.Name1 = txtEnglishName.Text;
                sc.Name2 = txtJapaneseName.Text;
                if (ddlCountry.SelectedValue != string.Empty)
                {
                    sc.CountryID = Convert.ToInt32(ddlCountry.SelectedValue);
                }
                if (ddlLevel.SelectedValue != string.Empty)
                {
                    sc.LevelID = Convert.ToInt32(ddlLevel.SelectedValue);
                }
                sc.Address = txtAddress.Text;
                sc.Telephone = txtTelephone.Text;
                sc.Url = txtUrl.Text;
                sc.Email = txtEmail.Text;
                sc.PreparedBy = txtPreparedBy.Text;
                //sc.Password = txtPassword.Text;
                if (txtLicense.Text != string.Empty)
                {
                    sc.License = Convert.ToInt32(txtLicense.Text);
                }
                sc.StartTime = Convert.ToInt32( ddlStartTime.SelectedValue);
                sc.EndTime = Convert.ToInt32(ddlEndTime.SelectedValue);
                //if (txtStartTime.Text != string.Empty)
                //{
                //    sc.StartTime = Convert.ToInt16(txtStartTime.Text);
                //}
                //if (txtEndTime.Text != string.Empty)
                //{
                //    sc.EndTime = Convert.ToInt16(txtEndTime.Text);
                //}
                sc.SchoolPallete = chkSchoolPalette.Checked;
                sc.AfterSchool = chkAfterSchool.Checked;
                sc.MailCheck = ckbMailCheck.Checked;
                sc.ShowPhraseOrder = ckbShowPhraseOrder.Checked;
                sc.ShowNativeLanguage = ckbShowNativeLanguage.Checked;
                sc.SchoolKey = ckbSchoolKey.Checked;
                sc.DefaultLanguageOrder = ddlLanguage.SelectedValue;
                sc.ShowSubLanguage2 = chkShowSubLanguage2.Checked;
                sc.SchoolTypeID = Convert.ToInt32(ddlSchoolType.SelectedValue);
                sc.AllowSameCountry = chkAllowSameCountry.Checked;
                sc.NativeLanguage = ddlNativeLanguage.SelectedValue;
                sc.LearningLanguage = ddlLearningLanguage.SelectedValue;
                sc.SendPasswordToTeacher = chkSendPasswordToTeacher.Checked;
                sc.TeachersEmail = txtTeachersEmail.Text;
                sc.ShowRomanji = chkShowRomanji.Checked;
                sc.EnabledFreeMessage = chkEnableFreeMessage.Checked;
                sc.SoundAndMail = chkSoundAndMail.Checked;
                sc.OrderByLearningLanguageFlag = chkOrderByLearningLanguage.Checked;
                sc.AllowTalk = chkAllowTalk.Checked;
                string totaltime = txtTotalTime.Text.Trim().Length == 0 ? "0" : txtTotalTime.Text;
                sc.TalkTime = Convert.ToInt32(totaltime);
                sc.LinkKey = txtLinkKey.Text;
                sc.EnableParentInfo = chkEnableParentInfo.Checked;
                bool updated = false;

                if (SchoolID == 0)
                {
                    sc.CreatedBy = SessionManager.Instance.UserProfile.UserID;
                    sc.ModifiedBy = SessionManager.Instance.UserProfile.UserID;
                    int schoolid = client.AddSchool(sc);
                    SchoolID = schoolid;
                }
                else
                {
                    sc.ModifiedBy = SessionManager.Instance.UserProfile.UserID;
                    sc.SchoolID = SchoolID;
                    updated = client.UpdateSchool(sc);
                }

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
            try
            {
                GridViewRow gvRow = grdResult.SelectedRow;
                int schoolheaderid = Convert.ToInt32(((HiddenField)gvRow.FindControl("hdnSearchSchoolHeaderID")).Value);
                SchoolID = schoolheaderid;
                SchoolServiceClient client = new SchoolServiceClient();
                SchoolContract sc = client.GetByID(schoolheaderid);

                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher" && SessionManager.Instance.UserProfile.SchoolID == SchoolID)
                {
                    btnSave.Enabled = true;
                    //btnDelete.Enabled = true;
                    //btnClear.Enabled = true;
                }
                else if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher" && SessionManager.Instance.UserProfile.SchoolID != SchoolID)
                {
                    btnSave.Enabled = false;
                    btnDelete.Enabled = false;
                    btnClear.Enabled = false;

                }

                if (sc != null)
                {
                    txtSchoolCode.Text = sc.SchoolCode;
                    txtEnglishName.Text = sc.Name1;
                    txtJapaneseName.Text = sc.Name2;
                    ddlCountry.SelectedValue = sc.CountryID.ToString();
                    ddlLevel.SelectedValue = sc.LevelID.ToString();
                    txtAddress.Text = sc.Address;
                    txtTelephone.Text = sc.Telephone;
                    txtUrl.Text = sc.Url;
                    txtEmail.Text = sc.Email;
                    txtPreparedBy.Text = sc.PreparedBy;
                    //txtPassword.Text = sc.Password;
                    txtLicense.Text = sc.License.ToString();
                    ddlStartTime.SelectedValue = sc.StartTime.ToString();
                    ddlEndTime.SelectedValue = sc.EndTime.ToString();
                    chkSchoolPalette.Checked = sc.SchoolPallete;
                    chkAfterSchool.Checked = sc.AfterSchool;
                    ckbMailCheck.Checked = sc.MailCheck;
                    ckbShowPhraseOrder.Checked = sc.ShowPhraseOrder;
                    ckbShowNativeLanguage.Checked = sc.ShowNativeLanguage;
                    ckbSchoolKey.Checked = sc.SchoolKey;
                    lblStudentCount.Text = sc.StudentCount.ToString();
                    ddlLanguage.SelectedValue = string.IsNullOrEmpty(sc.DefaultLanguageOrder) ? "en-US" : sc.DefaultLanguageOrder;
                    chkShowSubLanguage2.Checked = sc.ShowSubLanguage2;
                    ddlSchoolType.SelectedValue = sc.SchoolTypeID.ToString();
                    chkAllowSameCountry.Checked = sc.AllowSameCountry;
                    ddlNativeLanguage.SelectedValue = sc.NativeLanguage;
                    ddlLearningLanguage.SelectedValue = sc.LearningLanguage;
                    chkSendPasswordToTeacher.Checked = sc.SendPasswordToTeacher;
                    txtTeachersEmail.Text = sc.TeachersEmail;
                    chkEnableFreeMessage.Checked = sc.EnabledFreeMessage;
                    chkShowRomanji.Checked = sc.ShowRomanji;
                    chkSoundAndMail.Checked = sc.SoundAndMail;
                    chkOrderByLearningLanguage.Checked = sc.OrderByLearningLanguageFlag;
                    chkAllowTalk.Checked = sc.AllowTalk;
                    txtTotalTime.Text = sc.TalkTime.ToString();
                    txtLinkKey.Text = sc.LinkKey;
                    chkEnableParentInfo.Checked = sc.EnableParentInfo;
                }

                upDetail.Update();
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

                if (Save())
                {
                    ShowMessage(false);
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
                if (SchoolID != 0)
                {
                    SchoolServiceClient client = new SchoolServiceClient();
                    bool deleted = client.DeleteSchool(SchoolID);
                    if (deleted)
                    {
                        Clear();
                        BindResult();
                        ShowMessage(false);
                    }
                    else
                    {
                        ShowMessage("Cannot delete the entry, it might be used in User.", true);
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

        private void ShowMessage(string message, bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            //if (!isError)
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            var lang = LanguageList.Find(x => x.CountryID.Equals(Convert.ToInt32(ddlCountry.SelectedValue)));
            if (lang != null)
            {
                ddlNativeLanguage.SelectedValue = lang.LanguageCode; 
            }

        }
    }
}