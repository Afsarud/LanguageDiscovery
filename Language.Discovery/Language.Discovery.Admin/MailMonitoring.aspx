<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="MailMonitoring.aspx.cs" Inherits="Language.Discovery.Admin.MailMonitoring" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Mail Monitoring" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
 <%--   <div>
        <table>
            <tr>
                <td><asp:Label ID="lblUser" runat="server" Text="User"></asp:Label></td>
                <td>

                </td>
            </tr>
        </table>
    </div>--%>
    <script src="scripts/jquery.floatThead.min.js"></script>
    <script>
        $(document).ready(function () {
            
        });

        function ShowFeedbackDialog() {
            $("#divFeedbackDialog").dialog({
                modal: true,
                buttons: {
                    Ok: function () {
                        debugger;
                        $('#hdnFeedbackMessage').val('');
                        $('#hdnFeedbackMessage').val($('<div/>').text('<p style="color:white;background-color:red;">==>' + $('#txtFeedbackMessage').val() + '</p>').html());
                        $('#txtFeedbackMessage').val('');
                        $('#btnFeedbackPost').click();
                        $(this).dialog("close");
                    }
                }
            });
        }
        function ShowFeedbackDialogAll() {
            $("#divFeedbackDialog").dialog({
                modal: true,
                buttons: {
                    Ok: function () {
                        debugger;
                        $('#hdnFeedbackMessage').val('');
                        $('#hdnFeedbackMessage').val($('<div/>').text('<p style="color:white;background-color:red;">==>' + $('#txtFeedbackMessage').val() + '</p>').html());
                        $('#txtFeedbackMessage').val('');
                        $('#btnFeedbackAllPost').click();
                        $(this).dialog("close");
                    }
                }
            });
        }
        function checkAll(selectAllCheckbox) {
            //get all checkbox and select it
            $('td :checkbox', '#tblMessage').prop("checked", selectAllCheckbox.checked);
        }
        function unCheckSelectAll(selectCheckbox) {
            //if any item is unchecked, uncheck header checkbox as also
            if (!selectCheckbox.checked)
                $('thead :checkbox', '#tblMessage').prop("checked", false);
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
            <asp:HiddenField ID="hdnFeedbackMessage" runat="server" ClientIDMode="Static" />
              <fieldset class="fieldset">
                  <legend><asp:Label ID="lblSearchLegend" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                  <asp:Label ID="lblSearchSchoolLabel" runat="server" Text="School" meta:resourcekey="lblSearchSchoolLabelResource1"></asp:Label>
                  <asp:DropDownList ID="ddlSchoolList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSchoolList_SelectedIndexChanged"></asp:DropDownList>
                  
               </fieldset>

            <br />
            <asp:CheckBox ID="chkSelectAll" runat="server" Text="Select All" meta:resourcekey="chkSelectAllResource1" onclick="checkAll(this);" style="float:left;"></asp:CheckBox>
            <asp:Button ID="btnSendAll" runat="server" Text="SendAll" style="float:left;" CommandName="sendAll" meta:resourcekey="btnSendAllResource1" OnClick="btnSendAll_Click"/>
            <asp:Button ID="btnFeedbackAll" runat="server" Text="Feed Back All" style="float:left;" CommandName="feedbackall" meta:resourcekey="btnFeedbackAllResource1" OnClientClick="ShowFeedbackDialogAll(); return false;"/>
            <asp:Button ID="btnRejectAll" runat="server" Text="Reject All" style="float:left;" CommandName="rejectall" meta:resourcekey="btnRejectAllResource1" OnClick="btnRejectAll_Click"/>
            <asp:Button ID="btnFeedbackAllPost" runat="server" ClientIDMode="Static" Text="Send" CommandName="feedbackall" OnClick="btnFeedbackAll_Click" meta:resourcekey="btnFeedBackResource1" style="display:none;"/>

             <div id="divMessage" style="border:1px solid black;overflow:auto; height:450px; width:100%;">
                <asp:Repeater ID="rptMessage" runat="server" ClientIDMode="Static" OnItemCommand="rptMessage_ItemCommand">
                    <HeaderTemplate>
                        <table id="tblMessage" border="1" style="padding:0;border-collapse:collapse;width:100%;">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th><asp:Label ID="lblSenderSchool" runat="server" Text="Sender School" meta:resourcekey="lblSenderSchoolResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblSender" runat="server" Text="Sender" meta:resourcekey="lblSenderResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblRecepientSchool" runat="server" Text="Recepient School" meta:resourcekey="lblRecepientSchoolResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblRecipient" runat="server" Text="Recepient" meta:resourcekey="lblRecipientResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblMessage" runat="server" Text="Message" meta:resourcekey="lblMessageResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblTranslation" runat="server" Text="Translation" meta:resourcekey="lblTranslationResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblSendDate" runat="server" Text="Send Date" meta:resourcekey="lblSendDateResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblFilteredWords" runat="server" Text="Filtered Words" meta:resourcekey="lblFilteredWordsResource1"></asp:Label></th>
                                    <th><asp:Label ID="lblSendReject" runat="server" Text="Send/Reject" meta:resourcekey="lblSendRejectResource1"></asp:Label>
<%--                                        <asp:Button ID="btnSendAll" runat="server" Text="SendAll" style="float:right;" CommandName="sendAll" meta:resourcekey="btnSendAllResource1" OnClick="btnSendAll_Click"/>
                                        <asp:Button ID="btnFeedbackAll" runat="server" Text="Feed Back All" style="float:right;" CommandName="feedbackall" meta:resourcekey="btnFeedbackAllResource1" OnClientClick="ShowFeedbackDialogAll(); return false;"/>
                                        <asp:Button ID="btnRejectAll" runat="server" Text="Reject All" style="float:right;" CommandName="rejectall" meta:resourcekey="btnRejectAllResource1" OnClick="btnRejectAll_Click"/>
                                        <asp:Button ID="btnFeedbackAllPost" runat="server" ClientIDMode="Static" Text="Send" CommandName="feedbackall" OnClick="btnFeedbackAll_Click" meta:resourcekey="btnFeedBackResource1" style="display:none;"/>--%>
                                    </th>
                                </tr>
                            </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <asp:Label ID="lblUserMailID" runat="server" Text='<%# Eval("UserMailID") %>' style="display:none;" meta:resourcekey="lblSenderResource2"></asp:Label>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkSelectRow" runat="server" onclick="unCheckSelectAll(this);"></asp:CheckBox>
                            </td>
                            <td>
                                <asp:Label ID="lblSenderSchool" runat="server" Text='<%# Eval("SenderSchool") %>' meta:resourcekey="lblSenderResource2"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblSender" runat="server" Text='<%# Eval("Sender") %>' meta:resourcekey="lblSenderResource2"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("RecepientSchool") %>' meta:resourcekey="Label1Resource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Recepient") %>' meta:resourcekey="Label1Resource1"></asp:Label>
                            </td>
                            <td>
                                <span class="<%# Eval("CssClass") %>" style="width:200px;"><%# Server.HtmlDecode(Eval("NativeLanguageMessage").ToString() )%></span>
                            </td>
                            <td>
                                <span class="bubble1" style="width:200px;"><%# Server.HtmlDecode( Eval("LearningLanguageMessage").ToString() )%></span>
                            </td>
                            <td>
                                <asp:Label ID="lblSendDatevalue" runat="server" Text='<%# Eval("CreateDate") %>' meta:resourcekey="lblSendDatevalueResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblFilterdWords" runat="server" Text='<%# Eval("FilteredWords") %>' meta:resourcekey="lblFilterdWordsResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Button ID="btnFeedback" runat="server" Text="Send" meta:resourcekey="btnFeedBackResource1" OnClientClick="ShowFeedbackDialog(); return false;" />
                                <asp:Button ID="btnFeedbackPost" runat="server" ClientIDMode="Static" Text="Send" CommandName="feedback" CommandArgument='<%# Eval("UserMailID") %>' meta:resourcekey="btnFeedBackResource1" style="display:none;"/>
                                <asp:Button ID="btnSend" runat="server" Text="Send" CommandName="send" CommandArgument='<%# Eval("UserMailID") %>' meta:resourcekey="btnSendResource1"/>
                                <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="reject" CommandArgument='<%# Eval("UserMailID") %>' meta:resourcekey="btnRejectResource1"/>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div id="divFeedbackDialog" style="display:none;">
                <asp:TextBox ID="txtFeedbackMessage" runat="server" ClientIDMode="Static" TextMode="MultiLine" Height="150px" MaxLength="250" Width="260px"></asp:TextBox>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
