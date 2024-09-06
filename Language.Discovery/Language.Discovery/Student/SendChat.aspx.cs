﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.PhraseCategoryService;
using System.Web.Script.Serialization;
using Language.Discovery.PaletteService;
using Language.Discovery.UserService;
using Language.Discovery.SchoolService;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Data;
using System.IO;


namespace Language.Discovery
{
    public partial class SendChat : System.Web.UI.Page
    {
        
        private int m_SentenceRowPerPage = Convert.ToInt32(ConfigurationManager.AppSettings["SentenceRowsPerPage"]);
        private int m_WordRowPerPage = Convert.ToInt32(ConfigurationManager.AppSettings["WordRowsPerPage"]);

        protected override void InitializeCulture()
        {
            if (SessionManager.Instance.UserProfile == null)
            {
                Response.Redirect("~/Logout");
                return;
            }
            UICulture = SessionManager.Instance.UserProfile.NativeLanguage;

            base.InitializeCulture();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    string dst = Request.QueryString["dst"];
                    if (!string.IsNullOrEmpty(dst) && dst == "1")
                    {
                        if (new UserClient().UpdateUserDontShowNewTab(SessionManager.Instance.UserProfile.UserID, true))
                            SessionManager.Instance.UserProfile.DontShowNewTab = true;
                    }
                    PopulateDropDownList();
                    LoadSenderDetails();
                    LoadToDetails();
                    CreateSuggestion();
                    hdnNativeLanguageCode.Value = SessionManager.Instance.UserProfile.NativeLanguage;
                    hdnLearningLanguageCode.Value = SessionManager.Instance.UserProfile.LearningLanguage;
                    SetOptions();

                    SearchWords();
                    SearchSentence();
                    BindFriends("");
                    GetUserMessage();

                    if (OnlineUser.OnlineUserList.Where(item => item.SessionID == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).Count() > 0)
                        OnlineUser.OnlineUserList.Remove(OnlineUser.OnlineUserList.Where(item => item.SessionID == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).FirstOrDefault());

                    ChatUser user = new ChatUser()
                    {
                        UserID = SessionManager.Instance.UserProfile.UserID,
                        UserName = SessionManager.Instance.UserProfile.UserName,
                        SessionID = HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString(),
                        IsOnline = true
                    };
                    OnlineUser.Add(user);
                    hdnCurrentUserID.Value = SessionManager.Instance.UserProfile.UserID.ToString();
                    hdnCurrentAvatar.Value = SessionManager.Instance.UserProfile.Avatar.Length > 0 ? "../Images/avatar/" + SessionManager.Instance.UserProfile.Avatar : "../Images/no_avatar.png"; 

                     //string script = "$(function () {";
                     //script += "$('#tabs').tabs();});";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearSessionStoragescript", "ClearSessionStorage();", true);
                }
                this.Form.DefaultButton = imgSearchSentence.UniqueID;
                this.Form.DefaultFocus = txtSearchSentence.UniqueID;
            }
            catch (Exception)
            {

                throw;
            }

        }

        private void SetOptions()
        {
            if (SessionManager.Instance.UserProfile.NativeLanguage == "ja-JP")
            {
                //data-on="info" data-off="danger" data-on-label="ENG" data-off-label="JP">
                divRomanji.Visible = false;
                divorder.Attributes["data-on"] = "danger";
                divorder.Attributes["data-off"] = "info";
                divorder.Attributes["data-on-label"] = "JP";
                divorder.Attributes["data-off-label"] = "EN";

                //divShowTranslation.Attributes["data-on-label"] = "<i class='icon-ok icon-white'><img src='../Images/en-US.png' style='width:16x;height;16px;'/></i>";
                //divShowTranslation.Attributes["data-off-label"] = "<i class='icon-ok icon-white'><img src='../Images/ja-JP.png' style='width:16x;height;16px;'/></i>";
            }
            else
            {
                divRomanji.Visible = true;
            }
            if (!SessionManager.Instance.SchoolProfile.ShowPhraseOrder)
            {
                chkSequence.Checked = SessionManager.Instance.SchoolProfile.ShowPhraseOrder;
                chkSequence.Attributes.Add("disabled", "disabled");
            }
            if (!SessionManager.Instance.SchoolProfile.ShowNativeLanguage)
            {
                chkNative.Checked = SessionManager.Instance.SchoolProfile.ShowNativeLanguage;
                chkNative.Attributes.Add("disabled", "disabled");
            }
            if (SessionManager.Instance.SchoolProfile.ShowSubLanguage2)
            {
                chkSubLanguage2.Checked = SessionManager.Instance.SchoolProfile.ShowSubLanguage2;
                //chkNative.Attributes.Add("disabled", "disabled");
            }

            //chkLanguageOrder.Checked = (SessionManager.Instance.SchoolProfile.DefaultLanguageOrder != SessionManager.Instance.UserProfile.LearningLanguage);
                
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (rdoCriteriaList.SelectedValue == "0")//All
                {
                    SearchWords();
                    SearchSentence();
                }
                else if (rdoCriteriaList.SelectedValue == "1")//Word
                {
                    UpdatePanel2.Triggers.RemoveAt(1);
                    SearchWords();
                }

                //SearchWords();
                //SearchSentence();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void LoadSenderDetails()
        {
            try
            {
                UserContract user = null;
                string json = new UserClient().GetUserDetails(SessionManager.Instance.UserProfile.UserID);
                if (!string.IsNullOrEmpty(json))
                {
                   user = new JavaScriptSerializer().Deserialize<UserContract>(json);
                   //lblFromName.Text = user.FirstName;
                   //imgFrom.ImageUrl = "../Images/Avatar/" + user.Avatar;
                }

            }
            catch (Exception ex)
            {
               throw;
            }
        }

        private void LoadToDetails()
        {
            try
            {
                if (!string.IsNullOrEmpty(Request.QueryString["grp"]))
                {
                    ViewState["UserTo"] = Request.QueryString["grp"];
                    //lblToName.Text = "Group";
                    //imgTo.ImageUrl = "../Images/groupavatar.png";
                    return;

                }
                UserContract user = null;
                long userid = !string.IsNullOrEmpty(Request.QueryString["to"]) ? Convert.ToInt64(Request.QueryString["to"]) : 0;
                if (userid == 0)
                    return;

                string json = new UserClient().GetUserDetails(userid);
                if (!string.IsNullOrEmpty(json))
                {
                    user = new JavaScriptSerializer().Deserialize<UserContract>(json);
                    //lblToName.Text = user.FirstName;
                    //imgTo.ImageUrl = "../Images/Avatar/" + user.Avatar;
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private void PopulateDropDownList()
        {
            try
            {
                PhraseCategoryServiceClient pclient = new PhraseCategoryServiceClient();
                string json = pclient.GetPhraseCategory(SessionManager.Instance.UserProfile.NativeLanguage, SessionManager.Instance.UserProfile.LevelID, SessionManager.Instance.UserProfile.SchoolID);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                plist.Insert (0,new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[All]" });
                ddlCategory.DataSource = plist;
                ddlCategory.DataTextField = "PhraseCategoryCode";
                ddlCategory.DataValueField = "PhraseCategoryID";
                ddlCategory.DataBind();

                Random next = new Random();
                int index = next.Next(1, plist.Count - 1);
                ddlCategory.SelectedIndexChanged -=ddlCategory_SelectedIndexChanged;
                ddlCategory.SelectedValue = plist[index].PhraseCategoryID.ToString();
                ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;



            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private int CreateWordList()
        {
            try
            {
        
                PaletteServiceClient pclient = new PaletteServiceClient();
                int virtualcount = 0;
                //string json = pclient.SearchWord(new SearchDTO() { SchoolID= SessionManager.Instance.UserProfile.SchoolID, CategoryID = Convert.ToInt64( ddlCategory.SelectedValue ), Keyword = txtSearchSentence.Text, PageNumber = Convert.ToInt32(hdnwordpage.Value), RowsPerPage = m_WordRowPerPage }, out virtualcount);
                string json = pclient.SearchWord(new SearchDTO() { SchoolID = SessionManager.Instance.UserProfile.SchoolID, CategoryID = 0, Keyword = txtSearchSentence.Text, PageNumber = Convert.ToInt32(hdnwordpage.Value), RowsPerPage = m_WordRowPerPage }, out virtualcount);
                List<WordContract> list = new JavaScriptSerializer().Deserialize<List<WordContract>>(json);

                string words = string.Empty;

                HtmlGenericControl parentul = new HtmlGenericControl("ul");
                parentul.Attributes.Add("class", "items2");

                var pnativelist = list.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage)).ToList();
                var plearninglist = list.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).ToList();
                var psubnativelist = list.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();
                var psubnative2list = list.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage2)).ToList();

                foreach (WordContract wc in pnativelist)
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");

                    string subnative2word = string.Empty;
                    string subnative2code = string.Empty;

                    var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(wc.WordMapID));

                    if (sub2 != null)
                    {
                        subnative2word = sub2.Word;
                        subnative2code = sub2.LanguageCode.Substring(0, 2);
                    }


                    int count = 1;
                    string dimage = "data-image='../Content/images/" + wc.ImageFile + "' ";
                    if (string.IsNullOrEmpty(wc.ImageFile))
                        dimage = string.Empty;

                    words = string.Format("<span id='{0}' class='firstword' data-lang='{1}' data-switchword='{2}' data-word='{3}' {4}>", "divspanword" + wc.WordID.ToString(), wc.LanguageCode, wc.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", wc.Word, dimage) + wc.Word + "</span>" + "<br/>";

                    var learn = plearninglist.Find(x => x.WordMapID.Equals(wc.WordMapID));
                    if (learn != null)
                    {
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5}>", "divspanword" + learn.WordID.ToString(), cl, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage) + learn.Word + "</span>" + "<br/>";
                    }

                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(wc.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}'>", "divspan" + sub.WordID.ToString(), cl) + sub.Word + "</span>" + "<br/>";
                    }

                    string datasound = string.Empty;
                    if (learn != null)
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";


                    string div = string.Format("<div id=\"div{0}\" class=\"screenshot wordbox\" style=\"border:1px solid black;text-align:center;background-color:white;cursor:pointer;position:relative;\" data-isword=\"true\" ondblclick=\"worddblClick('div{0}');\" onclick=\"wordClick('div{0}', false);\" data-image=\"../Content/images/" + wc.ImageFile + "\" {2} >" +
                        (wc.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + wc.ImageFile + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; position:absolute;top:-5px;left:-5px;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                                "{1}" +
                                "</div>", wc.WordID.ToString() + learn.WordID.ToString() + (sub == null ? string.Empty : sub.WordID.ToString()), words, datasound);
                    li.InnerHtml = div;
                    parentul.Controls.Add(li);
                }
                divWordContainer.Controls.Add(parentul);

                return virtualcount;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void CreateWordListBackup()
        {
            try
            {
                PaletteServiceClient pclient = new PaletteServiceClient();

                string json = "";//pclient.SearchWord(new SearchDTO() { Keyword=txtSearchSentence.Text, PageNumber = 1, RowsPerPage = 10 }, out );
                List<WordContract> list = new JavaScriptSerializer().Deserialize<List<WordContract>>(json);

                string words = string.Empty;

                HtmlGenericControl parentul = new HtmlGenericControl("ul");
                parentul.Attributes.Add("class", "items2");

                

                foreach (WordContract wc in list)
                {
                    HtmlGenericControl li = new HtmlGenericControl("li");

                    int count = 1;
                    words = string.Format("<span id='{0}' class='firstword'>", "divspanword" + wc.WordID.ToString() ) + wc.Word + "</span>" + "<br/>";
                    foreach (WordContract w in wc.WordList)
                    {
                        count++;
                        if (count == 2)
                        {
                            string cl = "secondword";
                            words += string.Format("<span id='{0}' class='{1}'>", "divspanword" + w.WordID.ToString() + count.ToString(),cl) + w.Word + "</span>" + "<br/>";
                        }
                        if (count == 3)
                        {
                            string cl = "thirdword";
                            words += string.Format("<span id='{0}' class='{1}'>", "divspan" +  w.WordID.ToString() + count.ToString(),cl) + w.Word + "</span>" + "<br/>";
                        }
                    }


                    string div = string.Format("<div id=\"div{0}\" class=\"screenshot\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;width:200px;\" ondblclick=\"worddblClick('div{0}', false);\" data-image=\"http://localhost:50835/Content/images/" + wc.ImageFile + "\" >" +
                                "{1}" +
                        "</div>", wc.WordID,  words);
                    li.InnerHtml = div;
                    parentul.Controls.Add(li);
                }
                divWordContainer.Controls.Add(parentul);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void CreateSuggestion()
        {


            PaletteServiceClient pclient = new PaletteServiceClient();
            string json = pclient.GetPaletteSuggestion();
            List<PaletteContract> list = null;
            //object result = null;
            //if (json.ToLower().Contains("dataset"))
            //{
            //    DataSet ds = new DataSet();
            //    StringReader reader = new StringReader(json);
            //    ds.ReadXml(reader);
            //    result = ds;
            //}
            //else
            //{
                list = new JavaScriptSerializer().Deserialize<List<PaletteContract>>(json);

            //}

            List<PaletteContract> finallist = new List<PaletteContract>();
            List<Phrase> phraseList = new List<Phrase>();
            string div = string.Empty;

            HtmlGenericControl parentul = new HtmlGenericControl("ul");
            //parentul.Attributes.Add("class", "items");
            //<ul>
            //    <li>
            //        <ul>
            //            <li></li>
            //            <li></li>
            //            <li></li>
            //        </ul>
            //    </li>
            //    <li>
            //        <ul>
            //            <li></li>
            //            <li></li>
            //            <li></li>
            //        </ul>
            //    </li>
            //</ul>   
            string nativesentence = "";
            string learningsentence = "";
            //if (result != null)
            //{
            //    DataSet ds = (DataSet)result;

            //    LiteralControl lit = new LiteralControl();
            //    lit.Text = ds.Tables[0].Rows[0]["Sentence1"].ToString();
            //    divDisplaySuggestion.Controls.Add(lit);
            //    divSuggestion.Controls.Add(parentul);
            //    return;
            //} 

            foreach (PaletteContract paleteContract in list)
            {
                HtmlGenericControl parentli = new HtmlGenericControl("li");

                PaletteContract pcontract = new PaletteContract();
                pcontract.PaletteID = paleteContract.PaletteID;
                pcontract.SchoolID = paleteContract.SchoolID;
                pcontract.PhraseCategoryID = paleteContract.PhraseCategoryID;
                pcontract.DefaultLanguageCode = paleteContract.DefaultLanguageCode;

                HtmlGenericControl childul = new HtmlGenericControl("ul");

                var pnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage)).OrderBy(x => x.Ordinal).ToList();
                var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).ToList();
                var psubnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();
                var psubnative2list = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage2)).ToList();

                string words = string.Empty;
                string sentence1ordinal = "";
                string sentence2ordinal = "";
                string sounds = "";

                foreach (Phrase p in pnativelist)
                {
                    nativesentence += p.Word + "&nbsp;";
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    sounds += p.SoundFile + ",";

                    string subnative2word = string.Empty;
                    string subnative2code = string.Empty;

                    var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(p.WordMapID));

                    if (sub2 != null)
                    {
                        subnative2word = sub2.Word;
                        subnative2code = sub2.LanguageCode.Substring(0, 2);
                    }

                    int count = 1;
                    string dimage = "data-image='../Content/images/" + p.ImageFile + "' ";
                    if (string.IsNullOrEmpty(p.ImageFile))
                        dimage = string.Empty;

                    words = string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6}>", "divspan" + p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString() + count.ToString(),
                        p.Ordinal.ToString(), "../Content/Sound/" + p.SoundFile, p.LanguageCode, p.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", p.Word, dimage) + p.Word + "</span>" + "<br/>";
                    sentence1ordinal += p.Ordinal.ToString() + ",";

                    var learn = plearninglist.Find(x => x.WordMapID.Equals(p.WordMapID));
                    if (learn != null)
                    {
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + learn.PalleteID.ToString() + learn.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + count.ToString(),
                            cl, learn.Ordinal.ToString(), "../Content/Sound/" + learn.SoundFile, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage) + learn.Word + "</span>" + "<br/>";
                        sentence2ordinal += learn.Ordinal.ToString() + ",";
                        learningsentence += learn.Word + "&nbsp;";
                    }
                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(p.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}'>", "divspan" + sub.PalleteID.ToString() + sub.SentenceID.ToString() + p.Ordinal.ToString() + sub.Ordinal.ToString() + count.ToString(),
                           cl, sub.Ordinal.ToString()) + sub.Word + "</span>" + "<br/>";
                    }

                    string dataimage = "data-image='../Content/images/" + p.ImageFile + "' ";
                    //string datasound = "<span id='sound' class='mp3'>"+ "http://localhost:50835/Content/images/" + p.ImageFile + "</span>'"; 
                    string datasound = string.Empty;
                    if( learn != null )
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";

                    string cssclass = "class='screenshot'";
                    //string datagrouping = "data-elementgrouping='sentence_" + p.SentenceID.ToString() + "'";
                    if (string.IsNullOrEmpty(p.ImageFile))
                    {
                        cssclass = string.Empty;
                        dataimage = string.Empty;
                    }
                    div = string.Format("<div id=\"div{0}\" class=\"suggestion\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;padding-left:10px;padding-bottom:2px;\" data-isword=\"false\" ondblclick='worddblClick(\"div{0}\")'  onclick=\"wordClick('div{0}', true);\" {3} {4}>" +
                    (p.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + p.ImageFile + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; left:0;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                    "<img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; float:right;\"/>" +
                    "{2}" +
                    "</div>", p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString(), p.Ordinal.ToString(), words, dataimage, datasound);

                    li.InnerHtml = div;

                    childul.Controls.Add(li);
                }

                childul.Attributes.Add("data-sentence1Ordinal", sentence1ordinal);
                childul.Attributes.Add("data-sentence2Ordinal", sentence2ordinal);

                //parentli.Attributes.Add("class", "pallete");
                parentli.Controls.Add(childul);
                parentul.Controls.Add(parentli);
            }

            LiteralControl lit = new LiteralControl();
            lit.Text = nativesentence;
            divDisplaySuggestion.Controls.Add(lit);
            divSuggestion.Controls.Add(parentul);

            StringBuilder builder = new StringBuilder();
            builder.AppendLine("$(function ()");
            builder.AppendLine("{");
            //builder.AppendLine("$('ul.items').easyPaginate({step:5});");
            //builder.AppendLine("$('.sortable').sortable().disableSelection();;HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable();");
            builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable();");
            //builder.AppendLine("$('.sortable').sortable();HideShowWords('#chkNative', '.secondword'); HideShowWords('#chkSecondary', '.thirdword'); screenshotPreview();SetPalleteSelectable();");
            builder.AppendLine("});");

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateSuggestion", builder.ToString(), true);


        }
        private int CreatePalleteList()
        {

            
            //PaletteServiceClient pclient = new PaletteServiceClient();
            //SearchDTO dto = new SearchDTO() { SchoolID= SessionManager.Instance.UserProfile.SchoolID, CategoryID = Convert.ToInt32(ddlCategory.SelectedValue), Keyword = txtSearchSentence.Text, LevelID = SessionManager.Instance.UserProfile.LevelID, PageNumber = Convert.ToInt32(hdnsentencepage.Value), RowsPerPage = m_SentenceRowPerPage };
            //int virtualcount = 0;

            PaletteServiceClient pclient = new PaletteServiceClient();
            SearchDTO dto = null;
            if (rdoCriteriaList.SelectedValue == "1") //Word
            {

                dto = new SearchDTO()
                {
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID,
                    CategoryID = Convert.ToInt32(ddlCategory.SelectedValue),
                    Keyword = string.Empty, //string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty ,
                    LevelID = SessionManager.Instance.UserProfile.LevelID,
                    PageNumber = Convert.ToInt32(hdnsentencepage.Value),
                    RowsPerPage = m_SentenceRowPerPage
                };
            }
            else //Phrase+word
            {
                dto = new SearchDTO()
                {
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID,
                    CategoryID = Convert.ToInt32(ddlCategory.SelectedValue),
                    Keyword = txtSearchSentence.Text,
                    LevelID = SessionManager.Instance.UserProfile.LevelID,
                    PageNumber = Convert.ToInt32(hdnsentencepage.Value),
                    RowsPerPage = m_SentenceRowPerPage
                };
            }
            int virtualcount = 0;

            List<PaletteContract> list = pclient.Search(dto, out virtualcount).ToList();
            
            //List < PaletteContract > list = pclient.Search(dto, out virtualcount).ToList();
            

            List<PaletteContract> finallist = new List<PaletteContract>();
            List<Phrase> phraseList = new List<Phrase>();
            string div = string.Empty;

            HtmlGenericControl parentul = new HtmlGenericControl("ul");
            parentul.Attributes.Add("class", "items");
            //<ul>
            //    <li>
            //        <ul>
            //            <li></li>
            //            <li></li>
            //            <li></li>
            //        </ul>
            //    </li>
            //    <li>
            //        <ul>
            //            <li></li>
            //            <li></li>
            //            <li></li>
            //        </ul>
            //    </li>
            //</ul>   
            foreach (PaletteContract paleteContract in list)
            {
                HtmlGenericControl parentli = new HtmlGenericControl("li");

                PaletteContract pcontract = new PaletteContract();
                pcontract.PaletteID = paleteContract.PaletteID;
                pcontract.SchoolID = paleteContract.SchoolID;
                pcontract.PhraseCategoryID = paleteContract.PhraseCategoryID;
                pcontract.DefaultLanguageCode = paleteContract.DefaultLanguageCode;

                HtmlGenericControl childul = new HtmlGenericControl("ul");


                var pnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage)).ToList();
                var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();
                var psubnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();
                var psubnative2list = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage2)).ToList();

                //var pfakelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();

                string words = string.Empty;
                string sentence1ordinal = "";
                string sentence2ordinal = "";
                string sounds = "";
                long sentenceid = 0;
                foreach (Phrase learn in plearninglist)
                {

                    var p = pnativelist.Find(x => x.WordMapID.Equals(learn.WordMapID));
                    HtmlGenericControl li = new HtmlGenericControl("li");
                    sounds += p.SoundFile + ",";
                    int count = 1;
                    string subnative2word = string.Empty;
                    string subnative2code = string.Empty;

                    var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(learn.WordMapID));

                    if (sub2 != null)
                    {
                        subnative2word = sub2.Word;
                        subnative2code = sub2.LanguageCode.Substring(0,2);
                    }
                    //"data-image='../Content/images/" + p.ImageFile + "' "
                    string dimage = "data-image='../Content/images/" + p.ImageFile + "' ";
                    if (string.IsNullOrEmpty(p.ImageFile))
                        dimage = string.Empty;
                    words = string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6}>", "divspan" + p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString() + count.ToString(),
                        p.Ordinal.ToString(), "../Content/Sound/" + p.SoundFile, p.LanguageCode, p.LanguageCode.Substring(0,2) == subnative2code ? subnative2word : "",p.Word, dimage) + p.Word + "</span>" + "<br/>";
                    sentence1ordinal += p.Ordinal.ToString() + ",";
                    
                    if (p != null)
                    {
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + learn.PalleteID.ToString() + learn.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + count.ToString(),
                            cl, learn.Ordinal.ToString(), "../Content/Sound/" + learn.SoundFile, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage) + learn.Word + "</span>" + "<br/>";
                        
                        sentence2ordinal += learn.Ordinal.ToString() + ",";
                        
                    }
                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(learn.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}'>", "divspan" + sub.PalleteID.ToString() + sub.SentenceID.ToString() + p.Ordinal.ToString() + sub.Ordinal.ToString() + count.ToString(),
                           cl, sub.Ordinal.ToString()) + sub.Word + "</span>" + "<br/>";
                    }
                    
                    //if (sub2 != null)
                    //{
                    //    string cl = "fourthword";
                    //    words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' style='display:none;left:-1000px;top:-1000px;position:absolute;'>", "divspan" + sub2.PalleteID.ToString() + sub2.SentenceID.ToString() + p.Ordinal.ToString() + sub2.Ordinal.ToString() + count.ToString(),
                    //       cl, sub2.Ordinal.ToString()) + sub2.Word + "</span>" + "<br/>";
                    //}

                    //var fake = pfakelist.Find(x => x.WordMapID.Equals(learn.WordMapID));
                    //if (fake != null)
                    //{
                    //    string cl = "fakewords";
                    //    words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' style='display:none;'>", "divspan" + fake.PalleteID.ToString() + fake.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + count.ToString(),
                    //        cl, fake.Ordinal.ToString(), "../Content/Sound/" + p.SoundFile) + p.Word + "</span>" + "<br/>";
                    //}



                    string dataimage = "data-image='../Content/images/" + p.ImageFile + "' ";
                    //string datasound = "<span id='sound' class='mp3'>"+ "http://localhost:50835/Content/images/" + p.ImageFile + "</span>'"; 
                    string datasound = string.Empty;
                    if( learn != null )
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";

                    string cssclass = "class='screenshot'";
                    string datagrouping = "data-elementgrouping='sentence_" + p.SentenceID.ToString() + "'";
                    if (string.IsNullOrEmpty(p.ImageFile))
                    {
                        cssclass = string.Empty;
                        dataimage = string.Empty;
                    }
                    
                    string imagesequence = "<img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; position:absolute;top:-5px;right:-5px;\"/>";
                    if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
                    {
                        imagesequence = "<img class='imgsequence' src=\"../Images/red{1}.png\" style=\"width:20px; height:20px; position:absolute;top:-5px;right:-5px;\"/>";    
                    }

                    div = string.Format("<div id=\"div{0}\" {4} style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;padding-left:10px;padding-bottom:2px;position:relative;\" data-isword=\"false\" ondblclick='worddblClick(\"div{0}\")'  onclick=\"wordClick('div{0}', true);\" {3} {5} {6}>" +
                    (p.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + p.ImageFile + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; position:absolute;top:-5px;left:-5px;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                    imagesequence +
                    "{2}" +
                    "</div>", p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString(), learn.Ordinal.ToString(), words, dataimage, cssclass, datasound, datagrouping);
                    //"<span style='float:right;'><img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; float:right;\" onclick=\"alert('bong');\"/><span>" +
                    li.Attributes.Add("data-ordinalNative", p.Ordinal.ToString());

                    li.Attributes.Add("data-ordinalLearning", p != null ? learn.Ordinal.ToString() : "0");
                    li.InnerHtml = div;
                
    
                    childul.Controls.Add(li);
                    sentenceid = p.SentenceID;
                }

                string soundfile = string.Empty;

                var sentence = paleteContract.SentenceList.Find(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage) && x.PaletteID.Equals(paleteContract.PaletteID));

                //var sentence = paleteContract.SentenceList.Find(x => x.SentenceID.Equals(sentenceid));

                if (sentence != null)
                {
                    soundfile = sentence.SoundFile;
                }

                LiteralControl sound = new LiteralControl();
                sound.Text = "<img src=\"../Images/ICO_Speaker.png\" class=\"soundicon\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;\" onclick=\"playsoundnow(this,'" + soundfile + "');\" data-sound='" + soundfile + "'/>";
                if( soundfile.Length > 0  )
                    childul.Controls.Add(sound);

                childul.Attributes.Add("data-sentence1Ordinal", sentence1ordinal);
                childul.Attributes.Add("data-sentence2Ordinal", sentence2ordinal);
                childul.Attributes.Add("style", "padding:0px;");

                parentli.Attributes.Add("class", "pallete");
                
                parentli.Controls.Add(childul);
                parentul.Controls.Add(parentli);
            }


            sentenceContainer.Controls.Add(parentul);

            return virtualcount;

        }
        

        protected void imgSearchSentence_Click(object sender, ImageClickEventArgs e)
        {
            //DataTable dt = new DataTable();
            //dt.Columns.Add(new DataColumn("name1", typeof(string)));
            //dt.Columns.Add(new DataColumn("name2", typeof(string)));
            //for (int i = 0; i < 10; i++)
            //{
            //    DataRow row = dt.NewRow();
            //    row["name1"] = "bong" + i.ToString();
            //    row["name2"] = "bong" + (i*2).ToString();
            //    dt.Rows.Add(row);
            //}
            //Repeater1.DataSource = dt;
            //Repeater1.DataBind();

            if( txtSearchSentence.Text.Length > 0 && ddlCategory.SelectedIndex > 0 )
                ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
         
            
            if (rdoCriteriaList.SelectedValue == "0")//All
            {
                SearchWords();
                SearchSentence();
            }
            else if (rdoCriteriaList.SelectedValue == "1")//Word
            {
                UpdatePanel2.Triggers.RemoveAt(0);
                SearchWords();
            }


            if (txtSearchSentence.Text.Length > 0)
                ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();", true);
            //UpdatePanel1.Update();
        }

        private void SearchSentence()
        {
            int virtualcount = CreatePalleteList();
            int numberofpages = virtualcount / m_SentenceRowPerPage;
            if (virtualcount % m_SentenceRowPerPage > 0)
                numberofpages++;

            if (numberofpages <= 0)
                numberofpages = 0;

            //if (numberofpages <= m_SentenceRowPerPage)
            //    numberofpages = 0;
            StringBuilder builder = new StringBuilder();
            builder.AppendLine("$(function ()");
            builder.AppendLine("{");
            //builder.AppendLine("$('ul.items').easyPaginate({step:5});");
            //builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable(); HideShowSequence('#" + chkSequence.ClientID + "');SwitchLanguageOrder('.chkLanguageOrder');SwitchWords('.chkSubLanguage2');");
            builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable(); HideShowSequence('#" + chkSequence.ClientID + "');SwitchWords('.chkSubLanguage2');");
            //builder.AppendLine("$('.sortable').sortable();HideShowWords('#chkNative', '.secondword'); HideShowWords('#chkSecondary', '.thirdword'); screenshotPreview();SetPalleteSelectable();");
            int pagenumber = Convert.ToInt32(hdnsentencepage.Value);

            builder.AppendFormat("ActivateSentencePaging({0},{1});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString()); ;
            builder.AppendLine("});");

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreatePalleteList", builder.ToString(), true);
            UpdatePanel2.Update();
        }


        private void SearchWords()
        {
            int virtualcount = CreateWordList();
            int numberofpages = virtualcount / m_WordRowPerPage;
            if (virtualcount % m_WordRowPerPage > 0)
                numberofpages++;

            if (numberofpages <= 0)
               numberofpages = 0;
            StringBuilder builder = new StringBuilder();
            builder.Clear();
            builder.AppendLine("$(function ()");
            builder.AppendLine("{");
            //builder.AppendLine("$('ul.items2').easyPaginate({step:2});");
            builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); HideShowSequence('#" + chkSequence.ClientID + "');");
            int pagenumber = Convert.ToInt32(hdnwordpage.Value);
            builder.AppendFormat("ActivateWordPaging({0},{1});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString()); ;
            builder.AppendLine("});");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateWordList", builder.ToString(), true);
            UpdatePanel1.Update();

        }

        //protected void imgSearchWord_Click(object sender, ImageClickEventArgs e)
        //{
        //    //System.Threading.Thread.Sleep(2000);
        //    CreateWordList();
        //    StringBuilder builder = new StringBuilder();
        //    builder.AppendLine("$(function ()");
        //    builder.AppendLine("{");
        //    builder.AppendLine("$('ul.items2').easyPaginate({step:2});");
        //    builder.AppendLine("HideShowWords('#chkNative', '.secondword'); HideShowWords('#chkSecondary', '.thirdword');" );
        //    builder.AppendLine("});");
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "testets", builder.ToString(), true);
        //    UpdatePanel2.Update();
        //}

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {

                SendToGroup();

                //string learningsentence = hdnLearning.Value;
                //string nativesentence = hdnNative.Value;

                //string[] ls = learningsentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                //string[] ns = nativesentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

               

                //UserMessageContract umc = new UserMessageContract();
                //for (int i = 0; i < ls.Count(); i++)
                //{
                
                //    umc.SenderID = SessionManager.Instance.UserProfile.UserID;
                //    umc.RecepientID = !string.IsNullOrEmpty(Request.QueryString["to"]) ? Convert.ToInt64(Request.QueryString["to"]) : 0;
                //    umc.LearningLanguageMessage += Server.HtmlEncode(ls[i] + "<br/>");
                //    umc.NativeLanguageMessage += Server.HtmlEncode(ns[i] + "<br/>");
                //    umc.Subject = txtSubject.Text;
                    
                //}

                //UserClient client = new UserClient();
                //string json = new JavaScriptSerializer().Serialize(umc);
                //bool saved = client.SaveMessage(json);
                //if (saved)
                //{
                //    Response.Redirect("MailBox");
                //}
                
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void SendToGroup()
        {
            //btnSend.Enabled = false;
            string learningsentence = hdnLearning.Value;
            string nativesentence = hdnNative.Value;

            string[] ls = learningsentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            string[] ns = nativesentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

            List<UserMessageContract> msgList = new List<UserMessageContract>();
            List<long> userids = new List<long>();
            if (ViewState["UserTo"] != null)
            {
                string userto = ViewState["UserTo"].ToString();
                userids = userto.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(long.Parse).ToList();

            }
            else
            {
                userids.Add(!string.IsNullOrEmpty(Request.QueryString["to"]) ? Convert.ToInt64(Request.QueryString["to"]) : 0);
            }

            foreach (int userid in userids)
            {
                UserMessageContract umc = new UserMessageContract();
                for (int i = 0; i < ls.Count(); i++)
                {

                    umc.SenderID = SessionManager.Instance.UserProfile.UserID;
                    umc.RecepientID = userid;
                    umc.LearningLanguageMessage += Server.HtmlEncode(ls[i] + "<br/>");
                    umc.NativeLanguageMessage += Server.HtmlEncode(ns[i] + "<br/>");
                    //umc.Subject = txtSubject.Text;

                }

                msgList.Add(umc);
            }
            //string s = Utility.SerializeObjectToXML(msgList);

            UserClient client = new UserClient();
            string json = new JavaScriptSerializer().Serialize(msgList);
            long[] ids = client.SaveMessage(json);
            if (ids !=null)
            {
                //Response.Redirect("MailBox");
            }
        }

        protected void btnSearchSentence_Click(object sender, EventArgs e)
        {
            try
            {
                SearchSentence();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();", true);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        protected void btnSearchWord_Click(object sender, EventArgs e)
        {
            try
            {
                SearchWords();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void rptConversation_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Object item = e.Item.DataItem;
                if (item == null)
                    return;

                Image you = (Image)e.Item.FindControl("imgAvatarYou");
                Image me = (Image)e.Item.FindControl("imgAvatarMe");
                Image imgLikeMessage = (Image)e.Item.FindControl("imgLikeMessage");
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trMessage");

                UserMessageContract u = (UserMessageContract)e.Item.DataItem;

                //you.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/avatar/no_avatar.png";
                //me.ImageUrl = u.RecepientAvatar.Length > 0 ? "../Images/avatar/" + u.RecepientAvatar : "../Images/avatar/no_avatar.png";
                if (tr != null && u.ReadDate == DateTime.MinValue && !u.IsReply)
                {
                    tr.Attributes.Add("class", "message");
                }

                if (u.IsReply)
                {
                    //you.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/avatar/no_avatar.png";
                    me.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/no_avatar.png";
                    you.Visible = false;
                    me.Visible = true;
                }
                else
                {
                    you.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/no_avatar.png";
                    //me.ImageUrl = u.RecepientAvatar.Length > 0 ? "../Images/avatar/" + u.RecepientAvatar : "../Images/avatar/no_avatar.png";

                    you.Visible = true;
                    me.Visible = false;
                }

                if (u.IsLike)
                {
                    string origurl = imgLikeMessage.ImageUrl;
                    imgLikeMessage.ImageUrl = imgLikeMessage.Attributes["data-swap"];
                    imgLikeMessage.Attributes["data-swap"] = origurl;
                }
            }
        }
        private void GetUserMessage()
        {
            try
            {
                //divUser.Attributes.Remove("style");
                long userid = Convert.ToInt64(hdnSelectedUserID.Value);
                //string name = hdnName.Value;
                UserClient client = new UserClient();
                ////string json = client.SearchPeople(0, 0, "Friends", name, SessionManager.Instance.UserProfile.UserID);
                ////List<PeopleSearchContract> people = new JavaScriptSerializer().Deserialize<List<PeopleSearchContract>>(json);

                //string json = client.GetUserDetails(userid);
                //UserContract people = new JavaScriptSerializer().Deserialize<UserContract>(json);

                //if (people != null) //&& people.Count > 0)
                //{
                //    var p = people;
                //    imgAvatar.ImageUrl = "../Images/avatar/" + p.Avatar;
                //    imgAvatar.Attributes["data-userid"] = p.UserID.ToString();
                //    lblFirstNAme.Text = p.FirstName;
                //    lblLastName.Text = p.UserName;
                //    string js = new MiscService.MiscServiceClient().GetCityOtherName(p.CityID, Constants.English);
                //    List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(js);

                //    lblAddress.Text = ((list != null && list.Count > 0) ? list[0].CityName : string.Empty) + "," + p.CountryName;

                //    imgStatus.ImageUrl = p.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                //    lblOnlineStatusText.Text = p.IsOnline ? "Online Now" : "Offline Now";
                //    //imgLike.ImageUrl = p.ILike ? "../Images/heartUnlike.png" : "../Images/heartLike.png";
                //    //imgLike.ImageUrl = "../Images/heartUnlike.png" : "../Images/heartLike.png";
                //    lblStatusText.Text = p.StatusText;
                //    lblLikeCount.Text = p.LikeCount.ToString();
                //}

                //json = client.GetMessageTrailBySenderID(userid, SessionManager.Instance.UserProfile.UserID, Convert.ToInt32(hdnPageNumber.Value), 5);
                string json = client.GetMessageTrailBySenderID(userid, SessionManager.Instance.UserProfile.UserID, 1, 5);
                List<UserMessageContract> messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                if (messages != null)
                {
                    foreach (UserMessageContract msg in messages)
                    {
                        //msg.RecepientAvatar = msg.RecepientAvatar.Length > 0 ? "../Images/avatar/" + msg.RecepientAvatar : "../Images/avatar/no_avatar.png";
                        //msg.SenderAvatar = msg.SenderAvatar.Length > 0 ? "../Images/avatar/" + msg.SenderAvatar : "../Images/avatar/no_avatar.png";
                        msg.CssClass = msg.IsReply ? "bubble you" : "bubble me";
                        msg.CssClass = msg.ReadDate == DateTime.MinValue && !msg.IsReply ? msg.CssClass + " new" : msg.CssClass + " old";
                        // = msg.IsReply ? "bubble you" : "bubble me";
                    }
                    rptConversation.DataSource = messages;
                    rptConversation.DataBind();
                    string script = "$('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollnow", script, true);

                    client.MarkMessageAsRead(userid, SessionManager.Instance.UserProfile.UserID);

                    SiteMaster x = (SiteMaster)this.Master;
                    x.UpdateMailCount();


                    updMessages.Update();

                }

            }
            catch (Exception)
            {

                throw;
            }
        }

        private List<UserSearchContract> BindFriends(string name)
        {


            string json = new UserClient().SearchUserWithMessage(name, SessionManager.Instance.UserProfile.UserID, MailBoxUserType.All);
            List<UserSearchContract> people = new JavaScriptSerializer().Deserialize<List<UserSearchContract>>(json);
            if (people != null)
            {
                foreach (UserSearchContract person in people)
                {
                    person.Avatar = person.Avatar.Length > 0 ? "../Images/avatar/" + person.Avatar : "../Images/no_avatar.png";
                    person.StatusImage = person.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                    person.OnlineStatusText = person.IsOnline ? "Online" : "Offline";
                }

                if (people.Count() > 0)
                    hdnSelectedUserID.Value = people[0].UserID.ToString();

                rptFriends.DataSource = people;
                rptFriends.DataBind();

            }
            else
            {
                rptFriends.DataSource = null;
                rptFriends.DataBind();
            }
            updFriends.Update();

            return people;
        }

        protected void btnGetUserMessage_Click(object sender, EventArgs e)
        {
            try
            {
                GetUserMessage();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }


    }
}