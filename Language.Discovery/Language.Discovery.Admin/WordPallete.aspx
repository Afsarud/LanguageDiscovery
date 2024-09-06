<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="WordPallete.aspx.cs" Inherits="Language.Discovery.Admin.WordPallete" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Word Palette Maintenance" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    
        <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
           <fieldset class="fieldset">
                <asp:HiddenField ID="hdnWordHeaderID" runat="server" />
                <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
                <legend><asp:Label ID="lblSearchLegend" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                 <table>
                    <tr>
                        <td><asp:Label ID="lblSearchSchool" runat="server" meta:resourcekey="lblSearchSchoolResource1">School</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>
                        <td><asp:Label ID="lblSearchCategory" runat="server" meta:resourcekey="lblSearchCategoryResource1">Category</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchlCategory" runat="server" meta:resourcekey="ddlSearchlCategoryResource1"></asp:DropDownList></td>
                        <td><asp:Label ID="lblWordName" runat="server" meta:resourcekey="lblWordNameResource1">Word</asp:Label></td>
                        <td><asp:TextBox ID="txtWordName" runat="server" meta:resourcekey="txtWordNameResource1"></asp:TextBox></td>
                        <td><asp:Label ID="lblSearchKeyword" runat="server" meta:resourcekey="lblSearchKeywordResource1">Keyword</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchKeyword" runat="server" meta:resourcekey="txtSearchKeywordResource1"></asp:TextBox></td>
                        <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                        OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" /></td>

                    </tr>
                     <tr>
                         <td><asp:Label ID="lblSearchLanguage" runat="server" meta:resourcekey="lblSearchLanguageResource1" Visible="false">Language</asp:Label></td>
                         <td><asp:DropDownList ID="ddlSearchLanguage" runat="server" Visible="false"></asp:DropDownList></td>

                     </tr>
                </table>
        
                <asp:GridView ID="grdResult" runat="server" 
                        GridLines="Horizontal" Width="80%" Height="300px"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                        onpageindexchanging="grdResult_PageIndexChanging"
                        onrowdatabound="grdResult_RowDataBound" 
                        onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True" 
                        BackColor="White" BorderColor="#336666" AllowCustomPaging="True"
                        BorderWidth="3px" meta:resourcekey="grdResultResource1">
                        <PagerSettings Mode="NumericFirstLast" />
                    
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField  ShowHeader="False" meta:resourcekey="TemplateFieldResource1" >
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnSearchWordHeaderID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"WordMapID").ToString() %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Word" HeaderText="Word" meta:resourcekey="BoundFieldResource1" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Keyword" HeaderText="Keyword" meta:resourcekey="BoundFieldResource2" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
            </fieldset>
        </ContentTemplate>  
    </asp:UpdatePanel>
 <br />
    <asp:UpdatePanel ID="upDetail" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>

            <fieldset>
                <legend>
                    <asp:Label ID="lblDataEntryLegend" runat="server" Text="Data Entry" meta:resourcekey="lblDataEntryLegendResource1"></asp:Label></legend>
                <table>
                    <tr>
                        <td><asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategoryResource1">Category</asp:Label></td>
                        <td><asp:DropDownList ID="ddlCategory" runat="server" meta:resourcekey="ddlCategoryResource1"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblEnglish" runat="server" meta:resourcekey="lblEnglishResource1">English</asp:Label></td>
                        <td><asp:TextBox ID="txtEnglish" runat="server" Width="402px" meta:resourcekey="txtEnglishResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="English is required" ControlToValidate="txtEnglish" ValidationGroup="v" ForeColor="Red" Display="Dynamic" meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>
                        </td>
                        <td><asp:Label ID="lblEnglishSound" runat="server" meta:resourcekey="lblEnglishSoundResource1">English Sound</asp:Label></td>
                        <td><asp:TextBox ID="txtEnglishSoundFile" runat="server" Width="402px" meta:resourcekey="txtEnglishSoundFileResource1"></asp:TextBox>
                        <td><asp:FileUpload ID="uploadEnglishSound" runat="server" meta:resourcekey="uploadEnglishSoundResource1" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="uploadEnglishSound" ValidationGroup="v"  ErrorMessage="Invalid file extension for Englis Sound. Valid file is .mp3" ValidationExpression="(.*\.([Mm][Pp][3])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator3Resource1">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    </table>
                <fieldset style="border:1px solid black;">
                    <legend><asp:Label ID="lblTranslationLegend" runat="server" Text="Translation" meta:resourcekey="lblTranslationLegendResource1"></asp:Label></legend>
                    <table>
                    <tr>
                        <td><asp:Label ID="lblLanguage" runat="server" Text="Language" meta:resourcekey="lblLanguageResource1"></asp:Label></td>
                        <td colspan="13"><asp:DropDownList ID="ddlLanguage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged"></asp:DropDownList></td>
                    </tr>
                    <tr><td colspan="2" style="height:20px;"></td></tr>
                    <tr>
                        <td><asp:Label ID="lblHiragana" runat="server" meta:resourcekey="lblHiraganaResource1">Japanese</asp:Label></td>
                        <td><asp:TextBox ID="txtHiragana" runat="server" Width="402px" meta:resourcekey="txtHiraganaResource1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Translation is required" ControlToValidate="txtHiragana" ValidationGroup="v" ForeColor="Red" Display="Dynamic" meta:resourcekey="RequiredFieldValidator3Resource1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblKanji" runat="server" meta:resourcekey="lblKanjiResource1">Kanji</asp:Label></td>
                        <td><asp:TextBox ID="txtKanji" runat="server" Width="402px" meta:resourcekey="txtKanjiResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblRomanji" runat="server" meta:resourcekey="lblRomanjiResource1">Romanji</asp:Label></td>
                        <td><asp:TextBox ID="txtRomanji" runat="server" Width="402px" meta:resourcekey="txtRomanjiResource1"></asp:TextBox>
                        </td>
                        <td><asp:Label ID="lblJapaneseSound" runat="server" meta:resourcekey="lblJapaneseSoundResource1">Japanese Sound</asp:Label></td>
                        <td><asp:TextBox ID="txtJapaneseSoundFile" runat="server" Width="402px" meta:resourcekey="txtJapaneseSoundFileResource1"></asp:TextBox>
                        <td><asp:FileUpload ID="uploadJapaneseSound" runat="server" meta:resourcekey="uploadJapaneseSoundResource1" />
                                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="uploadJapaneseSound" ValidationGroup="v"  ErrorMessage="Invalid file extension for Japanese Sound. Valid file is .mp3" ValidationExpression="(.*\.([Mm][Pp][3])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator1Resource1">*</asp:RegularExpressionValidator>
                       
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblKeyword" runat="server" meta:resourcekey="lblKeywordResource1">Keyword</asp:Label></td>
                        <td><asp:TextBox ID="txtKeyword" runat="server" Width="402px" meta:resourcekey="txtKeywordResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblWordType" runat="server" meta:resourcekey="lblWordTypeResource1">Word Type</asp:Label></td>
                        <td><asp:TextBox ID="txtWordType" runat="server" Width="402px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblImage" runat="server" meta:resourcekey="lblImageResource1">Image</asp:Label></td>
                        <td><asp:TextBox ID="txtImageFile" runat="server" Width="402px" meta:resourcekey="txtImageFileResource1"></asp:TextBox>
                        <td><asp:FileUpload ID="uploadImage" runat="server" meta:resourcekey="uploadImageResource1" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="uploadImage" ValidationGroup="v"  ErrorMessage="Invalid file extension for image" ValidationExpression="(.*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$)" ForeColor="Red" meta:resourcekey="RegularExpressionValidator2Resource1">*</asp:RegularExpressionValidator>
                        </td>

                    </tr>
                    <tr>
                        <td><asp:Label ID="lblSequence" runat="server" meta:resourcekey="lblSequenceResource1">Sequence</asp:Label></td>
                        <td><asp:TextBox ID="txtSequence" TextMode="Number" runat="server" Width="50px"></asp:TextBox></td>
                    </tr>

                </table>
                </fieldset>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server"  ValidationGroup="v" HeaderText="Please review your inputs." ForeColor="Red" BorderWidth="1px" BorderStyle="Solid" meta:resourcekey="ValidationSummary1Resource1" />
                <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />

                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="v" meta:resourcekey="btnSaveResource1" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" meta:resourcekey="btnDeleteResource1"
                     />
                </fieldset>
            </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
        </asp:UpdatePanel>
</asp:Content>
