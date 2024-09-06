using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using Language.Discovery.Admin.PhraseCategoryService;
using Language.Discovery.Admin.SchoolService;
using Language.Discovery.Admin.UserService;
using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using SpreadsheetLight;
using System.Reflection;
using System.Net;
using Language.Discovery.Repository;
using System.Configuration;
using System.Text.RegularExpressions;

namespace Language.Discovery.Admin
{
    public partial class CreateStudent : BasePage
    {
        private List<ClassContract> ClassList
        {
            get
            {
                List<ClassContract> list = null;
                if (ViewState["ClassList"] != null)
                    list = (List<ClassContract>)ViewState["ClassList"];
                return list;

            }
            set
            {
                ViewState["ClassList"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                PopulatDropDown();
                grdResult.DataSource = CreateBlankDataset();
                grdResult.DataBind();
                string json;
                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                    json = new AuxilliaryService.AuxilliaryServicesClient().GetClassList(SessionManager.Instance.UserProfile.SchoolID);
                else
                    json = new MiscServiceClient().GetClassList();
                ClassList = new JavaScriptSerializer().Deserialize<List<ClassContract>>(json);
                if(SessionManager.Instance.SchoolProfile != null && (SessionManager.Instance.SchoolProfile.IsSchoolDemo && SessionManager.Instance.UserProfile.UserTypeName == "Teacher"))
                {
                    btnGoToReport.Enabled = false;
                }
                //GetUserList();

            }
        }

        private void PopulatDropDown()
        {
            try
            {
                MiscServiceClient mclient = new MiscServiceClient();
                string json = mclient.GetSchoolList("");
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
                if( SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                    ddlSchool.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                //string userid = ((DataRowView)e.Row.DataItem).Row["UserID"].ToString();
                string sfurigana = ((DataRowView)e.Row.DataItem).Row["Furigana"].ToString();
                string sFirstName = ((DataRowView)e.Row.DataItem).Row["FirstName"].ToString();
                string sLastName = ((DataRowView)e.Row.DataItem).Row["LastName"].ToString();
                string sGender = ((DataRowView)e.Row.DataItem).Row["Gender"].ToString();
                string sClass = ((DataRowView)e.Row.DataItem).Row["ClassName"].ToString();
                string sPassword = ((DataRowView)e.Row.DataItem).Row["Password"].ToString();

                //Label lblUserID = e.Row.FindControl("lblUserID") as Label;
                TextBox txtFurigana = e.Row.FindControl("txtFurigana") as TextBox;
                TextBox txtFirstName = e.Row.FindControl("txtFirstName") as TextBox;
                TextBox txtLastName = e.Row.FindControl("txtLastName") as TextBox;
                TextBox txtPassword = e.Row.FindControl("txtPassword") as TextBox;
                TextBox txtClassName = e.Row.FindControl("txtClassName") as TextBox;
                DropDownList ddlGender = e.Row.FindControl("ddlGender") as DropDownList;

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "dateofbirthkey"+txtDateOfBirth.ClientID, "InitializeDate('" + txtDateOfBirth.ClientID + "');", true);

                if (ClassList == null)
                {
                    ClassList = new List<ClassContract>();
                }

                if (ClassList.Find(x => x.ClassID == -1) == null)
                    ClassList.Insert(0, new ClassContract() { ClassID = -1, ClassName = "None" });


                //lblUserID.Text = userid;
                txtFurigana.Text = sfurigana; 
                txtFirstName.Text = sFirstName;
                txtLastName.Text = sLastName;
                txtPassword.Text = sPassword;
                txtClassName.Text = sClass;
                ListItem item1 = FindByValue(ddlGender, sGender); //ddlGender.Items.FindByValue(sGender);
                if (item1 != null)
                {
                    ddlGender.SelectedValue = item1.Value;
                }

              
            }
        }

        private ListItem FindByValue(DropDownList ddl, string value)
        {
            ListItem litem = null;
            foreach (ListItem item in ddl.Items)
            {
                if (string.Compare(value, item.Value, true) == 0)
                {
                    litem = item;
                    break;
                }
            }

            return litem;
        }
        protected void btnImport_Click(object sender, EventArgs e)
        {
            lblImport.Visible = fuExcelUploader.HasFile;
            lblImport.Text = string.Empty;

            if (fuExcelUploader.HasFile)
            {
                try
                {
                    string sExtension = Path.GetExtension(fuExcelUploader.FileName).ToLower();

                    if (sExtension.Trim() == ".xls" || sExtension.Trim() == ".xlsx")
                    {
                        string sFileName = Server.MapPath("Upload/") + fuExcelUploader.FileName;

                        if (!Directory.Exists(Server.MapPath("Upload/")))
                        {
                            Directory.CreateDirectory(Server.MapPath("Upload/"));
                        }

                        fuExcelUploader.SaveAs(sFileName);
                        lblImport.Text = "File name: " + fuExcelUploader.PostedFile.FileName + "<br>" + fuExcelUploader.PostedFile.ContentLength + " kb<br>" + "<br><b>Uploaded Successfully";

                        DataSet ds = FileHelper.ImportWords(sFileName, sExtension);
            
                        //hfWord1.Value = ds.Tables[0].Columns[0].Caption;
                        //hfWord2.Value = ds.Tables[0].Columns[1].Caption;
                        if (!string.IsNullOrEmpty(txtClass.Text))
                        {
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                row["ClassName"] = txtClass.Text;
                            }
                        }
                        if (!string.IsNullOrEmpty(txtPasswordMain.Text))
                        {
                            foreach (DataRow row in ds.Tables[0].Rows)
                            {
                                row["Password"] = txtPasswordMain.Text;
                            }
                        }
                        grdResult.DataSource = ds;
                        grdResult.DataBind();
                        DetectDuplicate();
                        //btnSave.Enabled = true;
                    }
                    else
                    {
                        lblImport.Text = "WARNING: File is invalid";
                    }
                }
                catch (Exception ex)
                {
                    lblImport.Text = "ERROR: " + ex.Message.ToString();
                }
            }
            else
            {
                lblImport.Text = "You have not specified a file.";
            }
        }

