using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Language.Discovery.Entity;
using System.Transactions;

namespace Language.Discovery.Repository
{
    public class InfoRepository : IRepository<InfoContract>
    {
        public bool Delete(InfoContract tObject)
        {
            try
            {
                int affected = 0;
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ID", tObject.InfoID));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteInfo", paramlist);
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
        public object Add(InfoContract tObject)
        {
            try
            {
                int schoolid = 0;
                using (TransactionScope scope = new TransactionScope())
                {

                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("InfoMessage", tObject.InfoMessage));
                    paramlist.Add(new Parameter("InfoType", tObject.InfoType));
                    paramlist.Add(new Parameter("ImageFile", tObject.ImageFile));
                    paramlist.Add(new Parameter("ID", 0, DbType.Int32, ParameterDirection.Output));

                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertInfo", paramlist);
                    
                    if (affected > 0)
                    {
                        scope.Complete();
                        List<Parameter> output = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                        if (output != null)
                        {
                            schoolid = Convert.ToInt32(output[0].Value);
                        }

                    }
                }

                return schoolid;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(InfoContract tObject)
        {
            try
            {
                int affected = 0;
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ID", tObject.InfoID));
                    paramlist.Add(new Parameter("InfoMessage", tObject.InfoMessage));
                    paramlist.Add(new Parameter("InfoType", tObject.InfoType));
                    paramlist.Add(new Parameter("IsActive", tObject.IsActive));
                    paramlist.Add(new Parameter("ImageFile", tObject.ImageFile));

                    affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateInfo", paramlist);
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

        public InfoContract GetByID(Int64 id)
        {
            try
            {
                List<InfoContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetInfoByID", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<InfoContract>)CollectionHelper.ConvertTo<InfoContract>(ds.Tables[0]);
                }

                return msg[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public InfoContract GetInfoByType(string type)
        {
            try
            {
                List<InfoContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Type", type));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetInfoByType", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<InfoContract>)CollectionHelper.ConvertTo<InfoContract>(ds.Tables[0]);
                }

                return msg == null ? null : msg[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<InfoContract> Search(SearchInfoDTO tObject)
        {
            try
            {
                List<InfoContract> infos = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("RowsPerPage", tObject.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", tObject.PageNumber));
                paramlist.Add(new Parameter("InfoType", tObject.InfoType));
                paramlist.Add(new Parameter("IsActive", tObject.IsActive));
                paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchInfo", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    infos = (List<InfoContract>)CollectionHelper.ConvertTo<InfoContract>(ds.Tables[0]);

                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        tObject.VirtualCount = Convert.ToInt32(pa[0].Value);
                    }
                }

                return infos;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }        
    }
}