using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.Reports;
using Language.Discovery.Admin.ReportService;
using Language.Discovery.Entity;
using Language.Discovery.Repository;
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
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class LoginReport : BasePage
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
                ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();
                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSearchSchool.Enabled = false;
                    ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                }

                txtStartDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtEndDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                Generate();

            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            try
            {
                if (chkDetails.Checked)
                    GenerateDetails();
                else
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
            DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
            DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
            ReportRepository rep = new ReportRepository();

            ds = rep.GetUserLoginReportByDate(Convert.ToInt32(ddlSearchSchool.SelectedValue), txtSearchUser.Text, ddlSort.SelectedValue, ddlOrder.SelectedValue, sdate, edate);

            //StringReader reader = new StringReader(json);
            //ds.ReadXml(reader);

            Reports.MailExchangeLogData data = new Reports.MailExchangeLogData();
            if (ds.Tables.Count > 0)
            {

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    MailExchangeLogData.UserLoginReportRow r = data.UserLoginReport.NewUserLoginReportRow();
                    r.UserName = row["UserName"].ToString();
                    r.FirstName = row["FirstName"].ToString();
                    r.LastName = row["LastName"].ToString();
                    if (row.Table.Columns.Contains("LastLogin") &&  row["LastLogin"] != DBNull.Value)
                        r.LastLogin = Convert.ToDateTime(row["LastLogin"]);

                    r.LoginCount = Convert.ToInt32 (row["LoginCount"]);
                    r.SchoolID = Convert.ToInt32(row["SchoolID"]);
                    r.SchoolName = SessionManager.Instance.UserProfile.NativeLanguage !="en-US" ?   row["Name2"].ToString() : row["Name1"].ToString();
                    data.UserLoginReport.Rows.Add(r);
                }
            }

            data.AcceptChanges();


            

            ReportDataSource source = new ReportDataSource();
            source.DataMember = "UserLogin";
            source.Name = "UserLogin";
            source.Value = data.UserLoginReport;

            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/UserLoginReport.rdlc");
            this.LocalizeReport(ReportViewer1.LocalReport);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.DataSources.Add(source);
            ReportViewer1.LocalReport.Refresh();
        }

        private void GenerateDetails()
        {
            DataSet ds = new DataSet();

            ReportRepository rep = new ReportRepository();
            DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
            DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;

            ds = rep.GetUserLoginDetailsReport(Convert.ToInt32(ddlSearchSchool.SelectedValue), txtSearchUser.Text, ddlSort.SelectedValue, ddlOrder.SelectedValue, sdate, edate);


            Reports.MailExchangeLogData data = new Reports.MailExchangeLogData();
            if (ds.Tables.Count > 0)
            {

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    MailExchangeLogData.UserLoginDetailsReportsRow r = data.UserLoginDetailsReports.NewUserLoginDetailsReportsRow();
                    r.UserName = row["UserName"].ToString();
                    r.FirstName = row["FirstName"].ToString();
                    r.LastName = row["LastName"].ToString();
                    if (row.Table.Columns.Contains("LoginDate") && row["LoginDate"] != DBNull.Value)
                        r.LoginDate = Convert.ToDateTime(row["LoginDate"]);

                    r.SchoolName = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? row["Name2"].ToString() : row["Name1"].ToString();
                    data.UserLoginDetailsReports.Rows.Add(r);
                }
            }

            data.AcceptChanges();


            ReportDataSource source = new ReportDataSource();
            source.DataMember = "UserLoginDetails";
            source.Name = "UserLoginDetails";
            source.Value = data.UserLoginDetailsReports;

            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/UserLoginReportDetails.rdlc");
            this.LocalizeReport(ReportViewer1.LocalReport);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.DataSources.Add(source);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}
