<%@ Page Title="" Language="C#" MasterPageFile="~/Master/AdminMaster.Master" AutoEventWireup="true" CodeBehind="SchedulerViewer.aspx.cs" Inherits="Language.Discovery.Admin.SchedulerViewer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div style="width:100%;border:1px solid black;text-align:center;">
        <asp:Label ID="lblTitle" runat="server" Text="Talk  Matching Settings" meta:resourcekey="lblTitleResource1"></asp:Label>
    </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <script src="scripts/moment.js"></script>
    <script src="scripts/evol-colorpicker.min.js">https://mycwt.sharepoint.com/sites/ProjectOnline/default.aspx</script>
    <link href="css/evol-colorpicker.min.css" rel="stylesheet" />
    <style>
        .commandfield{
            cursor:pointer;
        }
        .colorComment{
            float: left;
            width: 97px;
            height: 14px;
            margin-right:5px;
            margin-left:5px;
        }
        .colorPicker{
            display:none;
        }
        .evo-colorind{
            width:35px;
            float:left;
            margin-right: 5px;
        }
        .evo-cp-wrap{
            width:auto !important;
        }
        .evo-pop{
            top: 88px;
        }
        .verticalColumnBorder{
            border-left: 2px solid black;
        }
    </style>
     <script>
        function InitializeDate() {
            $("#txtStartDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                numberOfMonths: 1,
                defaultDate: "-1w",
                onClose: function (selectedDate) {
                    $("#txtEndDate").datepicker("option", "minDate", selectedDate);
                }
            });
            //$("#txtStartDate").datepicker("setDate", "-1w");
            $("#txtEndDate").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                numberOfMonths: 1,
                defaultDate: "+3w",
                onClose: function (selectedDate) {
                    $("#txtStartDate").datepicker("option", "maxDate", selectedDate);
                }
            });
            //$("#txtEndDate").datepicker("setDate", "+3w");

          
         }

         function setupDialog(title) {
             $("#editDialog").dialog({
                 modal: true,
                 autoOpen: false,
                 title: title,
                 width: 500,
                 height: 300,
                 open: function (event, ui) {
                     $('#txtUserNameDialog').focusout(function () {
                         getUserInformation($(this).val(), 'txtUserSessionTimeDialog');
                     });
                     $('#txtPartnerDialog').focusout(function () {
                         getUserInformation($(this).val(), 'txtPartnerSessionTimeDialog');
                     });
                 },
                 close: function (event, ui) {
                    $('#hdnScheduleIdDialog').val("");
                    $('#txtUserNameDialog').val("");
                    $('#txtPartnerDialog').val("");
                    $('#txtDateTime').val("");
                     $('#ddlTime').val(0);
                     $('#txtUserSessionTimeDialog').val(0);
                     $('#txtPartnerSessionTimeDialog').val(0);
                 },
                 buttons: {
                     "Book": function () {
                         $('#hdnBook').val("book");
                         Save(this);
                     },
                     "Save": function () {
                         Save(this);
                         //var dialog = this;
                         //$('#hdnScheduleFinalId').val($('#hdnScheduleIdDialog').val());
                         //$('#hdnFinalSchedule').val($('#txtDateTime').val() + " " + $('#ddlTime').val());
                         //$('#hdnFinalUserName').val($('#txtUserNameDialog').val());
                         //$('#hdnFinalPartnerName').val($('#txtPartnerDialog').val());
                         //$('#hdnFinalUserTime').val($('#txtUserSessionTimeDialog').val());
                         //$('#hdnFinalPartnerTime').val($('#txtPartnerSessionTimeDialog').val() == "" ? "0" : $('#txtPartnerSessionTimeDialog').val());

                         //if ($('#txtUserNameDialog').val() != "" && $('#txtUserNameDialog').val() == $('#txtPartnerDialog').val()) {
                         //    $('#lblError').text("User and partner cannot be the same.");
                         //    $('#lblError').show();
                         //    return;
                         //}
                         //if ($('#txtDateTime').val().trim() == "") {
                         //    $('#lblError').text("Schedule is required.");
                         //    $('#lblError').show();
                         //    return;
                         //}
                         //if ($('#txtUserNameDialog').val().trim() == "") {
                         //    $('#lblError').text("User is required.");
                         //    $('#lblError').show();
                         //    return;
                         //}

                         //var json = { Type: 'student', username: $('#hdnFinalUserName').val(), partner: $('#hdnFinalPartnerName').val() };
                         //$.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                         //    var obj = $.parseJSON(data)
                         //    if (obj.Status == "True") {
                         //        $('#hdnScheduleIdDialog').val("");
                         //        $('#txtUserNameDialog').val("");
                         //        $('#txtPartnerDialog').val("");
                         //        $('#txtDateTime').val("");
                         //        $('#ddlTime').val(0);
                         //        $('#btnSaveDialog').click();
                         //        $(dialog).dialog("close");
                         //    }
                         //    else {
                         //        if (obj.UserId == 0) {
                         //            $('#lblError').text("User does not exists.");
                         //            $('#lblError').show();
                         //        }
                         //        if (obj.PartnerId == 0)
                         //        {
                         //            if (obj.UserId == 0)
                         //                $('#lblError').html($('#lblError').text() + "<BR/>Partner does not exists.");
                         //            else
                         //                $('#lblError').text("Partner does not exists.");
                         //            $('#lblError').show();
                         //        }
                         //        return;
                         //    }

                         //}).error(function (response) {
                         //    alert(respose.responseText)
                         //});

                        
                     },
                     Cancel: function () {
                         $(this).dialog("close");
                     }
                 }
             });
             $("#editDialog").dialog("open");
         }

         function Save(dialog) {
             $('#hdnScheduleFinalId').val($('#hdnScheduleIdDialog').val());
             $('#hdnFinalSchedule').val($('#txtDateTime').val() + " " + $('#ddlTime').val());
             $('#hdnFinalUserName').val($('#txtUserNameDialog').val());
             $('#hdnFinalPartnerName').val($('#txtPartnerDialog').val());
             $('#hdnFinalUserTime').val($('#txtUserSessionTimeDialog').val());
             $('#hdnFinalPartnerTime').val($('#txtPartnerSessionTimeDialog').val() == "" ? "0" : $('#txtPartnerSessionTimeDialog').val());

             if ($('#txtUserNameDialog').val() != "" && $('#txtUserNameDialog').val() == $('#txtPartnerDialog').val()) {
                 $('#lblError').text("User and partner cannot be the same.");
                 $('#lblError').show();
                 return;
             }
             if ($('#txtDateTime').val().trim() == "") {
                 $('#lblError').text("Schedule is required.");
                 $('#lblError').show();
                 return;
             }
             if ($('#txtUserNameDialog').val().trim() == "") {
                 $('#lblError').text("User is required.");
                 $('#lblError').show();
                 return;
             }

             var json = { Type: 'student', username: $('#hdnFinalUserName').val(), partner: $('#hdnFinalPartnerName').val() };
             $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                 var obj = $.parseJSON(data)
                 if (obj.Status == "True") {
                     $('#hdnScheduleIdDialog').val("");
                     $('#txtUserNameDialog').val("");
                     $('#txtPartnerDialog').val("");
                     $('#txtDateTime').val("");
                     $('#ddlTime').val(0);
                     $('#btnSaveDialog').click();
                     $(dialog).dialog("close");
                 }
                 else {
                     if (obj.UserId == 0) {
                         $('#lblError').text("User does not exists.");
                         $('#lblError').show();
                     }
                     if (obj.PartnerId == 0) {
                         if (obj.UserId == 0)
                             $('#lblError').html($('#lblError').text() + "<BR/>Partner does not exists.");
                         else
                             $('#lblError').text("Partner does not exists.");
                         $('#lblError').show();
                     }
                     return;
                 }

             }).error(function (response) {
                 alert(respose.responseText)
             });
         }

         function getUserInformation(name, sessiontimeid) {
              var json = { Type: 'getstudenttime', username: name};
                         $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                             var obj = $.parseJSON(data)
                             if (obj.Status == "True") {
                                 $('#' + sessiontimeid).val(obj.Time);
                                 $('#lblError').hide();
                             }
                             else {
                                     $('#' + sessiontimeid).val("");
                                     $('#lblError').text("User does not exists.");
                                     $('#lblError').show();
                                }
                                return;
                         }).error(function (response) {
                             alert(respose.responseText)
                         });

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

         function setupCommentDialog(color1, color2) {
             $("#dialog-comment").dialog({
                 resizable: true,
                 width: 500,
                 height: 500,
                 modal: true,
                 autoOpen: true,
                 open: function () {

                     color1 = (color1 == undefined || color1 == "" ? "#000000" : color1);
                     color2 = (color2 == undefined || color2 == ""  ? "#000000" : color2);
                     $('.main').colorpicker({ showOn: 'button', color: rgbToHex(color1) });
                     $('.partner').colorpicker({ showOn: 'button', color: rgbToHex(color2) });
                     hdnFinalCommentUserColor.value = rgbToHex(color1);
                     hdnFinalCommentPartnerColor.value = rgbToHex(color2);
                     $(".colorComment").on("change.color", function (event, color) {
                         if (event.currentTarget.className.indexOf("main") > -1) {
                             $("#hdnFinalCommentUserColor").val(color);
                         } else {
                             $("#hdnFinalCommentPartnerColor").val(color);
                         }
                     });

                 },
                 buttons: {
                     "Ok": function () {
                         $('#hdnFinalComment').val($('#txtCommentDialog').val());
                         $('#btnSaveComment').click();
                         $(this).dialog("close");
                     },
                     "Cancel": function () {
                         $(this).dialog("close");
                         $('#hdnFinalComment').val($('#txtCommentDialog').val());
                     }
                 }
             });
         }

         function InitializeDialog() {
             $("#txtDateTime").datepicker({
                 dateFormat: 'mm/dd/yy',
                 minDate: new Date(),
                 changeMonth: true,
                 numberOfMonths: 1
             });
             $('.commandfield').off('click').on("click", function (e) {
                 if ($(this)[0].value == "Edit") {
                     $('#hdnScheduleIdDialog').val($(this).closest('tr').find("#hdnScheduleId")[0].value);
                     $('#txtUserNameDialog').val($(this).closest('tr').find("#lblUserName")[0].innerHTML);
                     $('#txtPartnerDialog').val($(this).closest('tr').find("#lblPartnerName")[0].innerHTML);
                     $('#txtDateTime').val(moment($(this).closest('tr').find("#hdnSchedule")[0].value).format("MM/DD/YYYY"));
                     $('#ddlTime').val(moment($(this).closest('tr').find("#hdnSchedule")[0].value).format("HH:mm"));
                     $('#txtUserSessionTimeDialog').val($(this).closest('tr').find("#lblUserSessionTime")[0].innerHTML);
                     $('#txtPartnerSessionTimeDialog').val($(this).closest('tr').find("#lblPartnerSessionTime")[0].innerHTML);
                     setupDialog('Update Schedule');

                 } else if ($(this)[0].value == "Delete") {
                     $('#hdnScheduleFinalId').val($(this).closest('tr').find("#hdnScheduleId")[0].value);
                     confirmDelete();
                 } else if ($(this).data("text") == "Comment") {
                     $('#hdnScheduleFinalId').val($(this).closest('tr').find("#hdnScheduleId")[0].value);
                     $('#txtCommentDialog').html($(this).closest('tr').find("#lblComment")[0].innerHTML);
                     //$('.main').val($(this).closest('tr').find("#lblUserColor")[0].style["background-color"]);
                     //$('.partner').val($(this).closest('tr').find("#lblComment")[0].attributes["background-color"]);
                     setupCommentDialog($(this).closest('tr').find("#lblUserColor")[0].style["background-color"],
                         $(this).closest('tr').find("#lblPartnerColor")[0].style["background-color"]);
                     //confirmDelete();
                 }

                 e.stopPropagation();
                 e.preventDefault();
                 return false;
             });
             $('#btnNew').off('click').on("click", function () {
                 setupDialog('New Schedule');
             });
         }
         function rgbToHex(color) {
             color = "" + color;
             if (!color || color.indexOf("rgb") < 0) {
                 return;
             }

             if (color.charAt(0) == "#") {
                 return color;
             }

             var nums = /(.*?)rgb\((\d+),\s*(\d+),\s*(\d+)\)/i.exec(color),
                 r = parseInt(nums[2], 10).toString(16),
                 g = parseInt(nums[3], 10).toString(16),
                 b = parseInt(nums[4], 10).toString(16);

             return "#" + (
                 (r.length == 1 ? "0" + r : r) +
                 (g.length == 1 ? "0" + g : g) +
                 (b.length == 1 ? "0" + b : b)
             );
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
                    <asp:Button ID="btnShow" runat="server" Text="Show" OnClick="btnShow_Click" ValidationGroup="v"  meta:resourcekey="btnShowResource1" ClientIDMode="Static" />
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
                            GridLines="Horizontal" Height="300px" Width="100%"
                            EmptyDataText="No record to display." AutoGenerateColumns="False" 
                            ShowFooter="True" AllowCustomPaging="True"
                            BackColor="White" BorderColor="#336666" 
                            BorderWidth="3px" meta:resourcekey="grdResultResource1"
                            DataKeyNames="ScheduleId"
                            HorizontalAlign="Center"
                            >
                            <PagerSettings Mode="NumericFirstLast" />
                            <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small"/>
                            <FooterStyle BackColor="White" ForeColor="#333333"   Height="100%" />
                            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                            <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                            <Columns>
                                <asp:TemplateField  ShowHeader="False" meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnScheduleId" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ScheduleId").ToString() %>'  ClientIDMode="Static"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:TemplateField HeaderText="Schedule" ItemStyle-Width="150" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblScheduleJP" runat="server" Text='<%# Eval("UserSchedule") %>' ClientIDMode="Static"></asp:Label>
                                    <asp:HiddenField ID="hdnSchedule" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Schedule").ToString() %>'  ClientIDMode="Static"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User Name" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>' ClientIDMode="Static"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUserName" runat="server" Text='<%# Eval("UserName") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="GradeID" HtmlEncode="False" HeaderText="Grade" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Remaining Time" ItemStyle-Width="90" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserSessionTime" runat="server" Text='<%# Eval("UserSessionTime") %>' ClientIDMode="Static"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUserSessionTime" runat="server" Text='<%# Eval("UserSessionTime") %>' Width="90"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="IsUserConfirmed" HtmlEncode="False" HeaderText="Confirmed" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </asp:BoundField>
                            <asp:BoundField DataField="UserConfirmationDateTime" HtmlEncode="False" HeaderText="Date Confirmed" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </asp:BoundField>
                            <asp:BoundField DataField="PartnerSchedule" HtmlEncode="False" HeaderText="Partner Schedule" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="verticalColumnBorder" HeaderStyle-CssClass="verticalColumnBorder">
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Partner" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblPartnerName" runat="server" Text='<%# Eval("PartnerName") %>' ClientIDMode="Static"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPartnerName" runat="server" Text='<%# Eval("PartnerName") %>' Width="90"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PartnerGradeID" HtmlEncode="False" HeaderText="Grade" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Remaining Time" ItemStyle-Width="150" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblPartnerSessionTime" runat="server" Text='<%# Eval("PartnerSessionTime") %>' ClientIDMode="Static"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPartnerSessionTime" runat="server" Text='<%# Eval("PartnerSessionTime") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="IsPartnerConfirmed" HtmlEncode="False" HeaderText="Confirmed" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </asp:BoundField>
                            <asp:BoundField DataField="PartnerConfirmationDateTime" HtmlEncode="False" HeaderText="Date Confirmed" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                            </asp:BoundField>
                            <asp:BoundField DataField="ScheduleAU" HtmlEncode="False" HeaderText="AU Date/Time" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ItemStyle-CssClass="verticalColumnBorder">
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Comment" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="verticalColumnBorder" HeaderStyle-CssClass="verticalColumnBorder">
                                <ItemTemplate>
                                    <asp:Label ID="lblWithComment" style="display: block !important;text-overflow: ellipsis;white-space: nowrap;overflow: hidden;width: 84px;" runat="server" Text='<%# Eval("Comment") %>' ClientIDMode="Static"></asp:Label>
                                    <asp:Label ID="lblComment" style="display:none;" runat="server" Text='<%# Eval("Comment") %>' ClientIDMode="Static"></asp:Label>
                                    <asp:Label ID="lblUserColor" runat="server" data-text="Comment" CssClass="commandfield" ClientIDMode="Static" Width="30" BorderColor="silver" Height="15" BorderWidth="1" BorderStyle="Solid" BackColor= '<%# System.Drawing.ColorTranslator.FromHtml(Eval("UserColor").ToString())%>'></asp:Label>
                                    <asp:Label ID="lblPartnerColor" runat="server" data-text="Comment" CssClass="commandfield" ClientIDMode="Static" Width="30" BorderColor="silver" Height="15" BorderWidth="1" BorderStyle="Solid" BackColor='<%# System.Drawing.ColorTranslator.FromHtml(Eval("PartnerColor").ToString())%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Command" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" >
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" ClientIDMode="Static"   CssClass="commandfield" CausesValidation="false" OnClientClick="return false;" UseSubmitBehavior="false"/>
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" ClientIDMode="Static"  CssClass="commandfield" CausesValidation="false" OnClientClick="return false;" UseSubmitBehavior="false" /><br />
                                    <asp:Button ID="btnAddComment" runat="server" Text="Comment" data-text="Comment" ClientIDMode="Static"  CssClass="commandfield" CausesValidation="false" OnClientClick="return false;" UseSubmitBehavior="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

        


              <div id="editDialog" style="display: none">
            <table>
                <tr>
                    <td>
                        Date:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDateTime" runat="server" ClientIDMode="Static" Width="144" autocomplete="off"/>
                        <asp:DropDownList ID="ddlTime" runat="server" ClientIDMode="Static"></asp:DropDownList>
                    </td>
                    <td>Japan Time</td>
                </tr>
                <tr>
                    <td>
                        User:
                    </td>
                    <td>
                        <asp:HiddenField ID="hdnScheduleIdDialog" runat="server" ClientIDMode="Static"/>
                        <asp:TextBox ID="txtUserNameDialog" runat="server" ClientIDMode="Static"/>
                    </td>
                    <td>
                        Time:
                    </td>
                    <td>
                        <asp:TextBox TextMode="Number" ID="txtUserSessionTimeDialog" runat="server" ClientIDMode="Static" Width="50px" min="0"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        Partner:
                    </td>
                    <td>
                        <asp:TextBox ID="txtPartnerDialog" runat="server" ClientIDMode="Static"/>
                    </td>
                    <td>
                        Time:
                    </td>
                    <td>
                        <asp:TextBox TextMode="Number" ID="txtPartnerSessionTimeDialog" runat="server" ClientIDMode="Static" Width="50px" min="0" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span id="lblError" style="color:red;display:none;">Partner is the same as username.</span>
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
        <div id="dialog-comment" title="Comment" style="display:none;">
            <textarea id="txtCommentDialog" style="margin: 0px; width: 457px; height: 302px;"></textarea>
            <div>
                <input class="colorComment main" readonly="true" />
                <input class="colorComment partner" readonly="true" />
            </div>
            
        </div>
        <asp:Button ID="btnSaveDialog" runat="server" OnClick="btnSave_Click" ClientIDMode="Static" style="display:none;" />
        <asp:Button ID="btnDeleteDialog" runat="server" OnClick="btnDeleteDialog_Click" ClientIDMode="Static" style="display:none;" />
        <asp:Button ID="btnSaveComment" runat="server" OnClick="btnSaveComment_Click" ClientIDMode="Static" style="display:none;" />
        <asp:HiddenField ID="hdnScheduleFinalId" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnFinalSchedule" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnFinalUserName" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnFinalPartnerName" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnFinalUserTime" runat="server" ClientIDMode="Static" Value="0"/>
        <asp:HiddenField ID="hdnFinalPartnerTime" runat="server" ClientIDMode="Static" Value="0"/>
        <asp:HiddenField ID="hdnFinalComment" runat="server" ClientIDMode="Static" Value=""/>
        <asp:HiddenField ID="hdnFinalCommentUserColor" runat="server" ClientIDMode="Static" Value=""/>
        <asp:HiddenField ID="hdnFinalCommentPartnerColor" runat="server" ClientIDMode="Static" Value=""/>
        <asp:HiddenField ID="hdnBook" runat="server" ClientIDMode="Static" Value=""/>

           <%-- </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnSaveDialog" EventName="click" />
                    <asp:AsyncPostBackTrigger ControlID="btnDeleteDialog" EventName="click" />
                </Triggers>
    </asp:UpdatePanel>--%>

                </fieldset>


</asp:Content>
