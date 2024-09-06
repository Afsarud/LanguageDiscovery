using Language.Discovery.Entity;
using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Web.Script.Serialization;

namespace Language.Discovery.Services.Service
{
    public class MiscService : IMiscService
    {
        public  string GetCountryList()
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<CountryContract> list= rep.GetCountryList();
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetCityList()
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<CityContract> list = rep.GetCityList();
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetClassList()
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<ClassContract> list = rep.GetClassList();
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetUserTypeList()
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<UserTypeContract> list = rep.GetUserTypeList();
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetCityListByCountry(int countryid)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<CityContract> list = rep.GetCityListByCountry(countryid);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetCityListByCountryAndLanguage(int countryid, string languagecode)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<CityContract> list = rep.GetCityListByCountry(countryid, languagecode);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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


        public string GetCityListByLanguage(string languagecode)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<CityContract> list = rep.GetCityListByLanguage(languagecode);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetCityOtherName(int cityid, string languagecode)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                
                List<CityContract> list = rep.GetCityOtherName(cityid, languagecode);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
                
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

        public string GetInterestList(string languageCode)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<InterestContract> list = rep.GetInterestList(languageCode);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetAboutMeList(string languageCode)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<AboutMeContract> list = rep.GetAboutMeList(languageCode);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetLanguageList()
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<LanguageContract> list = rep.GetLanguageList();
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetSchoolList(string language)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<SchoolContract> list = rep.GetSchoolList(language);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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

        public string GetLevelList(string languagecode)
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<LevelContract> list = rep.GetLevelList(languagecode);
                string json = new JavaScriptSerializer().Serialize(list);
                return json;
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
