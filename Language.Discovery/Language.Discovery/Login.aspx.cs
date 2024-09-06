using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.UserService;
using Language.Discovery.SchoolService;
using System.Web.Script.Serialization;
using Language.Discovery.Entity;
using System.ServiceModel;
using System.Net.Mail;
using System.Configuration;
using System.Text;
using System.Net.Mime;
using System.Text.RegularExpressions;
using System.Globalization;
using Language.Discovery.Repository;

namespace Language.Discovery.Account
{
    public partial class Login : Page
    {
        protected override void InitializeCulture()
        {
            if (Request.UserLanguages != null)
            {
                string lang = Request.UserLanguages[0].ToString() == "en-AU" ? "en-US" : Request.UserLanguages[0].ToString();
                if (lang.Contains("ja"))
                    lang = "ja-JP";
                else if( lang.Contains("en") )
                    lang = "en-US";

                UICulture = lang;

                base.InitializeCulture();
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Abandon();
                Session.Clear();
                FormsAuthentication.SignOut();
            }
            btnRegister.Visible = Convert.ToBoolean(hdnIsRegisterVisible.Value);
            if (Request.QueryString["timeout"] != null && Request.QueryString["timeout"].Length > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "logoutnamen", "ShowTimeout();", true);
            }
            Panel1.DefaultButton = ((Button)Login1.FindControl("btnLogin")).UniqueID;

            TextBox txt = Login1.FindControl("UserName") as TextBox;
            TextBox pass = Login1.FindControl("Password") as TextBox;
            if (txt != null)
            {
                if (Session["RegisteredUserName"] != null)
                {
                    txt.Text = Session["RegisteredUserName"].ToString();
                    pass.Focus();
                    return;
                }

                txt.Focus();
            }
        }

        private void ShowMessage()
        {
            Label lbl = (Label)Login1.FindControl("lblMessage");
            if (lbl != null)
            {
                lbl.Visible = true;
            }
        }

