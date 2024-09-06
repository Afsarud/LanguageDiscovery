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
    public class TeacherRegistrationContract
    {
        [DataMember]
        public string FirstName { get; set; }
        [DataMember]
        public string LastName { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string SchoolName { get; set; }
        [DataMember]
        public string Telephone { get; set; }
        [DataMember]
        public string Gender { get; set; }
        [DataMember]
        public string ObjectID { get; set; }
        [DataMember]
        public DateTime ExpiryDate { get; set; }
        [DataMember]
        public bool IsRegistered { get; set; }
        [DataMember]
        public DateTime RegistrationDate { get; set; }


    }
}
