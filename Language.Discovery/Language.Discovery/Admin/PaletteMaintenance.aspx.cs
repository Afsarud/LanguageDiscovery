using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.MiscService;
using Language.Discovery.PaletteService;

namespace Language.Discovery.Admin
{
    public partial class PaletteMaintenance : System.Web.UI.Page
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
                slist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = "[Select School]" });
                ddlSearchSchool.DataSource = slist;
                ddlSearchSchool.DataTextField = "Name1";
                ddlSearchSchool.DataValueField = "SchoolID";
                ddlSearchSchool.DataBind();


                json = mclient.GetLevelList("en-US");
                List<LevelContract> lelist = new JavaScriptSerializer().Deserialize<List<LevelContract>>(json);
                lelist.Insert(0, new LevelContract() { LevelID = 0, LevelName = "[Select Level]" });
                ddlSearchLevel.DataSource = lelist;
                ddlSearchLevel.DataTextField = "LevelName";
                ddlSearchLevel.DataValueField = "LevelID";
                ddlSearchLevel.DataBind();

                json = pclient.GetPhraseCategory("en-US", 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                ddlSearchCategory.DataSource = plist;
                ddlSearchCategory.DataTextField = "PhraseCategoryCode";
                ddlSearchCategory.DataValueField = "PhraseCategoryID";
                ddlSearchCategory.DataBind();

                ddlPhraseCategory.DataSource = plist;
                ddlPhraseCategory.DataTextField = "PhraseCategoryCode";
                ddlPhraseCategory.DataValueField = "PhraseCategoryID";
                ddlPhraseCategory.DataBind();



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

            return dt;
        }

        private void BindResult()
        {
            PaletteServiceClient pclient = new PaletteServiceClient();
            SearchDTO dto = new SearchDTO()
            {
                CategoryID = Convert.ToInt32(ddlSearchCategory.SelectedValue),
                Word = txtSearchWord.Text,
                Keyword = txtSearchKeyword.Text,
                LevelID = Convert.ToInt64(ddlSearchLevel.SelectedValue),
                SchoolID = Convert.ToInt64(ddlSearchSchool.SelectedValue),
                PageNumber = 1,
                RowsPerPage = 10
            };
            int virtualcount = 0;
            
            List<PaletteContract> list = pclient.Search(dto, out virtualcount).ToList();

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
                var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("ja-JP")).ToList();
                //var psubnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();

                string words = string.Empty;
                string words2 = string.Empty;
                foreach (Phrase p in pnativelist)
                {
                    words += p.Word + " ";

                    var learn = plearninglist.Find(x => x.WordMapID.Equals(p.WordMapID));
                    if (learn != null)
                    {
                        words2 += learn.Word + " ";
                    }
                }

                row["PaletteID"] = pcontract.PaletteID;
                row["Sentence"] = words;
                row["Sentence2"] = words2;
                dt.Rows.Add(row);
            }

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
            System.Threading.Thread.Sleep(2000);
            BindResult();
        }

        protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

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
            GridViewRow gvRow = grdResult.SelectedRow;
            long headerid = Convert.ToInt64(((HiddenField)gvRow.FindControl("hdnSearchPaletteID")).Value);
            PaletteID = headerid;
            LoadDetails();

        }

        private void InitializePalette()
        {
            for (int i = 1; i <= 10; i++)
            {
                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtHir = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtHir" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());

                txtEng.Attributes.Add("data-phraseid",(-1 * i).ToString());
                txtHir.Attributes.Add("data-phraseid",(-1 * i).ToString());
                txtKanji.Attributes.Add("data-phraseid",(-1 * i).ToString());
                txtRomanji.Attributes.Add("data-phraseid", (-1 * i).ToString());

            }
        }
        

        private void Clear()
        {
            for (int i = 1; i <= 10; i++)
            {
                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtHir = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtHir" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());

                txtEng.Text = string.Empty;
                txtHir.Text = string.Empty;
                txtKanji.Text = string.Empty;
                txtRomanji.Text = string.Empty;
                ddlOrderEng.SelectedIndex = 0;
                ddlOrderJap.SelectedIndex = 0;

                txtEng.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtHir.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtKanji.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtRomanji.Attributes["data-phraseid"] = (-1 * i).ToString();
                txtHir.Text = string.Empty;
                txtKanji.Text = string.Empty;
                txtRomanji.Text = string.Empty;

            }
            PaletteID = 0;
            hdnEnglishSentenceID.Value = "-1";
            hdnHiraganaSentenceID.Value = "-2";
            hdnKanjiSentenceID.Value = "-3";
            hdnRomanjiSenteceID.Value = "-4";
            txtEnglishKeyword.Text = string.Empty;
            txtJapaneseKeyword.Text = string.Empty;
            upDetail.Update();
        }

        private void LoadDetails()
        {
            PaletteServiceClient client = new PaletteServiceClient();
            string json = client.GetPaletteDetails(PaletteID);
            PaletteContract pl = new JavaScriptSerializer().Deserialize<PaletteContract>(json);

            ddlPhraseCategory.SelectedValue = pl.PhraseCategoryID.ToString();
            Sentence s1 = pl.SentenceList.Find(x => x.LanguageCode == "en-US");
            if (s1!= null)
            {
                txtEnglishKeyword.Text = s1.Keyword;
                hdnEnglishSentenceID.Value = s1.SentenceID.ToString();
            }
            Sentence s2 = pl.SentenceList.Find(x => x.LanguageCode == "ja-JP");
            if (s2 != null)
            {
                txtJapaneseKeyword.Text = s2.Keyword;
                hdnHiraganaSentenceID.Value = s2.SentenceID.ToString();
            }
            Sentence s3 = pl.SentenceList.Find(x => x.LanguageCode == "ja-KA");
            if (s3 != null)
            {
                hdnKanjiSentenceID.Value = s3.SentenceID.ToString();

            }
            Sentence s4 = pl.SentenceList.Find(x => x.LanguageCode == "ja-RO");
            if (s4 != null)
            {
                hdnRomanjiSenteceID.Value = s4.SentenceID.ToString();
            }
            for (int i = 1; i <= 10; i++)
            {
                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtHir = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtHir" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());

                List<Phrase> plist = pl.PhraseList.FindAll(x => x.WordMapID == i);
                if (plist!= null)
                {
                    foreach (Phrase p in plist)
                    {
                        if (p.LanguageCode == "en-US")
                        {
                            txtEng.Attributes["data-phraseid"] = p.PhraseID.ToString();
                            txtEng.Text = p.Word;
                            ddlOrderEng.SelectedValue = p.Ordinal.ToString();
                        }
                        if (p.LanguageCode == "ja-JP")
                        {
                            txtHir.Text = p.Word;
                            txtHir.Attributes["data-phraseid"] = p.PhraseID.ToString();
                        }
                        if (p.LanguageCode == "ja-KA")
                        {
                            txtKanji.Text = p.Word;
                            txtKanji.Attributes["data-phraseid"] = p.PhraseID.ToString();
                        }
                        if (p.LanguageCode == "ja-RO")
                        {
                            txtRomanji.Text = p.Word;
                            txtRomanji.Attributes["data-phraseid"] = p.PhraseID.ToString();

                        }

                        if (p.LanguageCode == "ja-RO" || p.LanguageCode == "ja-JP" || p.LanguageCode == "ja-KA")
                        {
                            ddlOrderJap.SelectedValue = p.Ordinal.ToString();
                        }

                    }
                    
                }
            }
            upDetail.Update();
        }

        private bool Save()
        {
            try
            {
                
                PaletteServiceClient client = new PaletteServiceClient();
                PaletteContract pc = GetPalette();

                long id = client.AddPalette(pc);
                PaletteID = id;

                LoadDetails();

                return id>0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private PaletteContract GetPalette()
        {
            PaletteContract pc = new PaletteContract();
            pc.PaletteID = PaletteID;
            pc.PhraseCategoryID = Convert.ToInt64(ddlPhraseCategory.SelectedValue);
            
            Sentence se = new Sentence();
            //TODO:
            se.CreatedBy = 1;
            se.LanguageCode = "en-US";
            se.SentenceID = Convert.ToInt32(hdnEnglishSentenceID.Value);
            se.Keyword = txtEnglishKeyword.Text;

            Sentence sh = new Sentence();
            //TODO:
            sh.CreatedBy = 1;
            sh.LanguageCode = "ja-JP";
            sh.SentenceID = Convert.ToInt32(hdnHiraganaSentenceID.Value);
            sh.Keyword = txtJapaneseKeyword.Text;

            Sentence sk = new Sentence();
            //TODO:
            sk.CreatedBy = 1;
            sk.LanguageCode = "ja-KA";
            sk.SentenceID = Convert.ToInt32(hdnKanjiSentenceID.Value);

            Sentence sr = new Sentence();
            //TODO:
            sr.CreatedBy = 1;
            sr.LanguageCode = "ja-RO";
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
                TextBox txtHir = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtHir" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());
                FileUpload soundfileEng = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileEng" + i.ToString());
                FileUpload soundfileJap = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileJap" + i.ToString());
                FileUpload imagefile = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileImage" + i.ToString());
                
                //English
                pe.Word = txtEng.Text;
                pe.Ordinal = Convert.ToInt32(ddlOrderEng.SelectedValue);
                pe.LanguageCode = "en-US";
                pe.PalleteID = PaletteID;
                pe.SentenceID = se.SentenceID;
                pe.SoundFile = soundfileEng.HasFile ? soundfileEng.FileName : string.Empty;
//                pe.SoundBytes = soundfile.PostedFile.InputStream
                pe.WordMapID = i;
                pe.ImageFile = imagefile.HasFile ? imagefile.FileName : string.Empty;
                //pe.ImageBytes =

                //Hiragana
                ph.Word = txtHir.Text;
                ph.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
                ph.LanguageCode = "ja-JP";
                ph.PalleteID = PaletteID;
                ph.SentenceID = sh.SentenceID;
                ph.SoundFile = soundfileEng.HasFile ? soundfileJap.FileName : string.Empty;
                //                pe.SoundBytes = soundfile.PostedFile.InputStream
                ph.WordMapID = i;
                ph.ImageFile = imagefile.HasFile ? imagefile.FileName : string.Empty;
                //pe.ImageBytes =

                //Kanji
                pk.Word = txtKanji.Text;
                pk.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
                pk.LanguageCode = "ja-KA";
                pk.PalleteID = PaletteID;
                pk.SentenceID = sk.SentenceID;
                pk.SoundFile = soundfileJap.HasFile ? soundfileJap.FileName : string.Empty;
                //                pe.SoundBytes = soundfile.PostedFile.InputStream
                pk.WordMapID = i;
                pk.ImageFile = imagefile.HasFile ? imagefile.FileName : string.Empty;
                //pe.ImageBytes =

                //Romanji
                pr.Word = txtRomanji.Text;
                pr.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
                pr.LanguageCode = "ja-RO";
                pr.PalleteID = PaletteID;
                pr.SentenceID =sr.SentenceID;
                pr.SoundFile = soundfileJap.HasFile ? soundfileJap.FileName : string.Empty;
                //                pe.SoundBytes = soundfile.PostedFile.InputStream
                pr.WordMapID = i;
                pr.ImageFile = imagefile.HasFile ? imagefile.FileName : string.Empty;
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

            if (Save())
            {
                ShowMessage(false);
                Clear();
            }
            
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

        }
    }
}