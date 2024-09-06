<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Scheduler.aspx.cs" Inherits="Language.Discovery.Student.Scheduler" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #schedulerContainer{
            width: 100%;
            height: 90vh;
            margin-top: 6px;
        }
        #divCalendarContainer{
            width: 35%;
        }
          #divYourSchedule{
             height: 45vh;
             overflow-y: scroll;
        }
       @media screen and (max-width: 1366px) and (max-height: 768px){
          #divYourSchedule{
             height: 36vh;
             overflow-y: scroll;
            }
        }
      
        #divTimeContainer{
            width: 64%;
        }
        .divSchedulerChildContainer {
            height:100%;
            float:left;
            border: 1px solid black;
            overflow-y: scroll;
            overflow-x: hidden;
        }
        #divMyScheduleLabelContainer{
            background-color: green;
            color: white !important;
            text-align: center;
            font-size: 22px;
            height: 33px;
            line-height: 33px;
        }
        h2 {
            background-color: green;
            color:white !important;
            text-align:center;
            margin: 0 0 !important;
        }
        /*.divTimeSlot{
            text-align: center;
            border: 1px solid lightgray;
            float: left;
            width: 100%;
            /*height: 51px;*/*/
        }
        .lblTimeSlot {
            cursor: pointer;
            /*position: relative;
            top: 50%;
            transform: translateY(-50%);*/
        }
        .lblSlot{
            font-size: medium;
            background-color:teal;
            color:white;
            vertical-align: middle;
            line-height: 50px;
            margin-bottom: 0px;
        }
        #divTimeChildContainer{
            overflow-y:scroll;
            height:83vh;
        }
        .blockMsg  {
            background-color: transparent !important;
        }
        #scheduleTable{
            width: 100%;
            text-align: center;
        }
        table, th, td {
            border: 1px solid black;
        }
        /*.divLabelTimeSlot{
            width:50%;
            float:left;
            height:100%;
        }*/
        /*.divLabelSlot{
            width:28%;
            float:left;
            height: 100%;
        }*/
        /*.divButton{
            width:22%;
            float:left;
            height:100%;
            line-height: 50px;
        }*/
        .btnSetSchedule{
            width:99%;
        }
        .material-icons{
            vertical-align: middle;
            float: left;
            margin-left: -8px;
        }
        /*.button-text{
            float:left;
            margin-left: 3px;
        }*/
        #tableTimeChildContainer{
            width: 100%;
            text-align: center;
        }
        td.divLabelTimeSlot {
            width: 45%;
        }
        td.divLabelSlot {
            width: 30%;
        }
         .ui-tooltip, .arrow:after {
    /*background: linear-gradient(to bottom, rgba(251,200,67,1) 0%, rgba(248,164,38,1) 100%);*/
    background: #fff4ca;
    border: 2px solid white;
}
.ui-tooltip {
    padding: 10px 20px;
    color: black;
    border-radius: 20px;
    font: 14px"Helvetica Neue", Sans-Serif;
    box-shadow: 0 0 7px black;
}
    </style>
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script src="../Scripts/jquery-ui-1.10.3.js"></script>
    <script src="../Scripts/Others.js"></script>
    <script src="../Scripts/jquery.blockUI.js"></script>
    <script src="../Scripts/moment.js"></script>
    <link href="../App_Themes/Default/bootstrap2.3.2.css" rel="stylesheet" />
    <link href="../App_Themes/Default/jqueryui_custom/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script>
        $(function () {
            var todate = sessionStorage.getItem("yuckdate");
            
            if (todate != null) {
                //var dates = todate.split("-");
                //todate = dates[0] + "-" + (parseInt(dates[1]) < 11 ? "0" + dates[1] : dates[1]) + "-" + dates[2];
                todate = moment(todate, "YYYY-MM-DD");
                sessionStorage.removeItem("yuckdate");
            }
            var date = todate == null ? moment().add(7, 'day') : moment(todate);
            var dateToday = new Date(date);
            //alert(date.year() + "-" + (date.month() < 11 ? "0" + (date.month() + 1) : (date.month() + 1)) + "-" + date.date());
            var schedule = todate != null ? moment(todate).format("YYYY-MM-DD") : moment(dateToday).format("YYYY-MM-DD");
            
            getSchedules(schedule);
            if (todate == null) {
                $("#monthView").datepicker({
                    minDate: dateToday,
                    onSelect: function (dateText, inst) {
                        var dts = dateText.split('/');
                        var newDate = dts[2] + "-" + dts[0] + "-" + dts[1];
                        getSchedules(newDate);

                    }
                });
            }
            else {
                var minDate = moment().add(7, 'day');
                $("#monthView").datepicker({
                    defaultDate: dateToday,
                    minDate: new Date(minDate),
                    onSelect: function (dateText, inst) {
                        var dts = dateText.split('/');
                        var newDate = dts[2] + "-" + dts[0] + "-" + dts[1];
                        getSchedules(newDate);

                    }
                });

            }
            $('#tableTimeChildContainer').on('click', '.btnSetSchedule', function () {
                //showTopics();
                //if ($('#hdnParentsInfoFlag').val() == "False") {
                //    ShowParentsInfo(this)
                //}
                //else {
                    confirm(this);
                //}
                //if ($(this).hasClass("btnCancelSchedule"))
                //    CancelSchedule(this, $(this).data("date"), $('#hdnCurrentUser').val());
                //else
                //    CreateMatch(this, $(this).data("date"), $('#hdnCurrentUser').val());

              
            });
            GetMySchedule();
            //$('.btnSetSchedule').click(function() {
            //    CreateMatch($(this).data("date"), $('#hdnCurrentUser').val());
            //});
        });
        function BlockElement() {
            $.blockUI({
                message: '<img src="../Images/loading.gif" /> ',
                css: { border: 'none' }
            });
        }

        function UnBlockElement() {
            setTimeout($.unblockUI, 1000);
        }
        function getSchedules(date) {
            sessionStorage.setItem("date", date);
            $.getJSON("../api/MatchMaker/GetAllTimeSchedule/" + date,
                function (data) {
                    if (data) {
                        $('#tableTimeChildContainer').empty();
                        data.forEach((item) => {
                            //var template = "<div class='divTimeSlot'><label class='lblTimeSlot'>{0}</label ><button type='button' class='btnSetSchedule btn {1} ' data-date='{2}' ><span class='glyphicon glyphicon-refresh glyphicon-refresh-animate'></span>{3}</button><label class='lblSlot'>{4}</label></div>";
                            var template = $('#tableTimetemplate').html().trim();
                            var slotsAvailable = $('#hdnSlotsAvailable').val().stringformat(item.SlotsAvailable);
                            template = template.stringformat(item.TimeSchedule,
                                item.HasSchedule == true ? "btnCancelSchedule " + (item.HasPartner ?  "btn-vivid-gold" : "btn-vivid-purple") : (!item.HasMatched) ? (item.DisableRegisterButton ? "btn-secondary" : "btn-info") : "btn-success",
                                item.ActualDateTime,
                                item.HasSchedule == true ? (item.HasPartner ? $('#hdnCancelBookedButton').val() : $('#hdnCancelButton').val() ) : (!item.HasMatched) ? $('#hdnRegisterButton').val() : $('#hdnMatchButton').val(),
                                slotsAvailable,
                                !item.HasSchedule && !item.HasMatched && item.DisableRegisterButton ? "disabled" : "",
                            );
                            $('#tableTimeChildContainer').append(template)
                        });
                        if ($('#hdnLanguage').val() == "en-US") {
                            $(".material-icons").css("margin-left", "5px");
                        }
                        GetMySchedule();
                        $('.btn-vivid-gold').hover(function () {
                            $(this).tooltip({
                                content: $("#hdnCancelMessage").val(), items: '.btn-vivid-gold', show: null,
                                close: function (event, ui) {
                                    ui.tooltip.hover(

                                        function () {
                                            $(this).stop(true).fadeTo(400, 1);
                                        },

                                        function () {
                                            $(this).fadeOut("400", function () {
                                                $(this).remove();
                                            })
                                        });
                                }
                            });
                        });
                        $('.btn-vivid-purple').hover(function () {
                            $(this).tooltip({
                                content: $("#hdnCancelRegisteredTooltip").val(), items: '.btn-vivid-purple', show: null,
                                close: function (event, ui) {
                                    ui.tooltip.hover(

                                        function () {
                                            $(this).stop(true).fadeTo(400, 1);
                                        },

                                        function () {
                                            $(this).fadeOut("400", function () {
                                                $(this).remove();
                                            })
                                        });
                                }
                            });
                        });
                    }
                    
                });
        }

        function GetScheduleByDateAndId(date, id) {
            $.getJSON("../api/MatchMaker/GetScheduleByDateAndId/" + date + "/1",
                function (data) {
                    alert(data);
                });
        }

        function CreateMatch(el, date, id) {
            BlockElement();
            $.getJSON("../api/MatchMaker/CreateMatch?schedule=" + date + "&userId=" + id + "&categoryId=" + $('#ddlTopic').val(),
                function (data) {
                    $(el).removeClass("btn-info");
                    $(el).addClass("btnCancelSchedule btn-vivid-gold");
                    $(el).text($('#hdnCancelButton').val());
                    getSchedules(sessionStorage.getItem("date"));
                    GetMySchedule();
                    UnBlockElement();
                });
        }
        function CancelSchedule(el, date, id) {
            $.getJSON("../api/MatchMaker/CancelSchedule?schedule=" + date + "&userId=" + id,
                function (data) {
                    $(el).removeClass("btnCancelSchedule");
                    $(el).addClass("btn-info");
                    $(el).text($('#hdnRegisterButton').val());
                    getSchedules(sessionStorage.getItem("date"));
                    GetMySchedule();
                    UnBlockElement();
                });
        }

        function GetMySchedule() {
            var date = sessionStorage.getItem("date");
            $.getJSON("../api/MatchMaker/GetScheduleByUserId/" + date + "/" + $('#hdnCurrentUser').val(),
                function (data) {
                    if (data) {
                        $('#scheduleTable > tbody').empty();

                        data.forEach(item => {
                            var template = '<tr><td>{0}</td><td style="text-align:center;">{1}</td><td style="width:50px;">{2}</td></tr>';
                            var items = item.TimeSchedule.split(/\//g);
                            var date = items[0];
                            items.shift();
                            //template = template.stringformat(item.TimeSchedule.replace(/\//g, '<br>'), item.PartnerId == null || item.PartnerId == 'undefined' ? "No" : "Yes");
                            template = template.stringformat(date,items.join('<br>'), item.PartnerId == null || item.PartnerId == 'undefined' ? "No" : "Yes");
                            $('#scheduleTable > tbody:last-child').append(template);
                        });
                        var date = new Date(sessionStorage.getItem("date"));
                        //alert(sessionStorage.getItem("date") + " " + sessionStorage.getItem("date"));
                        const month = date.toLocaleString($('#hdnLanguage').val(), { month: 'long' });
                        if ((data != null && data != undefined) && data.length > 0) {
                            var matchedcount = data[0].MatchedCount;
                            var remaining = data[0].NumberOfMatching - matchedcount;
                            $('#lblMatchCountLabel').text($('#hdnMatchCountLabel').val().stringformat(month,matchedcount));
                            $('#lblRemainingMatchLabel').text($('#hdnRemainingMatchLabel').val().stringformat(month,remaining));
                        }
                        else {
                            $('#lblMatchCountLabel').text($('#hdnMatchCountLabel').val().stringformat(month,0));
                            $('#lblRemainingMatchLabel').text($('#hdnRemainingMatchLabel').val().stringformat(month, $('#hdnCurrentUserNumberOfMatching').val()));
                        }
                    }

                });
        }
        function confirm(el) {
            var translations = {};
            var isRegisterCancel = $(el).hasClass("btn-vivid-purple");
            translations["Ok"] = $('#hdnOk').val();
            translations["Cancel"] = $('#hdnCancel').val();
            var buttonsOpts = {};

            if ($(el).hasClass("btnCancelSchedule")) {
                if (isRegisterCancel) {
                    translations["Ok"] = $('#hdnOkCancel').val();
                }
                translations["Cancel"] = isRegisterCancel ? $('#hdnDontCancel').val() : $('#hdnOk').val();
                
            }
            if (isRegisterCancel || $(el).hasClass("btn-info") || $(el).hasClass("btn-success")) {
                buttonsOpts[translations["Ok"]] = function () {
                    OK(this, el);
                }
            }
            buttonsOpts[translations["Cancel"]] = function () {
                $(this).dialog("close");
            }
            $('#imgWarning').show();
            if ($(el).hasClass("btnCancelSchedule")) {
                if (!isRegisterCancel) {
                    $("#lblConfirmationMessage").html($("#hdnCancelMessage").val());
                }
                else {
                    $("#lblConfirmationMessage").html($("#hdnCancelRegisterMessage").val());
                }
                $('#imgWarning').attr("src", "../Images/new/warning.png");
            }
            else {
                if ($(el).hasClass("btn-info")) {
                    $("#lblConfirmationMessage").html($("#hdnRegisterMessage").val());
                    $('#imgWarning').attr("src", "../Images/new/questionblue.png");
                }
                else if ($(el).hasClass("btn-success")) {
                    $("#lblConfirmationMessage").html($("#hdnMatchMessage").val());
                    //$('#imgWarning').attr("src", "../Images/new/questiongreen.png");
                    $('#imgWarning').hide();
                }
            }
            function OK(dialog,el) {
                $(dialog).dialog("close");

                if ($(el).hasClass("btnCancelSchedule")) {
                    CancelSchedule(el, $(el).data("date"), $('#hdnCurrentUser').val());
                }
                else {
                    showTopics(el, $(el).data("date"), $('#hdnCurrentUser').val());
                    //CreateMatch(el, $(el).data("date"), $('#hdnCurrentUser').val());
                }
            }
            if ($(el).hasClass("btn-vivid-gold")) {
                return;
            }
            $("#confirmDialog").dialog({
                autoOpen: true,
                modal: true,
                width: 325,
                buttons: buttonsOpts
            });
        }

        function showTopics(el, date, id) {
            var translations = {};
            translations["Ok"] = $('#hdnOk').val();
            translations["Cancel"] = $('#hdnCancel').val();
            var buttonsOpts = {};
            buttonsOpts[translations["Cancel"]] = function () {
                $(this).dialog("close");
            }
            buttonsOpts[translations["Ok"]] = function () {
                CreateMatch(el, date, id);
                $(this).dialog("close");
                $('#ddlTopic').val("0");
            }
            $("#divTopicDialog").dialog({
                title: "Select Topic",
                autoOpen: true,
                modal: true,
                width: 325,
                buttons: buttonsOpts
            });

        }

         function ShowParentsInfo(el) {
            if ($('#hdnParentsInfoFlag').val() == "False") {
                $("#txtParentsName").val("");
                $("#txtPhoneNumber").val("");
                $("#hdnParentsName").val("");
                $("#hdnPhoneNumber").val("");

                $("#divParentsInfo").dialog({
                    height: 400,
                    width: 650,
                    modal: true,
                    closeOnEscape: false,
                    buttons: {
                        Ok: function () {
                            confirm(el);
                            if (validateParentsInfo()) {
                                $("#hdnParentsName").val($("#txtParentsName").val());
                                $("#hdnPhoneNumber").val($("#txtPhoneNumber").val());
                                //$('#btnSaveParentsInfo').click();
                                saveContact().then(() => {
                                    $("#hdnParentsInfoFlag").val('True');
                                    $(this).dialog("close");
                                    confirm(el);
                                }).catch(() => {
                                    $("#hdnParentsInfoFlag").val('False');
                                    $("#lblErrorSaving").show();
                                });
                            }
                        }
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
                $('.ui-dialog-titlebar').css('display', "none");
                //$('.ui-dialog').css('z-index', 103);
                //$('.ui-widget-overlay').css('z-index', 102);
                //$('#divParentsInfo').parent().appendTo($("form:first"));
            }
        }

        async function saveContact() {
            return await $.post("../api/MatchMaker/SaveContact/" + $('#txtParentsName').val() + "/" + $('#txtPhoneNumber').val(),
                function (data) {
                    if (data) {
                        return data;
                    }
                }).promise();

        }

        function validateParentsInfo() {
            var hasError = 0;
            var regex = /^\+?[0-9]{10,20}$/;
            if ($('#txtPhoneNumber').val() == "" || !regex.test($('#txtPhoneNumber').val())) {
                $("#lblPhoneNumberError").show()
                hasError++;
            }
            else {
                $("#lblPhoneNumberError").hide()
            }
            if ($('#txtParentsName').val() == "") {
                $("#lblParentsNameError").show()
                hasError++;
            }
            else {
                $("#lblParentsNameError").hide()
            }

            return hasError == 0;
        }

        //function populateTopic() {
        //      $.getJSON("../api/MatchMaker/GetTopics",
        //          function (data) {
        //              if (data) {
        //                  data.forEach((item) => {
        //                      $('#ddlTopic').append('<option>',
        //                          {
        //                              value: item.PhraseCategoryID,
        //                              text: item.PhraseCategoryCode
        //                          });
        //                  });
        //              }
        //        });
        //}

    </script>
    <div id="confirmDialog" title="&nbsp;" style="display:none;">
        <img id="imgWarning" src="" alt="warning" style="width:64px;height:64px;float:left;" />
        <asp:Label ID="lblConfirmationMessage" runat="server" Text="" ClientIDMode="Static"></asp:Label><br />
    </div>
    <div id="divTopicDialog" style="display:none;">
		<asp:DropDownList ID="ddlTopic" runat="server" ClientIDMode="Static" AutoPostBack="false"></asp:DropDownList>
	</div>

    <div id="schedulerContainer">
        <div id="divCalendarContainer" class="divSchedulerChildContainer">
            <h2><asp:Label ID="lblSelectDate" runat="server" style="font-weight:bold;" Text="Select Date" ClientIDMode="Static" meta:resourcekey="lblSelectDateResource1"></asp:Label></h2>
            <div id="monthView"></div>
            <div id="divRemainingMatch">
                <div id="divMatchedCountContainer">
                    <asp:Label ID="lblMatchCountLabel" runat="server" style="font-weight:bold;" Text="Match Count : {0}" ClientIDMode="Static" meta:resourcekey="lblMatchCountLabelResource1"></asp:Label>
                </div>
                <div id="divRemainingMatchContainer">
                    <asp:Label ID="lblRemainingMatchLabel" runat="server" style="font-weight:bold;" Text="Remaining Match for {0} : {1}" ClientIDMode="Static" meta:resourcekey="lblRemainingMatchLabelResource1"></asp:Label>
                </div>
            </div>
            <div id="divYourSchedule">
                <div id="divMyScheduleLabelContainer"><asp:Label ID="lblMySchedule" runat="server" style="font-weight:bold;" Text="My Schedule" ClientIDMode="Static" meta:resourcekey="lblMyScheduleResource1"></asp:Label></div>
                <table id="scheduleTable">
                    <thead>
                        <tr><th><asp:Label ID="lblDateTime" runat="server" style="font-weight:bold;" Text="Date" ClientIDMode="Static" meta:resourcekey="lblDateTimeResource1"></asp:Label></th><th><asp:Label ID="lblTime" runat="server" style="font-weight:bold;" Text="Time" ClientIDMode="Static" meta:resourcekey="lblTimeResource1"></asp:Label></th><th><asp:Label ID="lblWithPartner" runat="server" style="font-weight:bold;" Text="With Partner" ClientIDMode="Static" meta:resourcekey="lblWithPartnerResource1"></asp:Label></th></tr>
                    </thead>
                    <tbody>
                        
                    </tbody>
                </table>
            </div>
        </div>
        <div id="divTimeContainer" class="divSchedulerChildContainer">
            <h2><asp:Label ID="lblSelectTimeSlot" runat="server" style="font-weight:bold;" Text="Select Time Slot" ClientIDMode="Static" meta:resourcekey="lblSelectTimeSlotResource1"></asp:Label></h2>
            <table id="tableTimeChildContainer">

            </table>
        </div>
    </div>
    <asp:HiddenField ID="hdnCurrentUser" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdnRegisterButton" runat="server" ClientIDMode="Static" meta:resourcekey="hdnRegisterButtonResource1"/>
    <asp:HiddenField ID="hdnMatchButton" runat="server" ClientIDMode="Static" meta:resourcekey="hdnMatchButtonResource1"/>
    <asp:HiddenField ID="hdnCancelButton" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCancelButtonResource1"/>
    <asp:HiddenField ID="hdnCancelBookedButton" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCancelBookedButtonResource1"/>
    <asp:HiddenField ID="hdnSlotsAvailable" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSlotsAvailableResource1"/>
    <asp:HiddenField ID="hdnMatchCountLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnMatchCountLabelResource1"/>
    <asp:HiddenField ID="hdnRemainingMatchLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnRemainingMatchLabelResource1"/>
    <asp:HiddenField ID="hdnRegisterMessage" runat="server" ClientIDMode="Static" meta:resourcekey="hdnRegisterMessageResource1"/>
    <asp:HiddenField ID="hdnMatchMessage" runat="server" ClientIDMode="Static" meta:resourcekey="hdnMatchMessageResource1"/>
    <asp:HiddenField ID="hdnCancelMessage" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCancelMessageResource1"/>
    <asp:HiddenField ID="hdnCancelRegisterMessage" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCancelRegisterMessageResource1"/>
    <asp:HiddenField ID="hdnLanguage" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdnOk" runat="server" ClientIDMode="Static" meta:resourcekey="hdnOkResource1"/>
    <asp:HiddenField ID="hdnCancel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCancelResource1"/>
    <asp:HiddenField ID="hdnCurrentUserNumberOfMatching" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdnOkCancel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnOkCancelResource1"/>
    <asp:HiddenField ID="hdnDontCancel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnDontCancelResource1"/>
    <asp:HiddenField ID="hdnCancelRegisteredTooltip" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCancelRegisteredTooltipResource1"/>
    <asp:HiddenField ID="hdnParentsInfoFlag" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnPhoneNumber" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnParentsName" runat="server" ClientIDMode="Static" />

     <template id="divTimetemplate">
        <div class="divTimeSlot">
            <div class="divLabelTimeSlot">
                <label class="lblTimeSlot">{0}</label>
            </div>
            <div class="divLabelSlot">
                <label class="lblSlot">{4}</label>
            </div>
            <div class="divButton">
                <button type="button" class="btnSetSchedule btn {1} " data-date="{2}" {5}><span>{3}</span></></button>
            </div>
        </div>
    </template>
     <template id="tableTimetemplate">
        <tr class="divTimeSlot">
            <td class="divLabelTimeSlot">
                <label class="lblTimeSlot">{0}</label>
            </td>
            <td class="divLabelSlot">
                <label class="lblSlot">{4}</label>
            </td>
            <td class="divButton">
                <button type="button" class="btnSetSchedule btn {1} " data-date="{2}" {5}><span>{3}</span></></button>
            </td>
        </tr>
    </template>

       <div id="divParentsInfo" style="display:none;">
        <div>
            <asp:Label ID="lblInformation" runat="server" Text="Please input your parents fullname and phone number." Font-Bold="true" meta:resourcekey="lblInformationResource1"></asp:Label><br /><br />
            <ul>
                <li>
                    <asp:Label ID="lblOtherInformation1" runat="server" Text="" Font-Size="Smaller" meta:resourcekey="lblOtherInformation1Resource1"></asp:Label>
                </li>
                <li>
                    <asp:Label ID="lblOtherInformation2" runat="server" Text="" Font-Size="Smaller" meta:resourcekey="lblOtherInformation2Resource1"></asp:Label>
                </li>
                <li>
                    <asp:Label ID="lblOtherInformation3" runat="server" Text="" Font-Size="Smaller" meta:resourcekey="lblOtherInformation3Resource1"></asp:Label>
                </li>
            </ul>
        </div>
        <table>
            <tr>
            <td><asp:Label ID="lblParentsName" runat="server" Text="Contactable Name:" meta:resourcekey="lblParentsNameResource1"></asp:Label></td>
            <td><asp:TextBox ID="txtParentsName" runat="server" ClientIDMode="Static" Width="350px"></asp:TextBox></td>
            </tr>
            <tr>
            <td><asp:Label ID="lblPhoneNumber" runat="server" Text="Contactable Phone Number:" meta:resourcekey="lblConfirmEmailResource1"></asp:Label></td>
            <td><asp:TextBox ID="txtPhoneNumber" runat="server" ClientIDMode="Static" Width="350px" placeholder="(+)12345678910"></asp:TextBox></td>
            </tr>
            <tr>
            <td colspan="2">
                <asp:Label ID="lblParentsNameError" runat="server" Text="Name is required." ClientIDMode="Static" ForeColor="Red" style="display:none;" meta:resourcekey="lblParentsNameErrorResource1"></asp:Label><br />
                <asp:Label ID="lblPhoneNumberError" runat="server" Text="Phone Number is required/Invalid" ClientIDMode="Static" ForeColor="Red" style="display:none;" meta:resourcekey="lblPhoneNumberErrorResource1"></asp:Label>
            </td>
            <asp:Label ID="lblErrorSaving" runat="server" Text="Error on saving your information." ClientIDMode="Static" ForeColor="Red" style="display:none;" meta:resourcekey="lblErrorSavingResource1"></asp:Label>
            </tr>
        </table>
    </div>

</asp:Content>
