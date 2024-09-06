using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Repository
{
    public class ReportRepository
    {
        public DataSet GetMailExhangeLogReport(int schoolID, string sender, string recipient, DateTime? startDate, DateTime? endDate)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));
                paramlist.Add(new Parameter("Sender", sender));
                paramlist.Add(new Parameter("Recipient", recipient));
                paramlist.Add(new Parameter("StartDate", startDate));
                paramlist.Add(new Parameter("EndDate", endDate));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMailExchangeLog", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public DataSet GetMailExhangeStatistics(int schoolID, string sender, string recipient, DateTime? startDate, DateTime? endDate)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));
                paramlist.Add(new Parameter("Sender", sender));
                paramlist.Add(new Parameter("Recipient", recipient));
                paramlist.Add(new Parameter("StartDate", startDate));
                paramlist.Add(new Parameter("EndDate", endDate));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMailExchangeStatistics", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetUserLoginReport(int schoolID, string username, string sort, string order)
        {//deprecated
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));
                paramlist.Add(new Parameter("UserName", username));
                paramlist.Add(new Parameter("Sort", sort));
                paramlist.Add(new Parameter("Order", order));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserLoginReports", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetUserLoginReportByDate(int schoolID, string username, string sort, string order, DateTime? startdate, DateTime? enddate)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));
                paramlist.Add(new Parameter("UserName", username));
                paramlist.Add(new Parameter("Sort", sort));
                paramlist.Add(new Parameter("Order", order));
                if (startdate.HasValue)
                    paramlist.Add(new Parameter("StartDate", startdate));
                if (enddate.HasValue)
                    paramlist.Add(new Parameter("EndDate", enddate));


                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserLoginReports", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetUserLoginDetailsReport(int schoolID, string username, string sort, string order, DateTime? startdate, DateTime? enddate)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));
                paramlist.Add(new Parameter("UserName", username));
                paramlist.Add(new Parameter("Sort", sort));
                paramlist.Add(new Parameter("Order", order));
                if( startdate.HasValue )
                    paramlist.Add(new Parameter("StartDate", startdate));
                if(enddate.HasValue)
                    paramlist.Add(new Parameter("EndDate", enddate));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserLoginDetailsReports", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public DataSet GetUserListReport(int schoolID, string username, string sort, string order)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));
                paramlist.Add(new Parameter("UserName", username));
                paramlist.Add(new Parameter("Sort", sort));
                paramlist.Add(new Parameter("Order", order));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserListReports", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetTalkScheduleReport(int schoolID, int partnerSchoolID, string sort, string order, DateTime? startdate, DateTime? enddate)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));
                paramlist.Add(new Parameter("PartnerSchoolID", partnerSchoolID));
                paramlist.Add(new Parameter("Sort", sort));
                paramlist.Add(new Parameter("Order", order));
                if (startdate.HasValue)
                    paramlist.Add(new Parameter("From", startdate));
                if (enddate.HasValue)
                    paramlist.Add(new Parameter("To", enddate));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetScheduleForReport", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
