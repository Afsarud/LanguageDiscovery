<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="TalkScheduleReport.aspx.cs" Inherits="Language.Discovery.Admin.TalkScheduleReport" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Talk Schedule Report" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script>
        function InitializeDate() {
            $("#txtStartDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                numberOfMonths: 1,
                onClose: function (selectedDate) {
                    $("#txtEndDate").datepicker("option", "minDate", selectedDate);
                }
            });
            $("#txtEndDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                numberOfMonths: 1,
                onClose: function (selectedDate) {
                    $("#txtStartDate").datepicker("option", "maxDate", selectedDate);
                }
            });
          
        }

        $(function () {
            
            InitializeDate();
        });

    </script>
     <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
        <fieldset>
        <legend>
            <asp:Label ID="lblCriteriaLegend" runat="server" Text="Criteria" meta:resourcekey="lblCriteriaLegendResource1"></asp:Label></legend>

      <table>
        <tr>
            <td><asp:Label ID="lblSearchSchool" runat="server" meta:resourcekey="lblSearchSchoolResource1" Text="School"></asp:Label></td>
            <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1"></asp:DropDownList></td>   
            <td><asp:Label ID="lblSearchPartnerSchool" runat="server" meta:resourcekey="lblSearchPartnerSchoolResource1" Text="Partner School"></asp:Label></td>
            <td><asp:DropDownList ID="ddlSearchPartnerSchool" runat="server" ClientIDMode="Static"></asp:DropDownList></td>   
            <td><asp:Label ID="lblSort" runat="server" meta:resourcekey="lblSortResource1" Text="Sort"></asp:Label></td>
            <td><asp:DropDownList ID="ddlSort" runat="server" meta:resourcekey="ddlSortResource1">
                    <asp:ListItem Text="Schedule" Value="Schedule" meta:resourcekey="ListItemResource1"></asp:ListItem>
                    <asp:ListItem Text="School" Value="School" meta:resourcekey="ListItemResource2"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td><asp:DropDownList ID="ddlOrder" runat="server" meta:resourcekey="ddlOrderResource1">
                    <asp:ListItem Text="Ascending" Value="A" meta:resourcekey="ListItemResource3"></asp:ListItem>
                    <asp:ListItem Text="Descending" Value="D" meta:resourcekey="ListItemResource4"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
         <tr>
            <td><asp:Label ID="Label2" runat="server" meta:resourcekey="Label2Resource1">From</asp:Label></td>
            <td><asp:TextBox ID="txtStartDate" runat="server" ClientIDMode="Static" meta:resourcekey="txtStartDateResource1" autocomplete="off"></asp:TextBox></td>   
            <td><asp:Label ID="Label3" runat="server" meta:resourcekey="Label3Resource1">To</asp:Label></td>
            <td colspan="2"><asp:TextBox ID="txtEndDate" runat="server" ClientIDMode="Static" meta:resourcekey="txtEndDateResource1" autocomplete="off"></asp:TextBox></td>   
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
