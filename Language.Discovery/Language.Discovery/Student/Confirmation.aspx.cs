using Language.Discovery.Entity;
using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Student
{
    public partial class Confirmation : System.Web.UI.Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            if(SessionManager.Instance.UserProfile == null)
            {
                Response.Redirect("~/Logout" + (Request.QueryString.Count > 0 ? "?" + Request.QueryString.ToString() : ""));
            }
            base.OnPreInit(e);
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string g = Request.QueryString["t"];
            string answer = Request.QueryString["a"];
            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(g))
            {
                Guid guid = Guid.Parse(g);
                bool ans = answer == "1" ? true : false;

                MatchMakerRepository rep = new MatchMakerRepository();
                int scheduleid = rep.Confirm(guid, ans, SessionManager.Instance.UserProfile.UserID);

                if(scheduleid == 0)
                {
                    lblMessage.Visible = false;
                    lblErrorMessage.Visible = true;
                    return;
                }
                MatchContract match = rep.GetMatchByScheduleId(scheduleid);

                ZendeskRepository zrep = new ZendeskRepository();
                ZendeskTicket ticket = new ZendeskTicket();
                Ticket tkt = new Ticket();
                tkt.SafeUpdate = true;
                tkt.TicketType = "task";
                tkt.UpdatedStamp = DateTime.Now.ToString("o");
                tkt.DueAt = TimeZoneInfo.ConvertTimeToUtc(match.Schedule, TimeZoneInfo.Local).ToString("o");
                //tkt.DueAt = match.Schedule.ToString("o");
                ticket.Ticket = tkt;

                if(zrep.UpdateTicket(id, ticket))
                {
                    zrep.UpdateTicketTags(id, "Session_confirmed");
                }
            }
        }
    }
}