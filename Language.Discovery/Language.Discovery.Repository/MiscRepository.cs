using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Repository
{
    public class MiscRepository
    {
        public List<CountryContract> GetCountryList()
        {
            try
            {
                List<CountryContract> countrylist = null;
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCountryList", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    countrylist = (List<CountryContract>)CollectionHelper.ConvertTo<CountryContract>(ds.Tables[0]);
                }

                return countrylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<GradeContract> GetGradeList()
        {
            try
            {
                List<GradeContract> gradelist = null;
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetGradeList", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    gradelist = (List<GradeContract>)CollectionHelper.ConvertTo<GradeContract>(ds.Tables[0]);
                }

                return gradelist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CityContract> GetCityList()
        {
            try
            {
                List<CityContract> citylist = null;
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCityList", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    citylist = (List<CityContract>)CollectionHelper.ConvertTo<CityContract>(ds.Tables[0]);
                }

                return citylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserTypeContract> GetUserTypeList()
        {
            try
            {
                List<UserTypeContract> usertypelist = null;
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserTypeList", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    usertypelist = (List<UserTypeContract>)CollectionHelper.ConvertTo<UserTypeContract>(ds.Tables[0]);
                }

                return usertypelist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ClassContract> GetClassList()
        {
            try
            {
                List<ClassContract> citylist = null;
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetClassList", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    citylist = (List<ClassContract>)CollectionHelper.ConvertTo<ClassContract>(ds.Tables[0]);
                }

                return citylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CityContract> GetCityListByCountry( int countryid)
        {
            try
            {
                List<CityContract> citylist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("CountryID", countryid));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCityListByCountryID", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    citylist = (List<CityContract>)CollectionHelper.ConvertTo<CityContract>(ds.Tables[0]);
                }

                return citylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CityContract> GetCityListByCountry(int countryid, string languagecode)
        {
            try
            {
                List<CityContract> citylist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("CountryID", countryid));
                paramlist.Add(new Parameter("LanguageCode", languagecode));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCityListByCountryIDAndLanguage", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    citylist = (List<CityContract>)CollectionHelper.ConvertTo<CityContract>(ds.Tables[0]);
                }

                return citylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CityContract> GetCityListByUserID(long userId)
        {
            try
            {
                List<CityContract> citylist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userId));

                DataSet ds = DatabaseHelper.ExecuteQuery("[usp_GetCityListByUserID]", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    citylist = (List<CityContract>)CollectionHelper.ConvertTo<CityContract>(ds.Tables[0]);
                }

                return citylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<CityContract> GetCityListByLanguage(string languagecode)
        {
            try
            {
                List<CityContract> citylist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", languagecode));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCityListByLanguage", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    citylist = (List<CityContract>)CollectionHelper.ConvertTo<CityContract>(ds.Tables[0]);
                }

                return citylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CityContract> GetCityOtherName(int cityid, string languagecode)
        {
            try
            {
                List<CityContract> citylist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("CityID", cityid));
                paramlist.Add(new Parameter("LanguageCode", languagecode));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCityOtherName", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    citylist = (List<CityContract>)CollectionHelper.ConvertTo<CityContract>(ds.Tables[0]);
                }

                return citylist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<InterestContract> GetInterestList(string langaugeCode)
        {
            try
            {
                List<InterestContract> interestlist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", langaugeCode));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetInterestList", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    interestlist = (List<InterestContract>)CollectionHelper.ConvertTo<InterestContract>(ds.Tables[0]);
                }

                return interestlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<AboutMeContract> GetAboutMeList(string langaugeCode)
        {
            try
            {
                List<AboutMeContract> aboutmelist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", langaugeCode));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetAboutMeList", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    aboutmelist = (List<AboutMeContract>)CollectionHelper.ConvertTo<AboutMeContract>(ds.Tables[0]);
                }

                return aboutmelist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<LanguageContract> GetLanguageList()
        {
            try
            {
                List<LanguageContract> list = null;

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetLanguageList", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    list = (List<LanguageContract>)CollectionHelper.ConvertTo<LanguageContract>(ds.Tables[0]);
                }

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SchoolContract> GetSchoolList( string languagecode, bool isSchool = false )
        {
            try
            {
                List<SchoolContract> list = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", languagecode));
                paramlist.Add(new Parameter("IsSchool", isSchool));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetSchoolList", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    list = (List<SchoolContract>)CollectionHelper.ConvertTo<SchoolContract>(ds.Tables[0]);
                }

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<LevelContract> GetLevelList(string languagecode)
        {
            try
            {
                List<LevelContract> list = null;
                //List<Parameter> paramlist = new List<Parameter>();
                //paramlist.Add(new Parameter("LanguageCode", languagecode));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetLevelList", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    list = (List<LevelContract>)CollectionHelper.ConvertTo<LevelContract>(ds.Tables[0]);
                }

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
