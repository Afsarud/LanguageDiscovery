using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Http;
using Language.Discovery.Entity;
using Language.Discovery.Entity.Contract;
using Language.Discovery.Repository;

namespace Language.Discovery.Controller
{
    public class MatchMakerController : ApiController
    {
        [HttpGet]
        [Route("api/MatchMaker/GetAllTimeSchedule/{date}")]
        public IEnumerable<TimeScheduleAuxContract> GetAllTimeSchedule(DateTime date)
        {
            MatchMakerRepository rep = new MatchMakerRepository();
            //foreach (TimeZoneInfo z in TimeZoneInfo.GetSystemTimeZones())
            //    System.Diagnostics.Debug.WriteLine(z.Id);

            List<List<ScheduleContract>> listOfList = rep.GetScheduleByDateAndUserId(date, SessionManager.Instance.UserProfile.UserID);
            List<ScheduleContract> scheduleList = listOfList[0];
            List<ScheduleContract> scheduleListAux = listOfList[1];

            List<TimeScheduleAuxContract> listAux = rep.GetAllTimeSchedule();
            List<TimeScheduleAuxContract> list = listAux.FindAll(x => x.CustomDate == Convert.ToDateTime(date.ToString("yyyy-MM-dd") + " 12:00:00 AM")  
                                                                &&   Convert.ToDateTime(date.ToString("yyyy-MM-dd") + " " + x.TimeSchedule.PadLeft(5,'0')) > DateTime.Now);

            //List<TimeScheduleAuxContract> list = listAux.FindAll(x => x.CountryIds.Contains(SessionManager.Instance.UserProfile.CountryID.ToString())
            //    && Convert.ToDateTime(date.ToString("yyyy-MM-dd") + " " + x.TimeSchedule) > DateTime.Now);
            foreach (TimeScheduleAuxContract info in list)
            {
                DateTime current = DateTime.Parse(date.Date.ToString("yyyy-MM-dd") + " " + info.TimeSchedule);
                info.ActualDateTime = current;
                List<ScheduleContract> schedules = null;
                if (SessionManager.Instance.UserProfile.GradeID == 13)//Youth
                {
                    schedules = scheduleList.FindAll(x => x.Schedule.Equals(current) && !x.PartnerId.HasValue && x.UserId != SessionManager.Instance.UserProfile.UserID
                        && IsWithin(x.GradeID, 8, 13) && x.MatchedCount < x.NumberOfMatching);
                }
                else
                {
                    schedules = scheduleList.FindAll(x => x.Schedule.Equals(current) && !x.PartnerId.HasValue && x.UserId != SessionManager.Instance.UserProfile.UserID
                        && IsWithin(SessionManager.Instance.UserProfile.GradeID, x.GradeID - 2, x.GradeID + 2) && x.MatchedCount < x.NumberOfMatching);
                }
                
                if (schedules != null && schedules.Count() > 0)
                {
                    info.SlotsAvailable = schedules.Count().ToString();
                    info.HasMatched = true;
                }
                else
                {
                    info.SlotsAvailable = "0";
                    info.HasMatched = false;
                }
                schedules = scheduleList.FindAll(x => x.Schedule.Equals(current) && (x.UserId.Equals(SessionManager.Instance.UserProfile.UserID) || x.PartnerId.Equals(SessionManager.Instance.UserProfile.UserID)));
                if (schedules != null && schedules.Count() > 0)
                {
                    info.HasSchedule = true;
                }

                List<ScheduleContract> schedulesAux = scheduleListAux.FindAll(x => (x.Schedule.Month == current.Month && x.Schedule.Year == current.Year) && (x.PartnerId.HasValue && (x.PartnerId.Equals(SessionManager.Instance.UserProfile.UserID)
                       || x.UserId.Equals(SessionManager.Instance.UserProfile.UserID))));
                if (schedulesAux.Count() >= SessionManager.Instance.UserProfile.NumberOfMatching)
                {
                    //info.SlotsAvailable = "0";
                    info.HasMatched = false;
                    info.DisableRegisterButton = true;
                }
                List<ScheduleContract> booked = scheduleList.FindAll(x => x.Schedule.Equals(current) && x.PartnerId.HasValue && (x.UserId == SessionManager.Instance.UserProfile.UserID
                             || x.PartnerId == SessionManager.Instance.UserProfile.UserID));
                if(booked != null && booked.Count() > 0)
                {
                    info.HasPartner = true;
                }


                string time = current.ToString("HH:mm") + "(JP)";
                DateTime dt;
                if (SessionManager.Instance.UserProfile.CountryCode == "GB" || SessionManager.Instance.UserProfile.CountryCode == "UK")
                {
                    var uk = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    dt = ConvertDateToTimezone(uk, current);
                    time = dt.ToString("HH:mm") + "(UK)";
                }
                else if (SessionManager.Instance.UserProfile.CountryCode == "AU")
                {
                    //If you are converting for Queensland, use "E. Australia Standard Time".
                    //If you are converting for New South Wales, use "AUS Eastern Standard Time".
                    //var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    //dt = ConvertDateToTimezone(aest, current);
                    //time = dt.ToString("HH:mm") + (aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

                    ////bool isDisplayACT = Convert.ToBoolean(ConfigurationManager.AppSettings["DisplayACT"]);
                    ////if (isDisplayACT)
                    ////{
                    //    var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    //    dt = ConvertDateToTimezone(acst, current);
                    //    time += "/" + dt.ToString("HH:mm") + (acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

                    //    var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    //    dt = ConvertDateToTimezone(qld, current);
                    //    time += "<br>" + dt.ToString("HH:mm") + "(AEST)";

                    //    var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    //    dt = ConvertDateToTimezone(awst, current);
                    //    time += "/" + dt.ToString("HH:mm") + "(AWST)";
                    //}
                    //------------------------------

                    var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    dt = ConvertDateToTimezone(awst, current);
                    time = dt.ToString("HH:mm") + "(WA)";

                    var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    dt = ConvertDateToTimezone(qld, current);
                    time += "/" + dt.ToString("HH:mm") + "(QLD)"; //AEST

                    var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    dt = ConvertDateToTimezone(acst, current);
                    time += "<br/>" + dt.ToString("HH:mm") + "(SA)";//(acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

                    var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    dt = ConvertDateToTimezone(aest, current);
                    time += "/" + dt.ToString("HH:mm") + "(VIC)";//(aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

                    //bool isDisplayACT = Convert.ToBoolean(ConfigurationManager.AppSettings["DisplayACT"]);
                    //if (isDisplayACT)
                    //{


                    //}


                }
                info.TimeSchedule = time;
            }
            return list;
        }

