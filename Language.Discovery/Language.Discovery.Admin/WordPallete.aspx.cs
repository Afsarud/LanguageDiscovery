using Language.Discovery.Entity;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using Language.Discovery.Admin.UserService;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class WordPallete : BasePage
    {

        private long WordHeaderID
        {
            get
            {
                long wid = 0;
                if (ViewState["WordHeaderID"] != null)
                {
                    wid = Convert.ToInt64(ViewState["WordHeaderID"]);
                }
                return wid;
            }
            set
            {
                ViewState["WordHeaderID"] = value;
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
            }
        }

        private void PopulateDropDownList()
        {
            try
            {
                PaletteServiceClient pclient = new PaletteServiceClient();
                string json = pclient.GetPhraseCategory(SessionManager.Instance.UserProfile.NativeLanguage, 0);
                //string json = pclient.GetPhraseCategory("en-US", 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                plist.Insert(0,new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = hdnAll.Value });
                ddlCategory.DataSource = plist;
                ddlCategory.DataTextField = "PhraseCategoryCode";
                ddlCategory.DataValueField = "PhraseCategoryID";
                ddlCategory.DataBind();

                ddlSearchlCategory.DataSource = plist;
                ddlSearchlCategory.DataTextField = "PhraseCategoryCode";
                ddlSearchlCategory.DataValueField = "PhraseCategoryID";
                ddlSearchlCategory.DataBind();

                MiscServiceClient mclient = new MiscServiceClient();
                json = mclient.GetLanguageList();
                List<LanguageContract> llist = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);
                LanguageList = llist;
                var l = llist.Find(x => x.LanguageCode == "en-US");
                if (l != null)
                    llist.Remove(l);

                ddlLanguage.DataSource = llist;
                ddlLanguage.DataTextField = "LanguageName";
                ddlLanguage.DataValueField = "LanguageCode";
                ddlLanguage.DataBind();

               json = mclient.GetSchoolList("en-US");
                List<SchoolContract> slist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnAll.Value, Name2=hdnAll.Value});
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
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Clear()
        {
            ddlCategory.SelectedIndex = 0;
            txtEnglish.Text = string.Empty;
            txtEnglish.Attributes.Remove("data-wordid");
            txtHiragana.Text = string.Empty;
            txtHiragana.Attributes.Remove("data-wordid");
            txtKanji.Text = string.Empty;
            txtKanji.Attributes.Remove("data-wordid");
            txtRomanji.Text = string.Empty;
            txtRomanji.Attributes.Remove("data-wordid");
            txtKeyword.Text = string.Empty;
            txtEnglishSoundFile.Text = string.Empty;
            txtJapaneseSoundFile.Text = string.Empty;
            txtImageFile.Text = string.Empty;
            txtWordType.Text = string.Empty;
            WordHeaderID = 0;
            txtSequence.Text = "0";
            GridViewRow gvRow = grdResult.SelectedRow;
            if (gvRow != null)
                ((HiddenField)gvRow.FindControl("hdnSearchWordHeaderID")).Value = "0";
        }

        private void ClearSecondLanguage()
        {
            //ddlCategory.SelectedIndex = 0;
            //txtEnglish.Text = string.Empty;
            //txtEnglish.Attributes.Remove("data-wordid");
            txtHiragana.Text = string.Empty;
            txtHiragana.Attributes.Remove("data-wordid");
            txtKanji.Text = string.Empty;
            txtKanji.Attributes.Remove("data-wordid");
            txtRomanji.Text = string.Empty;
            txtRomanji.Attributes.Remove("data-wordid");
            txtKeyword.Text = string.Empty;
            //txtEnglishSoundFile.Text = string.Empty;
            txtJapaneseSoundFile.Text = string.Empty;
            txtImageFile.Text = string.Empty;
            //WordHeaderID = 0;
            GridViewRow gvRow = grdResult.SelectedRow;
            if (gvRow != null)
                ((HiddenField)gvRow.FindControl("hdnSearchWordHeaderID")).Value = "0";

        }
        
        
        private void BindResult()
        {
            try
            {
                PaletteServiceClient client = new PaletteServiceClient();
                SearchDTO dto = new SearchDTO();
                dto.SchoolID = Convert.ToInt32(ddlSearchSchool.SelectedValue);
                dto.CategoryID = Convert.ToInt64(ddlSearchlCategory.SelectedValue);
                dto.Word = txtWordName.Text;
                dto.Keyword = txtSearchKeyword.Text;
                dto.PageNumber = grdResult.PageIndex == 0 ? 1 : grdResult.PageIndex + 1;
                dto.LanguageCode = "en-US";//ddlLanguage.SelectedValue.ToString();
                dto.RowsPerPage = 10;

                string json = client.SearchWordAdmin(dto);
                List<WordHeaderContract> list = new JavaScriptSerializer().Deserialize<List<WordHeaderContract>>(json);
                List<WordContract> wlist = new List<WordContract>();
                foreach (WordHeaderContract wc in list)
                {
                    wlist.AddRange(wc.Words);
                }

                grdResult.VirtualItemCount = list.Count > 0 ? list[0].VirtualCount : 0; ;
                grdResult.DataSource = wlist;
                grdResult.DataBind();
                upSearch.Update();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private DataTable CreateSearchTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("WordHeaderID", typeof(Int64)));
            dt.Columns.Add(new DataColumn("Word", typeof(string)));
            dt.Columns.Add(new DataColumn("Word2", typeof(string)));

            return dt;
        }

        private bool Save()
        {
            try
            {
         

                PaletteServiceClient client = new PaletteServiceClient();
                WordHeaderContract whc = new WordHeaderContract();

                whc.WordHeaderID = this.WordHeaderID;
                whc.PhraseCategoryID = Convert.ToInt64(ddlCategory.SelectedValue);
                whc.ImageFile = txtImageFile.Text.Length > 0 ? txtImageFile.Text : FileHelper.GetFileName(uploadImage.PostedFile);
                whc.ImageBytes = FileHelper.GetBytes(uploadImage.PostedFile);
                whc.CreatedByID = 1;
                whc.Keyword = txtKeyword.Text;
                whc.WordType = txtWordType.Text;
                whc.Sequence = txtSequence.Text.Length == 0 ? 0 : Convert.ToInt32(txtSequence.Text);


                whc.Words.Add(new WordContract() 
                {
                    WordID = txtEnglish.Attributes["data-wordid"] != null ? Convert.ToInt64(txtEnglish.Attributes["data-wordid"]) : 0,
                    Word = txtEnglish.Text,
                    LanguageCode= "en-US",
                    SoundFile = txtEnglishSoundFile.Text.Length > 0 ? txtEnglishSoundFile.Text : FileHelper.GetFileName(uploadEnglishSound.PostedFile),
                    SoundBytes = FileHelper.GetBytes(uploadEnglishSound.PostedFile),
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID
                    
                });

                var lang = LanguageList.Find(x => x.LanguageCode.Equals(ddlLanguage.SelectedValue));

                whc.Words.Add(new WordContract()
                {
                    WordID = txtHiragana.Attributes["data-wordid"] != null ? Convert.ToInt64(txtHiragana.Attributes["data-wordid"]) : 0,
                    Word = txtHiragana.Text,
                    LanguageCode = lang.LanguageCode,
                    SoundFile = txtJapaneseSoundFile.Text.Length > 0 ? txtJapaneseSoundFile.Text : FileHelper.GetFileName(uploadJapaneseSound.PostedFile),
                    SoundBytes = FileHelper.GetBytes(uploadJapaneseSound.PostedFile),
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID
                });
                whc.Words.Add(new WordContract()
                {
                    WordID = txtKanji.Attributes["data-wordid"] != null ? Convert.ToInt64(txtKanji.Attributes["data-wordid"]) : 0,
                    Word = txtKanji.Text,
                    LanguageCode = lang.SubLanguageCode2,
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID
                });
                whc.Words.Add(new WordContract()
                {
                    WordID = txtRomanji.Attributes["data-wordid"] != null ? Convert.ToInt64(txtRomanji.Attributes["data-wordid"]) : 0,
                    Word = txtRomanji.Text,
                    LanguageCode = lang.SubLanguageCode,
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID
                });

                //string json = new JavaScriptSerializer().Serialize(whc);
                bool updated = false;
                if (WordHeaderID == 0)
                {
                    long wordheaderid = client.AddWords(whc);
                    WordHeaderID = wordheaderid;
                }
                else
                {
                    updated = client.UpdateWord(whc);
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
            if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
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
            try
            {

                GridViewRow gvRow = grdResult.SelectedRow;
                long wordheaderid = 0;
                if (gvRow != null)
                    wordheaderid = Convert.ToInt64(((HiddenField)gvRow.FindControl("hdnSearchWordHeaderID")).Value);
                if( wordheaderid > 0 )
                    WordHeaderID = wordheaderid;
            

                PaletteServiceClient client = new PaletteServiceClient();

                string json = client.GetWordDetails(WordHeaderID);
                WordHeaderContract whc = new JavaScriptSerializer().Deserialize<WordHeaderContract>(json);
                if (whc != null)
                {
                    ddlCategory.SelectedValue = whc.PhraseCategoryID.ToString();
                    var en = whc.Words.Find(x => x.LanguageCode.Equals("en-US"));
                    txtEnglish.Text = en.Word;
                    txtEnglish.Attributes.Add("data-wordid", en.WordID.ToString());
                    txtEnglishSoundFile.Text = en.SoundFile;

                    var lang = LanguageList.Find(x => x.LanguageCode.Equals(ddlLanguage.SelectedValue));

                    var h = whc.Words.Find(x => x.LanguageCode.Equals(lang.LanguageCode));
                    if (h != null)
                    {
                        txtHiragana.Text = h.Word;
                        txtHiragana.Attributes.Add("data-wordid", h.WordID.ToString());
                        txtJapaneseSoundFile.Text = h.SoundFile;
                    }
                    else
                        txtHiragana.Text = string.Empty; 

                    var k = whc.Words.Find(x => x.LanguageCode.Equals(lang.SubLanguageCode2));
                    if (k != null)
                    {
                        txtKanji.Text = k.Word;
                        txtKanji.Attributes.Add("data-wordid", k.WordID.ToString());
                    }
                    else
                    {
                        txtKanji.Text = string.Empty;
                    }
                    var r = whc.Words.Find(x => x.LanguageCode.Equals(lang.SubLanguageCode));
                    if (r != null)
                    {
                        txtRomanji.Text = r.Word;
                        txtRomanji.Attributes.Add("data-wordid", r.WordID.ToString());
                    }
                    else
                    {
                        txtRomanji.Text = string.Empty;
                    }

                    txtImageFile.Text = whc.ImageFile;
                    txtKeyword.Text = whc.Keyword;
                    txtWordType.Text = whc.WordType;
                    txtSequence.Text = whc.Sequence.ToString();
                }

                upDetail.Update();
               
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //{
            //    FileUpload file = (FileUpload)e.Item.FindControl("fileupload");
                
            //    if (file != null)
            //    {
                    
            //        byte[] buffer = new byte[file.PostedFile.ContentLength];
            //        file.PostedFile.InputStream.Read(buffer, 0, file.PostedFile.ContentLength);

            //    }
            //}
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

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (WordHeaderID != 0)
                {
                    PaletteServiceClient client = new PaletteServiceClient();
                    bool deleted = client.DeleteWord(WordHeaderID);
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

        private void ShowMessage(bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            lblMessage.Text = "Action Successfull.";
            lblMessage.Visible = true;
        }

        protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Translate();
                ClearSecondLanguage();
                if (WordHeaderID > 0)
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
            lblHiragana.Text = GetTranslation(displaylanguage + ddlLanguage.SelectedItem.Text + "Label");
            lblKanji.Text = GetTranslation(displaylanguage + ddlLanguage.SelectedItem.Text + "KanjiLabel");
            lblRomanji.Text = GetTranslation(displaylanguage + ddlLanguage.SelectedItem.Text + "RomanjiLabel");

        }
    }
}