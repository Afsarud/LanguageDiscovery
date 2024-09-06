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
    public class ClassRepository : IRepository<ClassContract>
    {

        public DataSet Search(string classname, int schoolid)
        {
            try
            {
                List<ClassContract> list = new List<ClassContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ClassName", classname));
                paramlist.Add(new Parameter("SchoolId", schoolid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchClass", paramlist);
                //if (ds != null && ds.Tables.Count > 0)
                //{
                //    list = (List<ClassContract>)CollectionHelper.ConvertTo<ClassContract>(ds.Tables[0]);
                //}
                return ds;

            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }

        public object Add(ClassContract tObject)
        {
            try
            {
                long id = 0;

                
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ClassName", tObject.ClassName));
                    paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertClass", paramlist);
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

        public bool Update(ClassContract tObject)
        {
            try
            {

                bool updated = false;
                using (TransactionScope scope = new TransactionScope())
                {

                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ClassID", tObject.ClassID));
                    paramlist.Add(new Parameter("ClassName", tObject.ClassName));
                    paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateClass", paramlist);
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

        public bool Delete(ClassContract tObject)
        {
            try
            {
                int affected = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ClassID", tObject.ClassID));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteClass", paramlist);
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

        public ClassContract GetByID(long id)
        {
            try
            {
                ClassContract filter = new ClassContract();

                using (TransactionScope scope = new TransactionScope())
                {
                    List<ClassContract> list = new List<ClassContract>();
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ClassID", id));
                    DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetClassByID", paramlist);
                    if (ds != null && ds.Tables.Count > 0)
                    {
                        list = (List<ClassContract>)CollectionHelper.ConvertTo<ClassContract>(ds.Tables[0]);
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

        public List<ClassContract> GetClassList(int schoolid )
        {
            try
            {
                List<ClassContract> classlist = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetClassList", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    classlist = (List<ClassContract>)CollectionHelper.ConvertTo<ClassContract>(ds.Tables[0]);
                }

                return classlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
