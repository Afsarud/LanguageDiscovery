<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Language.Discovery.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
     <link href="Scripts/uploadify.css" rel="stylesheet" />
    <script type="text/javascript" src="http://www.uploadify.com/wp-content/themes/uploadify/js/jquery.min.js"></script>
    <script src="Scripts/jquery.uploadify-3.1.js"></script>

       <a href="javascript:$('#<%=FileUpload1.ClientID%>').fileUploadStart()">Start Upload</a>&nbsp; 
           |&nbsp;<a href="javascript:$('#<%=FileUpload1.ClientID%>').fileUploadClearQueue()">Clear</a> 
            <div style = "padding:40px">
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </div>

    <hgroup class="title">
        <h1><%: Title %>.</h1>
        <h2>Your app description page.</h2>
    </hgroup>

    <article>
        <p>        
            Use this area to provide additional information.
        </p>

        <p>        
            Use this area to provide additional information.
        </p>

        <p>        
            Use this area to provide additional information.
        </p>
    </article>

    <aside>
        <h3>Aside Title</h3>
        <p>        
            Use this area to provide additional information.
        </p>
        <ul>
            <li><a runat="server" href="~/">Home</a></li>
            <li><a runat="server" href="~/About">About</a></li>
            <li><a runat="server" href="~/Contact">Contact</a></li>
        </ul>
    </aside>

  
</asp:Content>