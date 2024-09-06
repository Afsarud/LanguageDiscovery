<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Language.Discovery.Admin.Login" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="scripts/jquery-2.0.3.js"></script>
    <script src="scripts/jquery-ui-1.10.3.js"></script>
    <script src="scripts/zendesk.js"></script>
    <link href="css/jqueryui_custom/jquery-ui-1.10.4.custom.css" rel="stylesheet" />
   
    <script>
        $(document).ready(function () {
            $('#btnLogin').click(function (event) {
                if ($('#txtUserName').val() == '') {
                    $('#btnRealLogin').click();
                    return;
                }
                if ($('#Password').val() == '') {
                    $('#btnRealLogin').click();
                    return;
                }

                ShowAgreement(event);
            });

            $('#btnCancel').click(function () {
                $("#content").empty();
                $("#terms").dialog("close");
            });
            $('#btnAgree').click(function () {
                $("#terms").dialog("close");
                $('#btnRealLogin').click();
            });
        });

        function ShowAgreement(e) {
            //$("#terms").dialog({
            //    height: 500,
            //    width: 600,
            //    modal: true,
            //    open: function () {
            //        $("#content").load('documentation/PalaygoTermsConditions_en.htm');
            //    }
            //});
            e.preventDefault();
            var json = { Type: 'user', username: $('#txtUsername').val(), password: $('#txtPassword').val() };
            $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)

                if (obj.Status == "inactive") {
                    $("#divNotice").dialog({
                        modal: true,
                        width: 600,
                        buttons: {
                            Ok: function () {
                                $(this).dialog("close");
                                $("#terms").dialog({
                                    height: 700,
                                    width: 600,
                                    modal: true,
                                    open: function () {
                                        $("#content").load('documentation/' + $('#hdnTerms').val());
                                    }
                                });
                            }
                        }
                    });

                }
                else if (obj.Status == "active")
                    $('#btnRealLogin').click();
                else
                    alert('Error getting user status.');
            });

            //return false;
            //$("#terms").load('documentation/PalaygoTermsConditions_en.htm').dialog("open");
        }
    </script>
    <!-- Start of palaygo Zendesk Widget script -->
<%--<script id="ze-snippet" src="https://static.zdassets.com/ekr/snippet.js?key=b98dcaa7-628d-4f75-894c-bc57a4cd0728"> </script>--%>
<!-- End of palaygo Zendesk Widget script -->
   <script type="text/javascript">
   
//var observer = new MutationObserver(function (mutationList, observer) {
//    debugger;
//    var tsf = $("#webWidget").contents();
//    tsf.find("input[name='name']").parent("div").hide();
//    tsf.find("input[name='email']").parent("div").hide();
//    tsf.find(".Icon--zendesk").hide();
//});

//       //observer.observe($("#webWidget").contents().find("#Embed")[0], { attributes: true, childList: true, subtree: true });
//$('#name').hide();

//var tsf = $("#webWidget");
//tsf = tsf.contents();
//tsf.find("input[name='name']").parent("div").hide();
//tsf.find("input[name='email']").parent("div").hide();
       //tsf.find(".Icon--zendesk").hide();


</script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:400px; margin-right:auto; margin-left:auto;margin-top:300px;margin-bottom:auto; border:1px solid #000;">
        <br /><br /><br />
        <table class="CenteredPage">
		    <tr>
			    <td class="Caption"><asp:Label ID="lblUsernameText" runat="server" Text="Username" meta:resourcekey="lblUsernameTextResource1"></asp:Label></td>
			    <td style="text-align: left"><asp:TextBox ID="txtUsername" runat="server" MaxLength="50" TabIndex="1" Width="150px" CssClass="LoginField" meta:resourcekey="txtUsernameResource1" ClientIDMode="Static"></asp:TextBox>
			        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please input your User Name." ControlToValidate="txtUsername" ValidationGroup="p" meta:resourcekey="RequiredFieldValidator2Resource1">*</asp:RequiredFieldValidator>
			    </td>
		    </tr>
		    <tr>
			    <td class="Caption"><asp:Label ID="lblPasswordText" runat="server" Text="Password" meta:resourcekey="lblPasswordTextResource1"></asp:Label></td>
			    <td style="text-align: left"><asp:TextBox ID="txtPassword" runat="server" TextMode="Password" MaxLength="50" Width="150px" TabIndex="2" CssClass="LoginField" meta:resourcekey="txtPasswordResource1" ClientIDMode="Static"></asp:TextBox>
			    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please input your Password." ControlToValidate="txtPassword" ValidationGroup="p" meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>
			    </td>
		    </tr>
		    <tr>
			    <td>
    			    
			    </td>
			    <td style="text-align: left">
    			
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="button" 
                        onclick="btnLogin_Click" meta:resourcekey="btnLoginResource1"/>
                    <asp:Button ID="btnRealLogin" runat="server" Text="Login" style="display:none;"
                        onclick="btnRealLogin_Click" meta:resourcekey="btnLoginResource1"/>

			    </td>
		    </tr>
		    <tr>
			    <td colspan="2"><asp:Label ID="lblMessages" runat="server" Visible="False" CssClass="Errors" ForeColor="Red" meta:resourcekey="lblMessagesResource1"></asp:Label></td>
		    </tr>
		    <tr>
		        <td colspan="2" style="vertical-align:bottom; font-size:x-small;">
		            <p>
					If you have a problem logging in, please contact the the 
					<asp:HyperLink ID="lnkAdminEmail" runat="server" Text="application administrator." meta:resourcekey="lnkAdminEmailResource1"></asp:HyperLink>
				</p>
		        </td>
		    </tr>
		    <%--<tr>
			    <td colspan="2" style="padding-top: 10px; text-align: center;">
				    <a href="">Forgotten your password?</a>
			    </td>
		    </tr>--%>
	    </table>
	</div>    
     <div id="terms" style="display:none;">
        <div id="content">

        </div>
        <asp:Button ID="btnAgree" runat="server" Text="I Agree" ClientIDMode="Static" meta:resourcekey="btnAgreeResource1"/>
        <asp:Button ID="btnCancel" runat="server" Text="I Do Not Agree" ClientIDMode="Static" meta:resourcekey="btnCancelResource1"/>
        <asp:HiddenField ID="hdnTerms" ClientIDMode="Static" runat="server" meta:resourcekey="hdnTermsResource1" Value="PalaygoTermsConditions_en.htm" />
    </div>
    <div id="divNotice" style="display:none;">
        <asp:Localize ID="localizenotice" runat="server" ClientIDMode="Static" runat="server" meta:resourcekey="localizenoticeResource1">
            <p>Palaygo Home has been upgraded. Use of this service is subject to compliance with the terms and condition of use (revised version).</p>
            <p>If the terms outlined below meet with your approval, please click “I Agree” at the bottom and enjoy Palaygo Home.</p>
        </asp:Localize>
    </div>
         <style>
        .src-component-container-ScrollContainer-title, .u-paddingHL
        {
            padding-left:0px !important;
            padding-right:0px !important;
        }
    </style>
        <script>
            $(function () {
                
            });
           
        </script>
    </form>
</body>
</html>
