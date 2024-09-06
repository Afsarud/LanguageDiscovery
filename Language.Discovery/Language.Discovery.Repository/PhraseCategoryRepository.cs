using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;
using Language.Discovery.Entity;
using Language.Discovery.Entity.Contract;

namespace Language.Discovery.Repository
{
    public class PhraseCategoryRepository : IRepository<PhraseCategoryHeaderContract>
    {
     
        public object Add(PhraseCategoryHeaderContract tObject)
        {
            try
            {
                long id = 0;

                string xml = Utility.SerializeObjectToXML(tObject.PhraseCategories);
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                    paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                    paramlist.Add(new Parameter("UserID", tObject.CreatedByID));
                    paramlist.Add(new Parameter("FolderName", tObject.FolderName));
                    paramlist.Add(new Parameter("IsDemo", tObject.IsDemo));
                    paramlist.Add(new Parameter("DisplayInUI", tObject.DisplayInUI));
                    paramlist.Add(new Parameter("TopCategoryHeaderID", tObject.TopCategoryHeaderID));
                    paramlist.Add(new Parameter("HideInScheduler", tObject.HideInScheduler));
                    paramlist.Add(new Parameter("xml", xml));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertPhraseCategory", paramlist);
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

        public bool Update(PhraseCategoryHeaderContract tObject)
        {
            try
            {

                int affected = 0;
                string xml = Utility.SerializeObjectToXML(tObject.PhraseCategories);
                using (TransactionScope scope = new TransactionScope())
                {

                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PhraseCategoryHeaderID", tObject.PhraseCategoryHeaderID));
                    paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                    paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                    paramlist.Add(new Parameter("UserID", tObject.CreatedByID));
                    paramlist.Add(new Parameter("FolderName", tObject.FolderName));
                    paramlist.Add(new Parameter("IsDemo", tObject.IsDemo));
                    paramlist.Add(new Parameter("DisplayInUI", tObject.DisplayInUI));
                    paramlist.Add(new Parameter("TopCategoryHeaderID", tObject.TopCategoryHeaderID));
                    paramlist.Add(new Parameter("HideInScheduler", tObject.HideInScheduler));
                    paramlist.Add(new Parameter("xml", xml));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_UpdatePhraseCategory", paramlist);
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

        public bool Delete(PhraseCategoryHeaderContract tObject)
        {
            try
            {
                int affected = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PhraseCategoryHeaderID", tObject.PhraseCategoryHeaderID));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_DeletePhraseCategory", paramlist);
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

        public PhraseCategoryHeaderContract GetByID(long id)
        {
            try
            {
                PhraseCategoryHeaderContract header = new PhraseCategoryHeaderContract();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("PhraseCategoryID", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetPhraseCategoryDetails", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {

                        header.PhraseCategoryHeaderID = Convert.ToInt64(dr["PhraseCategoryHeaderID"]);
                        header.CreateDate = Convert.ToDateTime(dr["CreateDate"]);
                        header.CreatedByID = Convert.ToInt64(dr["CreatedByID"]);
                        header.LevelID = Convert.ToInt32( dr["LevelID"]);
                        header.SchoolID = Convert.ToInt64(dr["SchoolID"]);
                        header.Ordinal = Convert.ToInt32(dr["Ordinal"]);
                        header.FolderName = dr["FolderName"].ToString();
                        header.IsDemo = Convert.ToBoolean(dr["IsDemo"]);
                        header.DisplayInUI  = Convert.ToBoolean(dr["DisplayInUI"]);
                        header.TopCategoryHeaderID = dr["TopCategoryHeaderID"] == DBNull.Value ? 0 : Convert.ToInt32(dr["TopCategoryHeaderID"]);
                        header.HideInScheduler = Convert.ToBoolean(dr["HideInScheduler"]);
                        List<PhraseCategoryContract> plist = new List<PhraseCategoryContract>();
                        DataRow[] rows = ds.Tables[1].Select("GroupID = " + header.PhraseCategoryHeaderID);

                        foreach (DataRow row in rows)
                        {
                            PhraseCategoryContract p = new PhraseCategoryContract();
                            p.PhraseCategoryID = Convert.ToInt64(row["PhraseCategoryID"]);
                            p.GroupID = Convert.ToInt64(row["GroupID"]);
                            p.PhraseCategoryCode = row["PhraseCategoryCode"].ToString();
                            p.LanguageCode = row["LanguageCode"].ToString();

                            header.PhraseCategories.Add(p);
                        }

                    }
                }

                return header;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PhraseCategoryContract> GetPhraseCategoryListToOrder(string languageCode, int levelid)
        {
            try
            {
                List<PhraseCategoryContract> plist = new List<PhraseCategoryContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", languageCode));
                paramlist.Add(new Parameter("LevelID", levelid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetPhraseCategoryListToOrder", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PhraseCategoryContract p = new PhraseCategoryContract();
                        p.PhraseCategoryID = Convert.ToInt64(row["PhraseCategoryID"]);
                        p.LanguageCode = row["LanguageCode"].ToString();
                        p.GroupID = row["GroupID"] == DBNull.Value ? 0 : Convert.ToInt64(row["GroupID"]);
                        p.LevelID = Convert.ToInt32(row["LevelID"]);
                        p.PhraseCategoryCode = row["PhraseCategoryCode"].ToString();
                        //p.PhraseCategoryName = row["PhraseCategoryName"].ToString();
                        //p.ParentID = row["ParentID"] == DBNull.Value ? 0 : Convert.ToInt64(row["ParentID"]);
                        p.Ordinal = Convert.ToInt32(row["Ordinal"]);
                        p.SchoolID = Convert.ToInt32(row["SchoolID"]);
                        plist.Add(p);
                    }

                }

                return plist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PhraseCategoryContract> GetPhraseCategoryList(string languageCode, int levelid, int? schoolid)
        {
            try
            {
                List<PhraseCategoryContract> plist = new List<PhraseCategoryContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", languageCode));
                paramlist.Add(new Parameter("LevelID", levelid));
                if(schoolid.HasValue)
                    paramlist.Add(new Parameter("SchoolID", schoolid.Value));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetPhraseCategory", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PhraseCategoryContract p = new PhraseCategoryContract();
                        p.PhraseCategoryID = Convert.ToInt64(row["PhraseCategoryID"]);
                        p.LanguageCode = row["LanguageCode"].ToString();
                        p.GroupID = row["GroupID"] == DBNull.Value ? 0 : Convert.ToInt64(row["GroupID"]);
                        p.LevelID = Convert.ToInt32(row["LevelID"]);
                        p.PhraseCategoryCode = row["PhraseCategoryCode"].ToString();
                        //p.PhraseCategoryName = row["PhraseCategoryName"].ToString();
                        //p.ParentID = row["ParentID"] == DBNull.Value ? 0 : Convert.ToInt64(row["ParentID"]);
                        p.Ordinal = Convert.ToInt32(row["Ordinal"]);
                        p.SchoolID = Convert.ToInt32(row["SchoolID"]);
                        p.IsDemo = Convert.ToBoolean(row["IsDemo"]);
                        p.DisplayInUI = Convert.ToBoolean(row["DisplayInUI"]);
                        p.IsDefault = Convert.ToBoolean(row["IsDefault"]);
                        p.IsTalk = Convert.ToBoolean(row["IsTalk"]);
                        p.TopCategoryHeaderID = row["TopCategoryHeaderID"] == DBNull.Value ? 0 : Convert.ToInt32(row["TopCategoryHeaderID"]);
                        p.HideInScheduler = Convert.ToBoolean(row["HideInScheduler"]);
                        
                        plist.Add(p);
                    }

                }

                return plist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

      

        public List<PhraseCategoryHeaderContract> SearchPhraseCategory(string languagecode, string category, int levelid, long schoolid)
        {
            try
            {
                //List<WordContract> wordlist = new List<WordContract>();
                List<PhraseCategoryHeaderContract> phclist = new List<PhraseCategoryHeaderContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", languagecode));
                paramlist.Add(new Parameter("PhraseCategoryCode", category));
                paramlist.Add(new Parameter("LevelID", levelid));
                paramlist.Add(new Parameter("SchoolID", schoolid));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchPhraseCategory", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        PhraseCategoryHeaderContract phc = new PhraseCategoryHeaderContract();
                        phc.PhraseCategoryHeaderID = Convert.ToInt64(dr["PhraseCategoryHeaderID"]);
                        phc.LevelID = Convert.ToInt32(dr["LevelID"]);
                        phc.CreatedByID = Convert.ToInt64(dr["CreatedByID"]);
                        phc.SchoolID = Convert.ToInt64(dr["SchoolID"]);

                        //List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                        //if (pa != null)
                        //{
                        //    whc.VirtualCount = Convert.ToInt32(pa[0].Value);
                        //}


                        List<PhraseCategoryContract> wordlist = new List<PhraseCategoryContract>();
                        DataRow[] rows = ds.Tables[1].Select("GroupID = " + phc.PhraseCategoryHeaderID);

                        foreach (DataRow row in rows)
                        {
                            PhraseCategoryContract p = new PhraseCategoryContract();
                            p.PhraseCategoryID = Convert.ToInt64(row["PhraseCategoryID"]);
                            p.GroupID = Convert.ToInt64(row["GroupID"]);
                            p.LanguageCode = row["LanguageCode"].ToString();
                            p.PhraseCategoryCode = row["PhraseCategoryCode"].ToString();


                            //word.SchoolID = Convert.ToInt32(row["SchoolID"]);

                            phc.PhraseCategories.Add(p);
                        }

                        phclist.Add(phc);
                    }
                }

                return phclist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateCategoryOrder(string xml)
        {
            try
            {
                int affected = 0;
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("xml", xml));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_UpdatePhraseCategoryOrder", paramlist);
                    if( affected > 0 )
                        scope.Complete();

                }

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool BulkInsertPhraseCategory(List<PhraseCategoryHeaderContract> tHeader, List<PhraseCategoryContract> tDetail)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("PhraseCategoryHeaderXml", Utility.SerializeObjectToXML(tHeader)));
                paramlist.Add(new Parameter("PhraseCategoryXml", Utility.SerializeObjectToXML(tDetail)));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_BulkInsertPhraseCategory", paramlist);

                return affected > 0;
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

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", languageCode));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetTopCategoryList", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    plist = (List<TopCategoryContract>)CollectionHelper.ConvertTo<TopCategoryContract>(ds.Tables[0]);

                }

                return plist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
