using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
using Language.Discovery.Entity;
namespace Language.Discovery.Helper
{
    public class ULHelper
    {
        public static HtmlGenericControl GenerateSentece(List<PhraseContract> phrases)
        {
            try
            {
                HtmlGenericControl ul = new HtmlGenericControl("ul");
                HtmlGenericControl li = new HtmlGenericControl("li");
                ul.Attributes.Add("id", "items");

                
                return new HtmlGenericControl();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}