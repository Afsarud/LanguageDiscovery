using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Admin.AuxilliaryService;
using Language.Discovery.Entity;

namespace Language.Discovery.Admin
{
    public partial class Information : BasePage
    {

        private long InfoID
        {
            get
            {
                long wid = 0;
                if (ViewState["InfoID"] != null)
                {
                    wid = Convert.ToInt64(ViewState["InfoID"]);
                }
                return wid;
            }
            set
            {
                ViewState["InfoID"] = value;
            }
        }
        int PageIndex = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindResult();
        }

        private void BindResult()
        {
            try
            {
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();

                int virtualcount = 0;
                InfoContract[] arr = client.SearchInfo(new SearchInfoDTO()
                {
                    InfoType = ddlSearchType.SelectedIndex == 0 ? null : ddlSearchType.SelectedValue,
                    PageNumber = PageIndex == 0 ? 1 : PageIndex, 
                    RowsPerPage=10, 
                    IsActive =Convert.ToInt16(ddlSearchActive.SelectedValue) == -1 ? (Nullable<bool>) null : Convert.ToBoolean(Convert.ToInt16(ddlSearchActive.SelectedValue))
                }, out virtualcount);
                List<InfoContract> ilist = null;
                if( arr != null )
                {
                    ilist = arr.ToList();
                }

                grdResult.VirtualItemCount = virtualcount;
                grdResult.DataSource = ilist;
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
            PageIndex = e.NewPageIndex + 1;
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
                long id = Convert.ToInt64(grdResult.SelectedDataKey.Value);
                InfoID = id;
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                InfoContract ic = client.GetInfoByID(id);
                if (ic != null)
                {
                    ddlType.SelectedValue = ic.InfoType;
                    txtMessage.Text = ic.InfoMessage;
                    chkActive.Checked = ic.IsActive;
                }
                upDetail.Update();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool Save()
        {
            AuxilliaryServicesClient client = new AuxilliaryServicesClient();
            InfoContract info = new InfoContract();
            info.InfoMessage = txtMessage.Text;
            info.InfoType = ddlType.SelectedValue;
            info.IsActive = chkActive.Checked;
            info.InfoID = InfoID;
            if (fileUpload.HasFile && fileUpload.PostedFile != null)
            {
                info.ImageFile = FileHelper.GetFileName(fileUpload.PostedFile);
                info.ImageBytes = FileHelper.GetBytes(fileUpload.PostedFile);
            }
            bool updated = false;
            if (InfoID == 0)
            {
                long id = client.AddInfo(info);
                InfoID = id;
            }
            else
            {
                updated = client.UpdateInfo(info);
            }

            return InfoID > 0 || updated;

        }

        private void Clear()
        {
            ddlType.SelectedIndex = 0;
            txtMessage.Text = string.Empty;
            chkActive.Checked = false;
            InfoID = 0;
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
                    Clear();
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (InfoID == 0)
                    return;

                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                bool deleted = client.DeleteInfo(InfoID);
                if (deleted)
                {
                    ShowMessage(false);
                    Clear();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ShowMessage(bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            if (!isError)
                lblMessage.Text = "Action Successfull.";
            lblMessage.Visible = true;
        }



    }
}