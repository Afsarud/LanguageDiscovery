using Language.Discovery.Admin.MiscService;
using Language.Discovery.Admin.PaletteService;
using Language.Discovery.Admin.PhraseCategoryService;
using Language.Discovery.Admin.SchoolService;
using Language.Discovery.Admin.UserService;
using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using SpreadsheetLight;
using System.Reflection;
using System.Net;
using iTextSharp.text.pdf;
using iTextSharp.text;

namespace Language.Discovery.Admin
{
    public partial class StudentProgress : System.Web.UI.Page
    {
        private SortDirection GetSortDirection(SortDirection dir)
        {
            if (dir == SortDirection.Ascending)
            {
                ViewState["SortDirection"] = SortDirection.Descending;
            }
            else
            {
                ViewState["SortDirection"] = SortDirection.Ascending;
            }
            return (SortDirection)ViewState["SortDirection"];
        } 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["SortDirection"] = SortDirection.Ascending;
                PopulatDropDown();
            }
        }

        private void PopulatDropDown()
        {
            try
            {
                MiscServiceClient mclient = new MiscServiceClient();
                string json = mclient.GetSchoolList("");
                List<SchoolContract> schoollist = new JavaScriptSerializer().Deserialize<List<SchoolContract>>(json);
                if (schoollist == null)
                {
                    schoollist = new List<SchoolContract>();
                }
                schoollist.Insert(0, new SchoolContract() { SchoolID = 0, Name1 = hdnSelectSchool.Value, Name2 = hdnSelectSchool.Value });
                ddlSchool.DataSource = schoollist;
                ddlSchool.DataTextField = SessionManager.Instance.UserProfile.NativeLanguage != "en-US" ? "Name2" : "Name1";
                ddlSchool.DataValueField = "SchoolID";
                ddlSchool.DataBind();
                if (SessionManager.Instance.UserProfile.UserTypeName == "Teacher")
                {
                    ddlSchool.SelectedValue = SessionManager.Instance.UserProfile.SchoolID.ToString();
                    LoadStudents();
                    ddlSchool.Enabled = false;
                }
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

                //string userid = ((DataRowView)e.Row.DataItem).Row["UserID"].ToString();

                long suserid = ((UserContract)e.Row.DataItem).UserID;
                string sfurigana = ((UserContract)e.Row.DataItem).Furigana;
                string spalaygoID = ((UserContract)e.Row.DataItem).UserName;
                string sCustom1 = ((UserContract)e.Row.DataItem).Custom1;
                string sCustom2 = ((UserContract)e.Row.DataItem).Custom2;
                string sCustom3 = ((UserContract)e.Row.DataItem).Custom3;
                string sNote1 = ((UserContract)e.Row.DataItem).Note1;
                string sNote2 = ((UserContract)e.Row.DataItem).Note2;
                string sNote3 = ((UserContract)e.Row.DataItem).Note3;
                string sNote4 = ((UserContract)e.Row.DataItem).Note4;

                Label lblUserID = e.Row.FindControl("lblUserID") as Label;
                TextBox txtFurigana = e.Row.FindControl("txtFurigana") as TextBox;
                Label lblUserName = e.Row.FindControl("lblUserName") as Label;
                TextBox txtCustom1 = e.Row.FindControl("txtCustom1") as TextBox;
                TextBox txtCustom2 = e.Row.FindControl("txtCustom2") as TextBox;
                TextBox txtCustom3 = e.Row.FindControl("txtCustom3") as TextBox;
                TextBox txtNote1 = e.Row.FindControl("txtNote1") as TextBox;
                TextBox txtNote2 = e.Row.FindControl("txtNote2") as TextBox;
                TextBox txtNote3 = e.Row.FindControl("txtNote3") as TextBox;
                TextBox txtNote4 = e.Row.FindControl("txtNote4") as TextBox;
                

                lblUserID.Text = suserid.ToString();
                txtFurigana.Text = sfurigana;
                lblUserName.Text = spalaygoID;
                txtCustom1.Text = sCustom1;
                txtCustom2.Text = sCustom2;
                txtCustom3.Text = sCustom3;
                txtNote1.Text = sNote1;
                txtNote2.Text = sNote2;
                txtNote3.Text = sNote3;
                txtNote4.Text = sNote4;


            }
        }

        protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                LoadStudents();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Save())
            {
                lblInfo.Visible = true;
            }
            else
            {
                lblInfo.Visible = true;
                lblInfo.Text = "Error Saving";
                lblInfo.ForeColor = System.Drawing.Color.Red; 
            }
        }

        private void LoadStudents()
        {
            try
            {
                UserContract[] arrc = new UserClient().GetUserListBySchoolForTrackingOrProgress(Convert.ToInt32(ddlSchool.SelectedValue));
                List<UserContract> list = arrc.ToList();

                grdResult.DataSource = list;
                grdResult.DataBind();

                btnExport.Enabled = true;
                btnSave.Enabled = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool Save()
        {
            try
            {
                bool updated = false;
                List<UserContract> userlist = GetGridViewData();
                
                if (userlist.Count == 0)
                    return false;

                UserService.UserClient x = new UserService.UserClient();
                if (userlist.Count > 0)
                    updated = x.UpdateUserTrackProgress(userlist.ToArray());

                return updated;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void grdResult_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {

                List<UserContract> list = GetGridViewData();
                List<UserContract> sortedlist  = list;
                if (GetSortDirection((SortDirection)ViewState["SortDirection"]) == SortDirection.Ascending)
                {
                    sortedlist = list.OrderBy(x => x.GetType().GetProperty(e.SortExpression).GetValue(x, null)).ToList();
                }
                else
                {
                    sortedlist = list.OrderByDescending(x => x.GetType().GetProperty(e.SortExpression).GetValue(x, null)).ToList();
                }

                // Use the HTML safe codes for the up arrow ▲ and down arrow ▼.
            
                grdResult.DataSource = sortedlist;
                grdResult.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private List<UserContract> GetGridViewData()
        {

            List<UserContract> userlist = new List<UserContract>();
            foreach (GridViewRow row in grdResult.Rows)
            {
                Label lblUserID = row.FindControl("lblUserID") as Label;
                TextBox txtFurigana = row.FindControl("txtFurigana") as TextBox;
                Label lblUserName = row.FindControl("lblUserName") as Label;
                TextBox txtCustom1 = row.FindControl("txtCustom1") as TextBox;
                TextBox txtCustom2 = row.FindControl("txtCustom2") as TextBox;
                TextBox txtCustom3 = row.FindControl("txtCustom3") as TextBox;
                TextBox txtNote1 = row.FindControl("txtNote1") as TextBox;
                TextBox txtNote2 = row.FindControl("txtNote2") as TextBox;
                TextBox txtNote3 = row.FindControl("txtNote3") as TextBox;
                TextBox txtNote4 = row.FindControl("txtNote4") as TextBox;
                UserContract user = new UserContract()
                {
                    UserID = string.IsNullOrEmpty(lblUserID.Text) ? 0 : Convert.ToInt32(lblUserID.Text),
                    UserName = lblUserName.Text,
                    Furigana = txtFurigana.Text,
                    Custom1 = txtCustom1.Text,
                    Custom2 = txtCustom2.Text,
                    Custom3 = txtCustom3.Text,
                    Note1 = txtNote1.Text,
                    Note2 = txtNote2.Text,
                    Note3 = txtNote3.Text,
                    Note4 = txtNote4.Text  
                };
                userlist.Add(user);
            }

            return userlist;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                
                if (ddlExport.SelectedValue == "Excel")
                    ExportToExcel();
                else
                    ExportToPdf();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private DataSet CreateBlankDataset()
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            //dt.Columns.Add("UserID", typeof(long));
            dt.Columns.Add("Furigana", typeof(string));
            dt.Columns.Add("PalaygoID", typeof(string));
            dt.Columns.Add("2016", typeof(string));
            dt.Columns.Add("2017", typeof(string));
            dt.Columns.Add("2018", typeof(string));
            dt.Columns.Add("Note1", typeof(string));
            dt.Columns.Add("Note2", typeof(string));
            dt.Columns.Add("Note3", typeof(string));
            dt.Columns.Add("Note4", typeof(string));

            ds.Tables.Add(dt);
            ds.AcceptChanges();
            return ds;
        }

        private void ExportToExcel()
        {
            SLDocument sl = new SLDocument();

            DataSet ds = CreateBlankDataset();

            foreach (GridViewRow row in grdResult.Rows)
            {
                Label lblUserID = row.FindControl("lblUserID") as Label;
                TextBox txtFurigana = row.FindControl("txtFurigana") as TextBox;
                Label lblUserName = row.FindControl("lblUserName") as Label;
                TextBox txtCustom1 = row.FindControl("txtCustom1") as TextBox;
                TextBox txtCustom2 = row.FindControl("txtCustom2") as TextBox;
                TextBox txtCustom3 = row.FindControl("txtCustom3") as TextBox;
                TextBox txtNote1 = row.FindControl("txtNote1") as TextBox;
                TextBox txtNote2 = row.FindControl("txtNote2") as TextBox;
                TextBox txtNote3 = row.FindControl("txtNote3") as TextBox;
                TextBox txtNote4 = row.FindControl("txtNote4") as TextBox;

                DataRow r = ds.Tables[0].NewRow();
                r["Furigana"] = txtFurigana.Text;
                r["PalaygoID"] = lblUserName.Text;
                r["2016"] = txtCustom1.Text;
                r["2017"] = txtCustom2.Text;
                r["2018"] = txtCustom3.Text;
                r["Note1"] = txtNote1.Text;
                r["Note2"] = txtNote2.Text;
                r["Note3"] = txtNote3.Text;
                r["Note4"] = txtNote4.Text;
                ds.Tables[0].Rows.Add(r);
            }
            ds.AcceptChanges();

            sl.ImportDataTable(1, 1, ds.Tables[0], true);
            string filename = Path.Combine(Server.MapPath("~//Upload//"), string.Format("{0}_{1}_StudentTrackingList.xlsx", ddlSchool.SelectedItem.Text, DateTime.Now.ToString("MMddyyyyHHmm")));
            sl.SaveAs(filename);

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

        public void ExportToPdf()
        {
            DataSet ds = CreateBlankDataset();
            foreach (GridViewRow row in grdResult.Rows)
            {
                Label lblUserID = row.FindControl("lblUserID") as Label;
                TextBox txtFurigana = row.FindControl("txtFurigana") as TextBox;
                Label lblUserName = row.FindControl("lblUserName") as Label;
                TextBox txtCustom1 = row.FindControl("txtCustom1") as TextBox;
                TextBox txtCustom2 = row.FindControl("txtCustom2") as TextBox;
                TextBox txtCustom3 = row.FindControl("txtCustom3") as TextBox;
                TextBox txtNote1 = row.FindControl("txtNote1") as TextBox;
                TextBox txtNote2 = row.FindControl("txtNote2") as TextBox;
                TextBox txtNote3 = row.FindControl("txtNote3") as TextBox;
                TextBox txtNote4 = row.FindControl("txtNote4") as TextBox;

                DataRow r = ds.Tables[0].NewRow();
                r["Furigana"] = txtFurigana.Text;
                r["PalaygoID"] = lblUserName.Text;
                r["2016"] = txtCustom1.Text;
                r["2017"] = txtCustom2.Text;
                r["2018"] = txtCustom3.Text;
                r["Note1"] = txtNote1.Text;
                r["Note2"] = txtNote2.Text;
                r["Note3"] = txtNote3.Text;
                r["Note4"] = txtNote4.Text;
                ds.Tables[0].Rows.Add(r);
            }
            ds.AcceptChanges();
            DataTable dt = ds.Tables[0];
            Document document = new Document();
            string filename = Path.Combine(Server.MapPath("~//Upload//"), string.Format("{0}_{1}_StudentTrackingList.pdf", ddlSchool.SelectedItem.Text, DateTime.Now.ToString("MMddyyyyHHmm")));
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(filename, FileMode.Create));
            document.Open();
            iTextSharp.text.Font font5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5);

            PdfPTable table = new PdfPTable(dt.Columns.Count);
            //PdfPRow row = null;
            float[] widths = new float[] { 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f };

            table.SetWidths(widths);

            table.WidthPercentage = 100;
            PdfPCell cell = new PdfPCell(new iTextSharp.text.Phrase("Students"));

            cell.Colspan = dt.Columns.Count;

            foreach (DataColumn c in dt.Columns)
            {

                table.AddCell(new iTextSharp.text.Phrase(c.ColumnName, font5));
            }

            foreach (DataRow r in dt.Rows)
            {
                if (dt.Rows.Count > 0)
                {
                    table.AddCell(new iTextSharp.text.Phrase(r[0].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[1].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[2].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[3].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[4].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[5].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[6].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[7].ToString(), font5));
                    table.AddCell(new iTextSharp.text.Phrase(r[8].ToString(), font5));
                }
            } document.Add(table);
            document.Close();

            Response.Clear();
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "Application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filename));
            Response.WriteFile(filename);
            Response.Flush();
            File.Delete(filename);

            Response.End();
        }
    }
}