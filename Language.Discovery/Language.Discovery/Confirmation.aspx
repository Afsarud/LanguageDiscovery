<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs" Inherits="Language.Discovery.Confirmation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .center {
          margin: auto;
          width: 50%;
          border: 3px solid green;
          padding: 70px 25px;
          text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="center">
            <asp:Label ID="lblMessage" runat="server" Text="Thank you for taking your time to answer the confirmation email." Font-Size="XX-Large"  meta:resourcekey="lblDialogMessageResource1"></asp:Label>
            <asp:Label ID="lblErrorMessage" Visible="false" runat="server" Text="There might be an error in your confirmation. Other user might be currently login. Please copy the YES link url and then paste it on other browser. Or Logout this session and try again." Font-Size="XX-Large" ForeColor="Red"  meta:resourcekey="lblErrorMessageResource1"></asp:Label>
        </div>
    </form>
</body>
</html>
