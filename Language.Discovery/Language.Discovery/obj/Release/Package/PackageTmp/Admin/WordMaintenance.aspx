<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="WordMaintenance.aspx.cs" Inherits="Language.Discovery.Admin.WordMaintenance" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">

        <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
           <fieldset class="fieldset">
                <asp:HiddenField ID="hdnWordHeaderID" runat="server" />
                <legend>Search</legend>
                 <table>
                    <tr>
                        <td><asp:Label ID="lblSearchCategory" runat="server">Category</asp:Label></td>
                        <td><asp:DropDownList ID="ddlSearchlCategory" runat="server"></asp:DropDownList></td>
                        <td><asp:Label ID="lblWordName" runat="server">Word</asp:Label></td>
                        <td><asp:TextBox ID="txtWordName" runat="server"></asp:TextBox></td>
                        <td><asp:Label ID="lblSearchKeyword" runat="server">Word</asp:Label></td>
                        <td><asp:TextBox ID="txtSearchKeyword" runat="server"></asp:TextBox></td>
                    </tr>
                     <tr>
                         <td><asp:Label ID="lblLanguage" runat="server">Language</asp:Label></td>
                         <td><asp:DropDownList ID="ddlLanguage" runat="server"></asp:DropDownList></td>
                        <td><asp:Button ID="btnSearch" runat="server" Text="Search" 
                        OnClick="btnSearch_Click" /></td>

                     </tr>
                </table>
        
                <asp:GridView ID="grdResult" runat="server"  
                        GridLines="Horizontal" Width="80%" Height="300px"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                        onpageindexchanging="grdResult_PageIndexChanging"
                        onrowdatabound="grdResult_RowDataBound"
                        onselectedindexchanged="grdResult_SelectedIndexChanged" ShowFooter="True" 
                        BackColor="White" BorderColor="#336666"
                        BorderWidth="3px">
                        <PagerSettings Mode="NumericFirstLast" />
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField  ShowHeader="false" >
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnSearchWordHeaderID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"WordMapID").ToString() %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Word" HeaderText="Word" 
                                HeaderStyle-HorizontalAlign="Left" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Keyword" HeaderText="Keyword" 
                                HeaderStyle-HorizontalAlign="Left" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
            </fieldset>
        </ContentTemplate>  
    </asp:UpdatePanel>
    <br />
    <asp:UpdatePanel ID="upWords" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
             <asp:GridView ID="grdWords" runat="server"  
                        GridLines="Horizontal" Width="80%"
                        AutoGenerateColumns="False"
                        onrowdatabound="grdWords_RowDataBound"
                        OnRowCommand="grdWords_RowCommand"
                        ShowFooter="True" 
                        BackColor="White" BorderColor="#336666"
                        BorderWidth="3px">
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField  ShowHeader="false" >
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnWordID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"WordID").ToString() %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlLanguage" runat="server"></asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:TextBox ID="txtLanguage1" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:TextBox ID="txtLanguage2" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:TextBox ID="txtLanguage3" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:FileUpload ID="uploadSound" runat="server" Width="65px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowDeleteButton="true" DeleteText="Remove" />
                            <asp:TemplateField>
                                <FooterTemplate>
                                    <asp:Button ID="btnAddRow" runat="server" OnClick="btnAddRow_Click" Text="Add Translation" />
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView> 
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upDetail" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>

            <fieldset>
                <legend>Data Entry</legend>
                <table>
                    <tr>
                        <td><asp:Label ID="lblCategory" runat="server">Category</asp:Label></td>
                        <td><asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Category is required" ControlToValidate="ddlCategory" ValidationGroup="v">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblEnglish" runat="server">English</asp:Label></td>
                        <td><asp:TextBox ID="txtEnglish" runat="server" Width="402px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="English is required" ControlToValidate="txtEnglish" ValidationGroup="v">*</asp:RequiredFieldValidator>
                        </td>
                        <td><asp:Label ID="lblEnglishSound" runat="server">English Sound</asp:Label></td>
                        <td><asp:FileUpload ID="uploadEnglishSound" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblHiragana" runat="server">Hiragana</asp:Label></td>
                        <td><asp:TextBox ID="txtHiragana" runat="server" Width="402px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Hiragana is required" ControlToValidate="txtHiragana" ValidationGroup="v">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblKanji" runat="server">Kanji</asp:Label></td>
                        <td><asp:TextBox ID="txtKanji" runat="server" Width="402px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Kanji is required" ControlToValidate="txtKanji" ValidationGroup="v">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblRomanji" runat="server">Romanji</asp:Label></td>
                        <td><asp:TextBox ID="txtRomanji" runat="server" Width="402px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Romanji is required" ControlToValidate="txtRomanji" ValidationGroup="v">*</asp:RequiredFieldValidator>
                        </td>
                        <td><asp:Label ID="lblJapaneseSound" runat="server">Japanese Sound</asp:Label></td>
                        <td><asp:FileUpload ID="uploadJapaneseSound" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblKeyword" runat="server">Keyword</asp:Label></td>
                        <td><asp:TextBox ID="txtKeyword" runat="server" Width="402px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblImage" runat="server">Image</asp:Label></td>
                        <td><asp:FileUpload ID="uploadImage" runat="server" /></td>

                    </tr>
                </table>

                <asp:Label ID="lblMessage" runat="server" Visible="false" EnableViewState="false" Text="Action Error."></asp:Label><br />

                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click"
                     />
                </fieldset>
            </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
        </asp:UpdatePanel>
</asp:Content>
