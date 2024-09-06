using Language.Discovery.Admin.AuxilliaryService;
using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Repository;
using System.Net.Mail;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Globalization;

namespace Language.Discovery.Admin
{
    public partial class TeachersRegistration : BasePage
    {
        bool invalid = false;

        private string ObjectID
        {
            get
            {
                string wid = "";
                if (ViewState["ObjectID"] != null)
                {
                    wid = Convert.ToString(ViewState["ObjectID"]);
                }
                return wid;
            }
            set
            {
                ViewState["ObjectID"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }

        private void BindResult()
        {
            try
            {
              

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            try
            {
                Clear();
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        private void Clear()
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtSchoolName.Text = string.Empty;
            txtTelephone.Text = string.Empty;
            ddlGender.SelectedValue = string.Empty;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                    return;

                if (Save())
                {
                    ShowMessage(false);
                    
                }
            }
            catch (Exception ex)
            {
                
                throw ex; 
            }
        }

        private bool Save()
        {
            TeacherRegistrationContract tc = new TeacherRegistrationContract();
            TeacherRegistrationRepository repo = new TeacherRegistrationRepository();
            tc.FirstName = txtFirstName.Text;
            tc.LastName = txtLastName.Text;
            tc.Gender = ddlGender.SelectedItem.Text;
            tc.SchoolName = txtSchoolName.Text;
            tc.Telephone = txtTelephone.Text;
            tc.ObjectID = Guid.NewGuid().ToString().Replace("-", "");
            tc.Email = txtEmail.Text;
            int id = Convert.ToInt32(repo.Add(tc));

            if(id > 0)
                MailInstruction(tc);

            return id > 0;
            
        }

        private void MailInstruction(TeacherRegistrationContract tc)
        {
            try
            {
                string link = "<a href='{0}'>Clink here to continue.</a>";
                string queryString = "?id={0}";
                queryString = String.Format(queryString, tc.ObjectID);
                link = string.Format(link, ConfigurationManager.AppSettings["Homesite"].ToString() + queryString);

                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"]);
                //smtp.UseDefaultCredentials = false;
                //smtp.Credentials = new System.Net.NetworkCredential("", "");
                //smtp.Port = 587;
                //smtp.EnableSsl = true;                
                

                string email = txtEmail.Text;

                MailMessage msg = new MailMessage("No_Reply_LanguageDicovery@languageDiscovery.org", email);//ConfigurationManager.AppSettings["PasswordRecoveryEmail"]);

                msg.IsBodyHtml = true;
                
                bool isvalidemail = IsValidEmail(email);
                msg.Subject = "Palaygo Home Registration";
                msg.Body = String.Format(ConfigurationManager.AppSettings["TeacherRegistrationEmailBody"].ToString(), txtFirstName.Text, "<br>" + link);



                smtp.Port = 25;
                if (isvalidemail)
                    smtp.Send(msg);

                ClientScript.RegisterStartupScript(this.GetType(), "alertUser", string.Format("alert('{0}');", "Email Sent"), true);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool IsValidEmail(string strIn)
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

        private void ShowMessage(bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            if (!isError)
                lblMessage.Text = "Action Successfull.";
            lblMessage.Visible = true;
        }
        private void ShowMessage(string message, bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            //if (!isError)
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }

    }
}