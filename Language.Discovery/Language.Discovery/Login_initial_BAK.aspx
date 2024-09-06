<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Language.Discovery.Account.Login" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<%--<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>--%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
  <script src="Scripts/jquery-1.9.1.js"></script>
  <script src="Scripts/jquery-ui-1.10.3.min.js"></script>
  <link href="App_Themes/Default/jqueryui_custom/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />

  <script>
    var isopen = false;

    function ShowNotice() {
      $("#divNotice").dialog({
        modal: true,
        width: 600,
        buttons: {
          Ok: function () {
            $(this).dialog("close");
            ShowTermsAndAgreement();
          }
        }
      });
    }

    function ShowTermsAndAgreement() {
      $("#terms").dialog({
        height: 700,
        width: 600,
        modal: true,
        open: function () {
          $("#content").load('documentation/' + $('#hdnTerms').val());
        }
      });
    }

    function ShowParentsInfo() {
      var translations = {};
      translations["Continue"] = $('#hdnContinue').val();
      $("#lblPalaygoID").text($("#UserName").val());
      $("#txtParentsName").val("");
      $("#txtParentsGivenName").val("");
      $("#txtEmail").val("");
      $("#txtConfirmEmail").val("");
      var buttonsOpts = {};

      buttonsOpts[translations["Continue"]] = function (){
        if ($("#txtParentsGivenName").val() == "") {
          $('#lblParentsNameInfo').show();
          return;
        }
        else{
          $('#lblParentsNameInfo').hide();
        }
        if ($("#txtEmail").val() == "") {
          $('#lblEmailInfo').show();
          return
        }
        else{
          $('#lblEmailInfo').hide();
        }
        if (!IsEmail($("#txtEmail").val())) {
          $('#lblEmailAddressInvalid').show();
          return;
        }
        else{
          $('#lblEmailAddressInvalid').hide();
        }
        if ($("#txtEmail").val().toLowerCase() != $("#txtConfirmEmail").val().toLowerCase()) {
          $('#lblConfirmEmailnotMatch').show();
          return;
        }
        else{
          $('#lblConfirmEmailnotMatch').hide();
        }
        $('#btnLogin').data('locked', 0);
        $(this).dialog("close");
        ShowTermsAndAgreement();
      }

      $("#divParentsInfo").dialog({
        height: 400,
        width: 650,
        modal: true,
        title: $('#hdnParentInfoDialogTitle').val(),
        buttons: buttonsOpts,
        close: function () {
          $("#btnRegister").removeAttr("disabled");
          $('#btnLogin').data('locked', 0);
        },
        open: function () {
          $("#txtParentsName").focus();
          $("#btnRegister").attr("disabled", "disabled");
        }
      });

      $("#divParentsInfo").keyup(function (event) {
        var key = event.keyCode || event.which;
        if (key == 13) {
          $("#btnRegister").attr("disabled", 'disabled');
          $(this).parent().find("button:eq(1)").click();
        }
      });

      $("#divParentsInfo").dialog("open");
      $('.ui-dialog').css('z-index', 103);
      $('.ui-widget-overlay').css('z-index', 102);
      $('#divParentsInfo').parent().appendTo($("form:first"));
    }

    function ShowInActiveMessage(){
      $("#divInActive").dialog({
        modal: true,
        width: 600,
        buttons: {
          Ok: function () {
            $(this).dialog("close");
          }
        }
      });
    }

    function IsEmail(email){
      var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
      return regex.test(email);
    }

    function checkIfUserHasAfterSchoolAccess(e){
      e.preventDefault();
      var json = { Type: 'UserAfterSchoolAccess', username: $('#UserName').val(), password: $('#Password').val() };

      $.post("Handler/GenericPostingHandler.ashx", json, function (data){
        var obj = $.parseJSON(data);
        if (obj.IsTrialExpired == "True" && obj.IsDemo == "True"){
          $('#trialmessage').dialog({
            autoOpen: true,
            modal: true,
            buttons: {
              Ok: function () {
                $(this).dialog("close");
              }
            }
          });
          $('#btnLogin').data('locked', 0);
        }
        else{
          if (obj.IsActive == "False"){
            ShowInActiveMessage();
          }
          else if ((obj.HasAgreedTC == "False" && obj.AfterSchool == "False") || obj.HasAgreedTC == "False"){
              ShowAgreement(e);
            }
          else if (obj.PermissionStatus == "permissionrequired"){
            ShowParentsInfo();
          }
          //else if (obj.PermissionStatus == "continuelogin"){
          //  if ((obj.HasAgreedTC == "False" && obj.AfterSchool == "False") || obj.HasAgreedTC == "False"){
          //    ShowAgreement(e);
          //  }
          //  else{
          //    $('#btnRealLogin').click();
          //  }
          //}
          //else if (obj.HasAgreedTC == "False" && obj.IsDemo == "True" && obj.FromRegistrationPage == "False"){
          //  ShowParentsInfo();
          //}
          //else if (obj.HasAgreedTC == "False" && obj.AfterSchool == "True"){
          //  ShowAgreement(e);
          //  return true
          //}
          else{
            $('#btnRealLogin').click();
          }
        }
      });
    }

    function ShowAgreement(e) {
      e.preventDefault();
      var json = { Type: 'user', username: $('#UserName').val(), password: $('#Password').val() };

      $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
        var obj = $.parseJSON(data)

        if (obj.Status == "inactive") {
          ShowNotice();
        }
        else if (obj.Status == "active") {
          $('#btnRealLogin').click();
        }
        else {
          $('#btnRealLogin').click();
        }
      });
    }

      $(document).ready(function () {
          $('#linkSupportContact').attr("href", $('#hdnContactPalaygo').val());
      $('#btnLogin').click(function (event) {
        if ($('#btnLogin').data('locked') == 1) {
          event.preventDefault();
          $('.ui-button-text-only').click();
          return;
        }
        if ($('#UserName').val() == '') {
          $('#btnRealLogin').click();
          return;
        }
        if ($('#Password').val() == '') {
          $('#btnRealLogin').click();
          return;
        }
        if ($('#btnLogin').data('locked') == undefined || $('#btnLogin').data('locked') == 0) {
          $('#btnLogin').data('locked', 1);
          checkIfUserHasAfterSchoolAccess(event);
        }
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

    function ShowTimeout() {
      $("#divSession").dialog({
        modal: true,
        width: 600,
        buttons: {
          Ok: function () {
            $(this).dialog("close");
          }
        }
      });
    }

    function Register() {
      window.open($('#hdnRegister').val(), '_blank');
      return false;
    }
    
    function Contact() {
      window.open($('#hdnContactPalaygo').val(), '_blank');
      return false;
    }
  </script>
  <style>
    body{
      background-color: rgb(220, 220, 220);
    }
    .login-html{
      padding: 5% 10% 10% 10%;
    }
  </style>

  <div id="trialmessage" style="display:none;">
    <asp:Label ID="lblExpireMessage" runat="server" Text="Your Demo user is already expired."  meta:resourcekey="lblExpireMessageResource1"></asp:Label>
  </div>
  <asp:HiddenField ID="hdnNativeLanguage" runat="server" ClientIDMode="Static" />

  <div class="container-fluid" style="padding: 0% 0% 2% 0%;">
    <div class="content-home-main">
      <div class="bg-home"></div>
      <div class="bg-content container-fluid">
        <div class="row">
          <div class="d-none d-lg-block col-lg-6 col-md-12 content-left" style="padding: 0% 0% 0% 5%; margin: 10px 0px 0px 0px">
            <asp:Localize ID="localizeLoginHeader" ClientIDMode="Static" runat="server" meta:resourcekey="localizeLoginWelcomeTitle">
              <h1>Welcome to Palaygo!</h1>
              <p>Type in yout Palaygo Username and Password to start using Palaygo</p>
              <p>Or, if you are new, click &quot;Register&quot; below, to create a nwe user.</p>
            </asp:Localize>
            <div class="text-center">
              <asp:HiddenField ID="hdnRegister" Value="https://www.palaygo.net.au/"  meta:resourcekey="hdnRegisterResource1" ClientIDMode="Static" runat="server" />
              <asp:Button ID="btnRegister" CssClass="btn btn-primary" Height="36px" BorderStyle="None" Width="116px" runat="server" Text="Register"  meta:resourcekey="btnRegisterResource1" CausesValidation="false" OnClientClick="Register(); return false;" OnClick="btnRegister_Click" ClientIDMode="Static" />
              <asp:Button ID="Activate" Visible="false" CssClass="btnActivate" Height="36px" BorderStyle="None" Width="116px" runat="server" Text="Activate"  meta:resourcekey="testResource2" />
            </div>
            <br />
            <asp:Localize ID="HomeAccess" meta:resourcekey="HomeAccessResource1" ClientIDMode="Static" runat="server" Visible="false"></asp:Localize>
            <br />
          </div>
          <div class="col-lg-6 col-md-12 content-right">
            <div id="loginForm">
              <div class="loginform-shadow">
                <asp:Panel ID="Panel1" runat="server" meta:resourcekey="Panel1Resource1">
                  <asp:Login ID="Login1" runat="server" ViewStateMode="Disabled" RenderOuterTable="False" meta:resourcekey="Login1Resource1" OnAuthenticate="Login1_Authenticate">
                    <LayoutTemplate>
                      <div class="login-wrap">
                        <div class="login-html">
                          <input id="tab-1" type="radio" name="tab" class="sign-in" checked="checked"/>
                          <label for="tab-1" class="tab">
                            <asp:Localize ID="formButtonLogin" runat="server" Text="Login" ClientIDMode="Static" meta:resourcekey="formBtnLogin"></asp:Localize>
                          </label>
                          <input id="tab-2" type="radio" name="tab" class="for-pwd"/>
                          <label for="tab-2" class="tab">
                            <asp:Localize ID="formButtonForpwd" runat="server" Text="Forgot Password" ClientIDMode="Static" meta:resourcekey="formBtnForpwd"></asp:Localize>
                          </label>
                          <div class="login-form">
                            <div class="sign-in-htm">
                              <div class="group">
                                <asp:TextBox runat="server" CssClass="form-control Username" ID="UserName" meta:resourcekey="UserNameResource1" ClientIDMode="Static" Width="60%"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="*" meta:resourcekey="RequiredFieldValidator1Resource1" ForeColor="Red"  ValidationGroup="p"/>
                              </div>
                              <div class="group">
                                <asp:TextBox runat="server" CssClass="form-control Password" ID="Password" TextMode="Password" meta:resourcekey="PasswordResource1" ClientIDMode="Static" Width="60%"/>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="*" meta:resourcekey="RequiredFieldValidator2Resource1" ForeColor="Red" ValidationGroup="p"/>
                              </div>
                              <div class="group">
                                <asp:Button ID="btnLogin" runat="server" CommandName="Login" Text="Log in" ClientIDMode="Static" OnClick="btnLogin_Click" meta:resourcekey="btnLoginResource1" CssClass="btn btn-primary" Height="36px" BorderStyle="None" Width="116px"  ValidationGroup="p" />
                                <asp:Button ID="btnRealLogin" runat="server" CommandName="Login" Text="Log in" ClientIDMode="Static" OnClick="btnLogin_Click" meta:resourcekey="btnLoginResource1" CssClass="loginButton" style="display:none;"   ValidationGroup="p"/>
                              </div>
                              <div class="group">
                                <p class="validation-summary-errors" style="color: orange;">
                                  <asp:Literal runat="server" ID="Failuretext" meta:resourcekey="FailureTextResource1" />
                                </p>
                                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="False" EnableViewState="False" meta:resourcekey="lblMessageResource1" Text="Invalid username or password"></asp:Label>
                              </div>
                            </div>
                            <div class="for-pwd-htm">
                              <div class="group">
                                <asp:TextBox CssClass="form-control Username" ID="txtRequestUserName" runat="server" meta:resourcekey="UsernameResource1" ClientIDMode="Static" Width="60%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtRequestUserName" ForeColor="Red" ValidationGroup="r" meta:resourcekey="RequiredFieldValidator1Resource1"></asp:RequiredFieldValidator><br />
                              </div>
                              <div class="group">
                                <asp:Button ID="btnContinue" CssClass="btn btn-primary" runat="server" Text="Continue" ClientIDMode="Static" OnClick="btnContinue_Click" ValidationGroup="r" Height="36px" BorderStyle="None" Width="116px" meta:resourcekey="btnContinueResource1"/>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </LayoutTemplate>
                  </asp:Login>
                </asp:Panel>
              </div>
            </div>
            <asp:HiddenField ID="hdnMailTo" Value="info@languagediscovery.org"  meta:resourcekey="hdnMailToResource1" ClientIDMode="Static" runat="server" />
            <asp:HiddenField ID="hdnParentInfoDialogTitle" Value="Authorisation for Home Access"  meta:resourcekey="hdnParentInfoDialogTitleResource1" ClientIDMode="Static" runat="server" />
            <asp:HiddenField ID="hdnContinue" Value="Continue"  meta:resourcekey="hdnContinueResource1" ClientIDMode="Static" runat="server" />
            <asp:HiddenField ID="hdnDemoUserMailTo" Value=""  meta:resourcekey="hdnDemoUserMailToResource1" ClientIDMode="Static" runat="server" />
            <asp:HiddenField ID="hdnIsRegisterVisible" Value="True"  meta:resourcekey="hdnIsRegisterVisibleResource1" ClientIDMode="Static" runat="server" />
            <asp:HiddenField ID="hdnPasswordMailBody" Value="True"  meta:resourcekey="hdnPasswordMailBodyResource1" ClientIDMode="Static" runat="server" />
              <asp:HiddenField ID="hdnMailToTeacher" Value="forgotpassword@languagediscovery.org"  meta:resourcekey="hdnMailToTeacherResource1" ClientIDMode="Static" runat="server" />
              <asp:HiddenField ID="hdnContactPalaygo" Value=""  meta:resourcekey="hdnContactPalaygoResource1" ClientIDMode="Static" runat="server" />
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="terms" style="display:none;">
    <div id="content"></div>
    <asp:Button ID="btnAgree" runat="server" Text="I Agree" ClientIDMode="Static" meta:resourcekey="btnAgreeResource1"/>
    <asp:Button ID="btnCancel" runat="server" Text="I Do Not Agree" ClientIDMode="Static" meta:resourcekey="btnCancelResource1"/>
    <asp:HiddenField ID="hdnTerms" ClientIDMode="Static" runat="server" meta:resourcekey="hdnTermsResource1" />
  </div>
  <div id="divNotice" style="display:none;">
    <asp:Localize ID="localizenotice" runat="server" ClientIDMode="Static"  meta:resourcekey="localizenoticeResource1">
      <p>Palaygo Home has been upgraded. Use of this service is subject to compliance with the terms and condition of use (revised version).</p>
      <p>If the terms outlined in the next page meet with your approval, please click “I Agree” at the bottom of the next page and enjoy Palaygo Home.</p>
    </asp:Localize>
  </div>
  <div id="divInActive" style="display:none;">
    <asp:Localize ID="localize3" runat="server" ClientIDMode="Static"  meta:resourcekey="localizeInActiveResource1">
      <p>Palaygo Home has been upgraded. Use of this service is subject to compliance with the terms and condition of use (revised version).</p>
    </asp:Localize>
  </div>
  <div id="divSession" style="display:none;">
    <asp:Localize ID="localizeSession" runat="server" ClientIDMode="Static" meta:resourcekey="localizeSessionResource1">
      <p>Time out. Please login again.</p>
    </asp:Localize>
  </div>
  <div id="divParentsInfo" style="display:none;">
    <asp:Localize ID="localize2" runat="server" ClientIDMode="Static" meta:resourcekey="localizedivParentsInfoResource1">
      <p>To access Palaygo Home outside of school hours, you need your parent/guardian to sign up for access from home. Please ask your parent/guardian to fill in the form below and click “Continue”,</p>
    </asp:Localize>
    <table>
      <tr>
        <td><asp:Label ID="lblPalaygoIDLabel" runat="server" Text="Palaygo Login ID" meta:resourcekey="lblPalaygoIDLabelResource1"></asp:Label></td>
        <td><asp:Label ID="lblPalaygoID" runat="server" ClientIDMode="Static"></asp:Label></td>
      </tr>
      <tr style="display:none;">
        <td><asp:Label ID="lblParentsName" runat="server" Text="Parent/Guardian’s Last Name" meta:resourcekey="lblParentsNameResource1"></asp:Label></td>
        <td><asp:TextBox ID="txtParentsName" runat="server" ClientIDMode="Static" Width="350px"></asp:TextBox></td>
      </tr>
      <tr>
        <td><asp:Label ID="lblParentsGivenName" runat="server" Text="Parent/Guardian’s Full Name" meta:resourcekey="lblParentsGivenNameResource1"></asp:Label></td>
        <td><asp:TextBox ID="txtParentsGivenName" runat="server" ClientIDMode="Static" Width="350px"></asp:TextBox></td>
      </tr>
      <tr>
        <td><asp:Label ID="lblEmail" runat="server" Text="Email" meta:resourcekey="lblEmailResource1"></asp:Label></td>
        <td><asp:TextBox ID="txtEmail" runat="server" ClientIDMode="Static" Width="350px"></asp:TextBox></td>
      </tr>
      <tr>
        <td><asp:Label ID="lblConfirmEmail" runat="server" Text="Confirm Email" meta:resourcekey="lblConfirmEmailResource1"></asp:Label></td>
        <td><asp:TextBox ID="txtConfirmEmail" runat="server" ClientIDMode="Static" Width="350px"></asp:TextBox></td>
      </tr>
      <tr>
        <td colspan="2">
          <asp:Label ID="lblParentsNameInfo" runat="server" Text="Parents name is required." ClientIDMode="Static" ForeColor="Red" style="display:none;" meta:resourcekey="lblParentsNameInfoResource1"></asp:Label>
          <asp:Label ID="lblEmailInfo" runat="server" Text="Email is required." ClientIDMode="Static" ForeColor="Red" style="display:none;" meta:resourcekey="lblEmailInfoResource1"></asp:Label>
          <asp:Label ID="lblEmailAddressInvalid" runat="server" Text="Email Addres is invalid." ClientIDMode="Static" ForeColor="Red" style="display:none;" meta:resourcekey="lblEmailAddressInvalidResource1"></asp:Label>
          <asp:Label ID="lblConfirmEmailnotMatch" runat="server" Text="Confirm Email address not match" ClientIDMode="Static" ForeColor="Red" style="display:none;" meta:resourcekey="lblConfirmEmailnotMatchResource1"></asp:Label>
        </td>
      </tr>
    </table>
  </div>
</asp:Content>
