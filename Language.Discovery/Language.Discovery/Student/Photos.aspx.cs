using Language.Discovery.Entity;
using Language.Discovery.PaletteService;
using Language.Discovery.UserService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery
{
    public partial class Photos : System.Web.UI.Page
    {
        //long m_userID = 3;
        protected override void InitializeCulture()
        {
            if (SessionManager.Instance.UserProfile == null)
            {
                Response.Redirect("~/Logout");
                return;
            }
            UICulture = SessionManager.Instance.UserProfile.NativeLanguage;

            base.InitializeCulture();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //list<photo> photolist = new list<photo>();
            //photolist.add(new photo() { image = "http://localhost:50835/content/images/image1.jpg", description = "image 1" });
            //photolist.add(new photo() { image = "http://localhost:50835/content/images/image2.jpg", description = "image 2" });
            //photolist.add(new photo() { image = "http://localhost:50835/content/images/image3.jpg", description = "image 3" });
            //photolist.add(new photo() { image = "http://localhost:50835/content/images/img_8247.jpg", description = "image 4" });
            if(!IsPostBack)
                BindPhoto();

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string error = string.Empty;
            if (FileUpload1.PostedFile.ContentLength > 0)
                UploadPhoto(FileUpload1.PostedFile, txtDescription1.Text);
            //if (FileUpload2.PostedFile.ContentLength > 0)
            //    UploadPhoto(FileUpload2.PostedFile, txtDescription2.Text);
            //if (FileUpload3.PostedFile.ContentLength > 0)
            //    UploadPhoto(FileUpload3.PostedFile, txtDescription3.Text);
            //if (FileUpload4.PostedFile.ContentLength > 0)
            //    UploadPhoto(FileUpload4.PostedFile, txtDescription4.Text);
            //if (FileUpload5.PostedFile.ContentLength > 0)
            //    UploadPhoto(FileUpload5.PostedFile, txtDescription5.Text);

            BindPhoto();
            txtDescription1.Text = string.Empty;
            //txtDescription2.Text = string.Empty;
            //txtDescription3.Text = string.Empty;
            //txtDescription4.Text = string.Empty;
            //txtDescription5.Text = string.Empty;
        }


        private bool UploadPhoto( HttpPostedFile postedFile, string description)
        {
            long userid = SessionManager.Instance.UserProfile.UserID;

            //HttpPostedFile postedFile = FileUpload1.PostedFile.ContentLength > 0 ? FileUpload1.PostedFile : null; //HttpContext.Current.Request.Files["Filedata"];

            int filesize = postedFile.ContentLength / 1024;
            if (filesize > 2048)
            {
                lblMessage.Text = "Some of the files is greater than 2MB.";
                lblMessage.Visible = true;
                return false;
            }

            string filename = postedFile.FileName;
            UserClient userService = new UserClient();
            Byte[] bytes = new Byte[postedFile.ContentLength];

            PaletteServiceClient ps = new PaletteServiceClient();
            bool hasfoul = ps.HasFoulWords(txtDescription1.Text);
            if (hasfoul)
            {
                lblDescriptionMessage.Visible = true;
                description = string.Empty;
            }


            postedFile.InputStream.Read(bytes, 0, postedFile.ContentLength);
            PhotoContract photo = new PhotoContract() { Photo = filename, Description = description, ImageBytes = bytes };


            bool uploaded = userService.SaveImage(userid, photo);

            return uploaded;

        }

        private void BindPhoto()
        {
            UserClient client = new UserClient();
            string json = client.GetUserPhoto(SessionManager.Instance.UserProfile.UserID, 3);

            //string url = Request.ServerVariables["URL"]; 
            List<PhotoContract> photolist = new JavaScriptSerializer().Deserialize<List<PhotoContract>>(json);
            if (photolist != null)
            {
                foreach (PhotoContract contract in photolist)
                {
                    contract.Photo = "../UserPhoto/" + SessionManager.Instance.UserProfile.UserID.ToString() + "/" + contract.Photo;
                }

                ListView1.DataSource = photolist;
                ListView1.DataBind();

                //UpdatePanel1.Update();
            }
        }

        protected void btnDeleteSelected_Click(object sender, EventArgs e)
        {
            try
            {

                UserClient client = new UserClient();
                string[] ids = hdnImageID.Value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                if (ids.Length > 0)
                {
                    StringBuilder builder = new StringBuilder();
                    builder.AppendLine("<List>");
                    foreach (string id in ids)
                    {
                        builder.AppendFormat("<IDS><UserPhotoID>{0}</UserPhotoID></IDS>", id);
                    }
                    builder.AppendLine("</List>");
                    bool deleted = client.DeleteUserPhoto(builder.ToString());
                    if (deleted)
                    {
                        BindPhoto();
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}