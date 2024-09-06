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
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IPhraseCategoryService" in both code and config file together.
    [ServiceContract]
    public interface IPhraseCategoryService
    {
        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool BulkInsertPhraseCategory(List<PhraseCategoryHeaderContract> tHeader, List<PhraseCategoryContract> tDetail);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetPhraseCategory(string languageCode, int levelid, int? schoolid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<TopCategoryContract> GetTopCategoryList(string languageCode);

    }
}
