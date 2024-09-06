using RestSharp;
using RestSharp.Authenticators;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
             string requestUri = "https://palaygo.zendesk.com/";
             string username = "dev@languagediscovery.org";
             string password = "Dev2016!";

            var client = new RestSharp.RestClient(requestUri);
            client.Authenticator = new HttpBasicAuthenticator(username, password);

            var request = new RestRequest("/api/v2/tickets.json", Method.POST);
            request.AddHeader("Accept", "application/json");
            request.Parameters.Clear();

            NewTicket createTicket = new NewTicket();
            createTicket.ticket = new Ticket
            {
                subject = "Test Ticket",
                status = "new",
                type = "incedent",
                priority = "high",
                group = "日本｜学校生徒サポート ",
                comment = new WindowsFormsApplication1.Ticket.Comment { value = string.Format("[カテゴリー]{0}\r\n[保護者名]{1}\r\n[お子様名] {2}\r\n[学校名]{3}\r\n[email]{4}", " 一般個人 ", "Parent Name", "Firstname", "School1", "ferdinandbelasa@outlook.com") },
                requester = new WindowsFormsApplication1.Ticket.Requester { name = "Ferdie", email = "ferdinandbelasa@outlook.com" },
                organization = new WindowsFormsApplication1.Ticket.Organization { name="New School" }
            };

            request.RequestFormat = RestSharp.DataFormat.Json;
            request.AddBody(createTicket);

            IRestResponse response = client.Execute(request);
            var content = response.Content;

            Console.WriteLine(content);
            //Group - Where did you hear about playgo
        }
    }
}
