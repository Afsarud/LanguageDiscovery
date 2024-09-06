using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class Default : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher" && !SessionManager.Instance.SchoolProfile.MailCheck)
            {
                btnMailMonitoringContainer.Visible = false;
                btnTalkMatchingSettingsContainer.Visible = false;
                btnTalkMonitorContainer.Visible = false;
            }
            bool shouldRedirectToCreateStudent = Request.QueryString["sc"] != null;
            if (SessionManager.Instance.SchoolProfile != null && ( shouldRedirectToCreateStudent && SessionManager.Instance.UserProfile.UserTypeName == "Teacher"))
            {
                Response.Redirect("~/CreateStudent");
            }
        }

        protected void btnCreateStudent_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateStudent.aspx");
        }

        protected void btnViewExhchangeMail_Click(object sender, EventArgs e)
        {
            Response.Redirect("MailExhangeLog.aspx");
        }

        protected void btnMailMonitoring_Click(object sender, EventArgs e)
        {
            Response.Redirect("MailMonitoring.aspx");
        }

        protected void btnEditSchool_Click(object sender, EventArgs e)
        {
            Response.Redirect("School.aspx");
        }

        protected void btnViewStudentLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginReport.aspx");
        }

        protected void btnViewStudentList_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserListReport.aspx");
        }

        protected void btnTalkMatchingSettings_Click(object sender, EventArgs e)
        {
            Response.Redirect("SchedulerViewer.aspx");
        }

        protected void btnTalkMonitor_Click(object sender, EventArgs e)
        {
            Response.Redirect("TalkMonitor.aspx");
        }

        protected void btnUserSettings_Click(object sender, EventArgs e)
        {
            Response.Redirect("User.aspx");
        }
    }
}