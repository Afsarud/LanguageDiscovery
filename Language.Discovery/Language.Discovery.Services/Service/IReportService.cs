using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace Language.Discovery.Services.Service
{
    [ServiceContract]
    public interface IReportService
    {
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetMailExhangeLogReport(int schoolID, string sender, string recipient, DateTime? startDate, DateTime? endDate);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetUserLoginReport(int schoolID, string username, string sort, string order);


        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetUserListReport(int schoolID, string username, string sort, string order);
        
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetMailExhangeStatistics(int schoolID, string sender, string recipient, DateTime? startDate, DateTime? endDate);
    }
}
