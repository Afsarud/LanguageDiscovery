<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PaletteMaintenance.aspx.cs" Inherits="Language.Discovery.Admin.PaletteMaintenance"  EnableEventValidation="false" MaintainScrollPositionOnPostback="true" culture="auto" meta:resourcekey="PageResource1" uiculture="auto"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Palette Maintenance" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <style>
        .word {
            width:70px;
        }
        .file {
               width:100px;
        }
      
    </style>
    <div>
        <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
            <ContentTemplate>
                <fieldset class="fieldset">
                    <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
                    <asp:HiddenField ID="hdnPaletteID" runat="server" />
                    <legend><asp:Label ID="lblLegend" runat="server" Text="Search" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                        <table>
                    
                        <tr>
                            <td><asp:Label ID="lblSearchLevel" runat="server" meta:resourcekey="lblSearchLevelResource1">Level</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchLevel" runat="server" meta:resourcekey="ddlSearchLevelResource1"></asp:DropDownList></td>
                            <td><asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategoryResource1">Category</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchCategory" runat="server" meta:resourcekey="ddlSearchCategoryResource1"></asp:DropDownList></td>
                        </tr>
                            <tr>
                            <td><asp:Label ID="lblSearchSchool" runat="server" meta:resourcekey="lblSearchSchoolResource1">School</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>
                            <td><asp:Label ID="lblWord" runat="server" meta:resourcekey="lblWordResource1">Word</asp:Label></td>
                            <td><asp:TextBox ID="txtSearchWord" runat="server" meta:resourcekey="txtSearchWordResource1"></asp:TextBox></td>
                            <td><asp:Label ID="lblSearchKeyword" runat="server" meta:resourcekey="lblSearchKeywordResource1">Keyword</asp:Label></td>
                            <td><asp:TextBox ID="txtSearchKeyword" runat="server" meta:resourcekey="txtSearchKeywordResource1"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblSearchLanguage" runat="server" Text="Language" meta:resourcekey="lblSearchLanguageResource1"></asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchLanguage" runat="server"></asp:DropDownList></td>
                            <td><asp:CheckBox ID="chkShowWithTranslationOnly" Text="Show result with Translation Only" runat="server" /></td>
                            <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                            OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1"/></td>
                        </tr>

                    </table>
        
                    <asp:GridView ID="grdResult" runat="server" 
                            GridLines="Horizontal" Width="80%" Height="300px"
                            EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                            onpageindexchanging="grdResult_PageIndexChanging"
                            onrowdatabound="grdResult_RowDataBound" 
                            onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True" AllowCustomPaging="True"
                            BackColor="White" BorderColor="#336666" 
                            BorderWidth="3px" meta:resourcekey="grdResultResource1">
                            <PagerSettings Mode="NumericFirstLast" />
                            <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                            <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField  ShowHeader="False" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnSearchPaletteID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PaletteID").ToString() %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  ShowHeader="False" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnCurrentLanguageCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PaletteID").ToString() %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sentence" meta:resourcekey="TemplateFieldResource2" >
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence").ToString() %>' meta:resourcekey="Label2Resource1"></asp:Label> <br />
                                        <asp:Label ID="Label14" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence2").ToString() %>' meta:resourcekey="Label14Resource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="CreateDate" HeaderText="Create Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"/>
                                <asp:BoundField DataField="ModifiedDate" HeaderText="Modified Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"/>
                            </Columns>
                        </asp:GridView>
                </fieldset>
            </ContentTemplate>  
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="upDetail" runat="server"  UpdateMode="Conditional">
            <ContentTemplate>
        <fieldset>
            <legend><asp:Label ID="lblDataEntryLegend" runat="server" Text="Data Entry" meta:resourcekey="lblDataEntryLegendResource1"></asp:Label></legend>

            <table>
                <tr>
                    <td><asp:Label ID="lblPhraseCategory" runat="server" Text="Category" meta:resourcekey="lblPhraseCategoryResource1"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlPhraseCategory" runat="server" meta:resourcekey="ddlPhraseCategoryResource1"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="Label18" runat="server" Text="Level" meta:resourcekey="Label18Resource1"></asp:Label></td>
                    <td><asp:DropDownList ID="ddlLevel" runat="server" meta:resourcekey="ddlLevelResource1"></asp:DropDownList></td>
                </tr>
            </table>
            <br /><br />
            <asp:HiddenField ID="hdnEnglishSentenceID" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnKanjiSentenceID" Value="-3" runat="server" />
            <asp:HiddenField ID="hdnJapaneseSentenceID" Value="-2" runat="server" />
            <asp:HiddenField ID="hdnRomanjiSenteceID" Value="-4" runat="server" />
            <asp:Label ID="lblWarning" runat="server" ForeColor="Orange" Visible="false" Text="Warning: The Category of this palette is missing or might be deleted. If you want to assign this to another category please select on the dropdown and click save." meta:resourcekey="lblWarningResource1"></asp:Label>
            <table id="tblentry" border="1" style="padding:0;border-collapse:collapse;background-color:ButtonFace;">
                <thead>
                    <tr>
                        <td style="width:50px;"></td>
                        <td style="width:100px;"></td>
                        <td style="width:120px;"></td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                        <td>5</td>
                        <td>6</td>
                        <td>7</td>
                        <td>8</td>
                        <td>9</td>
                        <td>10</td>
                        <td>Sentence Sound</td>
                    </tr>
                </thead>
                <tr>
                    
                    <td><asp:Label ID="lblMainLanguage" runat="server" Text="English" meta:resourcekey="lblMainLanguageResource1"></asp:Label></td>
                    <td><asp:Label ID="lblSen1" runat="server" Text="Sen-1" meta:resourcekey="lblSen1Resource1"></asp:Label></td>
                    <td><asp:Label ID="lblSubLanguage" runat="server" Text="English" meta:resourcekey="lblSubLanguageResource1"></asp:Label>
                    </td>
                    <td><asp:TextBox ID="txtEng1" CssClass="word" runat="server" meta:resourcekey="txtEng1Resource1"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="English Text is required" ValidationGroup="v" ForeColor="Red" ControlToValidate="txtEng1" meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>

                    </td>
                    <td><asp:TextBox ID="txtEng2" CssClass="word" runat="server" meta:resourcekey="txtEng2Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng3" CssClass="word" runat="server" meta:resourcekey="txtEng3Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng4" CssClass="word" runat="server" meta:resourcekey="txtEng4Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng5" CssClass="word" runat="server" meta:resourcekey="txtEng5Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng6" CssClass="word" runat="server" meta:resourcekey="txtEng6Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng7" CssClass="word" runat="server" meta:resourcekey="txtEng7Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng8" CssClass="word" runat="server" meta:resourcekey="txtEng8Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng9" CssClass="word" runat="server" meta:resourcekey="txtEng9Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEng10" CssClass="word" runat="server" meta:resourcekey="txtEng10Resource1"></asp:TextBox></td>
                    
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblFile" runat="server" Text="Sound File" meta:resourcekey="lblFileResource1"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td><asp:TextBox ID="txtEngSoundFile1" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile1Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile2" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile2Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile3" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile3Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile4" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile4Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile5" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile5Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile6" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile6Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile7" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile7Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile8" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile8Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile9" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile9Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSoundFile10" CssClass="word" runat="server" meta:resourcekey="txtEngSoundFile10Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtEngSentenceSoundFile" CssClass="word" runat="server" meta:resourcekey="txtEngSentenceSoundFileResource1"></asp:TextBox></td>
                    
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblEnglishSound" runat="server" Text="Sound" meta:resourcekey="lblEnglishSoundResource1"></asp:Label></td>
                    <td></td>
                    <td>
                        <asp:FileUpload ID="fileEng1" CssClass="file" runat="server" meta:resourcekey="fileEng1Resource1" />
                    </td>
                    <td><asp:FileUpload ID="fileEng2" CssClass="file" runat="server" meta:resourcekey="fileEng2Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng3" CssClass="file" runat="server" meta:resourcekey="fileEng3Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng4" CssClass="file" runat="server" meta:resourcekey="fileEng4Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng5" CssClass="file" runat="server" meta:resourcekey="fileEng5Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng6" CssClass="file" runat="server" meta:resourcekey="fileEng6Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng7" CssClass="file" runat="server" meta:resourcekey="fileEng7Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng8" CssClass="file" runat="server" meta:resourcekey="fileEng8Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng9" CssClass="file" runat="server" meta:resourcekey="fileEng9Resource1" /></td>
                    <td><asp:FileUpload ID="fileEng10" CssClass="file" runat="server" meta:resourcekey="fileEng10Resource1" /></td>
                    <td><asp:FileUpload ID="fileEnglishSentenceSound" CssClass="file" runat="server" meta:resourcekey="fileEnglishSentenceSoundResource1" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblKeyword" runat="server" Text="Keyword" meta:resourcekey="lblKeywordResource1"></asp:Label></td>
                    <td></td>
                    <td colspan="10"><asp:TextBox ID="txtEnglishKeyword" runat="server" Width="524px" meta:resourcekey="txtEnglishKeywordResource1"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblOrder" runat="server" Text="Order" meta:resourcekey="lblOrderResource1"></asp:Label></td>
                    <td></td>
                    <td><asp:DropDownList ID="ddlOrderEng1" runat="server" meta:resourcekey="ddlOrderEng1Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng2" runat="server" meta:resourcekey="ddlOrderEng2Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng3" runat="server" meta:resourcekey="ddlOrderEng3Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng4" runat="server" meta:resourcekey="ddlOrderEng4Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng5" runat="server" meta:resourcekey="ddlOrderEng5Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng6" runat="server" meta:resourcekey="ddlOrderEng6Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng7" runat="server" meta:resourcekey="ddlOrderEng7Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng8" runat="server" meta:resourcekey="ddlOrderEng8Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng9" runat="server" meta:resourcekey="ddlOrderEng9Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderEng10" runat="server" meta:resourcekey="ddlOrderEng10Resource1"></asp:DropDownList></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblWordType" runat="server" Text="Word Type" meta:resourcekey="lblWordTypeResource1"></asp:Label></td>
                    <td></td>
                    <td><asp:TextBox ID="txtWordType1" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType2" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType3" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType4" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType5" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType6" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType7" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType8" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType9" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtWordType10" CssClass="word" runat="server"></asp:TextBox></td>
                </tr>
                <tr style="border-style:none;border:0;"><td colspan="14" style="height:20px;background-color:white;border:0;"></td></tr>
                <tr style="background-color:white;">
                    <td><asp:Label ID="lblLanguage" runat="server" Text="Language" meta:resourcekey="lblLanguageResource1"></asp:Label></td>
                    <td colspan="13"><asp:DropDownList ID="ddlLanguage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged"></asp:DropDownList></td>
                </tr>
                <tr style="border-style:none;border:0;"><td colspan="14" style="height:20px;background-color:white;border-style:none;border:0;"></td></tr>
                <tr><!--japanese -->
                    <td><asp:Label ID="lblSecondaryLanguageLabel" runat="server" Visible="false" Text="Japanese" meta:resourcekey="Label4Resource1"></asp:Label></td>
                    <td><asp:Label ID="Label5" runat="server" Text="Sen-1" meta:resourcekey="Label5Resource1"></asp:Label></td>
                    <td><asp:Label ID="lblHiragana" runat="server" Text="Japanese" meta:resourcekey="Label6Resource1"></asp:Label></td>
                    <td><asp:TextBox ID="txtJap1" CssClass="word" runat="server" meta:resourcekey="txtJap1Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap2" CssClass="word" runat="server" meta:resourcekey="txtJap2Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap3" CssClass="word" runat="server" meta:resourcekey="txtJap3Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap4" CssClass="word" runat="server" meta:resourcekey="txtJap4Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap5" CssClass="word" runat="server" meta:resourcekey="txtJap5Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap6" CssClass="word" runat="server" meta:resourcekey="txtJap6Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap7" CssClass="word" runat="server" meta:resourcekey="txtJap7Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap8" CssClass="word" runat="server" meta:resourcekey="txtJap8Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap9" CssClass="word" runat="server" meta:resourcekey="txtJap9Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJap10" CssClass="word" runat="server" meta:resourcekey="txtJap10Resource1"></asp:TextBox></td>
                </tr>
                <tr><!--Kanji -->
                    
                    <td></td>
                    <td><asp:Label ID="Label8" runat="server" Text="Sen-2" meta:resourcekey="Label8Resource1"></asp:Label></td>
                    <td><asp:Label ID="lblKanji" runat="server" Text="Kanji" meta:resourcekey="Label9Resource1"></asp:Label></td>
                    <td><asp:TextBox ID="txtKanji1" CssClass="word" runat="server" meta:resourcekey="txtKanji1Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji2" CssClass="word" runat="server" meta:resourcekey="txtKanji2Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji3" CssClass="word" runat="server" meta:resourcekey="txtKanji3Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji4" CssClass="word" runat="server" meta:resourcekey="txtKanji4Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji5" CssClass="word" runat="server" meta:resourcekey="txtKanji5Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji6" CssClass="word" runat="server" meta:resourcekey="txtKanji6Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji7" CssClass="word" runat="server" meta:resourcekey="txtKanji7Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji8" CssClass="word" runat="server" meta:resourcekey="txtKanji8Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji9" CssClass="word" runat="server" meta:resourcekey="txtKanji9Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtKanji10" CssClass="word" runat="server" meta:resourcekey="txtKanji10Resource1"></asp:TextBox></td>
                </tr>
                <tr><!--Romanji -->
                    
                    <td></td>
                    <td><asp:Label ID="Label11" runat="server" Text="Sen-3" meta:resourcekey="Label11Resource1"></asp:Label></td>
                    <td><asp:Label ID="lblRomanji" runat="server" Text="Romanji" meta:resourcekey="Label12Resource1"></asp:Label></td>
                    <td><asp:TextBox ID="txtRomanji1" CssClass="word" runat="server" meta:resourcekey="txtRomanji1Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji2" CssClass="word" runat="server" meta:resourcekey="txtRomanji2Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji3" CssClass="word" runat="server" meta:resourcekey="txtRomanji3Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji4" CssClass="word" runat="server" meta:resourcekey="txtRomanji4Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji5" CssClass="word" runat="server" meta:resourcekey="txtRomanji5Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji6" CssClass="word" runat="server" meta:resourcekey="txtRomanji6Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji7" CssClass="word" runat="server" meta:resourcekey="txtRomanji7Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji8" CssClass="word" runat="server" meta:resourcekey="txtRomanji8Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji9" CssClass="word" runat="server" meta:resourcekey="txtRomanji9Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtRomanji10" CssClass="word" runat="server" meta:resourcekey="txtRomanji10Resource1"></asp:TextBox></td>
                </tr>
              <tr>
                    <td></td>
                    <td>
                        <asp:Label ID="lblJapSoundTextFile" runat="server" Text="Sound File" meta:resourcekey="lblJapSoundTextFileResource1"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td><asp:TextBox ID="txtJapSoundFile1" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile1Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile2" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile2Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile3" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile3Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile4" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile4Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile5" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile5Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile6" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile6Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile7" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile7Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile8" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile8Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile9" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile9Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtJapSoundFile10" CssClass="word" runat="server" meta:resourcekey="txtJapSoundFile10Resource1"></asp:TextBox></td>
                  <td><asp:TextBox ID="txtJapSentenceSoundFile" CssClass="word" runat="server" meta:resourcekey="txtJapSentenceSoundFileResource1"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblSoundFile" runat="server" Text="Sound" meta:resourcekey="lblSoundFileResource1"></asp:Label></td>
                    <td></td>
                    <td><asp:FileUpload ID="fileJap1" CssClass="file" runat="server" meta:resourcekey="fileJap1Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap2" CssClass="file" runat="server" meta:resourcekey="fileJap2Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap3" CssClass="file" runat="server" meta:resourcekey="fileJap3Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap4" CssClass="file" runat="server" meta:resourcekey="fileJap4Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap5" CssClass="file" runat="server" meta:resourcekey="fileJap5Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap6" CssClass="file" runat="server" meta:resourcekey="fileJap6Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap7" CssClass="file" runat="server" meta:resourcekey="fileJap7Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap8" CssClass="file" runat="server" meta:resourcekey="fileJap8Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap9" CssClass="file" runat="server" meta:resourcekey="fileJap9Resource1" /></td>
                    <td><asp:FileUpload ID="fileJap10" CssClass="file" runat="server" meta:resourcekey="fileJap10Resource1" /></td>
                    <td><asp:FileUpload ID="fileSentenceJapaneseSound" CssClass="file" runat="server" meta:resourcekey="fileSentenceJapaneseSoundResource1" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblJapKeyword" runat="server" Text="Keyword" meta:resourcekey="lblJapKeywordResource1"></asp:Label></td>
                    <td></td>
                    <td colspan="10"><asp:TextBox ID="txtJapaneseKeyword" runat="server" Width="524px" meta:resourcekey="txtJapaneseKeywordResource1"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblJapOrder" runat="server" Text="Order" meta:resourcekey="lblJapOrderResource1"></asp:Label></td>
                    <td></td>
                    <td><asp:DropDownList ID="ddlOrderJap1" runat="server" meta:resourcekey="ddlOrderJap1Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap2" runat="server" meta:resourcekey="ddlOrderJap2Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap3" runat="server" meta:resourcekey="ddlOrderJap3Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap4" runat="server" meta:resourcekey="ddlOrderJap4Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap5" runat="server" meta:resourcekey="ddlOrderJap5Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap6" runat="server" meta:resourcekey="ddlOrderJap6Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap7" runat="server" meta:resourcekey="ddlOrderJap7Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap8" runat="server" meta:resourcekey="ddlOrderJap8Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap9" runat="server" meta:resourcekey="ddlOrderJap9Resource1"></asp:DropDownList></td>
                    <td><asp:DropDownList ID="ddlOrderJap10" runat="server" meta:resourcekey="ddlOrderJap10Resource1"></asp:DropDownList></td>
                </tr>
              <tr>
                    <td></td>
                    <td>
                        <asp:Label ID="lblImageFile" runat="server" Text="Image File" meta:resourcekey="lblImageFileResource1"></asp:Label></td>
                    <td>&nbsp;</td>
                    <td><asp:TextBox ID="txtImageFile1" CssClass="word" runat="server" meta:resourcekey="txtImageFile1Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile2" CssClass="word" runat="server" meta:resourcekey="txtImageFile2Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile3" CssClass="word" runat="server" meta:resourcekey="txtImageFile3Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile4" CssClass="word" runat="server" meta:resourcekey="txtImageFile4Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile5" CssClass="word" runat="server" meta:resourcekey="txtImageFile5Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile6" CssClass="word" runat="server" meta:resourcekey="txtImageFile6Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile7" CssClass="word" runat="server" meta:resourcekey="txtImageFile7Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile8" CssClass="word" runat="server" meta:resourcekey="txtImageFile8Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile9" CssClass="word" runat="server" meta:resourcekey="txtImageFile9Resource1"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtImageFile10" CssClass="word" runat="server" meta:resourcekey="txtImageFile10Resource1"></asp:TextBox></td>
                </tr>

                <tr>
                    <td><asp:Label ID="lblImages" runat="server" Text="Images" meta:resourcekey="lblImagesResource1"></asp:Label></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:FileUpload ID="fileImage1" CssClass="file" runat="server" meta:resourcekey="fileImage1Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="fileImage1" ValidationGroup="v"  ErrorMessage="Invalid file extension for image 1" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator2Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage2" CssClass="file" runat="server" meta:resourcekey="fileImage2Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="fileImage2"  ValidationGroup="v" ErrorMessage="Invalid file extension for image 2" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator3Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage3" CssClass="file" runat="server" meta:resourcekey="fileImage3Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="fileImage3"  ValidationGroup="v" ErrorMessage="Invalid file extension for image 3" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator4Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage4" CssClass="file" runat="server" meta:resourcekey="fileImage4Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="fileImage4"  ValidationGroup="v" ErrorMessage="Invalid file extension for image 4" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator5Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage5" CssClass="file" runat="server" meta:resourcekey="fileImage5Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="fileImage5" ValidationGroup="v"  ErrorMessage="Invalid file extension for image 5" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator6Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage6" CssClass="file" runat="server" meta:resourcekey="fileImage6Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="fileImage6"  ValidationGroup="v" ErrorMessage="Invalid file extension for image 6" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator7Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage7" CssClass="file" runat="server" meta:resourcekey="fileImage7Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="fileImage7"  ValidationGroup="v" ErrorMessage="Invalid file extensionfor image 7" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator8Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage8" CssClass="file" runat="server" meta:resourcekey="fileImage8Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="fileImage8"  ValidationGroup="v" ErrorMessage="Invalid file extensionfor image 8" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator9Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage9" CssClass="file" runat="server" meta:resourcekey="fileImage9Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="fileImage9"  ValidationGroup="v" ErrorMessage="Invalid file extensionfor image 9" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator10Resource1">*</asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:FileUpload ID="fileImage10" CssClass="file" runat="server" meta:resourcekey="fileImage10Resource1" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="fileImage10" ValidationGroup="v" ErrorMessage="Invalid file extensionfor image 10" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator11Resource1">*</asp:RegularExpressionValidator>
                    </td>
                </tr>

            </table>
                <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" ForeColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please Check your inputs." meta:resourcekey="ValidationSummary1Resource1" />
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="v" meta:resourcekey="btnSaveResource1"/>
            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1"/>
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete?');" meta:resourcekey="btnDeleteResource1"/>
            <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="btnApprove_Click" OnClientClick="return confirm('Are you sure you want to Approve?');" meta:resourcekey="btnApproveResource1"/>
            <asp:Button ID="btnCopyToNew" runat="server" Text="Copy to this Category-->" OnClick="btnCopyToNew_Click" ValidationGroup="v" meta:resourcekey="btnCopyToNewResource1"/>
            <asp:DropDownList ID="ddlCopytoPhraseCategory" runat="server" meta:resourcekey="ddlPhraseCategoryResource1"></asp:DropDownList>

        </fieldset>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger  ControlID="btnSave"/>
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
