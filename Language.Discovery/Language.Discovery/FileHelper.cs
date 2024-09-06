using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Language.Discovery
{
    public class FileHelper
    {
        public FileHelper()
        {
        }

        public static string GetFileName(HttpPostedFile file)
        {
            try
            {
                string filename = Path.GetFileName(file.FileName);
                return filename;
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
        }
        public static byte[] GetBytes(HttpPostedFile file)
        {
            try
            {
                byte[] buffer = new byte[file.ContentLength];
                file.InputStream.Read(buffer, 0, file.ContentLength);
                return buffer;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}