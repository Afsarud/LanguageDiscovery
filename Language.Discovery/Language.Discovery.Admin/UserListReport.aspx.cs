using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.Reports;
using Language.Discovery.Admin.ReportService;
using Language.Discovery.Entity;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class UserListReport : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MiscServiceClient mclient = new MiscServiceClient();
                string json = mclient.GetSchoolList("en-US");
                List<SchoolContract> slist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnAll.Value, Name2 = hdnAll.Value });
                ddlSearchSchool.DataSource = slist;
                ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1"; ;
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();
                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSearchSchool.Enabled = false;
                    ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                }

                if (!string.IsNullOrEmpty(Request.QueryString["auto"]))
                {
                    Generate();
                }
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            try
            {
                Generate();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void Generate()
        {
            DataSet ds = new DataSet();

            ReportServiceClient client = new ReportServiceClient();
            //DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
            //DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
            string json = client.GetUserListReport(Convert.ToInt32(ddlSearchSchool.SelectedValue), txtSearchUser.Text, ddlSort.SelectedValue, ddlOrder.SelectedValue);

            StringReader reader = new StringReader(json);
            ds.ReadXml(reader);

            Reports.MailExchangeLogData data = new Reports.MailExchangeLogData();
            if (ds.Tables.Count > 0)
            {

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    MailExchangeLogData.UserListReportRow r = data.UserListReport.NewUserListReportRow();
                    r.UserName = row["UserName"].ToString();
                    r.FirstName = row["FirstName"].ToString();
                    r.LastName = row["LastName"].ToString();
                    r.CountryName = row["CountryName"].ToString();
                    r.CityName = row["CityName"].ToString();
                    r.LevelName = row["LevelName"].ToString();
                    r.ClassName = row["ClassName"].ToString();
                    r.SchoolCode = row["SchoolCode"].ToString();
                    if (row["DateOfBirth"] != DBNull.Value)
                        r.DateOfBirth = Convert.ToDateTime( row["DateOfBirth"]);
                    r.Gender = row["Gender"].ToString();
                    if (row.Table.Columns.Contains("LastLogin") && row["LastLogin"] != DBNull.Value)
                        r.LastLogin = Convert.ToDateTime(row["LastLogin"]);

                    r.SchoolID = Convert.ToInt32(row["SchoolID"]);
                    r.Name1 = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? row["Name2"].ToString() : row["Name1"].ToString();
                    r.CreateDate = Convert.ToDateTime(row["CreateDate"]);
                    r.IsOnline = Convert.ToBoolean( row["IsOnline"] );
                    r.IsActive = Convert.ToBoolean(row["IsActive"]);
                    r.Password= row["Password"].ToString();
                    r.AfterSchool = row["AfterSchool"] == DBNull.Value ? false : Convert.ToBoolean(row["AfterSchool"]);
                    r.AutoActivatedAfterSchool = Convert.ToBoolean(row["AutoActivatedAfterSchool"]);
                    data.UserListReport.Rows.Add(r);
                }
            }

            data.AcceptChanges();

            ReportDataSource source = new ReportDataSource();
            source.DataMember = "UserList";
            source.Name = "UserList";
            source.Value = data.UserListReport;

            ReportViewer1.LocalReport.EnableExternalImages = true;
            if( SessionManager.Instance.UserProfile.UserTypeName == "Teacher" )
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/UserListReport2.rdlc");
            else
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/UserListReport.rdlc");
            this.LocalizeReport(ReportViewer1.LocalReport);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.DataSources.Add(source);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}
