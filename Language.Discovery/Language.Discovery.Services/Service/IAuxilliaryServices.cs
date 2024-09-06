using Language.Discovery.Entity;
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
    public interface IAuxilliaryServices
    {
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchPhraseCategory(string languagecode, string category, int levelid, long schoolid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        long AddPhraseCategory(PhraseCategoryHeaderContract pch);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdatePhraseCategory(PhraseCategoryHeaderContract pch);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeletePhraseCategory(long phcid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetPhraseCategoryListToOrder(string languageCode, int levelid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdatePhraseCategoryOrder(string xml);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        long AddInfo(InfoContract ic);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateInfo(InfoContract ic);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteInfo(long id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        InfoContract GetInfoByID(long id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<InfoContract> SearchInfo(SearchInfoDTO dto,  out int virtualcount);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        InfoContract GetInfoByType(string type);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        long AddFilter(FilterContract fc);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateFilter(FilterContract fc);
        
        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteFilter(long id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchFilter(string filtername);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        FilterContract GetFilterByID(long id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetClassList(int schoolid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        ClassContract GetClassByID(long id);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteClass(int classid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateClass(ClassContract cc);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        int AddClass(ClassContract cc);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchClass(string classname, int schoolID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<GradeContract> GetGradeList();
    }
}
