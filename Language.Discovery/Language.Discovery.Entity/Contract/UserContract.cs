using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;


namespace Language.Discovery.Entity
{
    [DataContract]
    [Serializable]
    public partial class UserContract
    {
        private List<PhotoContract> _photoList = null;//new List<PhotoContract>();

        [DataMember]
        public Int64 UserID { get; set; }
        [DataMember]
        public string UserName{ get; set; }
        [DataMember]
        public string FirstName{ get; set; }
        [DataMember]
        public string MiddleName{ get; set; }
        [DataMember]
        public string LastName{ get; set; }
        [DataMember]
        public string Address{ get; set; }
        [DataMember]
        public System.DateTime DateOfBirth { get; set; }
        [DataMember]
        public string Telephone{ get; set; }
        [DataMember]
        public string Fax{ get; set; }
        [DataMember]
        public string Email{ get; set; }
        [DataMember]
        public string Password{ get; set; }
        [DataMember]
        public string Password2{ get; set; }
        [DataMember]
        public System.DateTime CreateDate{ get; set; }
        [DataMember]
        public System.Nullable<System.DateTime> ModifiedDate{ get; set; }
        [DataMember]
        public System.Nullable<int> ClassID{ get; set; }
        [DataMember]
        public string ClassName { get; set; }
        [DataMember]
        public int UserTypeID{ get; set; }
        [DataMember]
        public string UserTypeName { get; set; }
        [DataMember]
        public int CountryID{ get; set; }
        [DataMember]
        public string CountryName { get; set; }
        [DataMember]
        public int CityID { get; set; }
        [DataMember]
        public string CityName { get; set; }
        [DataMember]
        public int SchoolID{ get; set; }
        [DataMember]
        public string Name1 { get; set; }
        [DataMember]
        public int LevelID { get; set; }
        [DataMember]
        public string LevelName { get; set; }
        [DataMember]
        public bool IsPalleteVisible{ get; set; }
        [DataMember]
        public bool IsActive{ get; set; }
        [DataMember]
        public string StatusText { get; set; }
        [DataMember]
        public string Avatar { get; set; }
        [DataMember]
        public string NativeLanguage { get; set; }
        [DataMember]
        public string LearningLanguage { get; set; }
        [DataMember]
        public string SubNativeLanguage { get; set; }
        [DataMember]
        public string SubNativeLanguage2 { get; set; }
        [DataMember]
        public string OtherLanguage { get; set; }
        [DataMember]
        public List<string> OtherLanguages { get; set; }
        [DataMember]
        public string TeachersName { get; set; }
        [DataMember]
        public string ParentsName { get; set; }
        [DataMember]
        public string ProfilePhoto { get; set; }
        [DataMember]
        public int LikeCount { get; set; }
        [DataMember]
        public DateTime LastLogin { get; set; }
        [DataMember]
        public bool IsOnline { get; set; }
        [DataMember]
        public long UserStatusID { get; set; }
        [DataMember]
        public int UnReadMessageCount { get; set; }
        [DataMember]
        public string Gender { get; set; }
        [DataMember]
        public List<PhotoContract> PhotoList
        {
            get
            {
                if (_photoList == null)
                {
                    _photoList = new List<PhotoContract>();
                }
                return _photoList;
            }
            set
            {
                _photoList = value;
            }
        }
        [DataMember]
        public bool AfterSchool { get; set; }
        [DataMember]
        public bool HasAgreedTC { get; set; }
        [DataMember]
        public string Theme { get; set; }
        [DataMember]
        public int GradeID { get; set; }
        [DataMember]
        public string GradeName { get; set; }
        [DataMember]
        public bool DontShowVideo { get; set; }
        [DataMember]
        public bool DontShowNewTab { get; set; }
        [DataMember]
        public string Skin { get; set; }
        [DataMember]
        public bool IsDemo { get; set; }
        [DataMember]
        public bool IsTrialExpired { get; set; }
        [DataMember]
        public string PermissionStatus { get; set; }
        [DataMember]
        public bool IsRobot { get; set; }
        [DataMember]
        public string Reference { get; set; }
        [DataMember]
        public bool AllowTalk { get; set; }
        [DataMember]
        public string SchoolEntry { get; set; }
        [DataMember]
        public DateTime? TrialExpirationDate { get; set; }
        [DataMember]
        public string Furigana { get; set; }
        [DataMember]
        public string Custom1 { get; set; }
        [DataMember]
        public string Custom2 { get; set; }
        [DataMember]
        public string Custom3 { get; set; }
        [DataMember]
        public string Custom4 { get; set; }
        [DataMember]
        public string Custom5 { get; set; }
        [DataMember]
        public string Note1 { get; set; }
        [DataMember]
        public string Note2 { get; set; }
        [DataMember]
        public string Note3 { get; set; }
        [DataMember]
        public string Note4 { get; set; }
        [DataMember]
        public string Note5 { get; set; }
        [DataMember]
        public bool SequenceOptionFlag { get; set; }
        [DataMember]
        public bool NativeOptionFlag { get; set; }
        [DataMember]
        public bool SubLanguageOptionFlag { get; set; }
        [DataMember]
        public bool SubLanguage2OptionFlag { get; set; }
        [DataMember]
        public bool StepOptionFlag { get; set; }
        [DataMember]
        public bool IsOptionUpdated { get; set; }
        [DataMember]
        public bool SendPasswordToTeacher { get; set; }
        [DataMember]
        public string TeachersEmail { get; set; }
        [DataMember]
        public string StatusImage { get; set; }
        [DataMember]
        public string OnlineStatusText { get; set; }
        [DataMember]
        public string NativeLanguageMessageRecepient { get; set; }
        [DataMember]
        public string LearningLanguageMessageRecepient { get; set; }
        [DataMember]
        public string NativeLanguageMessage { get; set; }
        [DataMember]
        public string LearningLanguageMessage { get; set; }
        [DataMember]
        public bool EnabledFreeMessage{ get; set; }
        [DataMember]
        public bool SoundAndMail { get; set; }

        [DataMember]
        public bool IsCanTalk { get; set; }
        [DataMember]
        public int TotalTime { get; set; }
        [DataMember]
        public int BalanceTime { get; set; }
        [DataMember]
        public int SessionTime { get; set; }
        [DataMember]
        public bool ShouldUpdateTalkTime { get; set; }
        [DataMember]
        public bool DontShowQuickGuide { get; set; }
        [DataMember]
        public string CountryCode { get; set; }
        [DataMember]
        public int NumberOfMatching { get; set; }
        [DataMember]
        public string MatchingFrequency { get; set; }

        [DataMember]
        public bool OrderByLearningLanguageFlag { get; set; }

        [DataMember]
        public bool HasProfileSetup { get; set; }
        [DataMember]
        public bool IsSupport { get; set; }
        [DataMember]
        public bool ShouldChangePassword { get; set; }
        [DataMember]
        public string LinkKey { get; set; }

        [DataMember]
        public bool IsParentsInfoStored { get; set; }

        [DataMember]
        public List<ScheduleContract> Schedules { get; set; }

    }
}