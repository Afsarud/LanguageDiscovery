<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Language.Discovery.Registration" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .txtusername {}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-ui-1.10.3.min.js"></script>
    <link href="App_Themes/Default/jqueryui_custom/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />
    <style>
        fieldset {
        display: block;
        -webkit-margin-start: 2px;
        -webkit-margin-end: 2px;
        -webkit-padding-before: 0.35em;
        -webkit-padding-start: 0.75em;
        -webkit-padding-end: 0.75em;
        -webkit-padding-after: 0.625em;
        min-width: -webkit-min-content;
        border: 2px groove threedface;
        margin-right:10px;
        }
        .input {}
        table.rdoWhereDidyoufind input {
            width:20px;
            font-size:small !important;
            float: left;

        }
        table.rdoWhereDidyoufind label {
            font-size:small !important;
            width: 200px;
            display: block;
            float: left;
            margin-top:5px;
            vertical-align:middle;
        }
        .radiobutton label { display: inline-block; font-size:small !important; padding-left:5px;}
    </style>
    <script>
        function ShowConfirmationDialog() {
            $('#divConfirmed').dialog({
                width:350,
                modal: true,
                buttons: {
                    Ok: function () {
                        $(this).dialog("close");
                        $(location).attr('href', '<%=Page.ResolveUrl("~/Login")%>');
                    }
                }
            });
        }
        function EchoUserName() {
            $('#txtFirstName').change(function () {
                $('#txtUserName').val($('#txtFirstName').val());
                $('#hdnUserName').val($('#txtUserName').val());
            });
        }
        $(function () {
            var userLang = navigator.language || navigator.userLanguage; 
            
            if (userLang == "ja") {
                $('#pnlJapanese').show();
                //$('#pnlEnglish').hide();
            }
            else {
                $('#pnlJapanese').hide();
                $('#givenNameContainer').hide();
                $("#lblWhereDidyoufind").hide();
            }
            EchoUserName();
            $('#RadioButton8').change(function () {
                $('#txtOther').focus();
            });
            $('#txtOther').focusin(function () {
                $('#RadioButton8').prop("checked", true);
            });

            $("#txtAdditionalUserName").keypress(function (e) {
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    return false;
                }
            });
        });
    </script>
        <asp:HiddenField ID="hdnDemoUserMailTo" Value=""  meta:resourcekey="hdnDemoUserMailToResource1" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hdnUserName" Value="" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hdnPrintTC" Value="" ClientIDMode="Static" runat="server" meta:resourcekey="hdnPrintTCResource1"/>
        <fieldset  style="margin-top:40px;margin-left:10px;">
            <legend style="font-size:large;"><asp:Label ID="lblRegister" runat="server" ClientIDMode="Static" meta:resourcekey="lblRegisterResource1" >Register</asp:Label></legend>
                <div>
                    <table>
                        <tr>
                            <td><asp:Label ID="lblWhereDidyoufind" runat="server" ClientIDMode="Static" Text="Where did you find out about Palaygo?" meta:resourcekey="lblWhereDidyoufindResource1"></asp:Label></td>
                            <td>
                                <asp:Panel ID="pnlJapanese" runat="server" ClientIDMode="Static" style="display:none;">
                                    <table>
                                        <tr>
                                            <td><asp:RadioButton ID="RadioButton1" runat="server" Text="あしたね(Edutown)" CssClass="radiobutton" ClientIDMode="Static" GroupName="wheredidyoufind" Checked="true" meta:resourcekey="ListItem1Resource1"/></td>
                                            <td><asp:RadioButton ID="RadioButton2" runat="server" Text="ウェブ検索" CssClass="radiobutton" ClientIDMode="Static"  GroupName="wheredidyoufind" meta:resourcekey="ListItem3Resource1"/></td>
                                        </tr>
                                        <tr>
                                            <td><asp:RadioButton ID="RadioButton3" runat="server" Text="JAPEC提携教室" CssClass="radiobutton" ClientIDMode="Static"  GroupName="wheredidyoufind" meta:resourcekey="ListItem4Resource1"/></td>
                                            <td><asp:RadioButton ID="RadioButton4" runat="server" Text="その他英語教室" CssClass="radiobutton" ClientIDMode="Static" GroupName="wheredidyoufind" meta:resourcekey="ListItem5Resource1"/></td>
                                        </tr>
                                        <tr>
                                            <td><asp:RadioButton ID="RadioButton5" runat="server" Text="パレーゴ会員紹介" CssClass="radiobutton" ClientIDMode="Static" GroupName="wheredidyoufind" meta:resourcekey="ListItem6Resource1"/></td>
                                            <td><asp:RadioButton ID="RadioButton6" runat="server" Text="パレーゴ導入学校の生徒" CssClass="radiobutton" ClientIDMode="Static" GroupName="wheredidyoufind"  meta:resourcekey="ListItem7Resource1"/></td>
                                        </tr>
                                        <tr>
                                            <td><asp:RadioButton ID="RadioButton7" runat="server" Text="パレーゴ会員の兄弟姉妹" CssClass="radiobutton" ClientIDMode="Static" GroupName="wheredidyoufind" meta:resourcekey="ListItem8Resource1"/></td>
                                            <td><asp:RadioButton ID="RadioButton8" runat="server" Text="その他" CssClass="radiobutton" ClientIDMode="Static" GroupName="wheredidyoufind"  meta:resourcekey="ListItem9Resource1" data-item="Other"/>
                                                <asp:TextBox ID="txtOther" runat="server" ClientIDMode="Static"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <asp:Panel ID="pnlEnglish" runat="server" ClientIDMode="Static" style="display:none;width: 256px;">
                                    <table>
                                        <tr>
                                            <td><asp:TextBox ID="TextBox1" runat="server" ClientIDMode="Static" Width="256px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblParentsFullName" runat="server" ClientIDMode="Static" Text="Parent/Guardian's Full Name" meta:resourcekey="lblParentsFullNameResource1"></asp:Label></td>
                            <td><asp:TextBox runat="server" CssClass="input" ID="txtParentsFullName" ClientIDMode="Static" MaxLength="50" Width="310px" meta:resourcekey="txtParentsFullNameResource1"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtParentsFullName" Display="Dynamic" ForeColor="Red" ErrorMessage="-Required" ValidationGroup="v" meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblParentsEmail" runat="server" ClientIDMode="Static" Text="Parent/Guardian's Email" meta:resourcekey="lblParentsEmailResource1"></asp:Label></td>
                            <td><asp:TextBox runat="server" CssClass="input" ID="txtParentsEmail" ClientIDMode="Static" MaxLength="50" Width="310px" meta:resourcekey="txtParentsEmailResource1"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtParentsEmail" Display="Dynamic" ForeColor="Red" ErrorMessage="-Required" ValidationGroup="v" meta:resourcekey="RequiredFieldValidator3Resource1"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="validateEmail" runat="server" Display="Dynamic" ErrorMessage="-Invalid email" ControlToValidate="txtParentsEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ForeColor="Red" ValidationGroup="v" meta:resourcekey="validateEmailResource1"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblPhoneNumber" runat="server" ClientIDMode="Static" Text="Teacher's Phone Number" meta:resourcekey="lblPhoneNumberResource1"></asp:Label></td>
                            <td><asp:TextBox runat="server" CssClass="input" ID="txtTelepone" ClientIDMode="Static" MaxLength="50" Width="310px" meta:resourcekey="txtParentsEmailResource1"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTelepone" Display="Dynamic" ForeColor="Red" ErrorMessage="-Required" ValidationGroup="v" meta:resourcekey="RequiredFieldValidator3Resource1" Enabled="false"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblSchool" runat="server" ClientIDMode="Static" Text="School" meta:resourcekey="lblSchoolResource1"></asp:Label></td>
                            <td><asp:TextBox runat="server" CssClass="input" ID="txtSchoolName" ClientIDMode="Static" MaxLength="50" Width="310px" meta:resourcekey="txtSchoolNameResource1"/>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtSchoolName" Display="Dynamic" ForeColor="Red" ErrorMessage="-Required" ValidationGroup="v" meta:resourcekey="RequiredFieldValidator4Resource1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="givenNameContainer">
                            <td><asp:Label ID="lblFirstName" runat="server" ClientIDMode="Static" Text="Child's Given Name" meta:resourcekey="lblFirstNameResource1"></asp:Label></td>
                            <td><asp:TextBox runat="server" CssClass="input" ID="txtFirstName" ClientIDMode="Static" MaxLength="50" Width="310px" meta:resourcekey="txtFirstNameResource1"/>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtFirstName" Display="Dynamic" ForeColor="Red" ErrorMessage="-Required" ValidationGroup="v" meta:resourcekey="RequiredFieldValidator4Resource1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblPalaygoUserName" runat="server" ClientIDMode="Static" Text="Palaygo User Name" meta:resourcekey="lblPalaygoUserNameResource1"></asp:Label></td>
                            <td><asp:TextBox runat="server" CssClass="input" ID="txtUserName" BackColor="LightGray" ClientIDMode="Static" MaxLength="50" Width="150px" meta:resourcekey="txtUserNameResource1" ReadOnly="true" data-username=""/>
                                <asp:TextBox runat="server" CssClass="input" ID="txtAdditionalUserName" BackColor="LightGray" ClientIDMode="Static" MaxLength="8" Width="160px" Enabled="false"/>
                                <asp:Label ID="lblMessage" ForeColor="Red" runat="server" EnableViewState="False" Visible="False" Text="There is an error creating your account. Please contact the administrator." meta:resourcekey="lblMessageResource1" Width="350px"></asp:Label> 
                            </td>
                            
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblGender" runat="server" ClientIDMode="Static" Text="Gender" meta:resourcekey="lblGenderResource1"></asp:Label></td>
                            <td><asp:DropDownList ID="ddlGender" runat="server" Width="310px" Font-Size="Medium" meta:resourcekey="ddlGenderResource1">
                                    <asp:ListItem Text="" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                    <asp:ListItem Text="Male" Value="Male" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                    <asp:ListItem Text="Female" Value="Female" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:CompareValidator ID="CompareValidator1"  ClientIDMode="Static" runat="server" ErrorMessage="-Required"  Display="Dynamic" ControlToValidate="ddlGender" ValueToCompare="0" Operator="NotEqual"  ValidationGroup="v" ForeColor="Red" meta:resourcekey="CompareValidator1Resource1"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblPassword" runat="server" ClientIDMode="Static" Text="Password" meta:resourcekey="lblPasswordResource1"></asp:Label></td>
                            <td  colspan="3">
                                <asp:TextBox runat="server" CssClass="input" ID="txtPassword" TextMode="Password" MaxLength="15" ClientIDMode="Static" Width="310px" meta:resourcekey="txtPasswordResource1"/>
                                <div>
                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="-Required" ControlToValidate="txtPassword"  Display="Dynamic" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvPasswordResource1"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revPassword" ControlToValidate="txtPassword" ValidationGroup="v" ForeColor="Red" Display="Dynamic" ClientIDMode="Static" meta:resourcekey="revPasswordResource1"
                                    ValidationExpression = "^(?=.*[A-Z])^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$"
                                    runat="server" ErrorMessage="">Password must be at least 7 characters, mix of letters and numbers
                                    </asp:RegularExpressionValidator>
                                </div>
                            </td>
                            
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblConfirmPassword" runat="server" ClientIDMode="Static" Text="Confirm Password" meta:resourcekey="lblConfirmPasswordResource1"></asp:Label></td>
                            <td><asp:TextBox runat="server" CssClass="input" ID="txtConfirmPassword" TextMode="Password" MaxLength="15" ClientIDMode="Static" Width="310px" meta:resourcekey="txtConfirmPasswordResource1"/>
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="-Required" ControlToValidate="txtConfirmPassword"  Display="Dynamic" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvConfirmPasswordResource1" ></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvConfirmPassword" runat="server" ErrorMessage="Password not matched" ControlToValidate="txtConfirmPassword"  Display="Dynamic" ControlToCompare="txtPassword" ValidationGroup="v" ForeColor="Red" meta:resourcekey="cvConfirmPasswordResource1"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblTerms" runat="server" ClientIDMode="Static" Text="Terms and Conditions" meta:resourcekey="lblTermsResource1"></asp:Label></td>

                            <td>
                                <asp:HyperLink ID="linkPrint" runat="server" NavigateUrl="http://www.palaygo.com/home/terms2.html" meta:resourcekey="linkPrintResource1" Target="_blank">Print</asp:HyperLink><br />
                                <asp:TextBox runat="server" CssClass="input" ID="txtTerms" Height="100px" TextMode="MultiLine" MaxLength="15" ClientIDMode="Static" Width="526px" ReadOnly="true" Font-Size="Small" meta:resourcekey="txtTermsResource1"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <asp:HiddenField ID="hdnUserAlreadyExist" runat="server" Value="User {0} already exist in our system, please choose other Name." meta:resourcekey="hdnUserAlreadyExistResource1" />
                                <asp:Label ID="lblMessage1" ForeColor="Red" runat="server" EnableViewState="False" Visible="False" Text="There is an error creating your account. Please contact the administrator." meta:resourcekey="lblMessageResource1"></asp:Label> 
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <asp:Button ID="btnSubmit" ValidationGroup="v" style="background-image:url('Images/btnContinueLogin.png'); background-size:300px 36px; background-color:Transparent; cursor:pointer; background-position:left;color:#ffffff;font-weight:bold; background-repeat: no-repeat;background-size: cover;" Height="36px" BorderStyle="None" Width="430px" runat="server" Text="Agree to Terms and Condition"  meta:resourcekey="btnRegisterResource1" ClientIDMode="Static" OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>

    <div id="divConfirmed" style="display:none;width:400px;">
        <center>
            <asp:Label ID="lblInfo" runat="server" Text="Congratulations!!! Your user has been created. Please memorize and copy your username below. Once you click OK it will redirect to Login page" meta:resourcekey="lblInfoResource1"></asp:Label><br /><br />
            <asp:Label ID="lblUserName" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
        </center>
    </div>
</asp:Content>
