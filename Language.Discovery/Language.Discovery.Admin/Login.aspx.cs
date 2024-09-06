using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Admin.SchoolService;
using Language.Discovery.Admin.UserService;
using Language.Discovery.Entity;
using System.Globalization;
using Language.Discovery.Repository;
using System.Configuration;

namespace Language.Discovery.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        private string _culture = "en-US";
        protected override void InitializeCulture()
        {
            //if (Request.UserLanguages != null)
            //{
            //    string lang = Request.UserLanguages[0].ToString() == "en-AU" ? "en-US" : Request.UserLanguages[0].ToString();

            //    UICulture = lang;

            //    base.InitializeCulture();
            //}


            if (Request.UserLanguages != null)
            {
                string lang = Request.UserLanguages[0].ToString() == "en-AU" ? "en-US" : Request.UserLanguages[0].ToString();
                if (lang.Contains("ja"))
                    lang = "ja-JP";
                else if (lang.Contains("en"))
                    lang = "en-US";
                _culture = lang;
                UICulture = lang;

                base.InitializeCulture();
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //System.Data.Entity.Design.PluralizationServices.PluralizationService x = System.Data.Entity.Design.PluralizationServices.PluralizationService.CreateService(CultureInfo.GetCultureInfo("en-us"));
            //string xx = x.Pluralize("person");
            //string ip = Request.ServerVariables["REMOTE_ADDR"] + ":" + Request.ServerVariables["LOCAL_ADDR"];
            //Label1.Text = ip;
            txtUsername.Focus();
        }

        private void SignIn()
        {
            try
            {

                UserClient user = new UserClient();
                string json = user.AuthenticateAdmin(txtUsername.Text, new Security().Encrypt(txtPassword.Text, ConfigurationManager.AppSettings.Get("Salt")));

                UserContract userContract = new JavaScriptSerializer().Deserialize<UserContract>(json);
                if (userContract != null)
                {
                    if (userContract.UserTypeName == "Student")
                    {
                        ShowMessage();
                        return;
                    }
                    SessionManager.Instance.UserProfile = userContract;
                    if (userContract.UserTypeName.ToLower() == "administrator")
                    {
                        SessionManager.Instance.UserProfile.NativeLanguage = _culture;
                    }
                    //if (userContract.UserTypeName == "Teacher")
                    //{
                        SchoolContract school = new SchoolServiceClient().GetByID(userContract.SchoolID);
                        SessionManager.Instance.SchoolProfile = school;
                    //}

                }
                else
                {
                    ShowMessage();
                    return;
                }

                FormsAuthentication.SetAuthCookie(userContract.UserID.ToString(), false);
                //SessionManager.Instance.Roles = "Student";

                // Create the cookie that contains the forms authentication ticket

                HttpCookie authCookie = FormsAuthentication.GetAuthCookie(userContract.UserID.ToString(), false);

                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);

                FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(ticket.Version, ticket.Name, ticket.IssueDate, ticket.Expiration.AddDays(1), ticket.IsPersistent, SessionManager.Instance.UserProfile.UserTypeName, FormsAuthentication.FormsCookiePath);

                authCookie.Value = FormsAuthentication.Encrypt(newTicket);

                Response.Cookies.Add(authCookie);

                //string redirUrl = FormsAuthentication.GetRedirectUrl(userContract.UserID.ToString(), true);

                //Response.Redirect(redirUrl);



                //Login successful lets put him to requested page
                string returnUrl = Request.QueryString["ReturnUrl"] as string;

                if (returnUrl != null)
                {
                    Response.Redirect(returnUrl);
                }
                else
                {
                    //no return URL specified so lets kick him to home page
                    //Response.Redirect("Student/Profile.aspx");
                    if(Request.QueryString["sc"] != null)
                        Response.Redirect("Default?sc=1");
                    else
                        Response.Redirect("Default");
                }

            }
            catch (Exception ex)
            {
                //Logger
                throw ex;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {

                SignIn();

            }
            catch (Exception ex)
            {
                //Logger
                throw ex;
            }
        }

        private void ShowMessage()
        {
            lblMessages.Text = "Access denied.";
            lblMessages.Visible = true;
        }

        protected void btnRealLogin_Click(object sender, EventArgs e)
        {
            try
            {

                SignIn();

            }
            catch (Exception ex)
            {
                //Logger
                throw ex;
            }
        }
    }
}