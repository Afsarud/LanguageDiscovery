using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Web.Script.Serialization;
using Language.Discovery.Entity;
using Language.Discovery.Repository;

namespace Language.Discovery.Services.Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "PhraseCategoryService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select PhraseCategoryService.svc or PhraseCategoryService.svc.cs at the Solution Explorer and start debugging.
    public class PhraseCategoryService : IPhraseCategoryService
    {
        public bool BulkInsertPhraseCategory(List<PhraseCategoryHeaderContract> tHeader, List<PhraseCategoryContract> tDetail)
        {
            try
            {
                PhraseCategoryRepository rep = new PhraseCategoryRepository();

                return rep.BulkInsertPhraseCategory(tHeader, tDetail);
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

        public string GetPhraseCategory(string languageCode, int levelid, int? schoolid)
        {
            try
            {
                List<PhraseCategoryContract> plist = new List<PhraseCategoryContract>();

                PhraseCategoryRepository rep = new PhraseCategoryRepository();
                plist = rep.GetPhraseCategoryList(languageCode, levelid, schoolid);

                string json = new JavaScriptSerializer().Serialize(plist);

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

        public List<TopCategoryContract> GetTopCategoryList(string languageCode)
        {
            try
            {
                List<TopCategoryContract> plist = new List<TopCategoryContract>();

                PhraseCategoryRepository rep = new PhraseCategoryRepository();
                plist = rep.GetTopCategoryList(languageCode);

                return plist;

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
