using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.IO.Compression;

namespace Language.Discovery.Helper
{
    public class Utils
    {
        public static bool IsMsAjaxCallback(HttpRequest request)
        {
            return (request != null && request.Headers["X-MicrosoftAjax"] != null);
        }


        public static byte[] Compress(byte[] data)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                using (GZipStream zip = new GZipStream(ms, CompressionMode.Compress, true))
                {
                    zip.Write(data, 0, data.Length);
                    zip.Dispose();
                    return ms.ToArray();
                }
            }
        }

        public static byte[] Decompress(byte[] data)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                int dataLength = BitConverter.ToInt32(data, 0);
                ms.Write(data, 0, data.Length);

                byte[] buffer = new byte[dataLength];

                ms.Position = 0;
                using (GZipStream zip = new GZipStream(ms, CompressionMode.Decompress))
                {
                    zip.Read(buffer, 0, buffer.Length);
                }
                return buffer;
            }
        }
    }
}