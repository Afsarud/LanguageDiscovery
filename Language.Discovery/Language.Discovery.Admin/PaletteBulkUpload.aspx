<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PaletteBulkUpload.aspx.cs" Inherits="Language.Discovery.Admin.PaletteBulkUpload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <style>
        .item {
            padding:0;
            border-collapse:collapse;
            background-color:ButtonFace;
        }
        .alternate{
            padding:0;
            border-collapse:collapse;
            background-color:teal;
            color:white;
        }
    </style>
    <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
            <fieldset>
                <legend>Import Excel</legend>
                    <table>
                        <tr>
                            <td>
                                <b>Please Select Excel File: </b>
                                <asp:FileUpload ID="fuExcelUploader" runat="server" />&nbsp;&nbsp;
                                <asp:Button ID="btnImport" runat="server" Text="Import Data" OnClick="btnImport_Click" />
                                <br />
                                <asp:Label ID="lblImport" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933"></asp:Label><br />
                            </td>
                        </tr>
                    </table>           
                    <asp:HiddenField ID="hfWord1" runat="server" />
                    <asp:HiddenField ID="hfWord2" runat="server" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" ItemType="List<Language.Discovery.Entity.PaletteContract>" >
                    <HeaderTemplate>
                        <table id="tblentry" border="1">
                            <thead>
                               <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
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
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr class="item">
                    
                            <td><asp:Label ID="lblMainLanguage" runat="server" Text="English"></asp:Label></td>
                            <td><asp:Label ID="lblSen1" runat="server" Text="Sen-1"></asp:Label></td>
                            <td><asp:Label ID="lblSubLanguage" runat="server" Text="English"></asp:Label></td>
                            <td><asp:TextBox ID="txtEng1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng10" CssClass="word" runat="server"></asp:TextBox></td>
                    
                        </tr>
                        <tr class="item">
                            <td></td>
                            <td><asp:Label ID="lblEnglishSound" runat="server" Text="Sound"></asp:Label></td>
                            <td></td>
                            <td><asp:TextBox ID="txtEngSound1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound10" CssClass="word" runat="server"></asp:TextBox></td>                            
                            <td><asp:TextBox ID="txtEngSentenceSound" CssClass="word" runat="server"></asp:TextBox></td>                            
                        </tr>
                        <tr class="item">
                            <td></td>
                            <td><asp:Label ID="Label1" runat="server" Text="Keyword"></asp:Label></td>
                            <td></td>
                            <td colspan="10"><asp:TextBox ID="txtEnglishKeyword" runat="server" Width="524px"></asp:TextBox></td>
                        </tr>
                        <tr class="item">
                            <td></td>
                            <td><asp:Label ID="Label3" runat="server" Text="Order"></asp:Label></td>
                            <td></td>
                            <td><asp:DropDownList ID="ddlOrderEng1" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng2" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng3" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng4" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng5" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng6" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng7" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng8" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng9" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng10" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr class="item"><!--japanese -->
                            <td><asp:Label ID="Label4" runat="server" Text="Japanese"></asp:Label></td>
                            <td><asp:Label ID="Label5" runat="server" Text="Sen-1"></asp:Label></td>
                            <td><asp:Label ID="Label6" runat="server" Text="Japanese"></asp:Label></td>
                            <td><asp:TextBox ID="txtJap1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap10" CssClass="word" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr class="item"><!--Kanji -->
                    
                            <td></td>
                            <td><asp:Label ID="Label8" runat="server" Text="Sen-2"></asp:Label></td>
                            <td><asp:Label ID="Label9" runat="server" Text="Kanji"></asp:Label></td>
                            <td><asp:TextBox ID="txtKanji1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji10" CssClass="word" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr class="item"><!--Romanji -->
                    
                            <td></td>
                            <td><asp:Label ID="Label11" runat="server" Text="Sen-3"></asp:Label></td>
                            <td><asp:Label ID="Label12" runat="server" Text="Romanji"></asp:Label></td>
                            <td><asp:TextBox ID="txtRomanji1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji10" CssClass="word" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr class="item">
                            <td></td>
                            <td><asp:Label ID="Label10" runat="server" Text="Sound"></asp:Label></td>
                            <td></td>
                            <td><asp:TextBox ID="txtJapSound1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound10" CssClass="word" runat="server"></asp:TextBox></td>                            
                            <td><asp:TextBox ID="txtJapSentenceSound" CssClass="word" runat="server"></asp:TextBox></td>                            
                        </tr>
                        <tr class="item">
                            <td></td>
                            <td><asp:Label ID="Label13" runat="server" Text="Keyword"></asp:Label></td>
                            <td></td>
                            <td colspan="10"><asp:TextBox ID="txtJapaneseKeyword" runat="server" Width="524px"></asp:TextBox></td>
                        </tr>
                        <tr class="item">
                            <td></td>
                            <td><asp:Label ID="Label7" runat="server" Text="Order"></asp:Label></td>
                            <td></td>
                            <td><asp:DropDownList ID="ddlOrderJap1" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap2" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap3" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap4" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap5" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap6" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap7" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap8" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap9" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap10" runat="server"></asp:DropDownList></td>
                        </t>
                        <tr class="item">
                            <td><asp:Label ID="lblImages" runat="server" Text="Images"></asp:Label></td>
                            <td></td>
                            <td></td>
                            <td><asp:TextBox ID="txtImage1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage10" CssClass="word" runat="server"></asp:TextBox></td>                            
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr class="alternate">
                    
                            <td><asp:Label ID="lblMainLanguage" runat="server" Text="English"></asp:Label></td>
                            <td><asp:Label ID="lblSen1" runat="server" Text="Sen-1"></asp:Label></td>
                            <td><asp:Label ID="lblSubLanguage" runat="server" Text="English"></asp:Label></td>
                            <td><asp:TextBox ID="txtEng1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEng10" CssClass="word" runat="server"></asp:TextBox></td>
                    
                        </tr>
                        <tr class="alternate">
                            <td></td>
                            <td><asp:Label ID="lblEnglishSound" runat="server" Text="Sound"></asp:Label></td>
                            <td></td>
                            <td><asp:TextBox ID="txtEngSound1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtEngSound10" CssClass="word" runat="server"></asp:TextBox></td>                            
                            <td><asp:TextBox ID="txtEngSentenceSound" CssClass="word" runat="server"></asp:TextBox></td>                            
                        </tr>
                        <tr class="alternate">
                            <td></td>
                            <td><asp:Label ID="Label1" runat="server" Text="Keyword"></asp:Label></td>
                            <td></td>
                            <td colspan="10"><asp:TextBox ID="txtEnglishKeyword" runat="server" Width="524px"></asp:TextBox></td>
                        </tr>
                        <tr class="alternate">
                            <td></td>
                            <td><asp:Label ID="Label3" runat="server" Text="Order"></asp:Label></td>
                            <td></td>
                            <td><asp:DropDownList ID="ddlOrderEng1" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng2" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng3" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng4" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng5" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng6" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng7" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng8" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng9" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderEng10" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr class="alternate"><!--japanese -->
                            <td><asp:Label ID="Label4" runat="server" Text="Japanese"></asp:Label></td>
                            <td><asp:Label ID="Label5" runat="server" Text="Sen-1"></asp:Label></td>
                            <td><asp:Label ID="Label6" runat="server" Text="Japanese"></asp:Label></td>
                            <td><asp:TextBox ID="txtJap1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJap10" CssClass="word" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr class="alternate"><!--Kanji -->
                    
                            <td></td>
                            <td><asp:Label ID="Label8" runat="server" Text="Sen-2"></asp:Label></td>
                            <td><asp:Label ID="Label9" runat="server" Text="Kanji"></asp:Label></td>
                            <td><asp:TextBox ID="txtKanji1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtKanji10" CssClass="word" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr class="alternate"><!--Romanji -->
                    
                            <td></td>
                            <td><asp:Label ID="Label11" runat="server" Text="Sen-3"></asp:Label></td>
                            <td><asp:Label ID="Label12" runat="server" Text="Romanji"></asp:Label></td>
                            <td><asp:TextBox ID="txtRomanji1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtRomanji10" CssClass="word" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr class="alternate">
                            <td></td>
                            <td><asp:Label ID="Label10" runat="server" Text="Sound"></asp:Label></td>
                            <td></td>
                            <td><asp:TextBox ID="txtJapSound1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtJapSound10" CssClass="word" runat="server"></asp:TextBox></td>                            
                            <td><asp:TextBox ID="txtJapSentenceSound" CssClass="word" runat="server"></asp:TextBox></td>                            
                        </tr>
                        <tr class="alternate">
                            <td></td>
                            <td><asp:Label ID="Label13" runat="server" Text="Keyword"></asp:Label></td>
                            <td></td>
                            <td colspan="10"><asp:TextBox ID="txtJapaneseKeyword" runat="server" Width="524px"></asp:TextBox></td>
                        </tr>
                        <tr class="alternate">
                            <td></td>
                            <td><asp:Label ID="Label7" runat="server" Text="Order"></asp:Label></td>
                            <td></td>
                            <td><asp:DropDownList ID="ddlOrderJap1" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap2" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap3" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap4" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap5" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap6" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap7" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap8" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap9" runat="server"></asp:DropDownList></td>
                            <td><asp:DropDownList ID="ddlOrderJap10" runat="server"></asp:DropDownList></td>
                        </t>
                        <tr class="alternate">
                            <td><asp:Label ID="lblImages" runat="server" Text="Images"></asp:Label></td>
                            <td></td>
                            <td></td>
                            <td><asp:TextBox ID="txtImage1" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage2" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage3" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage4" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage5" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage6" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage7" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage8" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage9" CssClass="word" runat="server"></asp:TextBox></td>
                            <td><asp:TextBox ID="txtImage10" CssClass="word" runat="server"></asp:TextBox></td>                            
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                       
            </fieldset>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnImport" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
        </Triggers>
     </asp:UpdatePanel>
</asp:Content>
