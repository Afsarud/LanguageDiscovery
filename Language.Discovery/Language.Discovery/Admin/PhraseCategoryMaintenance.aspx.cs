using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.MiscService;
using Language.Discovery.PaletteService;
using Language.Discovery.AuxilliaryServices;
using Language.Discovery.PhraseService;
using System.Text;

namespace Language.Discovery.Admin
{
    public partial class PhraseCategoryMaintenance : System.Web.UI.Page
    {
        private long PhraseCategoryHeaderID
        {
            get
            {
                long wid = 0;
                if (ViewState["PhraseCategoryHeaderID"] != null)
                {
                    wid = Convert.ToInt64(ViewState["PhraseCategoryHeaderID"]);
                }
                return wid;
            }
            set
            {
                ViewState["PhraseCategoryHeaderID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDownList();
                BindResult();

                //StringBuilder str = new StringBuilder();
                //str.AppendLine("$(function () {");
                //str.AppendLine("$('ol').sortable({ placeholder: \"ui-state-highlight\" });");
                //str.AppendLine("});");
                
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "sort", "Sortable();", true);
           
        }

        private void PopulateDropDownList()
        {
            try
            {
                PaletteServiceClient pclient = new PaletteServiceClient();

                MiscServiceClient mclient = new MiscServiceClient();
                string json = mclient.GetLanguageList();
                List<LanguageContract> llist = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);
                ddlLanguage.DataSource = llist;
                ddlLanguage.DataTextField = "LanguageName";
                ddlLanguage.DataValueField = "LanguageCode";
                ddlLanguage.DataBind();

                json = mclient.GetSchoolList("en-US");
                List<SchoolContract> slist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                slist.Insert (0,new SchoolContract() { SchoolID = 0, Name1= "[Select School]" });
                ddlSearchSchool.DataSource = slist;
                ddlSearchSchool.DataTextField = "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();

                
                //slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = "[Select School]" });
                ddlSchool.DataSource = slist;
                ddlSchool.DataTextField = "Name1";
                ddlSchool.DataValueField = "SchoolID";
                ddlSchool.DataBind();

                json = mclient.GetLevelList("en-US");
                List<LevelContract> lelist = new JavaScriptSerializer().Deserialize<List<LevelContract>>(json);
                lelist.Insert(0, new LevelContract() { LevelID = 0, LevelName = "[Select Level]" });
                ddlSearchLevel.DataSource = lelist;
                ddlSearchLevel.DataTextField = "LevelName";
                ddlSearchLevel.DataValueField = "LevelID";
                ddlSearchLevel.DataBind();

                ddlLevel.DataSource = lelist;
                ddlLevel.DataTextField = "LevelName";
                ddlLevel.DataValueField = "LevelID";
                ddlLevel.DataBind();

           
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        private void PopulateOrder()
        {
            AuxilliaryServicesClient pc = new AuxilliaryServicesClient();
            string json = pc.GetPhraseCategoryListToOrder(ddlLanguage.SelectedValue.ToString(), Convert.ToInt32( ddlSearchLevel.SelectedValue));
            List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
            rptCategory.DataSource = plist;
            rptCategory.DataBind();
            upOrder.Update();

        }

        private void Clear()
        {
            txtEnglish.Text = string.Empty;
            txtEnglish.Attributes.Remove("data-phasecategoryid");
            txtHiragana.Text = string.Empty;
            txtHiragana.Attributes.Remove("data-phasecategoryid");
            txtKanji.Text = string.Empty;
            txtKanji.Attributes.Remove("data-phasecategoryid");
            txtRomanji.Text = string.Empty;
            txtRomanji.Attributes.Remove("data-phasecategoryid");
            PhraseCategoryHeaderID = 0;
        }

        private void BindResult()
        {
            try
            {
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();

                string json = client.SearchPhraseCategory(ddlLanguage.SelectedValue.ToString(), txtSearchCategory.Text, 
                    Convert.ToInt32( ddlSearchLevel.SelectedValue), Convert.ToInt64(ddlSearchSchool.SelectedValue));
                List<PhraseCategoryHeaderContract> list = new JavaScriptSerializer().Deserialize<List<PhraseCategoryHeaderContract>>(json);
                List<PhraseCategoryContract> wlist = new List<PhraseCategoryContract>();
                foreach (PhraseCategoryHeaderContract wc in list)
                {
                    wlist.AddRange(wc.PhraseCategories);
                }
                //grdResult.VirtualItemCount = list[0].VirtualCount;
                grdResult.DataSource = wlist;
                grdResult.DataBind();
                PopulateOrder();
                upSearch.Update();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool Save()
        {
            try
            {
                System.Threading.Thread.Sleep(2000);
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                PhraseCategoryHeaderContract phc = new PhraseCategoryHeaderContract();
                phc.PhraseCategoryHeaderID = this.PhraseCategoryHeaderID;
                phc.CreatedByID = 1;
                phc.LevelID = Convert.ToInt32(ddlLevel.SelectedValue);
                phc.SchoolID = Convert.ToInt32(ddlSchool.SelectedValue);


                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtEnglish.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtEnglish.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtEnglish.Text,
                    LanguageCode = "en-US",
                });
                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtHiragana.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtHiragana.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtHiragana.Text,
                    LanguageCode = "ja-JP",
                });
                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtKanji.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtKanji.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtKanji.Text,
                    LanguageCode = "ja-KA",
                });
                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtRomanji.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtRomanji.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtRomanji.Text,
                    LanguageCode = "ja-RO",
                });


                //string json = new JavaScriptSerializer().Serialize(whc);
                bool updated = false;
                if (PhraseCategoryHeaderID == 0)
                {
                    long pchid = client.AddPhraseCategory(phc);
                    PhraseCategoryHeaderID = pchid;
                }
                else
                {
                    updated = client.UpdatePhraseCategory(phc);
                }

                return true;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindResult();
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
                GridViewRow gvRow = grdResult.SelectedRow;
                long headerid = Convert.ToInt64(((HiddenField)gvRow.FindControl("hdnSearchPhraseCategoryHeaderID")).Value);
                PhraseCategoryHeaderID = headerid;

                PaletteServiceClient client = new PaletteServiceClient();

                string json = client.GetPhraseCategoryDetails(headerid);
                PhraseCategoryHeaderContract phc = new JavaScriptSerializer().Deserialize<PhraseCategoryHeaderContract>(json);
                if (phc != null)
                {
                    ddlLevel.SelectedValue = phc.LevelID.ToString();
                    ddlSchool.SelectedValue = phc.SchoolID.ToString();
                    var en = phc.PhraseCategories.Find(x => x.LanguageCode.Equals("en-US"));
                    txtEnglish.Text = en.PhraseCategoryCode;
                    txtEnglish.Attributes.Add("data-phrasecategoryid", en.PhraseCategoryID.ToString());

                    var h = phc.PhraseCategories.Find(x => x.LanguageCode.Equals("ja-JP"));
                    txtHiragana.Text = h.PhraseCategoryCode;
                    txtHiragana.Attributes.Add("data-phrasecategoryid", h.PhraseCategoryID.ToString());

                    var k = phc.PhraseCategories.Find(x => x.LanguageCode.Equals("ja-KA"));
                    if (k != null)
                    {
                        txtKanji.Text = k.PhraseCategoryCode;
                        txtKanji.Attributes.Add("data-phrasecategoryid", k.PhraseCategoryID.ToString());
                    }
                    else
                    {
                        txtKanji.Text = string.Empty;
                    }
                    var r = phc.PhraseCategories.Find(x => x.LanguageCode.Equals("ja-RO"));
                    if (r != null)
                    {
                        txtRomanji.Text = r.PhraseCategoryCode ;
                        txtRomanji.Attributes.Add("data-phrasecategoryid", r.PhraseCategoryID.ToString());
                    }
                    else
                    {
                        txtRomanji.Text = string.Empty;
                    }

                    
                }
                upDetail.Update();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    //{
        //    //    FileUpload file = (FileUpload)e.Item.FindControl("fileupload");

        //    //    if (file != null)
        //    //    {

        //    //        byte[] buffer = new byte[file.PostedFile.ContentLength];
        //    //        file.PostedFile.InputStream.Read(buffer, 0, file.PostedFile.ContentLength);

        //    //    }
        //    //}
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
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

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (PhraseCategoryHeaderID != 0)
                {
                    AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                    bool deleted = client.DeletePhraseCategory(PhraseCategoryHeaderID);
                    if (deleted)
                    {
                        Clear();
                        BindResult();
                        ShowMessage(false);
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }


        protected void btnUpdateOrder_Click(object sender, EventArgs e)
        {
            try
            {
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                StringBuilder builder = new StringBuilder();
                builder.AppendLine("<List>");

                List<int> ids = hdnNewOrder.Value.ToString().Split(',').Select(int.Parse).ToList();

                int order = 1;
                foreach (int id in ids)
                {
                    //string id = "0";
                    //HiddenField hdn = (HiddenField)item.FindControl("hdnPhraseCategoryHeaderID");
                    //if (hdn != null)
                    //{
                    //    id = hdn.Value;
                    //}

                    builder.AppendFormat("<Categories><PhraseCategoryHeaderID>{0}</PhraseCategoryHeaderID><Ordinal>{1}</Ordinal></Categories>",id,order.ToString());
                    builder.AppendLine("");
                    order++;
                }

                builder.AppendLine("</List>");
                if (client.UpdatePhraseCategoryOrder(builder.ToString()))
                    ShowMessage(false);

                PopulateOrder();
                
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