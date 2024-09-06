using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class Ip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ip = Request.ServerVariables["REMOTE_ADDR"] + ":" + Request.ServerVariables["LOCAL_ADDR"] + ":" + HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            Response.Write("REMOTE_ADDR - " + Request.ServerVariables["REMOTE_ADDR"] );
            Response.Write("<br/>");
            Response.Write("LOCAL_ADDR - " + Request.ServerVariables["LOCAL_ADDR"]);
            Response.Write("<br/>");
            Response.Write("HTTP_X_FORWARDED_FOR - " + Request.ServerVariables["HTTP_X_FORWARDED_FOR"]);
            Response.Write("<br/>");
            Response.Write("UserHostAddress - " + HttpContext.Current.Request.UserHostAddress);
            Response.Write("<br/>");

            //Label1.Text = ip;

        }
    }
}