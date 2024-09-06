<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="MessagePoll.aspx.cs" Inherits="Language.Discovery.Admin.MessagePoll" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
        <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Message Pool" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
        <script>
            $(function () {
                $(".chkSelectMessage :input").prop("checked", false);
                $("#btnSend").css("display", "inline");
            });
            function DisableSendButton() {
                $("#btnSend").css("display", "none");
            }
    </script>
    <table>
        <tr>
            <td style="vertical-align:top;width:50%;">
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:HiddenField ID="HiddenField1" runat="server" meta:resourcekey="hdnAllResource1" />
                              <fieldset class="fieldset">
                                  <legend><asp:Label ID="Label1" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                                  <asp:Label ID="Label2" runat="server" Text="School" meta:resourcekey="lblSearchSchoolLabelResource1"></asp:Label>
                                  <asp:DropDownList ID="ddlSchoolList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSchoolList_SelectedIndexChanged"></asp:DropDownList>
                  
                               </fieldset>
                            <br />
                             <div id="divMessage" style="border:1px solid black;overflow:scroll; height:600px; width:100%;">
                                <asp:Repeater ID="rptMessage" runat="server" ClientIDMode="Static" OnItemCommand="rptMessage_ItemCommand">
                                    <HeaderTemplate>
                                        <table id="tblMessage" border="1" style="padding:0;border-collapse:collapse;width:100%;">
                                            <thead>
                                                <tr>
                                                    <td></td>
                                                    <td><asp:Label ID="lblSenderSchool" runat="server" Text="Sender School" meta:resourcekey="lblSenderSchoolResource1"></asp:Label></td>
                                                    <td><asp:Label ID="lblUserID" runat="server" Text="User ID" meta:resourcekey="lblUserIDResource1"></asp:Label></td>
                                                    <td><asp:Label ID="lblSender" runat="server" Text="Sender" meta:resourcekey="lblSenderResource1"></asp:Label></td>
                                                    <td><asp:Label ID="lblMessage" runat="server" Text="Message" meta:resourcekey="lblMessageResource1"></asp:Label></td>
                                                    <td><asp:Label ID="lblTranslation" runat="server" Text="Translation" meta:resourcekey="lblTranslationResource1"></asp:Label></td>
                                                    <td><asp:Label ID="lblSendDate" runat="server" Text="Send Date" meta:resourcekey="lblSendDateResource1"></asp:Label></td>
                                                    </td>
                                                </tr>
                                            </thead>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <asp:CheckBox ID="chkSelectMessage" runat="server" CssClass="chkSelectMessage" data-userid='<%# Eval("SenderID") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSenderSchool" runat="server" Text='<%# Eval("SenderSchool") %>' meta:resourcekey="lblSenderResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblUserID" runat="server" Text='<%# Eval("UserName") %>' meta:resourcekey="lblUserIDResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSender" runat="server" Text='<%# Eval("Sender") %>' meta:resourcekey="lblSenderResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblNativeLanguageMessage" runat="server" CssClass='<%# Eval("CssClass") %>' style="width:200px;" Text='<%# Server.HtmlDecode(Eval("NativeLanguageMessage").ToString() )%>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblLearningLanguageMessage" runat="server" CssClass="bubble1" style="width:200px;" Text='<%# Server.HtmlDecode( Eval("LearningLanguageMessage").ToString() )%>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSendDatevalue" runat="server" Text='<%# Eval("CreateDate") %>' meta:resourcekey="lblSendDatevalueResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="hdnKeyword" runat="server" Value='<%# Eval("Keyword") %>'></asp:HiddenField>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
            </td>
            <td style="vertical-align:top;width:50%;">
                <asp:UpdatePanel ID="upSearch" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                       <fieldset class="fieldset">
                           <asp:HiddenField ID="hdnSelectSchool" runat="server" meta:resourcekey="hdnSelectSchoolResource1" />
                           <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
                            <asp:HiddenField ID="hdnUserHeaderID" runat="server" />
                            <legend><asp:Label ID="lblSearchLegend" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                             <table>
                                <tr>
                                    <td><asp:Label ID="lblSearchSchoolLabel" runat="server" meta:resourcekey="lblSearchSchoolLabelResource1">School</asp:Label></td>
                                    <td><asp:DropDownList ID="ddlSearchSchool" runat="server" meta:resourcekey="ddlSearchSchoolResource1" OnSelectedIndexChanged="ddlSearchSchool_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList></td>
                                </tr>
                            </table>
        
                            <asp:GridView ID="grdResult" runat="server" 
                                    GridLines="Horizontal"  PageSize="15"
                                    EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                                    onpageindexchanging="grdResult_PageIndexChanging"
                                    ShowFooter="True" 
                                    BackColor="White" BorderColor="#336666" AllowCustomPaging="True"
                                    BorderWidth="3px" meta:resourcekey="grdResultResource1">
                                    <PagerSettings Mode="NumericFirstLast" />
                                    <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                                    <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                                    <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                                    <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectUser" runat="server" data-userid='<%# DataBinder.Eval(Container.DataItem,"UserID").ToString() %>' /> 
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="UserName" HeaderText="User ID" meta:resourcekey="BoundFieldResource1" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FirstName" HeaderText="First Name" meta:resourcekey="BoundFieldResource1" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="UserName" HeaderText="User ID" meta:resourcekey="BoundFieldResource2" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CountryName" HeaderText="Country Name" meta:resourcekey="BoundFieldResource4" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Name1" HeaderText="School Name" meta:resourcekey="BoundFieldResource6" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CreateDate" HeaderText="Date Created" meta:resourcekey="BoundFieldResource6" >
                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField  ShowHeader="False" meta:resourcekey="TemplateFieldResource1" >
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnSearchUserHeaderID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"UserID").ToString() %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                        </fieldset>
                    </ContentTemplate>  
                </asp:UpdatePanel>
                
            </td>
        </tr>
        <tr>
            <td style="text-align:center;" colspan="2">
                <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btnSend_Click" Width="300px" ClientIDMode="Static" OnClientClick="DisableSendButton(); return true;" />
            </td>
        </tr>
    </table>

</asp:Content>