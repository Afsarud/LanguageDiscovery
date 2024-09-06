using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using Language.Discovery.Entity;

namespace Language.Discovery.Services.Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "ISchoolService" in both code and config file together.
    [ServiceContract]
    public interface ISchoolService
    {
  
        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        int AddSchool(SchoolContract tObject);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateSchool(SchoolContract tObject);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteSchool(int id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        SchoolContract GetByID(long id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchSchool(SearchSchoolDTO tObject, out int virtualcount);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserMessageContract> GetUnreadMessageForReview(long schoolid, long userid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserMessageContract> GetAllMessages(MessageSearchDTO dto, out int virtualcount);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool SetMessageAsReviewed(long usermailid, long userid,string feedbackmessage, bool isFeedBack = false);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool SetMessageStatus(string xml, long userid, string feedbackmessage, bool statusid, bool isFeedback = false);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool SetMessageAsRejected(long usermailid, long userid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<SchoolTypeContract> GetSchoolTypeList();

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserMessageContract> GetUnreadMessageForPolling(long schoolid, long userid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<FreeMessageContract> GetAllFreeMessages(MessageSearchDTO dto, out int virtualcount);

    }
}