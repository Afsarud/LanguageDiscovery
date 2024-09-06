using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;

namespace Language.Discovery.Entity
{
    [DataContract]
    [Serializable]
    public partial class SchoolContract
    {
        [DataMember]
        public Int32 SchoolID { get; set; }
        [DataMember]
        public string SchoolCode { get; set; }
        [DataMember]
        public string Name1 { get; set; }
        [DataMember]
        public string Name2 { get; set; }
        [DataMember]
        public Int32 SchoolTypeID { get; set; }
        [DataMember]
        public Int32 CountryID { get; set; }
        [DataMember]
        public string CountryName { get; set; }
        [DataMember]
        public string Address { get; set; }
        [DataMember]
        public string Telephone { get; set; }
        [DataMember]
        public string Url { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string PreparedBy { get; set; }
        [DataMember]
        public string Password { get; set; }
        [DataMember]
        public Int32 License { get; set; }
        [DataMember]
        public Int32 StartTime { get; set; }
        [DataMember]
        public Int32 EndTime { get; set; }
        [DataMember]
        public bool MailCheck { get; set; }
        [DataMember]
        public DateTime CreateDate { get; set; }
        [DataMember]
        public DateTime ModifiedDate { get; set; }
        [DataMember]
        public Int64 ModifiedBy { get; set; }
        [DataMember]
        public Int64 CreatedBy { get; set; }
        [DataMember]
        public bool ShowPhraseOrder { get; set; }
        [DataMember]
        public bool ShowNativeLanguage { get; set; }
        [DataMember]
        public bool AfterSchool { get; set; }
        [DataMember]
        public bool SchoolPallete { get; set; }
        [DataMember]
        public Int32 LevelID { get; set; }
        [DataMember]
        public bool SchoolKey { get; set; }
        [DataMember]
        public int  StudentCount { get; set; }
        [DataMember]
        public string DefaultLanguageOrder { get; set; }
        [DataMember]
        public bool ShowSubLanguage2 { get; set; }
        [DataMember]
        public bool IsLevelDemo { get; set; }
        [DataMember]
        public bool AllowSameCountry { get; set; }
        [DataMember]
        public bool IsDefault { get; set; }
        [DataMember]
        public bool IsRobot { get; set; }
        [DataMember]
		public string NativeLanguage { get; set; }
        [DataMember]
        public string LearningLanguage { get; set; }
        [DataMember]
        public bool SendPasswordToTeacher { get; set; }
        [DataMember]
        public string TeachersEmail { get; set; }
        [DataMember]
        public bool ShowRomanji { get; set; }
        [DataMember]
        public bool EnabledFreeMessage { get; set; }
        [DataMember]
        public bool SoundAndMail { get; set; }
        [DataMember]
        public int TalkTime { get; set; }
        [DataMember]
        public bool IsSchoolDemo { get; set; }
        [DataMember]
        public bool OrderByLearningLanguageFlag { get; set; }
        [DataMember]
        public bool AllowTalk { get; set; }
        [DataMember]
        public string LinkKey { get; set; }

        [DataMember]
        public bool EnableParentInfo { get; set; }

    }
}