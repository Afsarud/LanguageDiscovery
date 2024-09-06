<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UserBulkUpload.aspx.cs" Inherits="Language.Discovery.Admin.UserBulkUpload" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
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

     

    </script>
  <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
            <fieldset>
                <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
                 <legend><asp:Label ID="lblLegend" runat="server" Text="Import Excel" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblSchool" runat="server" Text="School" meta:resourcekey="lblSchoolResource1"></asp:Label>
                                <asp:DropDownList ID="ddlSchool" runat="server" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged" AutoPostBack="True" meta:resourcekey="ddlSchoolResource1"></asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator1" ClientIDMode="Static"  runat="server" ErrorMessage="School is required." ControlToValidate="ddlSchool" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red">*</asp:CompareValidator>
                            </td>
                            <td>
                                <asp:Label ID="lblSeparator" runat="server" Text="Separator" meta:resourcekey="lblSeparatorResource1"></asp:Label>
                                <asp:DropDownList ID="ddlSeparator" runat="server">
                                    <asp:ListItem Text="At Sign(@)" Value="@" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Dot(.)" Value="."></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSelectFile" runat="server" Text=" Please Select Excel File:" meta:resourcekey="lblSelectFileResource1"></asp:Label>
                                <asp:FileUpload ID="fuExcelUploader" runat="server" meta:resourcekey="fuExcelUploaderResource1" />&nbsp;&nbsp;
                                <asp:Button ID="btnImport" runat="server" Text="Import Data" OnClick="btnImport_Click" meta:resourcekey="btnImportResource1" />
                                <br />
                                <asp:Label ID="lblImport" runat="server" Visible="False" Font-Bold="True" ForeColor="#009933" meta:resourcekey="lblImportResource1" EnableViewState="false"></asp:Label><br />
                            </td>
                        </tr>
                    </table>           
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" meta:resourcekey="btnSaveResource1" ValidationGroup="v" />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v"  ShowSummary="true" DisplayMode="BulletList" BorderColor="Red" BorderStyle="Solid" BorderWidth="1" HeaderText="Please check your inputs" ForeColor="Red" />
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
                            
                            <asp:TemplateField HeaderText="User Name" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtUserName" runat="server" meta:resourcekey="txtUserNameResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="First Name" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtFirstName" runat="server" meta:resourcekey="txtFirstNameResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Name" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtLastName" runat="server" meta:resourcekey="txtLastNameResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtAddress" runat="server" meta:resourcekey="txtAddressResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
<%--                            <asp:TemplateField HeaderText="Date Of Birth" meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDateOfBirth" runat="server" meta:resourcekey="txtDateOfBirthResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Password" meta:resourcekey="TemplateFieldResource6">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPassword" runat="server" meta:resourcekey="txtPasswordResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Class" meta:resourcekey="TemplateFieldResource7">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlClass" runat="server" meta:resourcekey="ddlClassResource1"></asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Teachers Name" meta:resourcekey="TemplateFieldResource8">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtTeachersName" runat="server" meta:resourcekey="txtTeachersNameResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Parents Name" meta:resourcekey="TemplateFieldResource9">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtParentsName" runat="server" meta:resourcekey="txtParentsNameResource1"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gender" meta:resourcekey="TemplateFieldResource10">
                                <ItemTemplate>
                                    <asp:DropDownList ID="ddlGender" runat="server" meta:resourcekey="ddlGenderResource1">
                                        <asp:ListItem Text="Male" Value="Male" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        <asp:ListItem Text="Female" Value="Female" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                
            </fieldset>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnImport" />
            <asp:AsyncPostBackTrigger ControlID="btnSave" />
        </Triggers>
     </asp:UpdatePanel>
</asp:Content>
