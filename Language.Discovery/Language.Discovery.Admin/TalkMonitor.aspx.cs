using System;
using System.Collections.Generic;
using Language.Discovery.Admin;
using Language.Discovery.Repository;
using Language.Discovery.Entity;

namespace Language.Discovery.Student
{
    public partial class TalkMonitor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                hdnDisplayName.Value = SessionManager.Instance.UserProfile.UserName.Replace("@", "_");
                List<ConferenceRoomContract> list = new UserRepository().GetConferenceRoomList(SessionManager.Instance.UserProfile.SchoolID);
                grdRooms.DataSource = list;
                grdRooms.DataBind();
            }
        }
    }
}