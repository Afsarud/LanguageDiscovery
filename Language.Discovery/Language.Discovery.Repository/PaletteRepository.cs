using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading.Tasks;
using Language.Discovery.Entity;
using System.Transactions;
using Language.Discovery.Admin;

namespace Language.Discovery.Repository
{
    public class PaletteRepository : IRepository<PaletteContract>
    {
        public object Add(PaletteContract tObject)
        {
            try
            {
                long id = 0;

                string sentencexml = Utility.SerializeObjectToXML(tObject.SentenceList);
                string phrasexml = Utility.SerializeObjectToXML(tObject.PhraseList);
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                    paramlist.Add(new Parameter("PhraseCategoryID", tObject.PhraseCategoryID));
                    paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                    paramlist.Add(new Parameter("UserID", tObject.CreatedBy));
                    paramlist.Add(new Parameter("SentenceXml", sentencexml));
                    paramlist.Add(new Parameter("PhraseXml", phrasexml));
                    paramlist.Add(new Parameter("PaletteID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertPalette", paramlist);
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

        public bool AddBulkPalette(List<PaletteContract> plistContracts, bool deleteFirstThenAdd, long phraseCategoryID)
        {
            try
            {

                bool result = false;
                
                List<Sentence> sentenceList = new List<Sentence>();
                List<Phrase> phraseList = new List<Phrase>();

                foreach (PaletteContract palette in plistContracts)
                {
                    foreach (Sentence sentence in palette.SentenceList)
                    {
                        phraseList.AddRange(sentence.PhraseList);
                        sentence.PhraseList = null;
                    }
                    sentenceList.AddRange(palette.SentenceList);
                    palette.SentenceList = null;
                }

                string palettexml = Utility.SerializeObjectToXML(plistContracts);
                string sentencexml = Utility.SerializeObjectToXML(sentenceList);
                string phrasexml = Utility.SerializeObjectToXML(phraseList);
                palettexml = palettexml.Trim().Trim(new char[] {'\r','\n'});
                sentencexml = sentencexml.Trim().Trim(new char[] { '\r', '\n' });
                phrasexml = phrasexml.Trim().Trim(new char[] { '\r', '\n' });

                //Logger log = new Logger();
                //log.ErrorLog(ConfigurationManager.AppSettings["LogDirectory"], "repository before scope- " + palettexml + sentencexml + phrasexml);


                using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required, TimeSpan.FromSeconds(3600)))
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("DeleteFirstThenAdd", deleteFirstThenAdd));
                    paramlist.Add(new Parameter("PhraseCategoryID", phraseCategoryID));
                    paramlist.Add(new Parameter("PaletteXml", palettexml));
                    paramlist.Add(new Parameter("SentenceXml", sentencexml));
                    paramlist.Add(new Parameter("PhraseXml", phrasexml));
                    //paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                    //paramlist.Add(new Parameter("PhraseCategoryID", tObject.PhraseCategoryID));
                    //paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                    //paramlist.Add(new Parameter("UserID", tObject.CreatedBy));
                    //paramlist.Add(new Parameter("SentenceXml", sentencexml));
                    //paramlist.Add(new Parameter("PhraseXml", phrasexml));
                    //paramlist.Add(new Parameter("PaletteID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_BulkInsertPalette", paramlist);
                    if (affected > 0)
                    {
                        //log.ErrorLog(ConfigurationManager.AppSettings["LogDirectory"], "repository after insert - " + palettexml + sentencexml + phrasexml);
                        scope.Complete();
                    }

                    //List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    //if (pa != null)
                    //{
                    //    id = Convert.ToInt64(pa[0].Value);
                    //    scope.Complete();
                    //}

                    result =  affected > 0;
                }

                return result;
            }
            catch (Exception ex)
            {
                Logger log = new Logger();
                log.ErrorLog(ConfigurationManager.AppSettings["LogDirectory"]+ "error", ex.Message + "\r\n" + ex.InnerException);
                throw ex;
            }
        }

