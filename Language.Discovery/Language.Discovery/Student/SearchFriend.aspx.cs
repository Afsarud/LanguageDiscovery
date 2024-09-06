using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Student
{
    public partial class SearchFriend : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            UICulture = SessionManager.Instance.UserProfile.NativeLanguage;

            base.InitializeCulture();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            txtUser.Focus();
        }
    }
}