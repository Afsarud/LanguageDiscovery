// using System.Xml.Serialization;
// XmlSerializer serializer = new XmlSerializer(typeof(Envelope));
// using (StringReader reader = new StringReader(xml))
// {
//    var test = (Envelope)serializer.Deserialize(reader);
// }
using System.Xml.Serialization;
namespace Language.Discovery.Helper
{
    [XmlRoot(ElementName = "RoomMode", Namespace = "http://portal.vidyo.com/user/v1_1")]
    public class RoomMode
    {
        [XmlElement(ElementName = "roomURL", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string RoomURL { get; set; }
        [XmlElement(ElementName = "isLocked", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string IsLocked { get; set; }
        [XmlElement(ElementName = "hasPIN", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string HasPIN { get; set; }
        [XmlElement(ElementName = "roomPIN", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string RoomPIN { get; set; }
        [XmlElement(ElementName = "hasModeratorPIN", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string HasModeratorPIN { get; set; }
        [XmlElement(ElementName = "moderatorPIN", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string ModeratorPIN { get; set; }
    }

    [XmlRoot(ElementName = "Entity", Namespace = "http://portal.vidyo.com/user/v1_1")]
    public class Entity
    {
        [XmlElement(ElementName = "entityID", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string EntityID { get; set; }
        [XmlElement(ElementName = "EntityType", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string EntityType { get; set; }
        [XmlElement(ElementName = "ownerID", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string OwnerID { get; set; }
        [XmlElement(ElementName = "displayName", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string DisplayName { get; set; }
        [XmlElement(ElementName = "extension", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string Extension { get; set; }
        [XmlElement(ElementName = "emailAddress", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string EmailAddress { get; set; }
        [XmlElement(ElementName = "tenant", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string Tenant { get; set; }
        [XmlElement(ElementName = "Language", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string Language { get; set; }
        [XmlElement(ElementName = "MemberStatus", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string MemberStatus { get; set; }
        [XmlElement(ElementName = "MemberMode", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string MemberMode { get; set; }
        [XmlElement(ElementName = "canCallDirect", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string CanCallDirect { get; set; }
        [XmlElement(ElementName = "canJoinMeeting", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string CanJoinMeeting { get; set; }
        [XmlElement(ElementName = "canRecordMeeting", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string CanRecordMeeting { get; set; }
        [XmlElement(ElementName = "isInMyContacts", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string IsInMyContacts { get; set; }
        [XmlElement(ElementName = "RoomStatus", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string RoomStatus { get; set; }
        [XmlElement(ElementName = "RoomMode", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public RoomMode RoomMode { get; set; }
        [XmlElement(ElementName = "canControl", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string CanControl { get; set; }
        [XmlElement(ElementName = "audio", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string Audio { get; set; }
        [XmlElement(ElementName = "video", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string Video { get; set; }
        [XmlElement(ElementName = "appshare", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public string Appshare { get; set; }
    }

    [XmlRoot(ElementName = "CreateRoomResponse", Namespace = "http://portal.vidyo.com/user/v1_1")]
    public class CreateRoomResponse
    {
        [XmlElement(ElementName = "Entity", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public Entity Entity { get; set; }
        [XmlAttribute(AttributeName = "ns1", Namespace = "http://www.w3.org/2000/xmlns/")]
        public string Ns1 { get; set; }
    }

    [XmlRoot(ElementName = "Body", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
    public class Body
    {
        [XmlElement(ElementName = "CreateRoomResponse", Namespace = "http://portal.vidyo.com/user/v1_1")]
        public CreateRoomResponse CreateRoomResponse { get; set; }
    }

    [XmlRoot(ElementName = "Envelope", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
    public class Envelope
    {
        [XmlElement(ElementName = "Header", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public string Header { get; set; }
        [XmlElement(ElementName = "Body", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public Body Body { get; set; }
        [XmlAttribute(AttributeName = "soapenv", Namespace = "http://www.w3.org/2000/xmlns/")]
        public string Soapenv { get; set; }
    }

}