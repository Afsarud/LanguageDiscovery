using System;
using System.Xml.Serialization;
using System.Collections.Generic;

namespace Language.Discovery.Helper
{
    [XmlRoot(ElementName = "CreateScheduledRoomResponse", Namespace = "http://portal.vidyo.com/admin/v1_1")]
    public class CreateScheduledRoomResponse
    {
        [XmlElement(ElementName = "extension", Namespace = "http://portal.vidyo.com/admin/v1_1")]
        public string Extension { get; set; }
        [XmlElement(ElementName = "inviteContent", Namespace = "http://portal.vidyo.com/admin/v1_1")]
        public string InviteContent { get; set; }
        [XmlElement(ElementName = "roomURL", Namespace = "http://portal.vidyo.com/admin/v1_1")]
        public string RoomURL { get; set; }
        [XmlElement(ElementName = "inviteSubject", Namespace = "http://portal.vidyo.com/admin/v1_1")]
        public string InviteSubject { get; set; }
        [XmlAttribute(AttributeName = "ns1", Namespace = "http://www.w3.org/2000/xmlns/")]
        public string Ns1 { get; set; }
    }

    [XmlRoot(ElementName = "Body", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
    public class Body
    {
        [XmlElement(ElementName = "CreateScheduledRoomResponse", Namespace = "http://portal.vidyo.com/admin/v1_1")]
        public CreateScheduledRoomResponse CreateScheduledRoomResponse { get; set; }
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