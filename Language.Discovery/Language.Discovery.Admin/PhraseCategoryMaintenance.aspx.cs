using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using Language.Discovery.Admin.AuxilliaryService;
//using Language.Discovery.Admin.PhraseService;
using System.Text;
using Language.Discovery.Admin.PhraseCategoryService;

namespace Language.Discovery.Admin
{
    public partial class PhraseCategoryMaintenance : BasePage
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

        private List<LanguageContract> LanguageList
        {
            get
            {
                List<LanguageContract> languageList = null;
                if (ViewState["LanguageList"] != null)
                {
                    languageList = (List<LanguageContract>)ViewState["LanguageList"];
                }
                return languageList;
            }
            set
            {
                ViewState["LanguageList"] = value;
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
                ddlSearchLanguage.DataSource = llist;
                ddlSearchLanguage.DataTextField = "LanguageName";
                ddlSearchLanguage.DataValueField = "LanguageCode";
                ddlSearchLanguage.DataBind();

                LanguageList = llist;

                var l = llist.Find(x => x.LanguageCode == "en-US");
                if (l != null)
                    llist.Remove(l);

                ddlLanguage.DataSource = llist;
                ddlLanguage.DataTextField = "LanguageName";
                ddlLanguage.DataValueField = "LanguageCode";
                ddlLanguage.DataBind();

                Translate();


                json = mclient.GetSchoolList("en-US");
                List<SchoolContract> slist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnSelectSchool.Value, Name2 = hdnSelectSchool.Value });
                ddlSearchSchool.DataSource = slist;
                ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();

                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSearchSchool.Enabled = false;
                    ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                    ddlSchool.Enabled = false;
                    ddlSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                }


                
                //slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = "[Select School]" });
                ddlSchool.DataSource = slist;
                ddlSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSchool.DataValueField = "SchoolID";
                ddlSchool.DataBind();

                json = mclient.GetLevelList("en-US");
                List<LevelContract> lelist = new JavaScriptSerializer().Deserialize<List<LevelContract>>(json);
                lelist.Insert(0, new LevelContract() { LevelID = 0, LevelName =hdnAll.Value });
                ddlSearchLevel.DataSource = lelist;
                ddlSearchLevel.DataTextField = "LevelName";
                ddlSearchLevel.DataValueField = "LevelID";
                ddlSearchLevel.DataBind();

                ddlLevel.DataSource = lelist;
                ddlLevel.DataTextField = "LevelName";
                ddlLevel.DataValueField = "LevelID";
                ddlLevel.DataBind();

                PhraseCategoryServiceClient catclient = new PhraseCategoryServiceClient();
                TopCategoryContract[] tcats = catclient.GetTopCategoryList("en-US");

                if (tcats != null)
                {
                    List<TopCategoryContract> lcats = tcats.ToList();
                    lcats.Insert(0, new TopCategoryContract() { TopCategoryHeaderID = 0, TopCategoryName = "Select Top Category" });
                    ddlTopCategory.DataSource = lcats;
                    ddlTopCategory.DataTextField = "TopCategoryName";
                    ddlTopCategory.DataValueField = "TopCategoryHeaderID";
                    ddlTopCategory.DataBind();

                    lcats.RemoveAt(0);
                    lcats.Insert(0, new TopCategoryContract() { TopCategoryHeaderID = 0, TopCategoryName = "All" });
                    ddlSearchTopCategory.DataSource = lcats;
                    ddlSearchTopCategory.DataTextField = "TopCategoryName";
                    ddlSearchTopCategory.DataValueField = "TopCategoryHeaderID";
                    ddlSearchTopCategory.DataBind();


                }
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        private void PopulateOrder()
        {
            AuxilliaryServicesClient pc = new AuxilliaryServicesClient();
            string json = pc.GetPhraseCategoryListToOrder(ddlSearchLanguage.SelectedValue.ToString(), Convert.ToInt32( ddlSearchLevel.SelectedValue));
            List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
            rptCategory.DataSource = plist;
            rptCategory.DataBind();
            upOrder.Update();

        }

        private void Clear()
        {
            txtEnglish.Text = string.Empty;
            txtEnglish.Attributes.Remove("data-phrasecategoryid");
            txtHiragana.Text = string.Empty;
            txtHiragana.Attributes.Remove("data-phrasecategoryid");
            txtKanji.Text = string.Empty;
            txtKanji.Attributes.Remove("data-phrasecategoryid");
            txtRomanji.Text = string.Empty;
            txtRomanji.Attributes.Remove("data-phrasecategoryid");
            ddlSchool.SelectedIndex = 0;
            ddlLevel.SelectedIndex = 0;
            PhraseCategoryHeaderID = 0;
            chkIsDemo.Checked = false;
            chkHideInScheduler.Checked = false;
            chkDisplayInUI.Checked = false;
            hdnPhraseCategoryHeaderID.Value = "0";
            txtFolderName.Text = string.Empty;
            GridViewRow gvRow = grdResult.SelectedRow;
            if (gvRow != null)
                ((HiddenField)gvRow.FindControl("hdnSearchPhraseCategoryHeaderID")).Value = "0";
        }

        private void ClearSecondaryLanguage()
        {
            //txtEnglish.Text = string.Empty;
            //txtEnglish.Attributes.Remove("data-phasecategoryid");
            txtHiragana.Text = string.Empty;
            txtHiragana.Attributes.Remove("data-phrasecategoryid");
            txtKanji.Text = string.Empty;
            txtKanji.Attributes.Remove("data-phrasecategoryid");
            txtRomanji.Text = string.Empty;
            txtRomanji.Attributes.Remove("data-phrasecategoryid");
            //ddlSchool.SelectedIndex = 0;
            ddlLevel.SelectedIndex = 0;
            //PhraseCategoryHeaderID = 0;
            chkIsDemo.Checked = false;
            chkDisplayInUI.Checked = false;
            chkHideInScheduler.Checked = false;
            hdnPhraseCategoryHeaderID.Value = "";
            txtFolderName.Text = string.Empty;
            GridViewRow gvRow = grdResult.SelectedRow;
            if (gvRow != null)
                ((HiddenField)gvRow.FindControl("hdnSearchPhraseCategoryHeaderID")).Value = "0";
        }

        private void BindResult()
        {
            try
            {
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();

                string json = client.SearchPhraseCategory(ddlSearchLanguage.SelectedValue.ToString(), txtSearchCategory.Text, 
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
                AuxilliaryServicesClient client = new AuxilliaryServicesClient();
                PhraseCategoryHeaderContract phc = new PhraseCategoryHeaderContract();
                phc.PhraseCategoryHeaderID = this.PhraseCategoryHeaderID;
                phc.CreatedByID = SessionManager.Instance.UserProfile.UserID;
                phc.LevelID = Convert.ToInt32(ddlLevel.SelectedValue);
                phc.SchoolID = Convert.ToInt32(ddlSchool.SelectedValue);
                phc.FolderName = txtFolderName.Text;
                phc.IsDemo = chkIsDemo.Checked;
                phc.DisplayInUI = chkDisplayInUI.Checked;
                phc.HideInScheduler = chkHideInScheduler.Checked;
                phc.TopCategoryHeaderID = Convert.ToInt32(ddlTopCategory.SelectedValue);
                var lang = LanguageList.Find(x => x.LanguageCode.Equals(ddlLanguage.SelectedValue));

                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtEnglish.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtEnglish.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtEnglish.Text,
                    LanguageCode = "en-US"
                });
                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtHiragana.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtHiragana.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtHiragana.Text,
                    LanguageCode = lang.LanguageCode,
                });
                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtKanji.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtKanji.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtKanji.Text,
                    LanguageCode = lang.SubLanguageCode2,
                });
                phc.PhraseCategories.Add(new PhraseCategoryContract()
                {
                    PhraseCategoryID = txtRomanji.Attributes["data-phrasecategoryid"] != null ? Convert.ToInt64(txtRomanji.Attributes["data-phrasecategoryid"]) : 0,
                    PhraseCategoryCode = txtRomanji.Text,
                    LanguageCode = lang.SubLanguageCode,
                });


                //string json = new JavaScriptSerializer().Serialize(whc);
                bool updated = false;
                if (PhraseCategoryHeaderID == 0)
                {
                    long pchid = client.AddPhraseCategory(phc);
                    PhraseCategoryHeaderID = pchid;
                    hdnPhraseCategoryHeaderID.Value = pchid.ToString();
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
                LoadDetails();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadDetails()
        {
            GridViewRow gvRow = grdResult.SelectedRow;
            long headerid  = 0;
            if( gvRow != null )
                headerid = Convert.ToInt64(((HiddenField)gvRow.FindControl("hdnSearchPhraseCategoryHeaderID")).Value);
                
            long catid = Convert.ToInt64(grdResult.SelectedDataKey.Value); //Convert.ToInt64(((HiddenField)gvRow.FindControl("hdnSearchPhraseCategoryHeaderID")).Value);
                
                
            if ( headerid > 0 )
                PhraseCategoryHeaderID = headerid;

                PaletteServiceClient client = new PaletteServiceClient();

                string json = client.GetPhraseCategoryDetails(catid);
                PhraseCategoryHeaderContract phc = new JavaScriptSerializer().Deserialize<PhraseCategoryHeaderContract>(json);
                var lang = LanguageList.Find(x => x.LanguageCode.Equals(ddlLanguage.SelectedValue));
                if (phc != null)
                {
                    ddlLevel.SelectedValue = phc.LevelID.ToString();
                    ddlSchool.SelectedValue = phc.SchoolID.ToString();
                    var en = phc.PhraseCategories.Find(x => x.LanguageCode.Equals("en-US"));
                    txtEnglish.Text = en.PhraseCategoryCode;
                    txtEnglish.Attributes.Add("data-phrasecategoryid", en.PhraseCategoryID.ToString());

                var h = phc.PhraseCategories.Find(x => x.LanguageCode.Equals(lang.LanguageCode));
                if (h != null)
                {
                    txtHiragana.Text = h.PhraseCategoryCode;
                    txtHiragana.Attributes.Add("data-phrasecategoryid", h.PhraseCategoryID.ToString());
                }
                else
                    txtHiragana.Text = string.Empty;

                var k = phc.PhraseCategories.Find(x => x.LanguageCode.Equals(lang.SubLanguageCode2));
                if (k != null)
                {
                    txtKanji.Text = k.PhraseCategoryCode;
                    txtKanji.Attributes.Add("data-phrasecategoryid", k.PhraseCategoryID.ToString());
                }
                else
                {
                    txtKanji.Text = string.Empty;
                }
                var r = phc.PhraseCategories.Find(x => x.LanguageCode.Equals(lang.SubLanguageCode));
                if (r != null)
                {
                    txtRomanji.Text = r.PhraseCategoryCode;
                    txtRomanji.Attributes.Add("data-phrasecategoryid", r.PhraseCategoryID.ToString());
                }
                else
                {
                    txtRomanji.Text = string.Empty;
                }

                    txtFolderName.Text = phc.FolderName;
                    chkIsDemo.Checked = phc.IsDemo;
                    chkDisplayInUI.Checked = phc.DisplayInUI;
                    chkHideInScheduler.Checked = phc.HideInScheduler;
                    ddlTopCategory.SelectedValue = phc.TopCategoryHeaderID.ToString();

                    
                }
                upDetail.Update();

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
                    else
                    {
                        ShowMessage("Cannot delete the entry, it might be used in Words or Palette ",true);
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
        private void ShowMessage(string message,bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            //if (!isError)
                lblMessage.Text = message;
            lblMessage.Visible = true;
        }

        protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Translate();                
                ClearSecondaryLanguage();
                if (PhraseCategoryHeaderID > 0)
                    LoadDetails();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Translate()
        {
            string displaylanguage = System.Threading.Thread.CurrentThread.CurrentUICulture.Parent.EnglishName;
            if (System.Threading.Thread.CurrentThread.CurrentUICulture.Parent.EnglishName.Contains("Chinese"))
            {
                displaylanguage = "Chinese";
            }
            //displaylanguage = System.Threading.Thread.CurrentThread.CurrentUICulture.Parent.EnglishName;
            lblHiragana.Text = GetTranslation(displaylanguage + ddlLanguage.SelectedItem.Text + "Label");
            lblKanji.Text = GetTranslation(displaylanguage + ddlLanguage.SelectedItem.Text + "KanjiLabel");
            lblRomanji.Text = GetTranslation(displaylanguage + ddlLanguage.SelectedItem.Text + "RomanjiLabel");

        }

    }
}