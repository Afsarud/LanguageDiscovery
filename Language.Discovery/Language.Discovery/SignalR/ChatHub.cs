using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Threading.Tasks;
using Language.Discovery.Entity;
using Language.Discovery.UserService;
using System.Web.Script.Serialization;
using Microsoft.AspNet.SignalR.Hubs;

namespace Language.Discovery
{
    [HubName("chatHub")]
    public class ChatHub : Hub
    {
        
        public override Task OnConnected()
        {
            var newUser = OnlineUser.OnlineUserList.Where(item => item.IsOnline).Select(item => item.UserID).ToList();
            ChatUser user = OnlineUser.OnlineUserList.Where(item => item.SessionID == HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString()).SingleOrDefault();
            List<ChatUser> user1 = OnlineUser.OnlineUserList.FindAll(item => item.UserID.ToString() == HttpContext.Current.User.Identity.Name && item.SessionID != HttpContext.Current.Request.Cookies["ASP.NET_SessionId"].Value.ToString());
            if (user != null)
            {
                user.ConnectionID = Context.ConnectionId;

            }
            if (user1 != null && user1.Count() > 0 )
            {
                foreach(ChatUser u in user1)
                {
                    Clients.All.userLogout(u.SessionID);
                }
                
            }

            return Clients.All.joined(Context.ConnectionId, newUser);
        }

        public override Task OnReconnected()
        {
            return base.OnReconnected();
        }

        public override Task OnDisconnected(bool stopCalled)
        {
            var user = OnlineUser.OnlineUserList.FirstOrDefault(x => x.ConnectionID == Context.ConnectionId);
            //var item = OnlineUser.FirstOrDefault(x => x.ConnectionId == Context.ConnectionId);
            if (user != null)
            {
                OnlineUser.Remove(user);
                var id = Context.ConnectionId;
                Clients.All.onUserDisconnected(id, user.UserID);

            }

            return base.OnDisconnected(stopCalled);
        }

