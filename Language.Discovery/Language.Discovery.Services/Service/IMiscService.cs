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
    public interface IMiscService
    {

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetCountryList();

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetCityList();

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetClassList();

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetUserTypeList();

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetCityListByCountry( int countryid );

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetCityListByCountryAndLanguage(int countryid, string languagecode);

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetInterestList(string langaugeCode);

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetLanguageList();

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetSchoolList(string language);

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetLevelList(string language);

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetAboutMeList(string languageCode);

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetCityOtherName(int cityid, string languagecode);

       [OperationContract]
       [WebGet(ResponseFormat = WebMessageFormat.Json)]
       string GetCityListByLanguage(string languagecode);

    }
}
