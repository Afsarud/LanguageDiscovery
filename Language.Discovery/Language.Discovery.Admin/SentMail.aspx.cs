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
    public partial class SentMail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateSchool();
                GetMessageToReview();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setupdates", "InitializeDate();", true);
        }

        private void GetMessageToReview()
        {
            SchoolServiceClient client = new SchoolServiceClient();
            MessageSearchDTO dto = new MessageSearchDTO();
            dto.PageNumber = grdResult.PageIndex == 0 ? 1 : grdResult.PageIndex + 1;
            dto.RowsPerPage = 10;
            dto.Sender = txtSender.Text ;
            dto.Recepient = txtRecepient.Text;
            dto.SchoolID = Convert.ToInt64(ddlSchoolList.SelectedValue);
            if (txtStartDateSearch.Text.Length > 0)
                dto.StartDate = DateTime.ParseExact(txtStartDateSearch.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            if (txtEndDateSearch.Text.Length > 0)
                dto.EndDate = DateTime.ParseExact(txtEndDateSearch.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);

                
            
            int virtualcount = 0;
            
            UserMessageContract[] arr = client.GetAllMessages(dto, out virtualcount);
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
                    c.NativeLanguageMessage = Server.HtmlDecode(c.NativeLanguageMessage);
                    c.LearningLanguageMessage = Server.HtmlDecode(c.LearningLanguageMessage);

                    if (c.NativeLanguageMessage.Length > 50 && !c.NativeLanguageMessage.Contains(" "))
                    {
                        string[] temp = c.NativeLanguageMessage.SplitByLength(50).ToArray();
                        string st = "";
                        foreach (string s in temp)
                        {
                            st += s + "<br>";
                        }
                        c.NativeLanguageMessage = st;
                    }

                }
                grdResult.VirtualItemCount = virtualcount;
                grdResult.DataSource = list;
                grdResult.DataBind();

                //rptMessage.DataSource = list;
                //rptMessage.DataBind();
            }
            else
            {
                grdResult.DataSource = null;
                grdResult.DataBind();
            }
            UpdatePanel1.Update();

        }

        protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdResult.PageIndex = e.NewPageIndex;
            GetMessageToReview();
        }

        protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(grdResult, "Select$" + e.Row.RowIndex.ToString()));
            //    e.Row.Style.Add("cursor", "pointer");

            //    e.Row.Attributes.Add("onmouseover",
            //   "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='teal';this.originalcolor=this.style.color;this.style.color='white'");

            //    // when mouse leaves the row, change the bg color to its original value   
            //    e.Row.Attributes.Add("onmouseout",
            //    "this.style.backgroundColor=this.originalstyle;this.style.color=this.originalcolor;");
            //}
        }

        //protected void rptMessage_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{
        //    SchoolServiceClient client = new SchoolServiceClient();

        //    if (e.CommandName == "feedback")
        //    {
        //        bool updated = client.SetMessageAsReviewed(Convert.ToInt64(e.CommandArgument), SessionManager.Instance.UserProfile.UserID, true);
        //    }
        //    if (e.CommandName == "send")
        //    {
        //        bool updated = client.SetMessageAsReviewed(Convert.ToInt64(e.CommandArgument), SessionManager.Instance.UserProfile.UserID, false);
        //    }
        //    if (e.CommandName == "reject")
        //    {
        //        bool updated = client.SetMessageAsRejected(Convert.ToInt64(e.CommandArgument), SessionManager.Instance.UserProfile.UserID);
        //    }

        //    GetMessageToReview();
        //}

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

        //protected void btnSendAll_Click(object sender, EventArgs e)
        //{
        //    try
        //    {

        //        SchoolServiceClient client = new SchoolServiceClient();
        //        foreach (RepeaterItem ri in rptMessage.Items)
        //        {
        //            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
        //            {
        //                Label lbl = ri.FindControl("lblUserMailID") as Label;
        //                if (lbl != null)
        //                {
        //                    client.SetMessageAsReviewed(Convert.ToInt64(lbl.Text), SessionManager.Instance.UserProfile.UserID, false);
                        
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }

        //}

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GetMessageToReview();
            UpdatePanel1.Update();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            
            StringBuilder strids = new StringBuilder();
            
            for (int i = 0; i < grdResult.Rows.Count; i++)
            {
                HiddenField hdn = (HiddenField)grdResult.Rows[i].Cells[0].FindControl("hdnUserMailID");
                CheckBox cBox = (CheckBox)grdResult.Rows[i].Cells[0].FindControl("chkDelete");
                if (cBox != null)
                {
                    if (cBox.Checked)
                        strids.AppendFormat("<IDS><ID>{0}</ID></IDS>", hdn.Value);
                }
            }
            if (strids.Length > 0)
            {
                strids.Insert(0, "<UserMailIDs>");
                strids.AppendLine("</UserMailIDs>");

                UserService.UserClient us = new UserService.UserClient();
                bool deleted = us.DeleteUserMail(strids.ToString());
                if (deleted)
                {
                    GetMessageToReview();
                }
            }


            
        }
    }
}