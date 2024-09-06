using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Language.Discovery.Repository;
using Language.Discovery.Entity;
using System.Web;
using System.Web.UI;
using System.Web.Script.Serialization;


namespace Robot
{
    public partial class frmRobot : Form
    {
        private string logpath = Environment.CurrentDirectory + @"\Log";
        Logger log = null;
        public frmRobot()
        {
            InitializeComponent();
        }

        private void frmRobot_Load(object sender, EventArgs e)
        {
            try
            {
                System.Threading.Thread.Sleep(1000);
                log = new Logger(logpath);
                AutoReply();
                Application.Exit();
            }
            catch (Exception ex)
            {
               
   

                log.ErrorLog(ex.Message + "\r\n" + ex.StackTrace);
            }
        }

        private void AutoReply()
        {
            try
            {
                List<UserMessageContract> umlist = new UserRepository().GetUserMessageListThatNeedResponse();
                log.DebugLog("Getting messages that needs response");
                if (umlist != null)
                {
                    PhraseCategoryRepository pclient = new PhraseCategoryRepository();

                    List<PhraseCategoryContract> pplist = pclient.GetPhraseCategoryList("en-US", 0, 0);
                    List<PhraseCategoryContract> plist = null;
                    if (pplist != null)
                    {
                        //pplist.RemoveAll(x => (x.IsDemo == false && x.DisplayInUI == false) || (x.IsDemo == true && x.DisplayInUI == true));
                        plist = pplist.FindAll(x => x.IsDemo && !x.DisplayInUI);
                    }
                    int pindex = 0;
                    if (plist != null)
                    {
                        Random rr = new Random();
                        pindex = rr.Next(0, plist.Count); //for ints
                        log.DebugLog(string.Format("Category {0} with CategoryID {1}", plist != null && plist.Count > 0 ? plist[pindex].PhraseCategoryName : "", plist != null && plist.Count > 0 ? plist[pindex].PhraseCategoryID.ToString() : "0"));
                        log.DebugLog(string.Format("Category count {0}", plist != null ? plist.Count.ToString() : "0"));
                        foreach (UserMessageContract umc in umlist)
                        {
                            log.DebugLog(string.Format("Preparing message from {0}[{1}]", umc.Sender, umc.SenderID));
                            List<UserMessageContract> mlist = new List<UserMessageContract>();
                            SearchDTO dto = new SearchDTO()
                            {
                                SchoolID = 0,
                                CategoryID = plist != null && plist.Count > 0 ? plist[pindex].PhraseCategoryID : 0,
                                Keyword = umc.Keyword.Replace("'", "''"),
                                LevelID = 0,
                                PageNumber = 1,
                                RowsPerPage = 100
                            };

                            List<PaletteContract> list = new PaletteRepository().Search(dto).ToList();
                            log.DebugLog(string.Format("Finish searching palette with keyword {0}", umc.Keyword));
                            int index = 0;
                            if (list != null)
                            {
                                Random r = new Random();
                                index = r.Next(0, list.Count); //for ints

                            }
                            PaletteContract paleteContract = list[index];

                            PaletteContract pcontract = new PaletteContract();
                            var pnativelist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(umc.NativeLanguage)).OrderBy(x => x.Ordinal).ToList();
                            var plearninglist = paleteContract.PhraseList.FindAll(x => x.LanguageCode.Equals(umc.LearningLanguage)).OrderBy(x => x.Ordinal).ToList();
                            string native = string.Empty;

                            List<UserMessageContract> msglist = new List<UserMessageContract>();

                            string words = string.Empty;
                            string nativeSentence = "";
                            string learningSentence = "";
                            var sk = paleteContract.SentenceList.Find(x => x.PaletteID.Equals(paleteContract.PaletteID) && !string.IsNullOrEmpty(x.Keyword));

                            log.DebugLog(string.Format("Start building palette"));
                            foreach (Phrase p in pnativelist)
                            {
                                nativeSentence += p.Word + "&nbsp;";
                            }

                            foreach (Phrase learn in plearninglist)
                            {
                                learningSentence += learn.Word + "&nbsp;";
                            }
                            log.DebugLog(string.Format("End building palette"));
                            nativeSentence = string.Format("<span id='spanNative', data-keyword='{0}'>{1}</span></br>", sk != null ? sk.Keyword : "", nativeSentence);
                            learningSentence = string.Format("<span id='spanLearning', data-keyword='{0}'>{1}</span></br>", sk != null ? sk.Keyword : "", learningSentence);


                            mlist.Add(new UserMessageContract()
                            {
                                SenderID = umc.RecepientID,
                                RecepientID = umc.SenderID,
                                NativeLanguageMessage = System.Web.HttpUtility.HtmlEncode(nativeSentence),
                                LearningLanguageMessage = System.Web.HttpUtility.HtmlEncode(learningSentence),
                                Keyword = paleteContract.Keyword,
                                IsFromNewFriends = false,
                                HasFilteredWords = false,
                                NeedResponse = false
                            });

                            List<long> ids = new UserRepository().SaveMessage(mlist);
                            log.DebugLog(string.Format("Message sent to {0}[{1}] from {2}[{3}]", umc.Sender, umc.SenderID, umc.Recepient, umc.RecepientID));
                            bool updated = new UserRepository().UpdateUserMessage(umc.UserMailID);
                            log.DebugLog(string.Format("Finish updating UsermailID {0} ", umc.UserMailID));
                        }
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
