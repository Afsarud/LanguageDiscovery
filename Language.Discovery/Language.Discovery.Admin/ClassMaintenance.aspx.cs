using Language.Discovery.Admin.AuxilliaryService;
using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using Language.Discovery.Admin.MiscService;

namespace Language.Discovery.Admin
{
    public partial class ClassMaintenance : BasePage
    {

        private int ClassID
        {
            get
            {
                int wid = 0;
                if (ViewState["ClassID"] != null)
                {
                    wid = Convert.ToInt32(ViewState["ClassID"]);
                }
                return wid;
            }
            set
            {
                ViewState["ClassID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropdownlist();
                BindResult();
            }
        }

        private void BindResult()
        {
            try
            {
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                
                string json = client.SearchClass(txtSearchClass.Text, Convert.ToInt32(ddlSearchSchool.SelectedValue));
                
                //List<ClassContract> ilist = new JavaScriptSerializer().Deserialize<List<FilterContract>>(json);
                DataSet ds = new DataSet();
                if (json.ToLower() != "<newdataset />")
                {
                    StringReader reader = new StringReader(json);
                    ds.ReadXml(reader);
                }
                if (ds.Tables.Count == 0)
                    ds = null;

                grdResult.DataSource = ds;
                grdResult.DataBind();
                upSearch.Update();

            }
            catch (Exception ex)
            {
                throw ex;
            }
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
                int id = Convert.ToInt32(grdResult.SelectedDataKey.Value);
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                ClassContract cc = client.GetClassByID(id);
                if (cc != null)
                {
                    ClassID = cc.ClassID;
                    txtClass.Text = cc.ClassName;
                    ddlSchool.SelectedValue = cc.SchoolID.ToString();
                }
                upDetail.Update();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            try
            {
                Clear();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        private void Clear()
        {
            txtClass.Text = string.Empty;
            ClassID = 0;

            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                ddlSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
            }
            else
            {
                ddlSchool.SelectedIndex = 0;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (Delete())
                {
                    Clear();
                    ShowMessage(false);
                }
                else
                {
                    ShowMessage("Cannot delete the entry, it might be used in User.", true);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool Delete()
        {
            AuxilliaryServicesClient client = new AuxilliaryServicesClient();
            bool deleted = client.DeleteClass(ClassID);
            return deleted;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                BindResult();
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
                if (!Page.IsValid)
                    return;

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

        private bool Save()
        {
            AuxilliaryServicesClient client = new AuxilliaryServicesClient();
            ClassContract cc = new ClassContract();
            cc.ClassName= txtClass.Text;
            cc.SchoolID = Convert.ToInt32(ddlSchool.SelectedValue);
            bool updated = false;
            if (ClassID == 0)
            {
                int id = client.AddClass(cc);
                ClassID = id;
                updated = true;
            }
            else
            {
                cc.ClassID = ClassID;
                updated = client.UpdateClass(cc);
            }

            return updated;
            
        }
        private void ShowMessage(bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            if (!isError)
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

        private void PopulateDropdownlist()
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

            ddlSearchSchool.DataSource = schoollist;
            ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
            ddlSearchSchool.DataValueField = "SchoolID";
            ddlSearchSchool.DataBind();

            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                ddlSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                ddlSearchSchool.Enabled = false;
                ddlSchool.Enabled = false;
            }
        }
    }
}