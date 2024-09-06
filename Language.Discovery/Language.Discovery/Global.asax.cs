using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using Language.Discovery;
using System.Security.Principal;
using System.Web.Http;
using System.Web.SessionState;

namespace Language.Discovery
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            //RouteTable.Routes.MapHttpRoute(
            //    name: "DefaultApi",
            //    routeTemplate: "api/{controller}/{id}",
            //    defaults: new { id = System.Web.Http.RouteParameter.Optional }
            //);
            // Code that runs on application startup
            GlobalConfiguration.Configure(WebApiConfig.Register);
            GlobalConfiguration.Configuration.EnsureInitialized();

            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterOpenAuth();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            string cookieName = FormsAuthentication.FormsCookieName;
            HttpCookie authCookie = Context.Request.Cookies[cookieName];

            if (authCookie == null)
            {
                return;
            }
            FormsAuthenticationTicket authTicket = null;
            try
            {
                authTicket = FormsAuthentication.Decrypt(authCookie.Value);
            }
            catch
            {
                return;
            }
            if (authTicket == null)
            {
                return;
            }
            string[] roles = authTicket.UserData.Split(new char[] { ';' });
            FormsIdentity id = new FormsIdentity(authTicket);
            //GenericPrincipal principal = new GenericPrincipal(id, roles);
            string username = authTicket.Name;
            GenericPrincipal principal = new GenericPrincipal(new System.Security.Principal.GenericIdentity(username, "Forms"), roles);

            Context.User = principal;
        }

        protected void FormsAuthentication_OnAuthenticate(Object sender, FormsAuthenticationEventArgs e)
        {
            if (FormsAuthentication.CookiesSupported == true)
            {
                if (Request.Cookies[FormsAuthentication.FormsCookieName] != null)
                {
                    try
                    {
                        FormsAuthenticationTicket authTicket = FormsAuthentication.Decrypt(Request.Cookies[FormsAuthentication.FormsCookieName].Value);

                        string username = authTicket.Name;

                        string[] roles = authTicket.UserData.Split(new char[] { ';' });

                        e.User = new System.Security.Principal.GenericPrincipal(
                          new System.Security.Principal.GenericIdentity(username, "Forms"), roles);
                    }
                    catch (Exception)
                    {
                        //Walang gagawin, pabayaan lang.
                    }
                }
            }
        }

        private const string _WebApiPrefix = "api";

        private static string _WebApiExecutionPath = String.Format("~/{0}", _WebApiPrefix);

        protected void Application_PostAuthorizeRequest()
        {

            if (IsWebApiRequest())
            {

                HttpContext.Current.SetSessionStateBehavior(SessionStateBehavior.Required);

            }

        }

        private static bool IsWebApiRequest()
        {

            return HttpContext.Current.Request.AppRelativeCurrentExecutionFilePath.StartsWith(_WebApiExecutionPath);

        }
    }
}
