<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PaletteMaintenanceExport.aspx.cs" Inherits="Language.Discovery.Admin.PaletteMaintenanceExport"  EnableEventValidation="false" MaintainScrollPositionOnPostback="true" culture="auto" meta:resourcekey="PageResource1" uiculture="auto"%>
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
   <%-- <script src="scripts/jquery-2.0.3.min.js"></script>
     <script src="scripts/jquery.signalR-2.3.0.min.js"></script>
     <script src="signalr/hubs"></script>
    
    <script>
        $(function () {
            // Declare a proxy to reference the hub. 
            var chat = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
        
            chat.sendMessage = function (content) {
                alert(content);
                $('#lblWarning').text(content);
            };

            // Start the connection.
            $.connection.hub.start().done(function () {
                chat.activate = function (message) {
                    alert(message);

                    $('#lblWarning').text("Import Finish");
                };
            });
        });
    </script>--%>
  <%--  <script>
        $(function () {
            $('#rdoAction').change(function () {
                if($('#rdoAction').val() == "1")
                {
                    $('.category').show();
                    ValidatorEnable(document.getElementById('CompareValidator1'), true);
                }
                else
                {
                    $('.category').hide();
                    ValidatorEnable(document.getElementById('CompareValidator1'), false);
                }
            });
        });
    </script>--%>

    <div>
        <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
            <ContentTemplate>
                <fieldset class="fieldset">
                    <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
                    <asp:HiddenField ID="hdnPaletteID" runat="server" />
                    <legend><asp:Label ID="lblLegend" runat="server" Text="Search" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                        <table>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><asp:Label ID="Label1" runat="server" Text="Select Action" meta:resourcekey="Label1Resource1"></asp:Label></legend>
                                        <asp:RadioButtonList runat="server" id="rdoAction" OnSelectedIndexChanged="rdoAction_OnSelectedIndexChanged" AutoPostBack="True" ClientIDMode="Static" meta:resourcekey="rdoActionResource1">
                                            <asp:ListItem Text="Export" Value="1" Selected="True" meta:resourcekey="ListItemResource1"></asp:ListItem>
									        <asp:ListItem Text="Import" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                            <td colspan="2">
                                <asp:Label ID="lblSelectFile" runat="server" Text="Select Excel File(.xlsx):" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                                <asp:FileUpload ID="fuExcelUploader" runat="server" meta:resourcekey="fuExcelUploaderResource1" />&nbsp;&nbsp;
                                <br />
                                <asp:Label ID="lblImport" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933" meta:resourcekey="lblImportResource1" EnableViewState="False"></asp:Label><br />
                                <asp:Label ID="lblWarning" runat="server" Visible="False" Font-Bold="True" ForeColor="Red" EnableViewState="False" meta:resourcekey="lblWarningResource1">PLEASE WAIT FOR 5-10 MINUTES. <BR> THE IMPORT IS RUNNING IN THE BACKGROUND <BR> PLEASE DO NOT ACCESS YET THE PALETTE SETTINGS PAGE AND THE MAIL CREATION PAGE.</asp:Label><br />
                            </td>
                            </tr>
                           <tr class="category">
                                <td><asp:Label ID="lblCategory" runat="server" meta:resourcekey="lblCategoryResource1">Category</asp:Label></td>
                                <td><asp:DropDownList ID="ddlSearchCategory" runat="server" meta:resourcekey="ddlSearchCategoryResource1"></asp:DropDownList>
                                    <asp:CompareValidator ID="CompareValidator1" ClientIDMode="Static"  runat="server" ErrorMessage="Category is required." ControlToValidate="ddlSearchCategory" ValueToCompare="0" Operator="NotEqual"  ForeColor="Red" meta:resourcekey="CompareValidator1Resource1">Category is Required</asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <asp:RadioButtonList runat="server" id="rdoImportActionList" Visible="False" meta:resourcekey="rdoImportActionListResource1">
                                    <asp:ListItem Text="Replace All Palette in Category Selected" Value="0" Selected="True" meta:resourcekey="ListItemResource3"></asp:ListItem>
									<asp:ListItem Text="Add Palette in Category Selected" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                </asp:RadioButtonList>
                            </tr>
                            <tr>
                                <td><asp:Button ID="btnExport" runat="server" Text="Export" OnClick="btnExport_OnClick" meta:resourcekey="btnExportResource1"/></td>
                                <td><asp:Button ID="btnImport" runat="server" Text="Import" OnClick="btnImport_OnClick" meta:resourcekey="btnImportResource1"/></td>
                            </tr>
                    </table>
                </fieldset>
            </ContentTemplate>  
            <Triggers>
                <asp:PostBackTrigger ControlID="btnExport"/>
                <asp:PostBackTrigger ControlID="btnImport"/>
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
