<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="CreateStudent.aspx.cs" Inherits="Language.Discovery.Admin.CreateStudent" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="User Bulk Upload" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script>
        function InitializeDate(el) {
            $("#" + el).datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                numberOfMonths: 1
            });
        }

        function ShowHowTo() {
            var url;
            var presentation = "https://docs.google.com/presentation/d/e/2PACX-1vRXPzPY8KQ-5pEk9asLQOn0Zh7l1QtlVnsBfqU6ecwYsJ65KSV42FIUyxQARmY2aA2-1AwjRJrQbJzO/embed?start=false&loop=false&delayms=3000";
            if (presentation != "none") {
                url = presentation;
            }
            var newwindow = window.open(url, "_blank", "height=751,width=1038,scrollbars=yes,resizable=yes");
            if (window.focus) { newwindow.focus() }
            return false;

        }

    </script>
  <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional" style="width:82%">
        <ContentTemplate>
            <fieldset>
                <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
                 <legend><asp:Label ID="lblLegend" runat="server" Text=""></asp:Label></legend>
                   <asp:LinkButton ID="linkHowTo" runat="server" ClientIDMode="Static" style="float:right;" OnClientClick="ShowHowTo();">How to create User IDs</asp:LinkButton>
                    <table>
                        <tr>
                            <td  colspan="2">
                                <asp:Label ID="lblSelectFile" runat="server" Text="Excel Import:" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                                <asp:Button ID="btnDownloadTemplate" runat="server" Text="Download Template" OnClick="btnDownloadTemplate_Click" meta:resourcekey="btnDownloadTemplateResource1" />
                                <asp:FileUpload ID="fuExcelUploader" runat="server" meta:resourcekey="fuExcelUploaderResource1" />&nbsp;&nbsp;
                                <asp:Button ID="btnImport" runat="server" Text="Import Data" OnClick="btnImport_Click" meta:resourcekey="btnImportResource1" ValidationGroup="v" />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSeparator" runat="server" Text="Separator" meta:resourcekey="lblSeparatorResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSeparator" runat="server">
                                      <asp:ListItem Text="At Sign(@)" Value="@" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Dot(.)" Value="."></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSchool" runat="server" Text="School" meta:resourcekey="lblSchoolResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlSchool" runat="server" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged" meta:resourcekey="ddlSchoolResource1"></asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator1" ClientIDMode="Static"  runat="server" ErrorMessage="School is required." ControlToValidate="ddlSchool" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="CompareValidator1Resource1">*</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblClass" runat="server" Text="Class" meta:resourcekey="lblClassResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtClass" runat="server" meta:resourcekey="txtClassResource1"></asp:TextBox>
                                <asp:Button ID="btnUpdateClass" runat="server" Text="Update Class" OnClick="btnUpdateClass_Click" meta:resourcekey="btnUpdateClassResource1"/>
                            </td>

                        </tr>
                        <tr>
                            <td><asp:Label ID="lblPassword" runat="server" Text="Password" meta:resourcekey="lblPasswordResource1"></asp:Label></td>
                            <td><asp:TextBox ID="txtPasswordMain" runat="server" meta:resourcekey="txtPasswordMainResource1"></asp:TextBox>
                                <asp:Button ID="btnUpdatePassword" runat="server" Text="Update Password" OnClick="btnUpdatePassword_Click" meta:resourcekey="btnUpdatePasswordResource1"/>
                        </tr>
                    </table>           
                    <asp:Label ID="lblImport" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933" meta:resourcekey="lblImportResource1" EnableViewState="False"></asp:Label><br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please check your inputs" ForeColor="Red" meta:resourcekey="ValidationSummary1Resource1" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" ValidationGroup="v" Width="100px" Height="40px"/>
                    <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1" Width="100px" Height="40px" />
                    <asp:Button ID="btnGoToReport" runat="server" Text="Go to User List Report" OnClick="btnGoToReport_Click" Width="200px" Height="40px"  meta:resourcekey="btnGoToReportResource1" />
                <div style="width:100%;">
                    <asp:Label ID="lblRequiredInfo" runat="server" Text="* - Required Fields" style="float:right;color:red" meta:resourcekey="lblRequiredInfoResource1"></asp:Label>
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Password must be at least 8 characters, mix of letters(at least 1 upper case and lower case letters) and numbers." style="float:right;color:red"></asp:Label>
                    
                    
                    <asp:GridView ID="grdResult" runat="server" 
                        GridLines="Both" Width="100%" Height="300px"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" 
                        ShowFooter="True"
                        BackColor="White" BorderColor="#336666"
                        BorderWidth="3px" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                    
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblUserID" runat="server" style="display:none;" meta:resourcekey="lblUserIDResource1"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="0px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Furigana" meta:resourcekey="TemplateFieldResource12">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtFurigana" runat="server" Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="First Name" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtFirstName" runat="server" meta:resourcekey="txtFirstNameResource1" Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Name" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtLastName" runat="server" meta:resourcekey="txtLastNameResource1" Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gender" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlGender" runat="server" meta:resourcekey="ddlGenderResource1" Width="90%">
                                        <asp:ListItem Text="Male" Value="Male" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        <asp:ListItem Text="Female" Value="Female" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Class" meta:resourcekey="TemplateFieldResource8">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtClassName" runat="server" meta:resourcekey="txtClassNamwResource1"  Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Password" meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPassword" runat="server" meta:resourcekey="txtPasswordResource1"  Width="90%"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </fieldset>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnImport" />
            <asp:PostBackTrigger ControlID="btnDownloadTemplate" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
        </Triggers>
     </asp:UpdatePanel>
</asp:Content>
