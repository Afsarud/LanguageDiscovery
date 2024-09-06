using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using Language.Discovery.Entity;
using System.Data;

namespace Language.Discovery.Services
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IPaletteService" in both code and config file together.
    [ServiceContract]
    public interface IPaletteService
    {
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<PaletteContract> Search(SearchDTO dto, out int virtualcount);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchWord(SearchDTO dto, out int virtualcount);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetPhraseCategory(string languageCode, int levelid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchWordAdmin(SearchDTO dto);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        long AddWords(WordHeaderContract whc);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateWord(WordHeaderContract whc);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteWord(long wordheaderid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetWordDetails(long wordheaderid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetPhraseCategoryDetails(long id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetPaletteDetails(long id);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        long AddPalette(PaletteContract pc);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdatePalette(PaletteContract pc);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetPaletteSuggestion();

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeletePalette(long paletteID);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool ApprovePalette(long paletteID, long userid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool BulkAddWords(List<WordHeaderContract> header, List<WordContract> detail, bool deleteFirstThenAdd, long phraseCategoryID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchSuggestion(string keyword, DateTime? startdate, DateTime? enddate);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        long AddSuggestion(SuggestionContract sc);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateSuggestion(SuggestionContract sc);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteSuggestion(long paletteSuggestionID);
        
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        SuggestionContract GetSuggestionDetail(long paletteSuggestionID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool HasFoulWords(string message);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool AddBulkPalette(List<PaletteContract> paletteContracts, bool deleteFirstThenAdd, long phraseCategoryID );
    }
}
