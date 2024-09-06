using Language.Discovery.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;

namespace Language.Discovery.Admin
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
                string filename = string.Empty;
                if (file == null)
                    return filename;

                filename = Path.GetFileName(file.FileName);
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
                byte[] buffer = null;
                if (file == null)
                    return buffer;

                buffer = new byte[file.ContentLength];

                file.InputStream.Read(buffer, 0, file.ContentLength);
                return buffer;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public static DataSet Import(string sFileName, string sExtension)
        {
            string sConnectionString = string.Empty;

            if (sExtension == ".xls")
            {
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + sFileName + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=1\"";
            }
            else if (sExtension == ".xlsx")
            {
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + sFileName + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=1\"";
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

            oleDBDataAdapter.Dispose();
            oleDBConnection.Close();
            oleDBConnection.Dispose();

            DataSet dsNew = new DataSet();

            for (int i = 1; i < 1000; i++)
            {
                DataRow[] rows = ds.Tables[0].Select("ID = " + i.ToString());
                if (rows.Length > 0)
                {
                    DataTable dt = ds.Tables[0].Clone();
                    dt.TableName = dt.TableName + i.ToString();
                    foreach( DataRow row in rows )
                    {
                        dt.ImportRow(row);
                    }
                    dsNew.Tables.Add(dt);
                }
            }
            dsNew.AcceptChanges();
            return dsNew;
        }

        public static DataSet ImportWords(string sFileName, string sExtension)
        {
            string sConnectionString = string.Empty;

            if (sExtension == ".xls")
            {
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + sFileName + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=1\"";
            }
            else if (sExtension == ".xlsx")
            {
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + sFileName + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=1\"";
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
            //ds.Tables[0].Columns.Add("UserID", typeof(long));
            //foreach (DataRow row in ds.Tables[0].Rows)
            //{
            //    row[0] = 0;
            //}

            

            oleDBDataAdapter.Dispose();
            oleDBConnection.Close();
            oleDBConnection.Dispose();

            return ds;
        }


        public static List<PaletteContract> ConvertTablesToPaletteList(DataSet ds)
        {
            int sentenceid = -1;
            List<PaletteContract> list = new List<PaletteContract>();
            int paletteid = -1;
            foreach (DataTable dt in ds.Tables)
            {
                PaletteContract pc = new PaletteContract();
                pc.PaletteID = paletteid;
                pc.PhraseCategoryID = 0; //TODO: Get the category

                
                Sentence senEn = new Sentence();
                senEn.SentenceID = sentenceid;
                senEn.CreatedBy = SessionManager.Instance.UserProfile.UserID;
                senEn.LanguageCode = "en-US";
                senEn.SoundFile = dt.Rows[11][2].ToString();
                senEn.PaletteID = paletteid;
                sentenceid--;

                Sentence senJP = new Sentence();
                senJP.SentenceID = sentenceid;
                senJP.CreatedBy = SessionManager.Instance.UserProfile.UserID;
                senJP.LanguageCode = "ja-JP";
                senJP.SoundFile = dt.Rows[12][2].ToString();
                senJP.PaletteID = paletteid;
                sentenceid--;


                Sentence senRO = new Sentence();
                senRO.SentenceID = sentenceid;
                senRO.CreatedBy = SessionManager.Instance.UserProfile.UserID;
                senRO.LanguageCode = "ja-RO";
                senRO.SoundFile = dt.Rows[12][2].ToString();
                senRO.PaletteID = paletteid;
                sentenceid--;

                pc.SentenceList.Add(senEn);
                pc.SentenceList.Add(senJP);
                pc.SentenceList.Add(senRO);

                foreach (DataColumn col in dt.Columns)
                {
                    if (col.ColumnName.ToLower() == "id" || col.ColumnName.ToLower() == "f2")
                        continue;

                    Phrase pe = new Phrase(); //en
                    
                    pe.Word = dt.Rows[0][col.ColumnName].ToString();
                    pe.SentenceID = senEn.SentenceID;
                    pe.SoundFile = dt.Rows[1][col.ColumnName].ToString();
                    pe.Ordinal = Convert.ToInt32(dt.Rows[2][col.ColumnName]);
                    pe.ImageFile = dt.Rows[9][col.ColumnName].ToString();

                    Phrase pj = new Phrase();//ja
                    pj.SentenceID = senJP.SentenceID;
                    pj.Word = dt.Rows[3][col.ColumnName].ToString();
                    pj.SoundFile = dt.Rows[7][col.ColumnName].ToString();
                    pj.Ordinal = Convert.ToInt32(dt.Rows[8][col.ColumnName]);
                    pj.ImageFile = dt.Rows[9][col.ColumnName].ToString();

                    Phrase pr = new Phrase();//Romanji
                    pr.SentenceID = senRO.SentenceID;
                    pr.Word = dt.Rows[6][col.ColumnName].ToString();
                    pr.SoundFile = dt.Rows[7][col.ColumnName].ToString();
                    pr.Ordinal = Convert.ToInt32(dt.Rows[8][col.ColumnName]);
                    pr.ImageFile = dt.Rows[9][col.ColumnName].ToString();

                    pc.PhraseList.Add(pe);
                    pc.PhraseList.Add(pj);
                    pc.PhraseList.Add(pr);
                }
                list.Add(pc);
                paletteid--;
            }

            return list;

        }
    }
}