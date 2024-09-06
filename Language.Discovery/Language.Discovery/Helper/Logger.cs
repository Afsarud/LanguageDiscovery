using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Language.Discovery
{
    public class Logger
    {

        private static string sLogFormat;
        private static string sErrorTime;

        public Logger()
        {
            //sLogFormat used to create log files format :
            // dd/mm/yyyy hh:mm:ss AM/PM ==> Log Message
          
        }

        public static void ErrorLog(string sErrMsg)
        {
            sLogFormat = DateTime.Now.ToShortDateString().ToString() + " " + DateTime.Now.ToLongTimeString().ToString() + " ==> ";

            //this variable used to create log filename format "
            //for example filename : ErrorLogYYYYMMDD
            string sYear = DateTime.Now.Year.ToString();
            string sMonth = DateTime.Now.Month.ToString();
            string sDay = DateTime.Now.Day.ToString();
            sErrorTime = sYear + sMonth + sDay + ".txt";

            string sPathName = System.Configuration.ConfigurationManager.AppSettings["LogDirectory"];
            if( !Directory.Exists(sPathName))
            {
                Directory.CreateDirectory(sPathName);
            }
            StreamWriter sw = new StreamWriter(Path.Combine(sPathName , sErrorTime), true);
            sw.WriteLine(sLogFormat + sErrMsg);
            sw.Flush();
            sw.Close();
        }
    }
}