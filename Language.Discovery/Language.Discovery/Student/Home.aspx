<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Language.Discovery.Student.Home" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%--flagicons created by IconDrawer (Eugen Buzuk) http://www.icondrawer.com/--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script src="../Scripts/jquery-ui-1.10.3.min.js"></script>
    <script src="../Scripts/jquery.blockUI.js"></script>
    <link href="../colorbox/colorbox.css" rel="stylesheet" />
    <script src="../colorbox/jquery.colorbox.js"></script>
    <script src="../Scripts/Others.js?xx"></script>
    <script src="../Scripts/jquery-clearsearch.js"></script>


    <style>
        .scr {
            vertical-align: super;
            font-size: smaller;
        }

        .liUser {
            cursor: pointer;
            display: flex;
            align-items: center;
            height: 70px;
        }

        .rowrankselect {
            cursor: pointer;
        }

            .rowrankselect:hover {
                background-color: orange;
                color: white;
            }

        #tblRanking, #tblRanking th, #tblRanking td {
            border: 1px solid black;
        }

        .ui-dialog .ui-dialog-title {
            font-size: x-large;
            text-align: center;
        }

        .ui-dialog {
            z-index: 99999;
        }
        /*.ui-icon-closethick
        {
            background-image:url('../Images/x.png') !important;
        }*/
        .ui-icon-closethick {
           background-image: url(../Images/cancel.png) !important;
    background-size: cover;
    margin-left: -30px !important;
    margin-top: -14px !important;
    outline: none;
    background-position: unset !important;
    top: 0 !important;
    left: 0 !important;
    outline:none;
        }
        .ui-dialog .ui-dialog-titlebar-close {
            background: none !important;
            border: none !important;
        }
            .ui-dialog .ui-dialog-titlebar-close, .ui-dialog .ui-dialog-titlebar-close:hover {
                padding: 0 !important;
            }
            .ui-icon
            {
                width: 48px;
                height: 48px;
            }
        ::-webkit-scrollbar {
            width: 8px;
            height: 10px;

          }
          .new_notice_content::-webkit-scrollbar-thumb, .Tnew_notice_content::-webkit-scrollbar-thumb {
            border-radius: 8px;
            background: rgba(251,200,67,1);
          }
    </style>
    <script type="text/javascript">

        //start added afsar 12092024
        //window.addEventListener("beforeunload", function (event) {
        //    debugger;
            
        //    // Message to display when the user tries to close the tab or navigate away
        //    const message = "Are you sure you want to close this tab?";
        //    event.returnValue = message; // This will trigger the default confirmation dialog
        //    return message; // For some older browsers that may use the return value
        //});
        //end added afsar 12092024

        function AddLocalstorage(userid) {
            localStorage.setItem("UserID", userid);
        }

        $(function () {
            $(".newsImage").colorbox({ width: '500px', height: '500px', innerWidth: 500, innerHeight: 500 });
            $(".noticeImage").colorbox({ width: '500px', height: '500px', innerWidth: 500, innerHeight: 500 });
            $('#imgReplyFirst').click(function () {
                location.href = "Mailbox";
            });

            //var isSafari = !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/);
            $(".txtsearch_box").clearable();
            //Temporary commented 08-08-2019
            //if ($('#hdnVideoUrl').val() == "") {
            //    $('#frmVideo').attr("src", $('#hdnVideoUrl').val());
            //    if ($('#hdnDontShowVideo').val().toLowerCase() == "false") {
            //        $("#divVideo").dialog({
            //            autoOpen: true,
            //            height: 600,
            //            width: 634,
            //            modal: true,
            //            buttons:
            //                {
            //                    Ok: function () {
            //                        $(this).dialog("close");
            //                        $('#hdnDontShowVideo').val($('#chkDontShowVideo').prop("checked"));
            //                        $('#btnPostback').click();
            //                    }
            //                },
            //            close: function () {
            //                $('#frmVideo').attr("src", "");
            //            }
            //        });

            //        $(".ui-dialog-buttonpane").append($("#divchkDontShowVideo"));
            //    }
            //}

            MakeRankingOrdinal();
        });
       
        function nth(n) {
            return ["st", "nd", "rd"][((n + 90) % 100 - 10) % 10 - 1] || "th"
        }
        function ShowPicture() {
             $("a.gallery").colorbox();
             return false;
         }
        function MakeRankingOrdinal() {
            $('.scr').each(function () {

                var rank = parseInt($(this).attr("data-ranking"));
                rank = nth(rank);
                $(this).text(rank);
            });
        }
        function InitializeTabs() {
            $('#tabs').tabs({
                activate: function (event, ui) { //bind click event to link
                    $("#<%=hdnSelectedTab.ClientID%>").val(ui.newTab.index());

                    //$('#btnContinuetab' + ui.newTab.index()).show();
                    //$('#btnContinuetab' + ui.oldTab.index()).hide();

                    //if (ui.newTab.index() == 2) // New Palaygo joiner
                    //{
                    //    $('#btnContinue').show();
                    //}
                    //else {
                    //    $('#btnContinue').hide();
                    //}
                    //$('#imgSearch').click();
                    //alert('You chose tab index ' + ui.newTab.index());
                }
            });


            //$('#tabs').tabs("option", "active", $("#<%=hdnSelectedTab.ClientID%>").val());
        }
        function SetDefaultTab() {
            $('#tabs').tabs("option", "active", $("#<%=hdnSelectedTab.ClientID%>").val());
            $('#tabs').tabs("option", "activate", function (event, ui) { //bind click event to link
                $("#<%=hdnSelectedTab.ClientID%>").val(ui.newTab.index());
                $('#imgSearch').click();
                //$('#btnContinuetab' + ui.newTab.index()).show();
                //$('#btnContinuetab' + ui.oldTab.index()).hide();

            });

        }

        function SendToAllFriends(tabNum) {
            var selectedusers = "";
            var count = 0;
            $('#tab' + tabNum + '>.userBlock').each(function (i, obj) {
                count++;
                selectedusers = selectedusers + $(obj).attr("data-userid") + ",";
                if (count == 20)
                    return false;
            });//.data("data-userid");
            if (selectedusers != "")
                $(location).attr('href', '<%=Page.ResolveUrl("~/Student/SendMessage")%>' + '?grp=' + selectedusers);
        }


            //var prm = Sys.WebForms.PageRequestManager.getInstance();

            //prm.add_endRequest(function(s, e) {
            //    $('#tabs').tabs({selected:  $("#<%=hdnSelectedTab.ClientID%>").val(),
        //        activate: function (event, ui) { //bind click event to link
        //             $("#<%=hdnSelectedTab.ClientID%>").val(ui.newTab.index());
        //             
        //             //alert('You chose tab index ' + ui.newTab.index());
        //         }
        //     });
        //     $('#tabs').tabs("option", "active", $("#<%=hdnSelectedTab.ClientID%>").val());

        //BlockElement();
        //UnBlockElement();
        // });

        function pageLoad(sender, args) {
            $(function () {
                $(".imglike").click(function () {
                    $('.userBlock').removeAttr("onclick");
                    var onclickevent = $('.userBlock').attr("onclick");
                    var img = $(this);
                    var json = { Type: 'like', userid: $(this).attr("data-userid"), userstatusid: $(this).attr("data-userstatusid"), ilike: $(this).attr("data-ilike") };
                    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                        var obj = $.parseJSON(data)

                        if (obj.Status == "True") {
                            if (json.ilike.toLowerCase() == "true") {
                                img.attr("src", '../Images/heartLike.png');
                                img.attr("data-ilike", "false");
                                var likecount = img.siblings('.likecount').text();
                                img.siblings('.likecount').text(parseInt(likecount) - 1)
                            }
                            else {
                                img.attr("src", '../Images/heartUnlike.png');
                                img.attr("data-ilike", "true");
                                var likecount = img.siblings('.likecount').text();
                                img.siblings('.likecount').text(parseInt(likecount) + 1)
                            }
                        }
                        else
                            alert('Error updating your status.');
                    });
                    $('.userBlock').attr("onclick", onclickevent);
                });



            });

        }

        function InitializeDiscoverNewFriendsDialog() {

            var translations = {};
            translations["Continue"] = $('#lblContinue').text();
            translations["Cancel"] = $('#lblCancel').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Continue"]] = function () {

                if (sessionStorage.getItem("selectedUser") != null)
                    $(location).attr('href', '<%=Page.ResolveUrl("~/Student/SendMessage")%>' + '?grp=' + sessionStorage.getItem("selectedUser"));

                $(this).dialog("close");
                $("#results").html("");
                $("[id*=chkInterestGroup] input").each(function () {
                    $(this).removeAttr('checked');
                });
                $("[id*=chkGenderList] input").each(function () {
                    $(this).removeAttr('checked');
                });


            }
            buttonsOpts[translations["Cancel"]] = function () {
                $("#results").html("");
                $("[id*=chkInterestGroup] input").each(function () {
                    $(this).removeAttr('checked');
                });
                $("[id*=chkGenderList] input").each(function () {
                    $(this).removeAttr('checked');
                });
                $(this).dialog("close");

            }

            $("#discovernewfriendDialog").dialog({
                autoOpen: false,
                height: 700,
                width: 700,
                modal: true,
                title: $('#btnDisconverNewFriends').val(),
                //buttons: buttonsOpts
                open: function (event, ui) { SearchUser('', ''); $(this).parent().appendTo("form"); } //- remove selection as per meeting dec 04, 2014
                //title: $('#hdnDiscoverNewFriendsTitle').val(),
            });
        }
      

        $(function () {
            //createRoom();
            //if ($("#hdnLanguage").val() == "ja-JP") {
            //    $('#lblStartCount').css("margin-top", "-2px");
            //    $('#replyfirst').css("font-size", "12pt");
            //    $('#replyfirst').css("margin-top", "11px");
            //}
            //else {
            //    $('#lblStartCount').css("margin-top", "-5px");
            //    $('#replyfirst').css("font-size", "14pt");
            //    $('#replyfirst').css("margin-top", "14px");
            //}

            $('#chkGenderList').change(function () {

                var selectedItems = "";
                var selectedGenders = "";
                $("[id*=chkInterestGroup] input:checked").each(function () {
                    selectedItems += $(this).val() + ",";
                });

                $("[id*=chkGenderList] input:checked").each(function () {
                    selectedGenders += $(this).val() + ",";
                });

                SearchUser(selectedItems, selectedGenders);
            });

            $('#chkInterestGroup').change(function () {
                var selectedItems = "";
                var selectedGenders = "";
                $("[id*=chkInterestGroup] input:checked").each(function () {
                    selectedItems += $(this).val() + ",";
                });

                $("[id*=chkGenderList] input:checked").each(function () {
                    selectedGenders += $(this).val() + ",";
                });
                SearchUser(selectedItems, selectedGenders);
            });

            $('#ddlCity').change(function () {
                var selectedItems = "";
                var selectedGenders = "";
                $("[id*=chkInterestGroup] input:checked").each(function () {
                    selectedItems += $(this).val() + ",";
                });
                $("[id*=chkGenderList] input:checked").each(function () {
                    selectedGenders += $(this).val() + ",";
                });
                SearchUser(selectedItems, selectedGenders);
            });

            $('#txtSearch').on('input', function () {
                var selectedItems = "";
                var selectedGenders = "";
                $("[id*=chkInterestGroup] input:checked").each(function () {
                    selectedItems += $(this).val() + ",";
                });
                $("[id*=chkGenderList] input:checked").each(function () {
                    selectedGenders += $(this).val() + ",";
                });

                SearchUser(selectedItems, selectedGenders);
            });

        });

        function SelectAmbassador(el) {
            //if ($('#hdnIsDemo').val() == "True" || $('#hdnIsLevelDemo').val() == "True")
                //return;

            if ($(el).attr("data-flag").toLowerCase().indexOf("japan") > -1 && $("#hdnLanguage").val() == "ja-JP")
                return;
            if ($(el).attr("data-flag").toLowerCase().indexOf("australia") > -1 && $("#hdnLanguage").val() == "en-US")
                return;

            SelectUser(el);
        }


        function WriteNewMessage() {
            //if (sessionStorage.getItem("userresult") != null && parseInt(sessionStorage.getItem("userresult")) > 350) {
            //    alert('Search result too many, please limit your search criteria.');
            //    return false;
            //}
            var selectedusers = '';
            $(".chkSelectUser").each(function () {
                if ($(this).is(':checked') == true) {
                    selectedusers += $(this).attr("data-userid") + ",";
                }
            });
            sessionStorage.setItem("selectedUser", selectedusers);
            $('#hdnSelectedUsers').val(selectedusers);
            $("#results").html("");
            $("[id*=chkInterestGroup] input").each(function () {
                $(this).removeAttr('checked');
            });
        }

        function WriteNewMessageCancel() {
            $("#discovernewfriendDialog").dialog('close');
        }

        //Added InitializeChatHub by Afsar 14-08-2024
        function InitializeChatHub() {
            chat = $.connection.chatHub;
            $.connection.hub.logging = true;
            $.connection.hub.start().done(function () {
                chat.server.getAllOnlineStatus();
                var el = $('.divUsers');
                if (el.length > 0)
                    SelectUser($(el)[0]);

            }).fail(function (error) {
                console.log('Invocation of start failed. Error:' + error);
                alert('Microsoft Chat API crashed: ' + error + " - Please restart the browser, there might be a memory problem on your computer");
            });
            $.connection.hub.stateChanged(function (state) {
                var stateConversion = { 0: 'connecting', 1: 'connected', 2: 'reconnecting', 4: 'disconnected' };
                console.log('SignalR state changed from: ' + stateConversion[state.oldState]
                    + ' to: ' + stateConversion[state.newState]);

                if (stateConversion[state.newState] == "reconnecting") {
                    //callBroadCastHandler(10);
                    if (!_isInCall) {
                        $("<div>You have network problem, please press OK to refresh the page</div>").dialog({
                            title: "Reconnection Failed",
                            modal: true,
                            buttons: {
                                Ok: function () {
                                    location.reload();
                                }
                            }
                        });
                    }
                }
                else if (stateConversion[state.newState] == "connected") {
                    //callBroadCastHandler(10);
                }
            });
            $.connection.hub.connectionSlow(function () {
                toastr.clear();
                toastr.options = {
                    "closeButton": true,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": true,
                    "onclick": null,
                    "showDuration": "300",
                    "hideDuration": "10000",
                    "timeOut": "10000",
                    "extendedTimeOut": "10000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"

                }

                toastr.warning("Slow connection detected...", "NETWORK STATUS");
            });

            //$.connection.hub.disconnected(function () {
            //    if (!_isInCall) {
            //        $("<div>You have network problem, please press OK to refresh the page</div>").dialog({
            //            title: "Disconnected",
            //            modal: true,
            //            buttons: {
            //                Ok: function () {
            //                    location.reload();
            //                }
            //            }
            //        });
            //    }
            //});

            chat.client.OnlineStatus = function (connectionid, userList) {
                //alert("online :" +  connectionid);
            }

            chat.client.joined = function (connectionid, userList) {
                $.each(userList, function (index, value) {
                    var el = $(".divUsers[data-userid='" + value + "']");
                    if (el) {
                        var span = $(el).find("#spanstatus");
                        if (span) {
                            $(span).text("Online");
                            var img = $(el).find('.statusContainer > img');
                            if (img) {
                                $(img).attr("src", "../Images/online.png");
                                $(el).attr("data-isonline", "true");

                            }
                            DisableEnableCallButton();
                        }

                    }
                });
            }

            chat.client.onUserDisconnected = function (connectionid, userid) {
                var el = $(".divUsers[data-userid='" + userid + "']");
                if (el) {
                    $(el).find("#imgOnTalkStatus").attr("src", "../images/new/offline.png");
                    $(el).attr("data-isonline", "false");
                    DisableEnableCallButton();
                }
                if (userid == $('#hdnCurrentUserID').val()) {
                    changeStatusToConnected();
                }
            }

            chat.client.addMessage = function (usermailid, to, from, message, othermessage, groupname, keywords) {
                //debugger;
                if (from != $('#hdnSelectedUserID').val()) {
                    var el = $(".divUsers[data-userid='" + from + "']");
                    if (el) {
                        var span = $(el).find(".mailbox-img-counter");
                        if (span) {
                            var count = parseInt($(span).text());
                            //alert(count);
                            if (!isNaN(count))
                                count = count + 1;
                            else
                                count = 0;

                            //alert(count);
                            $(span).text(count);
                        }
                        if ($(el).data("issupport") == "True" && _isInCall) {
                            $('#hdnSupportId').val(from);
                            toastr.clear();
                            toastr.options = {
                                "closeButton": true,
                                "debug": false,
                                "newestOnTop": true,
                                "progressBar": false,
                                "positionClass": "toast-center-right",
                                "preventDuplicates": true,
                                "onclick": null,
                                "showDuration": "300",
                                "hideDuration": "1000",
                                "timeOut": 0,
                                "extendedTimeOut": 0,
                                "showEasing": "swing",
                                "hideEasing": "linear",
                                "showMethod": "fadeIn",
                                "hideMethod": "fadeOut",
                                "tapToDismiss": false,
                                "onCloseClick": function () { $('#btnChatSupport').removeClass("blink"); }
                            }
                            var messages = message.split('|');

                            var messageTemplate = '<div>{0}</<div><br><hr><div>{1}</<div><br/><hr><button type="button" style="display:block; background:#ccffff;" class="btn clear btnReplyToSupport">' + $('#hdnReplyButton').val() + '</button>';
                            var $toast = toastr.lighterror(messageTemplate.stringformat(messages[0], messages[2]), "<div>" + $('#hdnNewMessageTitle').val() + "</div><br/>");
                            $('#btnChatSupport').addClass("blink");
                            $toast.delegate('.clear', 'click', function () {
                                toastr.clear($toast, { force: true });
                                SelectSupportOrPartner(true);
                            });



                        }
                        $(el).toggleClass("newMessage");
                    }
                    //debugger;
                    if (from == $('#hdnCurrentUserID').val()) {
                        let str = writeToOwnWindow(to, from, message, othermessage);
                        showPhotos(str);
                    }
                    return;
                }
                var messages = message.split('|');
                var othermessages = othermessage.split('|');
                var cl = "newyou";
                var clstate = "old";
                var avatar = $('#hdnCurrentAvatar').val();
                var firstname = $('#hdnCurrentFirstName').val();
                var style = "color:black;font-size:8pt;font-weight:bold;"
                var spanid = "lblYou";
                var seconlanguageonlyclass = "";
                if ($('#chkSecondLanguage').prop("checked") == true) {
                    seconlanguageonlyclass = "newbubble1secondlanguageonly";
                }
                if (to == $('#hdnCurrentUserID').val()) {
                    cl = "newme";
                    clstate = "new";
                    avatar = $('#hdnSelectedAvatar').val();
                    firstname = $('#hdnSelectedFirstName').val();
                    style = "color:red;font-size:8pt;font-weight:bold;"
                    spanid = "lblMe";
                }
                var str = '<tr id="trMessage" class="message" data-keyword="' + keywords + '">';
                str = str + '<td class="nameContainer" style="vertical-align:middle;">';
                str = str + "<span class='chatname' id='" + spanid + "' style='" + style + "'>" + firstname + "</span>";
                str = str + '</td>';
                str = str + '<td class="tblMessage_conv">';
                str = str + '<div class="conversationDate" style="width:100%;text-align:center;">';
                str = str + '<span id="msgDate" style="width:100%;text-align:center;"><%=(System.DateTime.Now).ToShortDateString()%></span>';
                str = str + '</div>';
                str = str + '<div class="tblMessage_conversation">';
                if (cl == "newyou")
                    str = str + '<span class="newbubble ' + cl + ' ' + clstate + '" id="msg_conversation" style="word-wrap:break-word; width:40%;">' + "<div class='paletteContainer'>" + messages[2] + "</div>";
                else
                    str = str + '<span class="newbubble ' + cl + ' ' + clstate + '" id="msg_conversation" style="word-wrap:break-word; width:40%;">' + "<div class='paletteContainer'>" + othermessages[1] + "</div>";
                str = str + '</span>';
                if (cl == "newyou")
                    str = str + '<span class="newbubble1 newyou partnerbubble ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important;">' + "<div class='paletteContainer'>" + messages[0] + "</div>";
                else
                    str = str + '<span class="newbubble1 newme partnerbubble ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important;">' + "<div class='paletteContainer'>" + othermessages[0] + "</div>";
                if (cl == "newme") {
                    str = str + '<input title="Report this Problem Message" class="imgReport" id="imgReport" onclick="ConfirmReport(this); return false;" type="image" src="../Images/block.png" data-usermailid="' + usermailid + '">';
                    str = str + '<input title="Reply to this message" class="imgReply" id="imgReply" onclick="SearchViaReply(this); return false;" type="image" src="../Images/talkreply.png" data-usermailid="' + usermailid + '">';
                }
                str = str + '</span>';
                str = str + '</div>';
                str = str + '</td>';
                str = str + '<td style="vertical-align:top;">';
                str = str + '</td>';
                str = str + '</tr>';          
                let msgDom = $.parseHTML(str);
                showPhotos(str);


                $('#tblMessage').append(msgDom);
                AttachPlaysound();
                $('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);
                if (seconlanguageonlyclass.length > 0)
                    $('#tblMessage').find(".newbubble").addClass("newbubblesecondlanguageonlyHidden");
                else
                    $('#tblMessage').find(".newbubble").removeClass("newbubblesecondlanguageonlyHidden");

                $('#hdnSoundFile').val('');
                $('#hdnKeywords').val(keywords);
                $('#hdnAutoSearch').val("1");
            }

            function showPhotos(str) {
                let msgDom = $.parseHTML(str);
                let temp = $.parseHTML(str);
                $(temp).find("a.gallery").not(".secondword").attr("rel", "gal");
                $('#imageTemporary').append(temp);
                $(temp).find("a.gallery").not(".secondword").colorbox({
                    open: true,
                    rel: 'gal',
                    fixed: true,
                    width: "50%",
                    height: "75%",
                    onClosed: function () {
                        _wordTabDialogOpen = false;
                        $('#imageTemporary').empty();
                    }
                });
            }

            chat.client.sendToMailBox = function (to, from, message, othermessage) {
                let str = writeToOwnWindow(to, from, message, othermessage);
                showPhotos(str);
            }


            chat.client.NotifyUser = function (from, message) {
                //debugger;
                var messages = message.split('|');
                var cl = "you";
                var avatar = $('#hdnCurrentAvatar').val();
                if (to == $('#hdnCurrentUserID').val()) {
                    cl = "me";
                    avatar = $('#hdnSelectedAvatar').val();
                }
                var str = '<tr id="trMessage">';
                str = str + '<td style="vertical-align:top;">';
                if (cl == "me")
                    str = str + '<img class="imgAvatarYou" id="imgAvatarYou" style="width: 65px; height: 65px;" src="' + avatar + '">';

                $('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);
                $('#hdnSoundFile').val('');

                alert("User is not online, this message will be sent to mailbox.");
            }

            chat.client.callAnswered = function (group, from, roomKey) {
                setKeepAlive();
                PlayRingBack(false);
                if (from != $("#hdnCurrentUserName").val()) {
                    //GetVideoKey();
                    var username = $("#lblLastName").text();
                    var currentuser = $("#hdnCurrentUserName").val();
                    var room = currentuser.replace("@", "_") + username.replace("@", "_");
                    _roomparameter = room;
                    $('#btnCallIcon').addClass("callStart");
                    loadVidyoClientLibrary(true, true, roomKey, $("#hdnCurrentUserName").val(), true);
                    $("#renderer0").show();
                    $("#renderer01").show();
                    $("#renderer02").show();
                    $("#renderer01_timesSection").show();

                }
            }
            chat.client.callRejected = function (group, from) {
                $("#renderer01").hide();
                $("#renderer02").hide();
                $("#renderer01_timesSection").hide();
                if (from != $("#hdnCurrentUserName").val()) {
                    var message = $('#hdnCallBusyMessage').val().stringformat(from);
                    $("<div>" + message + "</div>").dialog({
                        modal: true,
                        buttons: {
                            Ok: function () {
                                $(this).dialog("close");
                            }
                        }
                    });
                }
                Ring(false);
                PlayRingBack(false);
                if (from != $("#hdnCurrentUserName").val())
                    $("#btnCallIcon").click();
                //alert("your call was rejected");
                clearInterval(_KeepAlive);
            }

            function setKeepAlive() {
                _KeepAlive = setInterval(KeepAlive, 300000); // every 5 min
            }

            function KeepAlive() {
                var json = { Type: 'keepalive' };
                $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                    var obj = $.parseJSON(data);
                    if (obj.Status == "True") {
                        console.log("keep alive");
                    }
                    else
                        alert('Error KeepAlive. Please check your network or internet.');
                }).fail(function (xhr, textStatus, errorThrown) {
                });

            }
            function showCallAlert(receiver, from, room, group) {
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": true,
                    "progressBar": false,
                    "positionClass": "toast-center-right",
                    "preventDuplicates": true,
                    "onclick": null,
                    "showDuration": "300",
                    "hideDuration": "1000",
                    "timeOut": 0,
                    "extendedTimeOut": 0,
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut",
                    "tapToDismiss": false,
                    "onCloseClick": function () { }
                }

                var messageTemplate = '<div>{0}</<div><br><br><hr>'
                    + '<button type="button" style="background:#ccffff;" class="btn btnAnswer">'
                    + $('#hdnAnswer').val() + '</button>'
                    + '<button type="button" style="background:#ccffff;" class="btn clear btnCancel">'
                    + $('#hdnReject').val() + '</button>';

                let $toast = toastr.success(messageTemplate.stringformat(from + " is calling you."));

                //Reject
                $toast.delegate('.clear', 'click', function () {
                    toastr.clear($toast, { force: true });
                    //$(this).dialog("close");
                    if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                        $.connection.hub.start().done(function () {
                            chat.server.rejected(group, $("#hdnCurrentUserName").val());
                        });
                    } else {
                        chat.server.rejected(group, $("#hdnCurrentUserName").val());
                    }
                    Ring(false);
                });
                //Answer
                $toast.delegate('.btnAnswer', 'click', function () {
                    toastr.clear();
                    if (!IsCallerSelected(from)) {
                        _callAnswered = true;
                        _roomparameter = room;
                        _fromparameter = from;
                        _groupparameter = group;
                        SelectCaller(from);

                    }
                    else {
                        GetVideoKey();
                        $('#btnCallIcon').addClass("callStart");
                        loadVidyoClientLibrary(true, true, room, $("#hdnCurrentUserName").val(), false);

                        $("#renderer0").show();
                        Ring(false);
                        if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                            $.connection.hub.start().done(function () {
                                chat.server.answered(group, $("#hdnCurrentUserName").val(), room);
                            });
                        } else {
                            chat.server.answered(group, $("#hdnCurrentUserName").val(), room);
                        }
                        AddConferenceRoom(room, from, $("#hdnCurrentUserName").val());
                    }
                });
            }
            chat.client.userSignedout = function (from) {
                var el = $(".divUsers[data-username='" + from + "']");
                if (el) {
                    //$(el).find(".ontalk").hide();
                    $(el).find("#imgOnTalkStatus").attr("src", "../images/new/offline.png");
                    $(el).attr("data-isonline", "false");
                    DisableEnableCallButton();
                    var span = $(el).find(".statusContainer > #spanstatus");
                    if (span) {
                        $(span).text("Offline");
                        var img = $(el).find('.statusContainer > img');
                        if (img.length > 0) {
                            $(img).attr("src", "../Images/Offline.png");
                        }
                    }

                }
                return;
            }
            chat.client.callHangup = function (from, group, room) {
                if ((from != _caller && _SomeoneIscalling) || _isInCall) {
                    return;
                }
                if (from != $("#hdnCurrentUserName").val()) {
                    $("#btnCallIcon").attr("data-isfromhangup", "true");
                    $("#btnCallIcon").click();
                    //$(".divMessage").removeClass("divMessageWithVideo");
                    $("#btnCallIcon").attr("src", "../Images/new/CallingStatic.png");
                    $("#renderer0").hide();
                    $("#renderer1").hide();
                    $("#renderer01").hide();
                    $("#renderer01_timesSection").hide();
                    //$("#renderer02").hide();

                    if ($("#divCallAlert").dialog("isOpen") === true) {
                        $("#divCallAlert").dialog("close");

                        Ring(false);
                        _SomeoneIscalling = false;
                    }
                    UpdateTalkSubscription(from);
                }
                else {
                    UpdateTalkSubscription($("#hdnSelectedUserName").val());
                }
                DeleteConferenceRoom(room);
                if (_isInCall && _SomeoneIscalling) {
                    _SomeoneIscalling = false;

                }
                _caller = "";
                
            }
            chat.client.callEnded = function (from, group, room) {

                if (from != $("#hdnCurrentUserName").val() && $("#btnCallIcon").attr("src").indexOf("callEnd.png") > -1) {
                    location.reload();
                    $("#btnCallIcon").click();
                    $("#btnCallIcon").attr("src", "../Images/new/CallingStatic.png");
                    $("#renderer0").hide();
                    $("#renderer1").hide();
                    $("#renderer01").hide();
                    $("#renderer02").hide();
                    $("#renderer01_timesSection").hide();
                    UpdateTalkSubscription(from);
                }
                else {
                    UpdateTalkSubscription($("#hdnSelectedUserName").val());
                }
                DeleteConferenceRoom(room);
                if (_isInCall && _SomeoneIscalling) {
                    _SomeoneIscalling = false;
                }
                _caller = "";
            }
            chat.client.userCanTalkNow = function (from, group, cantalk) {
                //if (from != $('#hdnSelectedUserID').val()) {
                var el = $(".divUsers[data-userid='" + from + "']");
                if (el) {
                    if (cantalk) {
                        //$(el).find(".ontalk").show();
                        $(el).find("#imgOnTalkStatus").attr("src", "../images/new/online.png");
                        $(el).attr("data-isonline", "true")
                    }
                    else {
                        //$(el).find(".ontalk").hide();
                        $(el).find("#imgOnTalkStatus").attr("src", "../images/new/offline.png");
                        $(el).attr("data-isonline", "false")
                    }
                    if (from == $('#hdnSelectedUserID').val()) {
                        chat.server.createGroup($('#hdnCurrentUserID').val(), $('#hdnSelectedUserID').val());
                    }
                    DisableEnableCallButton();
                }
                return;
                //}
            }
            chat.client.userOnline = function (from, isOnline) {
                //if (from != $('#hdnSelectedUserID').val()) {
                var el = $(".divUsers[data-userid='" + from + "']");
                if (el) {
                    if (isOnline) {
                        //$(el).find(".ontalk").show();
                        $(el).find("#imgOnTalkStatus").attr("src", "../images/new/online.png");
                        $(el).attr("data-isonline", "true")
                    }
                    else {
                        //$(el).find(".ontalk").hide();
                        $(el).find("#imgOnTalkStatus").attr("src", "../images/new/offline.png");
                        $(el).attr("data-isonline", "false")
                    }
                    //if (from == $('#hdnSelectedUserID').val()) {
                    //    chat.server.createGroup($('#hdnCurrentUserID').val(), $('#hdnSelectedUserID').val());
                    //}
                    DisableEnableCallButton();
                }
                return;
                //}
            }
            chat.client.callUser = function (receiver, from, room, group, roomKey) {

                userIsCalling(receiver, from, room, group, roomKey)
            }
            chat.client.userPing = function (to, from, group, cantalk) {
                //if (from != $('#hdnSelectedUserID').val()) {
                var el = $(".divUsers[data-userid='" + from + "']");
                if (el) {
                    if (cantalk) {
                        //$(el).find(".ontalk").show();
                        $(el).find("#imgOnTalkStatus").attr("src", "../images/new/online.png");
                        $(el).attr("data-isonline", "true")
                    }
                    else {
                        //$(el).find(".ontalk").hide();
                        $(el).find("#imgOnTalkStatus").attr("src", "../images/new/offline.png");
                        $(el).attr("data-isonline", "false")
                    }
                    DisableEnableCallButton();
                }
                return;
                //}
            }

            chat.client.setChatGroup = function (groupname) {
                $('#hdnGroupName').val(groupname);
            }

            chat.client.userPartnerCameraChanged = function (from, groupname, isCameraChanged) {
                _isPartnerCameraChanged = isCameraChanged;
            }

            chat.client.userLogout = function (authentication) {
                if (authentication.toLowerCase() == $('#hdnAuthentication').val()) {
                    $(location).attr('href', '<%=Page.ResolveUrl("~/Logout")%>');
                }
            }
        }
     
        //Added AnitializationTab by Afsar 14-08-2024
        function InitializeMainTab() {
            $("#mtabs").tabs({
                activate: function (event, ui) {
                    if (ui.newTab.index() == 0) {
                        //$('#rdoCriteriaList').find("input[value='0']").prop("checked", true);
                        $('#btnAddOwnPalette').show();
                        $('#step3').show();
                        $('#lblSentenceTitle').show();
                        $('#btnRemoveOwnPalette').hide();
                        $('#step3OwnPalette').hide();
                        $('#lblOwnPaletteTitle').hide();
                        $('.sContainerb input:checkbox:first').focus()
                    }
                    if (ui.newTab.index() == 1) {
                        //$('#rdoCriteriaList').find("input[value='1']").prop("checked", true);
                        $('#btnAddOwnPalette').hide();
                        $('#step3').hide();
                        $('#lblSentenceTitle').hide();
                        $('#btnRemoveOwnPalette').show();
                        $('#step3OwnPalette').show();
                        $('#lblOwnPaletteTitle').show();
                        $('.divUserPaletteContainer input:checkbox:first').focus();
                    }
                    _currentTab = ui.newTab.index();
                    $('#hdnCurrentTab').val(_currentTab);
                    //ui.newTab.index()
                },
                beforeActivate: function (event, ui) {
                    if (ui.newTab.index() == 3 || ui.newTab.index() == 4) {
                        event.preventDefault();
                        showWordDialog(ui.newTab.index());

                    }
                }
            }).addClass('ui-tabs-vertical ui-helper-clearfix');
            $("#mtabs li").removeClass('ui-corner-top').addClass('ui-corner-right');
        }
        //End Initialization by Afsar

        //Afsar DisableEnableCallButton start
        function DisableEnableCallButton() {
            var el = $(".divUsers.selected").find('.ontalk').find('#imgOnTalkStatus');
            if ($(el).length > 0 && $(el).attr("src").indexOf('online') > -1 && $("#lblCanTalkContainer").hasClass("lblCanTalk") && !$("#lblCanTalkContainer").hasClass("lblCanTalkDisabled"))
                $("#btnCallIcon").removeClass("btnCallIconDisabled");
            else
                $("#btnCallIcon").addClass("btnCallIconDisabled");
        }

       
        //Afsar InitializeChatHub End
        
        function SearchUser(selecteditems, genderlist) {
            //if (selecteditems != '') { //remove selection as per meeting dec 04, 2014
            //$('.spinner').show();
            var json = { Type: 'MakeNewFriends', Items: selecteditems, CityID: $('#ddlCity').val(), Name: $('#txtSearch').val(), Genders: genderlist };
            $.ajax
                ({
                    type: "POST",
                    url: "../Handler/SearchHandler.ashx",
                    data: json, //"selecteditem=" + selecteditems,
                    success: function (data) {

                        var data1 = $.parseJSON(data);
                        var result = "";
                        if (data1 == null) {
                            result = $('#hdnNoUserFound').val();
                            $("#results").empty();
                            $("#results").append('<ul>' + result + '</ul>');
                            return;
                        }

                        //sessionStorage.setItem("userresult",data1.length)
                        var selectedUser = "";
                        var count = 0;
                        var shouldIncreaseNativeUsersList = false;
                        $.each(data1, function (i, obj) {
                            if (count == 0)
                                shouldIncreaseNativeUsersList = obj.ShouldIncreaseNativeUsersList;
                            if (count <= 50)
                                selectedUser += obj.UserID + ",";

                            count = count + 1;
                            result += ("<li class='liUser' data-userid='{3}'><input type='checkbox' style='float:left;position:absolute;margin-left:5px;' class='chkSelectUser' data-userid='{3}'><div id='auth_img'><img src='{0}'></div>" +
                                "<div id='rest'><span>{1}</span><br/><span>{2}</span><br/><br/><br/></div>" +
                                "<div style='clear:both;'></div><div style='float:left;width:80%;font-weight:bold;'><span>{4}</span></div></li>").stringformat("../Images/avatar/" + obj.Avatar, obj.FirstName, obj.Address, obj.UserID, '');
                        });
                        sessionStorage.setItem("selectedUser", selectedUser)
                        
                        $("#results").empty();
                        $("#results").append('<ul>' + result + '</ul>');
                        //add it back as per franks email 12/07/2015
                        $('.liUser').click(function () { SelectUser(this); }); //- remove selection as per meeting dec 04, 2014
                        var counter = 0;
                        $(".chkSelectUser").each(function () {
                            var cnt = 1;
                            //$(el).siblings().find("#chkSelectUser").prop('checked', false);
                            //if (shouldIncreaseNativeUsersList) {
                            if ($("#hdnLanguage").val() == "ja-JP") {
                                cnt = 5;
                            }
                            if (counter == cnt)
                                return false;


                            $(this).prop('checked', true);
                            counter++;

                        });
                        $('.chkSelectUser').click(function (e) { e.stopPropagation(); });
                    }
                });
            //}
            //else {

            //    $("#results").html("");
            //}

            //$('.spinner').hide();
            return false;
        }

        function BlockElement() {
            $.blockUI({
                message: '<img src="../Images/loading.gif" /> ',
                css: { border: '1px solid white' }
            });
        }

        function UnBlockElement() {
            setTimeout($.unblockUI, 2000);
        }

        function SelectUser(el) {
            if ($('#hdnLevel').val() == 3 && $(el).attr("data-level") != 3) {
                return;
            }
            var userid = $(el).attr('data-userid');
            //$(location).attr('href', '<%=Page.ResolveUrl("~/Student/FriendsRoom")%>' + "?fid=" + userid);

            url = '<%=Page.ResolveUrl("~/Student/MyFriendsRoom")%>' + "?fid=" + userid;
            var windowObjectReference = window.open(url, '_blank');
        }

        function DiscoverNewFriends() {
            if ($('#imgReplyFirst').is(":visible")) {
                location.href = "Mailbox";
                return;
            }
            InitializeDiscoverNewFriendsDialog();
            $("#discovernewfriendDialog").dialog("open");
        }

        function Profile() {
            $(location).attr('href', '<%=Page.ResolveUrl("~/Student/MyRoom")%>');
        }

        function blink() {
            setInterval(function () {
                $("#linkHasMessages").fadeToggle();
            }, 200);
        }
        function DisableNewFriends() {
            //$('#btnDisconverNewFriends').val("");
            $('#imgAddFriends').hide();
            $('#imgReplyFirst').show();
        }

        function EnglishResource() {
            window.open("https://www.palaygo.com/en-learner-resources/");
           /* alert("hello")*/
        }

        function JapaneseResource() {
            window.open("https://www.palaygo.net.au/jp-learner-resources/");
            /* alert("hello")*/
        }

    </script>
    <div id="divVideo" style="display: none;">
        <div id="divFrame">
            <iframe width="600" height="450" src="" frameborder="0" allowfullscreen rel="0&amp;showinfo=0" id="frmVideo"></iframe>
        </div>
        <div id="divchkDontShowVideo">
            <asp:CheckBox ID="chkDontShowVideo" runat="server" ClientIDMode="Static" />&nbsp;<asp:Label ID="lblDontShowVideo" runat="server" ClientIDMode="Static" meta:resourcekey="lblDontShowVideoResource1">Dont't display this video again.</asp:Label>
        </div>
    </div>
   <%-- <div id="divQuickGuide" style="display: none;">
        <div id="divFrameQuickGuide">
            <iframe width="800" height="450" src="" frameborder="0" allowfullscreen rel="0&amp;showinfo=0" id="frmQuickGuide"></iframe>
        </div>
        <div id="divchkDontShowQuickGuide">
            <asp:CheckBox ID="chkDontShowQuickGuide" runat="server" ClientIDMode="Static" />&nbsp;<asp:Label ID="lblDontShowQuickGuide" runat="server" ClientIDMode="Static" meta:resourcekey="lblDontShowQuickGuideResource1">Dont't display this video again.</asp:Label>
            <asp:Label ID="lblQuickGuideOtherInfo" runat="server" ClientIDMode="Static" meta:resourcekey="lblQuickGuideOtherInfoResource1">Can still be accessed from <i class="material-icons help_icon">help</i> Help on the menu bar</asp:Label>
        </div>
    </div>--%>
    <asp:HiddenField ID="hdnCurrentUserID" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnDontShowQuickGuide" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnQuickGuideUrl" runat="server" ClientIDMode="Static" meta:resourcekey="hdnQuickGuideUrlResource1" />
    <asp:HiddenField ID="hdnVideoUrl" runat="server" ClientIDMode="Static" meta:resourcekey="hdnVideoUrlResource1" />
    <asp:HiddenField ID="hdnDontShowVideo" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnLanguage" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnNoUserFound" runat="server" ClientIDMode="Static" meta:resourcekey="hdnNoUserFoundResource1" />
    <asp:HiddenField ID="hdnIsDemo" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIsLevelDemo" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnNewMessageLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnNewMessageLabelResource1" />
    <asp:HiddenField ID="hdnSelectedUsers" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdnLevel" runat="server" ClientIDMode="Static" />
    <asp:Label ID="lblContinue" runat="server" meta:resourcekey="hdnContinueResource1" ClientIDMode="Static" Style="display: none;" />
    <asp:Label ID="lblCancel" runat="server" meta:resourcekey="hdnCancelResource1" ClientIDMode="Static" Style="display: none;" />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Button ID="btnPostback" runat="server" Text="" Style="display: none;" ClientIDMode="Static" OnClick="btnPostback_Click" />
            <asp:HiddenField ID="hdnSelectedTab" runat="server" />
               <div class="AvatarImage_Container" id="AvatarImage_Container">
                    <div class="avatar_profile" id="avatar_profile">
                        <asp:Image ID="imgAvatar" CssClass="avatar_profile_img" runat="server" Width="80px" Height="80px" ImageUrl="~/Images/no_avatar.png" meta:resourcekey="imgAvatar" onclick="Profile();" />
                    </div>
                    <div class="avatar_profile_content" id="avatar_profile_content_Head">
                        <asp:Label ID="lblWelcome" CssClass="avatar_profile_content_text" runat="server" Text="Welcome," meta:resourcekey="lblWelcomeResource1"></asp:Label>
                        <asp:Label ID="lblName" CssClass="avatar_profile_content_text" runat="server" meta:resourcekey="lblNameResource1"></asp:Label>
                      <%-- Start workable Message show under the welcome field --%>

                        <%--<div class="avatar_profile_content_text2" id="avatar_profile_content_text2">
                            <asp:Localize ID="lblstatement" runat="server" meta:resourcekey="lblstatementResource1" Text="
                                &lt;p&gt;
                                    Choose a friend from the list below to talk to &lt;/p&gt;&lt;p&gt;or click  New Friend to make a new friend
                                &lt;/p&gt;
                            "></asp:Localize>
                        </div>--%>

                         <%-- End workable Message show under the welcome field --%>
                    </div>
                    <div class="btnDiscoverNewFriends_container" id="btnDiscoverNewFriends_container">
                        <%--<div class="btndnf_cmd" id="btndnf_cmd">
                            <asp:Label runat="server" ClientIDMode="Static" id="replyfirst" meta:resourcekey="replyfirstResource1" Text="You have many unread messages, please reply first before you can use Make New Friends"></asp:Label>
                            <asp:Button ID="btnDisconverNewFriends" CssClass="btnDiscoverNewFriends" Style="background-image: url('../Images/new/add friends.png'); background-color: Transparent; cursor: pointer; background-repeat: no-repeat; background-position: left; padding-left: 15px; background-size: 300px; text-align: center; display:none;" Height="62px" BorderStyle="None" Width="300px" runat="server" Text="Make New Friends" ClientIDMode="Static" OnClientClick="DiscoverNewFriends(); return false;" meta:resourcekey="btnDisconverNewFriendsResource1" />
                            <asp:ImageButton runat="server" ID="imgReplyFirst" CssClass="imgReplyFirst" ClientIDMode="Static" ImageUrl="~/Images/new/reply.png" AlternateText="Add new Friends" OnClientClick="return false;"/>
                            <asp:ImageButton runat="server" ID="imgAddFriends" CssClass="imgAddFriends" ClientIDMode="Static" ImageUrl="~/Images/AddNewFriends.png" OnClientClick="DiscoverNewFriends(); return false;" AlternateText="Add new Friends" />
                        </div>--%>
                    </div>
                </div>
            <div class="Home_left_Container" id="Home_left_Container">
             

                <div class="Tabs_Container" id="Tabs_Container">
                    <div id="tabs" style="display: none;">
                        <div class="tabs_menu_container">
                            <ul class="tabs_header" id="tabs_header">
                                <li>
                                    <asp:HyperLink ID="HyperLink2" href="#tab1" runat="server" Text="Friends" meta:resourcekey="HyperLink2Resource1" /></li>
                                <li>
                                    <asp:HyperLink ID="HyperLink1" href="#tab2" runat="server" Text="Online Friends" meta:resourcekey="HyperLink1Resource1" /></li>
                                <li>
                                    <asp:HyperLink ID="HyperLink3" href="#tab3" runat="server" Text="New Palaygo Joiner" meta:resourcekey="HyperLink3Resource1" /></li>
                            </ul>
                        </div>
                        <div class="tab1" id="tab1">
                            <asp:Button ID="btnContinuetab1" CssClass="continue" meta:resourcekey="ContinueTabResource1" runat="server" Style="float: right;" ClientIDMode="Static" OnClientClick="return SendToAllFriends('2');" />
                            <div style="clear: both;"></div>
                            <asp:Repeater ID="rptFriends" runat="server" ClientIDMode="Static">
                                <HeaderTemplate>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div id="divUsers" class="userBlock" onclick="SelectUser(this);" data-userid="<%# Eval("UserID") %>" data-firstname="<%# Eval("FirstName") %>">
                                        <div style="float: left;">
                                            <asp:Image CssClass="tab1-img-avatar" ID="imgAvatar" runat="server" Width="65px" Height="65px" ImageUrl='<%# Eval("Avatar") %>' meta:resourcekey="imgAvatarResource2" />
                                        </div>
                                        <div style="float: left; margin-left: 10px;">
                                            <span class="tab1-name"><%#Eval("UserName") %><br />
                                                <%#Eval("FirstName") %></span><br />
                                            <span class="tab1-add"><%#Eval("Address") %></span><br />
                                            <span class="tab1-stat">
                                                <asp:Image ID="imgStatus" runat="server" ImageUrl='<%# Eval("StatusImage") %>' meta:resourcekey="imgAvatarResource2" /><%# Eval("OnlineStatusText") %></span><br />
                                        </div>
                                        <%--  <div style="float:right;">
                                                <span><asp:Image CssClass="tab-mail-image" ID="Image1" runat="server" ImageUrl="~/Images/mail.png" Width="21px" Height="14px"  meta:resourcekey="imgAvatarResource2" /><%# Eval("MessageCount") %></span><br />
                                            </div>--%>
                                        <div style='clear: both;'></div>
                                        <div>
                                            <asp:Image ID="Image2" CssClass="imglike" runat="server" ImageUrl='<%# Eval("LikeImage") %>' Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="imgAvatarResource2" />
                                            <asp:Label ID="lblLikeCount" CssClass="likecount" runat="server" Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="lblLikeCountResource2"><%#Eval("LikeCount") %></asp:Label>
                                            <span style="text-wrap: normal; word-wrap: break-word; font-style: italic; font-weight: bold;"><%#Eval("StatusText") %></span>
                                            <asp:Label ID="lblStatusDate" runat="server" Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="lblStatusDateResource2"><%#Eval("StatusDateText") %></asp:Label>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="tab2" id="tab2">
                            <asp:Button ID="btnContinuetab0" CssClass="continue" meta:resourcekey="ContinueTabResource1" runat="server" Style="float: right;" ClientIDMode="Static" OnClientClick="return SendToAllFriends('1');" />
                            <div style="clear: both;"></div>
                            <asp:Repeater ID="rptOnlineFriends" runat="server" ClientIDMode="Static">
                                <HeaderTemplate>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div id="divUsers" class="userBlock" role="button" onclick="SelectUser(this);" data-userid="<%# Eval("UserID") %>" data-firstname="<%# Eval("FirstName") %>">
                                        <div style="float: left;">
                                            <asp:Image CssClass="tab1-img-avatar" ID="imgAvatar" runat="server" Width="65px" Height="65px" ImageUrl='<%# Eval("Avatar") %>' meta:resourcekey="imgAvatarResource2" />
                                        </div>
                                        <div style="padding-left: 8px; float: left;">
                                            <span class="tab1-name"><%#Eval("UserName") %><br />
                                                <%#Eval("FirstName") %> </span>
                                            <br />
                                            <span class="tab1-add"><%#Eval("Address") %></span><br />
                                            <span class="tab1-stat">
                                                <asp:Image ID="imgStatus" runat="server" ImageUrl='../Images/online.png' meta:resourcekey="imgAvatarResource2" />Online Now</span><br />
                                        </div>
                                        <%--  <div class="tab-mail-image" style="float:right;">
                                                <span><asp:Image CssClass="tab-mail-image" ID="Image1" runat="server" ImageUrl="~/Images/mail.png" Width="21px" Height="14px"  meta:resourcekey="imgAvatarResource2" /><%# Eval("MessageCount") %></span><br />
                                            </div>--%>
                                        <div style='clear: both;'></div>
                                        <div>
                                            <asp:Image ID="Image2" CssClass="imglike" runat="server" ImageUrl='<%# Eval("LikeImage") %>' Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="imgAvatarResource2" />
                                            <asp:Label ID="lblLikeCount" CssClass="likecount" runat="server" Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="lblLikeCountResource1"><%#Eval("LikeCount") %></asp:Label>
                                            <span style="text-wrap: normal; word-wrap: break-word; font-style: italic; font-weight: bold;"><%#Eval("StatusText") %></span>
                                            <asp:Label ID="lblStatusDate" runat="server" Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="lblStatusDateResource1"><%#Eval("StatusDateText") %></asp:Label>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="tab3" id="tab3">
                            <asp:Button ID="btnContinuetab2" CssClass="continue" meta:resourcekey="ContinueTabResource1" runat="server" Style="float: right;" ClientIDMode="Static" OnClientClick="return SendToAllFriends('3');" />
                            <div style="clear: both;"></div>
                            <asp:Repeater ID="rptNew" runat="server" ClientIDMode="Static">
                                <HeaderTemplate>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div id="divUsers" class="userBlock" role="button" onclick="SelectUser(this);" data-userid="<%# Eval("UserID") %>" data-firstname="<%# Eval("FirstName") %>">
                                        <div style="float: left;">
                                            <asp:Image CssClass="tab1-img-avatar" ID="imgAvatar" runat="server" Width="65px" Height="65px" ImageUrl='<%# Eval("Avatar") %>' meta:resourcekey="imgAvatarResource2" />
                                        </div>
                                        <div style="float: left; margin-left: 10px;">
                                            <span class="tab1-name"><%#Eval("UserName") %><br />
                                                <%#Eval("FirstName") %></span><br />
                                            <spa class="tab1-add" n><%#Eval("Address") %></spa>
                                            <br />
                                            <span class="tab1-stat">
                                                <asp:Image ID="imgStatus" runat="server" ImageUrl='<%# Eval("StatusImage") %>' meta:resourcekey="imgAvatarResource2" /><%# Eval("OnlineStatusText") %></span><br />
                                        </div>
                                        <%-- <div style="float:right;">
                                                <span><asp:Image CssClass="tab-mail-image" ID="Image1" runat="server" ImageUrl="~/Images/mail.png" Width="21px" Height="14px"  meta:resourcekey="imgAvatarResource2" /><%# Eval("MessageCount") %></span><br />
                                            </div>--%>
                                        <div style='clear: both;'></div>
                                        <div>
                                            <asp:Image ID="Image2" CssClass="imglike" runat="server" ImageUrl='<%# Eval("LikeImage") %>' Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="imgAvatarResource2" />
                                            <asp:Label ID="lblLikeCount" CssClass="likecount" runat="server" Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="lblLikeCountResource3"><%#Eval("LikeCount") %></asp:Label>
                                            <span style="text-wrap: normal; word-wrap: break-word; font-style: italic; font-weight: bold;"><%#Eval("StatusText") %></span>
                                            <asp:Label ID="lblStatusDate" runat="server" Visible='<%# Eval("StatusText") != null %>' meta:resourcekey="lblStatusDateResource3"><%#Eval("StatusDateText") %></asp:Label>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                     
                    <div class="Search_Container" id="Search_Container">
                      

                        
                        <div class="palaygo-news-title">
                             <img src="../Images/new/Newspaper.png" style="height: 30px; width:30px" />
                            Palaygo news

                        </div>
                        <img src="../Images/new/news.png" class="imgNews" />
                       
                        <div class="new_notice_content">
                            <asp:Label ID="lblNotice" runat="server" meta:resourcekey="lblNoticeResource1"></asp:Label>
                        </div>

                    </div>
                </div>

            </div>
            <div id="discovernewfriendDialog" class="discovernewfriendDialog" style="display: none; overflow: hidden;">
                <div style="border-bottom-style: ridge; border-bottom-width: 1px; border-bottom-color: #e1dcdc;">
                    <asp:ImageButton ID="btnWriteNewMessage" ImageUrl="~/Images/new/send many.png" CssClass="btnWriteNewMessage_home" runat="server" ClientIDMode="Static"  OnClientClick="WriteNewMessage();" OnClick="btnWriteNewMessage_Click" />
                    <img id="btnCancel" class="btnCancel_home" onclick="WriteNewMessageCancel(); return false;" src="../Images/new/cancel.png" />
                    <%--<asp:Button ID="btnWriteNewMessage" CssClass="btnWriteNewMessage_home" runat="server" Text="Send mail to all below users" meta:resourcekey="btnWriteNewMessageResource1" ClientIDMode="Static" BorderStyle="None" Style="text-align: center;" OnClientClick="WriteNewMessage();" OnClick="btnWriteNewMessage_Click"/>--%>
                    <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" ClientIDMode="Static" CssClass="btnCancel_home" Height="62px" Width="150px" meta:resourcekey="btnCancelResource1" OnClientClick="WriteNewMessageCancel(); return false;" />--%>
                    <asp:Label ID="lblComment" runat="server" ClientIDMode="Static" meta:resourcekey="lblCommentResource1" Style="text-align: center; display: block;"></asp:Label>
                </div>
                <div id="results" style="overflow: scroll; height: 300px;">
                </div>
                <div style="border-top-style: ridge; border-top-width: 1px; border-top-color: #e1dcdc;">
                    <asp:Label ID="lblSearchTitle" runat="server" ClientIDMode="Static" Text="Search" Style="text-align: center; display: block;" Font-Size="Large" Font-Bold="true"></asp:Label>
                    <asp:CheckBoxList ID="chkInterestGroup" CssClass="CheckboxList" CellPadding="5" CellSpacing="5" runat="server" DataTextField="InterestName" DataValueField="InterestID" ClientIDMode="Static" RepeatDirection="Horizontal" BorderColor="Control" BorderStyle="Solid" BorderWidth="1px" Width="100%" meta:resourcekey="chkInterestGroupResource1"></asp:CheckBoxList>
                    <div class="country_city_search" id="country_city_search">
                        <div class="container_country_city" id="container_country_city">
                            <div class="container_country" id="container_country" style="display: none;">
                                <asp:Label ID="lblCountry" CssClass="container_country_city_lbl" runat="server" Text="Country" AssociatedControlID="ddlCountry" meta:resourcekey="lblCountryResource1"></asp:Label>
                                <asp:DropDownList ID="ddlCountry" CssClass="slctCountry" runat="server" Width="100px" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="True" meta:resourcekey="ddlCountryResource1"></asp:DropDownList>
                            </div>
                            <div class="container_city" id="container_city">
                                <asp:Label ID="lblCity" CssClass="container_country_city_lbl" runat="server" Text="City" AssociatedControlID="ddlCity" meta:resourcekey="lblCityResource1"></asp:Label>
                                <asp:DropDownList ID="ddlCity" CssClass="slctCity" runat="server" Width="100px" meta:resourcekey="ddlCityResource1" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                            <div class="search_email_name" id="search_email_name">
                                <asp:Label ID="lblSearchName" CssClass="search_email_name_lbl" runat="server" Text="Email or Name" AssociatedControlID="txtSearch" meta:resourcekey="lblSearchNameResource1"></asp:Label>
                                <div class="se_container" id="se_container">
                                    <div class="txtsearch_container" id="txtsearch_container">
                                        <asp:TextBox ID="txtSearch" CssClass="txtsearch_box" runat="server" Width="350px" meta:resourcekey="txtSearchResource1" ClientIDMode="Static"></asp:TextBox>
                                        <asp:ImageButton CssClass="home-search-btn" ID="imgSearch" BackColor="Transparent" BorderColor="Transparent" ImageUrl="~/Images/SearchF.png" runat="server" Width="12px" Height="13px" ClientIDMode="Static" meta:resourcekey="ImageButton1Resource1" style="display:none;" />
                                    </div>
                                </div>
                            </div>
                            <div>
                                <asp:CheckBoxList ID="chkGenderList" runat="server" ClientIDMode="Static" CssClass="CheckboxList">
                                    <asp:ListItem Text="Male" Value="Male" meta:resourcekey="chkMaleResource1"></asp:ListItem>
                                    <asp:ListItem Text="Female" Value="Female" meta:resourcekey="chkFemaleResource1"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="Home_Right_Container" id="Home_Right_Container">
                <asp:LinkButton ID="linkHasMessages" runat="server" Visible="false" Style="margin-top: -30px; font-size: 12pt !important; color: #808080;" CssClass="avatar_profile_content_text" Text="You have received new messages! Letʼs reply!" PostBackUrl="~/Student/MailBox.aspx" meta:resourcekey="linkHasMessagesResource1" ClientIDMode="Static"></asp:LinkButton>
                <div style="margin-top: 10px;text-align: center;">
                    
                    <div class="starCountContainer" style="display:none">
                        <img src="../Images/like_star.png" style="margin-top: -20px;float:left;" />
                        <%--<span class="avatar_profile_content_text" style="position: absolute; font-weight: bold;">!</span>--%>
                        <asp:Label ID="lblStar" runat="server" Style="float: left; font-size: 12pt !important;" CssClass="avatar_profile_content_text" Text="You have " meta:resourcekey="lblHasMessagesResource1" ClientIDMode="Static" />
                        <asp:Label ID="lblStartCount" runat="server"  Text="0" ClientIDMode="Static" />
                    </div>
                </div>

                <div class="New_Notice_Container" id="New_Notice_Container">
                    <div id="divNews" class="divNews">
                         <div class="palaygo-resources">
                               <img src="../Images/new/Resources.png" style="height: 30px; width:30px"/>
                             Resources</div>
                        <img src="../Images/new/ranking.png" class="imgRanking" />
