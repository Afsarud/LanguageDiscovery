using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using Language.Discovery.Entity;

namespace Language.Discovery.Repository
{
    public class UserRepository : IRepository<UserContract>
    {
        public UserRepository()
        {

        }


        public object Add(UserContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserName", tObject.UserName));
                paramlist.Add(new Parameter("FirstName", tObject.FirstName));
                paramlist.Add(new Parameter("MiddleName", tObject.MiddleName));
                paramlist.Add(new Parameter("LastName", tObject.LastName));
                paramlist.Add(new Parameter("Address", tObject.Address));
                if (tObject.DateOfBirth != DateTime.MinValue)
                    paramlist.Add(new Parameter("DateOfBirth", tObject.DateOfBirth));
                paramlist.Add(new Parameter("Telephone", tObject.Telephone));
                paramlist.Add(new Parameter("Fax", tObject.Fax));
                paramlist.Add(new Parameter("Email", tObject.Email));
                paramlist.Add(new Parameter("Password", tObject.Password));
                paramlist.Add(new Parameter("Password2", tObject.Password2));
                paramlist.Add(new Parameter("ClassID", tObject.ClassID));
                paramlist.Add(new Parameter("UserTypeID", tObject.UserTypeID));
                paramlist.Add(new Parameter("CountryID", tObject.CountryID));
                paramlist.Add(new Parameter("CityID", tObject.CityID));
                paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                paramlist.Add(new Parameter("GradeID", tObject.GradeID));
                paramlist.Add(new Parameter("IsPalleteVisible", tObject.IsPalleteVisible));
                //paramlist.Add(new Parameter("NativeLanguage", tObject.NativeLanguage));
                //paramlist.Add(new Parameter("LearningLanguage", tObject.LearningLanguage));
                //paramlist.Add(new Parameter("SubNativeLanguage", tObject.SubNativeLanguage));
                paramlist.Add(new Parameter("TeachersName", tObject.TeachersName));
                paramlist.Add(new Parameter("ParentsName", tObject.ParentsName));
                paramlist.Add(new Parameter("IsActive", tObject.IsActive));
                paramlist.Add(new Parameter("AfterSchool", tObject.AfterSchool));
                paramlist.Add(new Parameter("Gender", tObject.Gender));
                paramlist.Add(new Parameter("IsRobot", tObject.IsRobot));
                paramlist.Add(new Parameter("AllowTalk", tObject.AllowTalk));
                paramlist.Add(new Parameter("HasAgreedTC", tObject.HasAgreedTC));
                paramlist.Add(new Parameter("Custom1", tObject.Custom1));
                paramlist.Add(new Parameter("Custom2", tObject.Custom2));
                paramlist.Add(new Parameter("Custom3", tObject.Custom3));
                paramlist.Add(new Parameter("Note1", tObject.Note1));
                paramlist.Add(new Parameter("Note2", tObject.Note2));
                paramlist.Add(new Parameter("Note3", tObject.Note3));
                paramlist.Add(new Parameter("Note4", tObject.Note4));
                paramlist.Add(new Parameter("EnabledFreeMessage", tObject.EnabledFreeMessage));
                paramlist.Add(new Parameter("SoundAndMail", tObject.SoundAndMail));
                paramlist.Add(new Parameter("ShouldUpdateTalkTime", tObject.ShouldUpdateTalkTime));
                paramlist.Add(new Parameter("TotalTime", tObject.TotalTime));
                paramlist.Add(new Parameter("BalanceTime", tObject.BalanceTime));
                paramlist.Add(new Parameter("SessionTime", tObject.SessionTime));
                paramlist.Add(new Parameter("NumberOfMatching", tObject.NumberOfMatching));
                paramlist.Add(new Parameter("OrderByLearningLanguageFlag", tObject.OrderByLearningLanguageFlag));
                paramlist.Add(new Parameter("LinkKey", tObject.LinkKey));
                paramlist.Add(new Parameter("IsParentsInfoStored", tObject.IsParentsInfoStored));
                paramlist.Add(new Parameter("SubLanguageOptionFlag", tObject.SubLanguageOptionFlag));
                //if (tObject.TrialExpirationDate.HasValue )
                //    paramlist.Add(new Parameter("TrialExpirationDate", tObject.TrialExpirationDate));

                paramlist.Add(new Parameter("ID", 0, DbType.Int64, ParameterDirection.Output));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUser", paramlist);
                long userid = 0;
                if (affected > 0)
                {
                    List<Parameter> output = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (output != null)
                    {
                        userid = Convert.ToInt64(output[0].Value);
                    }

                }

                return userid;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(UserContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", tObject.UserID));
                paramlist.Add(new Parameter("UserName", tObject.UserName));
                paramlist.Add(new Parameter("FirstName", tObject.FirstName));
                paramlist.Add(new Parameter("MiddleName", tObject.MiddleName));
                paramlist.Add(new Parameter("LastName", tObject.LastName));
                paramlist.Add(new Parameter("Address", tObject.Address));
                if (tObject.DateOfBirth != DateTime.MinValue)
                    paramlist.Add(new Parameter("DateOfBirth", tObject.DateOfBirth));
                paramlist.Add(new Parameter("Telephone", tObject.Telephone));
                paramlist.Add(new Parameter("Fax", tObject.Fax));
                paramlist.Add(new Parameter("Email", tObject.Email));
                paramlist.Add(new Parameter("Password", tObject.Password));
                paramlist.Add(new Parameter("Password2", tObject.Password2));
                paramlist.Add(new Parameter("ClassID", tObject.ClassID));
                paramlist.Add(new Parameter("UserTypeID", tObject.UserTypeID));
                paramlist.Add(new Parameter("CountryID", tObject.CountryID));
                paramlist.Add(new Parameter("CityID", tObject.CityID));
                paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                paramlist.Add(new Parameter("LevelID", tObject.LevelID));
                paramlist.Add(new Parameter("GradeID", tObject.GradeID));
                paramlist.Add(new Parameter("IsPalleteVisible", tObject.IsPalleteVisible));
                //paramlist.Add(new Parameter("NativeLanguage", tObject.NativeLanguage));
                //paramlist.Add(new Parameter("LearningLanguage", tObject.LearningLanguage));
                //paramlist.Add(new Parameter("SubNativeLanguage", tObject.SubNativeLanguage));
                paramlist.Add(new Parameter("TeachersName", tObject.TeachersName));
                paramlist.Add(new Parameter("ParentsName", tObject.ParentsName));
                paramlist.Add(new Parameter("Gender", tObject.Gender));
                paramlist.Add(new Parameter("IsActive", tObject.IsActive));
                paramlist.Add(new Parameter("AfterSchool", tObject.AfterSchool));
                paramlist.Add(new Parameter("IsRobot", tObject.IsRobot));
                paramlist.Add(new Parameter("AllowTalk", tObject.AllowTalk));
                paramlist.Add(new Parameter("HasAgreedTC", tObject.HasAgreedTC));
                paramlist.Add(new Parameter("Custom1", tObject.Custom1));
                paramlist.Add(new Parameter("Custom2", tObject.Custom2));
                paramlist.Add(new Parameter("Custom3", tObject.Custom3));
                paramlist.Add(new Parameter("Note1", tObject.Note1));
                paramlist.Add(new Parameter("Note2", tObject.Note2));
                paramlist.Add(new Parameter("Note3", tObject.Note3));
                paramlist.Add(new Parameter("Note4", tObject.Note4));
                paramlist.Add(new Parameter("EnabledFreeMessage", tObject.EnabledFreeMessage));
                paramlist.Add(new Parameter("SoundAndMail", tObject.SoundAndMail));
                paramlist.Add(new Parameter("ShouldUpdateTalkTime", tObject.ShouldUpdateTalkTime));
                paramlist.Add(new Parameter("TotalTime", tObject.TotalTime));
                paramlist.Add(new Parameter("BalanceTime", tObject.BalanceTime));
                paramlist.Add(new Parameter("SessionTime", tObject.SessionTime));
                paramlist.Add(new Parameter("NumberOfMatching", tObject.NumberOfMatching));
                paramlist.Add(new Parameter("OrderByLearningLanguageFlag", tObject.OrderByLearningLanguageFlag));
                paramlist.Add(new Parameter("LinkKey", tObject.LinkKey));
                paramlist.Add(new Parameter("IsParentsInfoStored", tObject.IsParentsInfoStored));
                paramlist.Add(new Parameter("SubLanguageOptionFlag", tObject.SubLanguageOptionFlag));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUser", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateOtherUserInfo(UserContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", tObject.UserID));
                paramlist.Add(new Parameter("Password", tObject.Password));
                paramlist.Add(new Parameter("ClassID", tObject.ClassID));
                paramlist.Add(new Parameter("Gender", tObject.Gender));
                paramlist.Add(new Parameter("CityID", tObject.CityID));
                paramlist.Add(new Parameter("GradeID", tObject.GradeID));
                //paramlist.Add(new Parameter("DateOfBirth", tObject.DateOfBirth));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserOtherInfo", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserOptions(UserContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", tObject.UserID));
                paramlist.Add(new Parameter("SequenceOptionFlag", tObject.SequenceOptionFlag));
                paramlist.Add(new Parameter("NativeOptionFlag", tObject.NativeOptionFlag));
                paramlist.Add(new Parameter("SubLanguageOptionFlag", tObject.SubLanguageOptionFlag));
                paramlist.Add(new Parameter("SubLanguage2OptionFlag", tObject.SubLanguage2OptionFlag));
                paramlist.Add(new Parameter("SoundAndMail", tObject.SoundAndMail));
                paramlist.Add(new Parameter("StepOptionFlag", tObject.StepOptionFlag));
                paramlist.Add(new Parameter("OrderByLearningLanguageFlag", tObject.OrderByLearningLanguageFlag));
                //paramlist.Add(new Parameter("DateOfBirth", tObject.DateOfBirth));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_UserSaveOptions", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Delete(UserContract tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", tObject.UserID));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteUser", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public UserContract GetByID(long id)
        {
            try
            {
                List<UserContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ID", id));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserByID", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                }

                return msg[0];
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserContract> Search(SearchUserDTO tObject)
        {
            try
            {
                List<UserContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("RowsPerPage", tObject.RowsPerPage));
                paramlist.Add(new Parameter("PageNumber", tObject.PageNumber));
                paramlist.Add(new Parameter("FirstName", tObject.FirstName));
                paramlist.Add(new Parameter("LastName", tObject.LastName));
                paramlist.Add(new Parameter("ClassID", tObject.ClassID));
                paramlist.Add(new Parameter("CountryID", tObject.CountryID));
                paramlist.Add(new Parameter("CityID", tObject.CityID));
                paramlist.Add(new Parameter("SchoolID", tObject.SchoolID));
                paramlist.Add(new Parameter("UserName", tObject.UserName));
                paramlist.Add(new Parameter("VirtualCount", 0, ParameterDirection.Output));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchUserAdmin", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);

                    List<Parameter> pa = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (pa != null)
                    {
                        tObject.VirtualCount = Convert.ToInt32(pa[0].Value);
                    }
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserContract> GetDuplicateUsers(List<UserContract> userlist)
        {
            try
            {
                List<UserContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(userlist);
                paramlist.Add(new Parameter("xml", xml));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetDuplicateUsers", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserContract> GetUserListBySchool(int schoolID)
        {
            try
            {
                List<UserContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserListBySchool", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserContract> GetUserListBySchoolForTrackingOrProgress(int schoolID)
        {
            try
            {
                List<UserContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserListBySchoolForTrackingOrProgress", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserTrackProgress(List<UserContract> userlist)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(userlist);
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserTrackProgress", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public DataSet GetDSUserListBySchool(int schoolID)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolID));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserListBySchool", paramlist);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserStatus(long userID, string status)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("Status", status));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserStatus", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public bool UpdateUserActivity(long userID)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUpdateUserActivity", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public bool DeleteUserPhoto(string xml)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteUserPhoto", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public bool UpdateUserAvatar(long userID, string avatar)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("Avatar", avatar));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserAvatar", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public bool MarkMessageAsRead(long senderid, long recipientid)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SenderId", senderid));
                paramlist.Add(new Parameter("RecipientID", recipientid));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_MarkMessageAsRead", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }



        public UserContract Authenticate(string username, string password)
        {
            try
            {
                UserContract user = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserName", username));
                paramlist.Add(new Parameter("Password", password));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_Authenticate", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<UserContract> list = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                    user = list[0];
                }
                if (user != null)
                    user.OtherLanguages = string.IsNullOrEmpty(user.OtherLanguage) ? null : user.OtherLanguage.Split(',').ToList();

                return user;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public UserContract Authenticate(string username, string password, bool isAdminLogin)
        {
            try
            {
                UserContract user = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserName", username));
                paramlist.Add(new Parameter("Password", password));
                paramlist.Add(new Parameter("IsAdminLogin", isAdminLogin));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_Authenticate", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    List<UserContract> list = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                    user = list[0];
                }
                if(user != null)
                    user.OtherLanguages = user.OtherLanguage.Split(',').ToList();

                return user;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public UserContract GetUserDetails(long userid)
        {
            try
            {
                UserContract user = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserDetails", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    user = (UserContract)CollectionHelper.CreateItem<UserContract>(ds.Tables[0].Rows[0]);
                }

                return user;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public UserMessageContract GetUserSavedMessage(long userid)
        {
            try
            {
                UserMessageContract um = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetSavedMessage", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    um = new UserMessageContract();
                    um.UserMailID = Convert.ToInt32(ds.Tables[0].Rows[0]["UserSavedMessageId"]);
                    um.SenderID = Convert.ToInt32(ds.Tables[0].Rows[0]["UserID"]);
                    um.LearningLanguageMessage= ds.Tables[0].Rows[0]["LearningMessage"].ToString();
                    um.NativeLanguageMessage = ds.Tables[0].Rows[0]["NativeMessage"].ToString();
                    um.OtherLanguageMessage = ds.Tables[0].Rows[0]["OtherLanguageMessage"].ToString();
                }

                return um;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public UserContract GetUserDetailsByUserName(string userName)
        {
            try
            {
                UserContract user = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserName", userName));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserDetailsByUserName", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    user = (UserContract)CollectionHelper.CreateItem<UserContract>(ds.Tables[0].Rows[0]);
                }

                return user;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<UserFriendsContract> GetUserFriends(long userid)
        {
            try
            {
                List<UserFriendsContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMyFriends", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserFriendsContract>)CollectionHelper.ConvertTo<UserFriendsContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserInterestContract> GetUserInterest(long userid, string languagecode)
        {
            try
            {
                List<UserInterestContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                paramlist.Add(new Parameter("LanguageCode", languagecode));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserInterest", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserInterestContract>)CollectionHelper.ConvertTo<UserInterestContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserAboutMeContract> GetUserAboutMe(long userid, string languagecode)
        {
            try
            {
                List<UserAboutMeContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                paramlist.Add(new Parameter("LanguageCode", languagecode));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserAboutMe", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserAboutMeContract>)CollectionHelper.ConvertTo<UserAboutMeContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int GetUnreadMessage(long userid)
        {
            try
            {
                int unread = 0;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUnreadMessage", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    unread = ds.Tables[0].Rows[0]["UnReadMessageCount"] == DBNull.Value ? 0 : Convert.ToInt32(ds.Tables[0].Rows[0]["UnReadMessageCount"]);
                }

                return unread;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<PhotoContract> GetUserPhoto(long userID, long albumID)
        {
            try
            {
                List<PhotoContract> photos = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("AlbumID", albumID));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserPhotoList", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    photos = (List<PhotoContract>)CollectionHelper.ConvertTo<PhotoContract>(ds.Tables[0]);
                }

                return photos;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<WhoLikedMeContract> GetWhoLikedMed(long userID)
        {
            try
            {
                List<WhoLikedMeContract> users = new List<WhoLikedMeContract>();
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetWhoLikedMe", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<WhoLikedMeContract>)CollectionHelper.ConvertTo<WhoLikedMeContract>(ds.Tables[0]);
                    //foreach (DataRow row in ds.Tables[0].Rows)
                    //{
                    //    WhoLikedMeContract user = new WhoLikedMeContract();
                    //    user.UserID = Convert.ToInt64(row["UserID"]);
                    //    user.FirstName= row["FirstName"].ToString();
                    //    user.LastName = row["LastName"].ToString();
                    //    user.Address= row["Address"].ToString();
                    //    user.UserPhotoID = row["UserID"] != DBNull.Value ? Convert.ToInt64(row["UserID"]) : 0;
                    //    user.Photo = row["Photo"] != DBNull.Value ? row["Photo"].ToString() : string.Empty;
                    //    user.Description= row["Description"] != DBNull.Value ? row["Description"].ToString() : string.Empty;
                    //    if (row["LikeDate"] != DBNull.Value)
                    //        user.LikeDate = Convert.ToDateTime(row["LikeDate"]);

                    //    users.Add(user);

                    //}

                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool SaveImageDetails(long userID, string filename, string description)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("AlbumID", 3));
                paramlist.Add(new Parameter("FileName", filename));
                paramlist.Add(new Parameter("Description", description));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUserPhoto", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool AddFriend(long userID, long useridtoadd)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("@UserIDToAdd", useridtoadd));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_AddFriend", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        public bool LikeUnLike(long userID, long userIDToLike, long userstatusid, bool iscurrentLike)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LikeByUserID", userID));
                paramlist.Add(new Parameter("UserStatusID", userstatusid));
                string sp = "usp_LikeUserStatus";
                if (iscurrentLike)
                    sp = "usp_UnLikeUserStatus";

                int affected = DatabaseHelper.ExecuteNonQuery(sp, paramlist);
                if (affected > 0 && userIDToLike > 0 && !iscurrentLike)
                {
                    AddFriend(userID, userIDToLike);
                }
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool LikeUnLikePhoto(long userID, long userphotoID, bool iscurrentLike)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("LikeByUserID", userID));
                paramlist.Add(new Parameter("UserPhotoID", userphotoID));
                string sp = "usp_LikeUserPhoto";
                if (iscurrentLike)
                    sp = "usp_UnLikeUserPhoto";

                int affected = DatabaseHelper.ExecuteNonQuery(sp, paramlist);
                //if (affected > 0 && userphotoID > 0 && !iscurrentLike)
                //{
                //    AddFriend(userID, userphotoID);
                //}
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool LikeUnLikeMessage(long usermailid)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserMailID", usermailid));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_IsMessagelike", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool UpdatePhotoDescription(long userPhotoId, string desc)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserPhotoID", userPhotoId));
                paramlist.Add(new Parameter("Description", desc));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdatePhotoDescription", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UnFriend(long userID, long useridtounfriend)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("@UserIDToUnfriend", useridtounfriend));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UnFriend", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserSearchContract> SearchUser(string name, long searcheeid)
        {
            try
            {
                List<UserSearchContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("name", name));
                paramlist.Add(new Parameter("SearcheeID", searcheeid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchUser", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserSearchContract>)CollectionHelper.ConvertTo<UserSearchContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserSearchContract> DiscoverNewFriends(List<int> interestids, int cityid, string name, long searcheeid)
        {
            try
            {
                string xml = string.Empty;
                xml = "<Interests>";
                foreach (int i in interestids)
                {
                    xml += string.Format("<IDS><ID>{0}</ID></IDS>", i.ToString());
                }
                xml += "</Interests>";

                List<UserSearchContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("InterestXml", xml));
                paramlist.Add(new Parameter("CityID", cityid));
                paramlist.Add(new Parameter("Name", name));
                paramlist.Add(new Parameter("SearcheeID", searcheeid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_DiscoverNewFriends", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserSearchContract>)CollectionHelper.ConvertTo<UserSearchContract>(ds.Tables[0]);
                }
                
                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserSearchContract> DiscoverNewFriends(DiscoverNewFriendsDTO dto)
        {
            try
            {
                string xml = string.Empty;
                xml = "<Interests>";
                foreach (int i in dto.InterestIDs)
                {
                    xml += string.Format("<IDS><ID>{0}</ID></IDS>", i.ToString());
                }
                xml += "</Interests>";

                string xmlg = "<Genders>";
                foreach (string g in dto.GenderList )
                {
                    xmlg += string.Format("<Names><Name>{0}</Name></Names>", g);
                }
                xmlg += "</Genders>";

                List<UserSearchContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("InterestXml", xml));
                paramlist.Add(new Parameter("CityID", dto.CityID));
                paramlist.Add(new Parameter("Name", dto.Name ));
                paramlist.Add(new Parameter("SearcheeID", dto.SearcheeID));
                paramlist.Add(new Parameter("GenderXml", xmlg));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_DiscoverNewFriends", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserSearchContract>)CollectionHelper.ConvertTo<UserSearchContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<UserSearchContract> DiscoverNewFriends(List<int> interestids, long searcheeid)
        {
            try
            {
                string xml = string.Empty;
                xml = "<Interests>";
                foreach (int i in interestids)
                {
                    xml += string.Format("<IDS><ID>{0}</ID></IDS>", i.ToString());
                }
                xml += "</Interests>";

                List<UserSearchContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("InterestXml", xml));
                paramlist.Add(new Parameter("SearcheeID", searcheeid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_DiscoverNewFriends", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserSearchContract>)CollectionHelper.ConvertTo<UserSearchContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserSearchContract> SearchUserWithMessage(string name, long searcheeid, MailBoxUserType mailboxUserType, bool isTalk)
        {
            try
            {
                List<UserSearchContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Name", name));
                paramlist.Add(new Parameter("SearcheeID", searcheeid));
                paramlist.Add(new Parameter("IsTalk", isTalk));
                DataSet ds = null;
                switch (mailboxUserType)
                {
                    case MailBoxUserType.All:
                        ds = DatabaseHelper.ExecuteQuery("usp_SearchUserWithMessage", paramlist);
                        break;
                    case MailBoxUserType.School:
                        ds = DatabaseHelper.ExecuteQuery("usp_SearchUserWithMessage", paramlist);
                        break;
                    case MailBoxUserType.VIP:
                        ds = DatabaseHelper.ExecuteQuery("usp_SearchUserWithMessageVip", paramlist);
                        break;
                }

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserSearchContract>)CollectionHelper.ConvertTo<UserSearchContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserSearchContract> SearchUserWithMessage(string name, long searcheeid, MailBoxUserType mailboxUserType)
        {
            try
            {
                List<UserSearchContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Name", name));
                paramlist.Add(new Parameter("SearcheeID", searcheeid));
                DataSet ds = null;
                switch (mailboxUserType)
                {
                    case MailBoxUserType.All:
                        ds = DatabaseHelper.ExecuteQuery("usp_SearchUserWithMessage", paramlist);
                        break;
                    case MailBoxUserType.School:
                        ds = DatabaseHelper.ExecuteQuery("usp_SearchUserWithMessage", paramlist);
                        break;
                    case MailBoxUserType.VIP:
                        ds = DatabaseHelper.ExecuteQuery("usp_SearchUserWithMessageVip", paramlist);
                        break;
                }

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserSearchContract>)CollectionHelper.ConvertTo<UserSearchContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<PeopleSearchContract> SearchPeople(int countryid, int cityid, string type, string name, long searcheeid)
        {
            try
            {
                List<PeopleSearchContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("CountryID", countryid));
                paramlist.Add(new Parameter("CityID", cityid));
                paramlist.Add(new Parameter("Type", type));
                paramlist.Add(new Parameter("Name", name));
                paramlist.Add(new Parameter("SearcheeID", searcheeid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_SearchPeople", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<PeopleSearchContract>)CollectionHelper.ConvertTo<PeopleSearchContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserMessageContract> GetMessageTrailBySenderID(long senderid, long recepientid, int pagenumber, int rowsperpage)
        {
            try
            {
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SenderID", senderid));
                paramlist.Add(new Parameter("RecepientID", recepientid));
                paramlist.Add(new Parameter("PageNumber", pagenumber));
                paramlist.Add(new Parameter("RowsPerPage", rowsperpage));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMessageTrailBySenderID", paramlist);
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

        public List<UserMessageContract> GetMailMessages(string type, long senderid, long recepientid, int pagenumber, int rowsperpage)
        {
            try
            {
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Type", type));
                paramlist.Add(new Parameter("SenderID", senderid));
                paramlist.Add(new Parameter("RecepientID", recepientid));
                paramlist.Add(new Parameter("PageNumber", pagenumber));
                paramlist.Add(new Parameter("RowsPerPage", rowsperpage));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMailMessages", paramlist);
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

        public UserMessageContract GetMessageDetailByUserMailID(long userMailID)
        {
            try
            {
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserMailID", userMailID));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMessageDetailByUserMailID", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<UserMessageContract>)CollectionHelper.ConvertTo<UserMessageContract>(ds.Tables[0]);
                }

                return msg.Count > 0 ? msg[0] : null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public UserMessageContract GetLastMessageDetailByUserIDAndSenderID(long userId, long senderId)
        {
            try
            {
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userId));
                paramlist.Add(new Parameter("SenderId", senderId));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetLastMessageDetailByUserIDAndSenderID", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    msg = (List<UserMessageContract>)CollectionHelper.ConvertTo<UserMessageContract>(ds.Tables[0]);
                }

                return msg != null && msg.Count > 0 ? msg[0] : null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<long> SaveMessage(List<UserMessageContract> msgs, bool isCC = false)
        {

            try
            {
                List<long> messageids = new List<long>();
                string xml = Utility.SerializeObjectToXML(msgs);
                List<Parameter> paramlist = new List<Parameter>();
                //paramlist.Add(new Parameter("Subject", msg.Subject));
                //paramlist.Add(new Parameter("SenderID", msg.SenderID));
                //paramlist.Add(new Parameter("RecepientID", msg.RecepientID));
                //paramlist.Add(new Parameter("NativeLanguageMessage", msg.NativeLanguageMessage));
                Parameter p = new Parameter("MessageIDs", "", ParameterDirection.Output);
                paramlist.Add(new Parameter("xml", xml, DbType.Xml, ParameterDirection.Input));
                paramlist.Add(new Parameter("IsCC", isCC, DbType.Boolean, ParameterDirection.Input));
                paramlist.Add(p);
                int affected = DatabaseHelper.ExecuteNonQuery("usp_SaveMessage", paramlist);

                if (p != null)
                {
                    string[] list = p.Value.ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    if (list != null)
                    {
                        foreach (string s in list)
                        {
                            messageids.Add(Convert.ToInt64(s));
                        }
                    }
                }

                return messageids;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //public List<long> SaveMessage(List<UserContract> users,List<UserMessageContract> msgs)
        //{

        //    try
        //    {
        //        List<long> messageids = new List<long>();
        //        //string xml = Utility.SerializeObjectToXML(msgs);

                

        //        List<Parameter> paramlist = new List<Parameter>();
        //        //paramlist.Add(new Parameter("Subject", msg.Subject));
        //        //paramlist.Add(new Parameter("SenderID", msg.SenderID));
        //        //paramlist.Add(new Parameter("RecepientID", msg.RecepientID));
        //        //paramlist.Add(new Parameter("NativeLanguageMessage", msg.NativeLanguageMessage));
        //        Parameter p = new Parameter("MessageIDs", "", ParameterDirection.Output);
        //        int count = 1;
        //        string us = Utility.Serialize<List<UserContract>>(users);
        //        paramlist.Add(new Parameter("Users", us, DbType.Xml, ParameterDirection.Input));
        //        foreach (UserMessageContract msg in msgs)
        //        {
        //            string xml = Utility.Serialize<UserMessageContract>(msg);
        //            paramlist.Add(new Parameter("xml" + count, xml, DbType.Xml, ParameterDirection.Input));
        //            count++;
        //        }

        //        paramlist.Add(p);
        //        int affected = DatabaseHelper.ExecuteNonQuery("usp_ConsolidatedSaveMessage", paramlist);

        //        if (p != null)
        //        {
        //            string[] list = p.Value.ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        //            if (list != null)
        //            {
        //                foreach (string s in list)
        //                {
        //                    messageids.Add(Convert.ToInt64(s));
        //                }
        //            }
        //        }

        //        return messageids;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public int SaveMessageForLaterUser(UserMessageContract msg)
        {

            try
            {
                int messageid = 0;
                
                List<Parameter> paramlist = new List<Parameter>();
                //paramlist.Add(new Parameter("Subject", msg.Subject));
                //paramlist.Add(new Parameter("SenderID", msg.SenderID));
                //paramlist.Add(new Parameter("RecepientID", msg.RecepientID));
                //paramlist.Add(new Parameter("NativeLanguageMessage", msg.NativeLanguageMessage));
                Parameter p = new Parameter("ID", "", ParameterDirection.Output);
                if (msg.UserMailID > 0)
                    paramlist.Add(new Parameter("UserSavedMessageId", msg.UserMailID));

                paramlist.Add(new Parameter("UserID", msg.SenderID));
                paramlist.Add(new Parameter("LearningMessage", msg.LearningLanguageMessage));
                paramlist.Add(new Parameter("NativeMessage", msg.NativeLanguageMessage));
                paramlist.Add(new Parameter("OtherMessage", msg.OtherLanguageMessage));
                paramlist.Add(p);
                int affected = DatabaseHelper.ExecuteNonQuery("usp_SaveMessageForLaterUse", paramlist);

                if (p != null)
                {
                    messageid = Convert.ToInt32(p.Value);
                }

                return messageid;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool InsertFreeMessage(List<FreeMessageContract> messageList)
        {
            try
            {
                bool result = false;
                List<FreeMessageContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(messageList);
                paramlist.Add(new Parameter("xml", xml));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertFreeMessage", paramlist);
                result = affected > 0;

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool IsILike(long userid, long searcheeid)
        {

            try
            {
                bool ilike = false;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                paramlist.Add(new Parameter("SearcheeID", searcheeid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_IsIlike", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    ilike = Convert.ToBoolean(ds.Tables[0].Rows[0][0]);
                }

                return ilike;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserInterest(List<UserInterestContract> interestlist)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(interestlist);
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUserInterest", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserAboutMe(List<UserAboutMeContract> aboutmelist)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(aboutmelist);
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUserAboutMe", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool InsertBulkUser(int schoolid, List<UserContract> userlist)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(userlist);
                paramlist.Add(new Parameter("SchoolID", schoolid));
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertBulkUser", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool InsertUpdateBulkUser(int schoolid, List<UserContract> userlist)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(userlist);
                paramlist.Add(new Parameter("SchoolID", schoolid));
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUpdateBulkUser", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool AddVIPUser(List<VIPContract> viplist)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(viplist);
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUserVIP", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteVIPUser(List<VIPContract> viplist)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(viplist);
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteUserVIP", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool ClearSavedMessage(int userid)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_ClearSavedMessage", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool SignOut(long userID)
        {
            try
            {

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_SignOut", paramlist);

                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserMessageLikeRankingContract> GetUserMessageLikeRanking(long userid)
        {
            try
            {
                List<UserMessageLikeRankingContract> userrankingList = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter() { Name = "UserID", Value = userid });
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMessageLikeRanking", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    userrankingList = (List<UserMessageLikeRankingContract>)CollectionHelper.ConvertTo<UserMessageLikeRankingContract>(ds.Tables[0]);
                }

                return userrankingList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserTheme(long userid, string theme)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter() { Name = "UserID", Value = userid });
                paramlist.Add(new Parameter() { Name = "Theme", Value = theme });
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserTheme", paramlist);

                return (affected > 0);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool UpdateUserSkin(long userid, string skin)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter() { Name = "UserID", Value = userid });
                paramlist.Add(new Parameter() { Name = "Skin", Value = skin });
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserSkin", paramlist);

                return (affected > 0);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool UpdateUserDontShowVideo(long userid, bool dontshowvideo)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter() { Name = "UserID", Value = userid });
                paramlist.Add(new Parameter() { Name = "DontShowVideo", Value = dontshowvideo });
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserDontShowVideo", paramlist);

                return (affected > 0);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool UpdateUserDontShowNewTab(long userid, bool dontshownewtab)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter() { Name = "UserID", Value = userid });
                paramlist.Add(new Parameter() { Name = "DontShowNewTab", Value = dontshownewtab });
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserDontShowNewTab", paramlist);

                return (affected > 0);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool UpdateUserDontShowQuickGuide(long userid, bool dontshow)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter() { Name = "UserID", Value = userid });
                paramlist.Add(new Parameter() { Name = "DontShowQuickGuide", Value = dontshow });
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserDontShowQuickGuide", paramlist);

                return (affected > 0);
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool IsAfterSchoolTime(long userid)
        {

            try
            {
                bool asaccess = false;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_IsAfterSchoolTime", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    asaccess = Convert.ToBoolean(ds.Tables[0].Rows[0][0]);
                }

                return asaccess;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserAfterSchoolStatus(long userid, bool isaftershool, string parentsname, string parentsgivenname, string email)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                paramlist.Add(new Parameter("AfterSchool", isaftershool));
                paramlist.Add(new Parameter("ParentsName", parentsname));
                paramlist.Add(new Parameter("ParentsGivenName", parentsgivenname));
                paramlist.Add(new Parameter("Email", email));
                //paramlist.Add(new Parameter("DateOfBirth", tObject.DateOfBirth));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserAfterSchoolStatus", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteUserMail(string xml)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteUserMessage", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public long RegisterUser(UserContract uc)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("ParentsFullName", uc.ParentsName));
                paramlist.Add(new Parameter("ParentsEmail", uc.Email));
                paramlist.Add(new Parameter("FirstName", uc.FirstName));
                paramlist.Add(new Parameter("SchoolEntry", uc.SchoolEntry));
                paramlist.Add(new Parameter("Gender", uc.Gender ));
                paramlist.Add(new Parameter("Password", uc.Password));
                paramlist.Add(new Parameter("Reference", uc.Reference ));
                paramlist.Add(new Parameter("UserName", uc.UserName));
                paramlist.Add(new Parameter("ID", 0, DbType.Int64, ParameterDirection.Output));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_RegisterUser", paramlist);
                long userid = 0;
                if (affected > 0)
                {
                    List<Parameter> output = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (output != null)
                    {
                        userid = Convert.ToInt64(output[0].Value);
                    }

                }



                return userid;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserMessageContract> GetUserMessageListThatNeedResponse()
        {
            try
            {
                List<UserMessageContract> umlist = null;


                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserMessageThatNeedResponse", null);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    umlist = (List<UserMessageContract>)CollectionHelper.ConvertTo<UserMessageContract>(ds.Tables[0]);
                }

                return umlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserMessage(long usermailid)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserMailID", usermailid));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserMessage", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserContract> GetUserByIDs(List<UserContract> userlist)
        {
            try
            {
                List<UserContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                string xml = Utility.SerializeObjectToXML(userlist);
                paramlist.Add(new Parameter("xml", xml));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetUserListByIDs", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                }

                return users;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool SendAutoMail(long userID )
        {
            try
            {
                long mailid = 0;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("UserMailID", mailid, ParameterDirection.Output));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_SendAutoMail", paramlist);

                if (affected > 0)
                {
                    List<Parameter> output = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (output != null)
                    {
                        mailid = Convert.ToInt64(output[0].Value);
                    }
                }

                return mailid > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool MarkMessageAsUnRead(long senderid, long recipientid, List<long> mailList)
        {
            try
            {
                string xml = string.Empty;
                xml = "<UserMails>";
                foreach (long i in mailList)
                {
                    xml += string.Format("<IDS><ID>{0}</ID></IDS>", i.ToString());
                }
                xml += "</UserMails>";

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SenderId", senderid));
                paramlist.Add(new Parameter("RecipientID", recipientid));
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_MarkMessageAsUnRead", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public int GetMessageCountThatNeedsReply(long userid)
        {
            try
            {
                int count = 0;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMessageThatNeedsReply", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    count = ds.Tables[0].Rows.Count;
                }

                return count;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public UserContract GetLatestMessage(long userid)
        {
            try
            {
                UserContract user = null;
                List<UserContract> users = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userid));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetLatestMessage", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    users = (List<UserContract>)CollectionHelper.ConvertTo<UserContract>(ds.Tables[0]);
                    user = users[0];
                }

                return user;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int InsertTalkSubscription(UserTalkSubscription subs)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserName", subs.UserName));
                paramlist.Add(new Parameter("SessionTime", subs.SessionTime));
                paramlist.Add(new Parameter("BalanceTime", subs.BalanceTime));
                paramlist.Add(new Parameter("TotalTime", subs.TotalTime));
                paramlist.Add(new Parameter("IsActive", subs.IsActive));
                paramlist.Add(new Parameter("ID", 0, DbType.Int32, ParameterDirection.Output));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertTalkSubscription", paramlist);
                int subid = 0;
                if (affected > 0)
                {
                    List<Parameter> output = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
                    if (output != null)
                    {
                        subid = Convert.ToInt32(output[0].Value);
                    }
                }
                return subid;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //public int InsertTalkHistory(UserTalkHistory hist)
        //{
        //    try
        //    {
        //        List<Parameter> paramlist = new List<Parameter>();
        //        paramlist.Add(new Parameter("UserName", hist.UserName));
        //        paramlist.Add(new Parameter("TimeSpent", hist.TimeSpent));
        //        paramlist.Add(new Parameter("PartnerUserName", hist.PartnerUserName));
        //        paramlist.Add(new Parameter("ID", 0, DbType.Int32, ParameterDirection.Output));

        //        int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertTalkSubscription", paramlist);
        //        int subid = 0;
        //        if (affected > 0)
        //        {
        //            List<Parameter> output = paramlist.FindAll(x => x.Direction.Equals(ParameterDirection.Output));
        //            if (output != null)
        //            {
        //                subid = Convert.ToInt32(output[0].Value);
        //            }
        //        }
        //        return subid;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public UserTalkSubscription GetUserTalkSubscription(string username)
        {
            try
            {
                UserTalkSubscription sub = null;
                List<UserTalkSubscription> subs = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserName", username));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetTalkSubscription", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    subs = (List<UserTalkSubscription>)CollectionHelper.ConvertTo<UserTalkSubscription>(ds.Tables[0]);
                    sub = subs[0];
                }

                return sub;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateTalkSubscription(UserTalkSubscription tObject)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserTalkSubscriptionID", tObject.@UserTalkSubscriptionID));
                paramlist.Add(new Parameter("UserName", tObject.UserName));
                paramlist.Add(new Parameter("PartnerUserName", tObject.PartnerUserName));
                paramlist.Add(new Parameter("SessionTime", tObject.SessionTime));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateTalkSubscription", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateTalkStatus(long userID, bool status)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("Status", status));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_updateTalkStatus", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool AddConferenceRoom(string room, string caller, string callee, string roomKey)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Room", room));
                paramlist.Add(new Parameter("Caller", caller));
                paramlist.Add(new Parameter("Callee", callee));
                paramlist.Add(new Parameter("RoomKey", roomKey));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertConferenceRoom", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteConferenceRoom(string room)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Room", room));

                int affected = DatabaseHelper.ExecuteNonQuery("usp_DeleteConferenceRoom", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ConferenceRoomContract> GetConferenceRoomList(int schoolId)
        {
            try
            {
                List<ConferenceRoomContract> confList = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("SchoolID", schoolId.ToString()));

                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetConferenceRoomList", paramlist);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    confList = (List<ConferenceRoomContract>)CollectionHelper.ConvertTo<ConferenceRoomContract>(ds.Tables[0]);
                }

                return confList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool SaveUserPalette(long userID, List<long> paletteList)
        {
            try
            {
                string xml = string.Empty;
                xml = "<UserPalettes>";
                foreach (long i in paletteList)
                {
                    xml += string.Format("<IDS><ID>{0}</ID></IDS>", i.ToString());
                }
                xml += "</UserPalettes>";

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("[usp_InsertUserPalette]", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool DeleteUserPalette(long userID, List<long> paletteList)
        {
            try
            {
                string xml = string.Empty;
                xml = "<UserPalettes>";
                foreach (long i in paletteList)
                {
                    xml += string.Format("<IDS><ID>{0}</ID></IDS>", i.ToString());
                }
                xml += "</UserPalettes>";

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("[usp_DeleteUserPalette]", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserPhrase(long userID, List<WordReplace> phraseList)
        {
            try
            {
                string xml = string.Empty;
                xml = "<UserPhrases>";
                foreach (WordReplace k in phraseList)
                {
                    if (k.Sound == null)
                        k.Sound = "";
                    if (k.ImageFile == null)
                        k.ImageFile = "";
                    xml += string.Format("<IDS><ID>{0}</ID><WORD>{1}</WORD><SOUND>{2}</SOUND><IMAGEFILE>{3}</IMAGEFILE></IDS>", k.ID.ToString(), k.Word, k.Sound.Replace("../Content/sound/", ""), k.ImageFile.Replace("../Content/images/", ""));
                }
                xml += "</UserPhrases>";

                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("xml", xml));
                int affected = DatabaseHelper.ExecuteNonQuery("[usp_UpdateUserPhrase]", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UserMessageContract> GetMailExchangeForMonitoring(string sender, string recipient, DateTime? startDate, DateTime? endDate)
        {
            try
            {
                List<UserMessageContract> msg = null;
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("Sender", sender));
                paramlist.Add(new Parameter("Recipient", recipient));
                paramlist.Add(new Parameter("StartDate", startDate));
                paramlist.Add(new Parameter("EndDate", endDate));
                DataSet ds = DatabaseHelper.ExecuteQuery("usp_GetMailExchangeForMonitoring", paramlist);
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

        public bool ChangePassword(long userID, string password)
        {
            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userID));
                paramlist.Add(new Parameter("Password", password));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_ChangePassword", paramlist);
                return (affected > 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateUserParentsInfo(long userId)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userId));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_UpdateUserParentsInfo", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool InsertUserAttendance(UserAttendanceContract userAttendance)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userAttendance.UserID));
                paramlist.Add(new Parameter("Schedule", userAttendance.Schedule));
                paramlist.Add(new Parameter("Score", userAttendance.Score));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUserAttendance", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool InsertUserOtherPoints(UserOtherPointsContract userPoints)
        {

            try
            {
                List<Parameter> paramlist = new List<Parameter>();
                paramlist.Add(new Parameter("UserID", userPoints.UserID));
                paramlist.Add(new Parameter("Type", userPoints.Type));
                paramlist.Add(new Parameter("Points", userPoints.Points));
                int affected = DatabaseHelper.ExecuteNonQuery("usp_InsertUserOtherPoints", paramlist);

                return affected > 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

