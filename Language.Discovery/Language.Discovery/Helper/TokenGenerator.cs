using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Language.Discovery
{
   
    public class TokenGenerator
    {
        private static string key = ConfigurationManager.AppSettings["AppKey"];// "ff41eaf9f6fe460b8425438bca9cc27e";
        private static string appID = ConfigurationManager.AppSettings["AppId"];//"25968a.vidyo.io";//"37637d7c-3774-449f-8ee4-991a5dff721d";
        private static long expiresInSecs = 3600;
        private static string expiresAt = null;

        private const long EPOCH_SECONDS = 62167219200;

        //public string UserName { get; set; }

        public string GenerateToken(string userName)
        {
            string token = "";
            // As long as proper arguments were entered, generate the token
            if (userName != null)
            {
                string expires = "";

                // Check if using expiresInSecs or expiresAt
                TimeSpan timeSinceEpoch = DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1, 0, 0, 0));
                expires = (Math.Floor(timeSinceEpoch.TotalSeconds) + EPOCH_SECONDS + expiresInSecs).ToString();

                string jid = userName + "@" + appID;
                string body = "provision" + "\0" + jid + "\0" + expires + "\0" + "";

                var encoder = new UTF8Encoding();
                var hmacsha = new HMACSHA384(encoder.GetBytes(key));
                byte[] mac = hmacsha.ComputeHash(encoder.GetBytes(body));

                // macBase64 can be used for debugging
                //string macBase64 = Convert.ToBase64String(hashmessage);

                // Get the hex version of the mac
                string macHex = BytesToHex(mac);

                string serialized = body + '\0' + macHex;
                //token = serialized; 
                token =  Convert.ToBase64String(encoder.GetBytes(serialized));
            }

            return token;
        }

        private static string BytesToHex(byte[] bytes)
        {
            var hex = new StringBuilder(bytes.Length * 2);
            foreach (byte b in bytes)
            {
                hex.AppendFormat("{0:x2}", b);
            }
            return hex.ToString();
        }

    }
}