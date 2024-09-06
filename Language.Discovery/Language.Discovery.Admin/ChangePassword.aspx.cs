using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class ChangePassword1 : System.Web.UI.Page
    {
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
                    Response.Redirect("~/Timeout");
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Timeout");
        }
    }
}