using System;
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
using Language.Discovery.Helper;
using Language.Discovery.Repository;


namespace Language.Discovery
{
    public partial class Talk : System.Web.UI.Page
    {

        private int m_SentenceRowPerPage = Convert.ToInt32(ConfigurationManager.AppSettings["TalkSentenceRowsPerPage"]);
        private int m_MySentenceRowPerPage = Convert.ToInt32(ConfigurationManager.AppSettings["TalkMySentenceRowsPerPage"]);
        private int m_WordRowPerPage = Convert.ToInt32(ConfigurationManager.AppSettings["TalkWordRowsPerPage"]);
        private bool m_IsBack = false;
        private int m_SearchHistoryLimit = Convert.ToInt32(ConfigurationManager.AppSettings["SearchHistoryLimit"]);
        private string m_SearchText = string.Empty;
        private bool m_IsSearchAll = false;
        private bool m_IsUserSearch = false;

        string cPaletteDiv = string.Empty;

        private string Keyword
        {
            get
            {
                string key = "";
                if (ViewState["Keyword"] != null)
                    key = ViewState["Keyword"].ToString();
                return key;
            }
            set
            {
                ViewState["Keyword"] = value;
            }
        }

        private List<SearchDTO> SentenceSearchHistoryList
        {
            get
            {
                List<SearchDTO> list = new List<SearchDTO>();
                if (ViewState["SentenceSearchHistoryList"] != null)
                    list = (List<SearchDTO>)ViewState["SentenceSearchHistoryList"];
                else
                    ViewState["SentenceSearchHistoryList"] = list;

                return list;
            }
            //set
            //{
            //    ViewState["SearchHistoryList"] = value;
            //}
        }

        private List<SearchDTO> WordSearchHistoryList
        {
            get
            {
                List<SearchDTO> list = new List<SearchDTO>();
                if (ViewState["WordSearchHistoryList"] != null)
                    list = (List<SearchDTO>)ViewState["WordSearchHistoryList"];
                else
                    ViewState["WordSearchHistoryList"] = list;

                return list;
            }
            //set
            //{
            //    ViewState["SearchHistoryList"] = value;
            //}
        }

        protected int WordSearchHistoryListIndex
        {
            get
            {
                int index = -1;
                if (ViewState["WordSearchHistoryListIndex"] != null)
                    index = (int)ViewState["WordSearchHistoryListIndex"];

                return index;
            }
            set
            {
                ViewState["WordSearchHistoryListIndex"] = value;
            }
        }

        protected int SentenceSearchHistoryListIndex
        {
            get
            {
                int index = -1;
                if (ViewState["SentenceSearchHistoryListIndex"] != null)
                    index = (int)ViewState["SentenceSearchHistoryListIndex"];

                return index;
            }
            set
            {
                ViewState["SentenceSearchHistoryListIndex"] = value;
            }
        }

        private bool IsSearchFromHistory
        {
            get
            {
                bool res = false;
                if (ViewState["IsSearchFromHistory"] != null)
                    res = (bool)ViewState["IsSearchFromHistory"];

                return res;
            }
            set
            {
                ViewState["IsSearchFromHistory"] = value;
            }
        }

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
                if (!SessionManager.Instance.UserProfile.AllowTalk)
                    Response.Redirect("Home");

