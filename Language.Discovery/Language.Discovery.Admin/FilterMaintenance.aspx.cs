using Language.Discovery.Admin.AuxilliaryService;
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
    public partial class FilterMaintenance : BasePage 
    {

        private long FilterID
        {
            get
            {
                long wid = 0;
                if (ViewState["FilterID"] != null)
                {
                    wid = Convert.ToInt64(ViewState["FilterID"]);
                }
                return wid;
            }
            set
            {
                ViewState["FilterID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindResult();
        }

        private void BindResult()
        {
            try
            {
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                
                string json = client.SearchFilter(txtSearchFilter.Text);
                
                List<FilterContract> ilist = new JavaScriptSerializer().Deserialize<List<FilterContract>>(json);

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
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                FilterContract fc = client.GetFilterByID(id);
                if (fc != null)
                {
                    FilterID = fc.FilterID;
                    txtFilter.Text = fc.FilterName;
                }
                upDetail.Update();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            try
            {
                Clear();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        private void Clear()
        {
            txtFilter.Text = string.Empty;
            FilterID = 0;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (Delete())
                {
                    ShowMessage(false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool Delete()
        {
            AuxilliaryServicesClient client = new AuxilliaryServicesClient();
            bool deleted = client.DeleteFilter(FilterID);
            return deleted;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                BindResult();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
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
                }
            }
            catch (Exception ex)
            {
                
                throw ex; 
            }
        }

        private bool Save()
        {
            AuxilliaryServicesClient client = new AuxilliaryServicesClient();
            FilterContract fc = new FilterContract();
            fc.FilterName = txtFilter.Text;
            bool updated = false;
            if (FilterID == 0)
            {
                long id = client.AddFilter(fc);
                FilterID = id;
                updated = true;
            }
            else
            {
                fc.FilterID = FilterID;
                updated = client.UpdateFilter(fc);
            }

            return updated;
            
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