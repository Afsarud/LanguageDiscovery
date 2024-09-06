using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using Language.Discovery.Entity;
using Language.Discovery.Services;
using Language.Discovery.Repository;
using System.Configuration;
using System.Web.Script.Serialization;

namespace Language.Discovery.Services.Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "PhraseService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select PhraseService.svc or PhraseService.svc.cs at the Solution Explorer and start debugging.
    public class PhraseService : IPhraseService
    {
        public string Search(SearchDTO dto)
        {
            try
            {
                List<PaletteContract> phraselist = new List<PaletteContract>();

                PaletteRepository rep = new PaletteRepository();
                phraselist = rep.Search(dto);

                string json = new JavaScriptSerializer().Serialize(phraselist);

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
