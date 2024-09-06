using Language.Discovery.Entity;
using Language.Discovery.Entity.Contract;
using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class ScheduleSettings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtEndDate.Text = DateTime.Now.AddDays(28).ToString("dd/MM/yyyy");
                bind();
            }
        }

        private void bind()
        {
            try
            {
                DateTime? sdate = txtStartDate.Text.Length > 0 ? DateTime.ParseExact(txtStartDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;
                DateTime? edate = txtEndDate.Text.Length > 0 ? DateTime.ParseExact(txtEndDate.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) : (Nullable<DateTime>)null;


                MatchMakerRepository rep = new MatchMakerRepository();
                List<CustomScheduleContract> list = rep.GetCustomSchedule(sdate, edate);

                foreach (CustomScheduleContract info in list)
                {
                    info.Day = info.CustomDate.DayOfWeek.ToString();
                    string[] times = info.TimeSchedule.Split(' ');
                    string au = "";
                    string uk = "";
                    foreach(string time in times){
                        if (time.Length == 0)
                            continue;
                        au = au  + GetScheduleByCountry("AU", Convert.ToDateTime(info.CustomDate.ToString("MM/dd/yyyy") + " " + time)) + "<br/>";
                        uk = uk + GetScheduleByCountry("UK", Convert.ToDateTime(info.CustomDate.ToString("MM/dd/yyyy") + " " + time)) + "<br/>";
                    }
                    info.ScheduleAU = au;
                    info.ScheduleUK = uk;
                }
                grdResult.DataSource = list;
                grdResult.DataBind();
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        //protected void grdResult_DataBound(object sender, EventArgs e)
        //{
        //    for (int i = grdResult.Rows.Count - 1; i > 0; i--)
        //    {
        //        GridViewRow row = grdResult.Rows[i];
        //        GridViewRow previousRow = grdResult.Rows[i - 1];
        //        Label lblDate = (Label)row.FindControl("lblDate");
        //        Label previewsLblDate = (Label)previousRow.FindControl("lblDate");
        //        if (lblDate.Text == previewsLblDate.Text)
        //        {
        //            if (previousRow.Cells[0].RowSpan == 0)
        //            {
        //                if (row.Cells[0].RowSpan == 0)
        //                {
        //                    previousRow.Cells[0].RowSpan += 2;
        //                }
        //                else
        //                {
        //                    previousRow.Cells[0].RowSpan = row.Cells[0].RowSpan + 1;
        //                }
        //                row.Cells[0].Visible = false;
        //            }
        //        }

        //    }
        //}

        protected void btnShow_Click(object sender, EventArgs e)
        {
            bind();
        }

        protected void btnSaveDialog_Click(object sender, EventArgs e)
        {
            try
            {
                MatchMakerRepository rep = new MatchMakerRepository();
                bool result = false;
                result = rep.InsertUpdateSchedule(Convert.ToDateTime(hdnDate.Value), hdnTimeIdsDialog.Value);
                
                if (result)
                {
                    ShowMessage("Transaction successfull.", false);
                }
                else
                {
                    ShowMessage("Transaction failed.", true);
                }
                //txtStartDate.Text = Convert.ToDateTime(hdnFinalSchedule.Value).AddDays(-1).ToString("dd/MM/yyyy");
                //txtEndDate.Text = Convert.ToDateTime(hdnFinalSchedule.Value).ToString("dd/MM/yyyy");
                if (txtStartDate.Text.Length > 0 && txtEndDate.Text.Length > 0)
                    bind();
                //txtStartDate.Text = "";
                //txtEndDate.Text = "";

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        protected void btnDeleteDialog_Click(object sender, EventArgs e)
        {
            try
            {
                MatchMakerRepository rep = new MatchMakerRepository();
                bool result = rep.DeleteCustomSchedule(Convert.ToDateTime(hdnDate.Value));
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
            schedule += "/" + dt.ToString("HH:mm") + (acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

            var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
            dt = ConvertDateToTimezone(awst, dtschedule);
            schedule += "/" + dt.ToString("HH:mm") + "(AWST)";

            return schedule;
        }

        private DateTime ConvertDateToTimezone(TimeZoneInfo timezone, DateTime time)
        {
            //var BritishZone = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");

            DateTime dt = DateTime.SpecifyKind(time, DateTimeKind.Unspecified);

            DateTime tzdate = TimeZoneInfo.ConvertTime(dt, TimeZoneInfo.Local, timezone);
            return tzdate;
        }
    }
}