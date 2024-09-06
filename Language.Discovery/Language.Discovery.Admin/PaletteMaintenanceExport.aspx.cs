using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using DocumentFormat.OpenXml.Packaging;
using System.Web.UI.HtmlControls;
using SpreadsheetLight;
using System.IO;
using System.ServiceModel.Syndication;
using DocumentFormat.OpenXml.Spreadsheet;
using Color = System.Drawing.Color;

namespace Language.Discovery.Admin
{
    public partial class PaletteMaintenanceExport : BasePage
    {
        private delegate void ImportCompletedHandler(string filename);
        private string _Filename;
        private long _UserId;
        private long _SearchCategory;
        private string _ImportAction;
        private string _TopCategoryName;
        private int _TopCategoryHeaderID;

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

        private List<PhraseCategoryContract> CategoryList
        {
            get
            {
                List<PhraseCategoryContract> list = null;
                if (ViewState["CategoryList"] != null)
                {
                    list = (List<PhraseCategoryContract>)ViewState["CategoryList"];
                }
                return list;
            }
            set
            {
                ViewState["CategoryList"] = value;
            }
        }

        int PageIndex = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                PopulateDropDownList();
                btnExport.Visible = true;
                btnImport.Visible = false;
                lblSelectFile.Visible = false;
                fuExcelUploader.Visible = false;
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
            }
        }


        private void PopulateDropDownList()
        {
            try
            {
                PaletteServiceClient pclient = new PaletteServiceClient();

                MiscServiceClient mclient = new MiscServiceClient();
                string json = pclient.GetPhraseCategory(SessionManager.Instance.UserProfile.NativeLanguage, 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                List<PhraseCategoryContract> plist1 = plist.ToList();
                plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[Select Category]" });
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
        private void GetPhraseCategory()
        {
            try
            {
                PaletteServiceClient pclient = new PaletteServiceClient();

                MiscServiceClient mclient = new MiscServiceClient();
                string json = pclient.GetPhraseCategory(SessionManager.Instance.UserProfile.NativeLanguage, 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                CategoryList = plist;
                //List<PhraseCategoryContract> plist1 = plist.ToList();
                //plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[Select Category]" });
                //ddlSearchCategory.DataSource = plist;
                //ddlSearchCategory.DataTextField = "PhraseCategoryCode";
                //ddlSearchCategory.DataValueField = "PhraseCategoryID";
                //ddlSearchCategory.DataBind();


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //private void LoadDetails()
        //{
        //    PaletteServiceClient client = new PaletteServiceClient();
        //    string json = client.GetPaletteDetails(PaletteID);
        //    PaletteContract pl = new JavaScriptSerializer().Deserialize<PaletteContract>(json);

        //    ddlPhraseCategory.SelectedValue = pl.PhraseCategoryID.ToString();
        //    ddlLevel.SelectedValue = pl.LevelID.ToString();

        //    Sentence s1 = pl.SentenceList.Find(x => x.LanguageCode == "en-US");
        //    if (s1!= null)
        //    {
        //        txtEnglishKeyword.Text = s1.Keyword;
        //        hdnEnglishSentenceID.Value = s1.SentenceID.ToString();
        //        txtEngSentenceSoundFile.Text = s1.SoundFile;
        //    }
        //    Sentence s2 = pl.SentenceList.Find(x => x.LanguageCode == "ja-JP");
        //    if (s2 != null)
        //    {
        //        txtJapaneseKeyword.Text = s2.Keyword;
        //        hdnJapaneseSentenceID.Value = s2.SentenceID.ToString();
        //        txtJapSentenceSoundFile.Text = s2.SoundFile;
        //    }
        //    Sentence s3 = pl.SentenceList.Find(x => x.LanguageCode == "ja-KA");
        //    if (s3 != null)
        //    {
        //        hdnKanjiSentenceID.Value = s3.SentenceID.ToString();

        //    }
        //    Sentence s4 = pl.SentenceList.Find(x => x.LanguageCode == "ja-RO");
        //    if (s4 != null)
        //    {
        //        hdnRomanjiSenteceID.Value = s4.SentenceID.ToString();
        //    }
        //    for (int i = 1; i <= 10; i++)
        //    {
        //        TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
        //        TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
        //        TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
        //        TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
        //        DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
        //        DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());

        //        TextBox txtEngSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEngSoundFile" + i.ToString());
        //        TextBox txtJapSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJapSoundFile" + i.ToString());
        //        TextBox txtImageFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtImageFile" + i.ToString());


        //        List<Phrase> plist = pl.PhraseList.FindAll(x => x.WordMapID == i);
        //        if (plist!= null)
        //        {
        //            foreach (Phrase p in plist)
        //            {
        //                if (p.LanguageCode == "en-US")
        //                {
        //                    txtEng.Attributes["data-phraseid"] = p.PhraseID.ToString();
        //                    txtEng.Text = p.Word;
        //                    ddlOrderEng.SelectedValue = p.Ordinal.ToString();
        //                    txtEngSoundFile.Text = p.SoundFile;
        //                    txtImageFile.Text = p.ImageFile;
        //                }
        //                if (p.LanguageCode == "ja-JP")
        //                {
        //                    txtJap.Text = p.Word;
        //                    txtJap.Attributes["data-phraseid"] = p.PhraseID.ToString();
        //                    txtJapSoundFile.Text = p.SoundFile;
        //                }
        //                if (p.LanguageCode == "ja-KA")
        //                {
        //                    txtKanji.Text = p.Word;
        //                    txtKanji.Attributes["data-phraseid"] = p.PhraseID.ToString();
        //                }
        //                if (p.LanguageCode == "ja-RO")
        //                {
        //                    txtRomanji.Text = p.Word;
        //                    txtRomanji.Attributes["data-phraseid"] = p.PhraseID.ToString();

        //                }

        //                if (p.LanguageCode == "ja-RO" || p.LanguageCode == "ja-JP" || p.LanguageCode == "ja-KA")
        //                {
        //                    ddlOrderJap.SelectedValue = p.Ordinal.ToString();
        //                }

        //            }
                    
        //        }
        //    }
        //    upDetail.Update();
        //}

        //private bool Save(bool copytonew)
        //{
        //    try
        //    {
        //        PaletteServiceClient client = new PaletteServiceClient();
        //        PaletteContract pc = GetPalette(copytonew);
        //        long id = 0;
        //        bool updated = false;
        //        if (copytonew)
        //        {
        //            PaletteID = 0;
        //        }

        //        if (PaletteID == 0)
        //        {
        //            id = client.AddPalette(pc);
        //            PaletteID = id;
        //        }
        //        else
        //        {
        //            updated = client.UpdatePalette(pc);
        //        }

        //        LoadDetails();

        //        return id>0 || updated;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        //private PaletteContract GetPalette(bool copytonew)
        //{
        //    PaletteContract pc = new PaletteContract();

        //    if (copytonew)
        //    {
        //        pc.PaletteID = 0;
        //        pc.PhraseCategoryID = Convert.ToInt64(ddlCopytoPhraseCategory.SelectedValue);
        //    }
        //    else
        //    {
        //        pc.PaletteID = PaletteID;
        //        pc.PhraseCategoryID = Convert.ToInt64(ddlPhraseCategory.SelectedValue);
        //    }
        //    pc.LevelID = Convert.ToInt64(ddlLevel.SelectedValue);

        //    if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
        //    {
        //        pc.SchoolID = SessionManager.Instance.UserProfile.SchoolID;
        //    }


        //    Sentence se = new Sentence();
        //    //TODO:
        //    se.CreatedBy = SessionManager.Instance.UserProfile.UserID;
        //    se.LanguageCode = "en-US";
        //    se.SentenceID = Convert.ToInt32(hdnEnglishSentenceID.Value);
        //    se.SoundFile = txtEngSentenceSoundFile.Text.Length > 0 ?  txtEngSentenceSoundFile.Text : FileHelper.GetFileName(fileEnglishSentenceSound.PostedFile);
        //    se.SoundBytes= FileHelper.GetBytes(fileEnglishSentenceSound.PostedFile);
            

        //    se.Keyword = txtEnglishKeyword.Text;

        //    Sentence sh = new Sentence();
            
        //    sh.CreatedBy = SessionManager.Instance.UserProfile.UserID;
        //    sh.LanguageCode = "ja-JP";
        //    sh.SentenceID = Convert.ToInt32(hdnJapaneseSentenceID.Value);
        //    sh.Keyword = txtJapaneseKeyword.Text;
        //    sh.SoundFile = txtJapSentenceSoundFile.Text.Length > 0 ? txtJapSentenceSoundFile.Text : FileHelper.GetFileName(fileSentenceJapaneseSound.PostedFile);
        //    sh.SoundBytes = FileHelper.GetBytes(fileSentenceJapaneseSound.PostedFile);


        //    Sentence sk = new Sentence();
        //    //TODO:
        //    sk.CreatedBy = SessionManager.Instance.UserProfile.UserID;
        //    sk.LanguageCode = "ja-KA";
        //    sk.SentenceID = Convert.ToInt32(hdnKanjiSentenceID.Value);

        //    Sentence sr = new Sentence();
        //    //TODO:
        //    sr.CreatedBy = SessionManager.Instance.UserProfile.UserID;
        //    sr.LanguageCode = "ja-RO";
        //    sr.SentenceID = Convert.ToInt32(hdnRomanjiSenteceID.Value);


        //    pc.SentenceList.Add(se);
        //    pc.SentenceList.Add(sh);
        //    pc.SentenceList.Add(sk);
        //    pc.SentenceList.Add(sr);

        //    for (int i = 1; i <= 10; i++)
        //    {
        //        Phrase pe = new Phrase();
        //        Phrase ph = new Phrase();
        //        Phrase pk = new Phrase();
        //        Phrase pr = new Phrase();

        //        TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
        //        TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
        //        TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
        //        TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
        //        DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
        //        DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());
        //        FileUpload soundfileEng = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileEng" + i.ToString());
        //        FileUpload soundfileJap = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileJap" + i.ToString());
        //        FileUpload imagefile = (FileUpload)this.Master.FindControl("ContentPlaceHolder3").FindControl("fileImage" + i.ToString());

        //        TextBox txtEngSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEngSoundFile" + i.ToString());
        //        TextBox txtJapSoundFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJapSoundFile" + i.ToString());
        //        TextBox txtImageFile = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtImageFile" + i.ToString());
                
        //        //English
        //        pe.PhraseID = Convert.ToInt64(txtEng.Attributes["data-phraseid"]);
        //        pe.Word = txtEng.Text;
        //        pe.Ordinal = Convert.ToInt32(ddlOrderEng.SelectedValue);
        //        pe.LanguageCode = "en-US";
        //        pe.PalleteID = PaletteID;
        //        pe.SentenceID = se.SentenceID;
        //        pe.SoundFile = soundfileEng.HasFile ? FileHelper.GetFileName(soundfileEng.PostedFile) : txtEngSoundFile.Text;
        //        pe.SoundBytes = soundfileEng.HasFile ? FileHelper.GetBytes(soundfileEng.PostedFile) : null;

        //        pe.WordMapID = i;
        //        pe.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) : txtImageFile.Text;
        //        pe.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;

        //        //pe.ImageBytes =

        //        //Hiragana
        //        ph.PhraseID = Convert.ToInt64(txtJap.Attributes["data-phraseid"]);
        //        ph.Word = txtJap.Text;
        //        ph.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
        //        ph.LanguageCode = "ja-JP";
        //        ph.PalleteID = PaletteID;
        //        ph.SentenceID = sh.SentenceID;
        //        ph.SoundFile = soundfileJap.HasFile ? FileHelper.GetFileName(soundfileJap.PostedFile) : txtJapSoundFile.Text;
        //        ph.SoundBytes = soundfileJap.HasFile ? FileHelper.GetBytes(soundfileJap.PostedFile) : null;
        //        //                pe.SoundBytes = soundfile.PostedFile.InputStream
        //        ph.WordMapID = i;

        //        ph.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) : txtImageFile.Text;
        //        ph.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;

        //        //pe.ImageBytes =

        //        //Kanji
        //        pk.PhraseID = Convert.ToInt64(txtKanji.Attributes["data-phraseid"]);
        //        pk.Word = txtKanji.Text;
        //        pk.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
        //        pk.LanguageCode = "ja-KA";
        //        pk.PalleteID = PaletteID;
        //        pk.SentenceID = sk.SentenceID;
        //        pk.SoundFile = soundfileJap.HasFile ? FileHelper.GetFileName(soundfileJap.PostedFile) : txtJapSoundFile.Text;
        //        pk.SoundBytes = soundfileJap.HasFile ? FileHelper.GetBytes(soundfileJap.PostedFile) : null;

        //        //                pe.SoundBytes = soundfile.PostedFile.InputStream
        //        pk.WordMapID = i;
        //        pk.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) :txtImageFile.Text;
        //        pk.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;

        //        //pe.ImageBytes =

        //        //Romanji
        //        pr.PhraseID = Convert.ToInt64(txtRomanji.Attributes["data-phraseid"]);
        //        pr.Word = txtRomanji.Text;
        //        pr.Ordinal = Convert.ToInt32(ddlOrderJap.SelectedValue);
        //        pr.LanguageCode = "ja-RO";
        //        pr.PalleteID = PaletteID;
        //        pr.SentenceID =sr.SentenceID;
        //        pr.SoundFile = soundfileJap.HasFile ? FileHelper.GetFileName(soundfileJap.PostedFile) : txtJapSoundFile.Text;
        //        pr.SoundBytes = soundfileJap.HasFile ? FileHelper.GetBytes(soundfileJap.PostedFile) : null;

        //        //                pe.SoundBytes = soundfile.PostedFile.InputStream
        //        pr.WordMapID = i;
        //        pr.ImageFile = imagefile.HasFile ? FileHelper.GetFileName(imagefile.PostedFile) : txtImageFile.Text ;
        //        pr.ImageBytes = imagefile.HasFile ? FileHelper.GetBytes(imagefile.PostedFile) : null;

        //        //pe.ImageBytes =

        //        pc.PhraseList.Add(pe);
        //        pc.PhraseList.Add(ph);
        //        pc.PhraseList.Add(pk);
        //        pc.PhraseList.Add(pr);

        //    }
      
        //    return pc;
        //}

        private void ShowMessage(bool isError)
        {
        //    lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
        //    if (!isError)
        //        lblMessage.Text = "Action Successfull.";
        //    lblMessage.Visible = true;
        }


        protected void btnExport_OnClick(object sender, EventArgs e)
        {
            Export();
        }

        private void Export()
        {
            string filename = string.Empty;
            int rowaddends = 21;
            int currentrow = 2;
            string[] columns = new[] {"B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"};

            PaletteServiceClient pclient = new PaletteServiceClient();
            int pagenumber = 1;
            List<PaletteContract> list = new List<PaletteContract>();
            for (int i = 1; i < 10; i++)
            {
                SearchDTO dto = new SearchDTO()
                {
                    CategoryID = Convert.ToInt32(ddlSearchCategory.SelectedValue),
                    Word = "",
                    Keyword = "",
                    LevelID = 0,
                    SchoolID = 0,
                    PageNumber = i,
                    RowsPerPage = 100,
                    IsAdmin = true,
                    CategoryIDs = ddlSearchCategory.SelectedValue
                };
                int virtualcount = 0;
                //string json = pclient.Search(dto, out virtualcount);

                List<PaletteContract> list2 = pclient.Search(dto, out virtualcount).ToList();
                if (list2 != null && list2.Count > 0)
                    list.AddRange(list2);
                else
                    break;


            }
            using (SLDocument sl = new SLDocument())
            {
                int encurrentrow = 2;
                int jacurrentrow = 8;
                int chcurrentrow = 14;

                foreach (PaletteContract paleteContract in list)
                {
                    int enrunningrow = encurrentrow;
                    int jarunningrow = jacurrentrow;
                    int chrunningrow = chcurrentrow;
                    PaletteContract pcontract = new PaletteContract();
                    pcontract.PaletteID = paleteContract.PaletteID;
                    pcontract.SchoolID = paleteContract.SchoolID;
                    pcontract.PhraseCategoryID = paleteContract.PhraseCategoryID;
                    pcontract.DefaultLanguageCode = paleteContract.DefaultLanguageCode;

                    var englishlist =
                        paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("en-US"))
                            .OrderBy(x => x.Ordinal)
                            .ToList();
                    var japaneselist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("ja-JP"));
                    var kanjilist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("ja-KA"));
                    var romanjilist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("ja-RO"));

                    var chineselist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("zh-CN"));
                    var chkanjilist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("zh-X"));
                    var chromanjilist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals("zh-PN"));

                    //.OrderBy(x => x.Ordinal).ToList();
                    //var psubnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();


                    string words = string.Empty;
                    string words2 = string.Empty;
                    //I play basketball
                    SLStyle style = sl.CreateStyle();
                    SLStyle styleleft = sl.CreateStyle();
                    style.SetFontBold(true);
                    style.Alignment.Horizontal = HorizontalAlignmentValues.Right;
                    styleleft.SetFontBold(true);
                    styleleft.Alignment.Horizontal = HorizontalAlignmentValues.Left;

                    SLStyle jstyle = sl.CreateStyle();
                    //jstyle.Fill.SetPattern(PatternValues.Solid, System.Drawing.Color.Silver, System.Drawing.Color.Black);
                    jstyle.SetFontBold(true);
                    jstyle.Alignment.Horizontal = HorizontalAlignmentValues.Right;


                    //Write Box 1-10
                    for (int i = 0; i < 10; i++)
                    {
                        sl.SetCellValue(columns[i] + "1", "Box" + (i+1).ToString());
                        sl.SetCellStyle(columns[i] + "1", style);
                    }
                    sl.SetCellValue("L1", "Sentence Sound File");
                    sl.SetCellStyle("L1", style);
                    //Write English
                    bool hasSentenceSoundWritten = false;
                    bool hasSentenceKeywordWritten = false;
                    for (int i = 0; i < englishlist.Count; i++)
                    {
                        sl.SetCellValue("A" + enrunningrow.ToString(), "Photo Images");
                        sl.SetCellStyle("A" + enrunningrow.ToString(), style);
                        sl.SetCellValue(columns[i] + enrunningrow.ToString(), englishlist[i].ImageFile);
                        enrunningrow++;
                        sl.SetCellValue("A" + enrunningrow.ToString(), "English original sentence");
                        sl.SetCellStyle("A" + enrunningrow.ToString(), styleleft);
                        sl.SetCellValue(columns[i] + enrunningrow.ToString(), Server.HtmlDecode(englishlist[i].Word));
                        if (!hasSentenceSoundWritten)
                        {
                            var sentence = paleteContract.SentenceList.Find(x => x.SentenceID == englishlist[i].SentenceID);
                            if (sentence != null)
                            {
                                sl.SetCellValue("L" + enrunningrow.ToString(), sentence.SoundFile);
                            }
                            hasSentenceSoundWritten = true;
                        }
                        enrunningrow++;
                        sl.SetCellValue("A" + enrunningrow.ToString(), "Order");
                        sl.SetCellStyle("A" + enrunningrow.ToString(), style);
                        sl.SetCellValue(columns[i] + enrunningrow.ToString(), englishlist[i].Ordinal.ToString());
                        enrunningrow ++;
                        sl.SetCellValue("A" + enrunningrow.ToString(), "Sound File");
                        sl.SetCellStyle("A" + enrunningrow.ToString(), style);
                        sl.SetCellValue(columns[i] + enrunningrow.ToString(), englishlist[i].SoundFile);
                        enrunningrow++;
                        sl.SetCellValue("A" + enrunningrow.ToString(), "Word Type");
                        sl.SetCellStyle("A" + enrunningrow.ToString(), style);
                        sl.SetCellValue(columns[i] + enrunningrow.ToString(), englishlist[i].WordType);
                        enrunningrow++;
                        sl.SetCellValue("A" + enrunningrow.ToString(), "Keyword");
                        sl.SetCellStyle("A" + enrunningrow.ToString(), style);
                        if (!hasSentenceKeywordWritten)
                        {
                            var sentence = paleteContract.SentenceList.Find(x => x.SentenceID == englishlist[i].SentenceID);
                            if (sentence != null)
                            {
                                sl.SetCellValue("B" + enrunningrow.ToString(), sentence.Keyword);
                            }
                            hasSentenceKeywordWritten = true;
                        }
                        //sl.SetCellValue(columns[i] + enrunningrow.ToString(), englishlist[i].Keyword);
                        enrunningrow = encurrentrow;
                    }
                    //Write Japanese
                    jarunningrow = jacurrentrow;
                    if (japaneselist.Count == 0)
                    {
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Translations1 (Japanese)");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), styleleft);
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Other character 2(Kanji)");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), style);
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Other characters (Romanji)");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), style);
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Order");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), style);
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Sound File");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), style);
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Keyword");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), style);
                        jarunningrow = jacurrentrow;
                    }

                    hasSentenceSoundWritten = false;
                    hasSentenceKeywordWritten = false;
                    jarunningrow = jacurrentrow;
                    for (int j = 0; j < japaneselist.Count; j++)
                    {
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Translations1 (Japanese)");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), styleleft);
                        sl.SetCellValue(columns[j] + jarunningrow.ToString(), Server.HtmlDecode(japaneselist[j].Word));
                        if (!hasSentenceSoundWritten)
                        {
                            var sentence = paleteContract.SentenceList.Find(x => x.SentenceID == japaneselist[j].SentenceID);
                            if (sentence != null)
                            {
                                sl.SetCellValue("L" + jarunningrow.ToString(), sentence.SoundFile);
                            }
                            hasSentenceSoundWritten = true;
                        }

                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Other character 2(Kanji)");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), jstyle);
                        if (kanjilist != null && kanjilist.Count > 0 && kanjilist.Count > j)
                        {
                            sl.SetCellValue(columns[j] + jarunningrow.ToString(), kanjilist[j].Word);
                        }
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Other characters (Romanji)");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), jstyle);
                        if (romanjilist != null && romanjilist.Count > 0 && romanjilist.Count > j)
                        {
                            sl.SetCellValue(columns[j] + jarunningrow.ToString(), romanjilist[j].Word);
                        }
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Order");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), jstyle);
                        sl.SetCellValue(columns[j] + jarunningrow.ToString(), japaneselist[j].Ordinal.ToString());
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Sound File");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), jstyle);
                        sl.SetCellValue(columns[j] + jarunningrow.ToString(), japaneselist[j].SoundFile);
                        jarunningrow++;
                        sl.SetCellValue("A" + jarunningrow.ToString(), "Keyword");
                        sl.SetCellStyle("A" + jarunningrow.ToString(), jstyle);
                        if (!hasSentenceKeywordWritten)
                        {
                            var sentence = paleteContract.SentenceList.Find(x => x.SentenceID == japaneselist[j].SentenceID);
                            if (sentence != null)
                            {
                                sl.SetCellValue("B" + jarunningrow.ToString(), sentence.Keyword);
                            }
                            hasSentenceKeywordWritten = true;
                        }
                        //sl.SetCellValue(columns[j] + jarunningrow.ToString(), japaneselist[j].Keyword);
                        jarunningrow = jacurrentrow;
                    }
                    //Write Chinese
                    chrunningrow = chcurrentrow;
                    if (chineselist.Count == 0)
                    {
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Translations2 (Chinese)");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), styleleft);
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Other character 2");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Other characters (Romanji)");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Order");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Sound File");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Keyword");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        chrunningrow = chcurrentrow;
                    }
                    hasSentenceSoundWritten = false;
                    hasSentenceKeywordWritten = false;
                    for (int j = 0; j < chineselist.Count; j++)
                    {
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Translations2 (Chinese)");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), styleleft);
                        sl.SetCellValue(columns[j] + chrunningrow.ToString(), Server.HtmlDecode(chineselist[j].Word));
                        if (!hasSentenceSoundWritten)
                        {
                            var sentence = paleteContract.SentenceList.Find(x => x.SentenceID == chineselist[j].SentenceID);
                            if (sentence != null)
                            {
                                sl.SetCellValue("L" + chrunningrow.ToString(), sentence.SoundFile);
                            }
                            hasSentenceSoundWritten = true;
                        }
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Other character 2");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        if (chkanjilist != null && chkanjilist.Count > 0 && chkanjilist.Count > j)
                        {
                            sl.SetCellValue(columns[j] + chrunningrow.ToString(), chkanjilist[j].Word);
                        }
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Other characters (Romanji)");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        if (chromanjilist != null && chromanjilist.Count > 0 && chromanjilist.Count > j)
                        {
                            sl.SetCellValue(columns[j] + chrunningrow.ToString(), chromanjilist[j].Word);
                        }
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Order");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        sl.SetCellValue(columns[j] + chrunningrow.ToString(), chineselist[j].Ordinal.ToString());
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Sound File");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        sl.SetCellValue(columns[j] + chrunningrow.ToString(), chineselist[j].SoundFile);
                        chrunningrow++;
                        sl.SetCellValue("A" + chrunningrow.ToString(), "Keyword");
                        sl.SetCellStyle("A" + chrunningrow.ToString(), style);
                        if (!hasSentenceKeywordWritten)
                        {
                            var sentence = paleteContract.SentenceList.Find(x => x.SentenceID == chineselist[j].SentenceID);
                            if (sentence != null)
                            {
                                sl.SetCellValue("B" + chrunningrow.ToString(), sentence.Keyword);
                            }
                            hasSentenceKeywordWritten = true;
                        }
                        //sl.SetCellValue(columns[j] + chrunningrow.ToString(), chineselist[j].Keyword);
                        chrunningrow = chcurrentrow;
                    }


                    encurrentrow += 19;
                    jacurrentrow += 19;
                    chcurrentrow += 19;
                }

                //sl.ImportDataTable(1, 1, ds.Tables[0], true);
                filename = Path.Combine(Server.MapPath("~//Upload//"), "ExportedPalette_" + ddlSearchCategory.SelectedItem.Text.Replace("/","") + ".xlsx");
                sl.SaveAs(filename);
            }

            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "Application/x-msexcel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filename));
            Response.WriteFile(filename);
            Response.Flush();
            File.Delete(filename);

            Response.End();
        }

        private string Upload()
        {
            lblImport.Visible = fuExcelUploader.HasFile;
            lblImport.Text = string.Empty;
            string sFileName = string.Empty;

            if (fuExcelUploader.HasFile)
            {
                try
                {
                    string sExtension = Path.GetExtension(fuExcelUploader.FileName).ToLower();

                    if (sExtension.Trim() == ".xls" || sExtension.Trim() == ".xlsx")
                    {
                        sFileName = Server.MapPath("Upload/") + fuExcelUploader.FileName;

                        if (!Directory.Exists(Server.MapPath("Upload/")))
                        {
                            Directory.CreateDirectory(Server.MapPath("Upload/"));
                        }

                        fuExcelUploader.SaveAs(sFileName);
                        lblImport.ForeColor = Color.Green;
                        lblImport.Text = "File name: " + fuExcelUploader.PostedFile.FileName + "<br>" + fuExcelUploader.PostedFile.ContentLength + " kb<br>" + "<br><b>Uploaded Successfully";
                        lblWarning.ForeColor = Color.Orange;
                        lblWarning.Visible = true;


                    }
                    else
                    {
                        lblImport.ForeColor = Color.Red;
                        lblImport.Text = "WARNING: File is invalid";
                    }
                }
                catch (Exception ex)
                {
                    lblImport.ForeColor = Color.Red;
                    lblImport.Text = "ERROR: " + ex.Message.ToString();
                }
            }
            else
            {
                lblImport.ForeColor = Color.Red;
                lblImport.Text = "You have not specified a file.";
            }

            string[] names = Path.GetFileNameWithoutExtension(sFileName).Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
            _TopCategoryName = names.Count() > 0 ? names[0] : string.Empty;
            CategoryList.RemoveAll(x => x.TopCategoryName.Trim() != _TopCategoryName.Trim());
            return sFileName;
        }

        //private void SendMessage(string message)
        //{
        //    GlobalHost.ConnectionManager.GetHubContext<ChatHub>().Clients.All.sendMessage("Finish na");
        //}

        private void Import(string filename)
        {
            try
            {
                List<PaletteContract> paletteList = new List<PaletteContract>(); 
                FileStream fs = new FileStream(filename, FileMode.Open);

                MemoryStream msFirstPass = new MemoryStream();
                string[] columns = new[] {"B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L" };

                var sldocuments = new SLDocument(fs).GetSheetNames();
                foreach( var sheetname in sldocuments )
                {
                    PhraseCategoryContract pc = CategoryList.Find(x => x.PhraseCategoryCode.Trim().Equals(sheetname.Trim(), StringComparison.OrdinalIgnoreCase));
                    if (pc != null) 
                    {
                        _SearchCategory = pc.PhraseCategoryID;
                    }
                    else
                    {
                        continue;
                    }
                    try
                    {
                        using (SLDocument sl = new SLDocument(fs, sheetname))
                        {
                            SLWorksheetStatistics ss = sl.GetWorksheetStatistics();

                            bool isEndOfRow = false;

                            int encurrentrowIndex = 2;
                            int jacurrentrowIndex = 8;
                            int chcurrentrowIndex = 14;

                    
                            int paletteid = -1;
                            int sentenceid = -1;
                            int phraseid = -1;
                            long userid = _UserId;// SessionManager.Instance.UserProfile.UserID;

                            while (!isEndOfRow)
                            {
                                PaletteContract palette = new PaletteContract();
                                palette.PaletteID = paletteid;
                                palette.PhraseCategoryID = _SearchCategory; //Convert.ToInt64(ddlSearchCategory.SelectedValue);
                                palette.CreatedBy = userid;
                                palette.SchoolID = 0;

                                Sentence ensentence = new Sentence();
                                ensentence.LanguageCode = "en-US";
                                ensentence.SentenceID = sentenceid;
                                ensentence.PaletteID = paletteid;
                                //ensentence.SoundFile //TODO
                                int enrunningrowIndex = encurrentrowIndex;
                                bool hasSentenceSoundWritten = false;
                                bool hasSentenceKeywordWritten = false;
                                int wordmapid = 1;
                                for (int j = 0; j < columns.Length; j++)
                                {
                                    Phrase p = new Phrase();
                                    p.PhraseID = phraseid;
                                    p.ImageFile = sl.GetCellValueAsString(columns[j] + enrunningrowIndex);
                                    enrunningrowIndex++;
                                    p.Word = sl.GetCellValueAsString(columns[j] + enrunningrowIndex);//.Replace("'", "''");
                                    p.WordMapID = wordmapid;
                                    if (!hasSentenceSoundWritten)
                                    {
                                        ensentence.SoundFile = sl.GetCellValueAsString("L" + enrunningrowIndex);
                                        hasSentenceSoundWritten = true;
                                    }
                                    enrunningrowIndex++;
                                    int order = 0;
                                    if (int.TryParse(sl.GetCellValueAsString(columns[j] + enrunningrowIndex).Trim(), out order))
                                    {
                                        p.Ordinal = order;    
                                    }
                            
                                    enrunningrowIndex++;
                                    p.SoundFile = sl.GetCellValueAsString(columns[j] + enrunningrowIndex);
                                    enrunningrowIndex++;
                                    p.WordType = sl.GetCellValueAsString(columns[j] + enrunningrowIndex);

                                    enrunningrowIndex++;
                                    if (!hasSentenceKeywordWritten)
                                    {
                                        p.Keyword = sl.GetCellValueAsString(columns[j] + enrunningrowIndex);
                                        ensentence.Keyword = p.Keyword;
                                        hasSentenceKeywordWritten = true;
                                    }
                                    p.SentenceID = sentenceid;
                                    enrunningrowIndex = encurrentrowIndex;
                                    if (!string.IsNullOrEmpty(p.Word) && p.Ordinal > 0)
                                    {
                                        ensentence.PhraseList.Add(p);
                                    }

                                    wordmapid++;
                                    phraseid += (-1);
                                }

                        
                                int jarunningrowIndex = jacurrentrowIndex;
                                Sentence jasentence1 = new Sentence();
                                Sentence jasentence2 = new Sentence();
                                Sentence jasentence3 = new Sentence();

                                jasentence1.LanguageCode = "ja-JP";
                                jasentence2.LanguageCode = "ja-KA";
                                jasentence3.LanguageCode = "ja-RO";

                                sentenceid += (-1);
                                jasentence1.SentenceID = sentenceid;
                                sentenceid += (-1);
                                jasentence2.SentenceID = sentenceid;
                                sentenceid += (-1);
                                jasentence3.SentenceID = sentenceid;

                                jasentence1.PaletteID = paletteid;
                                jasentence2.PaletteID = paletteid;
                                jasentence3.PaletteID = paletteid;

                                hasSentenceSoundWritten = false;
                                hasSentenceKeywordWritten = false;
                                wordmapid = 1;
                                phraseid += (-1);
                                for (int j = 0; j < columns.Length; j++)
                                {
                                    Phrase p1 = new Phrase();
                                    Phrase p2 = new Phrase();
                                    Phrase p3 = new Phrase();
                            
                                    p1.Word = sl.GetCellValueAsString(columns[j] + jarunningrowIndex);
                                    p1.WordMapID = wordmapid;
                                    p1.PhraseID += phraseid;
                                    p1.SentenceID = jasentence1.SentenceID;
                                    if (!hasSentenceSoundWritten)
                                    {
                                        jasentence1.SoundFile = sl.GetCellValueAsString("L" + jarunningrowIndex);
                                        hasSentenceSoundWritten = true;
                                    }
                                    jarunningrowIndex++;
                                    if (sl.GetCellValueAsString("A" + jarunningrowIndex).ToLower() == "other character 2(kanji)")
                                    {
                                        p2.Word = sl.GetCellValueAsString(columns[j] + jarunningrowIndex);
                                        p2.WordMapID = wordmapid;
                                        p2.SentenceID = jasentence2.SentenceID;
                                        phraseid += (-1);
                                        p2.PhraseID = phraseid;
                                    }
                                    jarunningrowIndex++;
                                    if (sl.GetCellValueAsString("A" + jarunningrowIndex).ToLower() == "other characters (romanji)")
                                    {
                                        p3.Word = sl.GetCellValueAsString(columns[j] + jarunningrowIndex);
                                        p3.WordMapID = wordmapid;
                                        p3.SentenceID = jasentence3.SentenceID;
                                        phraseid += (-1);
                                        p3.PhraseID = phraseid;
                                    }
                                    jarunningrowIndex++;
                                    int order = 0;

                                    string sorder = sl.GetCellValueAsString(columns[j] + jarunningrowIndex);
                                    int lcid = new CultureInfo("ja-JP", true).LCID;
                                    sorder = Microsoft.VisualBasic.Strings.StrConv(sorder, Microsoft.VisualBasic.VbStrConv.Narrow, lcid);

                                    if (int.TryParse(sorder, out order))
                                    {
                                        p1.Ordinal = order;
                                    }
                                    p3.Ordinal = p2.Ordinal = p1.Ordinal;
                                    jarunningrowIndex++;
                                    p1.SoundFile = sl.GetCellValueAsString(columns[j] + jarunningrowIndex);
                                    p3.SoundFile = p2.SoundFile = p1.SoundFile;

                                    //jarunningrowIndex++;
                                    p1.WordType = sl.GetCellValueAsString(columns[j] + (jarunningrowIndex-6));
                                    p3.WordType = p2.WordType = p1.WordType;

                                    jarunningrowIndex++;
                                    if (!hasSentenceKeywordWritten)
                                    {
                                        p1.Keyword = sl.GetCellValueAsString(columns[j] + jarunningrowIndex);
                                        p3.Keyword = p2.Keyword = p1.Keyword;
                                        jasentence1.Keyword = jasentence2.Keyword = jasentence3.Keyword = p1.Keyword;
                                        hasSentenceKeywordWritten = true;
                                    }

                                    jarunningrowIndex = jacurrentrowIndex;
                                    if (!string.IsNullOrEmpty(p1.Word) && p1.Ordinal > 0)
                                    {
                                        jasentence1.PhraseList.Add(p1);
                                        jasentence2.PhraseList.Add(p2);
                                        jasentence3.PhraseList.Add(p3);
                                    }

                                    wordmapid++;
                                    phraseid += (-1);
                                }

                                int chrunningrowIndex = chcurrentrowIndex;
                                Sentence chsentence1 = new Sentence();
                                Sentence chsentence2 = new Sentence();
                                Sentence chsentence3= new Sentence();

                                chsentence1.LanguageCode = "zh-CN";
                                chsentence2.LanguageCode = "zh-X";
                                chsentence3.LanguageCode = "zh-PN";

                                sentenceid += (-1);
                                chsentence1.SentenceID = sentenceid;
                                sentenceid += (-1);
                                chsentence2.SentenceID = sentenceid;
                                sentenceid += (-1);
                                chsentence3.SentenceID = sentenceid;

                                chsentence1.PaletteID = paletteid;
                                chsentence2.PaletteID = paletteid;
                                chsentence3.PaletteID = paletteid;

                                hasSentenceSoundWritten = false;
                                hasSentenceKeywordWritten = false;
                                wordmapid = 1;
                                phraseid += (-1);
                                for (int j = 0; j < columns.Length; j++)
                                {
                                    Phrase p1 = new Phrase();
                                    Phrase p2 = new Phrase();
                                    Phrase p3 = new Phrase();
                                    //p1.ImageFile = sl.GetCellValueAsString(columns[j] + chrunningrowIndex);
                                    //p3.ImageFile = p2.ImageFile = p1.ImageFile;
                                    //chrunningrowIndex++;
                                    p1.Word = sl.GetCellValueAsString(columns[j] + chrunningrowIndex);
                                    p1.WordMapID = wordmapid;
                                    p1.SentenceID = chsentence1.SentenceID;
                                    p1.PhraseID = phraseid;
                                    if (!hasSentenceSoundWritten)
                                    {
                                        chsentence1.SoundFile = sl.GetCellValueAsString("L" + chrunningrowIndex);
                                        hasSentenceSoundWritten = true;
                                    }
                                    chrunningrowIndex++;
                                    if (sl.GetCellValueAsString("A" + chrunningrowIndex).ToLower() == "other character 2")
                                    {
                                        p2.Word = sl.GetCellValueAsString(columns[j] + chrunningrowIndex);
                                        p2.WordMapID = wordmapid;
                                        p2.SentenceID = chsentence2.SentenceID;
                                        phraseid += (-1);
                                        p2.PhraseID = phraseid;
                                    }
                                    chrunningrowIndex++;
                                    if (sl.GetCellValueAsString("A" + chrunningrowIndex).ToLower() == "other characters (romanji)")
                                    {
                                        p3.Word = sl.GetCellValueAsString(columns[j] + chrunningrowIndex);
                                        p3.WordMapID = wordmapid;
                                        p3.SentenceID = chsentence3.SentenceID;
                                        phraseid += (-1);
                                        p3.PhraseID = phraseid;
                                    }
                                    chrunningrowIndex++;
                                    int order = 0;
                                    string sorder = sl.GetCellValueAsString(columns[j] + chrunningrowIndex);
                                    int lcid = new CultureInfo("ja-JP", true).LCID;
                                    sorder = Microsoft.VisualBasic.Strings.StrConv(sorder, Microsoft.VisualBasic.VbStrConv.Narrow, lcid);
                                    if (int.TryParse(sorder, out order))
                                    {
                                        p1.Ordinal = order;
                                    }
                                    p3.Ordinal = p2.Ordinal = p1.Ordinal;
                                    chrunningrowIndex++;
                                    p1.SoundFile = sl.GetCellValueAsString(columns[j] + chrunningrowIndex);
                                    p3.SoundFile = p2.SoundFile = p1.SoundFile;

                                    p1.WordType = sl.GetCellValueAsString(columns[j] + (chrunningrowIndex - 12));
                                    p3.WordType = p2.WordType = p1.WordType;

                                    chrunningrowIndex++;
                                    if (!hasSentenceKeywordWritten)
                                    {
                                        p1.Keyword = sl.GetCellValueAsString(columns[j] + chrunningrowIndex);
                                        p3.Keyword = p2.Keyword = p1.Keyword;
                                        chsentence1.Keyword = chsentence2.Keyword = chsentence3.Keyword = p1.Keyword;
                                        hasSentenceKeywordWritten = true;
                                    }
                                    chrunningrowIndex = chcurrentrowIndex;
                                    if (!string.IsNullOrEmpty(p1.Word) && p1.Ordinal > 0)
                                    {
                                        chsentence1.PhraseList.Add(p1);
                                        chsentence2.PhraseList.Add(p2);
                                        chsentence3.PhraseList.Add(p3);
                                    }

                                    wordmapid++;
                                    phraseid += (-1);
                                }

                                palette.SentenceList.AddRange(new List<Sentence>() { ensentence, jasentence1, jasentence2, jasentence3, chsentence1, chsentence2, chsentence3 });
                                encurrentrowIndex += 19;
                                jacurrentrowIndex += 19;
                                chcurrentrowIndex += 19;
                                sentenceid += (-1);
                                paletteid += (-1);
                                paletteList.Add(palette);
                                if (chcurrentrowIndex > ss.EndRowIndex)
                                    isEndOfRow = true;
                            }
                        }

                        Repository.PaletteRepository client = new Repository.PaletteRepository();
                        bool result = client.AddBulkPalette(paletteList, (_ImportAction == "0"), _SearchCategory);
                        if( result )
                        {
                            paletteList.Clear();
                        }
                        else
                        {
                            AdminLogger.ErrorLog("Error in inserting to db from sheet " + sheetname  + "--> METHOD:" + System.Reflection.MethodBase.GetCurrentMethod().Name);
                        }
                    }
                    catch (Exception ex)
                    {
                        AdminLogger.ErrorLog(ex.Message + " : " + sheetname  + "-- > METHOD:" + System.Reflection.MethodBase.GetCurrentMethod().Name);
                        throw;

                    }
                }

                ////PaletteServiceClient client = new PaletteServiceClient();
                
                //List<List<PaletteContract>> contracts = null;
                //bool isAllGone = false;
                //while(!isAllGone)
                //{
                //    contracts = paletteList.ChunkBy<PaletteContract>(500);
                //    foreach( List<PaletteContract> list in contracts )
                //    {
                //        bool result = client.AddBulkPalette(list, (_ImportAction == "0"), _SearchCategory);
                //    }
                    
                //}


                //bool result = client.AddBulkPalette(paletteList, (rdoImportActionList.SelectedValue == "0"), Convert.ToInt64(ddlSearchCategory.SelectedValue))  ;

                fs.Dispose();
                fs = null;
                msFirstPass.Dispose();
                msFirstPass = null;
                ddlSearchCategory.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

     

        protected void btnImport_OnClick(object sender, EventArgs e)
        {
            try
            {
                GetPhraseCategory();

                _UserId = SessionManager.Instance.UserProfile.UserID;
                //_SearchCategory =  Convert.ToInt64(ddlSearchCategory.SelectedValue);
                _ImportAction = rdoImportActionList.SelectedValue;
                //bool result = client.AddBulkPalette(paletteList, (rdoImportActionList.SelectedValue == "0"), Convert.ToInt64(ddlSearchCategory.SelectedValue))  ;
                string filename = Upload();
                if (!string.IsNullOrEmpty(filename))
                {
                    ImportCompletedHandler handler = new ImportCompletedHandler(Import);
                    IAsyncResult async = null;

                    async = handler.BeginInvoke(filename, new AsyncCallback(ImportCompleted), null);

                    //Import(filename);
                }
            }
            catch (Exception)
            {

                throw;
            }


        }

        private void ImportCompleted( IAsyncResult result )
        {
            ClientScript.RegisterStartupScript(this.GetType(), "testing lang to", "alert('testing lang to')");
        }

        protected void rdoAction_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdoAction.SelectedValue == "1") //export
            {
                btnExport.Visible = true;
                btnImport.Visible = false;
                lblSelectFile.Visible = false;
                fuExcelUploader.Visible = false;
                lblImport.Visible = false;
                lblCategory.Visible = true;
                ddlSearchCategory.Visible = true;
                CompareValidator1.Visible = true;
                rdoImportActionList.Visible = false;
            }
            else //import
            {
                btnExport.Visible = false;
                btnImport.Visible = true;
                lblSelectFile.Visible = true;
                fuExcelUploader.Visible = true;
                lblCategory.Visible = false;
                ddlSearchCategory.Visible = false;
                CompareValidator1.Visible = false;
                rdoImportActionList.Visible = true;
            }
        }
    }

    public static class Extensions
    {
        public static List<List<T>> ChunkBy<T>(this List<T> source, int chunkSize)
        {
            return source
                .Select((x, i) => new { Index = i, Value = x })
                .GroupBy(x => x.Index / chunkSize)
                .Select(x => x.Select(v => v.Value).ToList())
                .ToList();
        }
    }
}