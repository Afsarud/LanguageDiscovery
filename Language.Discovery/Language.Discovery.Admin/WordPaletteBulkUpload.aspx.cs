using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using Language.Discovery.Admin.PhraseCategoryService;
using Language.Discovery.Entity;
using SpreadsheetLight;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Language.Discovery.Admin
{
    public partial class WordPaletteBulkUpload : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulatDropDown();
                btnExport.Visible = true;
                btnImport.Visible = false;
                lblSelectFile.Visible = false;
                fuExcelUploader.Visible = false;
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
            }
        }

        private void PopulatDropDown()
        {
            try
            {
                //MiscServiceClient mclient = new MiscServiceClient();
                //string json = mclient.GetSchoolList("");
                //List<SchoolContract> schoollist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                //if (schoollist == null)
                //{
                //    schoollist = new List<SchoolContract>();
                //}
                //schoollist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnSelectSchool.Value, Name2=hdnSelectSchool.Value });
                //ddlSchool.DataSource = schoollist;
                //ddlSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                //ddlSchool.DataValueField = "SchoolID";
                //ddlSchool.DataBind();
                //if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                //{
                //    ddlSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                //    ddlSchool.Enabled = false;
                //}

                PaletteServiceClient pclient = new PaletteServiceClient();

                MiscServiceClient mclient = new MiscServiceClient();
                string json = pclient.GetPhraseCategory(SessionManager.Instance.UserProfile.NativeLanguage, 0);

                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);
                List<PhraseCategoryContract> plist1 = plist.ToList();
                plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = 0, PhraseCategoryCode = "[ALL]-NO CATEGORY" });
                plist.Insert(0, new PhraseCategoryContract() { PhraseCategoryID = -1, PhraseCategoryCode = "[Select Category]" });
                ddlSearchCategory.DataSource = plist;
                ddlSearchCategory.DataTextField = "PhraseCategoryCode";
                ddlSearchCategory.DataValueField = "PhraseCategoryID";
                ddlSearchCategory.DataBind();



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
                string sWord3 = ((DataRowView)e.Row.DataItem).Row[2].ToString();
                string sWord4 = ((DataRowView)e.Row.DataItem).Row[3].ToString();
                string skeyword = ((DataRowView)e.Row.DataItem).Row[4].ToString();
                string senglishsound = ((DataRowView)e.Row.DataItem).Row[5].ToString();
                string sjapsound = ((DataRowView)e.Row.DataItem).Row[6].ToString();
                string schsound = ((DataRowView)e.Row.DataItem).Row[7].ToString();
                string image = ((DataRowView)e.Row.DataItem).Row[8].ToString();
                string category = ((DataRowView)e.Row.DataItem).Row[9].ToString();

                TextBox txtWord1 = e.Row.FindControl("txtWord1") as TextBox;
                TextBox txtWord2 = e.Row.FindControl("txtWord2") as TextBox;
                TextBox txtWord3 = e.Row.FindControl("txtWord3") as TextBox;
                TextBox txtWord4 = e.Row.FindControl("txtWord4") as TextBox;
                TextBox txtKeyword = e.Row.FindControl("txtKeyword") as TextBox;
                TextBox txtEnglishSound = e.Row.FindControl("txtEnglishSound") as TextBox;
                TextBox txtJapaneseSound = e.Row.FindControl("txtJapaneseSound") as TextBox;
                TextBox txtChineseSound = e.Row.FindControl("txtChineseSound") as TextBox;
                TextBox txtImage = e.Row.FindControl("txtImage") as TextBox;
                TextBox txtCategory = e.Row.FindControl("txtCategory") as TextBox;


                txtWord1.Text = sWord1;
                txtWord2.Text = sWord2;
                txtWord3.Text = sWord3;
                txtWord4.Text = sWord4;
                txtKeyword.Text = skeyword;
                txtEnglishSound.Text = senglishsound;
                txtJapaneseSound.Text = sjapsound;
                txtImage.Text = image;
                txtCategory.Text = category;

            }
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            string filename = Upload();
            if (!string.IsNullOrEmpty(filename))
            {
                Import(filename);
            }
        }

        private string Upload()
        {
            lblImport.Visible = fuExcelUploader.HasFile;
            lblImport.Text = string.Empty;
            string sFileName = string.Empty;

            if (fuExcelUploader.HasFile)
            {
                try
                {
                    string sExtension = Path.GetExtension(fuExcelUploader.FileName).ToLower();

                    if (sExtension.Trim() == ".xls" || sExtension.Trim() == ".xlsx")
                    {
                        sFileName = Server.MapPath("Upload/") + fuExcelUploader.FileName;

                        if (!Directory.Exists(Server.MapPath("Upload/")))
                        {
                            Directory.CreateDirectory(Server.MapPath("Upload/"));
                        }

                        fuExcelUploader.SaveAs(sFileName);
                        lblImport.ForeColor = Color.Green;
                        lblImport.Text = "File name: " + fuExcelUploader.PostedFile.FileName + "<br>" + fuExcelUploader.PostedFile.ContentLength + " kb<br>" + "<br><b>Uploaded Successfully";

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
                }
            }
            else
            {
                lblImport.ForeColor = Color.Red;
                lblImport.Text = "You have not specified a file.";
            }
            return sFileName;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (Save())
                {
                    grdResult.DataSource = null;
                    grdResult.DataBind();
                    lblImport.Visible = true;
                    lblImport.Text = "Action Success";
                }

            }
            catch (Exception ex)
            {
                throw;
            }
            //Save();
            //try
            //{

            //    List<PhraseCategoryHeaderContract> tHeader = new List<PhraseCategoryHeaderContract>();
            //    List<PhraseCategoryContract> tDetail = new List<PhraseCategoryContract>();

            //    int nCount = grdResult.Rows.Count;

            //    for (int i = 0; i < nCount; i++)
            //    {
            //        PhraseCategoryHeaderContract oHeader = new PhraseCategoryHeaderContract();
            //        oHeader.PhraseCategoryHeaderID = i;
            //        oHeader.CreatedByID = SessionManager.Instance.UserProfile.UserID;
            //        oHeader.ModifiedByID = SessionManager.Instance.UserProfile.UserID;
            //        tHeader.Add(oHeader);

            //        string sWord1 = ((System.Web.UI.WebControls.TextBox)grdResult.Rows[i].FindControl("Word1")).Text;
            //        string sWord2 = ((System.Web.UI.WebControls.TextBox)grdResult.Rows[i].FindControl("Word2")).Text;

            //        PhraseCategoryContract oDetail = new PhraseCategoryContract();
            //        oDetail.GroupID = i;
            //        oDetail.LanguageCode = (hfWord1.Value.Length > 0 && hfWord1.Value == "en") ? "en-US" : "";
            //        oDetail.PhraseCategoryCode = sWord1;
            //        oDetail.PhraseCategoryName = sWord1;
            //        tDetail.Add(oDetail);

            //        oDetail = new PhraseCategoryContract();
            //        oDetail.GroupID = i;
            //        oDetail.LanguageCode = (hfWord2.Value.Length > 0 && hfWord2.Value == "ja") ? "ja-JP" : "";
            //        oDetail.PhraseCategoryCode = sWord2;
            //        oDetail.PhraseCategoryName = sWord2;
            //        tDetail.Add(oDetail);
            //    }

            //    PhraseCategoryServiceClient cl = new PhraseCategoryServiceClient();
            //    cl.BulkInsertPhraseCategory(tHeader.ToArray(), tDetail.ToArray());
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

        }


        private bool Save()
        {
            try
            {

                PaletteServiceClient pclient = new PaletteServiceClient();
                string json = pclient.GetPhraseCategory("en-US",0);
                List<PhraseCategoryContract> plist = new JavaScriptSerializer().Deserialize<List<PhraseCategoryContract>>(json);

                int count = grdResult.Rows.Count;
                List<WordHeaderContract> header = new List<WordHeaderContract>();
                List<WordContract> detail = new List<WordContract>();

                PaletteServiceClient client = new PaletteServiceClient();
                int index = -1;
                foreach (GridViewRow row in grdResult.Rows)
                {
                    long categoryid = -1;
                    var p = plist.Find(x => x.PhraseCategoryCode.ToLower().Equals(((TextBox)row.FindControl("txtCategory")).Text.ToLower()));
                    if (p == null)
                        categoryid = -1;
                    else
                        categoryid = p.PhraseCategoryID;

                    WordHeaderContract whc = new WordHeaderContract();
                    whc.WordHeaderID = index;
                    whc.PhraseCategoryID = categoryid;
                    whc.ImageFile = ((TextBox)row.FindControl("txtImage")).Text;
                    whc.CreatedByID = SessionManager.Instance.UserProfile.UserID; ;
                    whc.Keyword = ((TextBox)row.FindControl("txtKeyword")).Text;
                    header.Add(whc);

                    detail.Add(new WordContract()
                    {
                        WordMapID = index,
                        WordID =  0,
                        Word =  ((TextBox)row.FindControl("txtWord1")).Text,
                        LanguageCode = "en-US",
                        SoundFile = ((TextBox)row.FindControl("txtEnglishSound")).Text,
                        SchoolID = Convert.ToInt32( ddlSchool.SelectedValue )
                    });

                    detail.Add(new WordContract()
                    {
                        WordMapID = index,
                        WordID = 0,
                        Word = ((TextBox)row.FindControl("txtWord2")).Text,
                        LanguageCode = "ja-JP",
                        SoundFile = ((TextBox)row.FindControl("txtJapaneseSound")).Text,
                        SchoolID = Convert.ToInt32(ddlSchool.SelectedValue)
                    });
                    detail.Add(new WordContract()
                    {
                        WordMapID = index,
                        WordID = 0,
                        Word = ((TextBox)row.FindControl("txtWord3")).Text,
                        LanguageCode = "ja-RO",
                        SchoolID = Convert.ToInt32(ddlSchool.SelectedValue)
                    });
                    detail.Add(new WordContract()
                    {
                        WordMapID = index,
                        WordID = 0,
                        Word = ((TextBox)row.FindControl("txtWord4")).Text,
                        LanguageCode = "zh-CN",
                        SoundFile = ((TextBox)row.FindControl("txtChineseSound")).Text,
                        SchoolID = Convert.ToInt32(ddlSchool.SelectedValue)
                    });
                    
                    index--;
                }


                bool uploaded = client.BulkAddWords(header.ToArray(), detail.ToArray(), (rdoImportActionList.SelectedValue == "0"), Convert.ToInt64(ddlSearchCategory.SelectedValue));
                
                return uploaded;

            }
            catch (Exception ex)
            {
                lblImport.Visible = true;
                lblImport.Text = ex.Message;
                throw ex;
            }
        }


        protected void btnExport_OnClick(object sender, EventArgs e)
        {
            try
            {
                Export();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Export()
        {
            PaletteServiceClient client = new PaletteServiceClient();
            List<WordHeaderContract> list = new List<WordHeaderContract>();
            for (int i = 1; i < 10; i++)
            {
                SearchDTO dto = new SearchDTO();
                dto.SchoolID = 0;
                dto.CategoryID = Convert.ToInt64(ddlSearchCategory.SelectedValue);
                dto.Word = "";
                dto.Keyword = "";
                dto.PageNumber = i;
                dto.LanguageCode = "en-US"; //ddlLanguage.SelectedValue.ToString();
                dto.RowsPerPage = 500;
                dto.IsExport = true;


                string json = client.SearchWordAdmin(dto);
                List<WordHeaderContract> list2 = new JavaScriptSerializer().Deserialize<List<WordHeaderContract>>(json);
                if (list2 != null && list2.Count > 0)
                    list.AddRange(list2);
                else
                    break;
                //List<WordContract> wlist = new List<WordContract>();
            }

            string filename = "";
            //string[] columns = new[] { "A","B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L","M"};

            using (SLDocument sl = new SLDocument())
            {
                SLStyle style = sl.CreateStyle();
                style.SetFontBold(true);

                
                sl.SetCellValue("A1","English");
                sl.SetCellStyle("A1", style);
                sl.SetCellValue("B1","Japanese");
                sl.SetCellStyle("B1", style);
                sl.SetCellValue("C1","Kanji");
                sl.SetCellStyle("C1", style);
                sl.SetCellValue("D1","Romanji");
                sl.SetCellStyle("D1", style);
                sl.SetCellValue("E1","Chinese");
                sl.SetCellStyle("E1", style);
                sl.SetCellValue("F1","Other");
                sl.SetCellStyle("F1", style);
                sl.SetCellValue("G1","PinYin");
                sl.SetCellStyle("G1", style);
                sl.SetCellValue("H1","Keyword");
                sl.SetCellStyle("H1", style);
                sl.SetCellValue("I1","English Sound");
                sl.SetCellStyle("I1", style);
                sl.SetCellValue("J1","Japanese Sound");
                sl.SetCellStyle("J1", style);
                sl.SetCellValue("K1","Chinese Sound");
                sl.SetCellStyle("K1", style);
                sl.SetCellValue("L1","Image");
                sl.SetCellStyle("L1", style);
                sl.SetCellValue("M1", "WordType");
                sl.SetCellStyle("M1", style);
                sl.SetCellValue("N1", "Sequence");
                sl.SetCellStyle("N1", style);


                int rowIndex = 2;

                foreach (WordHeaderContract wc in list)
                {
                    foreach (WordContract w  in wc.Words)
                    {

                        if (w.LanguageCode == "en-US")
                        {
                            sl.SetCellValue("A" + rowIndex.ToString(), w.Word);
                            sl.SetCellValue("I" + rowIndex.ToString(), w.SoundFile);
                        }
                        else if (w.LanguageCode == "ja-JP")
                        {
                            sl.SetCellValue("B" + rowIndex.ToString(), w.Word);
                            sl.SetCellValue("J" + rowIndex.ToString(), w.SoundFile);
                        }
                        else if (w.LanguageCode == "ja-KA")
                        {
                            sl.SetCellValue("C" + rowIndex.ToString(), w.Word);
                        }
                        else if (w.LanguageCode == "ja-RO")
                        {
                            sl.SetCellValue("D" + rowIndex.ToString(), w.Word);
                        }

                        else if (w.LanguageCode == "zh-CN")
                        {
                            sl.SetCellValue("E" + rowIndex.ToString(), w.Word);
                            sl.SetCellValue("K" + rowIndex.ToString(), w.SoundFile);
                        }
                        else if (w.LanguageCode == "zh-X")
                        {
                            sl.SetCellValue("F" + rowIndex.ToString(), w.Word);
                        }
                        else if (w.LanguageCode == "zh-PN")
                        {
                            sl.SetCellValue("G" + rowIndex.ToString(), w.Word);
                        }
                        sl.SetCellValue("H" + rowIndex.ToString(), wc.Keyword);
                        sl.SetCellValue("L" + rowIndex.ToString(), wc.ImageFile);
                        sl.SetCellValue("M" + rowIndex.ToString(), wc.WordType);
                        sl.SetCellValue("N" + rowIndex.ToString(), wc.Sequence);
                    }
                    rowIndex++;
                }

                filename = Path.Combine(Server.MapPath("~//Upload//"), "ExportedWord_" + ddlSearchCategory.SelectedItem.Text.Replace("/", "") + ".xlsx");
                sl.SaveAs(filename);
            }

            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "Application/x-msexcel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filename));
            Response.WriteFile(filename);
            Response.Flush();
            File.Delete(filename);

            Response.End();
        }

        protected void rdoAction_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdoAction.SelectedValue == "1") //export
            {
                btnExport.Visible = true;
                btnImport.Visible = false;
                lblSelectFile.Visible = false;
                fuExcelUploader.Visible = false;
                lblImport.Visible = false;
            }
            else //import
            {
                btnExport.Visible = false;
                btnImport.Visible = true;
                lblSelectFile.Visible = true;
                fuExcelUploader.Visible = true;
            }
        }

        private void Import(string filename)
        {
            try
            {
                List<WordHeaderContract> header = new List<WordHeaderContract>();
                List<WordContract> detail = new List<WordContract>();

                FileStream fs = new FileStream(filename, FileMode.Open);

                PaletteServiceClient client = new PaletteServiceClient();
                int index = -1;
                using (SLDocument sl = new SLDocument(fs,"Sheet1"))
                {
                    SLWorksheetStatistics ss = sl.GetWorksheetStatistics();
                    bool isEndOfRow = false;
                    int currentRowIndex = 2;
                    long userid = SessionManager.Instance.UserProfile.UserID;
                    while (!isEndOfRow)
                    {
                        WordHeaderContract whc = new WordHeaderContract();
                        whc.WordHeaderID = index;
                        whc.Keyword = sl.GetCellValueAsString("H" + currentRowIndex.ToString());
                        whc.WordType = sl.GetCellValueAsString("M" + currentRowIndex.ToString());
                        whc.ImageFile = sl.GetCellValueAsString("L" + currentRowIndex.ToString());
                        whc.Sequence= sl.GetCellValueAsString("N" + currentRowIndex.ToString()).Trim().Length == 0 
                            ? 0 : Convert.ToInt32(sl.GetCellValueAsString("N" + currentRowIndex.ToString()));

                        whc.PhraseCategoryID = Convert.ToInt64(ddlSearchCategory.SelectedValue);
                        whc.CreatedByID = userid;

                        if(string.IsNullOrEmpty(sl.GetCellValueAsString("A" + currentRowIndex.ToString().Trim())))
                        {
                            if (currentRowIndex == ss.EndRowIndex)
                                isEndOfRow = true;

                            currentRowIndex++;
                            continue;
                        }
                        detail.Add(new WordContract()
                        {
                            WordMapID = index,
                            WordID = 0,
                            Word = sl.GetCellValueAsString("A" + currentRowIndex.ToString()),
                            LanguageCode = "en-US",
                            SoundFile = sl.GetCellValueAsString("I" + currentRowIndex.ToString()),
                            SchoolID = 0
                        });
                        if (!string.IsNullOrEmpty(sl.GetCellValueAsString("B" + currentRowIndex.ToString())))
                        {
                            detail.Add(new WordContract()
                            {
                                WordMapID = index,
                                WordID = 0,
                                Word = sl.GetCellValueAsString("B" + currentRowIndex.ToString()),
                                LanguageCode = "ja-JP",
                                SoundFile = sl.GetCellValueAsString("J" + currentRowIndex.ToString()),
                                SchoolID = 0
                            });
                        }
                        if (!string.IsNullOrEmpty(sl.GetCellValueAsString("C" + currentRowIndex.ToString())))
                        {
                            detail.Add(new WordContract()
                            {
                                WordMapID = index,
                                WordID = 0,
                                Word = sl.GetCellValueAsString("C" + currentRowIndex.ToString()),
                                LanguageCode = "ja-KA",
                                SchoolID = 0
                            });
                        }
                        if (!string.IsNullOrEmpty(sl.GetCellValueAsString("D" + currentRowIndex.ToString())))
                        {
                            detail.Add(new WordContract()
                            {
                                WordMapID = index,
                                WordID = 0,
                                Word = sl.GetCellValueAsString("D" + currentRowIndex.ToString()),
                                LanguageCode = "ja-RO",
                                SchoolID = 0
                            });
                        }
                        if (!string.IsNullOrEmpty(sl.GetCellValueAsString("E" + currentRowIndex.ToString())))
                        {
                            detail.Add(new WordContract()
                            {
                                WordMapID = index,
                                WordID = 0,
                                Word = sl.GetCellValueAsString("E" + currentRowIndex.ToString()),
                                LanguageCode = "zh-CN",
                                SoundFile = sl.GetCellValueAsString("K" + currentRowIndex.ToString()),
                                SchoolID = 0
                            });
                        }
                        if (!string.IsNullOrEmpty(sl.GetCellValueAsString("F" + currentRowIndex.ToString())))
                        {
                            detail.Add(new WordContract()
                            {
                                WordMapID = index,
                                WordID = 0,
                                Word = sl.GetCellValueAsString("F" + currentRowIndex.ToString()),
                                LanguageCode = "zh-X",
                                SchoolID = 0
                            });
                        }
                        if (!string.IsNullOrEmpty(sl.GetCellValueAsString("G" + currentRowIndex.ToString())))
                        {
                            detail.Add(new WordContract()
                            {
                                WordMapID = index,
                                WordID = 0,
                                Word = sl.GetCellValueAsString("G" + currentRowIndex.ToString()),
                                LanguageCode = "zh-PN",
                                SchoolID = 0
                            });
                        }
                        header.Add(whc);

                        if (currentRowIndex == ss.EndRowIndex)
                            isEndOfRow = true;

                        currentRowIndex++;
                        index--;
                    }

                }

                bool uploaded = client.BulkAddWords(header.ToArray(), detail.ToArray(), (rdoImportActionList.SelectedValue == "0"), Convert.ToInt64(ddlSearchCategory.SelectedValue));

                fs.Dispose();
                fs = null;
                ddlSearchCategory.SelectedIndex = 0;
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}