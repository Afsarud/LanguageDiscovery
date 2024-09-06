using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.MiscService;
using Language.Discovery.UserService;
using Language.Discovery.Entity;
using System.Web.Script.Serialization;
using Language.Discovery.AuxilliaryServices;
using Language.Discovery.Repository;
using System.Configuration;

namespace Language.Discovery.Student
{
    public partial class Home : System.Web.UI.Page
    {
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
            string disablenewfriends = "";
            if (!IsPostBack)
            {
                hdnLanguage.Value = SessionManager.Instance.UserProfile.NativeLanguage;
                //hdnCurrentUserID.Value = SessionManager.Instance.UserProfile.UserID.ToString();
                //hdnDontShowQuickGuide.Value = SessionManager.Instance.UserProfile.DontShowQuickGuide.ToString().ToLower();
                //UserInterestContract[] uicList = new UserService.UserClient().GetUserInterest(SessionManager.Instance.UserProfile.UserID, SessionManager.Instance.UserProfile.NativeLanguage);
                //bool hasyear = SessionManager.Instance.UserProfile.GradeID > 0;
                //if ((uicList == null || !hasyear) && SessionManager.Instance.UserProfile.UserTypeID == (int)Language.Discovery.UserType.Student)
                //{
                //    Response.Redirect("Profile");
                //    return;
                //}
                imgAvatar.ImageUrl = "../Images/avatar/" + SessionManager.Instance.UserProfile.Avatar;
                lblName.Text = SessionManager.Instance.UserProfile.FirstName;
                PopulateDropdownList();
                PopulateInterest();
                PopulateInfo();

                UserClient client = new UserClient();
                int unread = client.GetUnreadMessage(SessionManager.Instance.UserProfile.UserID);
                if (unread >= Convert.ToInt32(ConfigurationManager.AppSettings["UnreadThreshold"]))
                {
                    linkHasMessages.Visible = true;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "blinknow", "blink();", true);
                }
                else
                    linkHasMessages.Visible = false;
                if(unread > 0)
                {
                    disablenewfriends = "DisableNewFriends();";
                }
                UserMessageLikeRankingContract[] list = null;
                list = new UserService.UserClient().GetUserMessageLikeRanking(SessionManager.Instance.UserProfile.UserID);
                if (list != null && list.Length > 0)
                {
                    //lblStar.Text += " " + list[0].LikeCount.ToString() + " !";
                    lblStartCount.Text = list[0].LikeCount.ToString() + " !";
                }

                hdnCurrentUserID.Value = SessionManager.Instance.UserProfile.UserID.ToString();
                //Search(0, "Friends");
                //Search(1, "OnlineFriends");
                //Search(2, "New");
            }