                //SessionManager.Instance.IsTalkOpen = true;
                if (!IsPostBack)
                {
                    string dst = Request.QueryString["dst"];
                    if (!string.IsNullOrEmpty(dst) && dst == "1")
                    {
                        if (new UserClient().UpdateUserDontShowNewTab(SessionManager.Instance.UserProfile.UserID, true))
                            SessionManager.Instance.UserProfile.DontShowNewTab = true;
                    }
                    bool status = new Repository.UserRepository().UpdateTalkStatus(SessionManager.Instance.UserProfile.UserID, true);
                    SessionManager.Instance.UserProfile.IsCanTalk = true;


                    PopulateDropDownList();
                    //LoadSenderDetails();
                    //LoadToDetails();
                    CreateSuggestion();
                    hdnNativeLanguageCode.Value = SessionManager.Instance.UserProfile.NativeLanguage;
                    hdnLearningLanguageCode.Value = SessionManager.Instance.UserProfile.LearningLanguage;

                    SetOptions();
                    hdnOtherLanguageCode.Value = new JavaScriptSerializer().Serialize(SessionManager.Instance.UserProfile.OtherLanguages);
                    imgBack.Visible = false;
                    imgForward.Visible = false;

                    List<UserContract> users = BindFriends();
                    if (users == null || (users != null && users.Count == 0))
                    {
                        SearchWords();
                        SearchSentence();
                    }
                    SearchSentence(true);
                    //GetUserMessage();

                    if (OnlineUser.OnlineUserList.Where(item => item.SessionID == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).Count() > 0)
                        OnlineUser.OnlineUserList.Remove(OnlineUser.OnlineUserList.Where(item => item.SessionID == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).FirstOrDefault());

                    ChatUser user = new ChatUser()
                    {
                        UserID = SessionManager.Instance.UserProfile.UserID,
                        UserName = SessionManager.Instance.UserProfile.UserName,
                        SessionID = HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString(),
                        IsOnline = true
                    };
                    hdnAuthentication.Value = user.SessionID;
                    OnlineUser.Add(user);
                    hdnCurrentUserID.Value = SessionManager.Instance.UserProfile.UserID.ToString();
                    hdnCurrentAvatar.Value = SessionManager.Instance.UserProfile.Avatar != null && SessionManager.Instance.UserProfile.Avatar.Length > 0 ? "../Images/avatar/" + SessionManager.Instance.UserProfile.Avatar : "../Images/no_avatar.png";
                    hdnCurrentFirstName.Value = SessionManager.Instance.UserProfile.FirstName;
                    hdnCurrentUserName.Value = SessionManager.Instance.UserProfile.UserName;

                    //rdoCriteriaList.SelectedIndex = 1;

                    SetupCallTimer();
                    //lblCanTalk.CssClass = SessionManager.Instance.UserProfile.IsCanTalk ? "lblCanTalk" : "lblCantTalk";

                    hdnTalkButtonTriggeredFromCodeBehind.Value = SessionManager.Instance.UserProfile.IsCanTalk.ToString();
                    if (SessionManager.Instance.UserProfile.IsSupport)
                    {
                        btnChatSupport.Visible = false;
                    }

                    //if (SessionManager.Instance.SchoolProfile.EnableParentInfo && !SessionManager.Instance.UserProfile.IsSupport 
                    //    && SessionManager.Instance.UserProfile.UserTypeID == 3 && SessionManager.Instance.UserProfile.CountryCode != "JP")
                    //{
                    //    hdnParentsInfoFlag.Value = SessionManager.Instance.UserProfile.IsParentsInfoStored.ToString();
                    //}
                    //string script = "$(function () {";
                    //script += "$('#tabs').tabs();});";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearSessionStoragescript", "ClearSessionStorage();InitializeChatHub();changeAddWordText();InitializeMainTab();", true);


                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "setIsPostBack", "setIsPostBack();", true);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "changeAddWordText_1", "changeAddWordText();", true);
                //this.Form.DefaultButton = imgSearchSentence.UniqueID;
                //this.Form.DefaultFocus = txtSearchSentence.UniqueID;
            }
            catch (Exception)
            {

                throw;
            }

        }

        private List<ScheduleContract> GetScheduledPartner()
        {
            try
            {
                MatchMakerRepository rep = new MatchMakerRepository();
                List<ScheduleContract> list = rep.GetScheduleByUserId(SessionManager.Instance.UserProfile.UserID);

                ScheduleContract info = null;
                List<ScheduleContract> listOfPartner = new List<ScheduleContract>();
                List<ScheduleContract> infos = list.FindAll(x => x.Schedule.ToString("MM/dd/yyyy") == DateTime.Now.ToString("MM/dd/yyyy") && x.PartnerId.HasValue);
                if (infos != null && infos.Count() > 0)
                {
                    foreach (ScheduleContract inf in infos)
                    {
                        TimeSpan timespan = inf.Schedule.Subtract(DateTime.Now);
                        if ((timespan.TotalMinutes >= 0 && timespan.TotalMinutes <= Convert.ToInt32(ConfigurationManager.AppSettings["TimeToShowPartner"]))
                            || (timespan.TotalMinutes < 0 && timespan.TotalMinutes >= -Convert.ToInt32(ConfigurationManager.AppSettings["EndTimeToShowPartner"]))
                            || !string.IsNullOrEmpty(inf.UserName))
                        {

                            listOfPartner.Add(inf);
                            if (SessionManager.Instance.UserProfile.IsSupport)
                            {
                                if (inf.UserId == SessionManager.Instance.UserProfile.UserID)
                                    continue;

                                ScheduleContract p = new ScheduleContract();
                                p.UserId = inf.PartnerId.Value;
                                p.PartnerId = inf.UserId;
                                p.UserName = inf.UserName;
                                p.PartnerName = inf.PartnerName;
                                p.PhraseCategoryID = inf.PhraseCategoryID;
                                p.PartnerPhraseCategoryID = inf.PartnerPhraseCategoryID;
                                listOfPartner.Add(p);
                            }

                        }
                        else
                            continue;
                    }
                }

                return listOfPartner;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void SetOptions()
        {
            if (SessionManager.Instance.UserProfile.NativeLanguage == "ja-JP" || SessionManager.Instance.UserProfile.NativeLanguage == "zh-CN")
            {
                //data-on="info" data-off="danger" data-on-label="ENG" data-off-label="JP">
                //divRomanji.Visible = false;
                //divorder.Attributes["data-on"] = "info";
                //divorder.Attributes["data-off"] = "danger";
                //divorder.Attributes["data-on-label"] = "ENG";
                //divorder.Attributes["data-off-label"] = "JP";
                chkLanguageOrder.Checked = true;
                chkSecondary.Checked = false;
                chkSecondary.Attributes.Add("disabled", "disabled");
                //divShowTranslation.Attributes["data-on-label"] = "<i class='icon-ok icon-white'><img src='../Images/en-US.png' style='width:16x;height;16px;'/></i>";
                //divShowTranslation.Attributes["data-off-label"] = "<i class='icon-ok icon-white'><img src='../Images/ja-JP.png' style='width:16x;height;16px;'/></i>";
            }
            else
            {
                divRomanji.Visible = true;
                chkLanguageOrder.Checked = false;
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

            chkSecondary.Checked = SessionManager.Instance.UserProfile.SubLanguageOptionFlag;

            chkSoundAndMail.Checked = SessionManager.Instance.UserProfile.SoundAndMail;
            //imgFreeFormMessage.Visible = SessionManager.Instance.UserProfile.EnabledFreeMessage;
            divFreeMessageImage.Visible = SessionManager.Instance.UserProfile.EnabledFreeMessage;
            chkTooltip.Checked = SessionManager.Instance.UserProfile.StepOptionFlag;

            //chkLanguageOrder.Checked = (SessionManager.Instance.SchoolProfile.DefaultLanguageOrder != SessionManager.Instance.UserProfile.LearningLanguage);

        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                m_IsUserSearch = true;
                if (hdnStopCategoryPostback.Value == "1")
                {
                    hdnStopCategoryPostback.Value = "0";
                    return;
                }
                hdnwordpage.Value = "1";
                hdnsentencepage.Value = "1";
                hdnsentencepageUserPalette.Value = "1";

                this.Keyword = string.Empty;
                //if (rdoCriteriaList.SelectedValue == "0")
                //{
                //SearchWords();
                SearchSentence();
                //SearchWordsUserCreated();
                //}
                //else
                //{
                //UpdatePanel2.Triggers.Clear();
                //SearchWords();
                //SearchWordsUserCreated();
                //}

                //if (rdoCriteriaList.SelectedValue == "1")
                //{
                //    rdoCriteriaList.SelectedValue = "0";
                //}

                //if (rdoCriteriaList.SelectedValue == "0")//All
                //{
                //    SearchWords();
                //    SearchSentence();
                //}
                //else if (rdoCriteriaList.SelectedValue == "1")//Word
                //{
                //    //UpdatePanel2.Triggers.RemoveAt(1);
                //    UpdatePanel2.Triggers.Clear();
                //    SearchWords();
                //    //SearchSentence();
                //}

                //SearchWords();
                //SearchSentence();
                string changeactivetab = "changeActiveTab();";
                //if (rdoCriteriaList.SelectedValue == "1")
                //    changeactivetab = "";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();" + changeactivetab, true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        private void AddSearchSentenceList(SearchDTO item)
        {
            SentenceSearchHistoryList.Add(item);
            if (SentenceSearchHistoryList.Count > m_SearchHistoryLimit)
            {
                SentenceSearchHistoryList.RemoveAt(0);
            }

            //if (!m_IsSearchAll)
            //{
            //    if (SentenceSearchHistoryList.Count > 0)
            //    {
            //        SentenceSearchHistoryList.Add(SentenceSearchHistoryList[SentenceSearchHistoryList.Count - 1]);
            //        if (SentenceSearchHistoryList.Count > m_SearchHistoryLimit)
            //        {
            //            SentenceSearchHistoryList.RemoveAt(0);
            //        }
            //    }
            //}
            if (SentenceSearchHistoryList.Count >= 2)
            {
                imgBack.Visible = true;
                //UpdatePanel2.Update();
            }

        }
        private void AddSearchWordList(SearchDTO item)
        {
            WordSearchHistoryList.Add(item);
            if (WordSearchHistoryList.Count > m_SearchHistoryLimit)
            {
                WordSearchHistoryList.RemoveAt(0);
            }

            //if (!m_IsSearchAll)
            //{
            //    if (WordSearchHistoryList.Count > 0)
            //    {
            //        WordSearchHistoryList.Add(WordSearchHistoryList[WordSearchHistoryList.Count - 1]);
            //        if (WordSearchHistoryList.Count > m_SearchHistoryLimit)
            //        {
            //            WordSearchHistoryList.RemoveAt(0);
            //        }
            //    }
            //}

            if (WordSearchHistoryList.Count >= 2)
            {
                imgBack.Visible = true;
                //UpdatePanel2.Update();
            }
        }

        private SearchDTO GetSearchSentenceDto()
        {
            try
            {
                if (SentenceSearchHistoryList.Count == SentenceSearchHistoryListIndex && m_IsBack)
                    SentenceSearchHistoryListIndex = SentenceSearchHistoryList.Count - 1;

                int index = SentenceSearchHistoryListIndex;
                if (index == 0)
                    index = 1;

                SearchDTO dto = SentenceSearchHistoryList[index - 1];
                return dto;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private SearchDTO GetSearchWordDto()
        {
            try
            {
                if (WordSearchHistoryList.Count == 0)
                    return null;
                if (WordSearchHistoryList.Count == WordSearchHistoryListIndex && m_IsBack)
                    WordSearchHistoryListIndex = WordSearchHistoryList.Count - 1;

                int index = WordSearchHistoryListIndex;
                if (index == 0)
                    index = 1;

                if (WordSearchHistoryList.Count == 0 || WordSearchHistoryList.Count == 1 || (WordSearchHistoryList.Count > 0 && index == 0))
                    index = 1;

                SearchDTO dto = WordSearchHistoryList[index - 1];
                return dto;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void imgBack_Click(object sender, ImageClickEventArgs e)
        {
            m_IsBack = true;
            IsSearchFromHistory = true;

            if (SentenceSearchHistoryListIndex == -1)
            {
                if (SentenceSearchHistoryList.Count == m_SearchHistoryLimit)
                    SentenceSearchHistoryListIndex = m_SearchHistoryLimit;//SentenceSearchHistoryList.Count - 1;
                else
                    SentenceSearchHistoryListIndex = SentenceSearchHistoryList.Count - 1;

                //imgForward.Visible = true;
            }
            else
                SentenceSearchHistoryListIndex--;

            if (SentenceSearchHistoryListIndex < 0)
            {
                SentenceSearchHistoryListIndex = 0;
            }

            if (WordSearchHistoryListIndex == -1)
            {
                if (WordSearchHistoryList.Count == m_SearchHistoryLimit)
                    WordSearchHistoryListIndex = m_SearchHistoryLimit;//SentenceSearchHistoryList.Count - 1;
                else
                    WordSearchHistoryListIndex = WordSearchHistoryList.Count - 1;

                //imgForward.Visible = true;
            }
            else
                WordSearchHistoryListIndex--;

            if (WordSearchHistoryListIndex < 0)
            {
                WordSearchHistoryListIndex = 0;
            }


            if (SentenceSearchHistoryListIndex == 1) //||  (WordSearchHistoryListIndex == 1 && SentenceSearchHistoryListIndex == 1))
            {
                imgBack.Visible = false;
            }

            imgForward.Visible = true;
            //UpdatePanel2.Update();

            SearchSentence();
            SearchWords();
            SearchWordsUserCreated();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript_back",
                      string.Format("InitializeSearchText('{0}'); InitializeCategory('{1}');AppendCircleButton();InitializeTooltipSteps();", m_SearchText, hdnCategory.Value), true);

            IsSearchFromHistory = false;
        }

        protected void imgForward_Click(object sender, ImageClickEventArgs e)
        {
            m_IsBack = false;
            IsSearchFromHistory = true;

            if (SentenceSearchHistoryListIndex < m_SearchHistoryLimit)
            {
                SentenceSearchHistoryListIndex++;
                //imgBack.Visible = true;
            }
            else
                imgForward.Visible = false;

            if (SentenceSearchHistoryListIndex > m_SearchHistoryLimit)
                SentenceSearchHistoryListIndex = m_SearchHistoryLimit;

            if (SentenceSearchHistoryList.Count == SentenceSearchHistoryListIndex)
                imgForward.Visible = false;

            if (WordSearchHistoryListIndex < m_SearchHistoryLimit && WordSearchHistoryListIndex < WordSearchHistoryList.Count)
            {
                WordSearchHistoryListIndex++;
                //imgBack.Visible = true;
            }
            else
                imgForward.Visible = false;

            if (WordSearchHistoryListIndex > m_SearchHistoryLimit)
                WordSearchHistoryListIndex = m_SearchHistoryLimit;

            if (WordSearchHistoryList.Count == WordSearchHistoryListIndex && SentenceSearchHistoryList.Count == SentenceSearchHistoryListIndex)
                imgForward.Visible = false;

            imgBack.Visible = true;
            //UpdatePanel2.Update();
            SearchSentence();
            SearchWords();
            SearchWordsUserCreated();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript_back",
                      string.Format("InitializeSearchText('{0}');InitializeCategory('{1}');AppendCircleButton();InitializeTooltipSteps();", m_SearchText, hdnCategory.Value), true);
            IsSearchFromHistory = false;
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
                TopCategoryContract[] tcats = pclient.GetTopCategoryList(SessionManager.Instance.UserProfile.NativeLanguage);


                plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[All]" });

                foreach (TopCategoryContract tc in tcats)
                {
                    var list = plist.FindAll(x => x.TopCategoryHeaderID.Equals(tc.TopCategoryHeaderID));
                    if (list != null)
                    {
                        foreach (PhraseCategoryContract p in list)
                        {
                            if (p.PhraseCategoryCode.Trim().Equals(tc.TopCategoryName.Trim(), StringComparison.OrdinalIgnoreCase) || p.PhraseCategoryCode.Trim().Contains(tc.TopCategoryName.Trim()))
                            {
                                ddlCategory.Items.Add(new ListItem(p.PhraseCategoryCode, p.PhraseCategoryID.ToString()));
                            }
                            else
                            {
                                ddlCategory.Items.Add(new ListItem(tc.TopCategoryName + " - " + p.PhraseCategoryCode, p.PhraseCategoryID.ToString()));
                            }
                            if (tc.IsTalk)
                            {
                                hdnTalkCategory.Value = p.PhraseCategoryID.ToString();
                            }

                        }
                    }
                }
                ddlCategory.Items.Insert(0, new ListItem("[All]", "0"));

                //ddlCategory.DataSource = plist;
                //ddlCategory.DataTextField = "PhraseCategoryCode";
                //ddlCategory.DataValueField = "PhraseCategoryID";
                //ddlCategory.DataBind();

                bool hasDefault = false;
                foreach (PhraseCategoryContract p in plist)
                {
                    if (p.IsDefault)
                    {
                        ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
                        if (string.IsNullOrEmpty(this.Keyword))
                            ddlCategory.SelectedValue = p.PhraseCategoryID.ToString();

                        hasDefault = true;
                        ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;
                        break;
                    }
                }
                //if(!hasDefault)
                //{
                //    Random next = new Random();
                //    int index = -1;
                //    if (plist.Count > 0)
                //        index = next.Next(0, plist.Count - 1);

                //    if (index > -1)
                //    {
                //        ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
                //        if (string.IsNullOrEmpty(this.Keyword))
                //            ddlCategory.SelectedValue = plist[index].PhraseCategoryID.ToString();

                //        ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;
                //    }
                //}






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

                string wordtype = hdnWordType.Value;

                SearchDTO dto = new SearchDTO()
                {
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID,
                    CategoryID = 0, //Convert.ToInt64(ddlCategory.SelectedValue),
                    Word = txtSearchWord.Text,
                    Keyword = txtSearchWord.Text,
                    PageNumber = Convert.ToInt32(hdnwordpage.Value),
                    RowsPerPage = m_WordRowPerPage,
                    IsTalk = true,
                    WordType = wordtype
                };

                //if (dto.CategoryID == 0)
                //{
                //    foreach (ListItem item in ddlCategory.Items)
                //    {
                //        if (item.Value == "0")
                //            continue;

                //        dto.CategoryIDs += item.Value + ",";
                //    }
                //}
                //else
                //{
                //    dto.CategoryIDs = ddlCategory.SelectedValue;
                //}
                if (!string.IsNullOrEmpty(this.Keyword) && string.IsNullOrEmpty(txtSearchWord.Text))
                {
                    dto.CategoryID = 0;
                    //dto.Word = this.Keyword.Replace("&#39;", "'"); //for talk only
                    dto.Keyword = this.Keyword.Replace("&#39;", "'");
                }
                if (!string.IsNullOrEmpty(hdnWordKeyword.Value) && string.IsNullOrEmpty(txtSearchWord.Text))
                {
                    dto.Word = string.Empty;
                    dto.Keyword = hdnWordKeyword.Value;
                }
                //if (!string.IsNullOrEmpty(txtSearchSentence.Text))
                //dto.WordType = string.Empty;

                if (!string.IsNullOrEmpty(txtSearchWord.Text) && dto.WordType.Length > 0)
                {
                    //dto.Word = string.Empty;
                    //dto.Keyword = string.Empty;
                    dto.WordType = "";
                }
                //if (!string.IsNullOrEmpty(txtSearchSentence.Text))
                //dto.WordType = string.Empty;
                if (string.IsNullOrEmpty(dto.WordType))
                {
                    if (IsSearchFromHistory)
                    {

                        SearchDTO dt = GetSearchWordDto();
                        if (dt != null)
                            dto = dt;

                        hdnwordpage.Value = dto.PageNumber.ToString();
                        hdnCategory.Value = dto.CategoryID.ToString();
                        ddlCategory.SelectedValue = dto.CategoryID.ToString();
                        m_SearchText = dto.Word;
                        hdnWordType.Value = dto.WordType;
                    }
                    else
                    {
                        AddSearchWordList(dto);
                    }
                }


                string json = pclient.SearchWord(dto, out virtualcount);
                List<WordContract> list = new JavaScriptSerializer().Deserialize<List<WordContract>>(json);
                //if(virtualcount == 0 && !string.IsNullOrEmpty(dto.Keyword) )
                //{
                //    dto.Keyword = string.Empty;
                //    json = pclient.SearchWord(dto, out virtualcount);
                //    list = new JavaScriptSerializer().Deserialize<List<WordContract>>(json);
                //}

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


                    var learn = plearninglist.Find(x => x.WordMapID.Equals(wc.WordMapID));
                    if (learn != null)
                    {
                        words = string.Format("<span id='{0}' class='firstword' data-lang='{1}' data-switchword='{2}' data-word='{3}' {4} data-sound='{5}'>", "divspanword" + wc.WordID.ToString(), wc.LanguageCode, wc.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", wc.Word, dimage, "../Content/sound/" + learn.SoundFile) + wc.Word + "</span>" + "<br/>";
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + learn.WordID.ToString(), cl, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage, "../Content/sound/" + wc.SoundFile) + learn.Word + "</span>" + "<br/>";
                    }
                    else
                    {
                        words = string.Format("<span id='{0}' class='firstword' data-lang='{1}' data-switchword='{2}' data-word='{3}' {4} data-sound='{5}'>", "divspanword" + wc.WordID.ToString(), wc.LanguageCode, wc.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", wc.Word, dimage, "") + wc.Word + "</span>" + "<br/>";
                    }

                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(wc.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}'>", "divspan" + sub.WordID.ToString(), cl) + sub.Word + "</span>" + "<br/>";
                    }

                    foreach (string lang in SessionManager.Instance.UserProfile.OtherLanguages)
                    {

                        var otherlanguage = list.FindAll(x => x.LanguageCode.Equals(lang)).ToList();
                        if (otherlanguage != null)
                        {
                            if (learn == null)
                                learn = wc;

                            var otherword = otherlanguage.Find(x => x.WordMapID.Equals(learn == null ? wc.WordMapID : learn.WordMapID));
                            if (otherword != null)
                            {
                                string cl = "otherword";
                                string sfile = "";
                                if (learn != null)
                                    sfile = "'../Content/sound/" + learn.SoundFile;
                                words += string.Format("<span id='{0}' class='{1}' style='display:none;' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + otherword.WordID.ToString(), cl, otherword.LanguageCode, otherword.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", otherword.Word, dimage, sfile) + otherword.Word + "</span>";                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
                            }
                        }
                    }

                    string datasound = string.Empty;
                    if (learn != null)
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";


                    string div = string.Format("<div id=\"div{0}\" class=\"screenshot wordbox\" style=\"text-align:center;background-color:white;cursor:pointer;position:relative;\" data-isword=\"true\" ondblclick=\"worddblClick('div{0}');\" onclick=\"wordClick('div{0}', false,true, event, true);\" data-image=\"../Content/images/" + wc.ImageFile + "\" {2} >" +
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
                    words = string.Format("<span id='{0}' class='firstword'>", "divspanword" + wc.WordID.ToString()) + wc.Word + "</span>" + "<br/>";
                    foreach (WordContract w in wc.WordList)
                    {
                        count++;
                        if (count == 2)
                        {
                            string cl = "secondword";
                            words += string.Format("<span id='{0}' class='{1}'>", "divspanword" + w.WordID.ToString() + count.ToString(), cl) + w.Word + "</span>" + "<br/>";
                        }
                        if (count == 3)
                        {
                            string cl = "thirdword";
                            words += string.Format("<span id='{0}' class='{1}'>", "divspan" + w.WordID.ToString() + count.ToString(), cl) + w.Word + "</span>" + "<br/>";
                        }
                    }


                    string div = string.Format("<div id=\"div{0}\" class=\"screenshot\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;width:200px;\" ondblclick=\"worddblClick('div{0}', false);\" data-image=\"http://localhost:50835/Content/images/" + wc.ImageFile + "\" >" +
                                "{1}" +
                        "</div>", wc.WordID, words);
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
                    if (learn != null)
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";

                    string cssclass = "class='screenshot'";
                    //string datagrouping = "data-elementgrouping='sentence_" + p.SentenceID.ToString() + "'";
                    if (string.IsNullOrEmpty(p.ImageFile))
                    {
                        cssclass = string.Empty;
                        dataimage = string.Empty;
                    }
                    div = string.Format("<div id=\"div{0}\" class=\"suggestion\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;padding-left:10px;padding-bottom:2px;\" data-isword=\"false\" ondblclick='worddblClick(\"div{0}\")'  onclick=\"wordClick('div{0}', true, true, event, false);\" {3} {4}>" +
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

            //LiteralControl lit = new LiteralControl();
            //lit.Text = nativesentence;
            //divDisplaySuggestion.Controls.Add(lit);
            //divSuggestion.Controls.Add(parentul);

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
        private int CreatePalleteList(bool own)
        {

            PaletteServiceClient pclient = new PaletteServiceClient();
            //SearchDTO dto = new SearchDTO() { SchoolID= SessionManager.Instance.UserProfile.SchoolID, CategoryID = Convert.ToInt32(ddlCategory.SelectedValue), Keyword = txtSearchSentence.Text, LevelID = SessionManager.Instance.UserProfile.LevelID, PageNumber = Convert.ToInt32(hdnsentencepage.Value), RowsPerPage = m_SentenceRowPerPage };
            SearchDTO dto = null;

            //if (rdoCriteriaList.SelectedValue == "1") //Word
            //{

            //    dto = new SearchDTO()
            //    {
            //        SchoolID = SessionManager.Instance.UserProfile.SchoolID,
            //        CategoryID = Convert.ToInt32(ddlCategory.SelectedValue),
            //        Keyword = txtSearchSentence.Text,//string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty,
            //        LevelID = SessionManager.Instance.UserProfile.LevelID,
            //        PageNumber = Convert.ToInt32(hdnsentencepage.Value),
            //        RowsPerPage = m_SentenceRowPerPage
            //    };
            //}
            //else //Phrase+word
            //{
            //    dto = new SearchDTO()
            //    {
            //        SchoolID = SessionManager.Instance.UserProfile.SchoolID,
            //        CategoryID = Convert.ToInt32(ddlCategory.SelectedValue),
            //        Keyword = txtSearchSentence.Text,
            //        LevelID = SessionManager.Instance.UserProfile.LevelID,
            //        PageNumber = Convert.ToInt32(hdnsentencepage.Value),
            //        RowsPerPage = m_SentenceRowPerPage
            //    };
            //}
            dto = new SearchDTO()
            {
                SchoolID = SessionManager.Instance.UserProfile.SchoolID,
                CategoryID = Convert.ToInt32(ddlCategory.SelectedValue),
                Word = txtSearchSentence.Text,//string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty,
                Keyword = txtSearchSentence.Text,//string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty,
                LevelID = SessionManager.Instance.UserProfile.LevelID,
                PageNumber = own ? Convert.ToInt32(hdnsentencepageUserPalette.Value) : Convert.ToInt32(hdnsentencepage.Value),
                RowsPerPage = own ? m_MySentenceRowPerPage : m_SentenceRowPerPage,
                UserID = SessionManager.Instance.UserProfile.UserID,
                IsTalk = true,
                IsUserPalette = own
            };
            if (dto.CategoryID == 0)
            {
                foreach (ListItem item in ddlCategory.Items)
                {
                    if (item.Value == "0")
                        continue;

                    dto.CategoryIDs += item.Value + ",";
                }
            }
            else
            {
                dto.CategoryIDs = ddlCategory.SelectedValue;

            }

            if (!string.IsNullOrEmpty(this.Keyword) && string.IsNullOrEmpty(txtSearchSentence.Text) && ddlCategory.SelectedIndex == 0)
            {
                string catid = dto.CategoryIDs;
                if (catid.EndsWith(","))
                {
                    dto.CategoryIDs = string.IsNullOrEmpty(dto.CategoryIDs) ? string.Empty : dto.CategoryIDs.Substring(0, dto.CategoryIDs.Length - 1);
                }

                ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
                ddlCategory.SelectedIndex = 0;
                dto.CategoryID = 0;
                //dto.Word = this.Keyword.Replace("&#39;", "'");
                dto.Keyword = this.Keyword.Replace("&#39;", "'");
                ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;
                dto.RowsPerPage = own ? m_MySentenceRowPerPage : m_SentenceRowPerPage;
                dto.IsTalk = true;
            }

            int virtualcount = 0;

            if (IsSearchFromHistory)
            {
                SearchDTO dt = GetSearchSentenceDto();
                if (dt != null)
                    dto = dt;
                hdnsentencepage.Value = dto.PageNumber.ToString();
                hdnCategory.Value = dto.CategoryID.ToString();
                ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
                ddlCategory.SelectedValue = dto.CategoryID.ToString();
                ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;
                m_SearchText = dto.Word;
            }
            else
            {
                AddSearchSentenceList(dto);
            }
            List<PaletteContract> list = pclient.Search(dto, out virtualcount).ToList();


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

            int eBtnId = 0;

            foreach (PaletteContract paleteContract in list)
            {
                HtmlGenericControl parentli = new HtmlGenericControl("li");

                PaletteContract pcontract = new PaletteContract();
                pcontract.PaletteID = paleteContract.PaletteID;
                pcontract.SchoolID = paleteContract.SchoolID;
                pcontract.PhraseCategoryID = paleteContract.PhraseCategoryID;
                pcontract.DefaultLanguageCode = paleteContract.DefaultLanguageCode;

                HtmlGenericControl childul = new HtmlGenericControl("ul");
                Console.WriteLine(paleteContract);

                var pnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage)).ToList();
                var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();
                var psubnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();
                var psubnative2list = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage2)).ToList();
                if ((pnativelist != null && pnativelist.Count == 0) || (plearninglist != null && plearninglist.Count == 0))
                {
                    virtualcount--;
                    continue;
                }

                //var pfakelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();

                string soundfilelearning = string.Empty;
                string soundfilenative = string.Empty;
                var soundfilelearn = paleteContract.SentenceList.Find(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage) && x.PaletteID.Equals(paleteContract.PaletteID));
                var soundfilenat = paleteContract.SentenceList.Find(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage) && x.PaletteID.Equals(paleteContract.PaletteID));
                if (soundfilelearn != null)
                {
                    soundfilelearning = soundfilelearn.SoundFile;
                }
                if (soundfilenat != null)
                {
                    soundfilenative = soundfilenat.SoundFile;
                }

                LiteralControl sound = new LiteralControl();
                LiteralControl divsoundcont = new LiteralControl();
                divsoundcont.Text = "<div style='height:40px;width:40px;float:left;'></div>";

                //m@s
                HtmlGenericControl divEachPalette = new HtmlGenericControl("div");
                divEachPalette.Attributes.Add("id", "divEachPalette");
                divEachPalette.Attributes.Add("style", "display: flex; justify-content: space-between; margin-button:5px;");

                int indx = 0;
                string commoncss = "vertical-align: top;  display: inline-block;";
                HtmlGenericControl divSpeaker = new HtmlGenericControl("div");
                divSpeaker.Attributes.Add("id", "divSpeaker");
                divSpeaker.Attributes.Add("style", commoncss+ "width: 5%; height: auto;");
                divEachPalette.Controls.AddAt(indx, divSpeaker);

                indx += 1;
                HtmlGenericControl divForeign = new HtmlGenericControl("div"); 
                divForeign.Attributes.Add("id", "divForeign");
                divForeign.Attributes.Add("style", commoncss + "width: 40%; height: auto;");
                divEachPalette.Controls.AddAt(indx, divForeign);

                indx += 1;
                HtmlGenericControl divNativ = new HtmlGenericControl("div");
                divNativ.Attributes.Add("id", "divNativ");
                divNativ.Attributes.Add("style", commoncss + "width: 40%; height: auto;");
                divEachPalette.Controls.AddAt(indx, divNativ);

                indx += 1;
                HtmlGenericControl divChkbox = new HtmlGenericControl("div");
                divChkbox.Attributes.Add("id", "divChkbox");
                divChkbox.Attributes.Add("style", commoncss + "width: 5%; height: auto;");
                divEachPalette.Controls.AddAt(indx, divChkbox);

                indx += 1;
                HtmlGenericControl divEmailIcon = new HtmlGenericControl("div");
                divEmailIcon.Attributes.Add("id", "divEmailIcon");
                divEmailIcon.Attributes.Add("style", commoncss + "width: 5%; height: auto;");
                divEachPalette.Controls.AddAt(indx, divEmailIcon);

                parentli.Controls.AddAt(0, divEachPalette);

                int divSpeakerIndex = 0;

                //sound.Text = "<img src=\"../Images/new/ICO_Speaker.png\" class=\"soundicon\" style=\"width:16px; height:16px; float:left;vertical-align:middle;cursor:pointer;\" onclick=\"PlaySentenceOrIndividualSound(this,'" + soundfilelearning + "');\" data-sound='" + soundfilelearning + "'/>";
                sound.Text = "<img src=\"../Images/new/ICO_Speaker.png\" class=\"soundicon\" style=\"width:16px; height:16px; float:left;vertical-align:middle;cursor:pointer;\" onclick=\"PlaySentenceOrIndividualSound(this,'" + soundfilelearning + "');\" data-sound='" + soundfilelearning + "'/>";

                //if (soundfilelearning.Length > 0)
                //    parentli.Controls.AddAt(indx, sound);
                //else
                //    parentli.Controls.AddAt(indx, divsoundcont);
                if (soundfilelearning.Length > 0)
                    divSpeaker.Controls.AddAt(divSpeakerIndex, sound);
                else
                    divSpeaker.Controls.AddAt(divSpeakerIndex, divsoundcont);


                //if (!own)
                //{

                //// CheckBox start from here

                ////var checkbox = new CheckBox();
                //var checkbox = new CheckBox();
                //checkbox.Attributes.Add("class", "chkAddtoMyPhrases");
                //checkbox.Attributes.Add("data-paletteid", paleteContract.PaletteID.ToString());
                ////checkbox.Attributes.Add("style", "position: absolute;bottom: 45px; left: 14px;width: 15px;height: 15px;");
                ////checkbox.Text = "<input type='checkbox' class='chkAddtoMyPhrases'/>";
                //parentli.Controls.AddAt(1, checkbox);
                ////childul.Controls.Add(sound);
                ////}
                ////CheckBox ends hereMultiple controls with the same ID

                //< li class="prhraseTabs"><asp:HyperLink CssClass = "send-msg-tabs1" ID="linkTabPhrases" href="#mtab1" runat="server" Text="Phrases" meta:resourcekey="linkTabPhrasesResource1"/></li>


                // ======= Add Edit button into the palette ======
                //var editButton = new LinkButton();
                ////hLink.Attributes.Add("class", "send-msg-tabs1");
                //editButton.Attributes.Add("data-paletteid", paleteContract.PaletteID.ToString());
                ////editButton.Attributes.Add("style", "position: absolute;bottom: 45px; left: 14px;width: 150px;height: 15px;");
                //editButton.Text = "Edit";
                //editButton.ForeColor = System.Drawing.Color.Black;
                //parentli.Controls.AddAt(2, editButton);


                ////editButton.Attributes.Add("input type", "button");
                ////editButton.Attributes.Add("value", "edit");
                ////editButton.Attributes.Add("class", "editButton");
                ////editButton.Attributes.Add("onclick", "editButtonOnClick(this");
                //editButton.Text = "Edit";
                //editButton.ForeColor = System.Drawing.Color.Black;
                ////parentli.Controls.AddAt(2, editButton);

                //editButton.Text = "<onclick=\"editButtonOnClick(this);\" />";
                //parentli.Controls.AddAt(2, editButton);


                //LiteralControl editButton = new LiteralControl();
                ////editButton.Text = "<button class='editButtonClass' onClick='clickFunction(this)'> Edit<button/>";
                //editButton.attr = "<input type="button" value="edit" class="editButton" onclick="clone(this); "/> <span>palette 2</span>";
                //editButton.Text = "<input type="button" value="edit" class="editButton" onclick="clone(this); "/> <span>palette 2</span>";
                //parentli.Controls.AddAt(2, editButton);

                //m@s=================Final edit button code

                //string edit = string.Format("<img id='img{0}' src='../Images/swapoutline.png' class='addORreplaceword' onclick='InitializeReplaceWordSettings(this);' />", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString() + ownPhrase);

                indx += 1;
                HtmlButton editButton = new HtmlButton();
                //hLink.Attributes.Add("class", "send-msg-tabs1");
                editButton.Attributes.Add("id", paleteContract.PaletteID.ToString() + "EBTN" + eBtnId);
                editButton.Attributes.Add("type", "button");
                editButton.Attributes.Add("style", "width: 150px; height: 25px;");
                editButton.Attributes.Add("data-paletteid", paleteContract.PaletteID.ToString());
                //editButton.Attributes.Add("onclick", "editButtonOnClick(this)");
                //editButton.Attributes.Add("innerHTML", "Edit");
                editButton.InnerHtml = "Edit";
                //parentli.Controls.AddAt(indx, editButton);   //m@s

                eBtnId = eBtnId + 1;
                parentli.Attributes.Add("id", paleteContract.PaletteID.ToString() + "MainLi_" + eBtnId);


                // ======= Concat words ======
                //string NSentence = string.Empty;
                //string LSentence = string.Empty;
                //int wordCount = pnativelist.Count;

                //foreach (var item in pnativelist)
                //{
                //    NSentence += " " + item.Word;
                //}
                //foreach (var item in plearninglist)
                //{
                //    LSentence += " " + item.Word;
                //}

                //var NS = new Label();
                //var LS = new Label();

                ////NS.Attributes.Add("Text", NSentence);
                ////LS.Attributes.Add("Text", LSentence);
                //NS.Text = NSentence;
                //LS.Text = LSentence;
                //parentli.Controls.AddAt(3, NS);
                //parentli.Controls.AddAt(4, LS);

                //var emtLabel = new Label { Text = "&nbsp; &nbsp; &nbsp; &nbsp;" };

                int divForeignIndex = -1;
                foreach (var item in plearninglist)
                {
                    var wrd = new LinkButton();
                    //wrd.Text = item.Word + "&nbsp;";
                    wrd.Text = item.Word;
                    wrd.ForeColor = System.Drawing.Color.DarkRed;
                    //indx += 1;
                    //parentli.Controls.AddAt(indx, emtLabel);
                    divForeignIndex += 1;
                    //parentli.Controls.AddAt(indx, wrd);
                    divForeign.Controls.AddAt(divForeignIndex, wrd);

                }

                int divNativIndex = -1;
                foreach (var item in pnativelist)
                {
                    var wrd = new LinkButton();
                    //wrd.Text = item.Word + "&nbsp;";
                    wrd.Text = item.Word;
                    wrd.ForeColor = System.Drawing.Color.Blue;
                    //indx += 1;
                    //parentli.Controls.AddAt(indx, emtLabel);
                    divNativIndex += 1;
                    //parentli.Controls.AddAt(indx, wrd);
                    divNativ.Controls.AddAt(divNativIndex, wrd);

                }


                // CheckBox start from here
                int divChkboxIndex = 0;
                //var checkbox = new CheckBox();
                var checkbox = new CheckBox();
                checkbox.Attributes.Add("class", "chkAddtoMyPhrases");
                checkbox.Attributes.Add("data-paletteid", paleteContract.PaletteID.ToString());
                //checkbox.Attributes.Add("style", "position: absolute;bottom: 45px; left: 14px;width: 15px;height: 15px;");
                checkbox.Attributes.Add("style", "padding: auto !important;");
                //checkbox.Text = "<input type='checkbox' class='chkAddtoMyPhrases'/>";
                //parentli.Controls.AddAt(indx, checkbox);
                divChkbox.Controls.AddAt(divChkboxIndex, checkbox);

                //CheckBox ends hereMultiple controls with the same ID


                //===================================================


                string words = string.Empty;
                string sentence1ordinal = "";
                string sentence2ordinal = "";
                string sounds = "";
                long sentenceid = 0;
                string ll = SessionManager.Instance.UserProfile.LearningLanguage;
                string nl = SessionManager.Instance.UserProfile.NativeLanguage;
                string ol = SessionManager.Instance.UserProfile.OtherLanguage;
                Console.WriteLine(SessionManager.Instance.UserProfile.LearningLanguage);
                string nativelanguage = "";

                foreach (Phrase learn in plearninglist)
                {
                    var sk = paleteContract.SentenceList.Find(x => x.PaletteID.Equals(paleteContract.PaletteID) && !string.IsNullOrEmpty(x.Keyword));
                    var p = pnativelist.Find(x => x.WordMapID.Equals(learn.WordMapID));
                    if (p == null)
                        continue;

                    HtmlGenericControl li = new HtmlGenericControl("li");
                    sounds += p == null ? "" : p.SoundFile + ",";
                    int count = 1;
                    string subnative2word = string.Empty;
                    string subnative2code = string.Empty;
                    string subnative2wordphraseid = string.Empty;


                    var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(learn.WordMapID));
                    string learnimage = string.Empty;
                    if (learn != null)
                    {
                        learnimage = learn.ImageFile;
                    }
                    if (sub2 != null)
                    {
                        subnative2word = sub2.Word;
                        subnative2wordphraseid = sub2.PhraseID.ToString();
                        subnative2code = sub2.LanguageCode.Substring(0, 2);
                    }
                    //"data-image='../Content/images/" + p.ImageFile + "' "
                    string dimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "' ";
                    if (string.IsNullOrEmpty(p.ImageFile) && string.IsNullOrEmpty(learnimage))
                        dimage = string.Empty;
                    //words = string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6} data-keyword='{7}' data-sentencesound='{8}'>", "divspan" + p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString() + count.ToString(),
                    //    p.Ordinal.ToString(), "../Content/Sound/" + learn.SoundFile, p.LanguageCode, p.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", p.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilenative) + p.Word + "</span>";// + "<br/>";
                    //sentence1ordinal += p.Ordinal.ToString() + ",";
                    //nativelanguage += p.Word + "&nbsp;";
                    string dataswapped = learn.DataSwapped ? "data-swapped='1'" : "";

                    if (p != null)
                    {
                        string ownPhrase = "";
                        if (own)
                            ownPhrase = "myOwnPhrase";

                        string cl = "secondword";
                        words = string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7} data-keyword='{8}' data-sentencesound='{9}' data-phraseid='{10}' data-wordphraseid='{11}' data-switchwordphraseid='{12}' {13}>", "divspan" + learn.PalleteID.ToString() + learn.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + count.ToString(),
                            cl, learn.Ordinal.ToString(), "../Content/Sound/" + p == null ? "" : p.SoundFile, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilelearning, learn.PhraseID.ToString(), learn.PhraseID.ToString(), subnative2wordphraseid, dataswapped) + learn.Word + "</span>";

                        sentence2ordinal += learn.Ordinal.ToString() + ",";
                        string smallspeaker = string.Format("<img class='imgsmallspeaker' src=\"../Images/wordspeaker.png\" style=\"width:18px; height:18px;\" onclick='worddblClick(\"div{0}\")'/>", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString() + (own ? "myOwnPalette" : ""));
                        if (learn.SoundFile.Length == 0)
                            smallspeaker = "";

                        //string edit = string.Format("<img id='img{0}' src='../Images/Ico_edit.png' class='addreplaceword' onclick='InitializeReplaceWordSettings(this);' />", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString());

                        string edit = string.Format("<img id='img{0}' src='../Images/swapoutline.png' class='addORreplaceword' onclick='InitializeReplaceWordSettings(this);' />", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString() + ownPhrase);
                        if (string.IsNullOrEmpty(p.WordType))
                            edit = string.Empty;

                        string showimage = (p.ImageFile.Length > 0 || learn.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:18px; height:18px;\" onclick='ShowPicture(event)'/></a>" : string.Empty);
                        words += "<div class='paletteIconContainer'><div class='divReplaceContainer childpaletteIconContainer'>" + edit + "</div>"
                            + "<div class='divPlayContainer childpaletteIconContainer'>" + smallspeaker + "</div>"
                            + "<div class='divShowImageContainer childpaletteIconContainer'>" + showimage + "</div></div>";
                    }

                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(learn.WordMapID));
                    if (sub != null || own)
                    {
                        string cl = "thirdword";
                        if (own && sub == null)
                        {
                            words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-phraseid='{3}'>", "divspan" + Guid.NewGuid(),
                               cl, "", "") + "" + "</span>" + "<br/>";
                        }
                        else
                        {
                            words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-phraseid='{3}'>", "divspan" + sub.PalleteID.ToString() + sub.SentenceID.ToString() + p.Ordinal.ToString() + sub.Ordinal.ToString() + count.ToString(),
                               cl, sub.Ordinal.ToString(), sub.PhraseID.ToString()) + sub.Word + "</span>" + "<br/>";
                        }
                    }

                    words += string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6} data-keyword='{7}' data-sentencesound='{8}', data-phraseid='{9}' data-wordphraseid='{10}' data-switchwordphraseid='{11}' {12}>", "divspan" + p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString() + count.ToString(),
                        p.Ordinal.ToString(), "../Content/Sound/" + learn.SoundFile, p.LanguageCode, p.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", p.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilenative, p.PhraseID.ToString(), p.PhraseID, subnative2wordphraseid, dataswapped) + p.Word + "</span>";// + "<br/>";
                    sentence1ordinal += p.Ordinal.ToString() + ",";
                    nativelanguage += p.Word + "&nbsp;";

                    foreach (string lang in SessionManager.Instance.UserProfile.OtherLanguages)
                    {
                        //hdnOtherLanguageCode.Value += lang + ",";
                        Phrase learningPhrase = learn;
                        if (learningPhrase == null)
                            learningPhrase = p;

                        var otherlanguage = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(lang)).ToList();
                        if (otherlanguage != null)
                        {
                            var otherword = otherlanguage.Find(x => x.WordMapID.Equals(learningPhrase.WordMapID));
                            if (otherword != null)
                            {
                                string cl = "otherword";
                                words += string.Format("<span id='{0}' style='display:none;' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7} data-keyword='{8}' data-sentencesound='{9}', data-phraseid='{10}'>", "divspan" + learningPhrase.PalleteID.ToString() + learningPhrase.SentenceID.ToString() + p.Ordinal.ToString() + learningPhrase.Ordinal.ToString() + otherword.Ordinal.ToString() + count.ToString(),
                                    cl, otherword.Ordinal.ToString(), "../Content/Sound/" + otherword.SoundFile, otherword.LanguageCode, "", otherword.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilelearning, learningPhrase.PhraseID.ToString()) + otherword.Word + "</span>";
                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
                            }

                        }
                    }


                    //var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();

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



                    string dataimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "' ";
                    //string datasound = "<span id='sound' class='mp3'>"+ "http://localhost:50835/Content/images/" + p.ImageFile + "</span>'"; 
                    string datasound = string.Empty;
                    if (learn != null)
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";

                    string cssclass = "class='screenshot'";
                    string datagrouping = "data-elementgrouping='sentence_" + p.SentenceID.ToString() + "'";
                    if (string.IsNullOrEmpty(p.ImageFile))
                    {
                        cssclass = string.Empty;
                        dataimage = string.Empty;
                    }
                    string imagesequence = "<img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; position:absolute;top:-5px;right:-5px;display:none;\"/>";
                    if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
                    {
                        imagesequence = "<img class='imgsequence' src=\"../Images/red{1}.png\" style=\"width:20px; height:20px; position:absolute;top:-5px;right:-5px;display:none;\"/>";
                    }

                    //string smallspeaker = string.Format("<img class='imgsmallspeaker' src=\"../Images/wordspeaker.png\" style=\"width:20px; height:20px;\" onclick='worddblClick(\"div{0}\")'/>", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString());

                    ////string edit = string.Format("<img id='img{0}' src='../Images/Ico_edit.png' class='addreplaceword' onclick='InitializeReplaceWordSettings(this);' />", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString());
                    //string edit = string.Format("<img id='img{0}' src='../Images/swapoutline.png' class='addORreplaceword' onclick='InitializeReplaceWordSettings(this);' />", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString());
                    //if (string.IsNullOrEmpty(p.WordType))
                    //    edit = string.Empty;
                    //p.ImageFile = "../Images/swapoutline.png";

                    //string showimage = (p.ImageFile.Length > 0 || learn.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px;\" onclick='ShowPicture(event)'/></a>" : string.Empty);

                    //div = string.Format("<div id=\"div{0}\" {4} style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;padding-left:10px;padding-bottom:2px;position:relative;\" data-isword=\"false\" ondblclick='worddblClick(\"div{0}\")'  onclick=\"wordClick('div{0}', true, true, event);\" {3} {5} {6}>" +

                    div = string.Format("<div class='phraseContainer {10}' id=\"div{0}\" {4} data-isword=\"false\" ondblclick='worddblClick(\"div{0}\")' {3} {5} {6} data-wordtype='{9}'>" +
                    imagesequence + "{2} {7} {8}" +
                    "</div>", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString() +
                    (own ? "myOwnPalette" : ""), learn.Ordinal.ToString(), words, dataimage, cssclass, datasound, datagrouping, "", "", p.WordType, p.WordType.Trim().Length > 0 ? "replaceable" : string.Empty);

                    //m@s
                    //cPaletteDiv = div;
                    div = string.Empty;


                    //"<span style='float:right;'><img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; float:right;\" onclick=\"alert('bong');\"/><span>" +
                    li.Attributes.Add("data-ordinalNative", p.Ordinal.ToString());

                    li.Attributes.Add("data-ordinalLearning", learn != null ? learn.Ordinal.ToString() : "0");
                    li.InnerHtml = div;

                    ////m@s
                    ////childul.Attributes.Add("style", "display: none !important;");
                    //li.Attributes.Add("style", "display: none !important;");
                    //string Li_Id = paleteContract.PaletteID.ToString() + "Li_" + eBtnId.ToString();
                    //li.Attributes.Add("id", Li_Id);
                    ////editButton.Attributes.Add("onclick", "editButtonOnClick(this, " + paleteContract.PaletteID.ToString() + sentenceid.ToString() + ")");
                    ////editButton.Attributes.Add("onclick", "editButtonOnClick(this, " + ul_Id + ")");
                    //editButton.Attributes.Add("onclick", "editButtonOnClick(this, '" + Li_Id + "')");


                    childul.Controls.Add(li);
                    sentenceid = p.SentenceID;
                }

                //HtmlGenericControl nativelanguageContainer = new HtmlGenericControl("div");
                //nativelanguageContainer.InnerHtml = nativelanguage;
                //nativelanguageContainer.Attributes.Add("class", "nativelanguageContainer");

                childul.Attributes.Add("data-sentence1Ordinal", sentence1ordinal);
                childul.Attributes.Add("data-sentence2Ordinal", sentence2ordinal);
                childul.Attributes.Add("style", "padding:0px;");

                //m@s
                string ul_Id = paleteContract.PaletteID.ToString() + "ul_" + eBtnId.ToString();
                childul.Attributes.Add("id", ul_Id);
                childul.Attributes.Add("style", "display: none !important;");
                //editButton.Attributes.Add("onclick", "editButtonOnClick(this, " + paleteContract.PaletteID.ToString() + sentenceid.ToString() + ")");
                //editButton.Attributes.Add("onclick", "editButtonOnClick(this, " + ul_Id + ")");
                editButton.Attributes.Add("onclick", "editButtonOnClick(this, '" + ul_Id + "')");




                parentli.Attributes.Add("class", "pallete");
                parentli.Attributes.Add("data-sentencesound", soundfilelearning);

                parentli.Controls.Add(childul);
                //parentli.Controls.Add(nativelanguageContainer);
                parentul.Controls.Add(parentli);
            }


            if (own)
                sentenceContainerOwnPalette.Controls.Add(parentul);
            else
                sentenceContainer.Controls.Add(parentul);

            hdnOtherLanguageCode.Value = new JavaScriptSerializer().Serialize(SessionManager.Instance.UserProfile.OtherLanguages);
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
            m_IsUserSearch = true;
            hdnwordpage.Value = "1";
            hdnsentencepage.Value = "1";
            hdnsentencepageUserPalette.Value = "1";
            this.Keyword = "";
            UpdatePalette(false);

        }

        private void UpdatePalette(bool all)
        {
            string changeactivetab = "";
            if (!string.IsNullOrEmpty(hdnKeywords.Value))
            {
                ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
                ddlCategory.SelectedIndex = 0;
                ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;
                this.Keyword = hdnKeywords.Value;
                updCategory.Update();
            }

            if (txtSearchSentence.Text.Length > 0 && ddlCategory.SelectedIndex > 0)
                ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;

            //if(hdnAutoSearch.Value == "1")
            //{
            //    rdoCriteriaList.SelectedValue = "0";
            //}
            //if (rdoCriteriaList.SelectedValue == "0")//All
            //{
            if (all)
            {
                SearchWords();
                SearchSentence();
                SearchWordsUserCreated();
                changeactivetab = "changeActiveTab();";
            }
            else
            {
                //UpdatePanel2.Triggers.Clear();//.RemoveAt(0);
                //SearchWords();
                //SearchWordsUserCreated();
                SearchSentence();
            }
            // }
            // else if (rdoCriteriaList.SelectedValue == "1")//Word
            //{
            //    UpdatePanel2.Triggers.Clear();//.RemoveAt(0);
            //    SearchWords();
            //    SearchWordsUserCreated();

            //    if (!string.IsNullOrEmpty(hdnPrepareWordReplaceElementID.Value))
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "PrepareWordReplace_" + Guid.NewGuid().ToString().Replace("-", ""), string.Format("PrepareReplaceWordSettings('{0}');", hdnPrepareWordReplaceElementID.Value), true);
            //    }

            //        //SearchSentence();
            //}
            if (!string.IsNullOrEmpty(hdnPrepareWordReplaceElementID.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "PrepareWordReplace_" + Guid.NewGuid().ToString().Replace("-", ""), string.Format("PrepareReplaceWordSettings('{0}');", hdnPrepareWordReplaceElementID.Value), true);
            }

            if (hdnAutoSearch.Value == "1")
            {
                hdnAutoSearch.Value = "0";
            }

            if (txtSearchSentence.Text.Length > 0)
                ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();InitializeTooltipSteps();" + changeactivetab, true);
            //UpdatePanel1.Update();
        }

        private void SearchSentence(bool own = false)
        {
            //if (rdoCriteriaList.SelectedValue == "1" && hdnCurrentTab.Value == "0") //Word
            //    return;

            int virtualcount = CreatePalleteList(own);
            int rowsperpage = own ? m_MySentenceRowPerPage : m_SentenceRowPerPage;
            int numberofpages = virtualcount / rowsperpage;
            if (virtualcount % rowsperpage > 0)
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
            string switchlanguageorder = "";// "SwitchLanguageOrder('.chkLanguageOrder');";
            string minheight = "";
            string highlight = "";
            if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
                switchlanguageorder = "";
            else if (SessionManager.Instance.UserProfile.NativeLanguage == "ja-JP")
                minheight = "setMinHeight();";

            if (hdnAutoSearch.Value == "1")
            {
                highlight = "HighlightPalette();";
            }

            //chkLanguageOrder.Checked = true;

            builder.AppendLine("changeOwnPaletteButton();HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable(); HideShowSequence('#" + chkSequence.ClientID + "');" + switchlanguageorder + "SwitchWords('.chkSubLanguage2');HideSequence();InitializeTooltipSteps();" + minheight + highlight);
            //builder.AppendLine("$('.sortable').sortable();HideShowWords('#chkNative', '.secondword'); HideShowWords('#chkSecondary', '.thirdword'); screenshotPreview();SetPalleteSelectable();");
            int pagenumber = own ? Convert.ToInt32(hdnsentencepageUserPalette.Value) : Convert.ToInt32(hdnsentencepage.Value);

            if (own)
                builder.AppendFormat("ActivateSentencePagingForUserPalette({0},{1});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString());
            else
                builder.AppendFormat("ActivateSentencePaging({0},{1});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString());

            builder.AppendLine("});");

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreatePalleteList" + own.ToString(), builder.ToString(), true);
            if (own)
                updOwnPalette.Update();
            else
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
            //builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); HideShowSequence('#" + chkSequence.ClientID + "');");
            builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword');ShowHideSubLanguage2();InitializeTooltipSteps();");
            int pagenumber = Convert.ToInt32(hdnwordpage.Value);
            builder.AppendFormat("ActivateWordPaging({0},{1});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString()); ;
            builder.AppendLine("});");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateWordList", builder.ToString(), true);
            UpdatePanel1.Update();


        }

        private void SearchWordsUserCreated()
        {
            int virtualcount = CreateWordListForUserCreated();
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
            builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); HideShowSequence(null);InitializeTooltipSteps();ShowHideSubLanguage2();");
            int pagenumber = Convert.ToInt32(hdnwordpageusercreated.Value);
            builder.AppendFormat("ActivateWordPagingUserCreated({0},{1}, {2});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString(), IsPostBack.ToString().ToLower()); ;
            builder.AppendLine("});");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateWordListUserCreated", builder.ToString(), true);
            UpdatePanel3.Update();


        }

        private int CreateWordListForUserCreated()
        {
            try
            {

                PaletteServiceClient pclient = new PaletteServiceClient();
                int virtualcount = 0;
                //string json = pclient.SearchWord(new SearchDTO() { SchoolID= SessionManager.Instance.UserProfile.SchoolID, CategoryID = Convert.ToInt64( ddlCategory.SelectedValue ), Keyword = txtSearchSentence.Text, PageNumber = Convert.ToInt32(hdnwordpage.Value), RowsPerPage = m_WordRowPerPage }, out virtualcount);

                string wordtype = hdnWordType.Value;

                SearchDTO dto = new SearchDTO()
                {
                    UserID = SessionManager.Instance.UserProfile.UserID,
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID,
                    CategoryID = Convert.ToInt64(ddlCategory.SelectedValue),
                    Word = txtSearchWord.Text,
                    Keyword = txtSearchWord.Text,
                    PageNumber = Convert.ToInt32(hdnwordpageusercreated.Value),
                    RowsPerPage = m_WordRowPerPage,
                    IsTalk = true,
                    WordType = string.Empty,
                    UserCreatedWord = true
                };

                if (dto.CategoryID == 0)
                {
                    foreach (ListItem item in ddlCategory.Items)
                    {
                        if (item.Value == "0")
                            continue;

                        dto.CategoryIDs += item.Value + ",";
                    }
                }
                else
                {
                    dto.CategoryIDs = ddlCategory.SelectedValue;
                }
                if (!string.IsNullOrEmpty(this.Keyword) && string.IsNullOrEmpty(txtSearchSentence.Text))
                {
                    dto.CategoryID = 0;
                    //dto.Word = this.Keyword.Replace("&#39;", "'"); //for talk only
                    dto.Keyword = this.Keyword.Replace("&#39;", "'");
                }
                if (!string.IsNullOrEmpty(hdnWordKeyword.Value) && string.IsNullOrEmpty(txtSearchSentence.Text))
                {
                    dto.Word = string.Empty;
                    dto.Keyword = hdnWordKeyword.Value;
                }
                //if (!string.IsNullOrEmpty(txtSearchSentence.Text))
                //dto.WordType = string.Empty;

                if (!string.IsNullOrEmpty(txtSearchSentence.Text) && dto.WordType.Length > 0)
                {
                    dto.Word = string.Empty;
                    dto.Keyword = string.Empty;
                }
                //if (!string.IsNullOrEmpty(txtSearchSentence.Text))
                //dto.WordType = string.Empty;

                //if (string.IsNullOrEmpty(dto.WordType))
                //{
                //    if (IsSearchFromHistory)
                //    {

                //        SearchDTO dt = GetSearchWordDto();
                //        if (dt != null)
                //            dto = dt;

                //        hdnwordpage.Value = dto.PageNumber.ToString();
                //        hdnCategory.Value = dto.CategoryID.ToString();
                //        ddlCategory.SelectedValue = dto.CategoryID.ToString();
                //        m_SearchText = dto.Word;
                //        hdnWordType.Value = dto.WordType;
                //    }
                //    else
                //    {
                //        AddSearchWordList(dto);
                //    }
                //}


                string json = pclient.SearchWord(dto, out virtualcount);
                List<WordContract> list = new JavaScriptSerializer().Deserialize<List<WordContract>>(json);
                //if(virtualcount == 0 && !string.IsNullOrEmpty(dto.Keyword) )
                //{
                //    dto.Keyword = string.Empty;
                //    json = pclient.SearchWord(dto, out virtualcount);
                //    list = new JavaScriptSerializer().Deserialize<List<WordContract>>(json);
                //}

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
                    string delete = string.Format("<img class='imgRemoveMessage' src='../Images/ico_delete.png' style='width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;' onclick='return RemoveUserWord(event,this);' data-id='{0}' />", wc.WordMapID.ToString());
                    if (string.IsNullOrEmpty(wc.ImageFile))
                        dimage = string.Empty;


                    var learn = plearninglist.Find(x => x.WordMapID.Equals(wc.WordMapID));
                    if (learn != null)
                    {
                        words = string.Format("<span id='{0}' class='firstword' data-lang='{1}' data-switchword='{2}' data-word='{3}' {4} data-sound='{5}'>", "divspanword" + wc.WordID.ToString(), wc.LanguageCode, wc.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", wc.Word, dimage, "../Content/sound/" + learn.SoundFile) + wc.Word + "</span>" + "<br/>";
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + learn.WordID.ToString(), cl, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage, "../Content/sound/" + wc.SoundFile) + learn.Word + "</span>" + "<br/>";
                    }
                    else
                    {
                        words = string.Format("<span id='{0}' class='firstword' data-lang='{1}' data-switchword='{2}' data-word='{3}' {4} data-sound='{5}'>", "divspanword" + wc.WordID.ToString(), wc.LanguageCode, wc.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", wc.Word, dimage, "") + wc.Word + "</span>" + "<br/>";
                    }

                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(wc.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}'>", "divspan" + sub.WordID.ToString(), cl) + sub.Word + "</span>" + "<br/>";
                    }

                    foreach (string lang in SessionManager.Instance.UserProfile.OtherLanguages)
                    {

                        var otherlanguage = list.FindAll(x => x.LanguageCode.Equals(lang)).ToList();
                        if (otherlanguage != null)
                        {
                            if (learn == null)
                                learn = wc;

                            var otherword = otherlanguage.Find(x => x.WordMapID.Equals(learn == null ? wc.WordMapID : learn.WordMapID));
                            if (otherword != null)
                            {
                                string cl = "otherword";
                                string sfile = "";
                                if (learn != null)
                                    sfile = "'../Content/sound/" + learn.SoundFile;
                                words += string.Format("<span id='{0}' class='{1}' style='display:none;' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + otherword.WordID.ToString(), cl, otherword.LanguageCode, otherword.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", otherword.Word, dimage, sfile) + otherword.Word + "</span>";                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
                            }
                        }
                    }

                    string datasound = string.Empty;
                    if (learn != null)
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";


                    string div = string.Format("<div id=\"div{0}\" class=\"screenshot wordbox\" style=\"text-align:center;background-color:white;cursor:pointer;position:relative;\" data-isword=\"true\" ondblclick=\"worddblClick('div{0}');\" onclick=\"wordClick('div{0}', false,true, event, true);\" data-image=\"../Content/images/" + wc.ImageFile + "\" {2} >" +
                        (wc.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + wc.ImageFile + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; position:absolute;top:-5px;left:-5px;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                                "{1} {3}" +
                                "</div>", wc.WordID.ToString() + learn.WordID.ToString() + (sub == null ? string.Empty : sub.WordID.ToString()), words, datasound, delete);
                    li.InnerHtml = div;
                    parentul.Controls.Add(li);
                }
                divWordContainerUserCreated.Controls.Add(parentul);

                return virtualcount;

            }
            catch (Exception ex)
            {
                throw ex;
            }
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
                    umc.HasResponse = false;
                    //umc.Subject = txtSubject.Text;

                }

                msgList.Add(umc);
            }
            //string s = Utility.SerializeObjectToXML(msgList);

            UserClient client = new UserClient();
            string json = new JavaScriptSerializer().Serialize(msgList);
            long[] ids = client.SaveMessage(json);
            if (ids != null)
            {
                //Response.Redirect("MailBox");
            }
        }

        protected void btnSearchSentence_Click(object sender, EventArgs e)
        {
            try
            {
                m_IsUserSearch = true;
                SearchSentence();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();", true);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void btnSearchSentenceUserPalette_Click(object sender, EventArgs e)
        {
            try
            {
                m_IsUserSearch = true;
                SearchSentence(true);
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
                m_IsUserSearch = true;
                SearchWords();
                SearchWordsUserCreated();
                if (!string.IsNullOrEmpty(hdnPrepareWordReplaceElementID.Value))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "PrepareWordReplace_" + Guid.NewGuid().ToString().Replace("-", ""), string.Format("PrepareReplaceWordSettings('{0}');", hdnPrepareWordReplaceElementID.Value), true);
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        protected void imgSearchWord_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                m_IsUserSearch = true;
                SearchWords();
                SearchWordsUserCreated();
                if (!string.IsNullOrEmpty(hdnPrepareWordReplaceElementID.Value))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "PrepareWordReplace_" + Guid.NewGuid().ToString().Replace("-", ""), string.Format("PrepareReplaceWordSettings('{0}');", hdnPrepareWordReplaceElementID.Value), true);
                }
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

                Label you = (Label)e.Item.FindControl("lblYou");
                Label me = (Label)e.Item.FindControl("lblMe");
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
                    //me.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/no_avatar.png";
                    you.Visible = false;
                    me.Visible = true;
                }
                else
                {
                    //you.ImageUrl = u.SenderAvatar.Length > 0 ? "../Images/avatar/" + u.SenderAvatar : "../Images/no_avatar.png";
                    //me.ImageUrl = u.RecepientAvatar.Length > 0 ? "../Images/avatar/" + u.RecepientAvatar : "../Images/avatar/no_avatar.png";
                    you.Visible = true;
                    me.Visible = false;
                }

                //if (u.IsLike)
                //{
                //    string origurl = imgLikeMessage.ImageUrl;
                //    imgLikeMessage.ImageUrl = imgLikeMessage.Attributes["data-swap"];
                //    imgLikeMessage.Attributes["data-swap"] = origurl;
                //}
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
                //string json = client.SearchPeople(0, 0, "Friends", name, SessionManager.Instance.UserProfile.UserID);
                //List<PeopleSearchContract> people = new JavaScriptSerializer().Deserialize<List<PeopleSearchContract>>(json);

                string json = client.GetUserDetails(userid);
                UserContract people = new JavaScriptSerializer().Deserialize<UserContract>(json);

                if (people != null) //&& people.Count > 0)
                {
                    var p = people;
                    imgAvatar.ImageUrl = "../Images/avatar/" + p.Avatar;
                    imgAvatar.Attributes["data-userid"] = p.UserID.ToString();
                    lblFirstNAme.Text = p.FirstName;
                    lblLastName.Text = p.UserName;
                    string js = new MiscService.MiscServiceClient().GetCityOtherName(p.CityID, Constants.English);
                    List<CityContract> list = new JavaScriptSerializer().Deserialize<List<CityContract>>(js);

                    lblAddress.Text = ((list != null && list.Count > 0) ? list[0].CityName : string.Empty) + "," + p.CountryName;

                    imgStatus.ImageUrl = p.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                    lblOnlineStatusText.Text = p.IsOnline ? "Online Now" : "Offline Now";
                    //imgLike.ImageUrl = p.ILike ? "../Images/heartUnlike.png" : "../Images/heartLike.png";
                    //imgLike.ImageUrl = "../Images/heartUnlike.png" : "../Images/heartLike.png";
                    //lblStatusText.Text = p.StatusText;
                    //lblLikeCount.Text = p.LikeCount.ToString();
                }

                //json = client.GetMessageTrailBySenderID(userid, SessionManager.Instance.UserProfile.UserID, Convert.ToInt32(hdnPageNumber.Value), 5);
                json = client.GetMessageTrailBySenderID(userid, SessionManager.Instance.UserProfile.UserID, 1, 5);
                List<UserMessageContract> messages = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                if (messages == null)
                {
                    messages = new List<UserMessageContract>();
                }
                if (messages != null)
                {
                    foreach (UserMessageContract msg in messages)
                    {
                        //msg.RecepientAvatar = msg.RecepientAvatar.Length > 0 ? "../Images/avatar/" + msg.RecepientAvatar : "../Images/avatar/no_avatar.png";
                        //msg.SenderAvatar = msg.SenderAvatar.Length > 0 ? "../Images/avatar/" + msg.SenderAvatar : "../Images/avatar/no_avatar.png";
                        msg.IsReply = msg.SenderID == SessionManager.Instance.UserProfile.UserID;
                        //msg.CssClass = msg.IsReply ? "newbubble newyou" : "newbubble newme";
                        msg.CssClass = msg.IsReply ? "newbubble newyou" : "newbubble newme";
                        msg.CssClass = msg.ReadDate == DateTime.MinValue && !msg.IsReply ? msg.CssClass + " new" : msg.CssClass + " old";
                        //msg.CssClass2 = msg.IsReply ? "newbubble1 newyou" : "newbubble1 newme";
                        msg.CssClass2 = "newbubble1 ";


                        //msg.NativeLanguageMessage = msg.IsReply
                        //? msg.NativeLanguageMessage
                        ////: msg.NativeLanguageMessageRecepient;
                        //: string.IsNullOrEmpty(msg.NativeLanguageMessageRecepient) ? msg.NativeLanguageMessage : msg.NativeLanguageMessageRecepient;

                        //msg.LearningLanguageMessage = msg.IsReply
                        //    ? msg.LearningLanguageMessage
                        //    //: msg.LearningLanguageMessageRecepient;
                        //    : string.IsNullOrEmpty(msg.LearningLanguageMessageRecepient) ? msg.LearningLanguageMessage : msg.LearningLanguageMessageRecepient;


                        msg.NativeLanguageMessage = msg.IsReply
                        ? msg.NativeLanguageMessage
                        //: msg.NativeLanguageMessageRecepient;
                        : string.IsNullOrEmpty(msg.NativeLanguageMessageRecepient) ? msg.NativeLanguageMessage : msg.NativeLanguageMessageRecepient;

                        msg.LearningLanguageMessage = msg.IsReply
                            ? msg.LearningLanguageMessage
                            //: msg.LearningLanguageMessageRecepient;
                            : string.IsNullOrEmpty(msg.LearningLanguageMessageRecepient) ? msg.LearningLanguageMessage : msg.LearningLanguageMessageRecepient;


                        // = msg.IsReply ? "bubble you" : "bubble me";
                    }
                    rptConversation.DataSource = messages;
                    rptConversation.DataBind();

                    client.MarkMessageAsRead(userid, SessionManager.Instance.UserProfile.UserID);

                    SiteMaster x = (SiteMaster)this.Master;
                    x.UpdateMailCount();

                    if (messages.Count > 0)
                    {
                        UserMessageContract msg = messages[messages.Count - 1];
                        this.Keyword = msg.Keyword;
                        if (!string.IsNullOrEmpty(msg.Keyword))
                        {
                            hdnKeywords.Value = msg.Keyword;
                        }
                        //UpdatePalette();
                    }


                }
                //else if(people.FirstName.Equals(ConfigurationManager.AppSettings["TalkTestUser"], StringComparison.OrdinalIgnoreCase))
                //{
                UpdatePalette(true);
                //}

                updMessages.Update();
                updateSelectedUser.Update();

                string script = "AttachPlaysound();$('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);ChangeConversationColor();showCallButton();DisableEnableCallButton();";
                //if ( chkCallInProgress.Checked )
                //script += " toggleCallInProgress();";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollnow", script, true);


            }
            catch (Exception)
            {

                throw;
            }
        }

        private List<UserSearchContract> BindFriends(string name)
        {


            //string json = new UserClient().SearchUserWithMessage(name, SessionManager.Instance.UserProfile.UserID, MailBoxUserType.All);
            List<UserSearchContract> people = new UserRepository().SearchUserWithMessage(name, SessionManager.Instance.UserProfile.UserID, MailBoxUserType.All, true);
            //List<UserSearchContract> people = new JavaScriptSerializer().Deserialize<List<UserSearchContract>>(json);
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


        private List<UserContract> BindFriends()
        {
            List<UserContract> people = new List<UserContract>();
            try
            {
                MatchMakerRepository rep = new MatchMakerRepository();
                //List<ScheduleContract> list = rep.GetScheduleByUserId(SessionManager.Instance.UserProfile.UserID);

                //List<UserContract> people = new List<UserContract>();
                List<ScheduleContract> infos = GetScheduledPartner();
                if (infos != null)
                {
                    SessionManager.Instance.UserProfile.Schedules = infos;
                    foreach (ScheduleContract info in infos)
                    {

                        long partnerId = info.PartnerId.HasValue ? info.PartnerId.Value : 0;
                        if (partnerId == SessionManager.Instance.UserProfile.UserID)
                        {
                            partnerId = info.UserId;
                        }
                        if (people.Find(x => x.UserID.Equals(partnerId)) != null)
                        {
                            continue;
                        }
                        UserContract person = new UserRepository().GetUserDetails(partnerId);
                        if (person != null)
                        {
                            person.Avatar = person.Avatar.Length > 0 ? "../Images/avatar/" + person.Avatar : "../Images/no_avatar.png";
                            person.StatusImage = person.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                            person.OnlineStatusText = person.IsOnline ? "Online" : "Offline";

                            people.Add(person);
                            rptFriends.DataSource = people;
                            rptFriends.DataBind();

                        }
                        else
                        {
                            rptFriends.DataSource = null;
                            rptFriends.DataBind();
                        }
                    }
                    if (people.Count() > 0)
                    {
                        hdnSelectedUserID.Value = people[0].UserID.ToString();
                    }
                    if (infos.Count() > 0)
                    {
                        ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
                        ddlCategory.SelectedValue = infos[0].UserId == SessionManager.Instance.UserProfile.UserID ? infos[0].PhraseCategoryID.ToString() : infos[0].PartnerPhraseCategoryID.ToString();
                        ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;
                    }

                    updFriends.Update();

                }
            }
            catch (Exception ex)
            {
                Logger.ErrorLog(ex.Message + ex.StackTrace + " METHOD:" + System.Reflection.MethodBase.GetCurrentMethod().Name);
            }



            return people;
        }

        protected void btnGetUserMessage_Click(object sender, EventArgs e)
        {
            try
            {
                m_IsUserSearch = false;
                //rdoCriteriaList.SelectedIndex = 0;
                GetUserMessage();
                if (hdnButtonType.Value == "Ready")
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "buttontypes", "ImReady();", true);
                else if (hdnButtonType.Value == "Issues")
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "buttontypes", "Issues();", true);

                //rdoCriteriaList.SelectedIndex = 1;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }



        public void LogFile(string message)
        {
            StreamWriter log;
            if (!File.Exists(Server.MapPath("logfile.txt")))
            {
                log = new StreamWriter(Server.MapPath("logfile.txt"));
            }
            else
            {
                log = File.AppendText(Server.MapPath("logfile.txt"));
            }
            log.WriteLine("Message: " + message);
            log.Close();

        }

        private T FindControlFromMaster<T>(string name) where T : Control
        {
            MasterPage master = this.Master;
            while (master != null)
            {
                T control = master.FindControl(name) as T;
                if (control != null)
                    return control;

                master = master.Master;
            }
            return null;
        }

        //private void SetupCallTimer()
        //{
        //    try
        //    {
        //        Repository.UserRepository rep = new Repository.UserRepository();
        //        UserTalkSubscription sub = rep.GetUserTalkSubscription(SessionManager.Instance.UserProfile.UserName);
        //        string sessiontime = "0min";
        //        string totaltime = "0min";
        //        if (sub != null)
        //        {
        //            hdnSubscriptionID.Value = sub.UserTalkSubscriptionID.ToString();
        //            sessiontime = sub.SessionTime.ToString() + "min";
        //            totaltime = sub.TotalTime.ToString() + "min";
        //        }
        //        Label lblsessionTime = FindControlFromMaster<Label>("sessionTime");
        //        if (lblsessionTime != null)
        //            lblsessionTime.Text = sessiontime;

        //        Label lbltotalTime = FindControlFromMaster<Label>("totalTime");
        //        if (lbltotalTime != null)
        //            lbltotalTime.Text = totaltime;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        private void SetupCallTimer()
        {
            try
            {
                Repository.UserRepository rep = new Repository.UserRepository();
                UserTalkSubscription sub = rep.GetUserTalkSubscription(SessionManager.Instance.UserProfile.UserName);
                string sessiontime = "0min";
                //string totaltime = "0min";
                if (sub != null)
                {
                    hdnSubscriptionID.Value = sub.UserTalkSubscriptionID.ToString();
                    sessiontime = sub.SessionTime.ToString() + "min";
                    // totaltime = sub.TotalTime.ToString() + "min";
                }
                if (sessionTime != null)
                    sessionTime.Text = sessiontime;

                //if (totalTime != null)
                //    totalTime.Text = totaltime;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //protected void btnSaveParentsInfo_Click(object sender, EventArgs e)
        //{
        //    if (!SessionManager.Instance.UserProfile.IsParentsInfoStored)
        //    {
        //        ZendeskRepository rep = new ZendeskRepository();
        //        ZendeskUser user = new ZendeskUser();

        //        user = rep.GetZendeskEndUser(SessionManager.Instance.UserProfile.LinkKey);

        //        if (user != null && user.User != null ) //&& (String.IsNullOrEmpty(user.User.Phone) || String.IsNullOrEmpty(user.User.UserFields.ParentsName)) )
        //        {
        //            user.User.Phone = hdnPhoneNumber.Value;
        //            user.User.UserFields = new UserFields() { ParentsName = hdnParentsName.Value };
        //            bool updated = rep.UpdateUser(user);
        //            if (updated)
        //            {
        //                updated = new UserRepository().UpdateUserParentsInfo(SessionManager.Instance.UserProfile.UserID);
        //                SessionManager.Instance.UserProfile.IsParentsInfoStored = updated;
        //                hdnParentsInfoFlag.Value = updated.ToString();
        //            }
        //        }
        //    }
        //}



    }
}