        public void Send(string to, string from, string learning, string native, string otherlanguages , string groupName, string keywords)
        {
            if (Clients != null)
            {
                List<OtherMessage> othermessages = new JavaScriptSerializer().Deserialize<List<OtherMessage>>(otherlanguages.Replace(@"\","/"));
                string[] oll;
                string[] oln;
                //temporary only to get the first index
                List<UserContract> list = GetUserDetails(to);
                UserMessageContract umc = new UserMessageContract();
                oll = othermessages.Find(x => x.LanguageCode == list[0].LearningLanguage).Message.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                oln = othermessages.Find(x => x.LanguageCode == list[0].NativeLanguage).Message.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

                long[] ids = SendToGroup(to, from, learning, native, othermessages, keywords);
                if( ids == null )
                    Clients.Group(groupName).addMessage(0, to, from, "Error Sending Message","", groupName, "");
                if (string.IsNullOrEmpty(groupName) || OnlineUser.OnlineUserList.Count <= 1)
                {
                    Clients.Caller.sendToMailBox(to, from, learning + "|" + native, (oll.Length > 0 ? oll[0] : string.Empty) + "|" + (oln.Length > 0 ? oln[0] : string.Empty));
                    var username = Context.User.Identity.Name;
                    Clients.Client(username).notifyUser(from, learning + "|" + native);
                }
                else
                {

                    Clients.Group(groupName)
                        .addMessage(ids.Length > 0 ? ids[0] : 0, to, from, learning + "|" + native, (oll.Length > 0 ? oll[0] : string.Empty) + "|" + (oln.Length > 0 ? oln[0] : string.Empty), groupName, keywords);
                }
            }
        }

        public void GetAllOnlineStatus()
        {
            Clients.Caller.OnlineStatus(Context.ConnectionId, OnlineUser.OnlineUserList.Select(item => item.UserID).ToList());
        }

        public string GetUniqueGroupName(long currentuserid, long toConnectTo)
        {
            string group = (currentuserid.GetHashCode() ^ toConnectTo.GetHashCode()).ToString();
            return group;
        }
        public void CreateGroup(long currentuserid, long toConnectTo)
        {
            string groupName = GetUniqueGroupName(currentuserid, toConnectTo);
            string connectionid_to = OnlineUser.OnlineUserList.Where(item => item.UserID.Equals(toConnectTo)).Select(item => item.ConnectionID).FirstOrDefault();
            if (!string.IsNullOrEmpty(connectionid_to))
            {
                Groups.Add(Context.ConnectionId, groupName);
                Groups.Add(connectionid_to, groupName);
                //Clients.Caller.setChatGroup(groupName, toConnectTo);
                //Clients.Caller.setChatGroup(groupName);
            }
            else
            {
                Groups.Add(Context.ConnectionId, groupName);
            }
            Clients.Caller.setChatGroup(groupName);
        }

        private long[] SendToGroup( string usertos, string senderid, string learning, string native, List<OtherMessage> othermessages, string keyword )
        {
            //btnSend.Enabled = false;
            string learningsentence = learning;
            string nativesentence = native;

            string[] ls = learningsentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            string[] ns = nativesentence.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            string[] oll;
            string[] oln;

            List<UserMessageContract> msgList = new List<UserMessageContract>();
            List<long> userids = new List<long>();
            List<UserContract> list = new List<UserContract>();
            if (!string.IsNullOrEmpty(usertos))
            {
                list = GetUserDetails(usertos);

            }
            ///else
            //{
            //    userids.Add(!string.IsNullOrEmpty(Request.QueryString["to"]) ? Convert.ToInt64(Request.QueryString["to"]) : 0);
            //}

            foreach (UserContract user in list)
            {
                UserMessageContract umc = new UserMessageContract();
                oll = othermessages.Find(x => x.LanguageCode == user.LearningLanguage).Message.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
                oln = othermessages.Find(x => x.LanguageCode == user.NativeLanguage).Message.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries);

                for (int i = 0; i < ls.Count(); i++)
                {

                    umc.SenderID = Convert.ToInt64(senderid);
                    umc.RecepientID = user.UserID;

                    umc.LearningLanguageMessage += "<div class='paletteContainer'>" + HttpUtility.HtmlEncode(ls[i] + "</div>");
                    umc.NativeLanguageMessage += "<div class='paletteContainer'>" + HttpUtility.HtmlEncode(ns[i] + "</div>");
                    umc.LearningLanguageMessageRecepient += oll.Length > 0 ? "<div class='paletteContainer'>" + HttpUtility.HtmlEncode(oll[i] + "</div>") : string.Empty;
                    umc.NativeLanguageMessageRecepient += oln.Length > 0 ? "<div class='paletteContainer'>" + HttpUtility.HtmlEncode(oln[i] + "</div>") : string.Empty; 

                    umc.Keyword = keyword;
                    umc.HasResponse = false; 
                    //umc.Subject = txtSubject.Text;

                }

                msgList.Add(umc);
            }
            //string s = Utility.SerializeObjectToXML(msgList);

            UserClient client = new UserClient();
            string json = new JavaScriptSerializer().Serialize(msgList);
            long[] ids = client.SaveMessage(json);
            return ids;
        }

        private List<UserContract> GetUserDetails(string usertos)
        {
            List<UserContract> list = new List<UserContract>();
            list = new List<UserContract>(usertos.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(s => new UserContract() { UserID = int.Parse(s) }));
            UserContract[] usl = new UserClient().GetUserByIDs(list.ToArray());

            return usl.ToList();
        }

        public void Call(string receiver,string from, string groupname, string room, string roomKey)
        {
            //Clients.Client(username).callUser(from, room);
            Clients.Group(groupname).callUser(receiver,from, room, groupname, roomKey);
            Clients.Group(groupname).userCallingFromOtherPage(receiver, from, room, groupname, roomKey);
            //Clients.All.callUser(receiver, from, room, groupname);
        }

        public void Answered(string groupname, string from, string roomKey)
        {
            //Clients.Client(username).callUser(from, room);
            Clients.Group(groupname).callAnswered(groupname, from, roomKey);
        }
        public void Rejected(string groupname, string from)
        {
            //Clients.Client(username).callUser(from, room);
            Clients.Group(groupname).callRejected(groupname, from);
        }

        public void Hangup(string from,string groupname, string room)
        {
            //Clients.Client(username).callUser(from, room);
            Clients.Group(groupname).callHangUp(from, groupname, room);
        }

        public void Ended(string from, string groupname, string room)
        {
            //Clients.Client(username).callUser(from, room);
            Clients.Group(groupname).callEnded(from, groupname, room);
        }

        public void CanTalk(int from, string groupname, bool cantalk)
        {
            //Clients.Client(username).callUser(from, room);
            Clients.All.userCanTalkNow(from, groupname, cantalk);
        }

        public void IAmOnline(int from, bool isOnline)
        {
            Clients.All.userOnline(from, isOnline);
        }

        public void CantTalkToYou(string from)
        {
            //Clients.Client(username).callUser(from, room);
            Clients.All.userCantTalkToYou(from);
        }

        public void Signout(string from)
        {
            Clients.All.userSignedout(from);
        }


        public void LogoutSession(string id)
        {
            Clients.All.logoutSession(id);
        }

        public void Ping(string to,string from, string groupname, string room)
        {
            Clients.Group(groupname).userPing(from, groupname, room);
        }

        public void Acknowledge(string from, string groupname, string room)
        {
            Clients.Group(groupname).userAcknowledged(from, groupname, room);
        }

        public void PartnerCameraChanged(string from, string groupname, bool isCameraChanged)
        {
            Clients.Group(groupname).userPartnerCameraChanged(from, groupname, isCameraChanged);
        }

        public void AddUser(long userId)
        {
            Clients.All.AddUser(userId);
        }

    }
    

}