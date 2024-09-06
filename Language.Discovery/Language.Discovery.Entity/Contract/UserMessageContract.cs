using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Language.Discovery.Entity
{
    [DataContract]
    [Serializable]
    public class UserMessageContract
    {
        [DataMember]
        public long UserMailID { get; set; }
        [DataMember]
        public string Subject { get; set; }
        [DataMember]
        public long SenderID { get; set; }
        [DataMember]
        public long RecepientID { get; set; }
        [DataMember]
        public string Sender { get; set; }
        [DataMember]
        public string Recepient { get; set; }
        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public string NativeLanguageMessage { get; set; }
        [DataMember]
        public string LearningLanguageMessage { get; set; }
        [DataMember]
        public string OtherLanguageMessage { get; set; }

        [DataMember]
        public DateTime ReadDate { get; set; }
        [DataMember]
        public bool IsActive { get; set; }
        [DataMember]
        public bool IsReply { get; set; }
        [DataMember]
        public string CssClass { get; set; }
        [DataMember]
        public string RecepientAvatar { get; set; }
        [DataMember]
        public string SenderAvatar { get; set; }
        [DataMember]
        public bool Reviewed { get; set; }
        [DataMember]
        public long ReviewedByID { get; set; }
        [DataMember]
        public bool HasFilteredWords { get; set; }
        [DataMember]
        public string FilteredWords { get; set; }
        [DataMember]
        public bool IsLike { get; set; }
        [DataMember]
        public string RecepientSchool { get; set; }
        [DataMember]
        public string SenderSchool { get; set; }
        [DataMember]
        public string Keyword { get; set; }
        [DataMember]
        public bool IsFromNewFriends { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public bool NeedResponse { get; set; }
        [DataMember]
        public bool HasResponse { get; set; }
        [DataMember]
        public string NativeLanguage { get; set; }
        [DataMember]
        public string LearningLanguage { get; set; }
        [DataMember]
        public bool IsDirectReply { get; set; }
        [DataMember]
        public bool IsLastMessage { get; set; }
        [DataMember]
        public bool IsRejected { get; set; }
	    [DataMember]
        public string NativeLanguageMessageRecepient { get; set; }
        [DataMember]
        public string LearningLanguageMessageRecepient { get; set; }
        [DataMember]
        public string CssClass2 { get; set; }
        [DataMember]
        public string RecepientLearningLanguage { get; set; }
        [DataMember]
        public string RecepientNativeLanguage { get; set; }
        [DataMember]
        public string SenderLearningLanguage { get; set; }
        [DataMember]
        public string SenderNativeLanguage { get; set; }
        [DataMember]
        public string EnglishLanguageMessage{ get; set; }
        [DataMember]
        public bool SentFromPool { get; set; }
    }
}