            hdnIsDemo.Value = SessionManager.Instance.UserProfile.IsDemo.ToString();
            hdnIsLevelDemo.Value = SessionManager.Instance.SchoolProfile.IsLevelDemo.ToString();
            hdnLevel.Value = SessionManager.Instance.UserProfile.LevelID.ToString();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Initializetabs", "InitializeTabs(); InitializeChatHub();InitializeMainTab();" + disablenewfriends, true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SetDefaultTab", "SetDefaultTab();AddLocalstorage("+ SessionManager.Instance.UserProfile.UserID + ");", true);
        }

        

        private void PopulateInfo()
        {
            try
            {
                AuxilliaryServicesClient c = new AuxilliaryServicesClient();
                InfoContract notice =  c.GetInfoByType("Notice");
                //InfoContract news =  c.GetInfoByType("News");
                lblNotice.Text = notice != null ? notice.InfoMessage : "";
                //lblNews.Text = news != null ? news.InfoMessage : "";
                //lblJapanNewsLabel.Attributes.Add("href", "../Content/images/info/" + (news != null ? news.ImageFile : ""));
                //lblNoticeLabel.Attributes.Add("href", "../Content/images/info/" + (notice != null ? notice.ImageFile: ""));
                UserMessageLikeRankingContract[] ar = new UserService.UserClient().GetUserMessageLikeRanking(0);
                if (ar != null)
                {
                    List<UserMessageLikeRankingContract> list = ar.ToList();
                    rptRanking.DataSource = list;
                    rptRanking.DataBind();
                }
                hdnDontShowVideo.Value = SessionManager.Instance.UserProfile.DontShowVideo.ToString().ToLower();
                
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void PopulateInterest()
        {
            try
            {
                string json = new MiscServiceClient().GetInterestList(SessionManager.Instance.UserProfile.NativeLanguage);
                List<InterestContract> list = new JavaScriptSerializer().Deserialize<List<InterestContract>>(json);
                chkInterestGroup.DataSource = list;
                chkInterestGroup.DataBind();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void PopulateDropdownList()
        {
            try
            {
                //string json = new MiscServiceClient().GetCountryList();
                //List<CountryContract> list = new JavaScriptSerializer().Deserialize<List<CountryContract>>(json);
                //list.Insert(0, new CountryContract() { CountryID = 0, CountryName="[All]" });
                //var c = list.Find(x => x.CountryID.Equals(SessionManager.Instance.UserProfile.CountryID));
                //if (c != null)
                //    list.Remove(c);

                //ddlCountry.DataSource = list;
                //ddlCountry.DataTextField = "CountryName";
                //ddlCountry.DataValueField = "CountryID";
                //ddlCountry.DataBind();

                //List<CityContract> citylist = new List<CityContract>();
                //citylist.Insert(0, new CityContract() { CityID = 0, CityName = "[All]" });
                //ddlCity.DataSource = citylist;
                //ddlCity.DataTextField = "CityName";
                //ddlCity.DataValueField = "CityID";
                //ddlCity.DataBind();

                PopulateCity();

                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        private void PopulateCity()
        {
            try
            {

                string json = new MiscServiceClient().GetCountryList();
                List<CountryContract> listc = new JavaScriptSerializer().Deserialize<List<CountryContract>>(json);
                var c = listc.Find(x => x.CountryID.Equals(SessionManager.Instance.UserProfile.CountryID));
                if (c != null)
                    listc.Remove(c);

                json = new MiscServiceClient().GetCityListByCountryAndLanguage(listc[0].CountryID, SessionManager.Instance.UserProfile.NativeLanguage);

                List<CityContract> list = new MiscRepository().GetCityListByUserID(SessionManager.Instance.UserProfile.UserID);
                if (list != null)
                    list.Insert(0, new CityContract() { CityID = 0, CityName = "[All]" });
                else
                {
                    list = new List<CityContract>();
                    list.Insert(0, new CityContract() { CityID = 0, CityName = "[All]" });
                }

                ddlCity.DataSource = list;
                ddlCity.DataTextField = "CityName";
                ddlCity.DataValueField = "CityID";
                ddlCity.DataBind();
                //UpdatePanel1.Update();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                PopulateCity();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        protected void imgSearch_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                int index = hdnSelectedTab.Value.Length > 0 ? Convert.ToInt32(hdnSelectedTab.Value) : 0;
                string type = "Friends";
                if (index == 1)
                    type = "OnlineFriends";
                else if (index == 2)
                    type = "New";
                Search(index, type);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private List<CountryContract> GetCountryList()
        {
            try
            {
                List<CountryContract> list = null;
                string json = new MiscServiceClient().GetCountryList();
                list = new JavaScriptSerializer().Deserialize<List<CountryContract>>(json);

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private List<CityContract> GetCityList()
        {
            try
            {
                List<CityContract> list = null;
                string json = new MiscServiceClient().GetCityListByLanguage("en-US");
                list = new JavaScriptSerializer().Deserialize<List<CityContract>>(json);

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Search( int index, string type)
        {
            try
            {
              

                string json = new UserClient().SearchPeople(Convert.ToInt32(ddlCountry.SelectedValue),
                    Convert.ToInt32(ddlCity.SelectedValue), type, txtSearch.Text, SessionManager.Instance.UserProfile.UserID);
                List<PeopleSearchContract> people = new JavaScriptSerializer().Deserialize<List<PeopleSearchContract>>(json);
                List<CountryContract> country = GetCountryList();
                List<CityContract> city = GetCityList();
                if (people != null)
                {
                    foreach (PeopleSearchContract person in people)
                    {
                        person.Avatar = person.Avatar.Length > 0 ? "../Images/avatar/" + person.Avatar : "../Images/avatar/no_avatar.png";
                        person.StatusImage = person.IsOnline ? "../Images/online.png" : "../Images/offline.png";
                        person.OnlineStatusText = person.IsOnline ? "Online Now" : "Offline Now";
                        person.LikeImage = person.ILike ? "../Images/heartUnlike.png" : "../Images/heartLike.png";
                        person.StatusDateText = person.StatusDate.ToString("dd MMM yy");

                        CountryContract c = country.SingleOrDefault(x => x.CountryID.Equals(person.CountryID ));
                        if( c != null )
                            person.Country = c.CountryName;

                        CityContract ct = city.SingleOrDefault(x => x.CityHeaderID.Equals(person.CityHeaderID));
                        if (ct != null)
                            person.City = ct.CityName;

                        person.Address = person.City + "," + person.Country;
                    }

                    if (index == 0)
                    {
                        rptFriends.DataSource = people;
                        rptFriends.DataBind();
                    }
                    else if (index == 1)
                    {
                        rptOnlineFriends.DataSource = people;
                        rptOnlineFriends.DataBind();
                    }
                    else
                    {
                        rptNew.DataSource = people;
                        rptNew.DataBind();
                    }

                }
                else
                {
                    if (index == 0)
                    {
                        rptFriends.DataSource = null;
                        rptFriends.DataBind();
                    }
                    else if (index == 1)
                    {
                        rptOnlineFriends.DataSource = null;
                        rptOnlineFriends.DataBind();
                    }
                    else
                    {
                        rptNew.DataSource = null;
                        rptNew.DataBind();
                    }
                }
                UpdatePanel1.Update();
            }
            catch (Exception ex)
            {
                throw ex;
            }
         
        }

        protected void btnPostback_Click(object sender, EventArgs e)
        {
            try
            {
                UserClient client = new UserClient();
                bool isdontshow = false;
                if (hdnDontShowVideo.Value.ToLower() == "true")
                    isdontshow = true;
                client.UpdateUserDontShowVideo(SessionManager.Instance.UserProfile.UserID, isdontshow);
                SessionManager.Instance.UserProfile.DontShowVideo = isdontshow;
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void btnWriteNewMessage_Click(object sender, EventArgs e)
        {
            try
            {
                Session["SelectedUsers"] = hdnSelectedUsers.Value;
                Response.Redirect("~/Student/SendMessage");
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}