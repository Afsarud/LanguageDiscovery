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
    public class GradeContract
    {
        [DataMember]
        public int GradeID { get; set; }
        [DataMember]
        public string GradeName { get; set; }
    }
}
