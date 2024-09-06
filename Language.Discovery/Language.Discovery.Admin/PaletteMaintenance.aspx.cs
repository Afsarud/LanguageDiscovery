using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;

namespace Language.Discovery.Admin
{
    public partial class PaletteMaintenance : BasePage
    {
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

        private string CurrentTranlationLanguage
        {
            get
            {
                string lang = string.Empty;
                if (ViewState["CurrentTranlationLanguage"] != null)
                {
                    lang = Convert.ToString(ViewState["CurrentTranlationLanguage"]);
                }
                return lang;
            }
            set
            {
                ViewState["CurrentTranlationLanguage"] = value;
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

        int PageIndex = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateOrder();
                PopulateDropDownList();
                BindResult();
                InitializePalette();
            }
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
                slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnAll.Value, Name2=hdnAll.Value });
                ddlSearchSchool.DataSource = slist;
                ddlSearchSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();

                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSearchSchool.Enabled = false;
                    ddlSearchSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                }


                json = mclient.GetLevelList("en-US");
                List<LevelContract> lelist = new JavaScriptSerializer().Deserialize<List<LevelContract>>(json);
                lelist.Insert(0, new LevelContract() { LevelID = 0, LevelName = hdnAll.Value });
                ddlSearchLevel.DataSource = lelist;
                ddlSearchLevel.DataTextField = "LevelName";
                ddlSearchLevel.DataValueField = "LevelID";
                ddlSearchLevel.DataBind();

                var le = lelist.Find(x => x.LevelID == 0);
                if (le != null)
                    le.LevelName = hdnAll.Value;
                ddlLevel.DataSource = lelist;
                ddlLevel.DataTextField = "LevelName";
                ddlLevel.DataValueField = "LevelID";
                ddlLevel.DataBind();

                //json = pclient.GetPhraseCategory("en-US", 0);
                //json = pclient.GetPhraseCategory(SessionManager.Instance.UserProfile.NativeLanguage, 0);
                json = pclient.GetPhraseCategory("en-US", 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                List<PhraseCategoryContract> plist1 = plist.ToList();
                plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = hdnAll.Value });
                ddlSearchCategory.DataSource = plist;
                ddlSearchCategory.DataTextField = "PhraseCategoryCode";
                ddlSearchCategory.DataValueField = "PhraseCategoryID";
                ddlSearchCategory.DataBind();

                //plist1.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[Select Category]" });
                ddlPhraseCategory.DataSource = plist;
                ddlPhraseCategory.DataTextField = "PhraseCategoryCode";
                ddlPhraseCategory.DataValueField = "PhraseCategoryID";
                ddlPhraseCategory.DataBind();

                plist.RemoveAt(0);
                plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "Select Category" });
                ddlCopytoPhraseCategory.DataSource = plist;
                ddlCopytoPhraseCategory.DataTextField = "PhraseCategoryCode";
                ddlCopytoPhraseCategory.DataValueField = "PhraseCategoryID";
                ddlCopytoPhraseCategory.DataBind();


                json = mclient.GetLanguageList();
                List<LanguageContract> langList = new JavaScriptSerializer().Deserialize<List<LanguageContract>>(json);
                var l = langList.Find(x => x.LanguageCode == "en-US");
                if (l != null)
                    langList.Remove(l);

                LanguageList = langList;
                ddlSearchLanguage.DataSource = langList;
                ddlSearchLanguage.DataTextField = "LanguageName";
                ddlSearchLanguage.DataValueField = "LanguageCode";
                ddlSearchLanguage.DataBind();

                ddlLanguage.DataSource = langList;
                ddlLanguage.DataTextField = "LanguageName";
                ddlLanguage.DataValueField = "LanguageCode";
                ddlLanguage.DataBind();

                Translate();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private DataTable CreateSearchTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add(new DataColumn("PaletteID", typeof(Int64)));
            dt.Columns.Add(new DataColumn("Sentence", typeof(string)));
            dt.Columns.Add(new DataColumn("Sentence2", typeof(string)));
            dt.Columns.Add(new DataColumn("CreateDate", typeof(string)));
            dt.Columns.Add(new DataColumn("ModifiedDate", typeof(string)));

            return dt;
        }

        private void BindResult()
        {
            PaletteServiceClient pclient = new PaletteServiceClient();
            SearchDTO dto = new SearchDTO()
            {
                CategoryID = Convert.ToInt32(ddlSearchCategory.SelectedValue),
                Word = string.IsNullOrEmpty(txtSearchWord.Text) ? null : txtSearchWord.Text,
                Keyword = string.IsNullOrEmpty(txtSearchKeyword.Text) ? null: txtSearchKeyword.Text,
                LevelID = Convert.ToInt64(ddlSearchLevel.SelectedValue),
                SchoolID = Convert.ToInt64(ddlSearchSchool.SelectedValue),
                PageNumber = PageIndex == 0 ? 1 : PageIndex, 
                RowsPerPage = 10,
                LanguageCode = chkShowWithTranslationOnly.Checked ? ddlSearchLanguage.SelectedValue : null, 
                IsAdmin = true
            };
            CurrentTranlationLanguage = ddlSearchLanguage.SelectedValue; 
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
                var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(CurrentTranlationLanguage)).OrderBy(x => x.Ordinal).ToList();
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
                row["Sentence"] = words;
                row["Sentence2"] = words2;
                if (DateTime.MinValue != paleteContract.CreateDate)
                    row["CreateDate"] = paleteContract.CreateDate;
                if (DateTime.MinValue != paleteContract.ModifiedDate)
                    row["ModifiedDate"] = paleteContract.ModifiedDate;

                dt.Rows.Add(row);
            }
            grdResult.VirtualItemCount = virtualcount;
            grdResult.DataSource = dt;
            grdResult.DataBind();
        }

        private void PopulateOrder()
        {
            for (int i = 1; i <= 10; i++)
            {
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                if (ddlOrderEng != null)
                {
                    for (int j = 1; j <= 10; j++)
                    {
                        ddlOrderEng.Items.Add(new ListItem(j.ToString(), j.ToString()));
                        
                    }
                }
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());
                if (ddlOrderJap != null)
                {
                    for (int j = 1; j <= 10; j++)
                    {
                        ddlOrderJap.Items.Add(new ListItem(j.ToString(), j.ToString()));
                        ddlOrderJap.SelectedValue = j.ToString();
                    }
                }
                ddlOrderEng.SelectedValue = i.ToString();
                ddlOrderJap.SelectedValue = i.ToString();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindResult();
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
            Clear();
            GridViewRow gvRow = grdResult.SelectedRow;
            long headerid = Convert.ToInt64(((HiddenField)gvRow.FindControl("hdnSearchPaletteID")).Value);
            PaletteID = headerid;
            ddlLanguage.SelectedValue = CurrentTranlationLanguage; 
            LoadDetails();
        }

        private void InitializePalette()
        {
            for (int i = 1; i <= 10; i++)
            {
                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                TextBox txtWordType = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtWordType" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());

                txtEng.Attributes.Add("data-phraseid",(-1 * i).ToString());
                txtJap.Attributes.Add("data-phraseid",(-1 * i).ToString());
                txtKanji.Attributes.Add("data-phraseid",(-1 * i).ToString());
                txtRomanji.Attributes.Add("data-phraseid", (-1 * i).ToString());

            }

            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                btnApprove.Visible = false;
            }
        }
        

        private void Clear()
        {
            for (int i = 1; i <= 10; i++)
            {
                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                TextBox txtWordType = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtWordType" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());
                TextBox txtEngSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEngSoundFile" + i.ToString());
                TextBox txtJapSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJapSoundFile" + i.ToString());
                TextBox txtImageFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtImageFile" + i.ToString());

                txtEngSoundFile.Text = string.Empty;
                txtJapSoundFile.Text = string.Empty;
                txtImageFile.Text = string.Empty;

                txtEng.Text = string.Empty;
                txtJap.Text = string.Empty;
                txtKanji.Text = string.Empty;
                txtRomanji.Text = string.Empty;
                txtWordType.Text = string.Empty;
                ddlOrderEng.SelectedIndex = 0;
                ddlOrderJap.SelectedIndex = 0;

                txtEng.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtJap.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtKanji.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtRomanji.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtWordType.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtJap.Text = string.Empty;
                txtKanji.Text = string.Empty;
                txtRomanji.Text = string.Empty;
                txtWordType.Text = string.Empty;
                ddlOrderEng.SelectedValue = i.ToString();
                ddlOrderJap.SelectedValue = i.ToString();

            }

            PaletteID = 0;
            hdnEnglishSentenceID.Value = "-1";
            hdnJapaneseSentenceID.Value = "-2";
            hdnKanjiSentenceID.Value = "-3";
            hdnRomanjiSenteceID.Value = "-4";
            txtEnglishKeyword.Text = string.Empty;
            txtJapaneseKeyword.Text = string.Empty;
            ddlPhraseCategory.SelectedIndex = 0;
            txtEngSentenceSoundFile.Text = string.Empty;
            txtJapSentenceSoundFile.Text = string.Empty;
            upDetail.Update();
        }

        private void ClearSecondLanguage()
        {
            for (int i = 1; i <= 10; i++)
            {
                //TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                //DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());
                //TextBox txtEngSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEngSoundFile" + i.ToString());
                TextBox txtJapSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJapSoundFile" + i.ToString());
                TextBox txtImageFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtImageFile" + i.ToString());

                //txtEngSoundFile.Text = string.Empty;
                txtJapSoundFile.Text = string.Empty;
                txtImageFile.Text = string.Empty;

                //txtEng.Text = string.Empty;
                txtJap.Text = string.Empty;
                txtKanji.Text = string.Empty;
                txtRomanji.Text = string.Empty;
                //ddlOrderEng.SelectedIndex = 0;
                ddlOrderJap.SelectedIndex = 0;

                //txtEng.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtJap.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtKanji.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtRomanji.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtJap.Text = string.Empty;
                txtKanji.Text = string.Empty;
                txtRomanji.Text = string.Empty;
                //ddlOrderEng.SelectedValue = i.ToString();
                ddlOrderJap.SelectedValue = i.ToString();

            }

            //PaletteID = 0;
            //hdnEnglishSentenceID.Value = "-1";
            hdnJapaneseSentenceID.Value = "-2";
            hdnKanjiSentenceID.Value = "-3";
            hdnRomanjiSenteceID.Value = "-4";
            //txtEnglishKeyword.Text = string.Empty;
            txtJapaneseKeyword.Text = string.Empty;
            ddlPhraseCategory.SelectedIndex = 0;
            txtEngSentenceSoundFile.Text = string.Empty;
            upDetail.Update();
        }

        private void LoadDetails()
        {
            PaletteServiceClient client = new PaletteServiceClient();
            string json = client.GetPaletteDetails(PaletteID);
            PaletteContract pl = new JavaScriptSerializer().Deserialize<PaletteContract>(json);

            
            if(ddlPhraseCategory.Items.FindByValue(pl.PhraseCategoryID.ToString()) != null)
            {
                ddlPhraseCategory.SelectedValue = pl.PhraseCategoryID.ToString();
                lblWarning.Visible = false;
            }
            else
            {
                lblWarning.Visible = true;
            }
            ddlLevel.SelectedValue = pl.LevelID.ToString();

            Sentence s1 = pl.SentenceList.Find(x => x.LanguageCode == "en-US");
            if (s1!= null)
            {
                txtEnglishKeyword.Text = s1.Keyword;
                hdnEnglishSentenceID.Value = s1.SentenceID.ToString();
                txtEngSentenceSoundFile.Text = s1.SoundFile;
            }
            //if (s1.SentenceSoundList != null)
            //{
            //    SentenceSound ss = s1.SentenceSoundList.Find(x => x.LearningLanguageCode.Equals(ddlLanguage.SelectedValue));
            //    if (ss != null)
            //    {
            //        txtEngSentenceSoundFile.Text = ss.SoundFile;
            //    }
            //}

            var lang = LanguageList.Find(x => x.LanguageCode.Equals(ddlLanguage.SelectedValue));

            Sentence s2 = pl.SentenceList.Find(x => x.LanguageCode == lang.LanguageCode);
            if (s2 != null)
            {
                txtJapaneseKeyword.Text = s2.Keyword;
                hdnJapaneseSentenceID.Value = s2.SentenceID.ToString();
                txtJapSentenceSoundFile.Text = s2.SoundFile;
            }
            Sentence s3 = pl.SentenceList.Find(x => x.LanguageCode == lang.SubLanguageCode2);
            if (s3 != null)
            {
                hdnKanjiSentenceID.Value = s3.SentenceID.ToString();

            }
            Sentence s4 = pl.SentenceList.Find(x => x.LanguageCode == lang.SubLanguageCode);
            if (s4 != null)
            {
                hdnRomanjiSenteceID.Value = s4.SentenceID.ToString();
            }
            for (int i = 1; i <= 10; i++)
            {
                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                TextBox txtWordType = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtWordType" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());

                TextBox txtEngSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEngSoundFile" + i.ToString());
                TextBox txtJapSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJapSoundFile" + i.ToString());
                TextBox txtImageFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtImageFile" + i.ToString());


                List<Phrase> plist = pl.PhraseList.FindAll(x => x.WordMapID == i);
                if (plist!= null)
                {
                    foreach (Phrase p in plist)
                    {
                        if (p.LanguageCode == "en-US")
                        {
                            txtEng.Attributes["data-phraseid"] = p.PhraseID.ToString();
                            txtEng.Text = p.Word;
                            txtWordType.Text = p.WordType;
                            ddlOrderEng.SelectedValue = p.Ordinal.ToString();
                            txtEngSoundFile.Text = p.SoundFile;
                            txtImageFile.Text = p.ImageFile;
                        }
                        if (p.LanguageCode == lang.LanguageCode)
                        {
                            txtJap.Text = p.Word;
                            txtJap.Attributes["data-phraseid"] = p.PhraseID.ToString();
                            txtJapSoundFile.Text = p.SoundFile;
                        }
                        if (p.LanguageCode == lang.SubLanguageCode2)
                        {
                            txtKanji.Text = p.Word;
                            txtKanji.Attributes["data-phraseid"] = p.PhraseID.ToString();
                        }
                        if (p.LanguageCode == lang.SubLanguageCode)
                        {
                            txtRomanji.Text = p.Word;
                            txtRomanji.Attributes["data-phraseid"] = p.PhraseID.ToString();

                        }

                        if (p.LanguageCode == lang.SubLanguageCode || p.LanguageCode == lang.LanguageCode || p.LanguageCode == lang.SubLanguageCode2)
                        {
                            ddlOrderJap.SelectedValue = p.Ordinal.ToString();
                        }

                    }
                    
                }
            }
            upDetail.Update();
        }

        private bool Save(bool copytonew)
        {
            try
            {
                PaletteServiceClient client = new PaletteServiceClient();
                PaletteContract pc = GetPalette(copytonew);
                long id = 0;
                bool updated = false;
                if (copytonew)
                {
                    PaletteID = 0;
                }

                if (PaletteID == 0)
                {
                    id = client.AddPalette(pc);
                    PaletteID = id;
                }
                else
                {
                    updated = client.UpdatePalette(pc);
                }

                LoadDetails();

                return id>0 || updated;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private PaletteContract GetPalette(bool copytonew)
        {
            PaletteContract pc = new PaletteContract();

            if (copytonew)
            {
                pc.PaletteID = 0;
                pc.PhraseCategoryID = Convert.ToInt64(ddlCopytoPhraseCategory.SelectedValue);
            }
            else
            {
                pc.PaletteID = PaletteID;
                pc.PhraseCategoryID = Convert.ToInt64(ddlPhraseCategory.SelectedValue);
            }
            pc.LevelID = Convert.ToInt64(ddlLevel.SelectedValue);

            if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
            {
                pc.SchoolID = SessionManager.Instance.UserProfile.SchoolID;
            }


            Sentence se = new Sentence();
            //TODO:
            se.CreatedBy = SessionManager.Instance.UserProfile.UserID;
            se.LanguageCode = "en-US";
            se.SentenceID = Convert.ToInt32(hdnEnglishSentenceID.Value);
            se.SoundFile = txtEngSentenceSoundFile.Text.Length > 0 ?  txtEngSentenceSoundFile.Text : FileHelper.GetFileName(fileEnglishSentenceSound.PostedFile);
            se.SoundBytes= FileHelper.GetBytes(fileEnglishSentenceSound.PostedFile);
            

            se.Keyword = txtEnglishKeyword.Text;

            //List<SentenceSound> ssList = new List<SentenceSound>();
            //ssList.Add(new SentenceSound() { SentenceID = se.SentenceID, LearningLanguageCode =  ddlLanguage.SelectedValue, SoundFile = se.SoundFile});

            //se.SentenceSoundList = ssList;

            Sentence sh = new Sentence();
            
            var lang = LanguageList.Find(x => x.LanguageCode.Equals(ddlLanguage.SelectedValue));
            
            sh.CreatedBy = SessionManager.Instance.UserProfile.UserID;
            sh.LanguageCode = lang.LanguageCode;
            sh.SentenceID = Convert.ToInt32(hdnJapaneseSentenceID.Value);
            sh.Keyword = txtJapaneseKeyword.Text;
            sh.SoundFile = txtJapSentenceSoundFile.Text.Length > 0 ? txtJapSentenceSoundFile.Text : FileHelper.GetFileName(fileSentenceJapaneseSound.PostedFile);
            sh.SoundBytes = FileHelper.GetBytes(fileSentenceJapaneseSound.PostedFile);


            Sentence sk = new Sentence();
            //TODO:
            sk.CreatedBy = SessionManager.Instance.UserProfile.UserID;
            sk.LanguageCode = lang.SubLanguageCode2;
            sk.SentenceID = Convert.ToInt32(hdnKanjiSentenceID.Value);

            Sentence sr = new Sentence();
            //TODO:
            sr.CreatedBy = SessionManager.Instance.UserProfile.UserID;
            sr.LanguageCode = lang.SubLanguageCode;
            sr.SentenceID = Convert.ToInt32(hdnRomanjiSenteceID.Value);


            pc.SentenceList.Add(se);
            pc.SentenceList.Add(sh);
            pc.SentenceList.Add(sk);
            pc.SentenceList.Add(sr);

            for (int i = 1; i <= 10; i++)
            {
                Phrase pe = new Phrase();
                Phrase ph = new Phrase();
                Phrase pk = new Phrase();
                Phrase pr = new Phrase();

                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                TextBox txtWordType = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtWordType" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());
                FileUpload soundfileEng = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileEng" + i.ToString());
                FileUpload soundfileJap = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileJap" + i.ToString());
                FileUpload imagefile = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileImage" + i.ToString());

                TextBox txtEngSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEngSoundFile" + i.ToString());
                TextBox txtJapSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJapSoundFile" + i.ToString());
                TextBox txtImageFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtImageFile" + i.ToString());
                
                //English
                pe.PhraseID = Convert.ToInt64(txtEng.Attributes["data-phraseid"]);
                pe.Word = txtEng.Text;
                pe.Ordinal = Convert.ToInt32(ddlOrderEng.SelectedValue);
                pe.LanguageCode = "en-US";
                pe.PalleteID = PaletteID;
                pe.SentenceID = se.SentenceID;
                pe.SoundFile = soundfileEng.HasFile ? FileHelper.GetFileName(soundfileEng.PostedFile) : txtEngSoundFile.Text;
                pe.SoundBytes = soundfileEng.HasFile ? FileHelper.GetBytes(soundfileEng.PostedFile) : null;

                pe.WordMapID = i;
                pe.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) : txtImageFile.Text;
                pe.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;
                pe.WordType = txtWordType.Text;
                //pe.ImageBytes =

                //Hiragana
                ph.PhraseID = Convert.ToInt64(txtJap.Attributes["data-phraseid"]);
                ph.Word = txtJap.Text;
                ph.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
                ph.LanguageCode = lang.LanguageCode;
                ph.PalleteID = PaletteID;
                ph.SentenceID = sh.SentenceID;
                ph.SoundFile = soundfileJap.HasFile ? FileHelper.GetFileName(soundfileJap.PostedFile) : txtJapSoundFile.Text;
                ph.SoundBytes = soundfileJap.HasFile ? FileHelper.GetBytes(soundfileJap.PostedFile) : null;
                //                pe.SoundBytes = soundfile.PostedFile.InputStream
                ph.WordMapID = i;

                ph.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) : txtImageFile.Text;
                ph.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;
                ph.WordType = txtWordType.Text;
                //pe.ImageBytes =

                //Kanji
                pk.PhraseID = Convert.ToInt64(txtKanji.Attributes["data-phraseid"]);
                pk.Word = txtKanji.Text;
                pk.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
                pk.LanguageCode = lang.SubLanguageCode2;
                pk.PalleteID = PaletteID;
                pk.SentenceID = sk.SentenceID;
                pk.SoundFile = soundfileJap.HasFile ? FileHelper.GetFileName(soundfileJap.PostedFile) : txtJapSoundFile.Text;
                pk.SoundBytes = soundfileJap.HasFile ? FileHelper.GetBytes(soundfileJap.PostedFile) : null;

                //                pe.SoundBytes = soundfile.PostedFile.InputStream
                pk.WordMapID = i;
                pk.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) :txtImageFile.Text;
                pk.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;
                pk.WordType = txtWordType.Text;
                //pe.ImageBytes =

                //Romanji
                pr.PhraseID = Convert.ToInt64(txtRomanji.Attributes["data-phraseid"]);
                pr.Word = txtRomanji.Text;
                pr.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
                pr.LanguageCode = lang.SubLanguageCode;
                pr.PalleteID = PaletteID;
                pr.SentenceID =sr.SentenceID;
                pr.SoundFile = soundfileJap.HasFile ? FileHelper.GetFileName(soundfileJap.PostedFile) : txtJapSoundFile.Text;
                pr.SoundBytes = soundfileJap.HasFile ? FileHelper.GetBytes(soundfileJap.PostedFile) : null;

                //                pe.SoundBytes = soundfile.PostedFile.InputStream
                pr.WordMapID = i;
                pr.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) : txtImageFile.Text ;
                pr.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;
                pr.WordType = txtWordType.Text;
                //pe.ImageBytes =

                pc.PhraseList.Add(pe);
                pc.PhraseList.Add(ph);
                pc.PhraseList.Add(pk);
                pc.PhraseList.Add(pr);

            }
      
            return pc;
        }

        private void ShowMessage(bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            if (!isError)
                lblMessage.Text = "Action Successfull.";
            lblMessage.Visible = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                    return;

                if (Save(false))
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

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            try
            {
                if (Approve())
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
                if (Delete())
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

        private bool Delete()
        {
            PaletteServiceClient client = new PaletteServiceClient();
            bool deleted = client.DeletePalette(PaletteID);

            return deleted;
        }

        private bool Approve()
        {
            PaletteServiceClient client = new PaletteServiceClient();
            bool approved = client.ApprovePalette(PaletteID, SessionManager.Instance.UserProfile.UserID);

            return approved;
        }

        protected void btnCopyToNew_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            if (Save(true))
            {
                ShowMessage(false);
                Clear();
            }
        }

        protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Translate();
                ClearSecondLanguage();
                if(PaletteID > 0)
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