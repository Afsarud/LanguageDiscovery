using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery
{
    public partial class ChangePassword1 : System.Web.UI.Page
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
            lblUsernameText.Text = SessionManager.Instance.UserProfile.UserName;
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                bool isSuccess = new UserRepository().ChangePassword(SessionManager.Instance.UserProfile.UserID, new Security().Encrypt(txtPassword.Text, ConfigurationManager.AppSettings.Get("Salt")));
                if (isSuccess)
                {
                    Response.Redirect("~/Logout");
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Logout");
        }
    }
}