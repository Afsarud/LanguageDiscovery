using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Repository;
using Language.Discovery.Entity;

namespace Language.Discovery.Student
{
    public partial class Monitor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                hdnDisplayName.Value = SessionManager.Instance.UserProfile.UserName.Replace("@", "_");
                List<ConferenceRoomContract> list = new UserRepository().GetConferenceRoomList(0);
                grdRooms.DataSource = list;
                grdRooms.DataBind();
            }
        }
    }
}