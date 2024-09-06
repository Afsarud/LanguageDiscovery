using Language.Discovery.Entity;
using Language.Discovery.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Web.Script.Serialization;
using System.Data;
using System.IO;
using System.Drawing;
using System.Configuration;

namespace Language.Discovery.Services.Service
{
    public class AuxilliaryServices : IAuxilliaryServices
    {
        public long AddPhraseCategory(PhraseCategoryHeaderContract phc)
        {
            try
            {
                long id = 0;
                if (phc != null)
                {
                    PhraseCategoryRepository rep = new PhraseCategoryRepository();
                    id = Convert.ToInt64(rep.Add(phc));
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

        public bool UpdatePhraseCategory(PhraseCategoryHeaderContract phc)
        {
            try
            {
                bool updated = false;
                if (phc != null)
                {
                    PhraseCategoryRepository rep = new PhraseCategoryRepository();
                    updated = Convert.ToBoolean(rep.Update(phc));
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

        public bool DeletePhraseCategory(long id)
        {
            try
            {
                bool deleted = false;
                PhraseCategoryRepository rep = new PhraseCategoryRepository();
                PhraseCategoryHeaderContract phc = new PhraseCategoryHeaderContract();
                phc.PhraseCategoryHeaderID = id;
                deleted = rep.Delete(phc);

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

        public string SearchPhraseCategory(string languagecode, string category, int levelid, long schoolid)
        {
            try
            {
                List<PhraseCategoryHeaderContract> pchlist = new List<PhraseCategoryHeaderContract>();

                PhraseCategoryRepository rep = new PhraseCategoryRepository();
                pchlist = rep.SearchPhraseCategory(languagecode, category, levelid, schoolid);

                string json = new JavaScriptSerializer().Serialize(pchlist);

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

        public string GetPhraseCategoryListToOrder(string languageCode, int levelid)
        {
            try
            {
                List<PhraseCategoryContract> plist = new List<PhraseCategoryContract>();

                PhraseCategoryRepository rep = new PhraseCategoryRepository();
                plist = rep.GetPhraseCategoryListToOrder(languageCode, levelid);

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

        public bool UpdatePhraseCategoryOrder(string xml)
        {
            try
            {
                bool updated = false;
                if (!string.IsNullOrEmpty(xml))
                {
                    PhraseCategoryRepository rep = new PhraseCategoryRepository();
                    updated = rep.UpdateCategoryOrder(xml);
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

        public long AddInfo(InfoContract ic)
        {
            try
            {
                long id = 0;
                InfoRepository rep = new InfoRepository();

                id = Convert.ToInt64( rep.Add(ic));

                if (ic.ImageBytes != null && ic.ImageBytes.Length > 0)
                    SaveImage(ic.ImageFile, ic.ImageBytes);

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

        public bool UpdateInfo(InfoContract ic)
        {
            try
            {
                bool updated = false;
                InfoRepository rep = new InfoRepository();

                updated = rep.Update(ic);
                if (ic.ImageBytes != null && ic.ImageBytes.Length > 0)
                    SaveImage(ic.ImageFile, ic.ImageBytes);


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

        public bool DeleteInfo(long id)
        {
            try
            {
                bool deleted = false;
                InfoRepository rep = new InfoRepository();
                InfoContract c = new InfoContract();
                c.InfoID = id;
                deleted = rep.Delete(c);

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

        public InfoContract GetInfoByID(long id)
        {
            try
            {
                InfoContract info = new InfoContract();
                InfoRepository rep = new InfoRepository();

                info = rep.GetByID(id);

                return info;

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

        public List<InfoContract> SearchInfo(SearchInfoDTO dto, out int virtualcount)
        {
            try
            {
                List<InfoContract> infos = new List<InfoContract>();
                InfoRepository rep = new InfoRepository();

                infos = rep.Search(dto);

                virtualcount = dto.VirtualCount;
                return infos;

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

        public InfoContract GetInfoByType(string type)
        {
            try
            {
                InfoContract info = new InfoContract();
                InfoRepository rep = new InfoRepository();

                info = rep.GetInfoByType(type);

                return info;

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

        //-----------------------



        public long AddFilter(FilterContract fc)
        {
            try
            {
                long id = 0;
                FilterRepository rep = new FilterRepository();

                id = Convert.ToInt64(rep.Add(fc));

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

        public bool UpdateFilter(FilterContract fc)
        {
            try
            {
                bool updated = false;
                FilterRepository rep = new FilterRepository();

                updated = rep.Update(fc);

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

        public bool DeleteFilter(long id)
        {
            try
            {
                bool deleted = false;
                FilterRepository rep = new FilterRepository();
                FilterContract f = new FilterContract();
                f.FilterID = id;
                deleted = rep.Delete(f);

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

        public FilterContract GetFilterByID(long id)
        {
            try
            {
                FilterContract info = new FilterContract();
                FilterRepository rep = new FilterRepository();

                info = rep.GetByID(id);

                //string json = new JavaScriptSerializer().Serialize(info);

                return info;

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

        public string SearchFilter(string filtername)
        {
            try
            {
                List<FilterContract> infos = new List<FilterContract>();
                FilterRepository rep = new FilterRepository();

                infos = rep.Search(filtername);
                string json = new JavaScriptSerializer().Serialize(infos);
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

        public string GetClassList(int schoolid)
        {
            try
            {
                ClassRepository rep = new ClassRepository();
                List<ClassContract> list = rep.GetClassList(schoolid);
                string json = new JavaScriptSerializer().Serialize(list);
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

        public ClassContract GetClassByID(long id)
        {
            try
            {
                ClassRepository rep = new ClassRepository();
                ClassContract cc = rep.GetByID(id);
                //string json = new JavaScriptSerializer().Serialize(list);
                return cc;
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

        public bool DeleteClass(int classid)
        {
            try
            {
                bool deleted = false;
                ClassRepository rep = new ClassRepository();
                ClassContract c = new ClassContract();
                c.ClassID = classid;
                deleted = rep.Delete(c);

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

        public bool UpdateClass(ClassContract cc)
        {
            try
            {
                bool updated = false;
                ClassRepository rep = new ClassRepository();

                updated = rep.Update(cc);

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

        public int AddClass(ClassContract cc)
        {
            try
            {
                int id = 0;
                ClassRepository rep = new ClassRepository();

                id = Convert.ToInt32(rep.Add(cc));

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

        public string SearchClass(string classname, int schoolID)
        {
            try
            {
                List<ClassContract> infos = new List<ClassContract>();
                ClassRepository rep = new ClassRepository();

                DataSet ds = rep.Search(classname, schoolID);
                //string json = new JavaScriptSerializer().Serialize(infos);
                return ds.GetXml();

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

        private bool SaveImage(string filename, byte[] imagebyte, string category = "")
        {
            bool error = false;
            string dirName = ConfigurationManager.AppSettings["ContentImagePath"] + "\\Info";
            string finaldirectory = dirName;
            finaldirectory = finaldirectory + (category.Length > 0 ? "\\" + category + "\\" : string.Empty);
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

        public List<GradeContract> GetGradeList()
        {
            try
            {
                MiscRepository rep = new MiscRepository();
                List<GradeContract> list = rep.GetGradeList();
                //string json = new JavaScriptSerializer().Serialize(list);
                return list;
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
