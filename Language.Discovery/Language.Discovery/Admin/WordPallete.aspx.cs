using Language.Discovery.Entity;
using Language.Discovery.MiscService;
using Language.Discovery.PaletteService;
using Language.Discovery.UserService;
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
    public partial class WordPallete : System.Web.UI.Page
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
                //string json = pclient.GetPhraseCategory(SessionManager.Instance.UserProfile.NativeLanguage, 0);
                string json = pclient.GetPhraseCategory("en-US", 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                plist.Insert(0,new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[Select Category]" });
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
                ddlLanguage.DataSource = llist;
                ddlLanguage.DataTextField = "LanguageName";
                ddlLanguage.DataValueField = "LanguageCode";
                ddlLanguage.DataBind();


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Clear()
        {
            txtEnglish.Text = string.Empty;
            txtEnglish.Attributes.Remove("data-wordid");
            txtHiragana.Text = string.Empty;
            txtHiragana.Attributes.Remove("data-wordid");
            txtKanji.Text = string.Empty;
            txtKanji.Attributes.Remove("data-wordid");
            txtRomanji.Text = string.Empty;
            txtRomanji.Attributes.Remove("data-wordid");
            txtKeyword.Text = string.Empty;
            WordHeaderID = 0;
        }

        private void BindResult()
        {
            try
            {
                PaletteServiceClient client = new PaletteServiceClient();
                SearchDTO dto = new SearchDTO();
                dto.CategoryID = Convert.ToInt64(ddlSearchlCategory.SelectedValue);
                dto.Word = txtWordName.Text;
                dto.Keyword = txtSearchKeyword.Text;
                dto.PageNumber = grdResult.PageIndex == 0 ? 1 : grdResult.PageIndex + 1;
                dto.LanguageCode = ddlLanguage.SelectedValue.ToString();
                dto.RowsPerPage = 10;

                string json = client.SearchWordAdmin(dto);
                List<WordHeaderContract> list = new JavaScriptSerializer().Deserialize<List<WordHeaderContract>>(json);
                List<WordContract> wlist = new List<WordContract>();
                foreach (WordHeaderContract wc in list)
                {
                    wlist.AddRange(wc.Words);
                }
                grdResult.VirtualItemCount = list[0].VirtualCount;
                grdResult.DataSource = wlist;
                grdResult.DataBind();
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
                PaletteServiceClient client = new PaletteServiceClient();
                WordHeaderContract whc = new WordHeaderContract();

                whc.WordHeaderID = this.WordHeaderID;
                whc.PhraseCategoryID = Convert.ToInt64(ddlCategory.SelectedValue);
                whc.ImageFile = FileHelper.GetFileName(uploadImage.PostedFile);
                whc.ImageBytes = FileHelper.GetBytes(uploadImage.PostedFile);
                whc.CreatedByID = 1;
                whc.Keyword = txtKeyword.Text;

                whc.Words.Add(new WordContract() 
                {
                    WordID = txtEnglish.Attributes["data-wordid"] != null ? Convert.ToInt64(txtEnglish.Attributes["data-wordid"]) : 0,
                    Word = txtEnglish.Text,
                    LanguageCode= "en-US",
                    SoundFile = FileHelper.GetFileName(uploadEnglishSound.PostedFile),
                    SoundBytes = FileHelper.GetBytes(uploadEnglishSound.PostedFile)
                });

                whc.Words.Add(new WordContract()
                {
                    WordID = txtHiragana.Attributes["data-wordid"] != null ? Convert.ToInt64(txtHiragana.Attributes["data-wordid"]) : 0,
                    Word = txtHiragana.Text,
                    LanguageCode = "ja-JP",
                    SoundFile = FileHelper.GetFileName(uploadJapaneseSound.PostedFile),
                    SoundBytes = FileHelper.GetBytes(uploadJapaneseSound.PostedFile)
                });
                whc.Words.Add(new WordContract()
                {
                    WordID = txtKanji.Attributes["data-wordid"] != null ? Convert.ToInt64(txtKanji.Attributes["data-wordid"]) : 0,
                    Word = txtKanji.Text,
                    LanguageCode = "ja-KA",
                });
                whc.Words.Add(new WordContract()
                {
                    WordID = txtRomanji.Attributes["data-wordid"] != null ? Convert.ToInt64(txtRomanji.Attributes["data-wordid"]) : 0,
                    Word = txtRomanji.Text,
                    LanguageCode = "ja-RO",
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
                long wordheaderid = Convert.ToInt64(((HiddenField)gvRow.FindControl("hdnSearchWordHeaderID")).Value);
                WordHeaderID = wordheaderid;

                PaletteServiceClient client = new PaletteServiceClient();

                string json = client.GetWordDetails(wordheaderid);
                WordHeaderContract whc = new JavaScriptSerializer().Deserialize<WordHeaderContract>(json);
                if (whc != null)
                {
                    ddlCategory.SelectedValue = whc.PhraseCategoryID.ToString();
                    var en = whc.Words.Find(x => x.LanguageCode.Equals("en-US"));
                    txtEnglish.Text = en.Word;
                    txtEnglish.Attributes.Add("data-wordid", en.WordID.ToString());

                    var h =whc.Words.Find(x => x.LanguageCode.Equals("ja-JP"));
                    txtHiragana.Text = h.Word;
                    txtHiragana.Attributes.Add("data-wordid", h.WordID.ToString());

                    var k = whc.Words.Find(x => x.LanguageCode.Equals("ja-KA"));
                    if (k != null)
                    {
                        txtKanji.Text = k.Word;
                        txtKanji.Attributes.Add("data-wordid", k.WordID.ToString());
                    }
                    else
                    {
                        txtKanji.Text = string.Empty;
                    }
                    var r = whc.Words.Find(x => x.LanguageCode.Equals("ja-RO"));
                    if (r != null)
                    {
                        txtRomanji.Text = r.Word;
                        txtRomanji.Attributes.Add("data-wordid", r.WordID.ToString());
                    }
                    else
                    {
                        txtRomanji.Text = string.Empty;
                    }

                    txtKeyword.Text = whc.Keyword;
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
    }
}