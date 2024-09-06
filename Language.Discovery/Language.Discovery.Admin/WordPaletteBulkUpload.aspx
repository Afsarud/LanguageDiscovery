<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="WordPaletteBulkUpload.aspx.cs" Inherits="Language.Discovery.Admin.WordPaletteBulkUpload" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Word Palette Bulk Upload" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
            <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
            <fieldset>
                <legend><asp:Label ID="lblLegend" runat="server" Text="Import/Export Excel" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                    <table>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend><asp:Label ID="Label1" runat="server" Text="Select Action"></asp:Label></legend>
                                    <asp:RadioButtonList runat="server" id="rdoAction" RepeatDirection="Vertical" RepeatLayout="Table" OnSelectedIndexChanged="rdoAction_OnSelectedIndexChanged" AutoPostBack="True">
                                        <asp:ListItem Text="Export" Value="1" Selected="True"></asp:ListItem>
									    <asp:ListItem Text="Import" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </fieldset>                                
                            </td>
                         </tr>
                        <tr>
                            <td style="display: none;">
                                <asp:Label ID="lblSchool" runat="server" Text="School" meta:resourcekey="lblSchoolResource1"></asp:Label>
                                <asp:DropDownList ID="ddlSchool" runat="server" meta:resourcekey="ddlSchoolResource1"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSelectFile" runat="server" Text=" Please Select Excel File:" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                                <asp:FileUpload ID="fuExcelUploader" runat="server" meta:resourcekey="fuExcelUploaderResource1" />&nbsp;&nbsp;
                                <asp:Label ID="lblImport" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933" meta:resourcekey="lblImportResource1"></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSearchCategory" runat="server" Text="Category" meta:resourcekey="lblSearchCategoryResource1"></asp:Label>
                                <asp:DropDownList ID="ddlSearchCategory" runat="server" Width="248px"></asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator2" ClientIDMode="Static"  runat="server" ErrorMessage="Category is required." ControlToValidate="ddlSearchCategory" ValueToCompare="-1" Operator="NotEqual" ForeColor="Red">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnImport" runat="server" Text="Import Data" OnClick="btnImport_Click" meta:resourcekey="btnImportResource1" />
                                <asp:Button ID="btnExport" runat="server" Text="Export Data" OnClick="btnExport_OnClick"  meta:resourcekey="btnExportResource1" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButtonList runat="server" id="rdoImportActionList" RepeatDirection="Vertical" RepeatLayout="Table">
                                    <asp:ListItem Text="Replace All Word in Category Selected" Value="0" Selected="True"></asp:ListItem>
									<asp:ListItem Text="Add Word in Category Selected" Value="1"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            
                        </tr>
                    </table>           
                    <asp:HiddenField ID="hfWord1" runat="server" />
                    <asp:HiddenField ID="hfWord2" runat="server" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" Visible="False" />
                    <asp:GridView ID="grdResult" runat="server" 
                        GridLines="Horizontal" Width="80%" Height="300px"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" 
                        ShowFooter="True" 
                        BackColor="White" BorderColor="#336666" AllowCustomPaging="True"
                        BorderWidth="3px" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                    
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            
                            <asp:TemplateField HeaderText="Word1" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtWord1" runat="server" meta:resourcekey="txtWord1Resource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Word2" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtWord2" runat="server" meta:resourcekey="txtWord2Resource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Word3" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtWord3" runat="server" meta:resourcekey="txtWord3Resource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Chinese">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtWord4" runat="server" meta:resourcekey="txtWord3Resource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Keyword" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtKeyword" runat="server" meta:resourcekey="txtKeywordResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="English Sound" meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtEnglishSound" runat="server" meta:resourcekey="txtEnglishSoundResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Japanese Sound" meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtJapaneseSound" runat="server" meta:resourcekey="txtJapaneseSoundResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Chinese Sound">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtChineseSound" runat="server"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Image" meta:resourcekey="TemplateFieldResource7">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtImage" runat="server" meta:resourcekey="txtImageResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category" meta:resourcekey="TemplateFieldResource8">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCategory" runat="server" meta:resourcekey="txtCategoryResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                
            </fieldset>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnImport" />
            <asp:PostBackTrigger ControlID="btnExport" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
        </Triggers>
     </asp:UpdatePanel>
</asp:Content>
