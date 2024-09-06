using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class PaletteBulkUpload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //List<PaletteContract> list = new List<PaletteContract>();

            //PaletteContract c = new PaletteContract();
            //c.PhraseList.Add(new Phrase() { Word = "test" });
            //list.Add(c);
            //PaletteContract c1 = new PaletteContract();
            //c1.PhraseList.Add(new Phrase() { Word = "test2" });
            //list.Add(c1);

            //Repeater1.DataSource = list;
            //Repeater1.DataBind();
        }


        private void InitializePalette(RepeaterItem item)
        {
            for (int i = 1; i <= 10; i++)
            {
                TextBox txtEng = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtEng" + i.ToString());
                TextBox txtJap = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtJap" + i.ToString());
                TextBox txtKanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtKanji" + i.ToString());
                TextBox txtRomanji = (TextBox)this.Master.FindControl("ContentPlaceHolder3").FindControl("txtRomanji" + i.ToString());
                DropDownList ddlOrderEng = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderEng" + i.ToString());
                DropDownList ddlOrderJap = (DropDownList)this.Master.FindControl("ContentPlaceHolder3").FindControl("ddlOrderJap" + i.ToString());

                txtEng.Attributes.Add("data-phraseid", (-1 * i).ToString());
                txtJap.Attributes.Add("data-phraseid", (-1 * i).ToString());
                txtKanji.Attributes.Add("data-phraseid", (-1 * i).ToString());
                txtRomanji.Attributes.Add("data-phraseid", (-1 * i).ToString());

            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                PaletteContract c = (PaletteContract)e.Item.DataItem;
                foreach (Sentence s in c.SentenceList)
                {
                    List<Phrase> plist = c.PhraseList.FindAll(x => x.SentenceID.Equals(s.SentenceID));
                    if (plist != null)
                    {
                        for (int i = 0; i < 10; i++)
                        {
                            if (s.LanguageCode == "en-US")
                            {
                                TextBox txtEng = (TextBox)e.Item.FindControl("txtEng" + (i + 1).ToString());
                                txtEng.Text = plist[i].Word;
                            }

                            if (s.LanguageCode == "ja-JP")
                            {
                                TextBox txtJap = (TextBox)e.Item.FindControl("txtJap" + (i + 1).ToString());
                                txtJap.Text = plist[i].Word;
                            }

                        }
                    }
                }
              
                
            }
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

                        DataSet ds = FileHelper.Import(sFileName, sExtension);
                        List<PaletteContract> list = FileHelper.ConvertTablesToPaletteList(ds);

                        //hfWord1.Value = ds.Tables[0].Columns[0].Caption;
                        //hfWord2.Value = ds.Tables[0].Columns[1].Caption;

                        Repeater1.DataSource = list;
                        Repeater1.DataBind();
                        
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
        }

        
    }
}