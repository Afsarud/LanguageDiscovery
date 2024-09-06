using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using Language.Discovery.Entity;
using System.ServiceModel.Web;

namespace Language.Discovery.Services.Service
{
    [ServiceContract]
    public interface IPhraseService
    {
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string Search(SearchDTO dto);
    }
}
