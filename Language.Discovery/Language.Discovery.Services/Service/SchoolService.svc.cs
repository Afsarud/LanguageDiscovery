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


namespace Language.Discovery.Services.Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "SchoolService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select SchoolService.svc or SchoolService.svc.cs at the Solution Explorer and start debugging.
    public class SchoolService : ISchoolService
    {

        public int AddSchool(SchoolContract tObject)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                int schoolid = Convert.ToInt32(rep.Add(tObject));

                return schoolid;

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

        public bool UpdateSchool(SchoolContract tObject)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                
                return rep.Update(tObject);
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

        public bool DeleteSchool(int id)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                SchoolContract sc = new SchoolContract();
                sc.SchoolID = id;

                return rep.Delete(sc);
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

        public SchoolContract GetByID(long id)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();

                return rep.GetByID(id);
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

        public string SearchSchool(SearchSchoolDTO tObject, out int virtualcount)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                var list = rep.Search(tObject);
                virtualcount = tObject.VirtualCount;
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

        public List<UserMessageContract> GetUnreadMessageForReview(long schoolid, long userid)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                var list = rep.GetUnreadMessageForReview(schoolid, userid);
                
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

        public List<UserMessageContract> GetAllMessages(MessageSearchDTO dto, out int virtualcount)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                var list = rep.GetAllMessages(dto);
                virtualcount = dto.VirtualCount;

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

        public bool SetMessageAsReviewed(long usermailid, long userid, string feedbackmessage, bool isFeedback = false)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                bool updated = rep.SetMessageAsReviewed(usermailid, userid, feedbackmessage,isFeedback);

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

        public bool SetMessageStatus(string xml, long userid, string feedbackmessage, bool statusid, bool isFeedback = false)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                bool updated = rep.SetMessageStatus(xml, userid, feedbackmessage, statusid, isFeedback);

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

        public bool SetMessageAsRejected(long usermailid, long userid)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                bool updated = rep.SetMessageAsRejected(usermailid, userid);

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
        public List<SchoolTypeContract> GetSchoolTypeList()
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                var list = rep.GetSchoolTypeList();

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

        public List<UserMessageContract> GetUnreadMessageForPolling(long schoolid, long userid)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                var list = rep.GetUnreadMessageForPooling(schoolid, userid);

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

        public List<FreeMessageContract> GetAllFreeMessages(MessageSearchDTO dto, out int virtualcount)
        {
            try
            {
                SchoolRepository rep = new SchoolRepository();
                var list = rep.GetAllFreeMessages(dto);
                virtualcount = dto.VirtualCount;

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