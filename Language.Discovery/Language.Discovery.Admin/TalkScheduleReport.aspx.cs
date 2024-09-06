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
    public partial class TalkScheduleReport : BasePage
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

                ddlSearchPartnerSchool.DataSource = slist;
                ddlSearchPartnerSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSearchPartnerSchool.DataValueField = "SchoolID";
                ddlSearchPartnerSchool.DataBind();

                //if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                //{
                //    ddlSearchSchool.Enabled = false;
                //    ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                //}

            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            try
            {
                GenerateDetails();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void GenerateDetails()
        {
            DataSet ds = new DataSet();

            ReportRepository rep = new ReportRepository();
            DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
            DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;

            ds = rep.GetTalkScheduleReport(Convert.ToInt32(ddlSearchSchool.SelectedValue), Convert.ToInt32(ddlSearchPartnerSchool.SelectedValue), ddlSort.SelectedValue, ddlOrder.SelectedValue, sdate, edate);


            Reports.MailExchangeLogData data = new Reports.MailExchangeLogData();
            if (ds.Tables.Count > 0)
            {

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    MailExchangeLogData.TalkScheduleReportRow r = data.TalkScheduleReport.NewTalkScheduleReportRow();
                    r.ScheduleId = Convert.ToInt32(row["ScheduleId"]);
                    r.UserName = row["UserName"].ToString();
                    r.PartnerSchool= row["PartnerSchool"].ToString();
                    r.PartnerName= row["PartnerName"].ToString();
                    r.Schedule = Convert.ToDateTime(row["Schedule"]);
                    r.Comment= row["Comment"].ToString();
                    r.Name1 = row["Name1"].ToString();
                    r.UserColor = row["UserColor"] == DBNull.Value ? "White" : row["UserColor"].ToString();
                    r.PartnerColor= row["PartnerColor"] == DBNull.Value ? "White" :  row["PartnerColor"].ToString();
                    data.TalkScheduleReport.Rows.Add(r);
                }
            }

            data.AcceptChanges();


            ReportDataSource source = new ReportDataSource();
            source.DataMember = "TalkScheduleDataSet";
            source.Name = "TalkScheduleDataSet";
            source.Value = data.TalkScheduleReport;

            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/TalkScheduleReport.rdlc");
            this.LocalizeReport(ReportViewer1.LocalReport);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            ReportViewer1.LocalReport.DataSources.Add(source);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}
