using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Language.Discovery
{
    /// <summary>
    /// Summary description for PhotoDetailsHandler
    /// </summary>
    public class PhotoDetailsHandler : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string type = context.Request.Form["Type"];
            string imagearray = "";
            string stickerarray = "";
            string imagenames = string.Empty;
            bool success = false;
            switch (type)
            {
                case "avatar":
                   string[] avatar = Directory.GetFiles(context.Server.MapPath( "Images/avatar/"));
                    
                    foreach (string file in avatar)
                    {
                        if (file.Contains("no_avatar"))
                            continue;
                        imagenames += "{\"ImageName\" : \"../Images/avatar/" + Path.GetFileName(file) + "\"},";
                    }

                    imagenames = imagenames.Remove(imagenames.Length-1, 1);
                    imagearray = string.Format("{{\"avatars\":[{0}] }}", imagenames);
                    break;
                case "emoji":
                    string[] emoji = Directory.GetFiles(context.Server.MapPath("Images/emoji/"));

                    foreach (string file in emoji)
                    {
                        imagenames += "{\"ImageName\" : \"../Images/emoji/" + Path.GetFileName(file) + "\"},";
                    }

                    imagenames = imagenames.Remove(imagenames.Length - 1, 1);
                    imagearray = string.Format("{{\"emoji\":[{0}] }}", imagenames);

                    //--------------------

                    string stickernames = string.Empty;
                    string[] stickers = Directory.GetFiles(context.Server.MapPath("Images/sticker/"));

                    foreach (string file in stickers)
                    {
                        stickernames += "{\"ImageName\" : \"../Images/sticker/" + Path.GetFileName(file) + "\"},";
                    }

                    stickernames = stickernames.Remove(stickernames.Length - 1, 1);
                    stickerarray = string.Format("{{\"sticker\":[{0}] }}", stickernames);

                    break;
                //case "sticker":
                //    string[] stickers = Directory.GetFiles(context.Server.MapPath("Images/sticker/"));

                //    foreach (string file in stickers)
                //    {
                //        imagenames += "{\"ImageName\" : \"../Images/stcicker/" + Path.GetFileName(file) + "\"},";
                //    }

                //    imagenames = imagenames.Remove(imagenames.Length - 1, 1);
                //    imagearray = string.Format("{{\"sticker\":[{0}] }}", imagenames);
                //    break;
            }

            string st = (stickerarray.Length > 0 ? "," + stickerarray : "");
            context.Response.Write((st.Length > 0 ? "[" : "")  + imagearray + st + (st.Length > 0 ? "]" : ""));
            context.Response.StatusCode = 200;

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