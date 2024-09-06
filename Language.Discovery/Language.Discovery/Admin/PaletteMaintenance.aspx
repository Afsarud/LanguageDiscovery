<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PaletteMaintenance.aspx.cs" Inherits="Language.Discovery.Admin.PaletteMaintenance"  EnableEventValidation="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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
                    <asp:HiddenField ID="hdnPaletteID" runat="server" />
                    <legend>Search</legend>
                        <table>
                    
                        <tr>
                            <td><asp:Label ID="lblSearchLevel" runat="server">Level</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchLevel" runat="server"></asp:DropDownList></td>
                            <td><asp:Label ID="lblCategory" runat="server">Category</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchCategory" runat="server"></asp:DropDownList></td>
                        </tr>
                            <tr>
                            <td><asp:Label ID="lblSearchSchool" runat="server">School</asp:Label></td>
                            <td><asp:DropDownList ID="ddlSearchSchool" runat="server"></asp:DropDownList></td>
                            <td><asp:Label ID="lblWord" runat="server">Word</asp:Label></td>
                            <td><asp:TextBox ID="txtSearchWord" runat="server"></asp:TextBox></td>
                            <td><asp:Label ID="lblSearchKeyword" runat="server">Word</asp:Label></td>
                            <td><asp:TextBox ID="txtSearchKeyword" runat="server"></asp:TextBox></td>
                            <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                            OnClick="btnSearch_Click"/></td>
                            </tr>
                    </table>
        
                    <asp:GridView ID="grdResult" runat="server" PageSize="10" 
                            GridLines="Horizontal" Width="80%" Height="300px"
                            EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                            onpageindexchanging="grdResult_PageIndexChanging"
                            onrowdatabound="grdResult_RowDataBound" 
                            onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True" 
                            BackColor="White" BorderColor="#336666" 
                            BorderWidth="3px">
                            <PagerSettings Mode="NumericFirstLast" Position="Bottom" Visible="true" />
                            <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                            <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField  ShowHeader="false">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnSearchPaletteID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PaletteID").ToString() %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sentence" >
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence").ToString() %>'></asp:Label> <br />
                                        <asp:Label ID="Label14" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Sentence2").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                </fieldset>
            </ContentTemplate>  
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="upDetail" runat="server"  UpdateMode="Conditional">
            <ContentTemplate>
        <fieldset>
            <legend>Data Entry</legend>
            <asp:Label ID="lblPhraseCategory" runat="server" Text="Category"></asp:Label>
            <asp:DropDownList ID="ddlPhraseCategory" runat="server"></asp:DropDownList>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="CompareValidator"></asp:CompareValidator>
            <br /><br />
            <asp:HiddenField ID="hdnEnglishSentenceID" Value="-1" runat="server" />
            <asp:HiddenField ID="hdnKanjiSentenceID" Value="-3" runat="server" />
            <asp:HiddenField ID="hdnHiraganaSentenceID" Value="-2" runat="server" />
            <asp:HiddenField ID="hdnRomanjiSenteceID" Value="-4" runat="server" />
            <table id="tblentry" border="1" style="padding:0;border-collapse:collapse;background-color:ButtonFace;">
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
                    </tr>
                </thead>
                <tr>
                    
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
                <tr>
                    <td></td>
                    <td><asp:Label ID="lblEnglishSound" runat="server" Text="Sound"></asp:Label></td>
                    <td></td>
                    <td><asp:FileUpload ID="fileEng1" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng2" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng3" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng4" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng5" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng6" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng7" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng8" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng9" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileEng10" CssClass="file" runat="server" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="Label1" runat="server" Text="Keyword"></asp:Label></td>
                    <td></td>
                    <td colspan="10"><asp:TextBox ID="txtEnglishKeyword" runat="server" Width="524px"></asp:TextBox></td>
                </tr>
                <tr>
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
                <tr><!--japanese -->
                    <td><asp:Label ID="Label4" runat="server" Text="Japanese"></asp:Label></td>
                    <td><asp:Label ID="Label5" runat="server" Text="Sen-1"></asp:Label></td>
                    <td><asp:Label ID="Label6" runat="server" Text="Hiragana"></asp:Label></td>
                    <td><asp:TextBox ID="txtHir1" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir2" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir3" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir4" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir5" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir6" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir7" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir8" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir9" CssClass="word" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtHir10" CssClass="word" runat="server"></asp:TextBox></td>
                </tr>
                <tr><!--Kanji -->
                    
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
                <tr><!--Romanji -->
                    
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
                <tr>
                    <td></td>
                    <td><asp:Label ID="Label10" runat="server" Text="Sound"></asp:Label></td>
                    <td></td>
                    <td><asp:FileUpload ID="fileJap1" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap2" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap3" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap4" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap5" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap6" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap7" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap8" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap9" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileJap10" CssClass="file" runat="server" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:Label ID="Label13" runat="server" Text="Keyword"></asp:Label></td>
                    <td></td>
                    <td colspan="10"><asp:TextBox ID="txtJapaneseKeyword" runat="server" Width="524px"></asp:TextBox></td>
                </tr>
                <tr>
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
                </tr>
                <tr>
                    <td><asp:Label ID="lblImages" runat="server" Text="Images"></asp:Label></td>
                    <td></td>
                    <td></td>
                    <td><asp:FileUpload ID="fileImage1" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage2" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage3" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage4" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage5" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage6" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage7" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage8" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage9" CssClass="file" runat="server" /></td>
                    <td><asp:FileUpload ID="fileImage10" CssClass="file" runat="server" /></td>
                </tr>

            </table>
                <asp:Label ID="lblMessage" runat="server" Visible="false" EnableViewState="false" Text="Action Error."></asp:Label><br />

            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"/>
            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click"/>
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click"/>
            <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="btnApprove_Click"/>
        </fieldset>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger  ControlID="btnSave"/>
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