        private bool PassedValidation()
        {
            try
            {
                bool hasPassedValidation = true;
                foreach (GridViewRow row in grdResult.Rows)
                {
                    //TextBox txtUserName = row.FindControl("txtUserName") as TextBox;
                    TextBox txtFirstname = row.FindControl("txtFirstName") as TextBox;
                    TextBox txtPassword =  row.FindControl("txtPassword") as TextBox;

                    //if (txtUserName.Text.Length == 0)
                        //continue;
                    if (string.IsNullOrEmpty(txtFirstname.Text) && string.IsNullOrEmpty(txtPassword.Text))
                        continue;
                    if (txtFirstname.Text.Length == 0)
                    {
                        txtFirstname.ForeColor = System.Drawing.Color.White;
                        txtFirstname.BackColor = System.Drawing.Color.Red;
                        hasPassedValidation = false;
                    }
                    if (txtPassword.Text.Length == 0)
                    {
                        txtPassword.ForeColor = System.Drawing.Color.White;
                        txtPassword.BackColor = System.Drawing.Color.Red;
                        hasPassedValidation = false;
                    }
                    string pattern = @"^(?=.*[A-Z])^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$";
                    bool isMatch = Regex.IsMatch(txtPassword.Text, pattern);
                    if (!isMatch)
                    {
                        txtPassword.ForeColor = System.Drawing.Color.White;
                        txtPassword.BackColor = System.Drawing.Color.Red;
                        hasPassedValidation = false;
                    }

                }
                //for (int i = 0; i < grdResult.Rows.Count; i++)
                //{
                //    for (int j = 0; j < grdResult.Rows.Count; j++)
                //    {
                //        if (i == j)
                //        {
                //            continue;
                //        }
                //        GridViewRow row = grdResult.Rows[i];
                //        GridViewRow prow = grdResult.Rows[j];
                //        TextBox txtFirstname = row.FindControl("txtFirstName") as TextBox;
                //        TextBox txtPassword = prow.FindControl("txtPassword") as TextBox;
                //        if (txtFirstname.Text.Length == 0 )
                //        {
                //            txtFirstname.ForeColor = System.Drawing.Color.White;
                //            txtFirstname.BackColor = System.Drawing.Color.Red;
                //            hasPassedValidation = false;
                //        }
                //        if (txtPassword.Text.Length == 0)
                //        {
                //            txtPassword.ForeColor = System.Drawing.Color.White;
                //            txtPassword.BackColor = System.Drawing.Color.Red;
                //            hasPassedValidation = false;
                //        }

                //    }
                //}
                return hasPassedValidation;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        private bool DetectDuplicate()
        {
            try
            {
                bool hasduplicate = false;
                for( int i=0; i<grdResult.Rows.Count; i++ )
                {
                    for (int j = 0; j < grdResult.Rows.Count; j++)
                    {
                        if (i == j)
                        {
                            continue;
                        }
                        GridViewRow row = grdResult.Rows[i];
                        GridViewRow prow = grdResult.Rows[j];
                        TextBox currentText = row.FindControl("txtFirstName") as TextBox;
                        TextBox prevText = prow.FindControl("txtFirstName") as TextBox;
                        if ((currentText.Text.Length > 0 && prevText.Text.Length > 0) && currentText.Text == prevText.Text)
                        {
                            currentText.ForeColor = System.Drawing.Color.White;
                            currentText.BackColor= System.Drawing.Color.Red;
                            prevText.ForeColor = System.Drawing.Color.White;
                            prevText.BackColor = System.Drawing.Color.Red;
                            hasduplicate = true;
                        }

                    }
                }
                return hasduplicate;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
         
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {

                if (!PassedValidation())
                {
                    lblImport.Visible = true;
                    lblImport.ForeColor = System.Drawing.Color.Red;
                    lblImport.Text = "Firstname,Gender and Password is required";
                    return;
                }
                if (DetectDuplicate())
                {
                    lblImport.Visible = true;
                    lblImport.ForeColor = System.Drawing.Color.Red;
                    lblImport.Text = "Error creating users, Duplicate detected.";
                    return;
                }
                if (CheckForDuplicate())
                {
                    lblImport.Visible = true;
                    lblImport.ForeColor = System.Drawing.Color.Red;
                    lblImport.Text = "Error creating users, some of the user names are already taken.";
                    return;
                }
                if (Save())
                {
                    grdResult.DataSource = CreateBlankDataset();
                    grdResult.DataBind();
                    //GetUserList();
                    lblImport.Visible = true;
                    lblImport.Text = "Action Success";

                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            //Save();
            //try
            //{

            //    List<PhraseCategoryHeaderContract> tHeader = new List<PhraseCategoryHeaderContract>();
            //    List<PhraseCategoryContract> tDetail = new List<PhraseCategoryContract>();

            //    int nCount = grdResult.Rows.Count;

            //    for (int i = 0; i < nCount; i++)
            //    {
            //        PhraseCategoryHeaderContract oHeader = new PhraseCategoryHeaderContract();
            //        oHeader.PhraseCategoryHeaderID = i;
            //        oHeader.CreatedByID = SessionManager.Instance.UserProfile.UserID;
            //        oHeader.ModifiedByID = SessionManager.Instance.UserProfile.UserID;
            //        tHeader.Add(oHeader);

            //        string sWord1 = ((System.Web.UI.WebControls.TextBox)grdResult.Rows[i].FindControl("Word1")).Text;
            //        string sWord2 = ((System.Web.UI.WebControls.TextBox)grdResult.Rows[i].FindControl("Word2")).Text;

            //        PhraseCategoryContract oDetail = new PhraseCategoryContract();
            //        oDetail.GroupID = i;
            //        oDetail.LanguageCode = (hfWord1.Value.Length > 0 && hfWord1.Value == "en") ? "en-US" : "";
            //        oDetail.PhraseCategoryCode = sWord1;
            //        oDetail.PhraseCategoryName = sWord1;
            //        tDetail.Add(oDetail);

            //        oDetail = new PhraseCategoryContract();
            //        oDetail.GroupID = i;
            //        oDetail.LanguageCode = (hfWord2.Value.Length > 0 && hfWord2.Value == "ja") ? "ja-JP" : "";
            //        oDetail.PhraseCategoryCode = sWord2;
            //        oDetail.PhraseCategoryName = sWord2;
            //        tDetail.Add(oDetail);
            //    }

            //    PhraseCategoryServiceClient cl = new PhraseCategoryServiceClient();
            //    cl.BulkInsertPhraseCategory(tHeader.ToArray(), tDetail.ToArray());
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

        }


        private bool Save()
        {
            try
            {
                string json = string.Empty;
                AuxilliaryService.AuxilliaryServicesClient cl = new AuxilliaryService.AuxilliaryServicesClient();
                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                    json = new AuxilliaryService.AuxilliaryServicesClient().GetClassList(SessionManager.Instance.UserProfile.SchoolID);
                else
                    json = new MiscServiceClient().GetClassList();

                ClassList = new JavaScriptSerializer().Deserialize<List<ClassContract>>(json);
                if (ClassList == null)
                    ClassList = new List<ClassContract>();

                
                bool uploaded = false;

                List<UserContract> userlist = new List<UserContract>();
                //int index = -1;
                string schoolcode = string.Empty;
                if (ddlSchool.SelectedValue != "0")
                {
                    SchoolContract school = new SchoolServiceClient().GetByID(Convert.ToInt64(ddlSchool.SelectedValue));
                    schoolcode = ddlSeparator.SelectedValue + school.SchoolCode;
                }
                Security sec = new Security();
                string salt = ConfigurationManager.AppSettings.Get("Salt");
                foreach (GridViewRow row in grdResult.Rows)
                {

                    //Label lblUserID = row.FindControl("lblUserID") as Label;
                    TextBox txtFurigana = row.FindControl("txtFurigana") as TextBox;
                    TextBox txtFirstName = row.FindControl("txtFirstName") as TextBox;
                    TextBox txtLastName = row.FindControl("txtLastName") as TextBox;
                    TextBox txtPassword = row.FindControl("txtPassword") as TextBox;
                    TextBox txtClass = row.FindControl("txtClassName") as TextBox;
                    
                    DropDownList ddlGender = row.FindControl("ddlGender") as DropDownList;

                    if (string.IsNullOrEmpty(txtFirstName.Text) && string.IsNullOrEmpty(txtPassword.Text))
                        continue;

                    string uname = txtFirstName.Text;
                    if (uname.Contains(ddlSeparator.SelectedValue))
                        uname = uname.Remove(uname.IndexOf(ddlSeparator.SelectedValue)) + schoolcode;
                    else
                        uname = uname + schoolcode;

                    //if (!uname.ToLower().Contains(schoolcode))
                    //    uname = uname + schoolcode;

                    int classid = CreateClass(txtClass.Text, Convert.ToInt32(ddlSchool.SelectedValue));
                    UserContract user = new UserContract()
                    {
                        //UserID = string.IsNullOrEmpty(lblUserID.Text) ? 0 : Convert.ToInt32(lblUserID.Text),
                        UserName = uname,
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        Password = sec.Encrypt(txtPassword.Text, salt),
                        ClassID = classid,
                        Gender = ddlGender.SelectedValue,
                        Furigana = txtFurigana.Text 
                    };
                    userlist.Add(user);
                }
                if (userlist.Count == 0)
                    return false;

                UserService.UserClient x = new UserService.UserClient();
                if( userlist.Count > 0 )
                    uploaded  =x.InsertUpdateBulkUser(Convert.ToInt32(ddlSchool.SelectedValue), userlist.ToArray());

                return uploaded;

            }
            catch (Exception ex)
            {
                lblImport.Visible = true;
                lblImport.Text = ex.Message;
                throw ex;
            }
        }

        private int CreateClass(string name, int schoolID)
        {
            int id = 0;
            if (ClassList == null)
                ClassList = new List<ClassContract>();

            ClassContract c = ClassList.Find(x => string.Compare(x.ClassName, name, true) == 0 && x.SchoolID.Equals(schoolID));
            if (c == null)
            {
                AuxilliaryService.AuxilliaryServicesClient cl = new AuxilliaryService.AuxilliaryServicesClient();
                int clasid = cl.AddClass(new ClassContract() { ClassName = name, SchoolID = schoolID });
                if (clasid > 0)
                    ClassList.Add(new ClassContract() { ClassID = id, ClassName = name, SchoolID = schoolID });

                id = clasid;
            }
            else
                id = c.ClassID;

            return id;
        }

        private bool CheckForDuplicate()
        {
            try
            {
                string schoolcode = string.Empty;
                if (ddlSchool.SelectedValue != "0")
                {
                    SchoolContract school = new SchoolServiceClient().GetByID(Convert.ToInt64(ddlSchool.SelectedValue));
                    schoolcode = ddlSeparator.SelectedValue + school.SchoolCode;
                }
                bool hasduplicate = false;

                List<UserContract> userlist = new List<UserContract>();
                int index = -1;
                foreach (GridViewRow row in grdResult.Rows)
                {
                    TextBox txtFurigana = row.FindControl("txtFurigana") as TextBox;
                    TextBox txtFirstName = row.FindControl("txtFirstName") as TextBox;
                    TextBox txtLastName = row.FindControl("txtLastName") as TextBox;
                    TextBox txtPassword = row.FindControl("txtPassword") as TextBox;
                    TextBox txtClass = row.FindControl("txtClassName") as TextBox;
                    DropDownList ddlGender = row.FindControl("ddlGender") as DropDownList;
                    if (txtFirstName.Text.Length == 0)
                    {
                        continue;
                    }

                    string uname = txtFirstName.Text;
                    if (uname.Contains(ddlSeparator.SelectedValue))
                        uname = uname.Remove(uname.IndexOf(ddlSeparator.SelectedValue)) + schoolcode;
                    else
                        uname = uname + schoolcode;

                    int classid = CreateClass(txtClass.Text, Convert.ToInt32(ddlSchool.SelectedValue));
                    UserContract user = new UserContract()
                    {
                        UserName = uname,
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        Password = txtPassword.Text,
                        ClassID = classid,
                        Gender = ddlGender.SelectedValue,
                        Furigana = txtFurigana.Text  
                    };
                    userlist.Add(user);
                }

                UserService.UserClient x = new UserService.UserClient();
                string json = string.Empty;
                if (userlist.Count > 0)
                {
                    json = x.GetDuplicateUsers(userlist.ToArray());
                    userlist = new JavaScriptSerializer().Deserialize<List<UserContract>>(json);
                }
                if (userlist != null && userlist.Count > 0)
                {
                    hasduplicate = true;
                    foreach (GridViewRow row in grdResult.Rows)
                    {
                        TextBox txtFirstName = row.FindControl("txtFirstName") as TextBox;

                        if (txtFirstName != null && txtFirstName.Text.Length > 0)
                        {
                            string uname = txtFirstName.Text;
                            if (uname.Contains(ddlSeparator.SelectedValue))
                                uname = uname.Remove(uname.IndexOf(ddlSeparator.SelectedValue)) + schoolcode;
                            else
                                uname = uname + schoolcode;

                            UserContract user = userlist.Find(y => y.UserName.ToLower().Equals(uname.ToLower()));
                            if (user != null)
                            {
                                txtFirstName.ForeColor = System.Drawing.Color.White;
                                txtFirstName.BackColor = System.Drawing.Color.Red;//row.BackColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
                
                return hasduplicate;

            }
            catch (Exception ex)
            {
                lblImport.Visible = true;
                lblImport.Text = ex.Message;
                throw ex;
            }
        }

        protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string json;
            //json = new AuxilliaryService.AuxilliaryServicesClient().GetClassList(Convert.ToInt32(ddlSchool.SelectedValue));
            //ClassList = new JavaScriptSerializer().Deserialize<List<ClassContract>>(json);
            //if (ClassList != null)
            //{
            //    if (ClassList.Find(x => x.ClassID == -1) == null)
            //        ClassList.Insert(0, new ClassContract() { ClassID = -1, ClassName = "None" });

            //    foreach (GridViewRow row in grdResult.Rows)
            //    {
            //        TextBox txt = (TextBox)row.FindControl("txtDateOfBirth");
            //        DropDownList ddl = (DropDownList)row.FindControl("ddlClass");
            //        //ScriptManager.RegisterStartupScript(this, this.GetType(), "dateofbirthkey" + txt.ClientID, "InitializeDate('" + txt.ClientID + "');", true);

            //        if (ddl != null)
            //        {
            //            ddl.DataSource = ClassList;
            //            ddl.DataTextField = "ClassName";
            //            ddl.DataValueField = "ClassID";
            //            ddl.DataBind();
            //        }
            //    }
            //}
            try
            {
                //GetUserList();
                //btnSave.Enabled = false;

            }
            catch (Exception)
            {
                
                throw;
            }

        }

        private void GetUserList()
        {
            if (ddlSchool.SelectedIndex > 0)
            {
                List<UserContract> userList = new List<UserContract>();
                string json = new UserClient().GetDSUserListBySchool(Convert.ToInt32(ddlSchool.SelectedValue));
                DataSet ds = new DataSet();
                StringReader reader = new StringReader(json);
                ds.ReadXml(reader);
                grdResult.DataSource = ds;
                grdResult.DataBind();
            }
        }

        private DataSet CreateBlankDataset()
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            //dt.Columns.Add("UserID", typeof(long));
            dt.Columns.Add("Furigana", typeof(string));
            dt.Columns.Add("FirstName", typeof(string));
            dt.Columns.Add("LastName", typeof(string));
            dt.Columns.Add("Password", typeof(string));
            dt.Columns.Add("ClassName", typeof(string));
            dt.Columns.Add("Gender", typeof(string));

            for (int i = 0; i <= 20; i++)
            {
                DataRow row = dt.NewRow();
                dt.Rows.Add(row);
            }

            ds.Tables.Add(dt);
            ds.AcceptChanges();
            return ds;
        }

        private DataSet CreateBlankDataset(bool hasblankdata)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            //dt.Columns.Add("UserID", typeof(long));
            dt.Columns.Add("Furigana", typeof(string));
            dt.Columns.Add("FirstName", typeof(string));
            dt.Columns.Add("LastName", typeof(string));
            dt.Columns.Add("Gender", typeof(string));
            dt.Columns.Add("ClassName", typeof(string));
            dt.Columns.Add("Password", typeof(string));
            
            if (hasblankdata)
            {
                for (int i = 0; i <= 10; i++)
                {
                    DataRow row = dt.NewRow();
                    dt.Rows.Add(row);
                }
            }

            ds.Tables.Add(dt);
            ds.AcceptChanges();
            return ds;
        }

        protected void btnUpdateClass_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in grdResult.Rows)
            {
                TextBox txtf = (TextBox)row.Cells[0].FindControl("txtFirstName");
                TextBox txtc = (TextBox)row.Cells[3].FindControl("txtClassName");
                if (string.IsNullOrEmpty(txtf.Text))
                    continue;

                txtc.Text = txtClass.Text;
            }
        }

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in grdResult.Rows)
            {
                TextBox txtf = (TextBox)row.Cells[0].FindControl("txtFirstName");
                TextBox txtp = (TextBox)row.Cells[4].FindControl("txtPassword");
                if (string.IsNullOrEmpty(txtf.Text))
                    continue;

                txtp.Text = txtPasswordMain.Text;
            }

        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            SLDocument sl = new SLDocument();

            DataSet ds = CreateBlankDataset(false);

            foreach (GridViewRow row in grdResult.Rows)
            {
                TextBox txtFurigana = row.FindControl("txtFurigana") as TextBox;
                TextBox txtFirstName = row.FindControl("txtFirstName") as TextBox;
                TextBox txtLastName = row.FindControl("txtLastName") as TextBox;
                TextBox txtPassword = row.FindControl("txtPassword") as TextBox;
                TextBox txtClass = row.FindControl("txtClassName") as TextBox;
                DropDownList ddlGender = row.FindControl("ddlGender") as DropDownList;

                DataRow r = ds.Tables[0].NewRow();
                r["Furigana"] = txtFurigana.Text;
                r["FirstName"] = txtFirstName.Text;
                r["LastName"] = txtLastName.Text;
                r["Gender"] = ddlGender.SelectedItem.Text;
                r["ClassName"] = txtClass.Text;
                r["Password"] = txtPassword.Text;
                ds.Tables[0].Rows.Add(r);
            }
            ds.AcceptChanges();

            sl.ImportDataTable(1, 1, ds.Tables[0], true);
            string filename = Path.Combine(Server.MapPath("~//Upload//") , ddlSchool.SelectedItem.Text + "_StudentList.xlsx");
            sl.SaveAs(filename);

            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "Application/x-msexcel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filename));
            Response.WriteFile(filename);
            Response.Flush();
            File.Delete(filename);

            Response.End();
            
        }

        protected void btnDownloadTemplate_Click(object sender, EventArgs e)
        {
            try
            {
                 SLDocument sl = new SLDocument();

                DataSet ds = CreateBlankDataset(false);

                sl.ImportDataTable(1, 1, ds.Tables[0], true);
                string filename = Path.Combine(Server.MapPath("~//Upload//") , ddlSchool.SelectedItem.Text + "_StudentList.xlsx");
                sl.SaveAs(filename);

                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                Response.ContentType = "Application/x-msexcel";
                Response.AppendHeader("Content-Disposition", "attachment; filename=Template_CreateStudentIDs.xlsx");
                Response.WriteFile(filename);
                Response.Flush();
                File.Delete(filename);

                Response.End();
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            grdResult.DataSource = CreateBlankDataset();
            grdResult.DataBind();
        }

        protected void btnGoToReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UserListReport?auto=1");
        }


    }
}