        private bool IsWithin(int value, int minimum, int maximum)
        {
            return value >= minimum && value <= maximum;
        }

        [HttpGet]
        [Route("api/MatchMaker/GetAllTimeScheduleForTalkDisplay")]
        public IEnumerable<TimeScheduleAuxContract> GetAllTimeScheduleForTalkDisplay()
        {
            MatchMakerRepository rep = new MatchMakerRepository();
            List<TimeScheduleAuxContract> list = rep.GetAllTimeSchedule();

            foreach (TimeScheduleAuxContract info in list)
            {
                DateTime current = DateTime.Parse(info.CustomDate.ToString("yyyy-MM-dd") + " " + info.TimeSchedule);

                string time = current.ToString("hh:mm tt") + "(JP)";
                DateTime dt;
                if (SessionManager.Instance.UserProfile.CountryCode == "GB" || SessionManager.Instance.UserProfile.CountryCode == "UK")
                {
                    var uk = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    dt = ConvertDateToTimezone(uk, current);
                    time = dt.ToString("hh:mm tt") + "(UK)";
                }
                else if (SessionManager.Instance.UserProfile.CountryCode == "AU")
                {
                    var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    dt = ConvertDateToTimezone(aest, current);
                    time = dt.ToString("hh:mm tt") + (aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

                    //bool isDisplayACT = Convert.ToBoolean(ConfigurationManager.AppSettings["DisplayACT"]);
                    //if (isDisplayACT)
                    //{
                        var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                        dt = ConvertDateToTimezone(acst, current);
                        time += "/" + dt.ToString("hh:mm tt") + (acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

                        var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                        dt = ConvertDateToTimezone(awst, current);
                        time += "<br/>" + dt.ToString("hh:mm tt") + "(AWST)";
                    //}

                }
                info.TimeSchedule = time;
            }
            return list;
        }

        [HttpGet]
        [Route("api/MatchMaker/GetScheduleByDateAndId/{schedule}/{userId}")]
        public IEnumerable<ScheduleContract> GetScheduleByDateAndId(DateTime schedule, int userId)
        {
            MatchMakerRepository rep = new MatchMakerRepository();
            return rep.GetScheduleByDateAndId(schedule, userId);
        }

        [HttpGet]
        [Route("api/MatchMaker/CreateMatch/{schedule=schedule}/{userId=userId}/{categoryId=categoryId}")]
        public MatchContract CreateMatch(DateTime? schedule = null, int userId = 0, int categoryId = 0)
        {
            
            MatchMakerRepository rep = new MatchMakerRepository();
            int id = Convert.ToInt32(rep.CreateMatch(schedule.Value, userId, categoryId));
            
            MatchContract match = null;
            if (id > 0)
            {
                
                match = rep.GetMatchByScheduleId(id);
                bool isMain = SessionManager.Instance.UserProfile.UserID == match.UserId;
                CreateTicket(match, isMain);
                //ConfirmSchedule(match, isMain);
                if(match.PartnerId > 0)
                {
                    CreateTicket(match, !isMain);
                }
            }
            return match;
        }

        [HttpGet]
        [Route("api/MatchMaker/CancelSchedule/{schedule=schedule}/{userId=userId}")]
        public IEnumerable<MatchContract> CancelSchedule(DateTime? schedule = null, int userId = 0)
        {
            MatchMakerRepository rep = new MatchMakerRepository();
            bool result = rep.CancelSchedule(schedule.Value, userId);
            List<MatchContract> list = null;
            if (result)
            {
                EmailCancelSchedule(schedule);
            }

            //Email

            return list;
        }

        [HttpGet]
        [Route("api/MatchMaker/GetScheduleByUserId/{schedule}/{userId}")]
        public IEnumerable<ScheduleContract> GetScheduleByUserId(DateTime schedule, int userId)
        {
            MatchMakerRepository rep = new MatchMakerRepository();
            List<ScheduleContract>  list = rep.GetMySchedule(userId);
            List<ScheduleContract> finalList = new List<ScheduleContract>();
            foreach (ScheduleContract info in list)
            {
                if (info.ScheduleId == 0)
                    continue;
                string time = "";
                DateTime dt = DateTime.Now;
                if (SessionManager.Instance.UserProfile.CountryCode == "JP")
                {
                    time = info.Schedule.ToString("MMM dd dddd/HH:mm") + "(JP)";
                }
                else if (SessionManager.Instance.UserProfile.CountryCode == "UK")
                {
                    var uk = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    dt = ConvertDateToTimezone(uk, info.Schedule);
                    time = dt.ToString("MMM dd dddd/HH:mm") + "(UK)";
                }
                else if (SessionManager.Instance.UserProfile.CountryCode == "AU")
                {
                    //var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    //dt = ConvertDateToTimezone(aest, info.Schedule);
                    //time = dt.ToString("MMM dd dddd/HH:mm") + (aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

                    ////bool isDisplayACT = Convert.ToBoolean(ConfigurationManager.AppSettings["DisplayACT"]);
                    ////if (isDisplayACT)
                    ////{
                    //var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    //dt = ConvertDateToTimezone(acst, info.Schedule);
                    //time += "/" + dt.ToString("HH:mm") + (acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

                    //var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    //dt = ConvertDateToTimezone(qld, info.Schedule);
                    //time += "/" + dt.ToString("HH:mm") + "(AEST)";


                    //var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    //dt = ConvertDateToTimezone(awst, info.Schedule);
                    //time += "/" + dt.ToString("HH:mm") + "(AWST)";
                    ////}

                    var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    dt = ConvertDateToTimezone(aest, info.Schedule);
                    time = dt.ToString("MMM dd dddd/HH:mm") + "(VIC)";//(aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

                    //bool isDisplayACT = Convert.ToBoolean(ConfigurationManager.AppSettings["DisplayACT"]);
                    //if (isDisplayACT)
                    //{
                    var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    dt = ConvertDateToTimezone(acst, info.Schedule);
                    time += "/" + dt.ToString("HH:mm") + "(SA)";//(acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

                    var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    dt = ConvertDateToTimezone(qld, info.Schedule);
                    time += "/" + dt.ToString("HH:mm") + "(QLD)"; //AEST


                    var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    dt = ConvertDateToTimezone(awst, info.Schedule);
                    time += "/" + dt.ToString("HH:mm") + "(WA)";
                }

                info.TimeSchedule = time;
                info.NumberOfMatching = SessionManager.Instance.UserProfile.NumberOfMatching;
                finalList.Add(info);
            }

            List<ScheduleContract> matched = finalList.FindAll(x => x.Schedule.Year.Equals(schedule.Year) && x.Schedule.Month.Equals(schedule.Month) && x.PartnerId != null);
            if (matched != null && matched.Count() > 0)
            {
                list.ForEach(item =>
                {
                    item.MatchedCount = matched.Count();
                });
            }


            return finalList;
        }

        [HttpGet]
        [Route("api/MatchMaker/GetPartnerToDisplay/{userId}")]
        public IEnumerable<ScheduleContract> GetPartnerToDisplay(int userId)
        {
            MatchMakerRepository rep = new MatchMakerRepository();
            List<ScheduleContract> list = rep.GetPartnerToDisplayInTalk(userId);
            List<UserFrequencyContract> freqList = rep.GetUserAvailablePerMonth(userId);
            List<ScheduleContract> finallist = new List<ScheduleContract>();
            List<TimeScheduleAuxContract> listAux = rep.GetAllTime();
            foreach (ScheduleContract info in list)
            {
                //TimeScheduleAuxContract aux = listAux.Find(x => x.TimeSchedule == info.Schedule.ToString("HH:mm") && x.CountryIds.Contains(SessionManager.Instance.UserProfile.CountryID.ToString()));
                TimeScheduleAuxContract aux = listAux.Find(x => x.TimeSchedule.PadLeft(5,'0') == info.Schedule.ToString("HH:mm") );
                if (aux == null)
                {
                    continue;
                }
                UserFrequencyContract uf = freqList.Find(x => x.Month == info.Schedule.Month && x.Year == info.Schedule.Year && x.MatchedCount < x.NumberOfMatching);
                if (uf != null)
                {
                    finallist.Add(info);
                }
                uf = freqList.Find(x => x.Month == info.Schedule.Month && x.Year == info.Schedule.Year);
                if(uf == null)
                {
                    finallist.Add(info);
                }
            }
            string spaces = string.Concat(Enumerable.Repeat("&nbsp;", 14));
            List<ScheduleContract> orderedList = finallist.OrderBy(x => x.Schedule).ToList();
            foreach (ScheduleContract info in orderedList)
            {
                string time = "";
                DateTime dt = DateTime.Now;
                if (SessionManager.Instance.UserProfile.CountryCode == "JP")
                {
                    time = info.Schedule.ToString("MMM dd HH:mm") + "(JP)";
                }
                else if (SessionManager.Instance.UserProfile.CountryCode == "UK")
                {
                    var uk = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    dt = ConvertDateToTimezone(uk, info.Schedule);
                    time = dt.ToString("MMM dd dddd HH:mm") + "(UK)";
                }
                else if (SessionManager.Instance.UserProfile.CountryCode == "AU")
                {
                    var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    dt = ConvertDateToTimezone(aest, info.Schedule);
                    time = dt.ToString("MMM dd dddd HH:mm") + "(VIC)";//(aest.IsDaylightSavingTime(dt) ? "(AEDT)" : "(AEST)");

                    //bool isDisplayACT = Convert.ToBoolean(ConfigurationManager.AppSettings["DisplayACT"]);
                    //if (isDisplayACT)
                    //{
                        var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                        dt = ConvertDateToTimezone(acst, info.Schedule);
                    time += "&nbsp;" + dt.ToString("HH:mm") + "(SA)";//(acst.IsDaylightSavingTime(dt) ? "(ACDT)" : "(ACST)");

                        var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                        dt = ConvertDateToTimezone(qld, info.Schedule);
                        time += "&nbsp;" + dt.ToString("HH:mm") + "(QLD)"; //AEST


                        var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                        dt = ConvertDateToTimezone(awst, info.Schedule);
                        time += "&nbsp;" +  dt.ToString("HH:mm") + "(WA)";
                    //}
                }

                info.TimeSchedule = time;
            }

            return orderedList;
        }

        [HttpGet]
        [Route("api/MatchMaker/IsWithinThreshold")]
        public bool IsWithinThreshold()
        {
            bool isWithinThreshold = false;
            if(SessionManager.Instance.UserProfile != null && SessionManager.Instance.UserProfile.Schedules != null)
            {
                List<ScheduleContract> schedules = SessionManager.Instance.UserProfile.Schedules.Where(x=> x.ScheduleId > 0).OrderBy(x => x.Schedule).ToList();
                List<ScheduleContract> updatedShedules = new List<ScheduleContract>();
                ScheduleContract[] arr = new ScheduleContract[schedules.Count()];
                schedules.CopyTo(arr);
                updatedShedules = arr.ToList();
                foreach (ScheduleContract sc in schedules)
                {

                    TimeSpan timespan = sc.Schedule.Subtract(DateTime.Now);
                    List<int> attendanceThresholds = ConfigurationManager.AppSettings["AttendanceThreshold"].ToString().Split(',').Select(Int32.Parse).ToList();
                    
                    if (timespan.TotalMinutes <= attendanceThresholds[0] && timespan.TotalMinutes > 0)
                    {
                        isWithinThreshold = true;
                        break;
                    }
                    else if(timespan.TotalMinutes < 0)
                    {
                        updatedShedules.Remove(sc);
                    }
                }
                SessionManager.Instance.UserProfile.Schedules = updatedShedules;
            }
            return isWithinThreshold;
        }

        [HttpGet]
        [Route("api/MatchMaker/UpdateAttendance")]
        public bool UpdateAttendance()
        {
            bool result = false;
            int score = 0;
            if (SessionManager.Instance.UserProfile != null && SessionManager.Instance.UserProfile.Schedules != null)
            {
                List<ScheduleContract> schedules = SessionManager.Instance.UserProfile.Schedules.Where(x => x.ScheduleId > 0).OrderBy(x => x.Schedule).ToList();
                List<ScheduleContract> updatedShedules = new List<ScheduleContract>();
                ScheduleContract[] arr = new ScheduleContract[schedules.Count()];
                schedules.CopyTo(arr);
                updatedShedules = arr.ToList();
                List<int> attendanceThresholds = ConfigurationManager.AppSettings["AttendanceThreshold"].ToString().Split(',').Select(Int32.Parse).ToList();
                List<int> scoreList = ConfigurationManager.AppSettings["AttendanceScore"].ToString().Split(',').Select(Int32.Parse).ToList();
                DateTime? sched = null;
                ScheduleContract schedule = null;
                foreach (ScheduleContract sc in schedules)
                {
                    TimeSpan timespan = sc.Schedule.Subtract(DateTime.Now);
                    if (timespan.TotalMinutes < 0)
                    {
                        continue;
                    }
                    sched = sc.Schedule;
                    if (timespan.TotalMinutes >= attendanceThresholds[1])
                    {
                        result = true;
                        score = scoreList[0];
                        schedule = sc;
                        break;
                    }
                    else if (timespan.TotalMinutes <= attendanceThresholds[1] && timespan.TotalMinutes > attendanceThresholds[2])
                    {
                        result = true;
                        score = scoreList[1];
                        schedule = sc;
                        break;
                    }
                    else if (timespan.TotalMinutes <= attendanceThresholds[2] && timespan.TotalMinutes > 0)
                    {
                        result = true;
                        score = scoreList[2];
                        schedule = sc;
                        break;
                    }
                }
                if (score > 0)
                {
                    UserRepository rep = new UserRepository();
                    UserAttendanceContract u = new UserAttendanceContract();
                    u.Score = score;
                    u.UserID = SessionManager.Instance.UserProfile.UserID;
                    u.Schedule = sched.Value;
                    rep.InsertUserAttendance(u);
                    if (schedule != null)
                    {
                        updatedShedules.Remove(schedule);
                        SessionManager.Instance.UserProfile.Schedules = updatedShedules;

                    }
                }
            }
            return result;
        }

        [HttpPost]
        [Route("api/MatchMaker/AddUserPoints")]
        public bool AddUserPoints(UserOtherPointsContract user)
        {
            bool result = false;
            int points = 0;
            try
            {
                UserRepository rep = new UserRepository();
                switch( user.Type)
                {
                    case "Issues":
                        points = 100;
                        break;
                    case "Advice":
                        points = 100;
                        break;
                }
                if (user.UserID == 0)
                {
                    user.UserID = SessionManager.Instance.UserProfile.UserID;
                }
                user.Points = points;
                rep.InsertUserOtherPoints(user);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }

        [HttpPost]
        [Route("api/MatchMaker/SaveContact/{name}/{phone}")]
        public bool SaveContact(string name, string phone)
        {
            bool result = false;
            if (!SessionManager.Instance.UserProfile.IsParentsInfoStored)
            {
                ZendeskRepository rep = new ZendeskRepository();
                ZendeskUser user = new ZendeskUser();

                user = rep.GetZendeskEndUser(SessionManager.Instance.UserProfile.LinkKey);

                if (user != null && user.User != null) //&& (String.IsNullOrEmpty(user.User.Phone) || String.IsNullOrEmpty(user.User.UserFields.ParentsName)) )
                {
                    user.User.Phone = phone;
                    user.User.UserFields = new UserFields() { ParentsName = name };
                    bool updated = rep.UpdateUser(user);
                    if (updated)
                    {
                        updated = new UserRepository().UpdateUserParentsInfo(SessionManager.Instance.UserProfile.UserID);
                        SessionManager.Instance.UserProfile.IsParentsInfoStored = updated;
                        result = updated;
                    }
                }
            }

            return result;
        }

        [HttpGet]
        [Route("api/MatchMaker/GetTopics")]
        public IEnumerable<PhraseCategoryContract> GetTopics()
        {
            PhraseCategoryRepository rep = new PhraseCategoryRepository();
            List<PhraseCategoryContract> plist = rep.GetPhraseCategoryList(SessionManager.Instance.UserProfile.NativeLanguage, SessionManager.Instance.UserProfile.LevelID, SessionManager.Instance.UserProfile.SchoolID);
            List<TopCategoryContract> tcats = rep.GetTopCategoryList(SessionManager.Instance.UserProfile.NativeLanguage);
            List<PhraseCategoryContract> phraseList = new List<PhraseCategoryContract>();


            foreach (TopCategoryContract tc in tcats)
            {
                var list = plist.FindAll(x => x.TopCategoryHeaderID.Equals(tc.TopCategoryHeaderID));
                if (list != null)
                {
                    foreach (PhraseCategoryContract p in list)
                    {
                        if (p.PhraseCategoryCode.Trim().Equals(tc.TopCategoryName.Trim(), StringComparison.OrdinalIgnoreCase) || p.PhraseCategoryCode.Trim().Contains(tc.TopCategoryName.Trim()))
                        {
                            phraseList.Add(new PhraseCategoryContract() { PhraseCategoryID = p.PhraseCategoryID, PhraseCategoryCode = p.PhraseCategoryCode });
                        }
                        else
                        {
                            phraseList.Add(new PhraseCategoryContract() { PhraseCategoryID = p.PhraseCategoryID, PhraseCategoryCode = tc.TopCategoryName + " - " + p.PhraseCategoryCode });
                        }
                    }
                }
            }
            phraseList.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[All]" });

            return phraseList;
        }

        private DateTime ConvertDateToTimezone(TimeZoneInfo timezone, DateTime time)
        {
            //var BritishZone = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");

            DateTime dt = DateTime.SpecifyKind(time, DateTimeKind.Unspecified);

            DateTime tzdate = TimeZoneInfo.ConvertTime(dt, TimeZoneInfo.Local, timezone);
            return tzdate;
        }

        private bool EmailConfirmation(string mailfrom, string to, string username)
        {
            bool success = false;
            try
            {
                SmtpClient smtp = new SmtpClient("smtp.mailtrap.io");
                
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new System.Net.NetworkCredential("f51aab2d717be5", "99d76ecdff64fe");
                smtp.Port = 2525;
                smtp.EnableSsl = true;

                MailMessage msg = new MailMessage(mailfrom, to);
                msg.IsBodyHtml = true;

                Resources.Scheduler.Culture = new System.Globalization.CultureInfo(SessionManager.Instance.UserProfile.NativeLanguage);
                msg.Subject = Resources.Scheduler.Subject;
                StringBuilder body = new StringBuilder();
                body.AppendFormat(Resources.Scheduler.Message, "Bong", "2021-03-30 08:00");
                msg.Body = body.ToString();
                smtp.SendMailAsync(msg);
                success = true;
            }
            catch (Exception)
            {
                success = false;
                throw;
            }
            return success;
        }

        private bool CreateTicket(MatchContract info, bool isMain)
        {
            try
            {
                ZendeskUser user = new ZendeskRepository().GetZendeskEndUser(info.UserLinkKey);
                ZendeskUser partner = new ZendeskRepository().GetZendeskEndUser(info.PartnerLinkKey);

                ZendeskTicket ticket = new ZendeskTicket();
                Comment comment = new Comment();
                comment.Body = (isMain ? info.Name : info.PartnerName) + " registered a Schedule.";
                Requester requester = new Requester();
                requester.Email = isMain ? (user.User != null ? user.User.Email : "") : (partner!= null && partner.User != null ? partner.User.Email : "");
                ticket.Country = (isMain ? info.Country : info.PartnerCountry);

                List<ICustomFields> custom = new List<ICustomFields>();
                if (user != null && user.User != null)
                {
                    CustomFields customFields = new CustomFields();
                    customFields.Id = "360024797616"; //P_User_Email
                    customFields.Value = isMain ? user.User.Email : (partner.User != null ? partner.User.Email : "");
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "360024843836"; //P_User_Name
                    customFields.Value = isMain ? info.UserName : info.PartnerUserName;
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "4726160281743"; //P_Talk_User_Topic
                    customFields.Value = isMain ? info.UserTopic : info.PartnerTopic;
                    custom.Add(customFields);

                    if (!String.IsNullOrEmpty(info.PartnerUserName))
                    {
                        if (partner != null)
                        {
                            customFields = new CustomFields();
                            customFields.Id = "360024797636"; // P_Tak_PartnerEmail
                            customFields.Value = isMain ? (partner.User != null ? partner.User.Email : "") : user.User.Email;
                            custom.Add(customFields);

                            customFields = new CustomFields();
                            customFields.Id = "360024768575"; // P_Tak_Partner_Name
                            customFields.Value = isMain ? info.PartnerUserName : info.UserName;
                            custom.Add(customFields);

                            customFields = new CustomFields();
                            customFields.Id = "4726140231695"; //P_Talk_Partner_Topic
                            customFields.Value = isMain ? info.PartnerTopic : info.UserTopic;
                            custom.Add(customFields);

                            ticket.HasPartner = true;
                        }
                    }
                    string domainName = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

                    customFields = new CustomFields();
                    customFields.Id = "360024769575"; //P_Talk_Confirmation_Url
                    customFields.Value = domainName + (ConfigurationManager.AppSettings["ENV"] == "UAT" ? "/UAT" : "") + String.Format("/Confirmation?t={0}", (isMain ? info.UserConfirmationToken : info.PartnerConfirmationToken));
                    custom.Add(customFields);


                    customFields = new CustomFields();
                    customFields.Id = "360024720395"; //P_Talk_Date
                    customFields.Value = info.Schedule.ToString("yyyy-MM-dd"); //"2021-12-20";
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "4419906240143"; //P_Talk_FullText_Date
                    customFields.Value = info.Schedule.ToString("dddd, dd MMM yyyy"); //"2021-12-20";
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "360024797656"; //P_Talk_Time
                    customFields.Value = FindTimeZoneByCountry(info, isMain);
                    custom.Add(customFields);

                    customFields = new CustomFields();
                    customFields.Id = "360024893816"; //P_Talk_Ticket_Type
                    customFields.Value = "Schedule";
                    custom.Add(customFields);

                    //MultiSelectCustomFields mcustomFields = new MultiSelectCustomFields();
                    //mcustomFields.Id = "4416096345615"; //P_Talk_Topics
                    //mcustomFields.Values = getPhraseCategory();
                    //custom.Add(mcustomFields);


                    Ticket tick = new Ticket();
                    tick.Comment = comment;
                    tick.CustomFields = custom;
                    tick.Priority = "urgent";
                    tick.Subject = "Talk Schedule";

                    tick.TicketType = "task";
                    tick.DueAt = TimeZoneInfo.ConvertTimeToUtc(info.Schedule, TimeZoneInfo.Local).ToString("o");

                    tick.RequesterDetail = requester;
                    ticket.Ticket = tick;
                    ZendeskRepository rep = new ZendeskRepository();
                    rep.UpdateMultiSelectTicketField("4416096345615", getPhraseCategory());
                    rep.CreateTicket(ticket);

                }
                //body = body.Replace("{{first_name}}", isMain ? info.Name : info.PartnerName);
                //body = body.Replace("{{booked_date}}", info.Schedule.ToString("MMM dd, yyyy"));
                //body = body.Replace("{{booked_time}}", FindTimeZoneByCountry(info, isMain));
                //body = body.Replace("{{partner_detail}}", info.PartnerId == 0 ? "Waiting for your match." : String.Format("{0},{1},{2}", isMain ? info.PartnerName : info.Name, isMain ? info.PartnerGrade : info.Grade, isMain ? info.PartnerGender : info.PartnerGender));
                //body = body.Replace("{{username}}", isMain ? info.UserName : info.PartnerUserName);
                //body = body.Replace("{{password}}", isMain ? info.Password : info.PartnerPassword);



            }
            catch (Exception ex) 
            {
                throw ex;
            }

            return true;
        }

        private bool ConfirmSchedule(MatchContract info, bool isMain)
        {
            bool success = false;
            try
            {
                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"]);
                if (ConfigurationManager.AppSettings["ENV"] == "DEV")
                {
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["DEVUserName"], ConfigurationManager.AppSettings["DEVPassword"]);
                    smtp.Port = 2525;
                    smtp.EnableSsl = true;
                }
                else
                {
                    smtp.Port = 25;
                }


                MailMessage msg = new MailMessage("No_Reply_TalkBooking@languageDiscovery.org", ConfigurationManager.AppSettings["AdminEmail"]);
                msg.IsBodyHtml = true;
                string body = string.Empty;
                using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/Student/ScheduleTemplate.en-US.html")))
                {
                    body = reader.ReadToEnd();
                }
                body = body.Replace("{{first_name}}", isMain ? info.Name : info.PartnerName);
                body = body.Replace("{{booked_date}}", info.Schedule.ToString("MMM dd, yyyy"));
                body = body.Replace("{{booked_time}}", FindTimeZoneByCountry(info, isMain));
                body = body.Replace("{{partner_detail}}", info.PartnerId == 0 ? "Waiting for your match." :  String.Format("{0},{1},{2}", isMain ? info.PartnerName : info.Name, isMain ? info.PartnerGrade : info.Grade, isMain ? info.PartnerGender : info.PartnerGender));
                body = body.Replace("{{username}}", isMain ? info.UserName : info.PartnerUserName);
                body = body.Replace("{{password}}", isMain ? info.Password : info.PartnerPassword);


                msg.Subject = "Talk Booking Confirmation";
                
                msg.Body = body.ToString();
                smtp.Send(msg);
                success = true;
            }
            catch (Exception)
            {
                success = false;
                throw;
            }
            return success;
        }

        private bool EmailCancelSchedule(DateTime? date)
        {
            bool success = false;
            try
            {
                SmtpClient smtp = new SmtpClient(ConfigurationManager.AppSettings["SMTP"]);
                if (ConfigurationManager.AppSettings["ENV"] == "DEV")
                {
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["DEVUserName"], ConfigurationManager.AppSettings["DEVPassword"]);
                    smtp.Port = 2525;
                    smtp.EnableSsl = true;
                }
                else
                {
                    smtp.Port = 25;
                }


                MailMessage msg = new MailMessage("No_Reply_TalkBooking@languageDiscovery.org", ConfigurationManager.AppSettings["AdminEmail"]);
                msg.IsBodyHtml = true;
                string body = string.Empty;
                using (StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/Student/CancelScheduleTemplate.en-US.html")))
                {
                    body = reader.ReadToEnd();
                }
                body = body.Replace("{{first_name}}", SessionManager.Instance.UserProfile.FirstName);
                body = body.Replace("{{booked_date}}", date.Value.ToString("MMM dd, yyyy"));
                MatchContract info = new MatchContract()
                {
                    Schedule = date.Value,
                    Country = SessionManager.Instance.UserProfile.CountryCode
                };
                body = body.Replace("{{booked_time}}", FindTimeZoneByCountry(info, true));


                msg.Subject = "Cancel Talk Booking Confirmation";

                msg.Body = body.ToString();
                smtp.Send(msg);
                success = true;
            }
            catch (Exception)
            {
                success = false;
                throw;
            }
            return success;
        }

        private string FindTimeZoneByCountry(MatchContract info, bool isMain)
        {


            string time = "";
            TimeZoneInfo timeZone = null;// TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
            if(isMain)
            {
                if (info.Country == "AU")
                {
                    var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    DateTime dt = ConvertDateToTimezone(awst, info.Schedule);
                    time = dt.ToString("hh:mm tt") + "(WA)";//"(AWST)";

                    var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    dt = ConvertDateToTimezone(aest, info.Schedule);
                    time += " / " + dt.ToString("hh:mm tt") + "(VIC, ACT, NSW)";//"(AEST/AEDT) / ";

                    //var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    //DateTime dt = ConvertDateToTimezone(aest, info.Schedule);
                    //time = dt.ToString("hh:mm tt") + "(AEST/AEDT) / ";

                    //var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    //dt = ConvertDateToTimezone(acst, info.Schedule);
                    //time += dt.ToString("hh:mm tt") + "(ACST/ACDT) / ";

                    //var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    //dt = ConvertDateToTimezone(qld, info.Schedule);
                    //time += dt.ToString("hh:mm tt") + "(AEST) / ";

                    //var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    //dt = ConvertDateToTimezone(awst, info.Schedule);
                    //time += dt.ToString("hh:mm tt") + "(AWST)";
                }
                else if(info.Country == "JP")
                {
                    time = info.Schedule.ToString("hh:mm tt") + "(JP)";
                }
                else if (info.Country == "UK")
                {
                    timeZone= TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    DateTime dt = ConvertDateToTimezone(timeZone, info.Schedule);
                    time = dt.ToString("hh:mm tt") + "(UK)";
                }
            }
            else
            {
                if (info.PartnerCountry == "AU")
                {
                    var aest = TimeZoneInfo.FindSystemTimeZoneById("AUS Eastern Standard Time");
                    DateTime dt = ConvertDateToTimezone(aest, info.Schedule);
                    time = dt.ToString("hh:mm tt") + "(AEST/AEDT) / ";

                    var acst = TimeZoneInfo.FindSystemTimeZoneById("Cen. Australia Standard Time");
                    dt = ConvertDateToTimezone(acst, info.Schedule);
                    time += dt.ToString("hh:mm tt") + "(ACST/ACDT) / ";

                    var qld = TimeZoneInfo.FindSystemTimeZoneById("E. Australia Standard Time");
                    dt = ConvertDateToTimezone(qld, info.Schedule);
                    time += dt.ToString("hh:mm tt") + "(AEST) / ";

                    var awst = TimeZoneInfo.FindSystemTimeZoneById("W. Australia Standard Time");
                    dt = ConvertDateToTimezone(awst, info.Schedule);
                    time += dt.ToString("hh:mm tt") + "(AWST)";
                }
                else if (info.PartnerCountry == "JP")
                {
                    time = info.Schedule.ToString("hh:mm tt") + "(JP)";
                }
                else if (info.PartnerCountry == "UK")
                {
                    timeZone = TimeZoneInfo.FindSystemTimeZoneById("GMT Standard Time");
                    DateTime dt = ConvertDateToTimezone(timeZone, info.Schedule);
                    time = dt.ToString("hh:mm tt") + "(UK)";
                }
            }

            return time;
        }

        private ZendeskCustomTicketFields getPhraseCategory()
        {
            PhraseCategoryRepository rep = new PhraseCategoryRepository();
            List<PhraseCategoryContract> phraseList = rep.GetPhraseCategoryList(SessionManager.Instance.UserProfile.NativeLanguage, SessionManager.Instance.UserProfile.LevelID, SessionManager.Instance.UserProfile.SchoolID);
            ZendeskCustomTicketFields field = new ZendeskCustomTicketFields();
            List<ZendeskCustomTicketFieldsOption> options = new List<ZendeskCustomTicketFieldsOption>();
            foreach (PhraseCategoryContract p in phraseList)
            {
                if (p.PhraseCategoryCode.EndsWith("Q"))
                {
                    if (!options.Any(x => x.Value.Equals(p.PhraseCategoryCode.Replace(" ", "_").ToLower())))
                    {
                        ZendeskCustomTicketFieldsOption option = new ZendeskCustomTicketFieldsOption();
                        option.Name = p.PhraseCategoryCode;
                        option.Value = p.PhraseCategoryCode.Replace(" ", "_").ToLower();
                        options.Add(option);
                    }

                }
            }
            field.Options = options;
            return field;
        }
    }
}
