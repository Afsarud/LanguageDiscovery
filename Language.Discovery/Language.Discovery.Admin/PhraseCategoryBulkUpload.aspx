<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PhraseCategoryBulkUpload.aspx.cs" Inherits="Language.Discovery.Admin.PhraseCategoryBulkUpload" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
            <asp:Label ID="lblTitle" runat="server" Text="Category Bulk Upload" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
     <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
            <fieldset>
                <legend>
                    <asp:Label ID="lblLegend" runat="server" Text="Import Excel" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblSelectFile" runat="server" Text=" Please Select Excel File:" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                                <asp:FileUpload ID="fuExcelUploader" runat="server" meta:resourcekey="fuExcelUploaderResource1" />&nbsp;&nbsp;
                                <asp:Button ID="btnImport" runat="server" Text="Import Data" OnClick="btnImport_Click" meta:resourcekey="btnImportResource1" />
                                <br />
                                <asp:Label ID="lblImport" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933" meta:resourcekey="lblImportResource1"></asp:Label><br />
                            </td>
                        </tr>
                    </table>           
                    <asp:HiddenField ID="hfWord1" runat="server" />
                    <asp:HiddenField ID="hfWord2" runat="server" />
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
                                    <asp:TextBox ID="Word1" runat="server" meta:resourcekey="Word1Resource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Word2" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:TextBox ID="Word2" runat="server" meta:resourcekey="Word2Resource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" />
            </fieldset>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnImport" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
        </Triggers>
     </asp:UpdatePanel>
</asp:Content>
