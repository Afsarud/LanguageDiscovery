using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using Language.Discovery.Entity;
using Language.Discovery.Repository;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Configuration;
using System.IO;
using System.Drawing;
using System.Web;
using System.Data;

namespace Language.Discovery.Services.Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "UserService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select UserService.svc or UserService.svc.cs at the Solution Explorer and start debugging.
    public class UserService : IUser
    {

        public string Authenticate(string username, string password)
        {
            UserContract user = null;
            try
            {
                UserRepository rep = new UserRepository();
                user =  rep.Authenticate(username, password);
                string json = new JavaScriptSerializer().Serialize(user);
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

        public string AuthenticateAdmin(string username, string password)
        {
            UserContract user = null;
            try
            {
                UserRepository rep = new UserRepository();
                user = rep.Authenticate(username, password, true);
                string json = new JavaScriptSerializer().Serialize(user);
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


        public string GetUserPhoto(long userID, long albumID)
        {
            List<PhotoContract> list= null;
            try
            {
                UserRepository rep = new UserRepository();
                list = rep.GetUserPhoto(userID, albumID);
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

        public string GetWhoLikedMe(long userID)
        {
            List<WhoLikedMeContract> list = null;
            try
            {
                UserRepository rep = new UserRepository();
                list = rep.GetWhoLikedMed(userID);
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

        public string GetUserDetails(long userID)
        {
            try
            {
                UserRepository rep = new UserRepository();
                UserContract user = rep.GetUserDetails(userID);
                string json = new JavaScriptSerializer().Serialize(user);
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


        public int GetUnreadMessage(long userID)
        {
            try
            {
                UserRepository rep = new UserRepository();
                int unread  = rep.GetUnreadMessage(userID);
                return unread;
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

        public string GetUserDetailsByUserName(string userName)
        {
            try
            {
                UserRepository rep = new UserRepository();
                UserContract user = rep.GetUserDetailsByUserName(userName);
                string json = new JavaScriptSerializer().Serialize(user);
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

        public string GetUserFriends(long userID)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserFriendsContract> users = rep.GetUserFriends(userID);
                string json = new JavaScriptSerializer().Serialize(users);
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


        public bool UpdateUserStatus(long userID, string status)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.UpdateUserStatus(userID, status);

                return success;
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

        public bool UpdateUserAvatar(long userID, string avatar)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.UpdateUserAvatar(userID, avatar);

                return success;
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

        public bool MarkMessageAsRead(long senderid, long recipientid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.MarkMessageAsRead(senderid, recipientid);

                return success;
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


        public bool AddFriend(long userID, long useridtoadd)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.AddFriend(userID, useridtoadd);

                return success;
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

        
        public bool UpdatePhotoDescription(long userPhotoId, string desc)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.UpdatePhotoDescription(userPhotoId, desc);

                return success;
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

        public bool UnFriend(long userID, long useridtounfriend)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.UnFriend(userID, useridtounfriend);

                return success;
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

        public bool DeleteUserPhoto(string xml)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.DeleteUserPhoto(xml);

                return success;
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


        public string SearchUser(string name, long searcheeid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserSearchContract> users = rep.SearchUser(name, searcheeid);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public string GetDuplicateUsers(List<UserContract> userlist)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserContract> users = rep.GetDuplicateUsers(userlist);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public string DiscoverNewFriends(List<int> interestids, long searcheeid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserSearchContract> users = rep.DiscoverNewFriends(interestids, searcheeid);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public string DiscoverNewFriends2(List<int> interestids, int cityid, string name, long searcheeid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserSearchContract> users = rep.DiscoverNewFriends(interestids,cityid, name, searcheeid);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public string DiscoverNewFriends3(DiscoverNewFriendsDTO dto)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserSearchContract> users = rep.DiscoverNewFriends(dto);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public string SearchUserWithMessage(string name, long searcheeid, MailBoxUserType mailboxUserType)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserSearchContract> users = rep.SearchUserWithMessage(name, searcheeid, mailboxUserType);
                string json = new JavaScriptSerializer().Serialize(users);
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


        public string SearchPeople(int countryid, int cityid, string type, string name, long searcheeid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<PeopleSearchContract> users = rep.SearchPeople(countryid, cityid, type,name, searcheeid);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public string GetMessageTrailBySenderID(long senderid, long recepientid, int pagenumber, int rowsperpage)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserMessageContract> users = rep.GetMessageTrailBySenderID(senderid, recepientid, pagenumber, rowsperpage);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public string GetMessageDetailByUserMailID(long userMailID)
        {
            try
            {
                UserRepository rep = new UserRepository();
                UserMessageContract users = rep.GetMessageDetailByUserMailID(userMailID);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public List<long> SaveMessage(string json)
        {
            try
            {
                List<long> ids = new List<long>();
                UserRepository rep = new UserRepository();
                List<UserMessageContract> msgs = new JavaScriptSerializer().Deserialize<List<UserMessageContract>>(json);
                ids = rep.SaveMessage(msgs);

                return ids;
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

        public bool LikeUnLike(long userID, long userIDToLike, long userstatusid, bool iscurrentLike)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.LikeUnLike(userID, userIDToLike, userstatusid, iscurrentLike);

                return success;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool LikeUnLikePhoto(long userID, long userPhotoID, bool iscurrentLike)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.LikeUnLikePhoto(userID, userPhotoID, iscurrentLike);

                return success;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool IsILike(long userID, long searcheeid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool ilike = rep.IsILike(userID, searcheeid);

                return ilike;
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
                UserRepository rep = new UserRepository();
                bool success = rep.LikeUnLikeMessage(usermailid);

                return success;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool SaveImage(long userID,PhotoContract photoContract)
        {
            bool error = false;
            string dirName = ConfigurationManager.AppSettings["ImagePath"];
            string finaldirectory = dirName + "\\" + userID.ToString() + "\\";
            string guid = Guid.NewGuid().ToString().Replace("-", string.Empty);
            string finalfilename = Path.GetFileNameWithoutExtension(photoContract.Photo) + "_" + guid + Path.GetExtension(photoContract.Photo);

            try
            {
                Stream imgStream = new MemoryStream(photoContract.ImageBytes);
                Image image = Image.FromStream(imgStream);
                Bitmap bmpImage = new Bitmap(image);
                
                //string fileName = dirName + @"\" + photoContract.Image;
                
                if (!Directory.Exists(finaldirectory))
                {
                    Directory.CreateDirectory(finaldirectory);
                }
                
                image.Save(finaldirectory + "\\" +  finalfilename);
                imgStream.Close();

                UserRepository rep = new UserRepository();
                bool success = rep.SaveImageDetails(userID, finalfilename, photoContract.Description);

                return success;

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

        public bool UpdateUserInterest(List<UserInterestContract> interestlist)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool updated = rep.UpdateUserInterest(interestlist);

                return updated;
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
                UserRepository rep = new UserRepository();
                bool updated = rep.UpdateUserAboutMe(aboutmelist);

                return updated;
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
                UserRepository rep = new UserRepository();
                bool updated = rep.AddVIPUser(viplist);

                return updated;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool RemoveVIPUser(List<VIPContract> viplist)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool updated = rep.DeleteVIPUser(viplist);

                return updated;
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
                UserRepository rep = new UserRepository();
                List<UserInterestContract> list = rep.GetUserInterest(userid, languagecode);

                return list;
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
                UserRepository rep = new UserRepository();
                List<UserAboutMeContract> list = rep.GetUserAboutMe(userid, languagecode);

                return list;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
		
		  public int AddUser(UserContract tObject)
        {
            try
            {
                UserRepository rep = new UserRepository();
                int Userid = Convert.ToInt32(rep.Add(tObject));

                return Userid;

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

        public bool UpdateUser(UserContract tObject)
        {
            try
            {
                UserRepository rep = new UserRepository();

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

        public bool UpdateOtherUserInfo(UserContract tObject)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateOtherUserInfo(tObject);
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

        public bool DeleteUser(int id)
        {
            try
            {
                UserRepository rep = new UserRepository();
                UserContract sc = new UserContract();
                sc.UserID = id;

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

        public UserContract GetByID(long id)
        {
            try
            {
                UserRepository rep = new UserRepository();

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

        public string SearchUserAdmin(SearchUserDTO tObject, out int virtualcount)
        {
            try
            {
                UserRepository rep = new UserRepository();
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

        public bool InsertBulkUser(int schoolid, List<UserContract> tObject)
        {
            try
            {
                bool result = false;

                result = new UserRepository().InsertBulkUser(schoolid, tObject);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
            
        public bool InsertUpdateBulkUser(int schoolid, List<UserContract> tObject)
        {
            try
            {
                bool result = false;

                result = new UserRepository().InsertUpdateBulkUser(schoolid, tObject);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool SignOut(long userid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                
                return rep.SignOut(userid);
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

        public bool UpdateUserActivity(long userid)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateUserActivity(userid);
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

        public bool UpdateUserTheme(long userid, string theme)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateUserTheme(userid, theme);
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

        public bool UpdateUserSkin(long userid, string skin)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateUserSkin(userid, skin);
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

        public bool UpdateUserDontShowVideo(long userid, bool dontshowvideo)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateUserDontShowVideo(userid, dontshowvideo);
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


        public bool UpdateUserDontShowNewTab(long userid, bool dontshownewtab)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateUserDontShowNewTab(userid, dontshownewtab);
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

        public bool IsAfterSchoolTime(long userid)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.IsAfterSchoolTime(userid);
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

        
        public List<UserMessageLikeRankingContract> GetUserMessageLikeRanking(long userid)
        {
            try
            {

                UserRepository rep = new UserRepository();
                List<UserMessageLikeRankingContract> userrank = rep.GetUserMessageLikeRanking(userid);
                return userrank;
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

        public bool UpdateUserAfterSchoolStatus(long userid, bool isaftershool, string parentsname, string parentsgivenname, string email)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateUserAfterSchoolStatus(userid, isaftershool, parentsname, parentsgivenname, email);
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

        public string GetDSUserListBySchool(int schoolID)
        {
            try
            {

                UserRepository rep = new UserRepository();
                DataSet users = rep.GetDSUserListBySchool(schoolID);
                return users.GetXml();
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

        public List<UserContract>  GetUserListBySchool(int schoolID)
        {
            try
            {

                UserRepository rep = new UserRepository();
                List<UserContract> users = rep.GetUserListBySchool(schoolID);
                return users;
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

        public bool DeleteUserMail(string xml)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool deleted = rep.DeleteUserMail(xml);
                return deleted;
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
                UserRepository rep = new UserRepository();
                long id = rep.RegisterUser(uc);
                return id;
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

                UserRepository rep = new UserRepository();
                List<UserContract> users = rep.GetUserListBySchoolForTrackingOrProgress(schoolID);
                return users;
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

        public bool UpdateUserTrackProgress(List<UserContract> userlist)
        {
            try
            {

                UserRepository rep = new UserRepository();
                bool success = rep.UpdateUserTrackProgress(userlist);
                return success;
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

        public bool UpdateUserOptions(UserContract tObject)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.UpdateUserOptions(tObject);
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

        public bool InsertFreeMessage(List<FreeMessageContract> messageList)
        {
            try
            {
                UserRepository rep = new UserRepository();

                return rep.InsertFreeMessage(messageList);
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

        public List<UserContract> GetUserByIDs(List<UserContract> userlist)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserContract> users = rep.GetUserByIDs(userlist);

                return users;
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

        public bool SendAutoMail(long userID)
        {
            try
            {
                bool sent = false;
                UserRepository rep = new UserRepository();
                sent = rep.SendAutoMail(userID );

                return sent;
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

        public bool MarkMessageAsUnRead(long senderid, long recipientid, List<long> mailList)
        {
            try
            {
                UserRepository rep = new UserRepository();
                bool success = rep.MarkMessageAsUnRead(senderid, recipientid, mailList);

                return success;
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

        public int GetMessageCountThatNeedsReply(long userid)
        {
            try
            {
                int count = 0;
                UserRepository rep = new UserRepository();
                count = rep.GetMessageCountThatNeedsReply(userid);

                return count;
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

        public string GetMailMessages(string type, long senderid, long recepientid, int pagenumber, int rowsperpage)
        {
            try
            {
                UserRepository rep = new UserRepository();
                List<UserMessageContract> users = rep.GetMailMessages(type, senderid, recepientid, pagenumber, rowsperpage);
                string json = new JavaScriptSerializer().Serialize(users);
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

        public UserContract GetLatestMessage(long userid)
        {
            try
            {
                UserRepository rep = new UserRepository();
                UserContract user = rep.GetLatestMessage(userid);

                return user;
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
