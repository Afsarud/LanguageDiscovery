using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Robot
{
    public class Logger
    {

        private string sLogFormat;
        private string sErrorTime;
        private string sPathName;

        public Logger(string pPathName)
        {
            //sLogFormat used to create log files format :
            // dd/mm/yyyy hh:mm:ss AM/PM ==> Log Message
            sLogFormat = DateTime.Now.ToShortDateString().ToString() + " " + DateTime.Now.ToLongTimeString().ToString() + " ==> ";
            sPathName = pPathName;
            //this variable used to create log filename format "
            //for example filename : ErrorLogYYYYMMDD
            string sYear = DateTime.Now.Year.ToString();
            string sMonth = DateTime.Now.Month.ToString();
            string sDay = DateTime.Now.Day.ToString();
            sErrorTime = sYear + sMonth + sDay + ".txt";

            if (!Directory.Exists(pPathName))
                Directory.CreateDirectory(pPathName);
        }

        public void ErrorLog(string sErrMsg)
        {
            StreamWriter sw = new StreamWriter(sPathName + sErrorTime, true);
            sw.WriteLine("[ERROR]" + sLogFormat + sErrMsg);
            sw.Flush();
            sw.Close();
        }
        public void DebugLog(string msg)
        {
            StreamWriter sw = new StreamWriter(Path.Combine(sPathName,sErrorTime), true);
            sw.WriteLine("[Debug]" + sLogFormat + msg);
            sw.Flush();
            sw.Close();
        }
    }
}
