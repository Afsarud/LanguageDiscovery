using Language.Discovery.Entity;
using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Student
{
    public partial class Scheduler : System.Web.UI.Page
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
            hdnCurrentUser.Value = SessionManager.Instance.UserProfile.UserID.ToString();
            hdnLanguage.Value = SessionManager.Instance.UserProfile.NativeLanguage;
            hdnCurrentUserNumberOfMatching.Value = SessionManager.Instance.UserProfile.NumberOfMatching.ToString();

            if (!SessionManager.Instance.UserProfile.IsSupport && SessionManager.Instance.UserProfile.UserTypeID == 3 && SessionManager.Instance.UserProfile.CountryCode != "JP")
            {
                hdnParentsInfoFlag.Value = SessionManager.Instance.UserProfile.IsParentsInfoStored.ToString();
            }

            GetTopics();
        }

        public List<PhraseCategoryContract> GetTopics()
        {
            PhraseCategoryRepository rep = new PhraseCategoryRepository();
            List<PhraseCategoryContract> plist = rep.GetPhraseCategoryList(SessionManager.Instance.UserProfile.NativeLanguage, SessionManager.Instance.UserProfile.LevelID, SessionManager.Instance.UserProfile.SchoolID);
            List<TopCategoryContract> tcats = rep.GetTopCategoryList(SessionManager.Instance.UserProfile.NativeLanguage);
            List<PhraseCategoryContract> phraseList = new List<PhraseCategoryContract>();

            foreach (TopCategoryContract tc in tcats)
            {
                var list = plist.FindAll(x => x.TopCategoryHeaderID.Equals(tc.TopCategoryHeaderID) && !x.HideInScheduler);
                if (list != null)
                {
                    foreach (PhraseCategoryContract p in list)
                    {
                        if (p.PhraseCategoryCode.Trim().Equals(tc.TopCategoryName.Trim(), StringComparison.OrdinalIgnoreCase) || p.PhraseCategoryCode.Trim().Contains(tc.TopCategoryName.Trim()))
                        {
                            ddlTopic.Items.Add(new ListItem(p.PhraseCategoryCode, p.PhraseCategoryID.ToString()));
                        }
                        else
                        {
                            ddlTopic.Items.Add(new ListItem(tc.TopCategoryName + " - " + p.PhraseCategoryCode, p.PhraseCategoryID.ToString()));
                        }
                    }
                }
            }
            ddlTopic.Items.Insert(0, new ListItem("Load Default Topic", "0"));

            return phraseList;
        }
    }
}