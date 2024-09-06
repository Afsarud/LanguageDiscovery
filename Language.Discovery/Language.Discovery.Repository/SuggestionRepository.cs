using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Language.Discovery.Repository
{
    public class SuggestionRepository : IRepository<SuggestionContract>
    {
        public DataSet Search(string keyword, DateTime? startdate, DateTime? enddate)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Keyword", keyword));
                paramlist.Add(new Parameter("StartDate", startdate.HasValue ? startdate.Value : (Nullable<DateTime>) null));
                paramlist.Add(new Parameter("EndDate", enddate.HasValue ? enddate.Value : (Nullable<DateTime>)null));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchSuggestion", paramlist);

                return ds;

            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public object Add(SuggestionContract tObject)
        {
            try
            {
                long id = 0;

                
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PaletteID", tObject.PaletteID));
                    paramlist.Add(new Parameter("StartDate", tObject.StartDate));
                    paramlist.Add(new Parameter("EndDate", tObject.EndDate));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertSuggestion", paramlist);
                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        id = Convert.ToInt64(pa[0].Value);
                        scope.Complete();
                    }
                }

                return id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(SuggestionContract tObject)
        {
            try
            {

                bool updated = false;
                using (TransactionScope scope = new TransactionScope())
                {

                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PaletteSuggestionID", tObject.PaletteSuggestionID));
                    paramlist.Add(new Parameter("PaletteID", tObject.PaletteID));
                    paramlist.Add(new Parameter("StartDate", tObject.StartDate));
                    paramlist.Add(new Parameter("EndDate", tObject.EndDate));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateSuggestion", paramlist);
                    if (affected > 0)
                        scope.Complete();
                    updated = affected > 0;
                }
                return updated;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(SuggestionContract tObject)
        {
            try
            {
                int affected = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PaletteSuggestionID", tObject.PaletteSuggestionID));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteSuggestion", paramlist);
                    if (affected > 0)
                        scope.Complete();
                }
                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SuggestionContract GetByID(long id)
        {
            throw new NotImplementedException();
        }
    }
}
