using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Language.Discovery.Entity;
using Language.Discovery.Admin.PhraseCategoryService;
using Language.Discovery.Admin.SchoolService;

namespace Language.Discovery.Admin
{
    public partial class SchoolMaintenance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SchoolServiceClient client = new SchoolServiceClient();
            SchoolContract sc = new SchoolContract();
            client.AddSchool(sc);

            PhraseCategoryServiceClient cl = new PhraseCategoryServiceClient();
            List<PhraseCategoryHeaderContract> h = new List<PhraseCategoryHeaderContract>();
            List<PhraseCategoryContract> d = new List<PhraseCategoryContract>();
            cl.BulkInsertPhraseCategory(h.ToArray(), d.ToArray());

        }
    }
}