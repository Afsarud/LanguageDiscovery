using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Excel;
using Language.Discovery.Entity;
using Language.Discovery.Admin.PhraseCategoryService;

namespace Language.Discovery.Admin
{
    public partial class PhraseCategoryBulkUpload : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            lblImport.Visible = fuExcelUploader.HasFile;
            lblImport.Text = string.Empty;

            if (fuExcelUploader.HasFile)
            {
                try
                {
                    string sExtension = Path.GetExtension(fuExcelUploader.FileName).ToLower();

                    if (sExtension.Trim() == ".xls" || sExtension.Trim() == ".xlsx")
                    {
                        string sFileName = Server.MapPath("Upload/") + fuExcelUploader.FileName;

                        if (!Directory.Exists(Server.MapPath("Upload/")))
                        {
                            Directory.CreateDirectory(Server.MapPath("Upload/"));
                        }

                        fuExcelUploader.SaveAs(sFileName);
                        lblImport.Text = "File name: " + fuExcelUploader.PostedFile.FileName + "<br>" + fuExcelUploader.PostedFile.ContentLength + " kb<br>" + "<br><b>Uploaded Successfully";

                        Import(sFileName, sExtension);
                    }
                    else
                    {
                        lblImport.Text = "WARNING: File is invalid";
                    }
                }
                catch (Exception ex)
                {
                    lblImport.Text = "ERROR: " + ex.Message.ToString();
                }
            }
            else
            {
                lblImport.Text = "You have not specified a file.";
            }    
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {

                List<PhraseCategoryHeaderContract> tHeader = new List<PhraseCategoryHeaderContract>();
                List<PhraseCategoryContract> tDetail = new List<PhraseCategoryContract>();

                int nCount = grdResult.Rows.Count;

                for (int i = 0; i < nCount; i++)
                {
                    PhraseCategoryHeaderContract oHeader = new PhraseCategoryHeaderContract();
                    oHeader.PhraseCategoryHeaderID = i;
                    oHeader.CreatedByID = SessionManager.Instance.UserProfile.UserID;
                    oHeader.ModifiedByID = SessionManager.Instance.UserProfile.UserID;
                    tHeader.Add(oHeader);

                    string sWord1 = ((System.Web.UI.WebControls.TextBox)grdResult.Rows[i].FindControl("Word1")).Text;
                    string sWord2 = ((System.Web.UI.WebControls.TextBox)grdResult.Rows[i].FindControl("Word2")).Text;

                    PhraseCategoryContract oDetail = new PhraseCategoryContract();
                    oDetail.GroupID = i;
                    oDetail.LanguageCode = (hfWord1.Value.Length > 0 && hfWord1.Value == "en") ? "en-US" : "";
                    oDetail.PhraseCategoryCode = sWord1;
                    oDetail.PhraseCategoryName = sWord1;
                    tDetail.Add(oDetail);

                    oDetail = new PhraseCategoryContract();
                    oDetail.GroupID = i;
                    oDetail.LanguageCode = (hfWord2.Value.Length > 0 && hfWord2.Value == "ja") ? "ja-JP" : "";
                    oDetail.PhraseCategoryCode = sWord2;
                    oDetail.PhraseCategoryName = sWord2;
                    tDetail.Add(oDetail);
                }

                PhraseCategoryServiceClient cl = new PhraseCategoryServiceClient();
                cl.BulkInsertPhraseCategory(tHeader.ToArray(), tDetail.ToArray());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string sWord1 = ((DataRowView)e.Row.DataItem).Row[0].ToString();
                string sWord2 = ((DataRowView)e.Row.DataItem).Row[1].ToString();

                System.Web.UI.WebControls.TextBox txtWord1 = e.Row.FindControl("Word1") as System.Web.UI.WebControls.TextBox;
                System.Web.UI.WebControls.TextBox txtWord2 = e.Row.FindControl("Word2") as System.Web.UI.WebControls.TextBox;

                txtWord1.Text = sWord1;
                txtWord2.Text = sWord2;
            }
        }

        private void Import(string sFileName, string sExtension)
        {
            string sConnectionString = string.Empty;
            
            if (sExtension == ".xls")
            {
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + sFileName + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (sExtension == ".xlsx")
            {
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + sFileName + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }

            string sQuery = "SELECT * FROM [Sheet1$]";
            OleDbConnection oleDBConnection = new OleDbConnection(sConnectionString);

            if (oleDBConnection.State == ConnectionState.Closed)
            {
                oleDBConnection.Open();
            }

            OleDbCommand oleDBCommand = new OleDbCommand(sQuery, oleDBConnection);
            OleDbDataAdapter oleDBDataAdapter = new OleDbDataAdapter(oleDBCommand);

            DataSet ds = new DataSet();
            oleDBDataAdapter.Fill(ds);

            hfWord1.Value = ds.Tables[0].Columns[0].Caption;
            hfWord2.Value = ds.Tables[0].Columns[1].Caption;
            
            grdResult.DataSource = ds.Tables[0];
            grdResult.DataBind();
            oleDBDataAdapter.Dispose();
            oleDBConnection.Close();
            oleDBConnection.Dispose();
        }        
    }
}