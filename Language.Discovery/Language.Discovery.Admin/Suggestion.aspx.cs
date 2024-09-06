using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using Language.Discovery.Entity;
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
    public partial class Suggestion : BasePage
    {
        private long PaletteSuggestionID
        {
            get
            {
                long wid = 0;
                if (ViewState["PaletteSuggestionID"] != null)
                {
                    wid = Convert.ToInt64(ViewState["PaletteSuggestionID"]);
                }
                return wid;
            }
            set
            {
                ViewState["PaletteSuggestionID"] = value;
            }
        }
        private long PaletteID
        {
            get
            {
                long wid = 0;
                if (ViewState["PaletteID"] != null)
                {
                    wid = Convert.ToInt64(ViewState["PaletteID"]);
                }
                return wid;
            }
            set
            {
                ViewState["PaletteID"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDownList();
                BindResult();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "setupdates", "InitializeDate();", true);
        }

        private DataTable CreateSearchTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("PaletteSuggestionID", typeof(Int64)));
            dt.Columns.Add(new DataColumn("PaletteID", typeof(Int64)));
            dt.Columns.Add(new DataColumn("Sentence1", typeof(string)));
            dt.Columns.Add(new DataColumn("Sentence2", typeof(string)));
            dt.Columns.Add(new DataColumn("Sentence3", typeof(string)));
            dt.Columns.Add(new DataColumn("StartDate", typeof(DateTime)));
            dt.Columns.Add(new DataColumn("EndDate", typeof(DateTime)));

            return dt;
        }

        private void BindResult()
        {
            
            PaletteServiceClient client = new PaletteServiceClient();
            string json = client.SearchSuggestion(txtWordKeywordName.Text,
                txtSearchStartDate.Text.Length > 0 ? DateTime.ParseExact(txtSearchStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null,
                txtSearchEndDate.Text.Length > 0 ? DateTime.ParseExact(txtSearchEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null);

            DataSet ds = new DataSet();

            StringReader reader = new StringReader(json);
            ds.ReadXml(reader);

            DataTable newDt = CreateSearchTable();

            if( ds != null && ds.Tables.Count > 0 )
            {
                

                DataTable dt1 = ds.Tables[0].Copy();
                //DataTable dt2 = ds.Tables[1].Copy();
                foreach (DataRow row in dt1.Rows)
                {
                    DataRow newRow = newDt.NewRow();
                    newRow["PaletteSuggestionID"] = row["PaletteSuggestionID"];
                    newRow["PaletteID"] = row["PaletteID"];
                    newRow["Sentence1"] = row["Sentence1"];
                    newRow["Sentence2"] = row["Sentence2"];
                    newRow["StartDate"] = row["StartDate"];
                    newRow["EndDate"] = row["EndDate"];

                    newDt.Rows.Add(newRow);
                }

                //foreach (DataRow row in dt2.Rows)
                //{
                //    DataRow newRow = newDt.NewRow();
                //    newRow["PaletteSuggestionID"] = row["PaletteSuggestionID"];
                //    newRow["PaletteID"] = row["PaletteID"];
                //    newRow["Sentence1"] = row["Sentence1"];
                //    newRow["Sentence2"] = row["Sentence2"];
                //    newRow["StartDate"] = row["StartDate"];
                //    newRow["EndDate"] = row["EndDate"];

                //    newDt.Rows.Add(newRow);
                //}
            }
            newDt.AcceptChanges();
            grdResult.DataSource = newDt;
            grdResult.DataBind();
            upSearch.Update();
        }

        private void BindPalette()
        {
            PaletteServiceClient pclient = new PaletteServiceClient();
            SearchDTO dto = new SearchDTO()
            {
                CategoryID = Convert.ToInt32(ddlSearchCategory.SelectedValue),
                Word = txtSearchWord.Text,
                Keyword = txtSearchWord.Text,
                LevelID = Convert.ToInt64(ddlSearchLevel.SelectedValue),
                SchoolID = Convert.ToInt64(ddlSearchSchool.SelectedValue),
                PageNumber = grdPalette.PageIndex == 0 ? 1 : grdPalette.PageIndex + 1,
                RowsPerPage = 10,
                IsAdmin = true
            };
            int virtualcount = 0;
            //string json = pclient.Search(dto, out virtualcount);
            List<PaletteContract> list = pclient.Search(dto, out virtualcount).ToList();
            //new JavaScriptSerializer().Deserialize<List<PaletteContract>>(json);

            DataTable dt = CreateSearchTable();

            foreach (PaletteContract paleteContract in list)
            {
                DataRow row = dt.NewRow();
                PaletteContract pcontract = new PaletteContract();
                pcontract.PaletteID = paleteContract.PaletteID;
                pcontract.SchoolID = paleteContract.SchoolID;
                pcontract.PhraseCategoryID = paleteContract.PhraseCategoryID;
                pcontract.DefaultLanguageCode = paleteContract.DefaultLanguageCode;

                var pnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("en-US")).OrderBy(x => x.Ordinal).ToList();
                var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("ja-JP")).OrderBy(x => x.Ordinal).ToList();
                //var psubnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();

                string words = string.Empty;
                string words2 = string.Empty;
                foreach (Phrase p in pnativelist)
                {
                    words += p.Word + " ";

                    //var learn = plearninglist.Find(x => x.WordMapID.Equals(p.WordMapID));
                    //if (learn != null)
                    //{
                    //    words2 += learn.Word + " ";
                    //}
                }
                foreach (Phrase p in plearninglist)
                {
                    words2 += p.Word + " ";
                }

                row["PaletteID"] = pcontract.PaletteID;
                row["Sentence1"] = words;
                row["Sentence2"] = words2;
                dt.Rows.Add(row);
            }
            grdPalette.VirtualItemCount = virtualcount;
            grdPalette.DataSource = dt;
            grdPalette.DataBind();
            upPaletteSearch.Update();
        }

        private void PopulateDropDownList()
        {
            try
            {
                PaletteServiceClient pclient = new PaletteServiceClient();

                MiscServiceClient mclient = new MiscServiceClient();
                //string json = mclient.GetLanguageList();
                //List<LanguageContract> llist = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);
                //ddlLanguage.DataSource = llist;
                //ddlLanguage.DataTextField = "LanguageName";
                //ddlLanguage.DataValueField = "LanguageCode";
                //ddlLanguage.DataBind();


                string json = mclient.GetSchoolList("en-US");
                List<SchoolContract> slist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnAll.Value, Name2 = hdnAll.Value });
                ddlSearchSchool.DataSource = slist;
                ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();


                json = mclient.GetLevelList("en-US");
                List<LevelContract> lelist = new JavaScriptSerializer().Deserialize<List<LevelContract>>(json);
                lelist.Insert(0, new LevelContract() { LevelID = 0, LevelName = hdnAll.Value });
                ddlSearchLevel.DataSource = lelist;
                ddlSearchLevel.DataTextField = "LevelName";
                ddlSearchLevel.DataValueField = "LevelID";
                ddlSearchLevel.DataBind();

                json = pclient.GetPhraseCategory("en-US", 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                List<PhraseCategoryContract> plist1 = plist.ToList();
                plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = hdnAll.Value });
                ddlSearchCategory.DataSource = plist;
                ddlSearchCategory.DataTextField = "PhraseCategoryCode";
                ddlSearchCategory.DataValueField = "PhraseCategoryID";
                ddlSearchCategory.DataBind();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            BindResult();
        }

        protected void grdPalette_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdPalette.PageIndex = e.NewPageIndex;
            BindPalette();
        }

        protected void grdPalette_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(grdPalette, "Select$" + e.Row.RowIndex.ToString()));
                e.Row.Style.Add("cursor", "pointer");

                e.Row.Attributes.Add("onmouseover",
               "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='teal';this.originalcolor=this.style.color;this.style.color='white'");

                // when mouse leaves the row, change the bg color to its original value   
                e.Row.Attributes.Add("onmouseout",
                "this.style.backgroundColor=this.originalstyle;this.style.color=this.originalcolor;");
            }
        }

        protected void grdPalette_SelectedIndexChanged(object sender, EventArgs e)
        {
        
        }

        private void AddToTopic()
        {
            Clear();
            //long psid = Convert.ToInt64(grdResult.SelectedDataKey.Values["PaletteSuggestionID"]);
            
            long pid = Convert.ToInt64(grdPalette.SelectedDataKey.Values["PaletteID"]);
            PaletteSuggestionID = 0;
            PaletteID = pid;
            txtPaletteID.Text = pid.ToString();
            Label lbl1 = (Label)grdPalette.SelectedRow.Cells[0].FindControl("lblSentence1");
            Label lbl2 = (Label)grdPalette.SelectedRow.Cells[0].FindControl("lblSentence2");
            string sentence1 = string.Empty;
            string sentence2 = string.Empty;
            string phrase = string.Empty;
            if (lbl1 != null)
            {
                sentence1 = lbl1.Text;
            }
            if (lbl2 != null)
            {
                sentence2 = lbl2.Text;
            }
            if (PaletteID > 0)
            {
                txtFreeText.Text = sentence1;
                txtTranslation.Text = sentence2;
            }

            //txtStartDate.Text = grdResult.SelectedRow.Cells[1].Text;
            //txtEndDate.Text = grdResult.SelectedRow.Cells[2].Text;

            UpdatePanel2.Update();
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
            long psid = Convert.ToInt64( grdResult.SelectedDataKey.Values["PaletteSuggestionID"]);
            long pid = Convert.ToInt64(grdResult.SelectedDataKey.Values["PaletteID"]);
            PaletteSuggestionID = psid;
            PaletteID = pid;
            txtPaletteID.Text = pid.ToString();
            Label lbl1 = (Label)grdResult.SelectedRow.Cells[0].FindControl("lblSentence1");
            Label lbl2 = (Label)grdResult.SelectedRow.Cells[0].FindControl("lblSentence2");
            string sentence1 = string.Empty;
            string sentence2 = string.Empty;
            string phrase = string.Empty;
            if (lbl1 != null)
            {
                sentence1 = lbl1.Text;
            }
            if (lbl2 != null)
            {
                sentence2 = lbl2.Text;
            }
            if (PaletteID > 0)
            {
                txtFreeText.Text = sentence1;
                txtTranslation.Text = sentence2;
            }

            txtStartDate.Text = grdResult.SelectedRow.Cells[1].Text;
            txtEndDate.Text = grdResult.SelectedRow.Cells[2].Text;

            //txtPhrase.Enabled = PaletteID > 0;
            //txtFreeText.Enabled = PaletteID == 0;
            //txtTranslation.Enabled = PaletteID == 0;
           UpdatePanel2.Update();
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
            PaletteServiceClient client = new PaletteServiceClient();
            SuggestionContract c = new SuggestionContract() 
            {
                 PaletteID = this.PaletteID,
                 StartDate = DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture),
                 EndDate = DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture)
            };
            bool updated = false;
            if( PaletteSuggestionID == 0 )
            {
                long id = client.AddSuggestion(c);
                PaletteSuggestionID = id;
            }
            else
            {
                c.PaletteSuggestionID = PaletteSuggestionID;
                updated = client.UpdateSuggestion(c);
                
            }

            return PaletteSuggestionID > 0 || updated;

        }

        private bool Delete()
        {
            PaletteServiceClient client = new PaletteServiceClient();
            bool deleted = client.DeleteSuggestion(PaletteSuggestionID);
            return deleted;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void Clear()
        {
            txtStartDate.Text = string.Empty;
            txtEndDate.Text = string.Empty;
            txtFreeText.Text = string.Empty;
            txtTranslation.Text = string.Empty;
            txtPaletteID.Text  = string.Empty;
            PaletteID = 0;
            PaletteSuggestionID = 0;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (Delete())
                {
                    BindResult();
                    Clear();
                    ShowMessage(false);
                }
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        protected void btnPaletteSearch_Click(object sender, EventArgs e)
        {
            BindPalette();
        }

        protected void grdPalette_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Add")
            {
               
            }
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            GridViewRow row = ((Control)sender).Parent.NamingContainer as GridViewRow;
            grdPalette.SelectedIndex = row.RowIndex;
            AddToTopic();
            BindPalette();
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