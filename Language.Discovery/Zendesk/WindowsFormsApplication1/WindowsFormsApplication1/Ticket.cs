using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1
{
    public class NewTicket
    {
        public Ticket ticket { get; set; }
    }
    public class Ticket
    {
        public string subject { get; set; }
        public Requester requester { get; set; }
        public string group { get; set; }
        public string priority { get; set; }
        public string type { get; set; }
        public string status { get; set; }
        public Comment comment { get; set; }
        public Organization organization { get; set; }

        public class Comment
        {
            public string value { get; set; }
        }

        public class Requester
        {
            public string name { get; set; }
            public string email { get; set; }
        }

        public class Organization
        {
            public string name { get; set; }
        }
    }
}
