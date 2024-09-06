<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="Language.Discovery.Student.Confirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="lblMessage" runat="server" Text="Thank you for taking your time to answer the confirmation email." Font-Size="XX-Large"  meta:resourcekey="lblDialogMessageResource1"></asp:Label>
    <asp:Label ID="lblErrorMessage" Visible="false" runat="server" Text="There might be an error in your confirmation. Other user might be currently login. Please copy the YES link url and then paste it on other browser. Or Logout this session and try again." Font-Size="XX-Large" ForeColor="Red"  meta:resourcekey="lblErrorMessageResource1"></asp:Label>
</asp:Content>
