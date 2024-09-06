using Microsoft.AspNet.SignalR;
using Owin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace Language.Discovery
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            var hc = new HubConfiguration();
            hc.EnableDetailedErrors = Convert.ToBoolean(ConfigurationManager.AppSettings["DebugSignalR"]);
            app.MapSignalR(hc);
        }
    }
}