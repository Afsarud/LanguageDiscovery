using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Web.Script.Serialization;
using Language.Discovery.Entity;
using Language.Discovery.Repository;
using System.IO;
using System.Drawing;
using System.Data;

namespace Language.Discovery.Services.Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "PaletteService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select PaletteService.svc or PaletteService.svc.cs at the Solution Explorer and start debugging.
    public class PaletteService : IPaletteService
    {

        public long AddPalette(PaletteContract pc)
        {
            try
            {
                string json = GetPhraseCategoryDetails(pc.PhraseCategoryID);
                PhraseCategoryHeaderContract pcc = new JavaScriptSerializer().Deserialize<PhraseCategoryHeaderContract>(json);
                string categoryname = string.Empty;
                if (pcc != null)
                {
                    categoryname = pcc.FolderName;
                    //PhraseCategoryContract p = pcc.PhraseCategories.Find(x => x.LanguageCode == "en-US");
                    //if (p != null)
                    //    categoryname = p.PhraseCategoryCode;
                }
                

                long id = 0;
                //WordHeaderContract whc = new JavaScriptSerializer().Deserialize<WordHeaderContract>(json);
                if (pc != null)
                {
                    PaletteRepository rep = new PaletteRepository();
                    string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                    //string filename = whc.ImageFile.Length > 0 ? Path.GetFileNameWithoutExtension(whc.ImageFile) + "_" + guid + Path.GetExtension(whc.ImageFile) : string.Empty;
                    //whc.ImageFile = filename;

                    //foreach (Entity.Phrase p in pc.PhraseList)
                    //{
                    //    string filename = !string.IsNullOrEmpty(p.SoundFile) ? Path.GetFileNameWithoutExtension(p.SoundFile) + "_" + guid + Path.GetExtension(p.SoundFile) : string.Empty;
                    //    if (p.SoundBytes != null && p.SoundBytes.Length > 0)
                    //        p.SoundFile = filename;
                    //}

                    //foreach (Entity.Phrase p in pc.PhraseList)
                    //{
                    //    string filename = !string.IsNullOrEmpty(p.ImageFile) ? Path.GetFileNameWithoutExtension(p.ImageFile) + "_" + guid + Path.GetExtension(p.ImageFile) : string.Empty;
                    //    if (p.ImageBytes != null && p.ImageBytes.Length > 0)
                    //        p.ImageFile = filename;
                    //}

                    id = Convert.ToInt64(rep.Add(pc));

                    if (id > 0)
                    {
                        foreach (Entity.Phrase p in pc.PhraseList)
                        {
                            if (p.SoundBytes != null && p.SoundBytes.Length > 0)
                                SaveSounds(p.SoundFile, p.SoundBytes,categoryname, p.LanguageCode);
                            if(p.ImageBytes != null && p.ImageBytes.Length > 0)
                                SaveImage(p.ImageFile, p.ImageBytes, categoryname);
                        }
                            
                    }
                }

                return id;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool AddBulkPalette(List<PaletteContract> paletteContracts, bool deleteFirstThenAdd, long phraseCategoryID)
        {
            try
            {
                bool result = false;
                PaletteRepository rep = new PaletteRepository();

                result = rep.AddBulkPalette(paletteContracts, deleteFirstThenAdd, phraseCategoryID);
                return result;
            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdatePalette(PaletteContract pc)
        {
            try
            {
                bool updated = false;
                //WordHeaderContract whc = new JavaScriptSerializer().Deserialize<WordHeaderContract>(json);
                if (pc != null)
                {
                    string json = GetPhraseCategoryDetails(pc.PhraseCategoryID);
                    PhraseCategoryHeaderContract pcc = new JavaScriptSerializer().Deserialize<PhraseCategoryHeaderContract>(json);
                    string categoryname = string.Empty;
                    if (pcc != null)
                    {
                        categoryname = pcc.FolderName;
                        //PhraseCategoryContract p = pcc.PhraseCategories.Find(x => x.LanguageCode == "en-US");
                        //if (p != null)
                        //    categoryname = p.PhraseCategoryCode;
                    }
                
                    

                    PaletteRepository rep = new PaletteRepository();
                    string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                    //string filename = whc.ImageFile.Length > 0 ? Path.GetFileNameWithoutExtension(whc.ImageFile) + "_" + guid + Path.GetExtension(whc.ImageFile) : string.Empty;
                    //whc.ImageFile = filename;
                    
                    //foreach (Entity.Sentence s in pc.SentenceList)
                    //{
                    //    string filename = !string.IsNullOrEmpty(s.SoundFile) ? Path.GetFileNameWithoutExtension(s.SoundFile) + "_" + guid + Path.GetExtension(s.SoundFile) : string.Empty;
                    //    if (s.SoundBytes != null && s.SoundBytes.Length > 0)
                    //        s.SoundFile = filename;
                    //}


                    //foreach (Entity.Phrase p in pc.PhraseList)
                    //{
                    //    string filename = !string.IsNullOrEmpty(p.SoundFile) ? Path.GetFileNameWithoutExtension(p.SoundFile) + "_" + guid + Path.GetExtension(p.SoundFile) : string.Empty;
                    //    if (p.SoundBytes != null && p.SoundBytes.Length > 0)
                    //        p.SoundFile = filename;
                    //}

                    //foreach (Entity.Phrase p in pc.PhraseList)
                    //{
                    //    string filename = !string.IsNullOrEmpty(p.ImageFile) ? Path.GetFileNameWithoutExtension(p.ImageFile) + "_" + guid + Path.GetExtension(p.ImageFile) : string.Empty;
                    //    if (p.ImageBytes != null && p.ImageBytes.Length > 0)
                    //        p.ImageFile = filename;
                    //}

                    updated = rep.Update(pc);

                    if (updated )
                    {
                        foreach (Entity.Sentence s in pc.SentenceList)
                        {
                            if (s.SoundBytes != null && s.SoundBytes.Length > 0)
                                SaveSounds(s.SoundFile, s.SoundBytes, categoryname, s.LanguageCode);
                        }

                        foreach (Entity.Phrase p in pc.PhraseList)
                        {
                            if (p.SoundBytes != null && p.SoundBytes.Length > 0)
                                SaveSounds(p.SoundFile, p.SoundBytes, categoryname, p.LanguageCode);
                            if (p.LanguageCode == "en-US")
                            {
                                if (p.ImageBytes != null && p.ImageBytes.Length > 0)
                                    SaveImage(p.ImageFile, p.ImageBytes, categoryname);
                            }
                        }

                    }
                }

                return updated;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool SaveImage(string filename, byte[] imagebyte, string category="")
        {
            bool error = false;
            string dirName = ConfigurationManager.AppSettings["ContentImagePath"];
            string finaldirectory = dirName;
            //finaldirectory = finaldirectory;// +(category.Length > 0 ? "\\" + category + "\\" : string.Empty);
            //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
            string finalfilename = filename;

            if (!Directory.Exists(finaldirectory))
                Directory.CreateDirectory(finaldirectory);


            try
            {
                Stream imgStream = new MemoryStream(imagebyte);
                Image image = Image.FromStream(imgStream);
                Bitmap bmpImage = new Bitmap(image);

                //string fileName = dirName + @"\" + photoContract.Image;

                if (!Directory.Exists(finaldirectory))
                {
                    Directory.CreateDirectory(finaldirectory);
                }

                image.Save(finaldirectory + "\\" + finalfilename);
                imgStream.Close();
                image.Dispose();
                imgStream.Dispose();
                bmpImage.Dispose();

                //UserRepository rep = new UserRepository();
                //bool success = rep.SaveImageDetails(userID, finalfilename, photoContract.Description);

                return true;

            }
            catch (FaultException fex)
            {
                error = true;
                throw fex;
            }
            catch (Exception ex)
            {
                error = true;
                throw ex;
            }
            finally
            {
                if (error)
                {
                    File.Delete(finaldirectory + "\\" + finalfilename);
                }
            }

        }

        //private bool SaveImage(WordHeaderContract wordheader)
        //{
        //    bool error = false;
        //    string dirName = ConfigurationManager.AppSettings["ContentImagePath"];
        //    string finaldirectory = dirName;
        //    //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
        //    string finalfilename = wordheader.ImageFile;

        //    try
        //    {
        //        Stream imgStream = new MemoryStream(wordheader.ImageBytes);
        //        Image image = Image.FromStream(imgStream);
        //        Bitmap bmpImage = new Bitmap(image);

        //        //string fileName = dirName + @"\" + photoContract.Image;

        //        if (!Directory.Exists(finaldirectory))
        //        {
        //            Directory.CreateDirectory(finaldirectory);
        //        }

        //        image.Save(finaldirectory + "\\" + finalfilename);
        //        imgStream.Close();

        //        //UserRepository rep = new UserRepository();
        //        //bool success = rep.SaveImageDetails(userID, finalfilename, photoContract.Description);

        //        return true;

        //    }
        //    catch (FaultException fex)
        //    {
        //        error = true;
        //        throw fex;
        //    }
        //    catch (Exception ex)
        //    {
        //        error = true;
        //        throw ex;
        //    }
        //    finally
        //    {
        //        if (error)
        //        {
        //            File.Delete(finaldirectory + "\\" + finalfilename);
        //        }
        //    }

        //}

        public bool SaveSounds(string filename, byte[] bytes, string category="" ,string languagecode = "")
        {
            bool error = false;
            string dirName = ConfigurationManager.AppSettings["SoundPath"];
            string finaldirectory = dirName + (languagecode == "en-US" ? "\\en\\" : "\\ja\\");
            finaldirectory = finaldirectory + (category.Length > 0 ? "\\" + category + "\\" : string.Empty);
            if (!Directory.Exists(finaldirectory))
                Directory.CreateDirectory(finaldirectory);

            //string dirName = ConfigurationManager.AppSettings["SoundPath"];
            

            //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
            //string finalfilename = filename + "_" + guid;

            //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
            string finalfilename = filename;

            try
            {
                using (FileStream fileStream = new System.IO.FileStream(finaldirectory + filename, System.IO.FileMode.Create, System.IO.FileAccess.Write))
                {
                    fileStream.Write(bytes, 0, bytes.Length);
                }
                return true;
            }
            catch (FaultException fex)
            {
                error = true;
                throw fex;
            }
            catch (Exception ex)
            {
                error = true;
                throw ex;
            }
            finally
            {
                if (error)
                {
                    File.Delete(finaldirectory + "\\" + finalfilename);
                }
            }
        }

        //private bool SaveSounds(string filename)
        //{
        //    bool error = false;
        //    string dirName = ConfigurationManager.AppSettings["SoundPath"];
        //    string finaldirectory = dirName;
        //    //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
        //    string finalfilename = filename;

        //    try
        //    {

        //        using (BinaryWriter binWriter = new BinaryWriter(File.Open(finaldirectory + "\\" + finalfilename, FileMode.Create)))
        //        {
        //            binWriter.Write(filename);
        //        }


        //        return true;

        //    }
        //    catch (FaultException fex)
        //    {
        //        error = true;
        //        throw fex;
        //    }
        //    catch (Exception ex)
        //    {
        //        error = true;
        //        throw ex;
        //    }
        //    finally
        //    {
        //        if (error)
        //        {
        //            File.Delete(finaldirectory + "\\" + finalfilename);
        //        }
        //    }

        //}

        //private bool SaveSounds(Entity.Phrase p)
        //{
        //    bool error = false;
        //    string dirName = ConfigurationManager.AppSettings["SoundPath"];
        //    string finaldirectory = dirName + (p.LanguageCode == "en-US" ? "\\en\\" : "\\ja\\");

        //    //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
        //    string finalfilename = p.SoundFile;

        //    try
        //    {

        //        using (BinaryWriter binWriter = new BinaryWriter(File.Open(finaldirectory + "\\" + finalfilename, FileMode.Create)))
        //        {
        //            binWriter.Write(p.SoundFile);
        //        }


        //        return true;

        //    }
        //    catch (FaultException fex)
        //    {
        //        error = true;
        //        throw fex;
        //    }
        //    catch (Exception ex)
        //    {
        //        error = true;
        //        throw ex;
        //    }
        //    finally
        //    {
        //        if (error)
        //        {
        //            File.Delete(finaldirectory + "\\" + finalfilename);
        //        }
        //    }

        //}

        //private bool SaveSounds(WordContract word)
        //{
        //    bool error = false;
        //    string dirName = ConfigurationManager.AppSettings["SoundPath"];
        //    string finaldirectory = dirName + (word.LanguageCode == "en-US" ? "\\en\\" : "\\ja\\" );

        //    //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
        //    string finalfilename = word.SoundFile;

        //    try
        //    {

        //        using (BinaryWriter binWriter = new BinaryWriter(File.Open(finaldirectory + "\\" + finalfilename, FileMode.Create)))
        //        {
        //            binWriter.Write(word.SoundFile);
        //        }


        //        return true;

        //    }
        //    catch (FaultException fex)
        //    {
        //        error = true;
        //        throw fex;
        //    }
        //    catch (Exception ex)
        //    {
        //        error = true;
        //        throw ex;
        //    }
        //    finally
        //    {
        //        if (error)
        //        {
        //            File.Delete(finaldirectory + "\\" + finalfilename);
        //        }
        //    }

        //}
        public long AddWords(WordHeaderContract whc)
        {
            try
            {
                long id = 0;
                //WordHeaderContract whc = new JavaScriptSerializer().Deserialize<WordHeaderContract>(json);
                if (whc != null)
                {
                    WordRepository rep = new WordRepository();
                    //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                    //string filename = whc.ImageFile.Length > 0 ? Path.GetFileNameWithoutExtension(whc.ImageFile) + "_" + guid + Path.GetExtension(whc.ImageFile) : string.Empty;
                    //if (whc.ImageBytes != null && whc.ImageBytes.Length > 0)
                    //    whc.ImageFile = filename;

                    //foreach (WordContract w in whc.Words)
                    //{
                    //    filename = !string.IsNullOrEmpty(w.SoundFile) ? Path.GetFileNameWithoutExtension(w.SoundFile) + "_" + guid + Path.GetExtension(w.SoundFile) : string.Empty;
                    //    if (w.SoundBytes != null && w.SoundBytes.Length > 0)
                    //    w.SoundFile = filename;
                    //}

                    id = Convert.ToInt64( rep.Add(whc));

                    if (id > 0)
                    {
                        foreach (WordContract w in whc.Words)
                        {
                            if (w.SoundBytes != null && w.SoundBytes.Length > 0)
                                SaveSounds(w.SoundFile, w.SoundBytes, w.LanguageCode);
                        }
                        if (whc.ImageBytes != null && whc.ImageBytes.Length > 0)
                            SaveImage(whc.ImageFile, whc.ImageBytes);
                    }
                }

                return id;

            }
            catch (FaultException fex)
            {
                throw fex;
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

                bool updated = new WordRepository().BulkAddWords(header, detail, deleteFirstThenAdd, phraseCategoryID);
                return updated;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateWord(WordHeaderContract whc)
        {
            try
            {
                bool updated= false;
                //WordHeaderContract whc = new JavaScriptSerializer().Deserialize<WordHeaderContract>(json);
                if (whc != null)
                {
                    WordRepository rep = new WordRepository();

                    //string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
                    //string filename = whc.ImageFile.Length > 0 ? Path.GetFileNameWithoutExtension(whc.ImageFile) + "_" + guid + Path.GetExtension(whc.ImageFile) : string.Empty;
                    //if (whc.ImageBytes != null && whc.ImageBytes.Length > 0)
                    //    whc.ImageFile = filename;

                    //foreach (WordContract w in whc.Words)
                    //{
                    //    filename = !string.IsNullOrEmpty(w.SoundFile) ? Path.GetFileNameWithoutExtension(w.SoundFile) + "_" + guid + Path.GetExtension(w.SoundFile) : string.Empty;
                    //    if (w.SoundBytes != null && w.SoundBytes.Length > 0)
                    //        w.SoundFile = filename;
                    //}

                    updated = Convert.ToBoolean(rep.Update(whc));
                    if (updated)
                    {
                        foreach (WordContract w in whc.Words)
                        {
                            if (w.SoundBytes != null &&  w.SoundBytes.Length > 0)
                                SaveSounds(w.SoundFile, w.SoundBytes);
                        }
                        if (whc.ImageBytes != null && whc.ImageBytes.Length > 0)
                            SaveImage(whc.ImageFile, whc.ImageBytes);
                    }
                }

                return updated;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteWord(long wordheaderid)
        {
            try
            {
                bool deleted = false;
                WordRepository rep = new WordRepository();
                WordHeaderContract whc = new WordHeaderContract();
                whc.WordHeaderID = wordheaderid;
                deleted = rep.Delete(whc);

                return deleted;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool DeletePalette(long paletteID)
        {
            try
            {
                bool deleted = false;
                PaletteRepository rep = new PaletteRepository();
                PaletteContract p = new PaletteContract();
                p.PaletteID = paletteID;
                deleted = rep.Delete(p);

                return deleted;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool ApprovePalette(long paletteID, long userid)
        {
            try
            {
                bool approved = false;
                PaletteRepository rep = new PaletteRepository();

                approved = rep.ApprovePalette(paletteID, userid);

                return approved;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<PaletteContract> Search(SearchDTO dto, out int virtualcount)
        {
            try
            {
                List<PaletteContract> phraselist = new List<PaletteContract>();

                PaletteRepository rep = new PaletteRepository();
                phraselist = rep.Search(dto);
                virtualcount = dto.VirtualCount;

                //string json = new JavaScriptSerializer().Serialize(phraselist);

                return phraselist;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GetPaletteSuggestion()
        {
            try
            {
                List<PaletteContract> phraselist = new List<PaletteContract>();

                PaletteRepository rep = new PaletteRepository();
                phraselist = rep.GetPaletteSuggestion();

                string json = new JavaScriptSerializer().Serialize(phraselist);

                return json;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string SearchWord(SearchDTO dto, out int virtualcount)
        {
            try
            {
                List<WordContract> wordlist = new List<WordContract>();

                PaletteRepository rep = new PaletteRepository();
                wordlist = rep.SearchWord(dto);
                virtualcount = dto.VirtualCount;
                string json = new JavaScriptSerializer().Serialize(wordlist);
                

                return json;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string SearchWordAdmin(SearchDTO dto)
        {
            try
            {
                List<WordHeaderContract> wordheaderlist = new List<WordHeaderContract>();

                WordRepository rep = new WordRepository();
                wordheaderlist = rep.SearchWordAdmin(dto);

                string json = new JavaScriptSerializer().Serialize(wordheaderlist);

                return json;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GetPhraseCategory(string languageCode, int levelid)
        {
            try
            {
                List<PhraseCategoryContract> plist = new List<PhraseCategoryContract>();

                PaletteRepository rep = new PaletteRepository();
                plist = rep.GetPhraseCategoryList(languageCode,levelid);

                string json = new JavaScriptSerializer().Serialize(plist);

                return json;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

      

        public string GetWordDetails(long wordheaderid)
        {
            try
            {
                WordHeaderContract whc = new WordHeaderContract();

                WordRepository rep = new WordRepository();
                whc = rep.GetByID(wordheaderid);

                string json = new JavaScriptSerializer().Serialize(whc);

                return json;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GetPaletteDetails(long id)
        {
            try
            {
                PaletteContract phc = new PaletteContract();

                PaletteRepository rep = new PaletteRepository();
                phc = rep.GetByID(id);

                string json = new JavaScriptSerializer().Serialize(phc);

                return json;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GetPhraseCategoryDetails(long id)
        {
            try
            {
                PhraseCategoryHeaderContract phc = new PhraseCategoryHeaderContract();

                PhraseCategoryRepository rep = new PhraseCategoryRepository();
                phc = rep.GetByID(id);

                string json = new JavaScriptSerializer().Serialize(phc);

                return json;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string SearchSuggestion(string keyword, DateTime? startdate, DateTime? enddate)
        {
            try
            {
                SuggestionRepository rep = new SuggestionRepository();
                DataSet ds= rep.Search(keyword, startdate, enddate);

                //string json = new JavaScriptSerializer().Serialize(ds);

                return ds.GetXml(); ;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public long AddSuggestion(SuggestionContract sc)
        {
            try
            {
                SuggestionRepository rep = new SuggestionRepository();
                long psid = Convert.ToInt64(rep.Add(sc));

                return psid;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateSuggestion(SuggestionContract sc)
        {
            try
            {
                SuggestionRepository rep = new SuggestionRepository();
                bool updated = rep.Update(sc);

                return updated;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteSuggestion(long paletteSuggestionID)
        {
            try
            {
                SuggestionRepository rep = new SuggestionRepository();
                SuggestionContract sc = new SuggestionContract();
                sc.PaletteSuggestionID = paletteSuggestionID;
                bool deleted = rep.Delete(sc);

                return deleted;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SuggestionContract GetSuggestionDetail(long paletteSuggestionID)
        {
            try
            {
                SuggestionContract c= new SuggestionContract();
               return c;

            }
            catch (FaultException fex)
            {
                throw fex;
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
                PaletteRepository rep = new PaletteRepository();
                bool hasfoul = rep.HasFoulWords(message);
                return hasfoul;

            }
            catch (FaultException fex)
            {
                throw fex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
