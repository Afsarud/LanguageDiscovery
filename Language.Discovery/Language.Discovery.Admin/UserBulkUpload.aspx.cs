using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using Language.Discovery.Admin.PhraseCategoryService;
using Language.Discovery.Admin.SchoolService;
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

namespace Language.Discovery.Admin
{
    public partial class UserBulkUpload : BasePage
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

                string sUserName = ((DataRowView)e.Row.DataItem).Row[0].ToString();
                string sFirstName = ((DataRowView)e.Row.DataItem).Row[1].ToString();
                string sLastName = ((DataRowView)e.Row.DataItem).Row[2].ToString();
                string sAddress = ((DataRowView)e.Row.DataItem).Row[3].ToString();
                string sPassword = ((DataRowView)e.Row.DataItem).Row[4].ToString();
                string sClass = ((DataRowView)e.Row.DataItem).Row[5].ToString();
                string sTeacherName = ((DataRowView)e.Row.DataItem).Row[6].ToString();
                string sParentsName = ((DataRowView)e.Row.DataItem).Row[7].ToString();
                string sGender = ((DataRowView)e.Row.DataItem).Row[8].ToString();

                TextBox txtUserName = e.Row.FindControl("txtUserName") as TextBox;
                TextBox txtFirstName = e.Row.FindControl("txtFirstName") as TextBox;
                TextBox txtLastName = e.Row.FindControl("txtLastName") as TextBox;
                TextBox txtAddress = e.Row.FindControl("txtAddress") as TextBox;
                TextBox txtPassword = e.Row.FindControl("txtPassword") as TextBox;
                DropDownList ddlClass = e.Row.FindControl("ddlClass") as DropDownList;
                TextBox txtTeachersName = e.Row.FindControl("txtTeachersName") as TextBox;
                TextBox txtParentsName = e.Row.FindControl("txtParentsName") as TextBox;
                DropDownList ddlGender = e.Row.FindControl("ddlGender") as DropDownList;

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "dateofbirthkey"+txtDateOfBirth.ClientID, "InitializeDate('" + txtDateOfBirth.ClientID + "');", true);

                if (ClassList == null)
                {
                    ClassList = new List<ClassContract>();
                }

                if (ClassList.Find(x => x.ClassID == -1) == null)
                    ClassList.Insert(0, new ClassContract() { ClassID = -1, ClassName = "None" });

                ddlClass.DataSource = ClassList;
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassID";
                ddlClass.DataBind();

                txtUserName.Text = sUserName;
                txtFirstName.Text = sFirstName;
                txtLastName.Text = sLastName;
                txtAddress.Text = sAddress;
                txtPassword.Text = sPassword;
                ListItem item = ddlClass.Items.FindByText(sClass);
                if (item != null)
                {
                    ddlClass.SelectedValue = item.Value;
                }
                txtTeachersName.Text = sTeacherName;
                txtParentsName.Text = sParentsName;
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
            
                        grdResult.DataSource = ds;
                        grdResult.DataBind();
                        DetectDuplicate();
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
                    TextBox txtUserName = row.FindControl("txtUserName") as TextBox;
                    TextBox txtFirstname = row.FindControl("txtFirstName") as TextBox;
                    TextBox txtPassword =  row.FindControl("txtPassword") as TextBox;

                    if (txtUserName.Text.Length == 0)
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
                        TextBox currentText = row.FindControl("txtUserName") as TextBox;
                        TextBox prevText = prow.FindControl("txtUserName") as TextBox;
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
                    lblImport.Text = "Firstname and Password is required";
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

                bool uploaded = false;

                List<UserContract> userlist = new List<UserContract>();
                int index = -1;
                string schoolcode = string.Empty;
                if (ddlSchool.SelectedValue != "0")
                {
                    SchoolContract school = new SchoolServiceClient().GetByID(Convert.ToInt64(ddlSchool.SelectedValue));
                    schoolcode = ddlSeparator.SelectedValue + school.SchoolCode;
                }
                foreach (GridViewRow row in grdResult.Rows)
                {
                    TextBox txtUserName = row.FindControl("txtUserName") as TextBox;
                    TextBox txtFirstName = row.FindControl("txtFirstName") as TextBox;
                    TextBox txtLastName = row.FindControl("txtLastName") as TextBox;
                    TextBox txtAddress = row.FindControl("txtAddress") as TextBox;
                    TextBox txtPassword = row.FindControl("txtPassword") as TextBox;
                    DropDownList ddlClass = row.FindControl("ddlClass") as DropDownList;
                    TextBox txtTeachersName = row.FindControl("txtTeachersName") as TextBox;
                    TextBox txtParentsName = row.FindControl("txtParentsName") as TextBox;
                    DropDownList ddlGender = row.FindControl("ddlGender") as DropDownList;
                    if (txtUserName.Text.Length == 0)
                    {
                        continue;
                    }
                    //string[] date = txtDateOfBirth.Text.Split(new char[] { '/' });
                    //string finaldate;
                    //if (date.Length > 2)
                    //{

                    //    string day = date[0].PadLeft(2, '0');
                    //    string month = date[1].PadLeft(2, '0');

                    //    finaldate = day + "/" + month + "/" + date[2].Substring(0,4);
                    //}

                    string uname = txtUserName.Text;
                    if (uname.Contains(ddlSeparator.SelectedValue))
                        uname = uname.Remove(uname.IndexOf(ddlSeparator.SelectedValue)) + schoolcode;
                    else
                        uname = uname + schoolcode;

                    //if (!uname.ToLower().Contains(schoolcode))
                    //    uname = uname + schoolcode;

                    UserContract user = new UserContract()
                    {
                        UserName = uname,
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        Address = txtAddress.Text,
                        Password = txtPassword.Text,
                        ClassID = Convert.ToInt32(ddlClass.SelectedValue),
                        TeachersName = txtTeachersName.Text,
                        ParentsName = txtParentsName.Text,
                        Gender = ddlGender.SelectedValue
                    };
                    userlist.Add(user);
                }

                UserService.UserClient x = new UserService.UserClient();
                if( userlist.Count > 0 )
                    uploaded  =x.InsertBulkUser(Convert.ToInt32(ddlSchool.SelectedValue), userlist.ToArray());

                return uploaded;

            }
            catch (Exception ex)
            {
                lblImport.Visible = true;
                lblImport.Text = ex.Message;
                throw ex;
            }
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
                    TextBox txtUserName = row.FindControl("txtUserName") as TextBox;
                    TextBox txtFirstName = row.FindControl("txtFirstName") as TextBox;
                    TextBox txtLastName = row.FindControl("txtLastName") as TextBox;
                    TextBox txtAddress = row.FindControl("txtAddress") as TextBox;
                    TextBox txtPassword = row.FindControl("txtPassword") as TextBox;
                    DropDownList ddlClass = row.FindControl("ddlClass") as DropDownList;
                    TextBox txtTeachersName = row.FindControl("txtTeachersName") as TextBox;
                    TextBox txtParentsName = row.FindControl("txtParentsName") as TextBox;
                    DropDownList ddlGender = row.FindControl("ddlGender") as DropDownList;
                    if (txtUserName.Text.Length == 0)
                    {
                        continue;
                    }

                    string uname = txtUserName.Text;
                    if (uname.Contains(ddlSeparator.SelectedValue))
                        uname = uname.Remove(uname.IndexOf(ddlSeparator.SelectedValue)) + schoolcode;
                    else
                        uname = uname + schoolcode;

                    UserContract user = new UserContract()
                    {
                        UserName = uname,
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        Address = txtAddress.Text,
                        Password = txtPassword.Text,
                        ClassID = Convert.ToInt32(ddlClass.SelectedValue),
                        TeachersName = txtTeachersName.Text,
                        ParentsName = txtParentsName.Text,
                        Gender = ddlGender.SelectedValue
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
                        TextBox txtUserName = row.FindControl("txtUserName") as TextBox;
                        
                        if (txtUserName != null && txtUserName.Text.Length > 0)
                        {
                            UserContract user = userlist.Find(y => y.UserName.ToLower().Equals(txtUserName.Text.ToLower()));
                            if (user != null)
                            {
                                txtUserName.ForeColor = System.Drawing.Color.White;
                                txtUserName.BackColor = System.Drawing.Color.Red;//row.BackColor = System.Drawing.Color.Red;
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
            string json;
            json = new AuxilliaryService.AuxilliaryServicesClient().GetClassList(Convert.ToInt32(ddlSchool.SelectedValue));
            ClassList = new JavaScriptSerializer().Deserialize<List<ClassContract>>(json);
            if (ClassList != null)
            {
                if (ClassList.Find(x => x.ClassID == -1) == null)
                    ClassList.Insert(0, new ClassContract() { ClassID = -1, ClassName = "None" });

                foreach (GridViewRow row in grdResult.Rows)
                {
                    TextBox txt = (TextBox)row.FindControl("txtDateOfBirth");
                    DropDownList ddl = (DropDownList)row.FindControl("ddlClass");
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "dateofbirthkey" + txt.ClientID, "InitializeDate('" + txt.ClientID + "');", true);

                    if (ddl != null)
                    {
                        ddl.DataSource = ClassList;
                        ddl.DataTextField = "ClassName";
                        ddl.DataValueField = "ClassID";
                        ddl.DataBind();
                    }
                }
            }
        }

        private DataSet CreateBlankDataset()
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            dt.Columns.Add("UserName", typeof(string));
            dt.Columns.Add("FirstName", typeof(string));
            dt.Columns.Add("LastName", typeof(string));
            dt.Columns.Add("Address", typeof(string));
            //dt.Columns.Add("DateOfBirth", typeof(DateTime));
            dt.Columns.Add("Password", typeof(string));
            dt.Columns.Add("Class", typeof(int));
            dt.Columns.Add("TeachersName", typeof(string));
            dt.Columns.Add("ParentsName", typeof(string));
            dt.Columns.Add("Gender", typeof(string));

            for (int i = 0; i <= 5; i++)
            {
                DataRow row = dt.NewRow();
                dt.Rows.Add(row);
            }

            ds.Tables.Add(dt);
            ds.AcceptChanges();
            return ds;
        }
      
    }
}