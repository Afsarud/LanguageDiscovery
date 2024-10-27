using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Web.Http;
using System.Xml.Serialization;
using Language.Discovery.Helper;
using Language.Discovery.Entity;

namespace Language.Discovery.Controllers
{
    public class VidyoController : ApiController
    {
        [HttpPost]
        [Route("api/Vidyo/CreateRoom")]
        public IHttpActionResult CreateRoom(ConferenceRoomContract conferenceRoom)
        {
            string roomKey = string.Empty;
            string roomPattern = @"https:\/\/ld\.platform\.vidyo\.io\/join\/(?<roomid>[0-9a-zA-Z].+)";

            try
            {
                string requestString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v1=\"http://portal.vidyo.com/admin/v1_1\"><soapenv:Header/><soapenv:Body><v1:CreateScheduledRoomRequest><v1:ownerName>admin</v1:ownerName><v1:recurring>1</v1:recurring><v1:returnHtmlContent>false</v1:returnHtmlContent></v1:CreateScheduledRoomRequest></soapenv:Body></soapenv:Envelope>";

                var client = new RestClient("https://ld.platform.vidyo.io/services/v1_1/VidyoPortalAdminService")
                {
                    Timeout = 10000 // Set a 10-second timeout
                };

                var request = new RestRequest(Method.POST);
                request.AddHeader("Authorization", "Basic YWRtaW46Y2hhbmdlbWU=");
                request.AddHeader("Content-Type", "text/plain");
                request.AddParameter("text/plain", requestString, ParameterType.RequestBody);

                IRestResponse response = client.Execute(request);

                // Handle response errors
                if (response == null || response.StatusCode == 0)
                {
                    throw new TimeoutException("No response from Vidyo server.");
                }
                if (response.StatusCode != HttpStatusCode.OK)
                {
                    throw new Exception($"Vidyo server returned error: {response.StatusDescription}");
                }

                if (string.IsNullOrEmpty(response.Content))
                {
                    throw new Exception("Invalid response from Vidyo server.");
                }

                // Deserialize and process response
                Envelope body = FromXml<Envelope>(response.Content);
                if (body == null || string.IsNullOrEmpty(body.Body.CreateScheduledRoomResponse.RoomURL))
                {
                    throw new Exception("No Room Generated.");
                }

                // Extract room key
                RegexOptions options = RegexOptions.Multiline;
                MatchCollection matches = Regex.Matches(body.Body.CreateScheduledRoomResponse.RoomURL, roomPattern, options);
                if (matches.Count == 0 || string.IsNullOrEmpty(matches[0].Groups["roomid"].Value))
                {
                    throw new Exception("Invalid Room URL.");
                }

                roomKey = matches[0].Groups["roomid"].Value;
                conferenceRoom.RoomKey = roomKey;

                return Ok(conferenceRoom);
            }
            catch (TimeoutException tex)
            {
                // Specific handling for timeout
                return Content(HttpStatusCode.RequestTimeout, tex.Message);
            }
            catch (Exception ex)
            {
                // Generic exception handling
                return Content(HttpStatusCode.InternalServerError, $"Server error: {ex.Message}");
            }
        }





        //[HttpPost]
        //[Route("api/Vidyo/CreateRoom")]
        //public IHttpActionResult CreateRoom(ConferenceRoomContract conferenceRoom)
        //{
        //    string roomKey = string.Empty;
        //    string roomPattern = @"https:\/\/ld\.platform\.vidyo\.io\/join\/(?<roomid>[0-9a-zA-Z].+)";

        //    try
        //    {
        //        string requestString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v1=\"http://portal.vidyo.com/admin/v1_1\"><soapenv:Header/><soapenv:Body><v1:CreateScheduledRoomRequest><v1:ownerName>admin</v1:ownerName><v1:recurring>1</v1:recurring><v1:returnHtmlContent>false</v1:returnHtmlContent></v1:CreateScheduledRoomRequest></soapenv:Body></soapenv:Envelope>";

        //        // Setup the client with a timeout and error handling
        //        var client = new RestClient("https://ld.platform.vidyo.io/services/v1_1/VidyoPortalAdminService")
        //        {
        //            Timeout = 10000 // Set a 10-second timeout to prevent hanging
        //        };

        //        var request = new RestRequest(Method.POST);
        //        request.AddHeader("Authorization", "Basic YWRtaW46Y2hhbmdlbWU=");
        //        request.AddHeader("Content-Type", "text/plain");
        //        request.AddParameter("text/plain", requestString, ParameterType.RequestBody);

        //        // Execute the request
        //        IRestResponse response = client.Execute(request);

        //        // Handle timeout or network-related issues
        //        if (response == null || response.StatusCode == 0)
        //        {
        //            return Content(HttpStatusCode.RequestTimeout, "No response from Vidyo server.");
        //        }

