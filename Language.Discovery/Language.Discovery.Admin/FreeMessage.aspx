<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="FreeMessage.aspx.cs" Inherits="Language.Discovery.Admin.FreeMessage" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Sent Mails" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <style>
        html , body{height:100%;}
         .gridView
         {
             table-layout:fixed;
             height: 100%;
         }
        .col
        {
            word-wrap:break-word;
        }
        .usermailidclass {
            display:none;
        }
    </style>
    <%--   <div>
        <table>
            <tr>
                <td><asp:Label ID="lblUser" runat="server" Text="User"></asp:Label></td>
                <td>

                </td>
            </tr>
        </table>
    </div>--%>
    <script>
        function InitializeDate() {
            $("#txtStartDateSearch").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1,
                onClose: function (selectedDate) {
                    $("#txtEndDateSearch").datepicker("option", "minDate", selectedDate);
                }
            });
            $("#txtEndDateSearch").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1,
                onClose: function (selectedDate) {
                    $("#txtStartDateSearch").datepicker("option", "maxDate", selectedDate);
                }
            });
        }
       

        function checkAll(selectAllCheckbox) {
            //get all checkbox and select it
            $('td :checkbox', '#grdResult').prop("checked", selectAllCheckbox.checked);
        }
        function unCheckSelectAll(selectCheckbox) {
            //if any item is unchecked, uncheck header checkbox as also
            if (!selectCheckbox.checked)
                $('th :checkbox', '#grdResult').prop("checked", false);
        }

        function ConfirmDelete() {
            var checkedCheckboxes = $("#grdResult input[id*='chkDelete']:checkbox:checked").size();
            var result =  false;
            if (checkedCheckboxes > 0)
                result = confirm("Are you sure you want to delete this message?");
            else
                alert("Nothing to delete.");

            return result;
        }

    </script>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:HiddenField ID="hdnAll" runat="server" meta:resourcekey="hdnAllResource1" />
              <fieldset class="fieldset">
                  <legend><asp:Label ID="lblSearchLegend" runat="server" Text="Search" meta:resourcekey="lblSearchLegendResource1"></asp:Label></legend>
                  <asp:Label ID="lblSearchSchoolLabel" runat="server" Text="School" meta:resourcekey="lblSearchSchoolLabelResource1"></asp:Label>
                  <asp:DropDownList ID="ddlSchoolList" runat="server" OnSelectedIndexChanged="ddlSchoolList_SelectedIndexChanged" meta:resourcekey="ddlSchoolListResource1"></asp:DropDownList>
                  <asp:Label ID="lblUserName" runat="server" Text="Username" meta:resourcekey="lblUserNameLabelResource1"></asp:Label>
                  <asp:TextBox runat="server" id="txtUserName" Width="200px" MaxLength="50"></asp:TextBox>
                  <asp:Label ID="lblFirstname" runat="server" Text="First Name" meta:resourcekey="lblFirstnameLabelResource1"></asp:Label>
                  <asp:TextBox runat="server" id="txtFirstName" Width="200px" MaxLength="50"></asp:TextBox>
                  <asp:Label ID="lblLastName" runat="server" Text="Last Name" meta:resourcekey="lblLastNameLabelResource1"></asp:Label>
                  <asp:TextBox runat="server" id="txtLastName" Width="200px" MaxLength="50"></asp:TextBox>
                  <asp:Button ID="btnSearch" runat="server" Text="Search" meta:resourcekey="btnSearchResource1" OnClick="btnSearch_Click"/>
               </fieldset>
            <br />
                 <asp:GridView ID="grdResult" runat="server" Width="100%" ClientIDMode="Static" 
                        GridLines="Horizontal" Height="100%"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                        onpageindexchanging="grdResult_PageIndexChanging"
                        onrowdatabound="grdResult_RowDataBound" 
                        ShowFooter="True" 
                        BackColor="White" BorderColor="#336666" AllowCustomPaging="True"
                        BorderWidth="3px" meta:resourcekey="grdResultResource1" DataKeyNames="FreeMessageID" PageSize="30">
                        <PagerSettings Mode="NumericFirstLast" />
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Sender" HeaderText="Sender Name" meta:resourcekey="lblSenderNameResource1">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FreeMessageText1" HeaderText="Mesage" meta:resourcekey="lblMessageResource1" HtmlEncode="False">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                            <ItemStyle Width="100px" CssClass="col" Wrap="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FreeMessageText2" HeaderText="Translation" meta:resourcekey="lblTranslationResource1" HtmlEncode="False">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="100px" />
                            </asp:BoundField >
                            <asp:BoundField DataField="CreateDate" HeaderText="Send Date" meta:resourcekey="lblSendDateResource1">
                            <ControlStyle Width="50px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
