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
    public partial class MailExhangeStatistics : BasePage
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
            DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
            DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>) null;
            string json = client.GetMailExhangeStatistics(Convert.ToInt32( ddlSearchSchool.SelectedValue), txtSearchUser.Text,txtSearchRecipient.Text, sdate, edate);

            StringReader reader = new StringReader(json);
            ds.ReadXml(reader);

            Reports.MailExchangeLogData data = new Reports.MailExchangeLogData();
            if (ds.Tables.Count > 0)
            {

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    MailExchangeLogData.StatisticsRow r = data.Statistics.NewStatisticsRow();
                    r.Read = Convert.ToInt32(row["Read"]);
                    r.Sent = Convert.ToInt32(row["Sent"]);
                    r.Sender = row["Sender"].ToString();
                    r.Recepient = row["Recepient"].ToString();
                    r.ReadPercentage = row["ReadPercentage"].ToString() == "100" || row["ReadPercentage"].ToString() == "0" ? row["ReadPercentage"].ToString() + "%" : Convert.ToDecimal(row["ReadPercentage"]).ToString("F") + "%";
                    r.Reply = Convert.ToInt32(row["Reply"]);
                    r.ReplyPercentage = row["ReplyPercentage"].ToString() == "100" || row["ReplyPercentage"].ToString() == "0" ? row["ReplyPercentage"].ToString() + "%" : Convert.ToDecimal(row["ReplyPercentage"]).ToString("F") + "%";
                    data.Statistics.Rows.Add(r);
                }
            }

            data.AcceptChanges();


            //Reports.MailExchangeLogData.LogRow row = data.Log.NewLogRow();
            //row["Message"] = "今日 雨が降っ <img style=\"width: 24px; height: 24px;\" alt=\"\" src=\"http://localhost:56756/Admin/images/sticker/1.png\"> それ です <img style=\"width: 50px; height: 50px;\" alt=\"\" src=\"../Images/sticker/6.png\"> <br/>";
            //data.Log.Rows.Add(row);

            ReportDataSource source = new ReportDataSource();
            source.DataMember = "Statistics";
            source.Name = "Statistics";
            source.Value = data.Statistics;

            ReportParameter rp1 = new ReportParameter("StartDate", txtStartDate.Text);
            ReportParameter rp2 = new ReportParameter("EndDate", txtEndDate.Text);

            ReportViewer1.LocalReport.EnableExternalImages = true;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Reports/MailExhangeStatisticsReport.rdlc");
            this.LocalizeReport(ReportViewer1.LocalReport);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            if (sdate != null && edate != null)
                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp1,rp2 });

            ReportViewer1.LocalReport.DataSources.Add(source);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}