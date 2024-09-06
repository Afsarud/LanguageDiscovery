<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ScheduleSettings.aspx.cs" Inherits="Language.Discovery.Admin.ScheduleSettings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Talk Calendar Settings" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
        <script src="scripts/moment.js"></script>
    <style>
        .col{
            width:25%;
            float:left;
        }
        .col label {
            display: inline-table;
        }
    </style>
     <script>

         String.prototype.format = String.prototype.stringformat = function () {
             var s = this,
                 i = arguments.length;

             while (i--) {
                 s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
             }
             return s;
         };

         $(function () {
             getAllTime();
         });
        function InitializeDate() {
            $("#txtStartDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                numberOfMonths: 1,
                onClose: function (selectedDate) {
                    $("#txtEndDate").datepicker("option", "minDate", selectedDate);
                }
            });
            $("#txtEndDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                numberOfMonths: 1,
                defaultDate: "+4w",
                onClose: function (selectedDate) {
                    $("#txtStartDate").datepicker("option", "maxDate", selectedDate);
                }
            });
          
         }

         function getAllTime() {
             var json = { Type: 'getalltime'};
             $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                 var obj = $.parseJSON(data)
                 if (obj) {
                     var count = 0;
                     $('.col').empty();
                     var cssclass = "";
                     obj.forEach(item => {
                         count = count + 1;
                         if (count <= 16) {
                             cssclass = ".col1";
                         }
                         else if (count > 16 && count <= 32) {
                             cssclass = ".col2";
                         }
                         else if (count > 32 && count <= 48) {
                             cssclass = ".col3";
                         }
                         else {
                             cssclass = ".col4";
                         }
                         $(cssclass).append('<label for="chk{0}"><input type="checkbox" id="chk{0}" class="chk" value="{0}"/>{1}</label>'.stringformat(item.TimeId, item.TimeSchedule));
                         
                     });
                 }

             }).error(function (response) {
                 alert(respose.responseText)
             });
         }

         function getExistingTime() {
             $('.chk').prop('checked', false);
             if ($('#txtDateTime').val() == "") {
                 return;
             }
             
             var json = { Type: 'getexistingtime', date: $('#txtDateTime').val()};
             $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                 var obj = $.parseJSON(data)
                 if (obj) {
                     obj.forEach(item => {
                         var ids = item.TimeIds.split(',');
                         ids.forEach(id => {
                             $('#chk' + id).prop('checked', true);
                         });
                         
                     });
                 }

             }).error(function (response) {
                 alert(respose.responseText)
             });
         }

         function setupDialog(title) {
             $("#editDialog").dialog({
                 modal: true,
                 autoOpen: false,
                 title: title,
                 width: 450,
                 height: 540,
                 buttons: {
                     "Save": function () {

                         var dialog = this;
                         //$('#hdnScheduleFinalId').val($('#hdnScheduleIdDialog').val());
                         //$('#hdnFinalSchedule').val($('#txtDateTime').val() + " " + $('#ddlTime').val());
                         //$('#hdnFinalUserName').val($('#txtUserNameDialog').val());
                         var checkedVals = $('.chk:checkbox:checked').map(function () {
                             return this.value;
                         }).get();

                         $('#hdnTimeIdsDialog').val(checkedVals.join(","));
                         $('#hdnDate').val($('#txtDateTime').val());

                         if ($('#txtDateTime').val().trim() == "") {
                             $('#lblError').text("Date is required.");
                             $('#lblError').show();
                             return;
                         }
                         $('#btnSaveDialog').click();
                        
                     },
                     Cancel: function () {
                         $(this).dialog("close");
                     }
                 }
             });
             $("#editDialog").dialog("open");
         }

         function confirmDelete() {
             $("#dialog-confirm").dialog({
                 resizable: false,
                 height: "auto",
                 width: 400,
                 modal: true,
                 buttons: {
                     "Ok": function () {
                         $('#btnDeleteDialog').click();
                         $(this).dialog("close");
                     },
                     Cancel: function () {
                         $(this).dialog("close");
                     }
                 }
             });
         }

         function transactionComplete() {
             $("#divTransactionComplete").dialog({
                 resizable: false,
                 height: "auto",
                 width: 400,
                 modal: true,
                 autoOpen: true,
                 buttons: {
                     "Ok": function () {
                         $(this).dialog("close");
                     }
                 }
             });
         }

         
         function isUserExist(user, partner) {
             var deferred = $.Deferred();

                 var json = { Type: 'student', username: user };
                 $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                     var obj = $.parseJSON(data)
                     if (obj.Status == "True") {
                         deferred.resolve();
                         
                     }
                     else {
                         deferred.reject();
                     }

                 }).error(function (response) {
                     deferred.reject();
                     alert(respose.responseText)
                 });
             return deferred.promise();;
             }
             

        $(function () {
            
            InitializeDate();
            InitializeDialog();
        });

         function InitializeDialog() {
             $("#txtDateTime").datepicker({
                 dateFormat: 'mm/dd/yy',
                 minDate: new Date(),
                 changeMonth: true,
                 numberOfMonths: 1,
                 onClose: function (selectedDate) {
                     var dt = moment(selectedDate);
                     var day = dt.format('dddd');
                     $('#lblDayOfWeek').text(day);
                     getExistingTime();
                 }
             });
             $('.commandfield').off('click').on("click", function (e) {
                 if ($(this)[0].value == "Edit") {
                     $('#txtDateTime').val(moment(new Date($(this).closest('tr').find("#lblDate")[0].innerText)).format("MM/DD/YYYY"));
                     $('#hdnTimeIdsDialog').val($(this).closest('tr').find("#hdnTimeIds")[0].value);
                     var ids = $('#hdnTimeIdsDialog').val().split(',');
                     $('.chk').prop('checked', false);
                     if (ids.length > 0) {
                         ids.forEach(x => {
                             $('#chk' + x).prop('checked', true);
                         });
                     }

                     setupDialog('Update Schedule');

                 } else if ($(this)[0].value == "Delete") {
                     $('#hdnDate').val($(this).closest('tr').find("#lblDate")[0].innerText);
                     confirmDelete();
                 }

                 e.stopPropagation();
                 e.preventDefault();
                 return false;
             });
             $('#btnNew').off('click').on("click", function () {
                 $('#txtDateTime').val("");
                 $('.chk').prop('checked', false);
                 setupDialog('New Schedule');
             });
         }

    </script>
 <fieldset>
        <legend>
            <asp:Label ID="lblCriteriaLegend" runat="server" Text="Criteria" meta:resourcekey="lblCriteriaLegendResource1"></asp:Label></legend>
        <table>
            <tr>
                <td><asp:Label ID="Label2" runat="server" meta:resourcekey="Label2Resource1">From</asp:Label></td>
                <td><asp:TextBox ID="txtStartDate" runat="server" ClientIDMode="Static" meta:resourcekey="txtStartDateResource1" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ErrorMessage="Start Date is required" ControlToValidate="txtStartDate" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvStartDateResource1">*</asp:RequiredFieldValidator>
                </td>   
                <td><asp:Label ID="Label3" runat="server" meta:resourcekey="Label3Resource1">To</asp:Label></td>
                <td><asp:TextBox ID="txtEndDate" runat="server" ClientIDMode="Static" meta:resourcekey="txtEndDateResource1" autocomplete="off"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ErrorMessage="End Date is required" ControlToValidate="txtEndDate" ValidationGroup="v" ForeColor="Red" meta:resourcekey="rfvEndDateResource1">*</asp:RequiredFieldValidator>
                </td>   
                <td>
                    <asp:Button ID="btnShow" runat="server" Text="Show"  ValidationGroup="v" OnClick="btnShow_Click"  meta:resourcekey="btnShowResource1" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="v" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" HeaderText="Please input From and To dates." ForeColor="Red" meta:resourcekey="ValidationSummary1Resource1"/>
                </td>
            </tr>
        </table>
      </fieldset>
   <fieldset>
        <asp:Label ID="lblMessage" runat="server" Visible="False" EnableViewState="False" Text="Action Error." meta:resourcekey="lblMessageResource1"></asp:Label><br />
        <legend>Details</legend>
            <asp:Button ID="btnNew" runat="server" Text="New Schedule" ClientIDMode="Static" CausesValidation="false" OnClientClick="return false;" UseSubmitBehavior="false"/>
