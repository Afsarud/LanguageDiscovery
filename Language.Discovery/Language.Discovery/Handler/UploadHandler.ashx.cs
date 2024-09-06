using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using Language.Discovery.Entity;
using Language.Discovery.UserService;
using System.Web.SessionState;
namespace Language.Discovery
{
    /// <summary>
    /// Summary description for UploadHandler
    /// </summary>
    public class UploadHandler : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Expires = -1;
            try
            {
                long userid = SessionManager.Instance.UserProfile.UserID;

                HttpPostedFile postedFile = context.Request.Files["Filedata"];

                //string savepath = "";
                //string tempPath = "Content";
                //tempPath = @"c:\test\";//System.Configuration.ConfigurationManager.AppSettings["FolderPath"];
                //savepath = context.Server.MapPath(tempPath);
                string filename = postedFile.FileName;
                //if (!Directory.Exists(savepath))
                //    Directory.CreateDirectory(savepath);

                //postedFile.SaveAs(savepath + @"\" + filename);
                //context.Response.Write(tempPath + "/" + filename);
                UserClient userService = new UserClient();
                 Byte[] bytes = new Byte[postedFile.ContentLength];

                postedFile.InputStream.Read(bytes, 0, postedFile.ContentLength);
                PhotoContract photo = new PhotoContract() { Photo=filename, Description="test", ImageBytes=bytes };
                bool uploaded = userService.SaveImage(userid, photo);

                //Photo p = new Photo() { Image = "http://localhost:50835/Content/" + postedFile.FileName, Description = "Image 1" };
                //string json = new JavaScriptSerializer().Serialize();
                context.Response.Write(uploaded.ToString());
                context.Response.StatusCode = 200;
            }
            catch (Exception ex)
            {
                context.Response.Write("Error: " + ex.Message);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}