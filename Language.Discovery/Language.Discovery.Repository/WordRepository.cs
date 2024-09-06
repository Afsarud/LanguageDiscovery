using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Language.Discovery.Entity;
using System.Data;
using System.Transactions;


namespace Language.Discovery.Repository
{
    public class WordRepository : IRepository<WordHeaderContract>
    {
        public object Add(WordHeaderContract tObject)
        {
            try
            {
                long id = 0;

                string xml = Utility.SerializeObjectToXML(tObject.Words);
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ImageFile", tObject.ImageFile));
                    paramlist.Add(new Parameter("PhraseCategoryID", tObject.PhraseCategoryID));
                    paramlist.Add(new Parameter("UserID", tObject.CreatedByID));
                    paramlist.Add(new Parameter("Keyword", tObject.Keyword));
                    paramlist.Add(new Parameter("WordType", tObject.WordType));
                    paramlist.Add(new Parameter("xml", xml));
                    paramlist.Add(new Parameter("UserCreatedWord", tObject.UserCreatedWord));
                    paramlist.Add(new Parameter("Sequence", tObject.Sequence));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertWords", paramlist);
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

        public bool BulkAddWords(List<WordHeaderContract> header, List<WordContract> detail, bool deleteFirstThenAdd, long phraseCategoryID)
        {
            try
            {
                int affected = 0;

                string headerxml = Utility.SerializeObjectToXML(header);
                string detailxml = Utility.SerializeObjectToXML(detail);
                using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required, TimeSpan.FromSeconds(360)))
                {
                    
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("header", headerxml));
                    paramlist.Add(new Parameter("detail", detailxml));
                    paramlist.Add(new Parameter("DeleteFirstThenAdd", deleteFirstThenAdd));
                    paramlist.Add(new Parameter("PhraseCategoryID", phraseCategoryID));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_BulkInsertWords", paramlist);
                    if (affected > 0)
                    {
                        scope.Complete();
                    }
                }

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(WordHeaderContract tObject)
        {
            try
            {

                int affected = 0;
                string xml = Utility.SerializeObjectToXML(tObject.Words);
                using (TransactionScope scope = new TransactionScope())
                {

                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("WordHeaderID", tObject.WordHeaderID));
                    paramlist.Add(new Parameter("ImageFile", tObject.ImageFile));
                    paramlist.Add(new Parameter("PhraseCategoryID", tObject.PhraseCategoryID));
                    paramlist.Add(new Parameter("UserID", tObject.CreatedByID));
                    paramlist.Add(new Parameter("Keyword", tObject.Keyword));
                    paramlist.Add(new Parameter("WordType", tObject.WordType ));
                    paramlist.Add(new Parameter("Sequence", tObject.Sequence));
                    paramlist.Add(new Parameter("xml", xml));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateWords", paramlist);
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

        public bool Delete(WordHeaderContract tObject)
        {
            try
            {
                int affected = 0;
                
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("WordHeaderID", tObject.WordHeaderID));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteWord", paramlist);
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

        public WordHeaderContract GetByID(long id)
        {
            try
            {
                //List<WordContract> wordlist = new List<WordContract>();
                WordHeaderContract wordheader = new WordHeaderContract();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("WordHeaderID", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetWordDetails", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {

                        wordheader.WordHeaderID = Convert.ToInt64(dr["WordHeaderID"]);
                        wordheader.CreateDate = Convert.ToDateTime(dr["CreateDate"]);
                        wordheader.CreatedByID = Convert.ToInt64(dr["CreatedByID"]);
                        wordheader.PhraseCategoryID = Convert.ToInt64(dr["PhraseCategoryID"]);
                        wordheader.ImageFile = dr["ImageFile"].ToString();
                        wordheader.Keyword= dr["Keyword"].ToString();
                        wordheader.WordType = dr["WordType"].ToString();
                        wordheader.Sequence = Convert.ToInt32(dr["Sequence"]);

                        List<WordContract> wordlist = new List<WordContract>();
                        DataRow[] rows = ds.Tables[1].Select("WordMapID = " + wordheader.WordHeaderID);

                        foreach (DataRow row in rows)
                        {
                            WordContract word = new WordContract();
                            word.WordID = Convert.ToInt64(row["WordID"]);
                            word.WordMapID = Convert.ToInt64(row["WordMapID"]);
                            word.Word = row["Word"].ToString();
                            word.Keyword = row["Keyword"].ToString(); ;
                            word.PluralForm = row["PluralForm"].ToString(); ;
                            word.LanguageCode = row["LanguageCode"].ToString(); ;
                            word.SoundFile = row["SoundFile"].ToString(); ;
                            word.ImageFile = row["ImageFile"].ToString(); ;
                            //word.SchoolID = Convert.ToInt32(row["SchoolID"]);

                            wordheader.Words.Add(word);
                        }
                        
                    }
                }

                return wordheader;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<WordHeaderContract> SearchWordAdmin(SearchDTO criteria)
        {
            try
            {
                //List<WordContract> wordlist = new List<WordContract>();
                List<WordHeaderContract> wordheaderlist = new List<WordHeaderContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", criteria.SchoolID));
                paramlist.Add(new Parameter("Word", criteria.Word));
                paramlist.Add(new Parameter("Keyword", criteria.Keyword));
                paramlist.Add(new Parameter("RowsPerPage", criteria.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", criteria.PageNumber));
                paramlist.Add(new Parameter("LanguageCode", criteria.LanguageCode));
                paramlist.Add(new Parameter("CategoryID", criteria.CategoryID));
                paramlist.Add(new Parameter("IsExport", criteria.IsExport));
                paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchWordAdmin", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        WordHeaderContract whc = new WordHeaderContract();
                        whc.WordHeaderID = Convert.ToInt64(dr["WordHeaderID"]);
                        whc.CreateDate = Convert.ToDateTime(dr["CreateDate"]);
                        whc.CreatedByID = Convert.ToInt64(dr["CreatedByID"]);
                        whc.ImageFile = dr["ImageFile"].ToString();
                        whc.Keyword = dr["Keyword"].ToString();
                        whc.WordType= dr["WordType"].ToString();
                        whc.Sequence = Convert.ToInt32(dr["Sequence"]);

                        List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                        if (pa != null)
                        {
                            whc.VirtualCount = Convert.ToInt32(pa[0].Value);
                        }


                        List<WordContract> wordlist = new List<WordContract>();
                        DataRow[] rows = ds.Tables[1].Select("WordHeaderID = " + whc.WordHeaderID);

                        foreach (DataRow row in rows)
                        {
                            WordContract word = new WordContract();
                            word.WordID = Convert.ToInt64(row["WordID"]);
                            word.WordMapID = Convert.ToInt64(row["WordMapID"]);
                            word.Word = row["Word"].ToString();
                            word.Keyword = row["Keyword"].ToString(); ;
                            word.PluralForm = row["PluralForm"].ToString(); ;
                            word.LanguageCode = row["LanguageCode"].ToString(); ;
                            word.SoundFile = row["SoundFile"].ToString();
                            word.ImageFile = row["ImageFile"].ToString();



                            //word.SchoolID = Convert.ToInt32(row["SchoolID"]);

                            whc.Words.Add(word);
                        }

                        wordheaderlist.Add(whc);
                    }
                }

                return wordheaderlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