<%--            <asp:UpdatePanel ID="updateResult" runat="server" UpdateMode="Conditional">
                <ContentTemplate>--%>

            <asp:GridView ID="grdResult" runat="server" 
                            GridLines="Horizontal" Width="80%" Height="300px"
                            EmptyDataText="No record to display." AutoGenerateColumns="False" 
                            ShowFooter="True" AllowCustomPaging="True"
                            BackColor="White" BorderColor="#336666" 
                            BorderWidth="3px" meta:resourcekey="grdResultResource1"
                            DataKeyNames="CustomDate"
                            >
                            <PagerSettings Mode="NumericFirstLast" />
                            <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small" HorizontalAlign="Left"/>
                            <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                            
                            <Columns>
                            <asp:TemplateField HeaderText="Date" ItemStyle-Width="150" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblDate" runat="server" Text='<%# Convert.ToDateTime(Eval("CustomDate")).ToString("MM/dd/yyyy")%>' ClientIDMode="Static"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Day" ItemStyle-Width="150"  ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblDay" runat="server" Text='<%# Eval("Day") %>' ClientIDMode="Static"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Times(JP)" ItemStyle-Width="150"  ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblScheduleJP" style="display:table-caption;" runat="server" Text='<%# Eval("TimeSchedule") %>' ClientIDMode="Static"></asp:Label>
                                    <asp:HiddenField ID="hdnTimeIds" runat="server" Value='<%# Eval("TimeIds") %>' ClientIDMode="Static"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ScheduleAU" HtmlEncode="False" HeaderText="AU Date/Time" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ItemStyle-CssClass="verticalColumnBorder">
                            </asp:BoundField>
                            <asp:BoundField DataField="ScheduleUK" HtmlEncode="False" HeaderText="UK Date/Time" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ItemStyle-CssClass="verticalColumnBorder">
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Command" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" ClientIDMode="Static"   CssClass="commandfield" CausesValidation="false" OnClientClick="return false;" UseSubmitBehavior="false"/>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" ClientIDMode="Static"  CssClass="commandfield" CausesValidation="false" OnClientClick="return false;" UseSubmitBehavior="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

        


              <div id="editDialog" style="display: none">
            <table>
                <tr>
                    <td style="width:23%;">
                        Date:
                    </td>
                    <td style="width:42%;">
                        <asp:TextBox ID="txtDateTime" runat="server" ClientIDMode="Static" Width="144" autocomplete="off"/>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lblDayOfWeek" ClientIDMode="Static"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        Time(Japan Time): 
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <div class="col col1">
                        </div>
                        <div class="col col2">
                        </div>
                        <div class="col col3">
                        </div>
                        <div class="col col4">

                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span id="lblError" style="color:red;display:none;">Please select time.</span>
                    </td>
                </tr>
            </table>
        </div>
        <div id="dialog-confirm" title="Delete Schedule" style="display:none;">
          <p><span style="float:left; margin:12px 12px 20px 0;"></span>These schedule will be permanently deleted and cannot be recovered. Are you sure?</p>
        </div>
        <div id="divTransactionComplete" title="Success" style="display:none;">
          <p><span style="float:left; margin:12px 12px 20px 0;"></span>Transaction successfull.</p>
        </div>
        <asp:Button ID="btnSaveDialog" runat="server"  ClientIDMode="Static" style="display:none;" OnClick="btnSaveDialog_Click" />
        <asp:Button ID="btnDeleteDialog" runat="server"  ClientIDMode="Static" style="display:none;" OnClick="btnDeleteDialog_Click" />
        <asp:HiddenField ID="hdnDate" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnTimeIdsDialog" runat="server" ClientIDMode="Static"/>
    </fieldset>
</asp:Content>
