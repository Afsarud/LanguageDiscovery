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
    public class TeacherRegistrationRepository : IRepository<TeacherRegistrationContract>
    {

        public object Add(TeacherRegistrationContract tObject)
        {
            try
            {
                long id = 0;

                
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("FirstName", tObject.FirstName));
                    paramlist.Add(new Parameter("LastName", tObject.LastName));
                    paramlist.Add(new Parameter("Email", tObject.Email));
                    paramlist.Add(new Parameter("SchoolName", tObject.SchoolName));
                    paramlist.Add(new Parameter("Gender", tObject.Gender));
                    paramlist.Add(new Parameter("Telephone", tObject.Telephone));
                    paramlist.Add(new Parameter("ObjectID", tObject.ObjectID));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertNewUserRegistration", paramlist);
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

        public bool Update(TeacherRegistrationContract tObject)
        {
            try
            {

                bool updated = false;
                using (TransactionScope scope = new TransactionScope())
                {

                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ObjectID", tObject.ObjectID));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateNewUserRegistration", paramlist);
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

        public bool Delete(TeacherRegistrationContract tObject)
        {
            try
            {
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public TeacherRegistrationContract GetByID(long id)
        {
            try
            {
                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<TeacherRegistrationContract> GetTeacherRegistration(string objectId)
        {
            try
            {
                List<TeacherRegistrationContract> list = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ObjectID", objectId));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetTeacherRegistration", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    list = (List<TeacherRegistrationContract>)CollectionHelper.ConvertTo<TeacherRegistrationContract>(ds.Tables[0]);
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