<%--                        <div class="Tnews_notice_lbl">
                            <asp:Label ID="lblRankingLabel" runat="server" meta:resourcekey="lblRankingLabelResource1" Text="Ambassador Ranking"></asp:Label>
                            <asp:HyperLink ID="lblJapanNewsLabel" CssClass="Tnews_notice_lbl" BackColor="Transparent" runat="server" meta:resourcekey="lblJapanNewsLabelResource1" Visible="false">HyperLink</asp:HyperLink>
                        </div>--%>
                       
                        <div class="Tnew_notice_content">
                            <div>
                                <asp:Repeater ID="rptRanking" runat="server">
                                   <%-- <HeaderTemplate>
                                        <table style='text-align: center; width: 100%;' id="tblRanking">
                                            <th>
                                                <asp:Label ID="lblRankLabel" runat="server" Text="Rank" meta:resourcekey="lblRankLabelResource1"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lblAvatar" runat="server" Text=""></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lblUsernameLabel" runat="server" Text="Name" meta:resourcekey="lblUsernameLabelResource1"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lblSchoolCodeLabel" runat="server" Text="Code" meta:resourcekey="lblSchoolCodeLabelResource1"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lblCountryLabel" runat="server" Text="Country" meta:resourcekey="lblCountryLabelResource1"></asp:Label></th>
                                            <th>
                                                <asp:Label ID="lblCountLabel" runat="server" Text="Count" meta:resourcekey="lblCountLabelResource1"></asp:Label></th>
                                    </HeaderTemplate>--%>
                                   <%-- <ItemTemplate>
                                        <tr class="rowrankselect" onclick="SelectAmbassador(this);" data-userid="<%#Eval("UserID") %>" data-flag="<%#Eval("Flag") %>" data-level="<%#Eval("LevelID") %>">
                                            <td><%#Eval("Ranking") %><span data-ranking="<%#Eval("Ranking") %>" class="scr"></span></td>
                                            <td>
                                                <img src="../Images/avatar/<%#Eval("Avatar") %>" style="width: 32px; height: 32px;" /></td>
                                            <td><span class="spanUserName"><%#Eval("FirstName") %><span></td>
                                            <td><span class="spanSchoolCode"><%#Eval("SchoolCode") %><span></td>
                                            <td>
                                                <img style="width: 24px; height: 24px;" src="../images/<%#Eval("Flag") %>" alt="" /></td>
                                            <td><%#Eval("Points") %></td>
                                        </tr>
                                    </ItemTemplate>--%>

                                   <%-- <FooterTemplate></table></FooterTemplate>--%>

                                </asp:Repeater>
                                <div style="padding: 15px; height: 180px; border: 1px solid #B4B4B4; margin-top: 15px; border-radius: 8px">
                                    <li class="resources-list-item" onclick="EnglishResource()">English Learner Resources</li>
                                      <li class="resources-list-item" onclick="JapaneseResource()">Japanese Learner Resources</li>
                                </div>

                                <div style="padding: 15px; height: 180px; border: 1px solid #B4B4B4; margin-top: 15px; border-radius: 8px">
                                     <img class="home-page-image" src="../Images/new/learn.jpeg" />
                                </div>
                                <div>

                                </div>
                            </div>
                            <asp:Label ID="lblNews" runat="server" meta:resourcekey="lblNewsResource1" Visible="false"></asp:Label>
                        </div>
                        <%--</div>
                    <div id="divImportantNotice" class="divImportantNotice">--%>
                        <%--                        <div class="news_notice_lbl">
                            <asp:HyperLink ID="lblNoticeLabel" CssClass="news_notice_lbl" BackColor="Transparent" runat="server" meta:resourcekey="lblNoticeLabelResource1">HyperLink</asp:HyperLink>
                        </div>
                        <div class="new_notice_content">
                            <asp:Label ID="lblNotice" runat="server" meta:resourcekey="lblNoticeResource1"></asp:Label>
                        </div>--%>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
