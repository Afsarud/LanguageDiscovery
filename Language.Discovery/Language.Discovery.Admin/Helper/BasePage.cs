using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;

namespace Language.Discovery.Admin
{
    public class BasePage : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            if (SessionManager.Instance.UserProfile == null)
            {
                Response.Redirect("~/Timeout");
                return;
            }
            UICulture = SessionManager.Instance.UserProfile.NativeLanguage;
            base.InitializeCulture();
        }

        protected void LocalizeReport(LocalReport report)
        {
            string respath = "";
            // Load RDLC file. 
            XmlDocument doc = new XmlDocument();
            try
            {
                //doc.Load(Server.MapPath(ResolveUrl(report.ReportPath)));
                doc.Load(report.ReportPath);
            }
            catch (XmlException)
            {
                // TIP: If your web site was published with the updatable option switched off
                // you must copy your reports to the target location manually
                return;
            }
            // Create an XmlNamespaceManager to resolve the default namespace.
            XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
            nsmgr.AddNamespace("nm", "http://schemas.microsoft.com/" +
                               "sqlserver/reporting/2008/01/reportdefinition");
            nsmgr.AddNamespace("rd", "http://schemas.microsoft.com/" +
                               "SQLServer/reporting/reportdesigner");
            respath = ResolveUrl(".") +  Path.GetFileName(report.ReportPath);
            //path to the local resource object
            string resourcePath = Path.Combine(ResolveUrl("./App_LocalResources/"),
                                 Path.GetFileName(report.ReportPath) + "." + SessionManager.Instance.UserProfile.NativeLanguage + ".resx");
            
            //Go through the nodes of XML document and localize
            //the text of nodes Value, ToolTip, Label. 
            foreach (string nodeName in new String[] { "Value", 
             "ToolTip", "Label" })
            {
                foreach (XmlNode node in doc.DocumentElement.SelectNodes(
                         String.Format("//nm:{0}[@rd:LocID]", nodeName), nsmgr))
                {
                    String nodeValue = node.InnerText;
                    if (String.IsNullOrEmpty(nodeValue) || !nodeValue.StartsWith("="))
                    {
                        try
                        {
                            String localizedValue = (string)HttpContext.GetLocalResourceObject(respath, node.Attributes["rd:LocID"].Value);
                            if (!String.IsNullOrEmpty(localizedValue))
                            {
                                node.InnerText = localizedValue;
                            }
                        }
                        catch (InvalidCastException)
                        {
                            // if the specified resource is not a String
                        }
                    }
                }
            }
            report.ReportPath = String.Empty;
            //Load the updated RDLC document into LocalReport object.
            using (StringReader rdlcOutputStream = new StringReader(doc.DocumentElement.OuterXml))
            {
                report.LoadReportDefinition(rdlcOutputStream);
                // TIP: If the loaded report definition contains any
                // subreports, you must call LoadSubreportDefinition
            }
        }

        protected string GetTranslation(string id)
        {
            object res = GetGlobalResourceObject("Master" + SessionManager.Instance.UserProfile.NativeLanguage.Replace("-", ""), id);
            return res != null ? res.ToString() : string.Empty;
        }


    }
}