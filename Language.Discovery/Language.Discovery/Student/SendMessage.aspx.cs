using System;
using System.Collections;
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
using System.Threading;
using Language.Discovery.Helper;
using System.Text.RegularExpressions;
using System.Web.Services;

namespace Language.Discovery
{
	public partial class SendMessage : System.Web.UI.Page
	{
		
		private int m_SentenceRowPerPage = Convert.ToInt32(ConfigurationManager.AppSettings["SentenceRowsPerPage"]);
		private int m_WordRowPerPage = Convert.ToInt32(ConfigurationManager.AppSettings["WordRowsPerPage"]);
        private int m_SearchHistoryLimit = Convert.ToInt32(ConfigurationManager.AppSettings["SearchHistoryLimit"]);
        private bool m_IsCategoryTriggered = false;
        private bool m_IsBack = false;
        private bool m_IsSearchAll = false;
        private string m_SearchText = string.Empty;

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

		private List<PhraseCategoryContract> CategoryList
		{
			get
			{
				List<PhraseCategoryContract>  list = null;
				if (ViewState["CategoryList"] != null)
					list = (List<PhraseCategoryContract>)ViewState["CategoryList"];
				return list;
			}
			set
			{
				ViewState["CategoryList"] = value;
			}
		}

		private List<TopCategoryContract> TopCategoryList
		{
			get
			{
				List<TopCategoryContract> list = null;
				if (ViewState["TopCategoryList"] != null)
					list = (List<TopCategoryContract>)ViewState["TopCategoryList"];
				return list;
			}
			set
			{
				ViewState["TopCategoryList"] = value;
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

				if (!IsPostBack)
				{
                    hdnIsFirstLogin.Value = (SessionManager.Instance.UserProfile.LastLogin == DateTime.MinValue) ? "1" : "0";
                    string dst = Request.QueryString["dst"];
					this.Keyword = Request.QueryString["k"];
					
					if (!string.IsNullOrEmpty(dst) && dst == "1")
					{
						if (new UserClient().UpdateUserDontShowNewTab(SessionManager.Instance.UserProfile.UserID, true))
							SessionManager.Instance.UserProfile.DontShowNewTab = true;
					}

                    bool isDirectReply = string.IsNullOrEmpty(Request.QueryString["dr"]) ? false : true;
                    string showfloat = "";
                    if (isDirectReply)
                    {
                        showfloat = "showFloatButton();showMessage();";
                        
                    }
                    PopulateDropDownList();
					LoadSenderDetails();
					LoadToDetails();
					CreateSuggestion();
					hdnNativeLanguageCode.Value = SessionManager.Instance.UserProfile.NativeLanguage;
					hdnLearningLanguageCode.Value = SessionManager.Instance.UserProfile.LearningLanguage;
                    imgBack.Visible = false;
                    imgForward.Visible = false;
                    SetOptions();
                    SearchAll();
                    LoadSavedMessage();
                    hdnIsDemo.Value = Convert.ToByte(SessionManager.Instance.UserProfile.IsDemo).ToString();
                    hdnCurrentUser.Value = SessionManager.Instance.UserProfile.UserID.ToString();
					 //string script = "$(function () {";
					 //script += "$('#tabs').tabs();});";
					ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearSessionStoragescript", "ClearSessionStorage();" + showfloat, true);
				}
				//this.Form.DefaultButton = imgSearchSentence.UniqueID;
				//this.Form.DefaultFocus = txtSearchSentence.UniqueID;
				if (SessionManager.Instance.UserProfile.IsDemo && SessionManager.Instance.SchoolProfile.IsRobot)
				{
					txtSearchSentence.Enabled = false;
				}
			}
			catch (Exception)
			{

				throw;
			}

		}

		private void SetOptions()
		{
			if (SessionManager.Instance.UserProfile.NativeLanguage == "ja-JP" || SessionManager.Instance.UserProfile.NativeLanguage == "zh-CN")
			{
				//data-on="info" data-off="danger" data-on-label="ENG" data-off-label="JP">
				//divRomanji.Visible = false;
				//divorder.Attributes["data-on"] = "danger";
				//divorder.Attributes["data-off"] = "info";
				//divorder.Attributes["data-on-label"] = "JP";
				//divorder.Attributes["data-off-label"] = "EN";

				//divShowTranslation.Attributes["data-on-label"] = "<i class='icon-ok icon-white'><img src='../Images/en-US.png' style='width:16x;height;16px;'/></i>";
				//divShowTranslation.Attributes["data-off-label"] = "<i class='icon-ok icon-white'><img src='../Images/ja-JP.png' style='width:16x;height;16px;'/></i>";
				chkLanguageOrder.Checked = true;
				divRomanji.Visible = true;
				chkSecondary.Checked = false;
				chkSecondary.Attributes.Add("disabled", "disabled");
			}
			else
			{
				divRomanji.Visible = true;
				chkLanguageOrder.Checked = false ; 
			}

			if (SessionManager.Instance.UserProfile.IsOptionUpdated)
			{
				chkSequence.Checked = SessionManager.Instance.UserProfile.SequenceOptionFlag;
				chkNative.Checked = SessionManager.Instance.UserProfile.NativeOptionFlag;
				chkSecondary.Checked = SessionManager.Instance.UserProfile.SubLanguageOptionFlag;
				chkSubLanguage2.Checked = SessionManager.Instance.UserProfile.SubLanguage2OptionFlag;
			}
			else
			{
				chkSequence.Checked = SessionManager.Instance.SchoolProfile.ShowPhraseOrder;
				chkNative.Checked = SessionManager.Instance.SchoolProfile.ShowNativeLanguage;
				chkSubLanguage2.Checked = SessionManager.Instance.SchoolProfile.ShowSubLanguage2;
			}
            imgFreeFormMessage.Visible = SessionManager.Instance.UserProfile.EnabledFreeMessage;
            lblFreeMessageLabel.Visible = imgFreeFormMessage.Visible;
            chkTooltip.Checked = SessionManager.Instance.UserProfile.StepOptionFlag;
            chkOrderByLearningLanguage.Checked = SessionManager.Instance.UserProfile.OrderByLearningLanguageFlag;
            //if (!SessionManager.Instance.SchoolProfile.ShowPhraseOrder)
            //{
            //    chkSequence.Checked = SessionManager.Instance.SchoolProfile.ShowPhraseOrder;
            //    chkSequence.Attributes.Add("disabled", "disabled");
            //}
            //if (!SessionManager.Instance.SchoolProfile.ShowNativeLanguage)
            //{
            //    chkNative.Checked = SessionManager.Instance.SchoolProfile.ShowNativeLanguage;
            //    chkNative.Attributes.Add("disabled", "disabled");
            //}
            //if (SessionManager.Instance.SchoolProfile.ShowSubLanguage2)
            //{
            //    chkSubLanguage2.Checked = SessionManager.Instance.SchoolProfile.ShowSubLanguage2;
            //    //chkNative.Attributes.Add("disabled", "disabled");
            //}

            //chkLanguageOrder.Checked = (SessionManager.Instance.SchoolProfile.DefaultLanguageOrder != SessionManager.Instance.UserProfile.LearningLanguage);

        }

		protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				m_IsCategoryTriggered = true;
				TriggerCategorySearch();
			}
			catch (Exception ex)
			{
				throw ex;
			}
		}

		private void TriggerCategorySearch()
		{
			if (hdnIsDropDownChangeFromClient.Value == "1")
			{
				hdnIsDropDownChangeFromClient.Value = "0";
				ScriptManager.RegisterStartupScript(this, this.GetType(), "dropdownchange" + Guid.NewGuid().ToString().Replace("-", ""), "ChangeTheIsDropDownChange('0');", true);
				return;
			}


			//if (rdoCriteriaList.SelectedValue == "0")//All
			//{
			//    SearchWords();
			//    SearchSentence();
			//}
			//else if (rdoCriteriaList.SelectedValue == "1")//Word
			//{
			//    UpdatePanel2.Triggers.RemoveAt(1);
			//    SearchWords();
				//SearchSentence();
			//}

		    hdnwordpage.Value = "1";
            hdnwordpageusercreated.Value = "1";
            hdnsentencepage.Value = "1";

            SearchAll();
			ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();", true);

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
				string shouldgetdefault = Request.QueryString["du"];
				UserClient client = new UserClient();
				if (!string.IsNullOrEmpty(shouldgetdefault) && shouldgetdefault == "1")
				{
					int[] items = new int[]{};
					
					string js = client.DiscoverNewFriends2(items,0, string.Empty, SessionManager.Instance.UserProfile.UserID);
					JavaScriptSerializer us = new JavaScriptSerializer();
					List<UserSearchContract> usList = us.Deserialize<List<UserSearchContract>>(js);

					if (usList == null)
					{
						Response.Redirect("~/Student/Home");
					}

					string grp = string.Join(",", usList.Select(x => x.UserID).ToArray());
					
					ViewState["UserTo"] = grp;
					lblToName.Text = "Group";
					imgTo.ImageUrl = "../Images/groupavatar.png";
					lstRecipient.DataSource = usList;
					lstRecipient.DataTextField = "UserName";
					lstRecipient.DataValueField = "UserID";
					lstRecipient.DataBind();
					
					return;
				}
				//if (!string.IsNullOrEmpty(Request.QueryString["grp"]))
                if(Session["SelectedUsers"] != null || !string.IsNullOrEmpty(Request.QueryString["grp"]))
				{
                    ViewState["UserTo"] = Session["SelectedUsers"] != null ? Session["SelectedUsers"] : Request.QueryString["grp"];
                    Session["SelectedUsers"] = null;
                    lblToName.Text = "Group";
					imgTo.ImageUrl = "../Images/groupavatar.png";
					List<UserContract> list = null;
					if (ViewState["UserTo"] != null)
					{
						list = new List<UserContract>(ViewState["UserTo"].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(s => new UserContract() { UserID = int.Parse(s) }));
					}
					

					UserContract[] usl = client.GetUserByIDs(list.ToArray());
					lstRecipient.DataSource = usl;
					lstRecipient.DataTextField = "UserName";
					lstRecipient.DataValueField = "UserID";
					lstRecipient.DataBind();
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
					List<UserContract> list = new List<UserContract>();
					if (user != null)
					{
						list.Add(user);
						lstRecipient.DataSource = list;
						lstRecipient.DataTextField = "UserName";
						lstRecipient.DataValueField = "UserID";
						lstRecipient.DataBind();
					}
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
				CategoryList = plist; 
				//plist.Insert (0,new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[All]" });
				//ddlCategory.DataSource = plist;
				//ddlCategory.DataTextField = "PhraseCategoryCode";
				//ddlCategory.DataValueField = "PhraseCategoryID";
				//ddlCategory.DataBind();

				TopCategoryContract[] tcats = pclient.GetTopCategoryList(SessionManager.Instance.UserProfile.NativeLanguage);

				if (tcats != null)
				{
					List<TopCategoryContract> lcats = tcats.ToList();
                    //lcats.Insert(0, new TopCategoryContract() { TopCategoryHeaderID = 0, TopCategoryName = "[All]" });
                    //ddlTopCategory.DataSource = lcats;
                    //ddlTopCategory.DataTextField = "TopCategoryName";
                    //ddlTopCategory.DataValueField = "TopCategoryHeaderID";
                    //ddlTopCategory.DataBind();
                    TopCategoryContract talk = lcats.Find(x => x.IsTalk);
                    if (talk != null)
                        lcats.Remove(talk);

					TopCategoryList = lcats; 
					rptTopCategory.DataSource = lcats;
					rptTopCategory.DataBind();
				}

				int startrandom = 1;
				if (SessionManager.Instance.UserProfile.IsDemo && SessionManager.Instance.SchoolProfile.IsRobot)
				{
					plist.RemoveAll(x => (x.IsDemo == false && x.DisplayInUI == false) || (x.IsDemo == true && x.DisplayInUI == false));
					ScriptManager.RegisterStartupScript(this, this.GetType(), "DisableCategoryscript", "DisableCategory();", true);
					startrandom = 0;
					this.Keyword = string.Empty;
					if (plist.Count == 0)
						return;
				}
				else
				{
					plist.RemoveAll(x => (x.IsDemo == true));
				}

				Random next = new Random();
                int index = -1;
                if(plist.Count > 0)
                    index = next.Next(startrandom, plist.Count == 1 ? 1 : plist.Count - 1);
				//ddlCategory.SelectedIndexChanged -= ddlCategory_SelectedIndexChanged;
				if (string.IsNullOrEmpty(this.Keyword))
				{
					if (SessionManager.Instance.UserProfile.IsDemo)
					{
                        TopCategoryContract top = null;
                        if(index > -1)
                            top = TopCategoryList.Find(x => x.TopCategoryHeaderID == plist[index].TopCategoryHeaderID );
						if (top != null)
						{
							hdnCategory.Value = plist[index].PhraseCategoryID.ToString();
							ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript",
								string.Format("InitializeCategory('{0} > {1}');",
									top == null ? string.Empty : top.TopCategoryName, plist[index].PhraseCategoryCode),
								true);
						}
						else
						{
							hdnCategory.Value = "0";
							top = TopCategoryList.Find(x => x.IsMain == true);
                            
                            if (top == null)
                            {
                                TopCategoryContract top1 = TopCategoryList.Find(x => x.IsDefault == true);
                                string subcategory = "";
                                if (top1 != null)
                                {
                                    var list = plist.FindAll(x => x.TopCategoryHeaderID == top1.TopCategoryHeaderID);
                                    
                                    if (list != null && list.Count() > 0)
                                    {
                                        subcategory = list[0].PhraseCategoryCode;
                                    }
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript", string.Format("InitializeCategory('{0} > {1}');", top1 == null ? string.Empty : top1.TopCategoryName, subcategory), true);
                                }
                                
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript", string.Format("InitializeCategory('{0} > {1}');", top == null ? string.Empty : top.TopCategoryName, "[All]"), true);
                            }
							//ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript", string.Format("InitializeCategory('{0} > {1}');", top == null ? string.Empty : top.TopCategoryName, "[All]"), true);
						}
                        if (top != null)
                            hdnTopCategoryName.Value = top.TopCategoryName;
					}
					else
					{
						TopCategoryContract top = TopCategoryList.Find(x => x.IsDefault == true);
						if (top != null)
						{
							var cats = CategoryList.FindAll(x => x.TopCategoryHeaderID.Equals(top.TopCategoryHeaderID));
						    if (cats != null && cats.Count == 1)
						    {
						        hdnCategory.Value = cats[0].PhraseCategoryID.ToString();
						        ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript",
						            string.Format("InitializeCategory('{0}');", top == null ? string.Empty : top.TopCategoryName
						                ),
						            true);
						    }
                            else if (cats != null && cats.Count > 1)
						    {
                                //hdnCategory.Value = CategoryList[0].PhraseCategoryID.ToString();
                                PhraseCategoryContract c = CategoryList.Find(x => x.IsDefault);
                                if(c != null)
                                {
                                    hdnCategory.Value = c.PhraseCategoryID.ToString(); ;
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript",
                                    string.Format("InitializeCategory('{0} > {1}');", top == null ? string.Empty : top.TopCategoryName, c.PhraseCategoryCode),
                                    true);
                                }
                                else
                                {
                                    hdnCategory.Value = "0";
                                    top = TopCategoryList.Find(x => x.IsMain == true);
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript",
                                    string.Format("InitializeCategory('{0} > {1}');", top == null ? string.Empty : top.TopCategoryName, "[All]"),
                                    true);
                                }

                            }

						}
                        if (top != null)
                            hdnTopCategoryName.Value = top.TopCategoryName;
                    }
                }
				else
				{
					hdnCategory.Value = "0";
					TopCategoryContract top = TopCategoryList.Find(x => x.IsMain == true);
				    TopCategoryContract top1 = null;
				    if (top == null)
				    {
                        top1 = TopCategoryList.Find(x => x.IsDefault == true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript", string.Format("InitializeCategory('{0}');", top1 == null ? string.Empty : top1.TopCategoryName), true);
                        if (top1 != null)
                            hdnTopCategoryName.Value = top1.TopCategoryName;
                    }
				    else
				    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript", string.Format("InitializeCategory('{0} > {1}');", top == null ? string.Empty : top.TopCategoryName, "[All]"), true);
                        if (top != null)
                            hdnTopCategoryName.Value = top.TopCategoryName;
                    }


                }

				//if (!string.IsNullOrEmpty(hdnTopCategory.Value))
				//{
				//    var cats = CategoryList.FindAll(x => x.TopCategoryHeaderID.Equals(Convert.ToInt32(hdnTopCategory.Value)));
				//    if (cats.Count > 0 && cats.Count == 1)
				//    {
				//        hdnCategory.Value = cats[0].PhraseCategoryID.ToString();
				//    }

				//}

				//ddlCategory.SelectedIndexChanged += ddlCategory_SelectedIndexChanged;



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
                //string json = pclient.SearchWord(new SearchDTO() { SchoolID = SessionManager.Instance.UserProfile.SchoolID, CategoryID = 0, Keyword = txtSearchSentence.Text, PageNumber = Convert.ToInt32(hdnwordpage.Value), RowsPerPage = m_WordRowPerPage }, out virtualcount);
                SearchDTO dto = new SearchDTO()
			    {
			        SchoolID = SessionManager.Instance.UserProfile.SchoolID,
			        CategoryID = txtSearchWord.Text.Length == 0 ? Convert.ToInt64(hdnCategory.Value) : 0,
			        Word = txtSearchWord.Text,
			        Keyword = txtSearchWord.Text,
			        PageNumber = Convert.ToInt32(hdnwordpage.Value),
			        RowsPerPage = m_WordRowPerPage,
			        UserID = SessionManager.Instance.UserProfile.UserID,
                    WordType = txtSearchWord.Text.Length == 0 ? hdnWordType.Value : ""
                    
			        //TopCategoryHeaderID = Convert.ToInt32(ddlCategory.SelectedValue) == 0 ? Convert.ToInt32(ddlTopCategory.SelectedValue) : 0
			    };

                if (!string.IsNullOrEmpty(this.Keyword) && string.IsNullOrEmpty(txtSearchWord.Text) && hdnCategory.Value == "0")
                {
                    hdnCategory.Value = "0";
                    dto.CategoryID = 0;
                    if (!m_IsCategoryTriggered)
                    {
                        //dto.Word = this.Keyword.Replace("&#39;", "'");
                        dto.Keyword = this.Keyword.Replace("&#39;", "'");
                    }
                }
                //if (!string.IsNullOrEmpty(txtSearchSentence.Text))
                //    dto.WordType = string.Empty;
                if (string.IsNullOrEmpty(dto.WordType))
                {
                    if (IsSearchFromHistory)
                    {
                        dto = GetSearchWordDto();
                        hdnwordpage.Value = dto.PageNumber.ToString();
                        hdnTopCategory.Value = dto.TopCategoryHeaderID.ToString();
                        hdnCategory.Value = dto.CategoryID.ToString();
                        m_SearchText = dto.Word;
                        hdnTopCategoryName.Value = dto.TopCategoryName;
                        hdnWordType.Value = dto.WordType;
                    }
                    else
                    {
                        AddSearchWordList(dto);
                    }
                }
                
                string json = pclient.SearchWord(dto, out virtualcount);
                hdnWordType.Value = string.Empty;
                //multiple category
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

                    var learn = plearninglist.Find(x => x.WordMapID.Equals(wc.WordMapID));
                    					
                    var wordsoundfile = string.Empty;
                    if (learn != null)
                    {
                        wordsoundfile = learn.SoundFile;
                    }
                    words = string.Format("<span id='{0}' class='firstword' data-lang='{1}' data-switchword='{2}' data-word='{3}' {4} data-sound='{5}'>", "divspanword" + wc.WordID.ToString(), wc.LanguageCode, wc.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", wc.Word, dimage, "../Content/Sound/" + wordsoundfile) + wc.Word + "</span>" + "<br/>";
                    if (learn != null)
					{
						string cl = "secondword";
						words += string.Format("<span id='{0}' class='{1}' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + learn.WordID.ToString(), cl, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage, "../Content/Sound/" + wc == null ? string.Empty : wc.SoundFile) + learn.Word + "</span>" + "<br/>";
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
								words += string.Format("<span id='{0}' class='{1}' style='display:none;' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + otherword.WordID.ToString(), cl, otherword.LanguageCode, otherword.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", otherword.Word, dimage, "../Content/Sound/" + otherword.SoundFile) + otherword.Word + "</span>";                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
							}

						}
					}

					string datasound = string.Empty;
					if (learn != null)
						datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";


					string div = string.Format("<div id=\"div{0}\" class=\"screenshot wordbox\" style=\"border:1px solid black;text-align:center;background-color:white;cursor:pointer;position:relative;\" data-isword=\"true\" onclick=\"wordClick('div{0}', false, true);\" data-image=\"../Content/images/" + wc.ImageFile + "\" {2} >" +
						(wc.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + wc.ImageFile + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; position:absolute;top:-5px;left:-5px;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
								"{1}" +
								"</div>", wc.WordID.ToString() + (learn != null ? learn.WordID.ToString() : string.Empty) + (sub == null ? string.Empty : sub.WordID.ToString()), words, datasound);
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

        private int CreateWordListForUserCreated()
        {
            try
            {

                PaletteServiceClient pclient = new PaletteServiceClient();
                int virtualcount = 0;
                //string json = pclient.SearchWord(new SearchDTO() { SchoolID= SessionManager.Instance.UserProfile.SchoolID, CategoryID = Convert.ToInt64( ddlCategory.SelectedValue ), Keyword = txtSearchSentence.Text, PageNumber = Convert.ToInt32(hdnwordpage.Value), RowsPerPage = m_WordRowPerPage }, out virtualcount);
                //string json = pclient.SearchWord(new SearchDTO() { SchoolID = SessionManager.Instance.UserProfile.SchoolID, CategoryID = 0, Keyword = txtSearchSentence.Text, PageNumber = Convert.ToInt32(hdnwordpage.Value), RowsPerPage = m_WordRowPerPage }, out virtualcount);
                SearchDTO dto = new SearchDTO()
                {
                    SchoolID = SessionManager.Instance.UserProfile.SchoolID,
                    CategoryID = txtSearchWord.Text.Length == 0 ? Convert.ToInt64(hdnCategory.Value) : 0,
                    Word = txtSearchWord.Text,
                    Keyword = txtSearchWord.Text,
                    PageNumber = Convert.ToInt32(hdnwordpageusercreated.Value),
                    RowsPerPage = m_WordRowPerPage,
                    UserID = SessionManager.Instance.UserProfile.UserID,
                    TopCategoryHeaderID = txtSearchWord.Text.Length == 0 ? Convert.ToInt32(hdnTopCategory.Value) : 0,
                    TopCategoryName = hdnTopCategoryName.Value,
                    WordType = hdnWordType.Value,
                    UserCreatedWord = true
                    //TopCategoryHeaderID = Convert.ToInt32(ddlCategory.SelectedValue) == 0 ? Convert.ToInt32(ddlTopCategory.SelectedValue) : 0
                };

                if (!string.IsNullOrEmpty(this.Keyword) && string.IsNullOrEmpty(txtSearchWord.Text) && hdnCategory.Value == "0")
                {
                    hdnCategory.Value = "0";
                    dto.CategoryID = 0;
                    if (!m_IsCategoryTriggered)
                    {
                        //dto.Word = this.Keyword.Replace("&#39;", "'");
                        dto.Keyword = this.Keyword.Replace("&#39;", "'");
                    }
                }
                if (!string.IsNullOrEmpty(txtSearchWord.Text))
                    dto.WordType = string.Empty;
                //if (string.IsNullOrEmpty(dto.WordType))
                //{
                //    if (IsSearchFromHistory)
                //    {
                //        dto = GetSearchWordDto();
                //        hdnwordpage.Value = dto.PageNumber.ToString();
                //        hdnTopCategory.Value = dto.TopCategoryHeaderID.ToString();
                //        hdnCategory.Value = dto.CategoryID.ToString();
                //        m_SearchText = dto.Word;
                //        hdnTopCategoryName.Value = dto.TopCategoryName;
                //        hdnWordType.Value = dto.WordType;
                //    }
                //    else
                //    {
                //        AddSearchWordList(dto);
                //    }
                //}

                string json = pclient.SearchWord(dto, out virtualcount);
                hdnWordType.Value = string.Empty;
                //multiple category
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
                    string delete = string.Format("<img class='imgRemoveMessage' src='../Images/ico_delete.png' style='width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;' onclick='return RemoveUserWord(event,this);' data-id='{0}' />", wc.WordMapID.ToString());
                    if (string.IsNullOrEmpty(wc.ImageFile))
                        dimage = string.Empty;

                    var learn = plearninglist.Find(x => x.WordMapID.Equals(wc.WordMapID));

                    var wordsoundfile = string.Empty;
                    if (learn != null)
                    {
                        wordsoundfile = learn.SoundFile;
                    }
                    words = string.Format("<span id='{0}' class='firstword' data-lang='{1}' data-switchword='{2}' data-word='{3}' {4} data-sound='{5}'>", "divspanword" + wc.WordID.ToString(), wc.LanguageCode, wc.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", wc.Word, dimage, "../Content/Sound/" + wordsoundfile) + wc.Word + "</span>" + "<br/>";
                    if (learn != null)
                    {
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + learn.WordID.ToString(), cl, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage, "../Content/Sound/" + wc == null ? string.Empty : wc.SoundFile) + learn.Word + "</span>" + "<br/>";
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
                                words += string.Format("<span id='{0}' class='{1}' style='display:none;' data-lang='{2}' data-switchword='{3}' data-word='{4}' {5} data-sound='{6}'>", "divspanword" + otherword.WordID.ToString(), cl, otherword.LanguageCode, otherword.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", otherword.Word, dimage, "../Content/Sound/" + otherword.SoundFile) + otherword.Word + "</span>";                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
                            }

                        }
                    }

                    string datasound = string.Empty;
                    if (learn != null)
                        datasound = "data-sound='../Content/sound/" + learn.SoundFile + "' ";


                    string div = string.Format("<div id=\"div{0}\" class=\"screenshot wordbox\" style=\"border:1px solid black;text-align:center;background-color:white;cursor:pointer;position:relative;\" data-isword=\"true\" onclick=\"wordClick('div{0}', false, true);\" data-image=\"../Content/images/" + wc.ImageFile + "\" {2} >" +
                        (wc.ImageFile.Length > 0 ? "<a class='gallery' href='../Content/Images/" + wc.ImageFile + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; position:absolute;top:-5px;left:-5px;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                                "{1} {3}" +
                                "</div>", wc.WordID.ToString() + (learn != null ? learn.WordID.ToString() : string.Empty) + (sub == null ? string.Empty : sub.WordID.ToString()), words, datasound, delete);
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
            list = new JavaScriptSerializer().Deserialize<List<PaletteContract>>(json);
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

                string words = string.Empty;
                string sentence1ordinal = "";
                string sentence2ordinal = "";
                string sounds = "";

                var pnatives = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage)).OrderBy(x => x.Ordinal).ToList();
                foreach (Phrase p in pnatives)
                {
                    nativesentence += p.Word + "&nbsp;";
                    sounds += p.SoundFile + ",";
                }

                foreach (Phrase learning in plearninglist)
                {
                    var sk = paleteContract.SentenceList.Find(x => x.PaletteID.Equals(paleteContract.PaletteID) && !string.IsNullOrEmpty(x.Keyword));

                    HtmlGenericControl li = new HtmlGenericControl("li");

                    string subnative2word = string.Empty;
                    string subnative2code = string.Empty;

                    var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(learning.WordMapID));

                    if (sub2 != null)
                    {
                        subnative2word = sub2.Word;
                        subnative2code = sub2.LanguageCode.Substring(0, 2);
                    }



                    var native = pnativelist.Find(x => x.WordMapID.Equals(learning.WordMapID));
                    string wordsoundfile = string.Empty;
                    string learnimage = string.Empty;
                    if (native != null)
                    {
                        wordsoundfile = native.SoundFile;
                        learnimage = native.ImageFile;
                    }

                    int count = 1;
                    string dimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(native.ImageFile) ? learnimage : native.ImageFile) + "' ";
                    if (string.IsNullOrEmpty(native.ImageFile) && string.IsNullOrEmpty(learnimage))
                        dimage = string.Empty;

                    words = string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6}>", "divspan" + native.PalleteID.ToString() + native.SentenceID.ToString() + native.Ordinal.ToString() + count.ToString(),
                        native.Ordinal.ToString(), "../Content/Sound/" + wordsoundfile, native.LanguageCode, native.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", native.Word, dimage) + native.Word + "</span>" + "<br/>";
                    sentence1ordinal += learning.Ordinal.ToString() + ",";

                    //var learn = plearninglist.Find(x => x.WordMapID.Equals(p.WordMapID));
                    if (native != null)
                    {
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + learning.PalleteID.ToString() + learning.SentenceID.ToString() + native.Ordinal.ToString() + learning.Ordinal.ToString() + count.ToString(),
                            cl, learning.Ordinal.ToString(), "../Content/Sound/" + native.SoundFile, learning.LanguageCode, learning.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learning.Word, dimage) + learning.Word + "</span>" + "<br/>";
                        sentence2ordinal += learning.Ordinal.ToString() + ",";
                        learningsentence += learning.Word + "&nbsp;";
                    }
                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(native.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}'>", "divspan" + sub.PalleteID.ToString() + sub.SentenceID.ToString() + native.Ordinal.ToString() + sub.Ordinal.ToString() + count.ToString(),
                           cl, sub.Ordinal.ToString()) + sub.Word + "</span>" + "<br/>";
                    }

                    foreach (string lang in SessionManager.Instance.UserProfile.OtherLanguages)
                    {

                        var otherlanguage = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(lang)).ToList();
                        if (otherlanguage != null)
                        {
                            if (native == null)
                                native = learning;

                            var otherword = otherlanguage.Find(x => x.WordMapID.Equals(native == null ? learning.WordMapID : native.WordMapID));
                            if (otherword != null)
                            {

                                string cl = "otherword";
                                words += string.Format("<span id='{0}' style='display:none;' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + learning.PalleteID.ToString() + learning.SentenceID.ToString() + native.Ordinal.ToString() + learning.Ordinal.ToString() + otherword.Ordinal.ToString() + count.ToString(),
                                    cl, otherword.Ordinal.ToString(), "../Content/Sound/" + otherword.SoundFile, otherword.LanguageCode, "", otherword.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "") + otherword.Word + "</span>";
                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
                            }

                        }
                    }

                    string dataimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(native.ImageFile) ? learnimage : native.ImageFile) + "' ";
                    //string datasound = "<span id='sound' class='mp3'>"+ "http://localhost:50835/Content/images/" + p.ImageFile + "</span>'"; 
                    string datasound = string.Empty;
                    if (learning != null)
                        datasound = "data-sound='../Content/sound/" + learning.SoundFile + "' ";

                    string cssclass = "class='screenshot'";
                    //string datagrouping = "data-elementgrouping='sentence_" + p.SentenceID.ToString() + "'";
                    if (string.IsNullOrEmpty(native.ImageFile) && string.IsNullOrEmpty(learnimage))
                    {
                        cssclass = string.Empty;
                        dataimage = string.Empty;
                    }
                    string edit = string.Format("<img id='img{0}' src='../Images/swapoutline.png' class='addreplaceword' onclick='InitializeReplaceWordSettings(this);'/>", native.PalleteID.ToString() + native.SentenceID.ToString() + learning.Ordinal.ToString());
                    if (string.IsNullOrEmpty(native.WordType))
                        edit = string.Empty;

                    div = string.Format("<div id=\"div{0}s\" class=\"suggestion wordContainer\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;padding-left:10px;padding-bottom:2px;position:relative;\" data-isword=\"false\" onclick=\"wordClick('div{0}', true, true);\" {3} {4} data-wordtype='{5}'>" +
                    (native.ImageFile.Length > 0 || learnimage.Length > 0 ? "<a class='gallery' href='../Content/Images/" + (string.IsNullOrEmpty(native.ImageFile) ? learnimage : native.ImageFile) + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; left:-5px;top:-5px;position:absolute;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                    "<img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; float:right;\"/>" +
                    "{2} {6}" +
                    "</div>", native.PalleteID.ToString() + native.SentenceID.ToString() + native.Ordinal.ToString(), native.Ordinal.ToString(), words, dataimage, datasound, native.WordType, edit);

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

            //StringBuilder builder = new StringBuilder();
            //builder.AppendLine("$(function ()");
            //builder.AppendLine("{");
            ////builder.AppendLine("$('ul.items').easyPaginate({step:5});");
            ////builder.AppendLine("$('.sortable').sortable().disableSelection();;HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable();");
            //builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable();");
            ////builder.AppendLine("$('.sortable').sortable();HideShowWords('#chkNative', '.secondword'); HideShowWords('#chkSecondary', '.thirdword'); screenshotPreview();SetPalleteSelectable();");
            //builder.AppendLine("});");

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateSuggestion", builder.ToString(), true);


        }
        private void CreateSuggestion2()
        {


            PaletteServiceClient pclient = new PaletteServiceClient();
            string json = pclient.GetPaletteSuggestion();
            List<PaletteContract> list = null;
            list = new JavaScriptSerializer().Deserialize<List<PaletteContract>>(json);
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

                string words = string.Empty;
                string sentence1ordinal = "";
                string sentence2ordinal = "";
                string sounds = "";
                var pnatives = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage)).OrderBy(x => x.Ordinal).ToList();
                foreach (Phrase p in pnatives)
                {
                    nativesentence += p.Word + "&nbsp;";
                    sounds += p.SoundFile + ",";
                }
                foreach (Phrase learning in plearninglist)
                {
                    var sk = paleteContract.SentenceList.Find(x => x.PaletteID.Equals(paleteContract.PaletteID) && !string.IsNullOrEmpty(x.Keyword));

                    
                    HtmlGenericControl li = new HtmlGenericControl("li");

                    string subnative2word = string.Empty;
                    string subnative2code = string.Empty;

                    var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(learning.WordMapID));

                    if (sub2 != null)
                    {
                        subnative2word = sub2.Word;
                        subnative2code = sub2.LanguageCode.Substring(0, 2);
                    }



                    var native = plearninglist.Find(x => x.WordMapID.Equals(learning.WordMapID));
                    string wordsoundfile = string.Empty;
                    string learnimage = string.Empty;
                    if (native != null)
                    {
                        wordsoundfile = native.SoundFile;
                        learnimage = native.ImageFile;
                    }

                    int count = 1;
                    string dimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(learning.ImageFile) ? learnimage : learning.ImageFile) + "' ";
                    if (string.IsNullOrEmpty(learning.ImageFile) && string.IsNullOrEmpty(learnimage))
                        dimage = string.Empty;

                    words = string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6}>", "divspan" + native.PalleteID.ToString() + native.SentenceID.ToString() + native.Ordinal.ToString() + count.ToString(),
                        native.Ordinal.ToString(), "../Content/Sound/" + wordsoundfile, native.LanguageCode, native.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", native.Word, dimage) + native.Word + "</span>" + "<br/>";
                    sentence1ordinal += learning.Ordinal.ToString() + ",";

                    //var learn = plearninglist.Find(x => x.WordMapID.Equals(learning.WordMapID));
                    if (native != null)
                    {
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + native.PalleteID.ToString() + native.SentenceID.ToString() + learning.Ordinal.ToString() + native.Ordinal.ToString() + count.ToString(),
                            cl, native.Ordinal.ToString(), "../Content/Sound/" + learning.SoundFile, native.LanguageCode, native.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", native.Word, dimage) + native.Word + "</span>" + "<br/>";
                        sentence2ordinal += native.Ordinal.ToString() + ",";
                        learningsentence += native.Word + "&nbsp;";
                    }
                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(learning.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}'>", "divspan" + sub.PalleteID.ToString() + sub.SentenceID.ToString() + learning.Ordinal.ToString() + sub.Ordinal.ToString() + count.ToString(),
                           cl, sub.Ordinal.ToString()) + sub.Word + "</span>" + "<br/>";
                    }

                    foreach (string lang in SessionManager.Instance.UserProfile.OtherLanguages)
                    {

                        var otherlanguage = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(lang)).ToList();
                        if (otherlanguage != null)
                        {
                            if (native == null)
                                native = learning;

                            var otherword = otherlanguage.Find(x => x.WordMapID.Equals(native == null ? learning.WordMapID : native.WordMapID));
                            if (otherword != null)
                            {

                                string cl = "otherword";
                                words += string.Format("<span id='{0}' style='display:none;' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + native.PalleteID.ToString() + native.SentenceID.ToString() + learning.Ordinal.ToString() + native.Ordinal.ToString() + otherword.Ordinal.ToString() + count.ToString(),
                                    cl, otherword.Ordinal.ToString(), "../Content/Sound/" + otherword.SoundFile, otherword.LanguageCode, "", otherword.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "") + otherword.Word + "</span>";
                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
                            }

                        }
                    }

                    string dataimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(learning.ImageFile) ? learnimage : learning.ImageFile) + "' ";
                    //string datasound = "<span id='sound' class='mp3'>"+ "http://localhost:50835/Content/images/" + learning.ImageFile + "</span>'"; 
                    string datasound = string.Empty;
                    if (native != null)
                        datasound = "data-sound='../Content/sound/" + native.SoundFile + "' ";

                    string cssclass = "class='screenshot'";
                    //string datagrouping = "data-elementgrouping='sentence_" + learning.SentenceID.ToString() + "'";
                    if (string.IsNullOrEmpty(learning.ImageFile) && string.IsNullOrEmpty(learnimage))
                    {
                        cssclass = string.Empty;
                        dataimage = string.Empty;
                    }
                    string edit = string.Format("<img id='img{0}' src='../Images/swapoutline.png' class='addreplaceword' onclick='InitializeReplaceWordSettings(this);'/>", learning.PalleteID.ToString() + learning.SentenceID.ToString() + native.Ordinal.ToString());
                    if (string.IsNullOrEmpty(learning.WordType))
                        edit = string.Empty;

                    div = string.Format("<div id=\"div{0}s\" class=\"suggestion wordContainer\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;padding-left:10px;padding-bottom:2px;position:relative;\" data-isword=\"false\" onclick=\"wordClick('div{0}', true, true);\" {3} {4} data-wordtype='{5}'>" +
                    (learning.ImageFile.Length > 0 || learnimage.Length > 0 ? "<a class='gallery' href='../Content/Images/" + (string.IsNullOrEmpty(learning.ImageFile) ? learnimage : learning.ImageFile) + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; left:-5px;top:-5px;position:absolute;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                    "<img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; float:right;\"/>" +
                    "{2} {6}" +
                    "</div>", learning.PalleteID.ToString() + learning.SentenceID.ToString() + learning.Ordinal.ToString(), learning.Ordinal.ToString(), words, dataimage, datasound, learning.WordType, edit);

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

        }
        private int CreatePalleteList()
		{

			
			PaletteServiceClient pclient = new PaletteServiceClient();
			SearchDTO dto = null;
			dto = new SearchDTO()
			{
				SchoolID = SessionManager.Instance.UserProfile.SchoolID,
				CategoryID = txtSearchSentence.Text.Length == 0 ? Convert.ToInt32(hdnCategory.Value) : 0,
                Word = txtSearchSentence.Text,//string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty,
				Keyword = txtSearchSentence.Text,//string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty,
				LevelID = SessionManager.Instance.UserProfile.LevelID,
				PageNumber = Convert.ToInt32(hdnsentencepage.Value),
				RowsPerPage = m_SentenceRowPerPage,
				TopCategoryHeaderID = txtSearchSentence.Text.Length == 0 ? Convert.ToInt32(hdnTopCategory.Value) : 0,
                TopCategoryName = hdnTopCategoryName.Value,
                UserID = SessionManager.Instance.UserProfile.UserID 
				//TopCategoryHeaderID = Convert.ToInt32(ddlCategory.SelectedValue) == 0 ? Convert.ToInt32(ddlTopCategory.SelectedValue) : 0
			};

            //if (!SessionManager.Instance.UserProfile.IsDemo)
            //{
			if (!string.IsNullOrEmpty(this.Keyword) && string.IsNullOrEmpty(txtSearchSentence.Text) && hdnCategory.Value == "0")
			{
				hdnCategory.Value = "0";
				dto.CategoryID = 0;
                if (!m_IsCategoryTriggered)
                {
                    dto.Keyword = this.Keyword.Replace("&#39;", "'");
                }
                else
                {
                    dto.Keyword = "";
                }
			}
			//}
			int virtualcount = 0;
            if(IsSearchFromHistory)
            {
                dto = GetSearchSentenceDto();
                hdnsentencepage.Value = dto.PageNumber.ToString();
                hdnTopCategory.Value = dto.TopCategoryHeaderID.ToString();
                hdnCategory.Value = dto.CategoryID.ToString();
                m_SearchText = dto.Word;
                hdnTopCategoryName.Value = dto.TopCategoryName;                
            }
            else
            {
                AddSearchSentenceList(dto);
            }
            
			List < PaletteContract > list = pclient.Search(dto, out virtualcount).ToList();
			

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


				var pnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.NativeLanguage)).OrderBy(x => x.Ordinal).ToList();
				var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).ToList();
				var psubnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage)).ToList();
				var psubnative2list = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.SubNativeLanguage2)).ToList();
				if (pnativelist != null && pnativelist.Count == 0)
					continue;
				//var pfakelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();
				
				string words = string.Empty;
				string sentence1ordinal = "";
				string sentence2ordinal = "";
				string sounds = "";
				long sentenceid = 0;

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

                foreach (Phrase p in pnativelist)
				{
					var sk = paleteContract.SentenceList.Find(x => x.PaletteID.Equals(paleteContract.PaletteID) && !string.IsNullOrEmpty(x.Keyword));

					HtmlGenericControl li = new HtmlGenericControl("li");
					sounds += p.SoundFile + ",";
					int count = 1;
					string subnative2word = string.Empty;
					string subnative2code = string.Empty;

					var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(p.WordMapID));

					if (sub2 != null)
					{
						subnative2word = sub2.Word;
						subnative2code = sub2.LanguageCode.Substring(0,2);
					}
					var learn = plearninglist.Find(x => x.WordMapID.Equals(p.WordMapID));
					string wordsoundfile = string.Empty;
                    string learnimage = string.Empty;
					if (learn != null)
					{
						wordsoundfile = learn.SoundFile;
                        learnimage = learn.ImageFile;
					}
					//"data-image='../Content/images/" + p.ImageFile + "' "
					string dimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "' ";
					if (string.IsNullOrEmpty(p.ImageFile) && string.IsNullOrEmpty(learnimage) )
						dimage = string.Empty;

					words = string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6} data-keyword='{7}' data-sentencesound='{8}'>", "divspan" + p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString() + count.ToString(),
						p.Ordinal.ToString(), "../Content/Sound/" + wordsoundfile, p.LanguageCode, p.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", p.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilenative) + p.Word + "</span>" + "<br/>";
					sentence1ordinal += p.Ordinal.ToString() + ",";

					//var learn = plearninglist.Find(x => x.WordMapID.Equals(p.WordMapID));
					if (learn != null)
					{
						string cl = "secondword";
						words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7} data-keyword='{8}' data-sentencesound='{9}'>", "divspan" + learn.PalleteID.ToString() + learn.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + count.ToString(),
							cl, learn.Ordinal.ToString(), "../Content/Sound/" + p == null ? string.Empty : p.SoundFile, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilelearning) + learn.Word + "</span>" + "<br/>";
						sentence2ordinal += learn.Ordinal.ToString() + ",";
					}
					var sub = psubnativelist.Find(x => x.WordMapID.Equals(p.WordMapID));
					if (sub != null)
					{
						string cl = "thirdword";
						words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}'>", "divspan" + sub.PalleteID.ToString() + sub.SentenceID.ToString() + p.Ordinal.ToString() + sub.Ordinal.ToString() + count.ToString(),
						   cl, sub.Ordinal.ToString()) + sub.Word + "</span>" + "<br/>";
					}

					foreach (string lang in SessionManager.Instance.UserProfile.OtherLanguages)
					{
						
						var otherlanguage = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(lang)).ToList();
						if (otherlanguage != null)
						{
							if (learn == null)
								learn = p;

							var otherword = otherlanguage.Find(x => x.WordMapID.Equals(learn == null ? p.WordMapID : learn.WordMapID));
							if (otherword != null)
							{

								string cl = "otherword";
								words += string.Format("<span id='{0}' style='display:none;' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + learn.PalleteID.ToString() + learn.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + otherword.Ordinal.ToString() + count.ToString(),
									cl, otherword.Ordinal.ToString(), "../Content/Sound/" + otherword.SoundFile, otherword.LanguageCode, "", otherword.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "") + otherword.Word + "</span>";
								//sentence2ordinal += otherword.Ordinal.ToString() + ",";
							}

						}
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



					string dataimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "' ";
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
					if (SessionManager.Instance.UserProfile.NativeLanguage == "ja-JP")
					{
						imagesequence = "<img class='imgsequence' src=\"../Images/red{1}.png\" style=\"width:20px; height:20px; position:absolute;top:-5px;right:-5px;\"/>";
					}

                    string edit = "";//string.Format("<img id='img{0}' src='../Images/swapoutline.png' class='addreplaceword' onclick='InitializeReplaceWordSettings(this);'/>", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString());
                    if (string.IsNullOrEmpty(p.WordType))
                        edit = string.Empty;

                    //onclick=\"wordPlaysound('div{0}');\"
                    div = string.Format("<div class='wordContainer {9}' id=\"div{0}\" {4} data-isword=\"false\" {3} {5} {6} data-wordtype='{7}'>" +
					(p.ImageFile.Length > 0 || learnimage.Length > 0 ? "<a class='gallery' href='../Content/Images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; position:absolute;top:-5px;left:-5px;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
					imagesequence +
					"{2} {8}" +
					"</div>", p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString(), p.Ordinal.ToString(), words, dataimage, cssclass, datasound, datagrouping, p.WordType, edit, p.WordType.Trim().Length > 0 ? "replaceable" : string.Empty);
					//"<span style='float:right;'><img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; float:right;\" onclick=\"alert('bong');\"/><span>" +
					li.Attributes.Add("data-ordinalNative", p.Ordinal.ToString());

					li.Attributes.Add("data-ordinalLearning", learn != null ? learn.Ordinal.ToString() : "0");
					li.InnerHtml = div;
				
	
					childul.Controls.Add(li);
					sentenceid = p.SentenceID;
				}

				string soundfile = string.Empty;

				var sentence = paleteContract.SentenceList.Find(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage) && x.PaletteID.Equals(paleteContract.PaletteID));

				//var sentence = paleteContract.SentenceList.Find(x => x.SentenceID.Equals(sentenceid));

				if (sentence != null)
				{
					soundfile = sentence.SoundFile;
				}

				LiteralControl sound = new LiteralControl();
				sound.Text = "<img src=\"../Images/new/ICO_MailSpeaker.png\" class=\"soundicon\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;\"  onclick=\"PlaySentenceOrIndividualSound(this,'" + soundfile + "');\" />";
				if( soundfile.Length > 0  )
					childul.Controls.Add(sound);

				childul.Attributes.Add("data-sentence1Ordinal", sentence1ordinal);
				childul.Attributes.Add("data-sentence2Ordinal", sentence2ordinal);
				childul.Attributes.Add("style", "padding:0px;");
                childul.Attributes.Add("class", "sortableLi");

                parentli.Attributes.Add("class", "pallete");
				
				parentli.Controls.Add(childul);
				parentul.Controls.Add(parentli);
			}


			sentenceContainer.Controls.Add(parentul);
			hdnOtherLanguageCode.Value = new JavaScriptSerializer().Serialize(SessionManager.Instance.UserProfile.OtherLanguages);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "createpalettelist1" + Guid.NewGuid().ToString().Replace("-", ""), "attachClickOnWord();", true);
            return virtualcount;

		}

        private int CreatePalleteListOrderByLearning()
        {


            PaletteServiceClient pclient = new PaletteServiceClient();
            SearchDTO dto = null;
            dto = new SearchDTO()
            {
                SchoolID = SessionManager.Instance.UserProfile.SchoolID,
                CategoryID = txtSearchSentence.Text.Length == 0 ? Convert.ToInt32(hdnCategory.Value) : 0,
                Word = txtSearchSentence.Text,//string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty,
                Keyword = txtSearchSentence.Text,//string.IsNullOrEmpty(txtSearchSentence.Text) ? string.Empty : string.Empty,
                LevelID = SessionManager.Instance.UserProfile.LevelID,
                PageNumber = Convert.ToInt32(hdnsentencepage.Value),
                RowsPerPage = m_SentenceRowPerPage,
                TopCategoryHeaderID = txtSearchSentence.Text.Length == 0 ? Convert.ToInt32(hdnTopCategory.Value) : 0,
                TopCategoryName = hdnTopCategoryName.Value,
                UserID = SessionManager.Instance.UserProfile.UserID
                //TopCategoryHeaderID = Convert.ToInt32(ddlCategory.SelectedValue) == 0 ? Convert.ToInt32(ddlTopCategory.SelectedValue) : 0
            };

            //if (!SessionManager.Instance.UserProfile.IsDemo)
            //{
            if (!string.IsNullOrEmpty(this.Keyword) && string.IsNullOrEmpty(txtSearchSentence.Text) && hdnCategory.Value == "0")
            {
                hdnCategory.Value = "0";
                dto.CategoryID = 0;
                if (!m_IsCategoryTriggered)
                {
                    dto.Keyword = this.Keyword.Replace("&#39;", "'");
                }
                else
                {
                    dto.Keyword = "";
                }
            }
            //}
            int virtualcount = 0;
            if (IsSearchFromHistory)
            {
                dto = GetSearchSentenceDto();
                hdnsentencepage.Value = dto.PageNumber.ToString();
                hdnTopCategory.Value = dto.TopCategoryHeaderID.ToString();
                hdnCategory.Value = dto.CategoryID.ToString();
                m_SearchText = dto.Word;
                hdnTopCategoryName.Value = dto.TopCategoryName;
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
                if (pnativelist != null && pnativelist.Count == 0)
                    continue;
                //var pfakelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();

                string words = string.Empty;
                string sentence1ordinal = "";
                string sentence2ordinal = "";
                string sounds = "";
                long sentenceid = 0;

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

                foreach (Phrase learn in plearninglist)
                {
                    var sk = paleteContract.SentenceList.Find(x => x.PaletteID.Equals(paleteContract.PaletteID) && !string.IsNullOrEmpty(x.Keyword));

                    HtmlGenericControl li = new HtmlGenericControl("li");
                    sounds += learn.SoundFile + ",";
                    int count = 1;
                    string subnative2word = string.Empty;
                    string subnative2code = string.Empty;

                    var sub2 = psubnative2list.Find(x => x.WordMapID.Equals(learn.WordMapID));

                    if (sub2 != null)
                    {
                        subnative2word = sub2.Word;
                        subnative2code = sub2.LanguageCode.Substring(0, 2);
                    }
                    var p = pnativelist.Find(x => x.WordMapID.Equals(learn.WordMapID));
                    string wordsoundfile = string.Empty;
                    string learnimage = string.Empty;
                    if (learn != null)
                    {
                        wordsoundfile = learn.SoundFile;
                        learnimage = learn.ImageFile;
                    }
                    //"data-image='../Content/images/" + p.ImageFile + "' "
                    string dimage = "data-image='../Content/images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "' ";
                    if (string.IsNullOrEmpty(p.ImageFile) && string.IsNullOrEmpty(learnimage))
                        dimage = string.Empty;

                    words = string.Format("<span id='{0}' class='firstword' data-ordinal='{1}' data-sound='{2}' data-lang='{3}' data-switchword='{4}' data-word='{5}' {6} data-keyword='{7}' data-sentencesound='{8}'>", "divspan" + p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString() + count.ToString(),
                        p.Ordinal.ToString(), "../Content/Sound/" + wordsoundfile, p.LanguageCode, p.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", p.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilenative) + p.Word + "</span>" + "<br/>";
                    sentence1ordinal += learn.Ordinal.ToString() + ",";

                    //var learn = plearninglist.Find(x => x.WordMapID.Equals(p.WordMapID));
                    if (learn != null)
                    {
                        string cl = "secondword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7} data-keyword='{8}' data-sentencesound='{9}'>", "divspan" + learn.PalleteID.ToString() + learn.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + count.ToString(),
                            cl, learn.Ordinal.ToString(), "../Content/Sound/" + p == null ? string.Empty : p.SoundFile, learn.LanguageCode, learn.LanguageCode.Substring(0, 2) == subnative2code ? subnative2word : "", learn.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "", soundfilelearning) + learn.Word + "</span>" + "<br/>";
                        sentence2ordinal += p.Ordinal.ToString() + ",";
                    }
                    var sub = psubnativelist.Find(x => x.WordMapID.Equals(p.WordMapID));
                    if (sub != null)
                    {
                        string cl = "thirdword";
                        words += string.Format("<span id='{0}' class='{1}' data-ordinal='{2}'>", "divspan" + sub.PalleteID.ToString() + sub.SentenceID.ToString() + p.Ordinal.ToString() + sub.Ordinal.ToString() + count.ToString(),
                           cl, sub.Ordinal.ToString()) + sub.Word + "</span>" + "<br/>";
                    }

                    foreach (string lang in SessionManager.Instance.UserProfile.OtherLanguages)
                    {

                        var otherlanguage = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(lang)).ToList();
                        if (otherlanguage != null)
                        {
                            if (learn == null)
                                p = learn;

                            var otherword = otherlanguage.Find(x => x.WordMapID.Equals(learn == null ? p.WordMapID : learn.WordMapID));
                            if (otherword != null)
                            {

                                string cl = "otherword";
                                words += string.Format("<span id='{0}' style='display:none;' class='{1}' data-ordinal='{2}' data-sound='{3}' data-lang='{4}' data-switchword='{5}' data-word='{6}' {7}>", "divspan" + learn.PalleteID.ToString() + learn.SentenceID.ToString() + p.Ordinal.ToString() + learn.Ordinal.ToString() + otherword.Ordinal.ToString() + count.ToString(),
                                    cl, otherword.Ordinal.ToString(), "../Content/Sound/" + otherword.SoundFile, otherword.LanguageCode, "", otherword.Word, dimage, sk != null ? sk.Keyword.Replace("'", "&#39;") : "") + otherword.Word + "</span>";
                                //sentence2ordinal += otherword.Ordinal.ToString() + ",";
                            }

                        }
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
                    string imagesequence = "<img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; position:absolute;top:-5px;right:-5px;\"/>";
                    if (SessionManager.Instance.UserProfile.NativeLanguage == "ja-JP")
                    {
                        imagesequence = "<img class='imgsequence' src=\"../Images/red{1}.png\" style=\"width:20px; height:20px; position:absolute;top:-5px;right:-5px;\"/>";
                    }

                    string edit = "";//string.Format("<img id='img{0}' src='../Images/swapoutline.png' class='addreplaceword' onclick='InitializeReplaceWordSettings(this);'/>", p.PalleteID.ToString() + p.SentenceID.ToString() + learn.Ordinal.ToString());
                    if (string.IsNullOrEmpty(p.WordType))
                        edit = string.Empty;


                    div = string.Format("<div class='wordContainer {9}' id=\"div{0}\" {4} data-isword=\"false\" {3} {5} {6} data-wordtype='{7}'>" +
                    (p.ImageFile.Length > 0 || learnimage.Length > 0 ? "<a class='gallery' href='../Content/Images/" + (string.IsNullOrEmpty(p.ImageFile) ? learnimage : p.ImageFile) + "'> <img class='imgPicture' src=\"../Images/showimage.png\" style=\"width:15px; height:15px; position:absolute;top:-5px;left:-5px;\" onclick='ShowPicture(event)'/></a>" : string.Empty) +
                    imagesequence +
                    "{2} {8}" +
                    "</div>", p.PalleteID.ToString() + p.SentenceID.ToString() + p.Ordinal.ToString(), p.Ordinal.ToString(), words, dataimage, cssclass, datasound, datagrouping, p.WordType, edit, p.WordType.Trim().Length > 0 ? "replaceable" : string.Empty);
                    //"<span style='float:right;'><img class='imgsequence' src=\"../Images/orderedList{1}.png\" style=\"width:20px; height:20px; float:right;\" onclick=\"alert('bong');\"/><span>" +
                    li.Attributes.Add("data-ordinalNative", p.Ordinal.ToString());

                    li.Attributes.Add("data-ordinalLearning", learn != null ? learn.Ordinal.ToString() : "0");
                    li.InnerHtml = div;


                    childul.Controls.Add(li);
                    sentenceid = p.SentenceID;
                }

                string soundfile = string.Empty;

                var sentence = paleteContract.SentenceList.Find(x => x.LanguageCode.Equals(SessionManager.Instance.UserProfile.LearningLanguage) && x.PaletteID.Equals(paleteContract.PaletteID));

                //var sentence = paleteContract.SentenceList.Find(x => x.SentenceID.Equals(sentenceid));

                if (sentence != null)
                {
                    soundfile = sentence.SoundFile;
                }

                LiteralControl sound = new LiteralControl();
                sound.Text = "<img src=\"../Images/new/ICO_MailSpeaker.png\" class=\"soundicon\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;\" onclick=\"PlaySentenceOrIndividualSound(this,'" + soundfile + "');\" />";
                if (soundfile.Length > 0)
                    childul.Controls.Add(sound);

                childul.Attributes.Add("data-sentence1Ordinal", sentence1ordinal);
                childul.Attributes.Add("data-sentence2Ordinal", sentence2ordinal);
                childul.Attributes.Add("style", "padding:0px;");
                childul.Attributes.Add("class", "sortableLi");

                parentli.Attributes.Add("class", "pallete");

                parentli.Controls.Add(childul);
                parentul.Controls.Add(parentli);
            }


            sentenceContainer.Controls.Add(parentul);
            hdnOtherLanguageCode.Value = new JavaScriptSerializer().Serialize(SessionManager.Instance.UserProfile.OtherLanguages);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "createpalettelist1" + Guid.NewGuid().ToString().Replace("-", ""), "attachClickOnWord();", true);
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



            //if (rdoCriteriaList.SelectedValue == "0")//All
            //{
            //}
            //else if (rdoCriteriaList.SelectedValue == "1")//Word
            //{
            //    UpdatePanel2.Triggers.Clear();//.RemoveAt(0);
            //    SearchWords();
            //SearchSentence();
            //}
            m_IsSearchAll = true;

            hdnwordpage.Value = "1";
            hdnwordpageusercreated.Value = "1";
            hdnsentencepage.Value = "1";
            //SearchAll();
            SearchSentence();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();", true);
			//UpdatePanel1.Update();
		}

		private void SearchSentence()
		{
            int virtualcount = SessionManager.Instance.UserProfile.OrderByLearningLanguageFlag ? CreatePalleteListOrderByLearning() : CreatePalleteList();
			int numberofpages = virtualcount / m_SentenceRowPerPage;
			if (virtualcount % m_SentenceRowPerPage > 0)
				numberofpages++;

			if (numberofpages <= 0)
				numberofpages = 0;

            //if (numberofpages <= m_SentenceRowPerPage)
            //    numberofpages = 0;
            UpdatePanel2.Update();
            StringBuilder builder = new StringBuilder();
			builder.AppendLine("$(function ()");
			builder.AppendLine("{");
			//builder.AppendLine("$('ul.items').easyPaginate({step:5});");
			string switchlanguageorder = "";// "SwitchLanguageOrder('.chkLanguageOrder');";
			if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
				switchlanguageorder = "";


			//builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); SetPalleteSelectable(); HideShowSequence('#" + chkSequence.ClientID + "');SwitchLanguageOrder('.chkLanguageOrder');SwitchWords('.chkSubLanguage2');HideSequence();");
			//builder.AppendLine("$('.sortable').sortable();HideShowWords('#chkNative', '.secondword'); HideShowWords('#chkSecondary', '.thirdword'); screenshotPreview();SetPalleteSelectable();");
            builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword');  SwitchLanguageOrder('.chkLanguageOrder');SwitchWords('.chkSubLanguage2');ShowHidePaletteContainer(true);HideShowSequence(null);InitializeTooltipSteps();attachClickOnWord();");
			int pagenumber = Convert.ToInt32(hdnsentencepage.Value);

            builder.AppendFormat("Touchmove();InitializeSwipe(); activateSortablePalette(); ActivateSentencePaging({0},{1}, {2});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString(), IsPostBack.ToString().ToLower()); ;
			builder.AppendLine("});");

			ScriptManager.RegisterStartupScript(this, this.GetType(), "CreatePalleteList", builder.ToString(), true);
		}


		private void SearchWords()
		{
			int virtualcount = CreateWordList();
			int numberofpages = virtualcount / m_WordRowPerPage;
			if (virtualcount % m_WordRowPerPage > 0)
				numberofpages++;

			if (numberofpages <= 0)
			   numberofpages = 0;
            UpdatePanel1.Update();
            StringBuilder builder = new StringBuilder();
			builder.Clear();
			builder.AppendLine("$(function ()");
			builder.AppendLine("{");
			//builder.AppendLine("$('ul.items2').easyPaginate({step:2});");
			builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); HideShowSequence(null);InitializeTooltipSteps();ShowHideSubLanguage2();replaceWordBackground('"+ hdnWordToReplaceId.Value +"');");
			int pagenumber = Convert.ToInt32(hdnwordpage.Value);
            builder.AppendFormat("InitializeSwipe(); ActivateWordPaging({0},{1}, {2});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString(), IsPostBack.ToString().ToLower()); ;
			builder.AppendLine("});");
			ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateWordList", builder.ToString(), true);
			

		}

        private void SearchWordsUserCreated()
        {
            int virtualcount = CreateWordListForUserCreated();
            int numberofpages = virtualcount / m_WordRowPerPage;
            if (virtualcount % m_WordRowPerPage > 0)
                numberofpages++;

            if (numberofpages <= 0)
                numberofpages = 0;
            UpdatePanel3.Update();
            StringBuilder builder = new StringBuilder();
            builder.Clear();
            builder.AppendLine("$(function ()");
            builder.AppendLine("{");
            //builder.AppendLine("$('ul.items2').easyPaginate({step:2});");
            builder.AppendLine("HideShowWords('#" + chkNative.ClientID + "', '.firstword'); HideShowWords('#chkSecondary', '.thirdword'); HideShowSequence(null);InitializeTooltipSteps();ShowHideSubLanguage2();replaceWordBackground('" + hdnWordToReplaceId.Value + "');");
            int pagenumber = Convert.ToInt32(hdnwordpageusercreated.Value);
            builder.AppendFormat("InitializeSwipe(); ActivateWordPagingUserCreated({0},{1}, {2});", (pagenumber > numberofpages ? "0" : pagenumber.ToString()), numberofpages.ToString(), IsPostBack.ToString().ToLower()); ;
            builder.AppendLine("});");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateWordListUserCreated", builder.ToString(), true);


        }

        protected void imgSearchWord_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
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
                //throw ex;
                Logger.ErrorLog(ex.Message + ex.StackTrace + " METHOD:" + System.Reflection.MethodBase.GetCurrentMethod().Name);
			}
		}

		private void SendToGroup()
		{
            try
            {


                //btnSend.Enabled = false;
                string learningsentence = hdnLearning.Value;
                string nativesentence = hdnNative.Value;
                bool isDirectReply = string.IsNullOrEmpty(Request.QueryString["dr"]) ? false : true;
                List<OtherMessage> othermessages = new JavaScriptSerializer().Deserialize<List<OtherMessage>>(hdnOtherLanguagesContent.Value.Replace("\\", "/"));

                string[] ls = learningsentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                string[] ns = nativesentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                string[] oll;
                string[] oln;

                //Hashtable ht = new Hashtable();
                //int sentencecountls = 1;
                //int sentencecountns = 1;

                //int emojicountls = 1;
                //int emojicountns = 1;

                //foreach (var s in ls)
                //{
                //    if (s.IndexOf("data-isemoji", StringComparison.OrdinalIgnoreCase) > -1)
                //        emojicountls++;

                //    if (ht.Contains(s))
                //    {
                //        sentencecountls++;
                //        continue;
                //    }
                //    ht.Add(s, s);
                //}
                //foreach (var s in ns)
                //{
                //    if (s.IndexOf("emoji", StringComparison.OrdinalIgnoreCase) > -1)
                //        emojicountns++;

                //    if (ht.Contains(s))
                //    {
                //        sentencecountns++;
                //        continue;
                //    }
                //    ht.Add(s, s);
                //}
                ////---------------------
                //string learningfree = hdnFreeMessage1.Value;
                //string nativefree = hdnFreeMessage2.Value;


                //string[] freels = learningfree.Split(new char[] { '|', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                //string[] freens = nativefree.Split(new char[] { '|', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);

                //bool islsInvalid = false;
                //bool isnsInvalid = false;
                //int invalidlsCharCount = 0;
                //int invalidnsCharCount = 0;
                //int invalidlsSameCharCount = 0;
                //int invalidnsSameCharCount = 0;
                ////List<string> excludelList =
                ////    ConfigurationManager.AppSettings["ExcludeWordForRejection"].Split(new char[] { ',' },
                ////        StringSplitOptions.RemoveEmptyEntries).ToList();

                //if (SessionManager.Instance.UserProfile.NativeLanguage != "en-US")
                //{
                //    ht = new Hashtable();
                //    foreach (var s in freels)
                //    {
                //        if (s.Length > 20 && !s.Contains(" "))
                //        {
                //            islsInvalid = true;
                //            break;
                //        }
                //        if (!s.Contains(" ") && s.Length > 10)
                //        {
                //            isnsInvalid = true;
                //            break;
                //        }
                //        if (ht.Contains(s))
                //        {
                //            sentencecountls++;
                //            continue;
                //        }
                //        ht.Add(s, s);
                        
                //        foreach (var c in s.ToCharArray())
                //        {
                //            if (!Char.IsLetterOrDigit(c) && !Char.IsWhiteSpace(c))
                //                invalidlsCharCount++;
                //        }
                //        if (Regex.Match(s, @"(.)\1\1", RegexOptions.IgnoreCase).Success)
                //        {
                //            invalidlsSameCharCount++;
                //        }

                //    }
                //}
                //else if (SessionManager.Instance.UserProfile.NativeLanguage == "en-US")
                //{
                //    ht = new Hashtable();
                //    foreach (var s in freens)
                //    {
                //        if (s.Length > 20 && !s.Contains(" "))
                //        {
                //            islsInvalid = true;
                //            break;
                //        }
                //        if (!s.Contains(" ") && s.Length > 10)
                //        {
                //            isnsInvalid = true;
                //            break;
                //        }
                //        if (ht.Contains(s))
                //        {
                //            sentencecountls++;
                //            continue;
                //        }
                //        ht.Add(s, s);
                //        foreach (var c in s.ToCharArray())
                //        {
                //            if (!Char.IsLetterOrDigit(c) && !Char.IsWhiteSpace(c))
                //                invalidnsCharCount++;
                //        }
                //        if (Regex.Match(s, @"(.)\1\1", RegexOptions.IgnoreCase).Success)
                //        {
                //            invalidnsSameCharCount++;
                //        }

                //    }
                //}

                //---------------

                List<UserMessageContract> msgList = new List<UserMessageContract>();
                List<long> userids = new List<long>();
                string userto = string.Empty;
                if (ViewState["UserTo"] != null)
                {
                    userto = ViewState["UserTo"].ToString();
                    userids = userto.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(long.Parse).ToList();
                }
                else
                {
                    userids.Add(!string.IsNullOrEmpty(Request.QueryString["to"]) ? Convert.ToInt64(Request.QueryString["to"]) : 0);
                    userto = userids[0].ToString();
                }

                List<long> removeduserids = new List<long>();
                removeduserids = hdnRemovedUsers.Value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(long.Parse).ToList();

                userids.RemoveAll(x => removeduserids.Contains(x));

                List<UserContract> list = new List<UserContract>();
                if (userids.Count > 0)
                {
                    string uids = string.Join(",", userids.Select(x => x.ToString()).ToArray());
                    list = GetUserDetails(uids);
                    if (list == null)
                        throw new Exception("UserIDS list is null(GetUserDetails)");
                }

                int counter = 0;
                bool toadd = true;
                Repository.UserRepository rep = new Repository.UserRepository();
                List<long> ids = new List<long>();

                List<UserMessageContract> mlist = new List<UserMessageContract>();
                    foreach (UserContract user in list)
                    {
                        UserMessageContract umc = new UserMessageContract();
                        oll = othermessages.Find(x => x.LanguageCode == user.LearningLanguage).Message.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                        oln = othermessages.Find(x => x.LanguageCode == user.NativeLanguage).Message.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                        umc.SenderID = SessionManager.Instance.UserProfile.UserID;
                        umc.RecepientID = user.UserID;
                        umc.Keyword = hdnKeywords.Value;
                        umc.IsFromNewFriends = !string.IsNullOrEmpty(Request.QueryString["grp"]) || (!string.IsNullOrEmpty(Request.QueryString["du"]) && Request.QueryString["du"] == "1");
                        umc.NeedResponse = SessionManager.Instance.UserProfile.IsDemo;
                        //umc.Subject = txtSubject.Text;
                        umc.IsDirectReply = isDirectReply;
                        //umc.IsRejected = emojicountls > 3 || emojicountns > 3 || sentencecountls > 3 || sentencecountns > 3 || islsInvalid || isnsInvalid || invalidnsCharCount >= 10 || invalidlsCharCount >= 10 ? true : false;

                        for (int i = 0; i < ls.Count(); i++)
                        {
                            umc.LearningLanguageMessage += "<div class='paletteContainer'>" + Server.HtmlEncode(ls[i] + "</div>");
                            umc.NativeLanguageMessage += "<div class='paletteContainer'>" + Server.HtmlEncode(ns[i] + "</div>");
                            umc.LearningLanguageMessageRecepient += oll.Length > 0 && i < oll.Length ? "<div class='paletteContainer'>" + HttpUtility.HtmlEncode(oll[i] + "</div>") : string.Empty;
                            umc.NativeLanguageMessageRecepient += oln.Length > 0 && i < oln.Length ? "<div class='paletteContainer'>" + HttpUtility.HtmlEncode(oln[i] + "</div>") : string.Empty;
                        }
                        msgList.Add(umc);
                    }

                ids.AddRange(rep.SaveMessage(msgList, chkCC.Checked));
                if (ids != null && ids.Count() > 0)
                {
                    SaveFreeMessage();
                    ClearSavedMessage();
                    //if (emojicountls > 3 || emojicountns > 3 || sentencecountls > 3 || sentencecountns > 3 || islsInvalid || isnsInvalid || invalidnsCharCount >= 10 || invalidlsCharCount >= 10 || invalidnsSameCharCount > 0 || invalidlsSameCharCount > 0)
                    //{
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertRejection", "RejectMessage(" + SessionManager.Instance.UserProfile.IsDemo.ToString().ToLower() + ");", true);
                    //}
                    //else
                    //{
                        Response.Redirect("MailBox?d=" + SessionManager.Instance.UserProfile.IsDemo, false);
                    //}

                }
            }
            catch
            {
                throw;
            }
			
		}
        private void ClearSavedMessage()
        {
            Repository.UserRepository rep = new Repository.UserRepository();
            rep.ClearSavedMessage(Convert.ToInt32(SessionManager.Instance.UserProfile.UserID));
        }


        private void SaveFreeMessage()
		{
			string learningsentence = hdnFreeMessage1.Value;
			string nativesentence = hdnFreeMessage2.Value;


			string[] ls = learningsentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
			string[] ns = nativesentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

			List<FreeMessageContract> msgList = new List<FreeMessageContract>();
			
			for (int i = 0; i < ls.Count(); i++)
			{
				FreeMessageContract umc = new FreeMessageContract();
				umc.SenderID = SessionManager.Instance.UserProfile.UserID;
				umc.FreeMessageText1 = ls.Count() > 0 ? Server.HtmlEncode(ls[i]) : string.Empty;
				umc.FreeMessageText2 = ns.Count() > 0 ? Server.HtmlEncode(ns[i]) : string.Empty;
				umc.SchoolID = SessionManager.Instance.UserProfile.SchoolID;
				msgList.Add(umc);
			}


			UserClient client = new UserClient();
            Repository.UserRepository rep = new Repository.UserRepository();
            bool success = rep.InsertFreeMessage(msgList);
		}

		protected void btnSearchSentence_Click(object sender, EventArgs e)
		{
			try
			{
                
                if (!string.IsNullOrEmpty(hdnTopCategory.Value))
                {
                    var cats = CategoryList.FindAll(x => x.TopCategoryHeaderID.Equals(Convert.ToInt32(hdnTopCategory.Value)));
                    if (cats.Count > 0 && cats.Count == 1)
                    {
                        hdnCategory.Value = cats[0].PhraseCategoryID.ToString();
                    }

                }
				SearchSentence();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "addallwords_" + Guid.NewGuid().ToString().Replace("-", ""), "AppendCircleButton();ToggleSlider('items','up','show');", true);

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
                SearchWordsUserCreated();
                string scroll = "";
                if (!string.IsNullOrEmpty(hdnPrepareWordReplaceElementID.Value))
                {
                    scroll = string.Format("PrepareReplaceWordSettings('{0}'); ", hdnPrepareWordReplaceElementID.Value);
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "CreateWordList_ShowWordSlide", "ToggleSlider('items2','right','show');" + scroll, true);
			}
			catch (Exception ex)
			{

				throw ex;
			}
		}

		protected void ddlTopCategory_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				//m_IsCategoryTriggered = true;
				//List<PhraseCategoryContract> list = null;
				//if (ddlTopCategory.SelectedValue == "0")
				//    list = CategoryList;
				//else
				//    list = CategoryList.Where(x => x.TopCategoryHeaderID.Equals(Convert.ToInt32(ddlTopCategory.SelectedValue))).ToList();

				//if (list != null)
				//{

				//    if (list.Find(x => x.PhraseCategoryID.Equals(0)) == null)
				//        list.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[All]" });

				//    ddlCategory.DataSource = list;
				//    ddlCategory.DataTextField = "PhraseCategoryCode";
				//    ddlCategory.DataValueField = "PhraseCategoryID";
				//    ddlCategory.DataBind();

				//}
				//ddlCategory.SelectedValue = "0";
				//TriggerCategorySearch();
			}
			catch (Exception)
			{
				throw;
			}
		}

		protected void rptTopCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			RepeaterItem item = e.Item;
			if ((item.ItemType == ListItemType.Item) || (item.ItemType == ListItemType.AlternatingItem))
			{
				TopCategoryContract top = (TopCategoryContract)item.DataItem;
				if (top != null)
				{
					List<PhraseCategoryContract> list = null;
					list = CategoryList.Where(x => x.TopCategoryHeaderID.Equals(top.TopCategoryHeaderID)).ToList();

					if (list != null)
					{
						if (list.Find(x => x.PhraseCategoryID.Equals(0)) == null && list.Count > 1)
							list.Add(new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[All]" });

						Repeater rpt = (Repeater)item.FindControl("rptCategory");
						if (rpt != null && list.Count > 1)
						{
							rpt.DataSource = list;
							rpt.DataBind();
						}
					}

				}
			}
		}

		protected void btnSearchByCategory_Click(object sender, EventArgs e)
		{
			try
			{
				if (!string.IsNullOrEmpty(hdnTopCategory.Value))
				{
					var cats = CategoryList.FindAll(x => x.TopCategoryHeaderID.Equals(Convert.ToInt32(hdnTopCategory.Value)));
					if (cats.Count > 0 && cats.Count == 1)
					{
						hdnCategory.Value = cats[0].PhraseCategoryID.ToString(); 
					}

				}
                m_IsCategoryTriggered = true;

                TriggerCategorySearch();
			}
			catch (Exception ex)
			{
				throw ex;
			}
			
		}
		
		private List<UserContract> GetUserDetails(string usertos)
		{
			List<UserContract> list = new List<UserContract>();
			list = new List<UserContract>(usertos.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(s => new UserContract() { UserID = int.Parse(s) }));
            if (list == null)
                return null;

			UserContract[] usl = new UserClient().GetUserByIDs(list.ToArray());
            if (usl == null)
                return null;

			return usl.ToList();
		}

        private void AddSearchSentenceList(SearchDTO item)
        {
            SentenceSearchHistoryList.Add(item);
            if (SentenceSearchHistoryList.Count > m_SearchHistoryLimit)
            {
                SentenceSearchHistoryList.RemoveAt(0);
            }

            if(!m_IsSearchAll)
            {
                if (WordSearchHistoryList.Count > 0)
                {
                    WordSearchHistoryList.Add(WordSearchHistoryList[WordSearchHistoryList.Count - 1]);
                    if (WordSearchHistoryList.Count > m_SearchHistoryLimit)
                    {
                        WordSearchHistoryList.RemoveAt(0);
                    }
                }
            }
            if (WordSearchHistoryList.Count >= 2)
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

            if (!m_IsSearchAll)
            {
                if (SentenceSearchHistoryList.Count > 0)
                {
                    SentenceSearchHistoryList.Add(SentenceSearchHistoryList[SentenceSearchHistoryList.Count - 1]);
                    if (SentenceSearchHistoryList.Count > m_SearchHistoryLimit)
                    {
                        SentenceSearchHistoryList.RemoveAt(0);
                    }
                }
            }

            if (WordSearchHistoryList.Count >= 2)
            {
                imgBack.Visible = true;
                //UpdatePanel2.Update();
            }
        }

        private SearchDTO GetSearchSentenceDto()
        {
            if (SentenceSearchHistoryList.Count == SentenceSearchHistoryListIndex && m_IsBack)
                SentenceSearchHistoryListIndex = SentenceSearchHistoryList.Count - 1;

            SearchDTO dto = SentenceSearchHistoryList[SentenceSearchHistoryListIndex-1];
            return dto;
        }

        private SearchDTO GetSearchWordDto()
        {
            if (SentenceSearchHistoryList.Count == SentenceSearchHistoryListIndex && m_IsBack)
                SentenceSearchHistoryListIndex = SentenceSearchHistoryList.Count - 1;

            SearchDTO dto = WordSearchHistoryList[SentenceSearchHistoryListIndex-1];
            return dto;
        }

        protected void imgBack_Click(object sender, ImageClickEventArgs e)
        {
            m_IsBack = true;
            IsSearchFromHistory = true;

            if (SentenceSearchHistoryListIndex == -1)
            {
                if(SentenceSearchHistoryList.Count == m_SearchHistoryLimit)
                    SentenceSearchHistoryListIndex = m_SearchHistoryLimit;//SentenceSearchHistoryList.Count - 1;
                else
                    SentenceSearchHistoryListIndex = SentenceSearchHistoryList.Count - 1;

                //imgForward.Visible = true;
            }
            else
                SentenceSearchHistoryListIndex--;

            if(SentenceSearchHistoryListIndex < 0)
            {
                SentenceSearchHistoryListIndex = 0;
            }
            if (SentenceSearchHistoryListIndex ==1)
            {
                imgBack.Visible = false;
            }

            imgForward.Visible = true;
            //UpdatePanel2.Update();

            SearchSentence();
            //SearchWords();
            //SearchWordsUserCreated();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript_back",
                      string.Format("InitializeCategory('{0}');InitializeSearchText('{1}');AppendCircleButton();", hdnTopCategoryName.Value, m_SearchText
                          ),
                      true);
            
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

            imgBack.Visible = true;
            //UpdatePanel2.Update();
            SearchSentence();
            //SearchWords();
            //SearchWordsUserCreated();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeCategoryscript_back",
                      string.Format("InitializeCategory('{0}');InitializeSearchText('{1}');AppendCircleButton();", hdnTopCategoryName.Value, m_SearchText
                          ),
                      true);
            IsSearchFromHistory = false;
        }

        private void SearchAll()
        {
            m_IsSearchAll = true;
            SearchWords();
            SearchWordsUserCreated();
            SearchSentence();
            m_IsSearchAll = false;
        }
        private void LoadSavedMessage()
        {
            Language.Discovery.Repository.UserRepository user = new Repository.UserRepository();
            UserMessageContract um =  user.GetUserSavedMessage(SessionManager.Instance.UserProfile.UserID);
            if (um != null)
            {
                hdnLearningLanguageForSave.Value = um.LearningLanguageMessage;
                hdnNativeLangaugeForSave.Value = um.NativeLanguageMessage;
                hdnSavedMessageId.Value = um.UserMailID.ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "loadsavedmessagescript", "LoadSavedMessage();", true);
            }
        }
    }
}