using Language.Discovery.Entity;
using Language.Discovery.MiscService;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Repository;

namespace Language.Discovery
{
    public partial class Registration : System.Web.UI.Page
    {
        private string _language = "en-US";

        private string SchoolCode
        {
            get
            {
                string scode = string.Empty;
                if (ViewState["SchoolCode"] != null)
                {
                    scode = Convert.ToString(ViewState["SchoolCode"]);
                }

                return scode;
            }
            set
            {
                ViewState["SchoolCode"] = value;
            }
        }

        private string LangaugeCode
        {
            get
            {
                string scode = "en-US";
                if (ViewState["LangaugeCode"] != null)
                {
                    scode = Convert.ToString(ViewState["LangaugeCode"]);
                }

                return scode;
            }
            set
            {
                ViewState["LangaugeCode"] = value;
            }
        }

        private string ObjectId
        {
            get
            {
                string ocode= string.Empty;
                if (ViewState["ObjectId"] != null)
                {
                    ocode = Convert.ToString(ViewState["ObjectId"]);
                }

                return ocode;
            }
            set
            {
                ViewState["ObjectId"] = value;
            }
        }

        protected override void InitializeCulture()
        {
            if (Request.UserLanguages != null)
            {
                _language = Request.UserLanguages[0].ToString() == "en-AU" ? "en-US" : Request.UserLanguages[0].ToString();
                if (_language.Contains("ja"))
                    _language = "ja-JP";
                else if (_language.Contains("en"))
                    _language = "en-US";

                LangaugeCode = _language;
                UICulture = _language;

                base.InitializeCulture();
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            linkPrint.NavigateUrl = hdnPrintTC.Value;
            if (this.LangaugeCode == "en-US")
                RequiredFieldValidator4.Enabled = false;
            else
                RequiredFieldValidator4.Enabled = true;

            if (!IsPostBack)
            {
                
                string objectId = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                this.ObjectId = objectId;
                if (string.IsNullOrEmpty(objectId))
                {
                    Response.Redirect("Login");
                }
                else
                {
                    TeacherRegistrationRepository t = new TeacherRegistrationRepository();
                    List<TeacherRegistrationContract> tc = t.GetTeacherRegistration(objectId);
                    if(tc != null && tc.Count() > 0)
                    {
                        
                        if(tc[0].ExpiryDate < DateTime.Now || tc[0].IsRegistered)
                        {
                            Response.Redirect("Login");
                        }
                        else
                        {
                            txtParentsFullName.Text = tc[0].FirstName + " " + tc[0].LastName;
                            txtParentsEmail.Text = tc[0].Email;
                            txtSchoolName.Text = tc[0].SchoolName;
                            ddlGender.SelectedValue = tc[0].Gender;
                            txtUserName.Text = tc[0].FirstName;
                            txtFirstName.Text = tc[0].FirstName;
                            txtTelepone.Text = tc[0].Telephone;
                        }
                    }
                }

                GetSchoolCode();
            }
        }

        private void GetSchoolCode()
        {
            try
            {
                MiscServiceClient mclient = new MiscServiceClient();

                string json = mclient.GetSchoolList("");
                List<SchoolContract> schoollist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                if (schoollist != null)
                {
                    //SchoolContract sc = schoollist.Find(x => x.IsDefault && x.NativeLanguage == _language);
                    SchoolContract sc = schoollist.Find(x => x.IsDefault && x.NativeLanguage == _language);
                    if (sc != null)
                    {
                        SchoolCode = sc.SchoolCode;
                        txtAdditionalUserName.Text = "@" + sc.SchoolCode;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (!IsValid)
                {
                    Validate("v");
                    return;
                }
                string wheredidyoufind = GetRadioValue(this.pnlJapanese.Controls, "wheredidyoufind");
                UserService.UserClient us = new UserService.UserClient();

                string username = (txtUserName.Text.Length == 0 ? hdnUserName.Value.TrimEnd() : txtUserName.Text) + txtAdditionalUserName.Text.Trim(); //+ "@" + SchoolCode;
                string json = us.GetUserDetailsByUserName(username);

                UserContract userContract = new JavaScriptSerializer().Deserialize<UserContract>(json);
                if (userContract != null)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = string.Format(hdnUserAlreadyExist.Value,username);
                    //txtUserName.ReadOnly = false;
                    //txtUserName.BackColor = System.Drawing.Color.White;
                    txtUserName.Enabled = true;
                    txtUserName.Text = hdnUserName.Value;
                    txtAdditionalUserName.Enabled = false;
                    txtUserName.BackColor = System.Drawing.Color.White;
                    txtUserName.Focus();
                    txtFirstName.Enabled = false;
                    txtUserName.ReadOnly = false;
                    txtFirstName.BackColor = System.Drawing.Color.LightGray;
                    return;
                }

                UserContract uc;
                if (this.LangaugeCode == "ja-JP")
                {
                    uc = new UserContract()
                    {
                        ParentsName = txtParentsFullName.Text,
                        Email = txtParentsEmail.Text,
                        FirstName = txtFirstName.Text,
                        SchoolEntry = txtSchoolName.Text,
                        Gender = ddlGender.SelectedValue,
                        Password = txtPassword.Text,
                        Reference = wheredidyoufind,
                        UserName = username
                    };
                }
                else
                {
                    uc = new UserContract()
                    {
                        ParentsName = txtParentsFullName.Text,
                        Email = txtParentsEmail.Text,
                        FirstName = txtParentsFullName.Text.Split(' ')[0],
                        SchoolEntry = txtSchoolName.Text,
                        Gender = ddlGender.SelectedValue,
                        Password = txtPassword.Text,
                        Reference = wheredidyoufind,
                        UserName = username
                    };
                }

                if (us.RegisterUser(uc) > 0)
                {
                    lblUserName.Text = username;
                    ClientScript.RegisterStartupScript(this.GetType(), "scriptdialog", "ShowConfirmationDialog();", true);
                    Session["RegisteredUserName"] = username;
                    TeacherRegistrationRepository tr = new TeacherRegistrationRepository();
                    TeacherRegistrationContract tc = new TeacherRegistrationContract() { ObjectID = this.ObjectId };
                    tr.Update(tc);
                    EmailConfirmation(username, wheredidyoufind);
                    
                }
                else
                {
                    lblMessage.Visible = true;
                }


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool EmailConfirmation(string username, string wheredidyoufind)
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

                MailMessage msg = new MailMessage(txtParentsEmail.Text, hdnDemoUserMailTo.Value);//ConfigurationManager.AppSettings["PasswordRecoveryEmail"]);
                //MailMessage msg = new MailMessage();
                //msg.To.Add(mailto);
                //msg.From = new MailAddress("No_Reply_LanguageDicovery@languageDiscovery.org");

                msg.IsBodyHtml = true;
                //string username = ((TextBox)Login1.FindControl("txtRequestUserName")).Text;

                msg.Subject = GetLocalResourceObject("EmailSubject").ToString();
                StringBuilder body = new StringBuilder();
                body.AppendFormat(GetLocalResourceObject("EmailContent").ToString(), txtParentsFullName.Text, txtParentsEmail.Text, txtTelepone.Text, txtSchoolName.Text, username, ddlGender.SelectedValue);
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
        private string GetRadioValue(ControlCollection controls, string groupName)
        {
            string wheredidyoufind = string.Empty;
            var selectedRadioButton = controls.OfType<RadioButton>().FirstOrDefault(rb => rb.GroupName == groupName && rb.Checked);
            wheredidyoufind = selectedRadioButton == null ? string.Empty : selectedRadioButton.Attributes["Value"];
            if (RadioButton8.Checked)
            {
                wheredidyoufind = txtOther.Text;
            }
            

            return wheredidyoufind;
        }

    }
}