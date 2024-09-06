using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.SchoolService;
using Language.Discovery.Admin.UserService;
using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class MessagePoll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateSchool();
                GetMessageToReview();
                LoadUsers();
            }
        }
        protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdResult.PageIndex = e.NewPageIndex;
            LoadUsers();
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
        protected void rptMessage_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            GetMessageToReview();
        }
        private void LoadUsers()
        {
            try
            {
                UserService.UserClient client = new UserService.UserClient();
                SearchUserDTO dto = new SearchUserDTO();

                dto.SchoolID = Convert.ToInt32(ddlSearchSchool.SelectedValue);
                dto.PageNumber = grdResult.PageIndex == 0 ? 1 : grdResult.PageIndex + 1;
                dto.RowsPerPage = 15;

                int virtualcount = 0;
                string json = client.SearchUserAdmin(dto, out virtualcount);
                List<UserContract> list = new JavaScriptSerializer().Deserialize<List<UserContract>>(json);
                grdResult.VirtualItemCount = virtualcount;
                grdResult.DataSource = list;
                grdResult.DataBind();
                upSearch.Update();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void SendSelectedMessage()
        {
            List<UserMessageContract> msgList = new List<UserMessageContract>();
            List<long> userids = GetSelectedUserIds();
            foreach (RepeaterItem i in rptMessage.Items)
            {
                CheckBox cb = (CheckBox)i.FindControl("chkSelectMessage");
                if (cb.Checked)
                {
                    Label lblnative = (Label)i.FindControl("lblNativeLanguageMessage");
                    Label lbllearning = (Label)i.FindControl("lblLearningLanguageMessage");
                    HiddenField hdnKeywords = (HiddenField)i.FindControl("hdnKeyword");
                    if (lblnative != null)
                    {
                        
                        foreach (int userid in userids)
                        {
                            UserMessageContract umc = new UserMessageContract();

                            umc.SenderID = Convert.ToInt64(cb.Attributes["data-userid"]);
                            umc.RecepientID = userid;
                            umc.LearningLanguageMessage += Server.HtmlEncode(lbllearning.Text.Replace("Images/", "../Images/"));
                            umc.NativeLanguageMessage += Server.HtmlEncode(lblnative.Text.Replace("Images/", "../Images/"));
                            umc.Keyword = hdnKeywords.Value;
                            umc.SentFromPool = true;

                            msgList.Add(umc);
                        }
                    }
                }
            }

            UserClient client = new UserClient();
            string json = new JavaScriptSerializer().Serialize(msgList);
            long[] ids = client.SaveMessage(json);
            if (ids != null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "xxx", "alert('Message sent to users selected');", true);
            }

        }

        private List<long> GetSelectedUserIds()
        {
            List<long> userids = new List<long>();
            foreach (GridViewRow row in grdResult.Rows)
            {
                CheckBox chk = row.Cells[0].FindControl("chkSelectUser") as CheckBox;
                if (chk != null && chk.Checked)
                {
                    long userid = Convert.ToInt64(chk.Attributes["data-userid"]);
                    userids.Add(userid);
                }
            }

            return userids;
        }
        private void GetMessageToReview()
        {
            SchoolServiceClient client = new SchoolServiceClient();
            //UserMessageContract[] arr = client.GetUnreadMessageForReview(SessionManager.Instance.UserProfile.SchoolID, 0);
            UserMessageContract[] arr = client.GetUnreadMessageForPolling(Convert.ToInt32(ddlSchoolList.SelectedValue), 0);
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

            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                ddlSchoolList.Enabled = false;
                ddlSchoolList.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
            }

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

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                btnSend.Enabled = false;
                SendSelectedMessage();
                btnSend.Enabled = true;

                LoadUsers();
                
            }
            catch (Exception ex)
            {
                btnSend.Enabled = true;
                throw ex;
            }
        }

        protected void ddlSearchSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadUsers();
        }
    }
}