        private void ShowMessage(string message)
        {
            Label lbl = (Label)Login1.FindControl("lblMessage");
            if (lbl != null)
            {
                lbl.Text = message;
                lbl.Visible = true;
            }
        }

        
        private bool IsUserActive()
        {
            try
            {
                bool isactive = false;
                UserClient user = new UserClient();
                string json = user.GetUserDetailsByUserName(Login1.UserName);

                UserContract userContract = new JavaScriptSerializer().Deserialize<UserContract>(json);
                isactive = userContract.IsActive;

                return isactive;

            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        private bool IsUserHasAfterSchoolAccess()
        {
            try
            {
                bool afterschool = false;
                UserClient user = new UserClient();
                string json = user.GetUserDetailsByUserName(Login1.UserName);

                UserContract userContract = new JavaScriptSerializer().Deserialize<UserContract>(json);
                afterschool = userContract.AfterSchool;

                return afterschool;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }


        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                //if (!IsUserActive())
                //{
                //    Button btn = (Button)Login1.FindControl("btnLogin");
                //    if (btn != null)
                //        btn.CausesValidation = false;
                //    //show Agreement first
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowAgreement", "ShowAgreement();", true);
                //}
                //else
                //{
                if (Login1.UserName.Trim().Length == 0 || Login1.Password.Trim().Length == 0)
                {
                    return;
                }
                UserClient user = new UserClient();
                string json = "";
                if (txtParentsGivenName.Text.Length > 0)
                {
                    json = user.GetUserDetailsByUserName(Login1.UserName);
                    UserContract u = new JavaScriptSerializer().Deserialize<UserContract>(json);
                    if (u != null)
                    {
                        bool success = user.UpdateUserAfterSchoolStatus(u.UserID, true, txtParentsName.Text, txtParentsGivenName.Text, txtEmail.Text);
                        if (success)
                        {
                            EmailConfirmation(txtEmail.Text, u.UserName);
                        }
                    }
                }
                bool isSuccessSendAutoMessage = false;
                Repository.Security sec = new Repository.Security();
                json = user.Authenticate(Login1.UserName, sec.Encrypt(Login1.Password, ConfigurationManager.AppSettings.Get("Salt")));
                UserContract userContract = new JavaScriptSerializer().Deserialize<UserContract>(json);
                if (userContract != null && userContract.UserID > 0)
                {
                    SessionManager.Instance.UserProfile = userContract;
                    SchoolContract school = new SchoolServiceClient().GetByID(userContract.SchoolID);
                    SessionManager.Instance.SchoolProfile = school;
                    //SessionManager.Instance.IsTalkOpen = false;
                    isSuccessSendAutoMessage = user.SendAutoMail(userContract.UserID);
                }
                else
                {
                    //ShowMessage();
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
                    UserInterestContract[] uicList = new UserService.UserClient().GetUserInterest(SessionManager.Instance.UserProfile.UserID, SessionManager.Instance.UserProfile.NativeLanguage);
                    SessionManager.Instance.UserProfile.HasProfileSetup = true;
                    bool hasyear = SessionManager.Instance.UserProfile.GradeID > 0;
                    if ((uicList == null || !hasyear)
                        && (SessionManager.Instance.UserProfile.UserTypeID == (int)Language.Discovery.UserType.Student
                            || SessionManager.Instance.UserProfile.UserTypeID == (int)Language.Discovery.UserType.Teacher))
                    {
                        SessionManager.Instance.UserProfile.HasProfileSetup = false;
                        Response.Redirect("Student/MyRoom");
                        return;
                    }
                    //int unread = user.GetUnreadMessage(SessionManager.Instance.UserProfile.UserID);
                    //int messageneedreply = user.GetMessageCountThatNeedsReply(SessionManager.Instance.UserProfile.UserID);
                    //if (isSuccessSendAutoMessage || unread > 0 || (unread == 0 && messageneedreply > 0))
                    //{
                    //    string querystring = "";
                    //    if (unread > 0)
                    //        querystring = "?hn=1";
                    //    else if (unread == 0 && messageneedreply > 0)
                    //        querystring = "?hn=0&mnr=1";
                    //    Response.Redirect("Student/Home" + querystring);
                    //}
                    //else
                    Response.Redirect("Student/home"); //Added By Afsar
                    //Response.Redirect("Information");
                }
                //}
            }
            catch (Exception ex)
            {
                //Logger
                throw ex;
            }
        }

        private void MailRequestPassword(UserContract user)
        {
            try
            {
                bool isvalidemail = false;
                SchoolContract school = new SchoolServiceClient().GetByID(user.SchoolID);
                string schoolname = "";
                string email = hdnMailTo.Value;
                if (school != null)
                {
                    schoolname = school.Name1 + " ( " + school.Name2 + " )";
                    ZendeskUser teacher = new ZendeskRepository().GetZendeskEndUser(school.LinkKey);
                    if (teacher != null && teacher.User != null)
                    {
                        hdnMailToTeacher.Value = teacher.User.Email;
                    }
                    else
                    {
                        ZendeskUser u = new ZendeskRepository().GetZendeskEndUser(user.LinkKey);
                        if (u != null && u.User != null)
                        {
                            hdnMailToTeacher.Value = u.User.Email;
                        }
                    }
                }

                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"]);
                //smtp.UseDefaultCredentials = false;
                //smtp.Credentials = new System.Net.NetworkCredential("ferdinandbelasa@outlook.com", "P@ssw0rd.mathy");
                //smtp.Port = 587;
                //smtp.EnableSsl = true;                

                

                MailMessage msg = new MailMessage("No_Reply_Password_Request@languageDiscovery.org", hdnMailTo.Value);//ConfigurationManager.AppSettings["PasswordRecoveryEmail"]);
                
                msg.IsBodyHtml = true;
                //string alert = "alert('An Email has been sent to admin.');";
                
                if (user.SendPasswordToTeacher)
                {
                    isvalidemail = IsValidEmail(hdnMailToTeacher.Value);
                    msg = new MailMessage(hdnMailTo.Value, hdnMailToTeacher.Value);
                    msg.Subject = GetLocalResourceObject("PasswordRequestWithEmailSubject").ToString();
                    msg.Body = string.Format(GetLocalResourceObject("PasswordRequestContent").ToString(),
                        new Security().Decrypt(user.Password, ConfigurationManager.AppSettings.Get("Salt")), user.Furigana, user.ClassName, user.FirstName);
                }
                else
                {
                    isvalidemail = IsValidEmail(hdnMailToTeacher.Value);
                    if (string.IsNullOrEmpty(hdnMailToTeacher.Value) || !isvalidemail)
                    {
                        //string username = ((TextBox)Login1.FindControl("txtRequestUserName")).Text;
                        msg.Subject =
                            string.Format(GetLocalResourceObject("PasswordRequestWithoutEmailSubject").ToString(),
                                user.UserName);
                        msg.Body = "Please reset my password. My User Name is " + user.UserName + " from school " +
                                   schoolname;
                        isvalidemail = true;
                    }
                    else
                    {
                        msg = new MailMessage(hdnMailTo.Value, hdnMailToTeacher.Value);
                        msg.Subject = GetLocalResourceObject("PasswordRequestWithEmailSubject").ToString();
                        msg.Body = string.Format(GetLocalResourceObject("PasswordRequestContent").ToString(),
                            new Security().Decrypt(user.Password, ConfigurationManager.AppSettings.Get("Salt")), user.Furigana, user.ClassName, user.FirstName);
                        //alert = "alert('An Email has been sent to your registered email. Please check your email.');";
                    }
                }
                if (ConfigurationManager.AppSettings["ENV"] == "DEV")
                {
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["DEVUserName"], ConfigurationManager.AppSettings["DEVPassword"]);
                    smtp.Port = 2525;
                    smtp.EnableSsl = true;
                }
                else
                {
                    smtp.Port = 25;
                }
                
                if( isvalidemail  )
                    smtp.Send(msg);

                if (user.SendPasswordToTeacher)
                    ClientScript.RegisterStartupScript(this.GetType(), "alertUser", string.Format("alert('{0}');", GetLocalResourceObject("PasswordRequestMessageTeacher")), true);
                else
                    ClientScript.RegisterStartupScript(this.GetType(), "alertUser", string.Format("alert('{0}');", GetLocalResourceObject("PasswordRequestMessage")), true);


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                    return;
                UserClient client = new UserClient();
                TextBox txt = (TextBox)Login1.FindControl("txtRequestUserName");
                string json = client.GetUserDetailsByUserName(txt.Text);
                if (json == "null")
                {
                    ShowMessage("UserName does not exists.");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showforgot", "ShowForgotPassword();", true);
                    return;
                }
                else
                {
                    UserContract user = new JavaScriptSerializer().Deserialize<UserContract>(json);
                    MailRequestPassword(user);
                }

                
            }
            catch (SmtpException smtpex)
            {
                ShowMessage("There is an error sending email on " + ConfigurationManager.AppSettings["SMTP"] );
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void linkContactSupport_Click(object sender, EventArgs e)
        {
            //Response.Redirect(hdnContactPalaygo.Value);
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect(hdnRegister.Value);
        }

        private bool EmailConfirmation2(string mailto)
        {
            bool success = false;
            try
            {
                //for testing
                //SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"])
                //{
                //    Credentials = new NetworkCredential("", ""),
                //    EnableSsl = true
                //};

                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"]);
                //smtp.UseDefaultCredentials = false;
                //smtp.Credentials = new System.Net.NetworkCredential("ferdinandbelasa@outlook.com", "P@ssw0rd.mathy");
                ////smtp.Port = 587;
                //smtp.EnableSsl = true;                

                MailMessage msg = new MailMessage("No_Reply_LanguageDicovery@languageDiscovery.org", mailto);//ConfigurationManager.AppSettings["PasswordRecoveryEmail"]);
                //MailMessage msg = new MailMessage();
                //msg.To.Add(mailto);
                //msg.From = new MailAddress("No_Reply_LanguageDicovery@languageDiscovery.org");

                msg.IsBodyHtml = true;
                //string username = ((TextBox)Login1.FindControl("txtRequestUserName")).Text;

                msg.Subject = GetLocalResourceObject("EmailSubject").ToString(); 
                StringBuilder body = new StringBuilder();
                body.Append(GetLocalResourceObject("EmailContent").ToString());
                msg.Body = body.ToString();
                //smtp.Port = 587; //for testing
                smtp.Port = 25;
                smtp.Send(msg);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertUser", "alert('An Email has been sent to admin.')", true);
                success = true;
            }
            catch (Exception)
            {
                success = false;
                throw;
            }
            return success;
        }

        private bool EmailConfirmation(string mailfrom, string username)
        {
            bool success = false;
            try
            {
                //for testing
                //SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"])
                //{
                //    Credentials = new NetworkCredential("", ""),
                //    EnableSsl = true
                //};

                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"]);
                //smtp.UseDefaultCredentials = false;
                //smtp.Credentials = new System.Net.NetworkCredential("", "");
                //smtp.Port = 587;
                //smtp.EnableSsl = true;                

                MailMessage msg = new MailMessage(mailfrom, hdnDemoUserMailTo.Value );//ConfigurationManager.AppSettings["PasswordRecoveryEmail"]);
                //MailMessage msg = new MailMessage();
                //msg.To.Add(mailto);
                //msg.From = new MailAddress("No_Reply_LanguageDicovery@languageDiscovery.org");

                msg.IsBodyHtml = true;
                //string username = ((TextBox)Login1.FindControl("txtRequestUserName")).Text;

                msg.Subject = GetLocalResourceObject("EmailSubject").ToString();
                StringBuilder body = new StringBuilder();
                body.AppendFormat(GetLocalResourceObject("EmailContent").ToString(), txtParentsGivenName.Text, txtEmail.Text, username);
                msg.Body = body.ToString();
                //smtp.Port = 587; //for testing
                smtp.Port = 25;
                smtp.Send(msg);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alertUser", "alert('An Email has been sent to admin.')", true);
                success = true;
            }
            catch (Exception)
            {
                success = false;
                throw;
            }
            return success;
        }

        bool invalid = false;

        public bool IsValidEmail(string strIn)
        {
            invalid = false;
            if (String.IsNullOrEmpty(strIn))
                return false;

            // Use IdnMapping class to convert Unicode domain names. 
            try
            {
                strIn = Regex.Replace(strIn, @"(@)(.+)$", this.DomainMapper,
                                      RegexOptions.None, TimeSpan.FromMilliseconds(200));
            }
            catch (RegexMatchTimeoutException)
            {
                return false;
            }

            if (invalid)
                return false;

            // Return true if strIn is in valid e-mail format. 
            try
            {
                return Regex.IsMatch(strIn,
                      @"^(?("")("".+?(?<!\\)""@)|(([0-9a-z]((\.(?!\.))|[-!#\$%&'\*\+/=\?\^`\{\}\|~\w])*)(?<=[0-9a-z])@))" +
                      @"(?(\[)(\[(\d{1,3}\.){3}\d{1,3}\])|(([0-9a-z][-\w]*[0-9a-z]*\.)+[a-z0-9][\-a-z0-9]{0,22}[a-z0-9]))$",
                      RegexOptions.IgnoreCase, TimeSpan.FromMilliseconds(250));
            }
            catch (RegexMatchTimeoutException)
            {
                return false;
            }
        }

        private string DomainMapper(Match match)
        {
            // IdnMapping class with default property values.
            IdnMapping idn = new IdnMapping();

            string domainName = match.Groups[2].Value;
            try
            {
                domainName = idn.GetAscii(domainName);
            }
            catch (ArgumentException)
            {
                invalid = true;
            }
            return match.Groups[1].Value + domainName;
        }

    }
}