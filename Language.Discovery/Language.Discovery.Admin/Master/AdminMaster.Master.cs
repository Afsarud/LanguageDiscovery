using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin.Master
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {

        //protected override void OnPreRender(EventArgs e)
        //{
        //    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(SessionManager.Instance.UserProfile.NativeLanguage);

        //    base.OnPreRender(e);
        //}
        override protected void OnInit(EventArgs e)
        {
            
            base.OnInit(e);

            if (Context.Session != null)
            {
                //Tested and the IsNewSession is more advanced then simply checking if 
                // a cookie is present, it does take into account a session timeout, because 
                // I tested a timeout and it did show as a new session
                if (Session.IsNewSession)
                {
                    // If it says it is a new session, but an existing cookie exists, then it must 
                    // have timed out (can't use the cookie collection because even on first 
                    // request it already contains the cookie (request and response
                    // seem to share the collection)
                    string szCookieHeader = Request.Headers["Cookie"];
                    if ((null != szCookieHeader) && (szCookieHeader.IndexOf("ASP.NET_SessionId") >= 0))
                    {
                        Response.Redirect("~/Timeout");
                    }
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.Instance.UserProfile.ShouldChangePassword)
            {
                Response.Redirect("~/ChangePassword");
            }
            lblName.Text = SessionManager.Instance.UserProfile.FirstName;
            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                lifilter.Visible = false;
                liNotice.Visible = false;
                liSuggestion.Visible = false;
                linkMessagePoll.Visible = false;
                liMailMonitoring.Visible = SessionManager.Instance.SchoolProfile.MailCheck;
                liwordpalette.Visible = false;
                liPaletteMaintenance.Visible = false;
                licategory.Visible = false;
                licategoryupload.Visible = false;
                liwordpaletteupload.Visible = false;
                liStatisticsReport.Visible = false;
                lipaletteexport.Visible = false;
                liTalkMonitor.Visible = SessionManager.Instance.UserProfile.AllowTalk;
                liFileUploader.Visible = false;
                liSchedulerViewer.Visible = false;
                liScheduleSettings.Visible = false;
                liImageUploader.Visible = false;
                liTalkScheduleReport.Visible = false;

                //linkWordPalette.Visible = false;
                //liwordpalette.Visible = false;
                //linkPhraseCategoryMaintenance.Visible = false;
                //licategory.Visible = false;
                //linkCategoryUpload.Visible = false;
                //linkWordUpload.Visible = false;
                if (!SessionManager.Instance.SchoolProfile.SchoolPallete)
                {
                    liwordpalette.Visible = false;
                    //linkWordPalette.Visible = false;
                    liPaletteMaintenance.Visible = false;
                    //linkPhraseCategoryMaintenance.Visible = false;
                    licategory.Visible = false;
                    licategoryupload.Visible = false;
                }
                hdnIsDefaultSchool.Value = SessionManager.Instance.SchoolProfile.IsSchoolDemo ? "1" : "0";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DisabledMenuKey", "DisabledMenu();", true);
            }

            Translate();

        }

        private void Translate()
        {
            lblHome.Text = GetTranslation(lblHome.ID);
            lblCategoryBulkUpload.Text = GetTranslation(lblCategoryBulkUpload.ID);
            lblCategoryMaintenance.Text = GetTranslation(lblCategoryMaintenance.ID);
            lblClassMaintenance.Text = GetTranslation(lblClassMaintenance.ID);
            lblFilterMaintenance.Text = GetTranslation(lblFilterMaintenance.ID);
            lblFreeMessageView.Text = GetTranslation(lblFreeMessageView.ID);
            lblLogout.Text = GetTranslation(lblLogout.ID);
            lblMailExchangeReport.Text = GetTranslation(lblMailExchangeReport.ID);
            lblMailStatisticsReport.Text = GetTranslation(lblMailStatisticsReport.ID);
            lblMailMonitoring.Text = GetTranslation(lblMailMonitoring.ID);
            lblMaintenance.Text = GetTranslation(lblMaintenance.ID);
            lblNoticeUpdateTool.Text = GetTranslation(lblNoticeUpdateTool.ID);
            lblStudentProgress.Text = GetTranslation(lblStudentProgress.ID);


            lblPaletteMaintenance.Text = GetTranslation(lblPaletteMaintenance.ID);
            lblReports.Text = GetTranslation(lblReports.ID);
            lblSchoolMaintenance.Text = GetTranslation(lblSchoolMaintenance.ID);
            lblTool.Text = GetTranslation(lblTool.ID);
            lblTopicUpdateTool.Text = GetTranslation(lblTopicUpdateTool.ID);
            lblUserBulkUpload.Text = GetTranslation(lblUserBulkUpload.ID);
            lblUserListReport.Text = GetTranslation(lblUserListReport.ID);
            lblUserLoginReport.Text = GetTranslation(lblUserLoginReport.ID);

            lblUserMaintenance.Text = GetTranslation(lblUserMaintenance.ID);
            lblWordMaintenance.Text = GetTranslation(lblWordMaintenance.ID);
            lblWordPaletteBulkUpload.Text = GetTranslation(lblWordPaletteBulkUpload.ID);
            lblHelp.Text = GetTranslation(lblHelp.ID);
            lblCreateStudent.Text = GetTranslation(lblCreateStudent.ID);
            lblSentMail.Text = GetTranslation(lblSentMail.ID);
            lblPaletteImportExport.Text = GetTranslation(lblPaletteImportExport.ID);
            lblFileUploader.Text = GetTranslation(lblFileUploader.ID);
            lblImageUploader.Text = GetTranslation(lblImageUploader.ID);
            lblMessagePoll.Text = GetTranslation(lblMessagePoll.ID);
            lblTalkMatchingSettings.Text = GetTranslation(lblTalkMatchingSettings.ID);
            lblTalkMonitor.Text = GetTranslation(lblTalkMonitor.ID);
            lblTalkSchedulerTimeSettings.Text = GetTranslation(lblTalkSchedulerTimeSettings.ID);

            hdnHelp.Value = GetTranslation(hdnHelp.ID);
            hdnHelpPresentation.Value = GetTranslation(hdnHelpPresentation.ID);

        }

        private string GetTranslation(string id)
        {
            return GetGlobalResourceObject("Master" + SessionManager.Instance.UserProfile.NativeLanguage.Replace("-", ""), id).ToString();
        }

        protected void linkLogout_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("~/Timeout");
        }
    }
}