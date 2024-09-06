<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Language.Discovery.ChangePassword1" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.9.1.js"></script>
    <style>
        .ulInfo{
            margin-right: auto;
            margin-left: auto;
            width: 560px;
        }
        .ulInfo1{
            margin-top: 250px;
        }

    </style>
    <script>
        $(function () {
            $('#chkShowPassword').change(function () {
                if ($(this).is(':checked')) {
                    document.getElementById('txtPassword').setAttribute('type', 'text');
                    document.getElementById('txtConfirmPassword').setAttribute('type', 'text');
                }
                else {
                    document.getElementById('txtPassword').setAttribute('type', 'password');
                    document.getElementById('txtConfirmPassword').setAttribute('type', 'password');
                }
                
            });
            
        });
            
    </script>
</head>
<body>
    <img src="Images/mailLogo2022.png" style="position:absolute; left:0;top:0;" />
    <form id="form1" runat="server">
    <ul class="ulInfo1 ulInfo">
        <li><asp:Label ID="lblInfo1" runat="server" Text="Please change your initial password for security reasons." meta:resourcekey="lblInfo1Resource1"></asp:Label></li>
        <li><asp:Label ID="lblInfo2" runat="server" Text="If you have not changed your password for a long time you will be required to change it here as well." meta:resourcekey="lblInfo2Resource1"></asp:Label></li>
    </ul>
    <fieldset style="width:433px; margin-right:auto; margin-left:auto;margin-top:23px;margin-bottom:auto; border:1px solid #000;">
        <legend style="text-align:center;"><asp:Label ID="lblLegend" runat="server" Text="Change Password" Font-Bold="True" meta:resourcekey="lblLegendResource1"></asp:Label></legend>
        <asp:Label ID="lblChangePassword" runat="server" Font-Bold="True" Text="If change password is successful you will be ask to login again." meta:resourcekey="lblChangePasswordResource1"></asp:Label>
        <br />
        <br />
        <table class="CenteredPage">
		    <tr>
			    <td class="Caption">
                    <asp:Label ID="lblUsername" runat="server" Text="Username" Font-Bold="True" meta:resourcekey="lblUsernameResource1"></asp:Label>
			    </td>
			    <td class="Caption"><asp:Label ID="lblUsernameText" runat="server" Text="Username"></asp:Label></td>
		    </tr>
		    <tr>
			    <td class="Caption">
                    <asp:Label ID="lblPasswordText" runat="server" Text="Password" Font-Bold="True" meta:resourcekey="lblPasswordTextResource1"></asp:Label>
			    </td>
			    <td style="text-align: left"><asp:TextBox ID="txtPassword" ValidationGroup="v" runat="server" TextMode="Password" MaxLength="50" Width="150px" TabIndex="2" CssClass="LoginField" meta:resourcekey="txtPasswordResource1" ClientIDMode="Static"></asp:TextBox>
			    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Please input your Password." ControlToValidate="txtPassword" meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rfvPasswordValidator" ControlToValidate = "txtPassword" ValidationGroup="v" ForeColor="Red"
                                ValidationExpression = "^(?=.*[A-Z])^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$"
                                runat="server" ErrorMessage="Password must be at least 8 characters, mix of letters(at least 1 upper case and lower case letters with NO special characters) and numbers." meta:resourcekey="rfvPasswordValidatorResource1">*
                                </asp:RegularExpressionValidator>

			    </td>
		    </tr>
		    <tr>
			    <td class="Caption"><asp:Label ID="lblConfirmPassword" runat="server" Font-Bold="True" Text="Confirm Password" meta:resourcekey="lblConfirmPasswordResource1"></asp:Label></td>
			    <td style="text-align: left"><asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" ValidationGroup="v" MaxLength="50" Width="150px" TabIndex="2" CssClass="LoginField" meta:resourcekey="txtPasswordResource1" ClientIDMode="Static"></asp:TextBox>
			    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="Please confirm your Password." ControlToValidate="txtConfirmPassword"  ValidationGroup="v"  meta:resourcekey="RequiredFieldValidator1Resource1">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvConfirmPassword" runat="server" ErrorMessage="Password not matched." ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvConfirmPasswordResource1">*</asp:CompareValidator>
			    </td>
		    </tr>
            <tr><td></td><td><asp:CheckBox runat="server" ID="chkShowPassword" ClientIDMode="Static" Text="Show Password" meta:resourcekey="chkShowPasswordResource1"/></td></tr>
            <tr>
                <td></td>
            </tr>
            <tr>
                <td><br /></td>
            </tr>
           <tr>
               <td colspan="2"  style="border: 1px solid black;padding: 5px;"><asp:Label runat="server" ID="txtPasswordCondition" ClientIDMode="Static" Text="Password must be at least 8 characters, mix of letters(at least 1 upper case and lower case letters) and numbers." meta:resourcekey="lblPasswordConditionResource1" ></asp:Label></td>
           </tr>
            <tr>
                <td colspan="2">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please check your inputs" ForeColor="Red" meta:resourcekey="ValidationSummary1Resource1" />
                </td>
            </tr>
		    <tr>
			    <td>
                    <br />
                    <br />
			    </td>
			    <td style="text-align: left">
                    <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="button" 
                        onclick="btnChangePassword_Click" ValidationGroup="v" meta:resourcekey="btnChangePasswordResource1"/>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="button" 
                        onclick="btnCancel_Click" meta:resourcekey="btnCancelResource1" CausesValidation="false"/>
			    </td>
		    </tr>
		    <tr>
			    <td colspan="2"><asp:Label ID="lblMessages" runat="server" Visible="False" CssClass="Errors" ForeColor="Red" meta:resourcekey="lblMessagesResource1"></asp:Label></td>
		    </tr>
	    </table>
	</fieldset> 
    <ul class="ulInfo">
        <li><asp:Label ID="lblInfo3" runat="server" Text="After the password change, you will return to Palaygo login page, so please enter your new password and login again. " meta:resourcekey="lblInfo3Resource1"></asp:Label></li>
    </ul>        
        </form>
</body>
</html>
