using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.Repository;

namespace Language.Discovery.Admin
{
    public partial class SchedulerViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MatchMakerRepository rep = new MatchMakerRepository();
                List<TimeScheduleAuxContract> list = rep.GetAllTime();
                foreach (TimeScheduleAuxContract time in list)
                {
                    ddlTime.Items.Add(new ListItem(time.TimeSchedule.PadLeft(5,'0'), time.TimeSchedule.PadLeft(5, '0')));
                }
                txtStartDate.Text = DateTime.Now.AddDays(-7).ToString("dd/MM/yyyy");
                txtEndDate.Text = DateTime.Now.AddDays(21).ToString("dd/MM/yyyy");
                bind();
            }

        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            bind();
        }

        private void bind2()
        {
            try
            {
                DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
                DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;

                MatchMakerRepository rep = new MatchMakerRepository();
                List<ScheduleContractExt> list = rep.GetScheduleForAdmin(sdate, edate);
                foreach (ScheduleContractExt info in list)
                {
                    DateTime dt = DateTime.Now;
                    info.ScheduleJP = info.Schedule.DayOfWeek.ToString() + "<br/>" + info.Schedule.ToString("MMM dd HH:mm") + "(JP)";

                    var uk = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    dt = ConvertDateToTimezone(uk, info.Schedule);
                    info.ScheduleUK = dt.ToString("MMM dd HH:mm") + "(UK)";

                    var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    dt = ConvertDateToTimezone(aest, info.Schedule);
                    info.ScheduleAU = dt.ToString("MMM dd HH:mm") + (aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

                    var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    dt = ConvertDateToTimezone(acst, info.Schedule);
                    info.ScheduleAU += "<br/>" + dt.ToString("HH:mm") + (acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

                    var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    dt = ConvertDateToTimezone(awst, info.Schedule);
                    info.ScheduleAU += "<br/>" + dt.ToString("HH:mm") + "(AWST)";
                }
                grdResult.DataSource = list;
                grdResult.DataBind();
                //updateResult.Update();
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeDialog", "InitializeDialog();", true);
            }
            catch (Exception)
            {
                throw;
            }
        }

        private void bind()
        {
            try
            {
                DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
                DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;

                MatchMakerRepository rep = new MatchMakerRepository();
                List<ScheduleContractExt> list = rep.GetScheduleForAdmin(sdate, edate);
                foreach (ScheduleContractExt info in list)
                {
                    DateTime dt = DateTime.Now;
                    info.UserSchedule = GetScheduleByCountry(info.UserCountryCode, info.Schedule);
                    info.PartnerSchedule = GetScheduleByCountry(info.PartnerCountryCode, info.Schedule);
                    info.ScheduleAU = ConvertToAuDate(info.Schedule);

                }
                grdResult.DataSource = list;
                grdResult.DataBind();
                //updateResult.Update();
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "InitializeDialog", "InitializeDialog();", true);
            }
            catch (Exception)
            {
                throw;
            }
        }

        private String GetScheduleByCountry(string countryCode, DateTime dtschedule)
        {
            string schedule = "";
            DateTime dt = DateTime.Now;
            switch (countryCode)
            {
                case "JP":
                    schedule = dtschedule.DayOfWeek.ToString() + "<br/>" + dtschedule.ToString("MMM dd HH:mm") + "(JP)";
                    break;
                case "AU":
                    schedule = ConvertToAuDate(dtschedule);
                    break;
                case "UK":
                    var uk = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    dt = ConvertDateToTimezone(uk, dtschedule);
                    schedule = dt.ToString("MMM dd HH:mm") + "(UK)";
                    break;
            }

            return schedule;
        }

        private string ConvertToAuDate(DateTime dtschedule)
        {
            var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
            DateTime dt = DateTime.Now;
            dt = ConvertDateToTimezone(aest, dtschedule);
            string schedule = dt.ToString("MMM dd HH:mm") + (aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

            var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
            dt = ConvertDateToTimezone(acst, dtschedule);
            schedule += "<br/>" + dt.ToString("HH:mm") + (acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

            var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
            dt = ConvertDateToTimezone(awst, dtschedule);
            schedule += "<br/>" + dt.ToString("HH:mm") + "(AWST)";

            return schedule;
        }

        private DateTime ConvertDateToTimezone(TimeZoneInfo timezone, DateTime time)
        {
            //var BritishZone = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");

            DateTime dt = DateTime.SpecifyKind(time, DateTimeKind.Unspecified);

            DateTime tzdate = TimeZoneInfo.ConvertTime(dt, TimeZoneInfo.Local, timezone);
            return tzdate;
        }

        protected void grdResult_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdResult.EditIndex = -1;
            bind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                bool isBook = hdnBook.Value == "book";
                MatchMakerRepository rep = new MatchMakerRepository();
                int result = 0;
                if(hdnScheduleFinalId.Value.Length == 0)
                {
                    result = rep.CreateNewSchedule(Convert.ToDateTime(hdnFinalSchedule.Value), hdnFinalUserName.Value, hdnFinalPartnerName.Value); 
                }
                else
                {
                    result = rep.UpdateSchedule(Convert.ToInt32(hdnScheduleFinalId.Value), Convert.ToDateTime(hdnFinalSchedule.Value), hdnFinalUserName.Value, hdnFinalPartnerName.Value);
                }
                if(result > 0)
                {
                    ShowMessage("Transaction successfull.", false);
                    if (isBook)
                    {
                        MatchContract match = rep.GetMatchByScheduleId(result);
                        if (match != null)
                        {
                            CreateTicket(match, true);
                            CreateTicket(match, false);
                        }
                    }
                    rep.UpdateTalkTime(hdnFinalUserName.Value, Convert.ToInt32(hdnFinalUserTime.Value), hdnFinalPartnerName.Value, Convert.ToInt32(hdnFinalPartnerTime.Value));
                }
                else
                {
                    ShowMessage("Transaction failed.", true);
                }
                //txtStartDate.Text = Convert.ToDateTime(hdnFinalSchedule.Value).AddDays(-1).ToString("dd/MM/yyyy");
                //txtEndDate.Text = Convert.ToDateTime(hdnFinalSchedule.Value).ToString("dd/MM/yyyy");
                if(txtStartDate.Text.Length > 0 && txtEndDate.Text.Length > 0)
                    bind();
                //txtStartDate.Text = "";
                //txtEndDate.Text = "";

                hdnBook.Value = "";

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        private bool CreateTicket(MatchContract info, bool isMain)
        {
            try
            {
                ZendeskUser user = new ZendeskRepository().GetZendeskEndUser(info.UserLinkKey);
                ZendeskUser partner = new ZendeskRepository().GetZendeskEndUser(info.PartnerLinkKey);

                ZendeskTicket ticket = new ZendeskTicket();
                Comment comment = new Comment();
                comment.Body = (isMain ? info.Name : info.PartnerName) + " registered a Schedule.";
                Requester requester = new Requester();
                requester.Email = isMain ? (user.User != null ? user.User.Email : "") : (partner.User != null ? partner.User.Email : "");
                ticket.Country = (isMain ? info.Country : info.PartnerCountry);

                List<ICustomFields> custom = new List<ICustomFields>();
                if (user != null && user.User != null)
                {
                    CustomFields customFields = new CustomFields();
                    customFields.Id = "360024797616"; //P_User_Email
                    customFields.Value = isMain ? user.User.Email : (partner.User != null ? partner.User.Email : "");
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "360024843836"; //P_User_Name
                    customFields.Value = isMain ? info.UserName : info.PartnerUserName;
                    custom.Add(customFields);

                    if (!String.IsNullOrEmpty(info.PartnerUserName))
                    {
                        if (partner != null)
                        {
                            customFields = new CustomFields();
                            customFields.Id = "360024797636"; // P_Tak_PartnerEmail
                            customFields.Value = isMain ? (partner.User != null ? partner.User.Email : "") : user.User.Email;
                            custom.Add(customFields);

                            customFields = new CustomFields();
                            customFields.Id = "360024768575"; // P_Tak_Partner_Name
                            customFields.Value = isMain ? info.PartnerUserName : info.UserName;
                            custom.Add(customFields);

                            ticket.HasPartner = true;

                        }
                    }
                    string domainName = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

                    customFields = new CustomFields();
                    customFields.Id = "360024769575"; //P_Talk_Confirmation_Url
                    customFields.Value = domainName + (ConfigurationManager.AppSettings["ENV"] == "UAT" ? "/UAT" : "") + String.Format("/Confirmation?t={0}", (isMain ? info.UserConfirmationToken : info.PartnerConfirmationToken));
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "360024720395"; //P_Talk_Date
                    customFields.Value = info.Schedule.ToString("yyyy-MM-dd"); //"2021-12-20";
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "4419906240143"; //P_Talk_FullText_Date
                    customFields.Value = info.Schedule.ToString("dddd, dd MMM yyyy"); //"2021-12-20";
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "360024797656"; //P_Talk_Time
                    customFields.Value = FindTimeZoneByCountry(info, isMain);
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "360024893816"; //P_Talk_Ticket_Type
                    customFields.Value = "Schedule";
                    custom.Add(customFields);

                    //MultiSelectCustomFields mcustomFields = new MultiSelectCustomFields();
                    //mcustomFields.Id = "4416096345615"; //P_Talk_Topics
                    //mcustomFields.Values = getPhraseCategory();
                    //custom.Add(mcustomFields);

                    Ticket tick = new Ticket();
                    tick.Comment = comment;
                    tick.CustomFields = custom;
                    tick.Priority = "urgent";
                    tick.Subject = "Talk Schedule";

                    //tick.SafeUpdate = true;
                    tick.TicketType = "task";
                    //tick.UpdatedStamp = DateTime.Now.ToString("o");
                    tick.DueAt = TimeZoneInfo.ConvertTimeToUtc(info.Schedule, TimeZoneInfo.Local).ToString("o");

                    tick.RequesterDetail = requester;

                    ticket.Ticket = tick;
                    ZendeskRepository rep = new ZendeskRepository();
                    rep.UpdateMultiSelectTicketField("4416096345615", getPhraseCategory());
                    UserContract userContract = new UserRepository().GetByID(isMain ? info.UserId : info.PartnerId);
                    ticket.LearningLanguage = userContract.LearningLanguage;
                    ticket.NativeLanguage = userContract.NativeLanguage;
                    rep.CreateTicket(ticket);


                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return true;
        }

        protected void btnDeleteDialog_Click(object sender, EventArgs e)
        {
            try
            {
                MatchMakerRepository rep = new MatchMakerRepository();
                bool result = rep.DeleteSchedule(Convert.ToInt32(hdnScheduleFinalId.Value));
                if (result)
                {
                    ShowMessage("Transaction successfull.", false);
                }
                else
                {
                    ShowMessage("Transaction failed.", true);
                }
                bind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ShowMessage(bool isError)
        {
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
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

        private string ConvertToAuDate(MatchContract info)
        {

            var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
            DateTime dt = ConvertDateToTimezone(awst, info.Schedule);
            string time = dt.ToString("hh:mm tt") + "(WA)";//"(AWST)";

            var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
            dt = ConvertDateToTimezone(aest, info.Schedule);
            time += " / " +  dt.ToString("hh:mm tt") + "(VIC, ACT, NSW)" ;//"(AEST/AEDT) / ";

            //var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
            //dt = ConvertDateToTimezone(acst, info.Schedule);
            //time += dt.ToString("hh:mm tt") + "(ACST/ACDT) / ";

            //var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
            //dt = ConvertDateToTimezone(qld, info.Schedule);
            //time +=  dt.ToString("hh:mm tt") + "(AEST) / ";


            return time;
        }

        private string FindTimeZoneByCountry(MatchContract info, bool isMain)
        {


            string time = "";
            TimeZoneInfo timeZone = null;// TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
            if (isMain)
            {
                if (info.Country == "AU")
                {

                    time = ConvertToAuDate(info);
                    //var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    //DateTime dt = ConvertDateToTimezone(aest, info.Schedule);
                    //time = dt.ToString("hh:mm tt") + "(AEST/AEDT)<br/>";

                    //var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    //dt = ConvertDateToTimezone(acst, info.Schedule);
                    //time += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.ToString("hh:mm tt") + "(ACST/ACDT)<br/>";

                    //var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    //dt = ConvertDateToTimezone(qld, info.Schedule);
                    //time += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.ToString("hh:mm tt") + "(AEST)";

                    //var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    //dt = ConvertDateToTimezone(awst, info.Schedule);
                    //time += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.ToString("hh:mm tt") + "(AWST)<br/>";
                }
                else if (info.Country == "JP")
                {
                    time = info.Schedule.ToString("hh:mm tt") + "(JP)";
                }
                else if (info.Country == "UK")
                {
                    timeZone = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    DateTime dt = ConvertDateToTimezone(timeZone, info.Schedule);
                    time = dt.ToString("hh:mm tt") + "(UK)";
                }
            }
            else
            {
                if (info.PartnerCountry == "AU")
                {
                    time = ConvertToAuDate(info);
                    //var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    //DateTime dt = ConvertDateToTimezone(aest, info.Schedule);
                    //time = dt.ToString("hh:mm tt") + "(AEST/AEDT)<br/>";

                    //var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    //dt = ConvertDateToTimezone(acst, info.Schedule);
                    //time += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.ToString("hh:mm tt") + "(ACST/ACDT)<br/>";

                    //var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    //dt = ConvertDateToTimezone(qld, info.Schedule);
                    //time += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.ToString("hh:mm tt") + "(AEST)";

                    //var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    //dt = ConvertDateToTimezone(awst, info.Schedule);
                    //time += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.ToString("hh:mm tt") + "(AWST)<br/>";
                }
                else if (info.PartnerCountry == "JP")
                {
                    time = info.Schedule.ToString("hh:mm tt") + "(JP)";
                }
                else if (info.PartnerCountry == "UK")
                {
                    timeZone = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    DateTime dt = ConvertDateToTimezone(timeZone, info.Schedule);
                    time = dt.ToString("hh:mm tt") + "(UK)";
                }
            }

            return time;
        }

        protected void btnSaveComment_Click(object sender, EventArgs e)
        {
            try
            {
                MatchMakerRepository rep = new MatchMakerRepository();
                rep.SaveTalkMatchingComment(Convert.ToInt32(hdnScheduleFinalId.Value), hdnFinalComment.Value, hdnFinalCommentUserColor.Value, hdnFinalCommentPartnerColor.Value);
                hdnFinalCommentUserColor.Value = "";
                hdnFinalCommentPartnerColor.Value = "";
                bind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        private ZendeskCustomTicketFields getPhraseCategory()
        {
            PhraseCategoryRepository rep = new PhraseCategoryRepository();
            List<PhraseCategoryContract> phraseList = rep.GetPhraseCategoryList(SessionManager.Instance.UserProfile.NativeLanguage, SessionManager.Instance.UserProfile.LevelID, SessionManager.Instance.UserProfile.SchoolID);
            ZendeskCustomTicketFields field = new ZendeskCustomTicketFields();
            List<ZendeskCustomTicketFieldsOption> options = new List<ZendeskCustomTicketFieldsOption>();
            foreach (PhraseCategoryContract p in phraseList)
            {
                if (p.PhraseCategoryCode.EndsWith("Q"))
                {
                    if (!options.Any(x => x.Value.Equals(p.PhraseCategoryCode.Replace(" ", "_").ToLower())))
                    {
                        ZendeskCustomTicketFieldsOption option = new ZendeskCustomTicketFieldsOption();
                        option.Name = p.PhraseCategoryCode;
                        option.Value = p.PhraseCategoryCode.Replace(" ", "_").ToLower();
                        options.Add(option);
                    }

                }
            }
            field.Options = options;
            return field;
        }
    }
}