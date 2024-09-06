<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="TeachersRegistration.aspx.cs" Inherits="Language.Discovery.Admin.TeachersRegistration" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <div style="width:100%;border:1px solid black;text-align:center;">
            <asp:Label ID="lblTitle" runat="server" Text="New Teacher Registration" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <div>
        <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
  <table style="width:100%;">
        <tr>
            <td style="width:50%">
                <asp:UpdatePanel ID="upDetail" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblDataEntryLegend" runat="server" Text="Data Entry" meta:resourcekey="lblDataEntryLegendResource1"></asp:Label></legend>
                            <table>
                                <tr>
                                    <td><asp:Label ID="lblGender" runat="server" meta:resourcekey="lblGenderResource1">Gender</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlGender" runat="server" meta:resourcekey="ddlGenderResource1">
                                            <asp:ListItem Value="" Text="Select Gender"></asp:ListItem>
                                            <asp:ListItem Value="1" Text="Male"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Female"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CompareValidator ID="cvGender" ClientIDMode="Static" runat="server" ErrorMessage="Gender is required." ControlToValidate="ddlGender" ValueToCompare="0" Operator="NotEqual" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvGenderResource1" >*</asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblFirstName" runat="server" meta:resourcekey="lblFirstNameResource1">First Name</asp:Label></td>
                                     <td><asp:TextBox ID="txtFirstName" runat="server" Width="560px" meta:resourcekey="txtFirstNameResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="First Name is required" ControlToValidate="txtFirstName" ValidationGroup="v" ForeColor="Red" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
                                     </td>   
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblLastName" runat="server" meta:resourcekey="lblLastNameResource1">Last Name</asp:Label></td>
                                     <td><asp:TextBox ID="txtLastName" runat="server" Width="560px" meta:resourcekey="txtFirstNameResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Last Name is required" ControlToValidate="txtLastName" ValidationGroup="v" ForeColor="Red" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
                                     </td>   
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmailResource1">Email</asp:Label></td>
                                     <td><asp:TextBox ID="txtEmail" runat="server" Width="560px" meta:resourcekey="txtEmailResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" ValidationGroup="v" ForeColor="Red" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
                                         <asp:RegularExpressionValidator ID="validateEmail" runat="server" Display="Dynamic" ErrorMessage="-Invalid email" ControlToValidate="txtEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ForeColor="Red" ValidationGroup="v" meta:resourcekey="validateEmailResource1"></asp:RegularExpressionValidator>
                                     </td>   
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblTelephone" runat="server" meta:resourcekey="lblSchoolNameResource1">Telephone</asp:Label></td>
                                     <td><asp:TextBox ID="txtTelephone" runat="server" Width="560px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="School Name is required" ControlToValidate="txtSchoolName" ValidationGroup="v" ForeColor="Red" meta:resourcekey="RequiredFieldValidator2Resource1" Enabled="false">*</asp:RequiredFieldValidator>
                                     </td>   
                                </tr>
                                <tr>
                                    <td><asp:Label ID="lblSchoolName" runat="server" meta:resourcekey="lblSchoolNameResource1">School Name</asp:Label></td>
                                     <td><asp:TextBox ID="txtSchoolName" runat="server" Width="560px" meta:resourcekey="txtSchoolNameResource1"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="School Name is required" ControlToValidate="txtSchoolName" ValidationGroup="v" ForeColor="Red" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
                                     </td>   
                                </tr>

                            </table>

                            <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" ForeColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please Check your inputs." meta:resourcekey="ValidationSummary1Resource1" />

                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="v" meta:resourcekey="btnSaveResource1" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" meta:resourcekey="btnClearResource1" />
                            </fieldset>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
          
        </tr>
    </table>
    </div>
</asp:Content>
