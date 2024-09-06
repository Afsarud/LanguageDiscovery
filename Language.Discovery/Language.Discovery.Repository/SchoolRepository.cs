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
    public class SchoolRepository : IRepository<SchoolContract>
    {
        public object Add(SchoolContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolCode", tObject.SchoolCode));
                paramlist.Add(new Parameter("Name1", tObject.Name1));
                paramlist.Add(new Parameter("Name2", tObject.Name2));
                paramlist.Add(new Parameter("SchoolTypeID", tObject.SchoolTypeID));
                paramlist.Add(new Parameter("CountryID", tObject.CountryID));
                paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                paramlist.Add(new Parameter("Address", tObject.Address));
                paramlist.Add(new Parameter("Telephone", tObject.Telephone));
                paramlist.Add(new Parameter("Url", tObject.Url));
                paramlist.Add(new Parameter("Email", tObject.Email));
                paramlist.Add(new Parameter("PreparedBy", tObject.PreparedBy));
                paramlist.Add(new Parameter("Password", tObject.Password));
                paramlist.Add(new Parameter("License", tObject.License));
                paramlist.Add(new Parameter("StartTime", tObject.StartTime));
                paramlist.Add(new Parameter("EndTime", tObject.EndTime));
                paramlist.Add(new Parameter("CreatedBy", tObject.CreatedBy));
                paramlist.Add(new Parameter("ModifiedBy", tObject.ModifiedBy));
                paramlist.Add(new Parameter("MailCheck", tObject.MailCheck));
                paramlist.Add(new Parameter("ShowPhraseOrder", tObject.ShowPhraseOrder));
                paramlist.Add(new Parameter("ShowNativeLanguage", tObject.ShowNativeLanguage));
                paramlist.Add(new Parameter("AfterSchool", tObject.AfterSchool));
                paramlist.Add(new Parameter("SchoolPalette", tObject.SchoolPallete));
                paramlist.Add(new Parameter("SchoolKey", tObject.SchoolKey));
                paramlist.Add(new Parameter("DefaultLanguageOrder", tObject.DefaultLanguageOrder));
                paramlist.Add(new Parameter("ShowSubLanguage2", tObject.ShowSubLanguage2));
                paramlist.Add(new Parameter("AllowSameCountry", tObject.AllowSameCountry));
                paramlist.Add(new Parameter("NativeLanguage", tObject.NativeLanguage));
                paramlist.Add(new Parameter("LearningLanguage", tObject.LearningLanguage));
                paramlist.Add(new Parameter("SendPasswordToTeacher", tObject.SendPasswordToTeacher));
                paramlist.Add(new Parameter("TeachersEmail", tObject.TeachersEmail));
                paramlist.Add(new Parameter("ShowRomanji", tObject.ShowRomanji));
                paramlist.Add(new Parameter("EnabledFreeMessage", tObject.EnabledFreeMessage));
                paramlist.Add(new Parameter("SoundAndMail", tObject.SoundAndMail));
                paramlist.Add(new Parameter("OrderByLearningLanguageFlag", tObject.OrderByLearningLanguageFlag));
                paramlist.Add(new Parameter("TalkTime", tObject.TalkTime));
                paramlist.Add(new Parameter("AllowTalk", tObject.AllowTalk));
                paramlist.Add(new Parameter("LinkKey", tObject.LinkKey));
                paramlist.Add(new Parameter("EnableParentInfo", tObject.EnableParentInfo));
                paramlist.Add(new Parameter("ID", 0, DbType.Int32, ParameterDirection.Output));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertSchool", paramlist);
                int schoolid = 0;
                if (affected > 0)
                {
                    List<Parameter> output = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (output != null)
                    {
                        schoolid = Convert.ToInt32(output[0].Value);
                    }

                }

                return schoolid;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(SchoolContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", tObject.SchoolID));
                paramlist.Add(new Parameter("SchoolCode", tObject.SchoolCode));
                paramlist.Add(new Parameter("Name1", tObject.Name1));
                paramlist.Add(new Parameter("Name2", tObject.Name2));
                paramlist.Add(new Parameter("SchoolTypeID", tObject.SchoolTypeID));
                paramlist.Add(new Parameter("CountryID", tObject.CountryID));
                paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                paramlist.Add(new Parameter("Address", tObject.Address));
                paramlist.Add(new Parameter("Telephone", tObject.Telephone));
                paramlist.Add(new Parameter("Url", tObject.Url));
                paramlist.Add(new Parameter("Email", tObject.Email));
                paramlist.Add(new Parameter("PreparedBy", tObject.PreparedBy));
                paramlist.Add(new Parameter("Password", tObject.Password));
                paramlist.Add(new Parameter("License", tObject.License));
                paramlist.Add(new Parameter("StartTime", tObject.StartTime));
                paramlist.Add(new Parameter("EndTime", tObject.EndTime));
                paramlist.Add(new Parameter("ModifiedBy", tObject.ModifiedBy));
                paramlist.Add(new Parameter("MailCheck", tObject.MailCheck));
                paramlist.Add(new Parameter("ShowPhraseOrder", tObject.ShowPhraseOrder));
                paramlist.Add(new Parameter("ShowNativeLanguage", tObject.ShowNativeLanguage));
                paramlist.Add(new Parameter("AfterSchool", tObject.AfterSchool));
                paramlist.Add(new Parameter("SchoolPalette", tObject.SchoolPallete));
                paramlist.Add(new Parameter("SchoolKey", tObject.SchoolKey));
                paramlist.Add(new Parameter("DefaultLanguageOrder", tObject.DefaultLanguageOrder));
                paramlist.Add(new Parameter("ShowSubLanguage2", tObject.ShowSubLanguage2));
                paramlist.Add(new Parameter("AllowSameCountry", tObject.AllowSameCountry));
                paramlist.Add(new Parameter("NativeLanguage", tObject.NativeLanguage));
                paramlist.Add(new Parameter("LearningLanguage", tObject.LearningLanguage));
                paramlist.Add(new Parameter("SendPasswordToTeacher", tObject.SendPasswordToTeacher));
                paramlist.Add(new Parameter("TeachersEmail", tObject.TeachersEmail));
                paramlist.Add(new Parameter("ShowRomanji", tObject.ShowRomanji));
                paramlist.Add(new Parameter("EnabledFreeMessage", tObject.EnabledFreeMessage));
                paramlist.Add(new Parameter("SoundAndMail", tObject.SoundAndMail));
                paramlist.Add(new Parameter("OrderByLearningLanguageFlag", tObject.OrderByLearningLanguageFlag));
                paramlist.Add(new Parameter("TalkTime", tObject.TalkTime));
                paramlist.Add(new Parameter("AllowTalk", tObject.AllowTalk));
                paramlist.Add(new Parameter("LinkKey", tObject.LinkKey));
                paramlist.Add(new Parameter("EnableParentInfo", tObject.EnableParentInfo));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateSchool", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(SchoolContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", tObject.SchoolID));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteSchool", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public SchoolContract GetByID(Int64 id)
        {
            try
            {
                List<SchoolContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetSchoolByID", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<SchoolContract>)CollectionHelper.ConvertTo<SchoolContract>(ds.Tables[0]);
                }

                return (msg != null) ? msg[0] : null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SchoolContract> Search(SearchSchoolDTO tObject)
        {
            try
            {
                List<SchoolContract> schools = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("RowsPerPage", tObject.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", tObject.PageNumber));
                paramlist.Add(new Parameter("SchoolCode", tObject.SchoolCode));
                paramlist.Add(new Parameter("Name1", tObject.Name1));
                paramlist.Add(new Parameter("Name2", tObject.Name2));
                paramlist.Add(new Parameter("CountryID", tObject.CountryID));
                paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
               paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchSchool", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    schools = (List<SchoolContract>)CollectionHelper.ConvertTo<SchoolContract>(ds.Tables[0]);

                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        tObject.VirtualCount = Convert.ToInt32(pa[0].Value);
                    }
                }

                return schools;
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
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolid));
                paramlist.Add(new Parameter("SenderID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUnreadMessageForReview", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<UserMessageContract>)CollectionHelper.ConvertTo<UserMessageContract>(ds.Tables[0]);
                }

                return msg;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserMessageContract> GetAllMessages(MessageSearchDTO dto)
        {
            try
            {
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("RowsPerPage", dto.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", dto.PageNumber));
                paramlist.Add(new Parameter("SchoolID", dto.SchoolID));
                paramlist.Add(new Parameter("Sender", dto.Sender ));
                paramlist.Add(new Parameter("Recepient", dto.Recepient));
                if( dto.StartDate.HasValue  )
                    paramlist.Add(new Parameter("StartDate", dto.StartDate.Value));
                if (dto.EndDate.HasValue)
                    paramlist.Add(new Parameter("EndDate", dto.EndDate.Value));

                paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetAllMessages", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<UserMessageContract>)CollectionHelper.ConvertTo<UserMessageContract>(ds.Tables[0]);
                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        dto.VirtualCount = Convert.ToInt32(pa[0].Value);
                    }
                }

                return msg;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<FreeMessageContract> GetAllFreeMessages(MessageSearchDTO dto)
        {
            try
            {
                List<FreeMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("RowsPerPage", dto.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", dto.PageNumber));
                paramlist.Add(new Parameter("SchoolID", dto.SchoolID));
                paramlist.Add(new Parameter("UserName", dto.UserName));
                paramlist.Add(new Parameter("FirstName", dto.FirstName));
                paramlist.Add(new Parameter("LastName", dto.LastName));
                paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetAllFreeMessages", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<FreeMessageContract>)CollectionHelper.ConvertTo<FreeMessageContract>(ds.Tables[0]);
                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        dto.VirtualCount = Convert.ToInt32(pa[0].Value);
                    }
                }

                return msg;
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
                bool updated = false;
                //List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserMailID", usermailid));
                paramlist.Add(new Parameter("UserID", userid));
                paramlist.Add(new Parameter("IsFeedBack", isFeedback));
                paramlist.Add(new Parameter("FeedbackMessage", feedbackmessage));
                using (TransactionScope scope = new TransactionScope())
                {
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_SetMessageAsReviewed", paramlist);
                    if (affected > 0)
                    {
                        updated = true;
                        scope.Complete();
                    }
                }

                return updated;
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
                bool updated = false;
                //List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("xml", xml));
                paramlist.Add(new Parameter("UserID", userid));
                paramlist.Add(new Parameter("IsFeedBack", isFeedback));
                paramlist.Add(new Parameter("StatusId", statusid));
                paramlist.Add(new Parameter("FeedbackMessage", feedbackmessage));
                using (TransactionScope scope = new TransactionScope())
                {
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_SetMessageStatus", paramlist);
                    if (affected > 0)
                    {
                        updated = true;
                        scope.Complete();
                    }
                }

                return updated;
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
                bool updated = false;
                //List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserMailID", usermailid));
                paramlist.Add(new Parameter("UserID", userid));
                using (TransactionScope scope = new TransactionScope())
                {
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_SetMessageAsRejected", paramlist);
                    if (affected > 0)
                    {
                        updated = true;
                        scope.Complete();
                    }
                }

                return updated;
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
                List<SchoolTypeContract> types = null;
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetSchoolTypeList",null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    types = (List<SchoolTypeContract>)CollectionHelper.ConvertTo<SchoolTypeContract>(ds.Tables[0]);
                }

                return types;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<UserMessageContract> GetUnreadMessageForPooling(long schoolid, long userid)
        {
            try
            {
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolid));
                paramlist.Add(new Parameter("SenderID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUnreadMessageForPolling", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<UserMessageContract>)CollectionHelper.ConvertTo<UserMessageContract>(ds.Tables[0]);
                }

                return msg;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateSchoolTalkTime(int id, int talkTime)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", id));
                paramlist.Add(new Parameter("TalkTime", talkTime));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateSchoolTotalTime", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}