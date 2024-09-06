using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class ImageUploader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetPaths();
            }

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Upload();
            GetPaths();
            
        }

        private void GetPaths()
        {
            listDirectory.ClearSelection();
            string path = System.Configuration.ConfigurationManager.AppSettings["ImageDirectory"];
            string[] directories = Directory.GetDirectories(path + @"images\", "*", SearchOption.AllDirectories);
            listDirectory.Items.Clear();
            listDirectory.Items.Add(@"images\");
            foreach (string s in directories)
            {
                listDirectory.Items.Add(s.Replace(path, "") + @"\");
            }
            if (listDirectory.Items.Count > 0)
            {
                listDirectory.Items[0].Selected = true;
                lblDirectory.Text = listDirectory.Items[0].Text;
                hdnDirectory.Value = lblDirectory.Text;
            }
            txtFolder.Text = "";

        }
        private string Upload()
        {
            lblImport.Visible = fileUPloader.HasFile;
            lblImport.Text = string.Empty;
            string sFileName = string.Empty;
            string path = System.Configuration.ConfigurationManager.AppSettings["ImageDirectory"] + hdnDirectory.Value;

            if (fileUPloader.HasFile)
            {
                try
                {
                    string sExtension = Path.GetExtension(fileUPloader.FileName).ToLower();
                    string extentions = ".jpg, .jpeg, .png, .bmp, .tif, .gif, .tiff";

                    if (extentions.ToUpper().Contains(sExtension.ToUpper().Trim()))
                    {
                        //sFileName = path + fileUPloader.FileName;

                        if (!Directory.Exists(path))
                        {
                            Directory.CreateDirectory(path);
                        }

                        if ((fileUPloader.PostedFile != null) && (fileUPloader.PostedFile.ContentLength > 0))
                        {
                            var count = 0;
                            foreach (HttpPostedFile uploadedFile in fileUPloader.PostedFiles)
                            {
                                string fn = System.IO.Path.GetFileName(uploadedFile.FileName);
                                AdminLogger.ErrorLog("--before--");
                                AdminLogger.ErrorLog(fn);
                                fn = HttpUtility.UrlDecode(fn);
                                AdminLogger.ErrorLog("--after--");
                                AdminLogger.ErrorLog(fn);
                                string SaveLocation = path + @"\" +   fn;
                                try
                                {
                                    uploadedFile.SaveAs(SaveLocation);
                                    count++;
                                }
                                catch (Exception ex)
                                {
                                    AdminLogger.ErrorLog("Error -> " + fn + " -> " + ex.Message);
                                    lblWarning.Text = "Error: " + ex.Message;
                                }
                            }
                            if (count > 0)
                            {
                                lblWarning.Text = count + " files has been uploaded.";
                            }
                        }
                        else
                        {
                            lblWarning.Text = "Please select a file to upload.";
                        }

                        lblImport.ForeColor = Color.Green;
                        //lblImport.Text = "File name: " + fileUPloader.PostedFile.FileName + "<br>" + fileUPloader.PostedFile.ContentLength + " kb<br>" + "<br><b>Uploaded Successfully";
                        lblWarning.ForeColor = Color.Orange;
                        lblWarning.Visible = true;


                    }
                    else
                    {
                        lblImport.ForeColor = Color.Red;
                        lblImport.Text = "WARNING: File is invalid";
                    }
                }
                catch (Exception ex)
                {
                    lblImport.ForeColor = Color.Red;
                    lblImport.Text = "ERROR: " + ex.Message.ToString();
                    AdminLogger.ErrorLog("Error -> " + ex.Message);
                }
            }
            else
            {
                lblImport.ForeColor = Color.Red;
                lblImport.Text = "You have not specified a file.";
            }

            return sFileName;
        }
    }
}