        //        // Check if the Vidyo server returned an error
        //        if (response.StatusCode != HttpStatusCode.OK)
        //        {
        //            return Content(HttpStatusCode.InternalServerError, "Error from Vidyo server: " + response.StatusDescription);
        //        }

        //        // Check if the response content is null or empty
        //        if (string.IsNullOrEmpty(response.Content))
        //        {
        //            return Content(HttpStatusCode.InternalServerError, "No response from Vidyo server.");
        //        }

        //        // Deserialize the response
        //        Envelope body = FromXml<Envelope>(response.Content);
        //        if (body == null || string.IsNullOrEmpty(body.Body.CreateScheduledRoomResponse.RoomURL))
        //        {
        //            return Content(HttpStatusCode.BadRequest, "No Room Generated. Room URL is missing.");
        //        }

        //        // Extract the roomKey from the RoomURL using regex
        //        RegexOptions options = RegexOptions.Multiline;
        //        MatchCollection matches = Regex.Matches(body.Body.CreateScheduledRoomResponse.RoomURL, roomPattern, options);
        //        if (matches.Count == 0 || string.IsNullOrEmpty(matches[0].Groups["roomid"].Value))
        //        {
        //            return Content(HttpStatusCode.BadRequest, "Invalid Room URL. Room ID is missing.");
        //        }

        //        roomKey = matches[0].Groups["roomid"].Value;
        //        conferenceRoom.RoomKey = roomKey;

        //        return Ok(conferenceRoom);
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log the exception (optional)
        //        // Return a proper error response with details
        //        return Content(HttpStatusCode.InternalServerError, $"Error occurred while creating the room: {ex.Message}");
        //    }
        //}


        //[HttpPost]
        //[Route("api/Vidyo/CreateRoom")]
        //public IHttpActionResult CreateRoom(ConferenceRoomContract conferenceRoom)
        //{
        //    string roomKey = String.Empty;
        //    string roomPattern = @"https:\/\/ld\.platform\.vidyo\.io\/join\/(?<roomid>[0-9a-zA-Z].+)";
        //    try
        //    {
        //        string requestString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:v1=\"http://portal.vidyo.com/admin/v1_1\"><soapenv:Header/><soapenv:Body><v1:CreateScheduledRoomRequest><v1:ownerName>admin</v1:ownerName><v1:recurring>1</v1:recurring><v1:returnHtmlContent>false</v1:returnHtmlContent></v1:CreateScheduledRoomRequest></soapenv:Body></soapenv:Envelope>";
        //        var client = new RestClient("https://ld.platform.vidyo.io/services/v1_1/VidyoPortalAdminService");
        //        client.Timeout = -1;
        //        var request = new RestRequest(Method.POST);
        //        request.AddHeader("Authorization", "Basic YWRtaW46Y2hhbmdlbWU=");
        //        request.AddHeader("Content-Type", "text/plain");
        //        request.AddParameter("text/plain", requestString, ParameterType.RequestBody);
        //        IRestResponse response = client.Execute(request);


        //        Envelope body = FromXml<Envelope>(response.Content);
        //        if(body == null)
        //        {
        //            throw new Exception("No Room Generated");
        //        }

        //        RegexOptions options = RegexOptions.Multiline;
        //        MatchCollection matches = Regex.Matches(body.Body.CreateScheduledRoomResponse.RoomURL, roomPattern, options);
        //        roomKey = matches[0].Groups["roomid"].Value;
        //        bool res = false;
        //        //if (!string.IsNullOrEmpty(roomKey) && !string.IsNullOrEmpty(conferenceRoom.RoomName))
        //        //{
        //        //    res = new Repository.UserRepository().AddConferenceRoom(conferenceRoom.RoomName, conferenceRoom.Caller, conferenceRoom.Callee, roomKey);
        //        //}
        //        if (!res && string.IsNullOrEmpty(roomKey))
        //        {
        //            return StatusCode(HttpStatusCode.BadRequest);
        //        }
        //        else
        //        {
        //            conferenceRoom.RoomKey = roomKey;
        //        }

        //        return Ok(conferenceRoom);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }

            
        //}

        private string GenerateExtension()
        {
            Random rnd = new Random();
            int num = rnd.Next(0, 999);
            return num.ToString();
        }

        protected T FromXml<T>(String xml)
        {
            T returnedXmlClass = default(T);

            try
            {
                using (TextReader reader = new StringReader(xml))
                {
                    try
                    {
                        returnedXmlClass =
                            (T)new XmlSerializer(typeof(T)).Deserialize(reader);
                    }
                    catch (InvalidOperationException exx)
                    {
                        // String passed is not XML, simply return defaultXmlClass
                    }
                }
            }
            catch (Exception ex)
            {
            }

            return returnedXmlClass;
        }
    }
}
