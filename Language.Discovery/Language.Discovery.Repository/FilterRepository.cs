using Language.Discovery.Entity;
using Language.Discovery.Entity.Contract;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace Language.Discovery.Repository
{
    public class FilterRepository : IRepository<FilterContract>
    {
    
          public List<FilterContract> Search(string filtername)
        {
            try
            {
                List<FilterContract> list = new List<FilterContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("FilterName", filtername));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchFilter", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<FilterContract>)CollectionHelper.ConvertTo<FilterContract>(ds.Tables[0]);
                }
                return list;

            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public object Add(FilterContract tObject)
        {
            try
            {
                long id = 0;

                
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("FilterName", tObject.FilterName));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertFilter", paramlist);
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

        public bool Update(FilterContract tObject)
        {
            try
            {

                bool updated = false;
                using (TransactionScope scope = new TransactionScope())
                {

                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("FilterID", tObject.FilterID));
                    paramlist.Add(new Parameter("FilterName", tObject.FilterName));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateFilter", paramlist);
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

        public bool Delete(FilterContract tObject)
        {
            try
            {
                int affected = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("FilterID", tObject.FilterID));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteFilter", paramlist);
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

        public FilterContract GetByID(long id)
        {
            try
            {
                FilterContract filter = new FilterContract();

                using (TransactionScope scope = new TransactionScope())
                {
                    List<FilterContract> list = new List<FilterContract>();
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("FilterID", id));
                    DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetFilterByID", paramlist);
                    if (ds != null && ds.Tables.Count > 0)
                    {
                        list = (List<FilterContract>)CollectionHelper.ConvertTo<FilterContract>(ds.Tables[0]);
                        if (list.Count > 0)
                            filter = list[0];
                    }
                     
                }
                return filter;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
