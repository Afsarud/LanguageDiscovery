<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="SentMail.aspx.cs" Inherits="Language.Discovery.Admin.SentMail" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
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
        .gridView
        {
          table-layout:fixed;
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
                  <asp:Label ID="lblSearchSender" runat="server" Text="Sender" meta:resourcekey="lblSearchSenderResource1"></asp:Label>
                  <asp:TextBox ID="txtSender" runat="server" meta:resourcekey="txtSenderResource1"></asp:TextBox>
                  <asp:Label ID="lblSearchRecepient" runat="server" Text="Recepient" meta:resourcekey="lblSearchRecepientResource1"></asp:Label>
                  <asp:TextBox ID="txtRecepient" runat="server" meta:resourcekey="txtRecepientResource1"></asp:TextBox>
                  <br />
                  <asp:Label ID="lblStartDateSearch" runat="server" Text="Start Date" meta:resourcekey="lblStartDateSearchResource1"></asp:Label>
                  <asp:TextBox ID="txtStartDateSearch" runat="server" ClientIDMode="Static" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate = "txtStartDateSearch" ValidationGroup="s" ForeColor="Red"
                    ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
                    runat="server" ErrorMessage="Invalid Start Date format. Valid Date Format dd/MM/yyyy" meta:resourcekey="RegularExpressionValidator3Resource1">*
                    </asp:RegularExpressionValidator>

                  <asp:Label ID="lblEndDateSearch" runat="server" Text="End Date" meta:resourcekey="lblEndDateSearchResource1"></asp:Label>
                  <asp:TextBox ID="txtEndDateSearch" runat="server" ClientIDMode="Static" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate = "txtEndDateSearch" ValidationGroup="s" ForeColor="Red"
                    ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
                    runat="server" ErrorMessage="Invalid Start Date format. Valid Date Format dd/MM/yyyy" meta:resourcekey="RegularExpressionValidator3Resource1">*
                    </asp:RegularExpressionValidator>
                  <asp:Button ID="btnSearch" runat="server" Text="Search" meta:resourcekey="btnSearchResource1" OnClick="btnSearch_Click"/>
               </fieldset>
            <br />
                 <asp:GridView ID="grdResult" runat="server" Width="100%" ClientIDMode="Static" 
                        GridLines="Horizontal" Height="300px"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" AllowPaging="True" 
                        onpageindexchanging="grdResult_PageIndexChanging"
                        onrowdatabound="grdResult_RowDataBound" 
                        ShowFooter="True" 
                        BackColor="White" BorderColor="#336666" AllowCustomPaging="True"
                        BorderWidth="3px" meta:resourcekey="grdResultResource1" DataKeyNames="UserMailID" PageSize="10">
                        <PagerSettings Mode="NumericFirstLast" />
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                        <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkDeleteAll" runat="server" ClientIDMode="Static" onclick="checkAll(this);" />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" OnClientClick="return ConfirmDelete();" meta:resourcekey="btnDeleteResource1" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkDelete" onclick="unCheckSelectAll(this);" runat="server" meta:resourcekey="chkDeleteResource1" ClientIDMode="Static" />
                                    <asp:HiddenField ID="hdnUserMailID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"UserMailID").ToString() %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Width="10px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="SenderSchool" HeaderText="Sender School" meta:resourcekey="lblSenderSchoolResource1">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RecepientSchool" HeaderText="Recepient School" meta:resourcekey="lblRecepientSchoolResource" >
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Sender" HeaderText="Sender Name" meta:resourcekey="lblSenderNameResource1">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Recepient" HeaderText="Recepient Name" meta:resourcekey="lblRecepientNameResource1">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NativeLanguageMessage" HeaderText="Mesage" meta:resourcekey="lblMessageResource1" HtmlEncode="False">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                            <ItemStyle Width="100px" CssClass="col" Wrap="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LearningLanguageMessage" HeaderText="Translation" meta:resourcekey="lblTranslationResource1" HtmlEncode="False">
                            <ControlStyle Width="100px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="100px" />
                            </asp:BoundField >
                            <asp:BoundField DataField="CreateDate" HeaderText="Send Date" meta:resourcekey="lblSendDateResource1">
                            <ControlStyle Width="50px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FilteredWords" HeaderText="Filtered Words" meta:resourcekey="lblFilteredWordsResource1">
                            <ControlStyle Width="50px" />
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
            
            
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
