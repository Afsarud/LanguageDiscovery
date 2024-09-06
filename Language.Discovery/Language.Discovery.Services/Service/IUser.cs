using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Language.Discovery.Entity;
using System.ServiceModel.Web;
using System.Data;

namespace Language.Discovery.Services.Service
{
    [ServiceContract]
    public interface IUser
    {
        [OperationContract]
        [WebGet(ResponseFormat=WebMessageFormat.Json)]
        string Authenticate(string username, string password);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string AuthenticateAdmin(string username, string password);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool SaveImage(long userID, PhotoContract photo);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetUserPhoto(long userID, long albumID);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        string GetWhoLikedMe(long userID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserStatus(long userID, string status);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserAvatar(long userID, string avatar);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetUserDetails(long userID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetUserFriends(long userid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetUserDetailsByUserName(string userName);
        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchUser(string name, long searcheeid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string DiscoverNewFriends(List<int> interestids, long searcheeid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string DiscoverNewFriends2(List<int> interestids, int cityid, string name, long searcheeid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string DiscoverNewFriends3(DiscoverNewFriendsDTO dto);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchUserWithMessage(string name, long searcheeid, MailBoxUserType mailboxUserType);


        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool AddFriend(long userID, long useridtoadd);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UnFriend(long userID, long useridtounfriend);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteUserPhoto(string xml);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdatePhotoDescription(long userPhotoId, string desc);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchPeople(int countryid, int cityid, string type, string name, long searcheeid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool LikeUnLike(long userID, long userIDToLike, long userstatusid, bool iscurrentLike);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool LikeUnLikePhoto(long userID, long userPhotoID, bool iscurrentLike);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetMessageTrailBySenderID(long senderid, long recepientid,int pagenumber, int rowsperpage);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        List<long> SaveMessage(string json);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        int GetUnreadMessage(long userid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool MarkMessageAsRead(long senderid, long recipientid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool IsILike(long userid, long searcheeid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserInterestContract> GetUserInterest(long userid, string languagecode);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserInterest(List<UserInterestContract> interestlist);
		
		[OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        int AddUser(UserContract tObject);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUser(UserContract tObject);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteUser(int id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        UserContract GetByID(long id);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string SearchUserAdmin(SearchUserDTO tObject, out int virtualcount);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool SignOut(long userid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserAboutMe(List<UserAboutMeContract> aboutmelist);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserAboutMeContract> GetUserAboutMe(long userid, string languagecode);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateOtherUserInfo(UserContract tObject);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool InsertBulkUser(int schoolid,List<UserContract> tObject);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserActivity(long userID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetDuplicateUsers(List<UserContract> userlist);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetMessageDetailByUserMailID(long userMailID);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool AddVIPUser(List<VIPContract> viplist);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool RemoveVIPUser(List<VIPContract> viplist);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool LikeUnLikeMessage(long usermailid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserMessageLikeRankingContract> GetUserMessageLikeRanking(long userid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserTheme(long userid, string theme);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserDontShowVideo(long userid, bool dontshowvideo);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserDontShowNewTab(long userid, bool dontshownewtab);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserSkin(long userid, string skin);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool IsAfterSchoolTime(long userid);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserAfterSchoolStatus(long userid, bool isaftershool, string parentsname, string parentsgivenname, string email);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserContract> GetUserListBySchool(int schoolID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetDSUserListBySchool(int schoolID);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool InsertUpdateBulkUser(int schoolid, List<UserContract> userlist);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool DeleteUserMail(string xml);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        long RegisterUser(UserContract uc);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserContract> GetUserListBySchoolForTrackingOrProgress(int schoolID);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserTrackProgress(List<UserContract> userlist);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool UpdateUserOptions(UserContract tObject);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool InsertFreeMessage(List<FreeMessageContract> messageList);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        List<UserContract> GetUserByIDs(List<UserContract> userlist);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
        bool SendAutoMail(long userID);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        bool MarkMessageAsUnRead(long senderid, long recipientid, List<long> mailList);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        int GetMessageCountThatNeedsReply(long userid);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        string GetMailMessages(string type, long senderid, long recepientid, int pagenumber, int rowsperpage);

        [OperationContract]
        [WebGet(ResponseFormat = WebMessageFormat.Json)]
        UserContract GetLatestMessage(long userid);
    }


}