        public bool Update(PaletteContract tObject)
        {
            try
            {
                bool updated = false;

                string sentencexml = Utility.SerializeObjectToXML(tObject.SentenceList);
                string phrasexml = Utility.SerializeObjectToXML(tObject.PhraseList);
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PaletteID", tObject.PaletteID));
                    paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                    paramlist.Add(new Parameter("PhraseCategoryID", tObject.PhraseCategoryID));
                    paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                    paramlist.Add(new Parameter("UserID", tObject.CreatedBy));
                    paramlist.Add(new Parameter("SentenceXml", sentencexml));
                    paramlist.Add(new Parameter("PhraseXml", phrasexml));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdatePalette_New", paramlist);
                    if( affected > 0 )
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

        public bool Delete(PaletteContract tObject)
        {
            try
            {
                bool updated = false;

            
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PaletteID", tObject.PaletteID));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_DeletePalette", paramlist);
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

        public bool ApprovePalette(long paletteid, long userid)
        {
            try
            {
                bool updated = false;


                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("PaletteID", paletteid));
                    paramlist.Add(new Parameter("UserID", userid));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_ApprovedPalette", paramlist);
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


        public PaletteContract GetByID(long id)
        {
            try
            {
                PaletteContract pl = null;
                List<PaletteContract> plist = new List<PaletteContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("PaletteID", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetPaletteDetails", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataTable senteceTable = ds.Tables[1];
                    foreach (DataRow row in ds.Tables[0].Rows) // palette
                    {
                        PaletteContract pc = new PaletteContract();
                        pc.PaletteID = Convert.ToInt64(row["PaletteID"]);
                        pc.SchoolID = Convert.ToInt32(row["SchoolID"]);
                        pc.LevelID= Convert.ToInt32(row["LevelID"]);
                        pc.PhraseCategoryID = Convert.ToInt32(row["PhraseCategoryID"]);
                        pc.DefaultLanguageCode = row["DefaultLanguageCode"].ToString();

                        DataRow[] rows = senteceTable.Select(string.Format("PaletteID = {0}", pc.PaletteID.ToString()));

                        foreach (DataRow rw in senteceTable.Rows)
                        {
                            Sentence s = new Sentence();
                            s.Keyword = rw["Keyword"].ToString();
                            s.LanguageCode = rw["SentenceLanguageCode"].ToString();
                            s.SentenceID = Convert.ToInt64(rw["SentenceID"]);
                            s.SoundFile = rw["SentenceSoundFile"].ToString();
                            List<SentenceSound> ssList = new List<SentenceSound>();
                            foreach (DataRow srow in ds.Tables[2].Rows)
                            {
                                if (srow["SentenceSoundID"] == DBNull.Value)
                                    continue;

                                SentenceSound ss = new SentenceSound();
                                ss.SentenceSoundID = Convert.ToInt32(srow["SentenceSoundID"]);
                                ss.SentenceID = Convert.ToInt64(srow["SentenceID"]);
                                ss.LearningLanguageCode = srow["LearningLanguageCode"].ToString();
                                ss.SoundFile = srow["SoundFile"].ToString();
                                if (s.SentenceSoundList == null)
                                    s.SentenceSoundList = new List<SentenceSound>();

                                s.SentenceSoundList.Add(ss);
                            }

                            
                            pc.SentenceList.Add(s);
                        }
                                                
                        DataRow[] sRows = ds.Tables[3].Select(string.Format("PaletteID = {0}", pc.PaletteID.ToString()));
                        //List<Phrase> plist = new List<Phrase>();
                        foreach (DataRow r in sRows) // phrase
                        {
                            Phrase p = new Phrase();
                            p.SentenceID = Convert.ToInt64(r["SentenceID"]);
                            p.PalleteID = Convert.ToInt64(r["PaletteID"]);
                            p.WordMapID = Convert.ToInt64(r["WordMapID"]);
                            p.PhraseID = Convert.ToInt64(r["PhraseID"]);
                            p.Word = r["Word"].ToString();
                            //p.PluralForm = r["PluralForm"].ToString();
                            //p.Keyword = r["Keyword"].ToString();
                            p.LanguageCode = r["SentenceLanguageCode"].ToString();
                            p.Ordinal = Convert.ToInt32(r["Ordinal"]);
                            p.SoundFile = r["WordSoundFile"].ToString();
                            p.ImageFile = r["WordImageFile"].ToString();
                            p.WordType= r["WordType"].ToString();

                            pc.PhraseList.Add(p);
                        }

                        plist.Add(pc);
                    }
                    if (plist.Count > 0)
                        pl = plist[0];
                }

                return pl;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PhraseCategoryContract> GetPhraseCategoryList(string languageCode, int levelid)
        {
            try
            {
                List<PhraseCategoryContract> plist = new List<PhraseCategoryContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LanguageCode", languageCode));
                paramlist.Add(new Parameter("LevelID", levelid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetPhraseCategory", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        PhraseCategoryContract p = new PhraseCategoryContract();
                        p.PhraseCategoryID = Convert.ToInt64(row["PhraseCategoryID"]);
                        p.LanguageCode = row["LanguageCode"].ToString();
                        p.GroupID= row["GroupID"] == DBNull.Value ? 0 : Convert.ToInt64(row["GroupID"]);
                        p.LevelID = Convert.ToInt32(row["LevelID"]);
                        p.PhraseCategoryCode = row["PhraseCategoryCode"].ToString();
                        p.TopCategoryName = row["TopCategoryName"].ToString();
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

      

        public List<WordContract> SearchWord(SearchDTO criteria)
        {
            try
            {
                List<WordContract> wordlist = new List<WordContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", criteria.SchoolID));
                if( !string.IsNullOrEmpty(criteria.Word) )
                    paramlist.Add(new Parameter("Word", criteria.Word.Replace("'", "''")));
                if(!string.IsNullOrEmpty(criteria.Keyword))
                    paramlist.Add(new Parameter("Keyword", criteria.Keyword.Replace("'","''")));

                paramlist.Add(new Parameter("CategoryID", criteria.CategoryID));
                paramlist.Add(new Parameter("CategoryIDs", criteria.CategoryIDs));
                paramlist.Add(new Parameter("RowsPerPage", criteria.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", criteria.PageNumber));
                paramlist.Add(new Parameter("TopCategoryHeaderID", criteria.TopCategoryHeaderID));
                paramlist.Add(new Parameter("SearcheeID", criteria.UserID));
                paramlist.Add(new Parameter("IsTalk", criteria.IsTalk));
                paramlist.Add(new Parameter("WordType", criteria.WordType));
                paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));
                DataSet ds = null;
                if ( criteria.UserCreatedWord )
                    ds = DatabaseHelper.ExecuteQuery("usp_SearchWord_dynamic_UserCreated", paramlist);
                else
                    ds = DatabaseHelper.ExecuteQuery("usp_SearchWord_dynamic_3", paramlist);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    Parameter param = paramlist.Find(x => x.Direction.Equals(ParameterDirection.Output));
                    if (param != null)
                        criteria.VirtualCount = Convert.ToInt32(param.Value);

                    foreach (DataRow row in ds.Tables[0].Rows)
                    {
                        WordContract word = new WordContract();
                        word.WordID = Convert.ToInt64(row["WordID"]);
                        word.WordMapID = Convert.ToInt64(row["WordMapID"]);
                        word.Word = row["Word"].ToString();
                        word.Keyword = row["Keyword"].ToString(); ;
                        word.WordType = row["WordType"].ToString(); ;
                        word.PluralForm = row["PluralForm"].ToString(); ;
                        word.LanguageCode = row["LanguageCode"].ToString(); ;
                        word.SoundFile = row["SoundFile"] == DBNull.Value ? string.Empty : row["SoundFile"].ToString();
                        word.ImageFile = row["ImageFile"] == DBNull.Value ? string.Empty : row["ImageFile"].ToString();
                        word.SchoolID = row["SchoolID"] == DBNull.Value ? 0 : Convert.ToInt32(row["SchoolID"]);
                        word.Sequence = Convert.ToInt32(row["Sequence"]);

                        wordlist.Add(word);
                    }

                }

                return wordlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


      
        

        public List<WordContract> SearchWord1(SearchDTO criteria)
        {
            try
            {
                List<WordContract> wordlist = new List<WordContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Word", criteria.Word));
                paramlist.Add(new Parameter("Keyword", criteria.Keyword));
                paramlist.Add(new Parameter("RowsPerPage", criteria.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", criteria.PageNumber));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchWord", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow[] rows = ds.Tables[0].Select("ParentID IS NULL");
                   
                    foreach (DataRow row in rows)
                    {
                        WordContract word = new WordContract();
                        word.WordID = Convert.ToInt64(row["WordID"]);
                        word.Word = row["Word"].ToString();
                        word.Keyword = row["Keyword"].ToString(); ;
                        word.PluralForm = row["PluralForm"].ToString(); ;
                        word.LanguageCode = row["LanguageCode"].ToString(); ;
                        word.SoundFile = row["SoundFile"].ToString(); ;
                        word.ImageFile = row["ImageFile"].ToString(); ;
                        word.SchoolID = Convert.ToInt32(row["SchoolID"]);

                        DataRow[] drows = ds.Tables[0].Select(string.Format("ParentID = {0}", word.WordID.ToString()));
                        foreach (DataRow r in drows)
                        {
                            WordContract w = new WordContract();
                            w.WordID = Convert.ToInt64(r["WordID"]);
                            w.Word = r["Word"].ToString();
                            w.Keyword = r["Keyword"].ToString(); ;
                            w.PluralForm = r["PluralForm"].ToString(); ;
                            w.LanguageCode = r["LanguageCode"].ToString(); ;
                            w.SoundFile = r["SoundFile"].ToString(); ;
                            w.ImageFile = r["ImageFile"].ToString(); ;
                            w.ParentID = Convert.ToInt64(r["ParentID"]);
                            w.SchoolID = Convert.ToInt32(r["SchoolID"]);

                            word.WordList.Add(w);
                        }
                        wordlist.Add(word);
                    }
                   
                }

                return wordlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PaletteContract> Search1(SearchDTO criteria)
        {
            try
            {
                List<PaletteContract> phrases = new List<PaletteContract>();

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Word", criteria.Word  ));
                paramlist.Add(new Parameter("Keyword", criteria.Keyword));
                paramlist.Add(new Parameter("CategoryID", criteria.CategoryID));
                paramlist.Add(new Parameter("RowsPerPage", criteria.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", criteria.PageNumber));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchPhrase", paramlist);
                if( ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 )
                {
                    DataTable senteceTable = ds.Tables[1];
                    foreach (DataRow row in ds.Tables[0].Rows) // palette
                    {
                        PaletteContract pc = new PaletteContract();
                        pc.PaletteID = Convert.ToInt64(row["PaletteID"]);
                        pc.SchoolID = Convert.ToInt32(row["SchoolID"]);
                        pc.DefaultLanguageCode= row["DefaultLanguageCode"].ToString();
                        DataRow[] sRows = ds.Tables[1].Select(string.Format("PaletteID = {0}",pc.PaletteID.ToString()));
                        foreach (DataRow dr in sRows) // sentence
                        {
                            Sentence se = new Sentence();
                            se.PaletteID = pc.PaletteID;
                            se.SentenceID = Convert.ToInt64(dr["SentenceID"]);
                            se.LanguageCode = dr["LanguageCode"].ToString();

                            DataRow[] rows = ds.Tables[2].Select(string.Format("SentenceID = {0}",  se.SentenceID.ToString()));

                            foreach (DataRow r in rows)
                            {
                                if (r["ParentID"] != DBNull.Value)
                                    continue;

                                Phrase p = new Phrase();
                                p.SentenceID = se.SentenceID;
                                p.WordMapID = Convert.ToInt64(r["WordMapID"]);
                                p.PhraseID = Convert.ToInt64(r["PhraseID"]);
                                p.Word = r["Word"].ToString();
                                p.Keyword = r["PluralForm"].ToString();
                                p.Keyword = r["Keyword"].ToString();
                                p.LanguageCode = r["SentenceLanguageCode"].ToString();
                                p.Ordinal = Convert.ToInt32(r["Ordinal"]);
                                p.SoundFile = r["WordSoundFile"].ToString();
                                p.ImageFile = r["WordImageFile"].ToString();

                                DataRow[] prows = ds.Tables[2].Select(string.Format("ParentID = {0}", p.PhraseID.ToString()));
                                foreach (DataRow rc in prows)
                                {
                                    Phrase p1 = new Phrase();
                                    p1.SentenceID = Convert.ToInt64(rc["SentenceID"]);
                                    p1.WordMapID = Convert.ToInt64(rc["WordMapID"]);
                                    p1.PhraseID = Convert.ToInt64(rc["PhraseID"]);
                                    p1.Word = rc["Word"].ToString();
                                    p1.Keyword = rc["Keyword"].ToString();
                                    p1.Keyword = rc["PluralForm"].ToString();
                                    p1.LanguageCode = rc["SentenceLanguageCode"].ToString();
                                    p1.Ordinal = Convert.ToInt32(rc["Ordinal"]);
                                    p1.SoundFile = rc["WordSoundFile"].ToString();
                                    p1.ImageFile = rc["WordImageFile"].ToString();
                                    p.PhraseList.Add(p1);
                                }

                                se.PhraseList.Add(p);
                            }

                            pc.SentenceList.Add(se);
                            
                        }
                        phrases.Add(pc);

                        //pc.SentenceID = Convert.ToInt64(row["SentenceID"]);
                        //pc.ImageFile = row["ImageFile"].ToString();
                        //pc.SoundFile = row["SoundFile"].ToString();
                        //pc.DefaultLanguageCode = row["DefaultLanguageCode"].ToString();
                        
                        //DataRow[] rows = dt.Select(string.Format("SentenceID = {0}", row["SentenceID"].ToString()));
                        //if (rows.Length > 0)
                        //{
                            
                        //    foreach (DataRow r in rows)
                        //    {
                        //        Phrase p = new Phrase();
                        //        p.SentenceID = pc.SentenceID; 
                        //        p.WordGroupID = Convert.ToInt64(r["WordGroupID"]);
                        //        p.WordMapID = Convert.ToInt64(r["WordMapID"]);
                        //        p.PhraseID = Convert.ToInt64(r["PhraseID"]);
                        //        p.Word = r["Word"].ToString();
                        //        p.Keyword = r["Keyword"].ToString();
                        //        p.LanguageCode = r["LanguageCode"].ToString();
                        //        p.Ordinal= Convert.ToInt32(r["Ordinal"]); 
                        //        p.SoundFile = r["SoundFile"].ToString();
                        //        p.ImageFile = r["ImageFile"].ToString();
                        //        pc.PhraseList.Add(p);
                        //    }
                            
                        //}
                        //phrases.Add(pc);
                    }
                }

                return phrases;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PaletteContract> Search(SearchDTO criteria)
        {
            try
            {
                List<PaletteContract> pl = new List<PaletteContract>();

                List<Parameter> paramlist = new List<Parameter>();
                string sp = "usp_SearchPhrase_dynamic_3";
                if (criteria.IsUserPalette)
                {
                    paramlist.Add(new Parameter("UserID", criteria.UserID));
                    paramlist.Add(new Parameter("RowsPerPage", criteria.RowsPerPage));
                    paramlist.Add(new Parameter("PageNumber", criteria.PageNumber));
                    paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));
                    sp = "usp_GetUserPalette";
                }
                else
                {
                    if (!string.IsNullOrEmpty(criteria.Word))
                        paramlist.Add(new Parameter("Word", criteria.Word));

                    if (!string.IsNullOrEmpty(criteria.Keyword))
                        paramlist.Add(new Parameter("Keyword", criteria.Keyword));

                    paramlist.Add(new Parameter("CategoryID", criteria.CategoryID));
                    paramlist.Add(new Parameter("CategoryIDs", criteria.CategoryIDs));
                    paramlist.Add(new Parameter("LevelID", criteria.LevelID));
                    paramlist.Add(new Parameter("SchoolID", criteria.SchoolID));
                    paramlist.Add(new Parameter("RowsPerPage", criteria.RowsPerPage));
                    paramlist.Add(new Parameter("PageNumber", criteria.PageNumber));
                    paramlist.Add(new Parameter("IsAdmin", criteria.IsAdmin));
                    paramlist.Add(new Parameter("TopCategoryHeaderID", criteria.TopCategoryHeaderID));
                    paramlist.Add(new Parameter("LanguageCode", criteria.LanguageCode));
                    paramlist.Add(new Parameter("SearcheeID", criteria.UserID));
                    paramlist.Add(new Parameter("IsTalk", criteria.IsTalk));
                    paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));
                }
                DataSet ds = DatabaseHelper.ExecuteQuery(sp, paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    Parameter param = paramlist.Find(x =>x.Direction.Equals(ParameterDirection.Output));
                    if (param != null)
                        criteria.VirtualCount = Convert.ToInt32(param.Value);

                    DataTable senteceTable = ds.Tables[1];
                    
                    foreach (DataRow row in ds.Tables[0].Rows) // palette
                    {
                        PaletteContract pc = new PaletteContract();
                        
                        pc.PaletteID = Convert.ToInt64(row["PaletteID"]);
                        pc.SchoolID = Convert.ToInt32(row["SchoolID"]);
                        pc.DefaultLanguageCode = row["DefaultLanguageCode"].ToString();
                        if (row["CreateDate"] != DBNull.Value)
                            pc.CreateDate = Convert.ToDateTime(row["CreateDate"]);

                        if (row["ModifiedDate"] != DBNull.Value)
                            pc.ModifiedDate = Convert.ToDateTime(row["ModifiedDate"]);

                        //pc.Keyword= row["Keyword"].ToString();
                        DataRow[] sRows = ds.Tables[2].Select(string.Format("PaletteID = {0}", pc.PaletteID.ToString()));

                        foreach (DataRow rw in senteceTable.Rows)
                        {
                            Sentence s = new Sentence();
                            s.PaletteID = Convert.ToInt64( rw["PaletteID"]);
                            s.SentenceID = Convert.ToInt64(rw["SentenceID"]);
                            s.LanguageCode =  rw["LanguageCode"].ToString();
                            s.SoundFile = rw["SoundFile"].ToString();
                            s.Keyword= rw["Keyword"].ToString();

                            //DataRow[] ssoundRows = ds.Tables[2].Select(string.Format("SentenceID= {0}", s.SentenceID.ToString()));

                            //foreach (DataRow srow in ssoundRows)
                            //{
                            //    if (srow["SentenceSoundID"] == DBNull.Value)
                            //        continue;

                            //    SentenceSound ss = new SentenceSound();
                            //    ss.SentenceSoundID = Convert.ToInt32(srow["SentenceSoundID"]);
                            //    ss.SentenceID = Convert.ToInt64(srow["SentenceID"]);
                            //    ss.LearningLanguageCode = srow["LearningLanguageCode"].ToString();
                            //    ss.SoundFile = srow["SoundFile"].ToString();
                            //    if (s.SentenceSoundList == null)
                            //        s.SentenceSoundList = new List<SentenceSound>();

                            //    s.SentenceSoundList.Add(ss);
                            //}

                            pc.SentenceList.Add(s);
                        }

                        List<Phrase> plist = new List<Phrase>();
                        foreach (DataRow r in sRows) // phrase
                        {
                            Phrase p = new Phrase();
                            p.SentenceID = Convert.ToInt64(r["SentenceID"]);
                            p.PalleteID = Convert.ToInt64(r["PaletteID"]);
                            p.WordMapID = Convert.ToInt64(r["WordMapID"]);
                            p.PhraseID = Convert.ToInt64(r["PhraseID"]);
                            p.Word = r["Word"].ToString();
                            p.Keyword = r["PluralForm"].ToString();
                            p.WordType = r["WordType"].ToString();
                            p.LanguageCode = r["SentenceLanguageCode"].ToString();
                            p.Ordinal = Convert.ToInt32(r["Ordinal"]);
                            p.SoundFile = r["WordSoundFile"].ToString();
                            p.ImageFile = r["WordImageFile"].ToString();
                            if(r.Table.Columns.Contains("DataSwapped"))
                                p.DataSwapped = Convert.ToBoolean(r["DataSwapped"]);

                            pc.PhraseList.Add(p);
                        }

                        pl.Add(pc);
                    }
                }

                return pl;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<PaletteContract> GetPaletteSuggestion()
        {
            try
            {
                List<PaletteContract> pl = new List<PaletteContract>();

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetRandomSuggestion", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {

                    DataTable senteceTable = ds.Tables[1];
                    foreach (DataRow row in ds.Tables[0].Rows) // palette
                    {
                        PaletteContract pc = new PaletteContract();
                        pc.PaletteID = Convert.ToInt64(row["PaletteID"]);
                        pc.SchoolID = Convert.ToInt32(row["SchoolID"]);
                        pc.DefaultLanguageCode = row["DefaultLanguageCode"].ToString();
                        pc.Keyword = row["DefaultLanguageCode"].ToString();
                        DataRow[] sRows = ds.Tables[2].Select(string.Format("PaletteID = {0}", pc.PaletteID.ToString()));
                        List<Phrase> plist = new List<Phrase>();
                        foreach (DataRow r in sRows) // phrase
                        {
                            Phrase p = new Phrase();
                            p.SentenceID = Convert.ToInt64(r["SentenceID"]);
                            p.PalleteID = Convert.ToInt64(r["PaletteID"]);
                            p.WordMapID = Convert.ToInt64(r["WordMapID"]);
                            p.PhraseID = Convert.ToInt64(r["PhraseID"]);
                            p.Word = r["Word"].ToString();
                            p.Keyword = r["PluralForm"].ToString();
                            //p.Keyword = r["Keyword"].ToString();
                            p.LanguageCode = r["SentenceLanguageCode"].ToString();
                            p.Ordinal = Convert.ToInt32(r["Ordinal"]);
                            p.SoundFile = r["WordSoundFile"].ToString();
                            p.ImageFile = r["WordImageFile"].ToString();
                            p.WordType = r["WordType"].ToString();

                            pc.PhraseList.Add(p);
                        }

                        pl.Add(pc);
                    }
                }

                return pl;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool HasFoulWords(string message)
        {
            try
            {
                bool hasfoul = false;

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Message", message));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_CheckForFilteredWords", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    hasfoul = true;
                }

                return hasfoul;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

       

    }
}
