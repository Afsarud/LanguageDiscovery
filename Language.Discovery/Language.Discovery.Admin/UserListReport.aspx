<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UserListReport.aspx.cs" Inherits="Language.Discovery.Admin.UserListReport" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="User List Report" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
     <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
        <fieldset>
        <legend>
            <asp:Label ID="lblCriteria" runat="server" Text="Criteria" meta:resourcekey="lblCriteriaResource1"></asp:Label></legend>

      <table>
        <tr>
            <td><asp:Label ID="lblSearchSchool" runat="server" meta:resourcekey="lblSearchSchoolResource1">School</asp:Label></td>
            <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>   
            <td><asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1">User</asp:Label></td>
            <td><asp:TextBox ID="txtSearchUser" runat="server" meta:resourcekey="txtSearchUserResource1"></asp:TextBox></td>   
            <td><asp:Label ID="lblSort" runat="server" meta:resourcekey="lblSortResource1">Sort</asp:Label></td>
            <td><asp:DropDownList ID="ddlSort" runat="server" meta:resourcekey="ddlSortResource1">
                    <asp:ListItem Text="UserName" Value="UserName" meta:resourcekey="ListItemResource1"></asp:ListItem>
                    <asp:ListItem Text="School" Value="School" meta:resourcekey="ListItemResource2"></asp:ListItem>
                    <asp:ListItem Text="Active" Value="IsActive" meta:resourcekey="ListItemResource5"></asp:ListItem>
                    <asp:ListItem Text="After School Access" Value="AfterSchool" meta:resourcekey="ListItemResource6"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td><asp:DropDownList ID="ddlOrder" runat="server" meta:resourcekey="ddlOrderResource1">
                    <asp:ListItem Text="Ascending" Value="A" meta:resourcekey="ListItemResource3"></asp:ListItem>
                    <asp:ListItem Text="Descending" Value="D" meta:resourcekey="ListItemResource4"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
<%--            <td><asp:Label ID="Label2" runat="server">From</asp:Label></td>
            <td><asp:TextBox ID="txtStartDate" runat="server" ClientIDMode="Static"></asp:TextBox></td>   
            <td><asp:Label ID="Label3" runat="server">To</asp:Label></td>
            <td><asp:TextBox ID="txtEndDate" runat="server" ClientIDMode="Static"></asp:TextBox></td>   --%>
            <td>
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" OnClick="btnGenerate_Click" meta:resourcekey="btnGenerateResource1" /></td>
        </tr>
    </table>
   </fieldset>
  <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="700px" Font-Names="Verdana" Font-Size="8pt" meta:resourcekey="ReportViewer1Resource1" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        
    </rsweb:ReportViewer>

</asp:Content>
