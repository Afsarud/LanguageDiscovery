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
    public class PhotoContract
    {
        [DataMember]
        public long UserPhotoID { get; set; }
        [DataMember]
        public long UserID { get; set; }
        [DataMember]
        public long AlbumID { get; set; }
        [DataMember]
        public string Photo { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public byte[] ImageBytes { get; set; }
        [DataMember]
        public string AlbumName { get; set; }
        [DataMember]
        public bool IsProfilePhoto { get; set; }
        [DataMember]
        public int LikeCount { get; set; }
    }
}