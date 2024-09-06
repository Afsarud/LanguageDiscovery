using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Language.Discovery.Repository
{
    public class DatabaseHelper
    {
        //public static string ConnectionString { get; set; }
        public static DataSet ExecuteQuery(string storeProc, List<Parameter> paramlist)
        {
            try
            {
                 
                SqlConnection sqlConnection = new SqlConnection(ConfigSettings.ConnectionString);
                sqlConnection.Open();
                
                
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = storeProc;
                cmd.Connection = sqlConnection;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 300;

                if ((paramlist != null) && paramlist.Count > 0)
                {
                    foreach (Parameter p in paramlist)
                    {
                        SqlParameter param = new SqlParameter();
                        param.ParameterName = p.Name;
                        param.Value = p.Value;
                        param.Direction = p.Direction;
                        if (p.Direction == ParameterDirection.Output)
                        {
                            if (p.DataType == DbType.String)
                            {
                                param.DbType = DbType.String;
                                param.Size = 100;
                            }
                            else
                            {
                                param.DbType = DbType.Int32;
                                p.DataType = DbType.Int32;
                            }
                        }
                        cmd.Parameters.Add(param);
                        //cmd.Parameters.Add(new SqlParameter(p.Name, p.Value));
                    }
                }

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sqlDataAdapter.Fill(ds);
                sqlConnection.Close();

                if (paramlist != null)
                {
                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    long id = 0;
                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (Parameter param in pa)
                        {
                            if (param.DataType == DbType.Int32 || param.DataType == DbType.Int64)
                            {
                                id = Convert.ToInt64(cmd.Parameters[param.Name].Value);
                                param.Value = id.ToString();
                            }
                            else if (param.DataType == DbType.String)
                            {
                                param.Value = cmd.Parameters[param.Name].Value.ToString();
                            }
                        }
                    }
                }

                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static int ExecuteNonQuery(string storeProc, List<Parameter> paramList)
        {
            try
            {
                SqlConnection sqlConnection = new SqlConnection(ConfigSettings.ConnectionString);
                sqlConnection.Open();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = storeProc;
                cmd.Connection = sqlConnection;
                cmd.CommandTimeout = 3600;
                cmd.CommandType = CommandType.StoredProcedure;

                if ((paramList != null) && paramList.Count > 0)
                {

                    foreach (Parameter p in paramList)
                    {
                        SqlParameter param = new SqlParameter();
                        param.ParameterName = p.Name;
                        param.Value = p.Value;
                        param.Direction = p.Direction;
                        if (p.Direction == ParameterDirection.Output)
                        {
                            if (p.DataType == DbType.String)
                            {
                                param.DbType = DbType.String;
                                param.Size = 25;
                            }
                            else
                            {
                                param.DbType = DbType.Int32;
                                p.DataType = DbType.Int32;
                            }
                        }
                        cmd.Parameters.Add(param);
                    }
                }

                int affected = cmd.ExecuteNonQuery();
                if (paramList == null)
                {
                    return affected;
                }
                List<Parameter> pa = paramList.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                int id = 0;
                if (affected > 0 && pa != null && pa.Count > 0)
                {
                    foreach (Parameter param in pa)
                    {
                        if (param.DataType == DbType.Int32)
                        {
                            id = Convert.ToInt32(cmd.Parameters[param.Name].Value);
                            param.Value = id.ToString();
                        }
                        else if (param.DataType == DbType.String)
                        {
                            param.Value = cmd.Parameters[param.Name].Value.ToString();
                        }
                    }
                }

                sqlConnection.Close();

                return affected;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void UpdateSession()
        {

        }
    }
}
