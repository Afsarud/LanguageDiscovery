<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="FileUploader.aspx.cs" Inherits="Language.Discovery.Admin.FileUploader" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script>
        $(function () {

            $('#listDirectory').change(function () {
                $('#lblDirectory').text($(this).children("option:selected").val() + $('#txtFolder').val());
                $('#hdnDirectory').val($('#lblDirectory').text());
            })
            $('#txtFolder').keyup(function () {
                $('#lblDirectory').text($('#listDirectory').children("option:selected").val() + $(this).val());
                $('#hdnDirectory').val($('#lblDirectory').text());
            })
        });
    </script>
    <table>
        <tr>
            <td>
                <h2>Select Directory:</h2>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                
                <asp:ListBox ID="listDirectory" runat="server" ClientIDMode="Static" style="width:450px;height:250px;">
                </asp:ListBox>
                
            </td>
        </tr>
        <tr><td></td></tr>
        <tr>
            <td>
                <br />
                Input additional folder here: <asp:TextBox ID="txtFolder" runat="server" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr><td></td></tr>
        <tr>
            <td>
                <asp:Label ID="lblDirectoryLabel" runat="server" Text="Your files will be uploaded here:" ClientIDMode="Static" style="font-size:large; font-weight:bold;"></asp:Label>
                <asp:Label ID="lblDirectory" runat="server" Text="\Sound\" ClientIDMode="Static" style="font-size:large; font-weight:bold;color:red;"></asp:Label>
                <br />
		<span style="font-style:italic;">NOTE: If the input folder does not exist in the server, it will be created automatically.</span>
                <br />
                <br />
                <asp:HiddenField ID="hdnDirectory" runat="server" ClientIDMode="Static" />
            </td>
        </tr>
        <tr><td></td></tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblSelectFile" runat="server" Text="Select sound File:" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                <asp:FileUpload ID="fileUPloader" runat="server" AllowMultiple="true" />&nbsp;&nbsp;
                <br />
                <asp:Label ID="lblImport" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933" meta:resourcekey="lblImportResource1" EnableViewState="False"></asp:Label><br />
                <asp:Label ID="lblWarning" runat="server" Visible="False" Font-Bold="True" ForeColor="Red" EnableViewState="False" meta:resourcekey="lblWarningResource1">PLEASE WAIT FOR 5-10 MINUTES. <BR> THE IMPORT IS RUNNING IN THE BACKGROUND <BR> PLEASE DO NOT ACCESS YET THE PALETTE SETTINGS PAGE AND THE MAIL CREATION PAGE.</asp:Label><br />
            </td>
        </tr>
        <tr>
            <td><asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click"/></td>
        </tr>

    </table>
</asp:Content>
