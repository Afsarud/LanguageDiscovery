using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace Language.Discovery.Services.Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "ReportService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select ReportService.svc or ReportService.svc.cs at the Solution Explorer and start debugging.
    public class ReportService : IReportService
    {
        public string GetMailExhangeLogReport(int schoolID, string sender, string recipient, DateTime? startDate, DateTime? endDate)
        {
            try
            {
                ReportRepository rep = new ReportRepository();
                DataSet ds = rep.GetMailExhangeLogReport(schoolID, sender, recipient, startDate, endDate);

                return ds.GetXml();
                
            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GetMailExhangeStatistics(int schoolID, string sender, string recipient, DateTime? startDate, DateTime? endDate)
        {
            try
            {
                ReportRepository rep = new ReportRepository();
                DataSet ds = rep.GetMailExhangeStatistics(schoolID, sender, recipient, startDate, endDate);

                return ds.GetXml();

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public string GetUserLoginReport(int schoolID, string username, string sort, string order)
        {
            try
            {
                ReportRepository rep = new ReportRepository();
                DataSet ds = rep.GetUserLoginReport(schoolID, username, sort,  order);

                return ds.GetXml();

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public string GetUserListReport(int schoolID, string username, string sort, string order)
        {
            try
            {
                ReportRepository rep = new ReportRepository();
                DataSet ds = rep.GetUserListReport(schoolID, username, sort, order);

                return ds.GetXml();

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
