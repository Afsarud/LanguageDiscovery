using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.SchoolService;
using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class MailMonitoring : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateSchool();
                GetMessageToReview();
            }
        }

        private void GetMessageToReview()
        {
            SchoolServiceClient client = new SchoolServiceClient();
            //UserMessageContract[] arr = client.GetUnreadMessageForReview(SessionManager.Instance.UserProfile.SchoolID, 0);
            UserMessageContract[] arr = client.GetUnreadMessageForReview(Convert.ToInt32(ddlSchoolList.SelectedValue), 0);
            List<UserMessageContract> list = null;
            if (arr != null && arr.Length > 0)
            {
                list = arr.ToList();
            }
            if (list != null)
            {
                foreach (UserMessageContract c in list)
                {
                    c.NativeLanguageMessage = c.NativeLanguageMessage.Replace("../Images", "Images");
                    c.LearningLanguageMessage = c.LearningLanguageMessage.Replace("../Images", "Images");
                }
                rptMessage.DataSource = list;
                rptMessage.DataBind();

            }
            else
            {
                rptMessage.DataSource = null;
                rptMessage.DataBind();
            }
            UpdatePanel1.Update();

        }

        //protected void btnSend_Click(object sender, EventArgs e)
        //{

        //}

        protected void rptMessage_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            SchoolServiceClient client = new SchoolServiceClient();

            if (e.CommandName == "feedback")
            {
                bool updated = client.SetMessageAsReviewed(Convert.ToInt64(e.CommandArgument), SessionManager.Instance.UserProfile.UserID, hdnFeedbackMessage.Value, true);
            }
            if (e.CommandName == "send")
            {
                bool updated = client.SetMessageAsReviewed(Convert.ToInt64(e.CommandArgument), SessionManager.Instance.UserProfile.UserID, "",false);
            }
            if (e.CommandName == "reject")
            {
                bool updated = client.SetMessageAsRejected(Convert.ToInt64(e.CommandArgument), SessionManager.Instance.UserProfile.UserID);
            }

            GetMessageToReview();
        }

        private string GetAllSelectedToProcess()
        {
            StringBuilder builder = new StringBuilder();
            builder.AppendLine("<UserMail>");
            foreach (RepeaterItem item in rptMessage.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkrow = (CheckBox)item.FindControl("chkSelectRow");
                    if (chkrow.Checked)
                    {
                        Label id = (Label)item.FindControl("lblUserMailID");
                        builder.AppendLine("<IDS><id>"+ id.Text +"</id></IDS>");
                    }
                }

            }
            builder.AppendLine("</UserMail>");

            return builder.ToString();
        }

        private void PopulateSchool()
        {
            MiscServiceClient mclient = new MiscServiceClient();
            string json = mclient.GetSchoolList("en-US");
            List<SchoolContract> slist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
            slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnAll.Value, Name2 = hdnAll.Value });
            ddlSchoolList.DataSource = slist;
            ddlSchoolList.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
            ddlSchoolList.DataValueField = "SchoolID";
            ddlSchoolList.DataBind();
            ddlSchoolList.SelectedIndex = 1;

            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                ddlSchoolList.Enabled = false;
                ddlSchoolList.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
            }
        }

        protected void ddlSchoolList_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                GetMessageToReview();
                UpdatePanel1.Update();
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnSendAll_Click(object sender, EventArgs e)
        {
            try
            {

                SchoolServiceClient client = new SchoolServiceClient();
                client.SetMessageStatus(GetAllSelectedToProcess(), SessionManager.Instance.UserProfile.UserID, "", true, false);
                GetMessageToReview();
            }
            catch (Exception)
            {

                throw;
            }

        }

        protected void btnFeedbackAll_Click(object sender, EventArgs e)
        {
            try
            {
                SchoolServiceClient client = new SchoolServiceClient();
                client.SetMessageStatus(GetAllSelectedToProcess(), SessionManager.Instance.UserProfile.UserID, hdnFeedbackMessage.Value, true, true);
                GetMessageToReview();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btnRejectAll_Click(object sender, EventArgs e)
        {
            try
            {

                SchoolServiceClient client = new SchoolServiceClient();
                client.SetMessageStatus(GetAllSelectedToProcess(), SessionManager.Instance.UserProfile.UserID, "", false, false);
                GetMessageToReview();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}