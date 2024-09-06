using Language.Discovery.UserService;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string querystring = "";
            if (SessionManager.Instance.UserProfile != null)
            {
                UserClient client = new UserClient();
                bool signout = client.SignOut(SessionManager.Instance.UserProfile.UserID);
            }
            else
            {
                querystring = "1";
            }

            //if (Request.QueryString["t"] != null && Request.QueryString["t"] == "1")
            //querystring = "1";

            Session.Abandon();
            Session.Clear();
            FormsAuthentication.SignOut();
            string env = ConfigurationManager.AppSettings["ENV"] == "UAT" ? "/UAT" : "";
            string additional =  Request.QueryString.Count > 0 && Request.QueryString["t"] != null ? "ReturnUrl=" + HttpUtility.UrlEncode( String.Format("{0}/Student/Confirmation?", env) + Request.QueryString.ToString()) : "" ;
            if (querystring.Length > 0)
                Response.Redirect(ResolveUrl("~/Login?timeout=1" + (String.IsNullOrEmpty(additional) ? "" : "&" + additional)));
            else
                Response.Redirect(ResolveUrl("~/Login" + (String.IsNullOrEmpty(additional) ? "" : "?" + additional)));
        }
    }
}