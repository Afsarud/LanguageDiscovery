using Language.Discovery.Entity;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Language.Discovery.Repository
{
    public class ZendeskRepository
    {
        private string Uri = "https://palaygo.zendesk.com/";
        private string RequestUri = "api/v2/users/{0}.json";
        private string PostUri = "api/v2/tickets";
        private string TagsUri = "api/v2/tickets/{0}/tags";
        private string FieldssUri = "api/v2/ticket_fields/{0}";
        private string UpdateTicketUri = "api/v2/tickets/{0}";
        private string UpdateUserUri = "api/v2/users/{0}";
        private const string TOKEN = "it@languagediscovery.org/token:2wDRUeh3TL7r4TNz8JNcQpPts9gSPWa9NFpO3Gyc";

        public async Task<ZendeskUser> GetZendeskUser(string id)
        {
            ZendeskUser data = null;
            try
            {

                using (var httpClient = new HttpClient())
                {
                    using (var request = new HttpRequestMessage(new HttpMethod("GET"), String.Format(RequestUri, id)))
                    {
                        var base64authorization = Convert.ToBase64String(Encoding.ASCII.GetBytes(TOKEN));
                        request.Headers.TryAddWithoutValidation("Authorization", "Basic " + base64authorization);

                        var response = await httpClient.SendAsync(request);

                        using (HttpContent content = response.Content)
                        {
                            var jsonString = await response.Content.ReadAsStringAsync();
                            data = JsonConvert.DeserializeObject<ZendeskUser>(jsonString);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return await Task.FromResult(data);
        }

        public ZendeskUser GetZendeskEndUser(string id)
        {
            ZendeskUser data = null;
            try
            {
                RestClient client = new RestClient(Uri);
                var base64authorization = "aXRAbGFuZ3VhZ2VkaXNjb3Zlcnkub3JnL3Rva2VuOjJ3RFJVZWgzVEw3cjRUTno4Sk5jUXBQdHM5Z1NQV2E5TkZwTzNHeWM=";//Convert.ToBase64String(Encoding.ASCII.GetBytes(TOKEN));
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                RestRequest request = new RestRequest(String.Format(RequestUri, id), Method.GET);
                request.AddParameter("Authorization", $"Basic {base64authorization}", ParameterType.HttpHeader);
                request.AddHeader("Accept", "application/json");
                request.RequestFormat = DataFormat.Json;
                var response = client.Execute(request);
                data = JsonConvert.DeserializeObject<ZendeskUser>(response.Content);


            }
            catch (Exception ex)
            {
                throw ex;
            }

            return data;
        }

        public string CreateTicket(ZendeskTicket ticket)
        {
            try
            {
                string ticketid = "";
                RestClient client = new RestClient(Uri);
                var base64authorization = "aXRAbGFuZ3VhZ2VkaXNjb3Zlcnkub3JnL3Rva2VuOjJ3RFJVZWgzVEw3cjRUTno4Sk5jUXBQdHM5Z1NQV2E5TkZwTzNHeWM=";//Convert.ToBase64String(Encoding.ASCII.GetBytes(TOKEN));

                RestRequest request = new RestRequest(PostUri, Method.POST);
                request.AddParameter("Authorization", $"Basic {base64authorization}", ParameterType.HttpHeader);
                request.AddHeader("Content-Type", "application/json");
                request.RequestFormat = DataFormat.Json;
                string jsonString = JsonConvert.SerializeObject(ticket);
                request.AddJsonBody(jsonString);
                var response = client.Execute(request);
                if (response.StatusCode == System.Net.HttpStatusCode.Created)
                {
                    ticketid = GetTicketID(response.Content);
                    List<string> tags = new List<string>();
                    //List<string> tags = new List<string>() { ticket.Country == "JP" ? "palaygo_api_jp" : "palaygo_api", "Session_confirmed" };

                    if (ticket.NativeLanguage == "en-US" && ticket.LearningLanguage == "ja-JP")
                    {
                        tags.Add("palaygo_api_en_jp");
                    }
                    else if (ticket.NativeLanguage == "ja-JP" && ticket.LearningLanguage == "en-US")
                    {
                        tags.Add("palaygo_api_jp_en");
                    }
                    else if (ticket.NativeLanguage == "en-US" && ticket.LearningLanguage == "zh-CN")
                    {
                        tags.Add("palaygo_api_en_zh");
                    }
                    else if (ticket.NativeLanguage == "zh-CN" && ticket.LearningLanguage == "en-US")
                    {
                        tags.Add("palaygo_api_zh_en");
                    }
                    else if (ticket.NativeLanguage == "ja-JP" && ticket.LearningLanguage == "zh-CN")
                    {
                        tags.Add("palaygo_api_jp_zh");
                    }
                    else if (ticket.NativeLanguage == "zh-CN" && ticket.LearningLanguage == "ja-JP")
                    {
                        tags.Add("palaygo_api_zh_jp");
                    }
                    //string tag = ticket.Country == "JP" ? "palaygo_api_jp" : "palaygo_api";
                    if (!ticket.HasPartner)
                    {
                        tags.Add("palaygo_register");
                    }
                    else
                    {
                        tags.Add("Session_confirmed");
                    }
                    UpdateTicketTags(ticketid, tags);
                }

                return ticketid;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateTicketTags(string ticketid, List<string> tagList)
        {
            try
            {
                RestClient client = new RestClient(Uri);
                var base64authorization = "aXRAbGFuZ3VhZ2VkaXNjb3Zlcnkub3JnL3Rva2VuOjJ3RFJVZWgzVEw3cjRUTno4Sk5jUXBQdHM5Z1NQV2E5TkZwTzNHeWM=";//Convert.ToBase64String(Encoding.ASCII.GetBytes(TOKEN));

                RestRequest request = new RestRequest(String.Format(TagsUri, ticketid), Method.PUT);
                request.AddParameter("Authorization", $"Basic {base64authorization}", ParameterType.HttpHeader);
                request.AddHeader("Content-Type", "application/json");
                request.RequestFormat = DataFormat.Json;
                ZendeskTags tags = new ZendeskTags();
                tags.Tags = tagList;

                string jsonString = JsonConvert.SerializeObject(tags);
                request.AddJsonBody(jsonString);

                var response = client.Execute(request);
                return response.StatusCode == System.Net.HttpStatusCode.Created;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateTicket(string ticketid, ZendeskTicket ticket)
        {
            try
            {
                RestClient client = new RestClient(Uri);
                var base64authorization = "aXRAbGFuZ3VhZ2VkaXNjb3Zlcnkub3JnL3Rva2VuOjJ3RFJVZWgzVEw3cjRUTno4Sk5jUXBQdHM5Z1NQV2E5TkZwTzNHeWM=";//Convert.ToBase64String(Encoding.ASCII.GetBytes(TOKEN));

                RestRequest request = new RestRequest(String.Format(UpdateTicketUri, ticketid), Method.PUT);
                request.AddParameter("Authorization", $"Basic {base64authorization}", ParameterType.HttpHeader);
                request.AddHeader("Content-Type", "application/json");
                request.RequestFormat = DataFormat.Json;

                string jsonString = JsonConvert.SerializeObject(ticket, Newtonsoft.Json.Formatting.None,
                            new JsonSerializerSettings
                            {
                                NullValueHandling = NullValueHandling.Ignore
                            });
                request.AddJsonBody(jsonString);

                var response = client.Execute(request);
                return response.StatusCode == System.Net.HttpStatusCode.OK;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool UpdateMultiSelectTicketField(string fieldId, ZendeskCustomTicketFields field)
        {
            try
            {
                RestClient client = new RestClient(Uri);
                var base64authorization = "aXRAbGFuZ3VhZ2VkaXNjb3Zlcnkub3JnL3Rva2VuOjJ3RFJVZWgzVEw3cjRUTno4Sk5jUXBQdHM5Z1NQV2E5TkZwTzNHeWM=";//Convert.ToBase64String(Encoding.ASCII.GetBytes(TOKEN));

                RestRequest request = new RestRequest(String.Format(FieldssUri, fieldId), Method.PUT);
                request.AddParameter("Authorization", $"Basic {base64authorization}", ParameterType.HttpHeader);
                request.AddHeader("Content-Type", "application/json");
                request.RequestFormat = DataFormat.Json;

                var obj = new { ticket_field = field };

                string jsonString = JsonConvert.SerializeObject(obj);
                request.AddJsonBody(jsonString);

                var response = client.Execute(request);
                return response.StatusCode == System.Net.HttpStatusCode.Created;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool UpdateUser(ZendeskUser user)
        {
            try
            {
                RestClient client = new RestClient(Uri);
                var base64authorization = "aXRAbGFuZ3VhZ2VkaXNjb3Zlcnkub3JnL3Rva2VuOjJ3RFJVZWgzVEw3cjRUTno4Sk5jUXBQdHM5Z1NQV2E5TkZwTzNHeWM=";//Convert.ToBase64String(Encoding.ASCII.GetBytes(TOKEN));

                RestRequest request = new RestRequest(String.Format(UpdateUserUri, user.User.Id), Method.PUT);
                request.AddParameter("Authorization", $"Basic {base64authorization}", ParameterType.HttpHeader);
                request.AddHeader("Content-Type", "application/json");
                request.RequestFormat = DataFormat.Json;

                string jsonString = JsonConvert.SerializeObject(user, Newtonsoft.Json.Formatting.None,
                            new JsonSerializerSettings
                            {
                                NullValueHandling = NullValueHandling.Ignore
                            });
                request.AddJsonBody(jsonString);

                var response = client.Execute(request);
                return response.StatusCode == System.Net.HttpStatusCode.OK;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private string GetTicketID(string response)
        {
            string ticketid = "";
            string pattern = @"([0-9]*)\.json";

            Match m = Regex.Match(response, pattern);
            ticketid = m.Groups[1].ToString();
            return ticketid;
        }

    }
}
