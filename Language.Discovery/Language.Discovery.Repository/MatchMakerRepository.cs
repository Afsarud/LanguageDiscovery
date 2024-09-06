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
    public class MatchMakerRepository
    {

        public int CreateNewSchedule(DateTime dt, string username, string partnername)
        {
            try
            {
                int id = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("@Date", dt));
                    paramlist.Add(new Parameter("@UserName", username));
                    paramlist.Add(new Parameter("@PartnerUserName", partnername));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_CreateNewSchedule", paramlist);
                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        id = Convert.ToInt32(pa[0].Value);
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

        public int UpdateSchedule(int scheduleId, DateTime dt, string username, string partnername)
        {
            try
            {
                int id = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("@ScheduleId", scheduleId));
                    paramlist.Add(new Parameter("@Date", dt));
                    paramlist.Add(new Parameter("@UserName", username));
                    paramlist.Add(new Parameter("@PartnerUserName", partnername));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateSchedule", paramlist);
                    scope.Complete();
                    id = scheduleId;
                }

                return id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteSchedule(int scheduleId)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("@ScheduleId", scheduleId));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteSchedule", paramlist);
                    scope.Complete();
                }

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<TimeScheduleAuxContract> GetAllTimeSchedule()
        {
            try
            {
                TimeScheduleAuxContract aux = new TimeScheduleAuxContract();

                List<TimeScheduleAuxContract> list = new List<TimeScheduleAuxContract>();
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetAllTimeSchedule", null);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<TimeScheduleAuxContract>)CollectionHelper.ConvertTo<TimeScheduleAuxContract>(ds.Tables[0]);
                }

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public List<TimeScheduleAuxContract> GetAllTime()
        {
            try
            {
                TimeScheduleAuxContract aux = new TimeScheduleAuxContract();

                List<TimeScheduleAuxContract> list = new List<TimeScheduleAuxContract>();
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetAllTime", null);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<TimeScheduleAuxContract>)CollectionHelper.ConvertTo<TimeScheduleAuxContract>(ds.Tables[0]);
                }

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
       
        public List<List<ScheduleContract>> GetScheduleByDateAndUserId(DateTime schedule, Int64 userId)
        {
            try
            {
                List<List<ScheduleContract>> listOfList = new List<List<ScheduleContract>>();
               ScheduleContract aux = new ScheduleContract();

                List<ScheduleContract> list = new List<ScheduleContract>();
                List<ScheduleContract> list2 = new List<ScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Schedule", schedule));
                paramlist.Add(new Parameter("UserId", userId));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetScheduleByDateAndUserId", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<ScheduleContract>)CollectionHelper.ConvertTo<ScheduleContract>(ds.Tables[0]);
                    list2 = (List<ScheduleContract>)CollectionHelper.ConvertTo<ScheduleContract>(ds.Tables[1]);
                    listOfList.Add(list);
                    listOfList.Add(list2);

                }
                return listOfList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public MatchContract GetMatchByScheduleId(int id)
        {
            try
            {
                ScheduleContract aux = new ScheduleContract();

                List<MatchContract> list = new List<MatchContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Id", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMatchByScheduleId", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<MatchContract>)CollectionHelper.ConvertTo<MatchContract>(ds.Tables[0]);
                }
                return list.Count() > 0 ? list[0] : null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<ScheduleContract> GetScheduleByDateAndId(DateTime schedule, Int64 userId)
        {
            try
            {
                ScheduleContract aux = new ScheduleContract();

                List<ScheduleContract> list = new List<ScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Schedule", schedule));
                paramlist.Add(new Parameter("UserId", userId));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetScheduleByDateAndId", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<ScheduleContract>)CollectionHelper.ConvertTo<ScheduleContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<ScheduleContract> GetNonMatchedScheduleByDateAndId(DateTime schedule, Int64 userId)
        {
            try
            {
                ScheduleContract aux = new ScheduleContract();

                List<ScheduleContract> list = new List<ScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Schedule", schedule));
                paramlist.Add(new Parameter("UserId", userId));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetNonMatchedScheduleByDateAndId", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<ScheduleContract>)CollectionHelper.ConvertTo<ScheduleContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public object CreateMatch(DateTime date, Int64 userId, int categoryId)
        {
            try
            {
                long id = 0;


                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("Date", date));
                    paramlist.Add(new Parameter("UserId", userId));
                    if (categoryId > 0)
                    {
                        paramlist.Add(new Parameter("CategoryId", categoryId));
                    }
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_CreateMatch", paramlist);
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

        public bool CancelSchedule(DateTime date, Int64 userId)
        {
            try
            {
                int affected = 0;
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("Date", date));
                    paramlist.Add(new Parameter("UserId", userId));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_CancelSchedule", paramlist);
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

        public List<ScheduleContract> GetScheduleByUserId(Int64 id)
        {
            try
            {
                ScheduleContract aux = new ScheduleContract();

                List<ScheduleContract> list = new List<ScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserId", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetScheduleByUserId", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<ScheduleContract>)CollectionHelper.ConvertTo<ScheduleContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ScheduleContract> GetMySchedule(Int64 id)
        {
            try
            {
                ScheduleContract aux = new ScheduleContract();

                List<ScheduleContract> list = new List<ScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserId", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMySchedule", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<ScheduleContract>)CollectionHelper.ConvertTo<ScheduleContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ScheduleContract> GetPartnerToDisplayInTalk(Int64 id)
        {
            try
            {
                ScheduleContract aux = new ScheduleContract();

                List<ScheduleContract> list = new List<ScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserId", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetPartnerToDisplayInTalk", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<ScheduleContract>)CollectionHelper.ConvertTo<ScheduleContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserFrequencyContract> GetUserAvailablePerMonth (Int64 id)
        {
            try
            {
                List<UserFrequencyContract> list = new List<UserFrequencyContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserId", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserAvailablePerMonth", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<UserFrequencyContract>)CollectionHelper.ConvertTo<UserFrequencyContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ScheduleContractExt> GetScheduleForAdmin(DateTime? from, DateTime? to)
        {
            try
            {
                List<ScheduleContractExt> list = new List<ScheduleContractExt>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("From", from));
                paramlist.Add(new Parameter("To", to));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetScheduleForAdmin", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<ScheduleContractExt>)CollectionHelper.ConvertTo<ScheduleContractExt>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CustomScheduleContract> GetCustomSchedule(DateTime? from, DateTime? to)
        {
            try
            {
                List<CustomScheduleContract> list = new List<CustomScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Startdate", from));
                paramlist.Add(new Parameter("Enddate", to));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCustomSchedule", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<CustomScheduleContract>)CollectionHelper.ConvertTo<CustomScheduleContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<CustomScheduleContract> GetCustomScheduleByDate(DateTime date)
        {
            try
            {
                List<CustomScheduleContract> list = new List<CustomScheduleContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Date", date));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetCustomScheduleByDate", paramlist);
                if (ds != null && ds.Tables.Count > 0)
                {
                    list = (List<CustomScheduleContract>)CollectionHelper.ConvertTo<CustomScheduleContract>(ds.Tables[0]);
                }
                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool InsertUpdateSchedule(DateTime dt, string timeIds)
        {
            try
            {
                long id = 0;

                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("@Date", dt));
                    paramlist.Add(new Parameter("@Timeids", timeIds));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUpdateCustomSchedule", paramlist);
                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        id = Convert.ToInt64(pa[0].Value);
                        scope.Complete();
                    }
                }

                return id > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool DeleteCustomSchedule(DateTime date)
        {
            try
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("@Date", date));
                    int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteCustomSchedule", paramlist);
                    scope.Complete();
                }

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int Confirm(Guid guid, bool isConfirmed, long userId)
        {
            try
            {
                int id = 0;

                int affected = 0;
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("Token", guid));
                    paramlist.Add(new Parameter("IsConfirmed", isConfirmed));
                    paramlist.Add(new Parameter("UserID", userId));
                    paramlist.Add(new Parameter("ID", null, ParameterDirection.Output));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_ConfirmSchedule", paramlist);
                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        id = Convert.ToInt32(pa[0].Value);
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

        public bool UpdateTalkTime(string username, int time,string partnerusername, int partnertime )
        {
            try
            {
                int affected = 0;
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("UserName", username));
                    paramlist.Add(new Parameter("SessionTime", time));
                    paramlist.Add(new Parameter("PartnerUserName", partnerusername));
                    paramlist.Add(new Parameter("PartnerSessionTime", partnertime));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateTalkSessionTimeByUserName", paramlist);
                    scope.Complete();
                }

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }

        public bool SaveTalkMatchingComment (int scheduleid, string comment, string userColor, string partnerColor)
        {
            try
            {
                int affected = 0;
                using (TransactionScope scope = new TransactionScope())
                {
                    List<Parameter> paramlist = new List<Parameter>();
                    paramlist.Add(new Parameter("ScheduleID", scheduleid));
                    paramlist.Add(new Parameter("Comment", comment));
                    paramlist.Add(new Parameter("UserColor", userColor));
                    paramlist.Add(new Parameter("PartnerColor", partnerColor));
                    affected = DatabaseHelper.ExecuteNonQuery("usp_SaveComment", paramlist);
                    scope.Complete();
                }

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
    }
}
