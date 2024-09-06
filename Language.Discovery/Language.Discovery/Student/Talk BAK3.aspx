<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Talk.aspx.cs" Inherits="Language.Discovery.Talk" ValidateRequest="false" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content> 
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <%--thanks to http://findicons.com/icon/69363/circle_orange?id=69415 and http://www.icons-land.com/ --%>
    <%--thanks to http://www.androidicons.com/ for the chat icon--%>
    <script src="../Scripts/easyPaginate.js" type="text/javascript"></script>
    <script src="../Scripts/playsound.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.tmpl.min.js" type="text/javascript"></script>
    <script src="../Scripts/Others.js?sdfs" type="text/javascript"></script>
    <link href="../colorbox/colorbox.css" rel="stylesheet" />
    <script src="../colorbox/jquery.colorbox.js"></script>
    <script src="../Scripts/bootstrap-paginator.min.js"></script>
    <script src="../Scripts/bootstrap-switch.min.js"></script>
    <link href="../App_Themes/Default/bootstrap-switch.css" rel="stylesheet" />
    <script src="../Scripts/jquery.simplePagination.js"></script>
    <link href="../App_Themes/Default/simplePagination.css?1234" rel="stylesheet" />
    <script src="../Scripts/buzz.min.js"></script>
    <script src="../Scripts/jquery.ui.position.min.js"></script>
    <script src="../Scripts/contextMenu.min.js"></script>
    <link href="../App_Themes/Default/contextMenu.css" rel="stylesheet" />
    <script src="../Scripts/jquery.ui.touch-punch.min.js"></script>
    <link href="../App_Themes/Default/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-clearsearch.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.signalR-2.2.0.min.js"></script>
     <script src="../signalr/hubs"></script>
    <script src="../Scripts/jquery.touchSwipe.min.js"></script>
    <script src="../Scripts/moment.js"></script>
    <script src="../Scripts/jquery.blockUI.js"></script>
    <%--<script src="../Scripts/VideoHelper.js"></script>--%>
    <script src="../Scripts/jQuery.countdownTimer.min.js"></script>
    <script src="../Scripts/VideoPlatformApi.js?123d1fgf32sds2"></script>
    <link href="../App_Themes/Default/DefaultTalk.css?11" rel="stylesheet" />
    <link rel="stylesheet" media="only screen and (max-width: 1024px), only screen and (max-device-width: 1024px) and (orientation:landscape)" href="../App_Themes/Default/MobileDefaultTalk.css?1" type="text/css" />
    <link rel="stylesheet" media="only screen and (max-width: 900px), only screen and (max-device-width: 900) and (orientation:portrait)" href="../App_Themes/Default/MobileDefaultTalk900.css?1" type="text/css" />
    <style type="text/css">
        @import url('https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@700&display=swap');
 .ui-tooltip, .arrow:after {
     background: #B9FCFF;
    /*background: linear-gradient(to bottom, rgba(32,124,202,1) 37%,rgba(32,124,202,1) 37%,rgba(32,124,202,1) 38%,rgba(32,124,202,1) 38%,rgba(32,124,202,1) 39%,rgba(32,124,202,1) 39%,rgba(125,185,232,1) 100%);*/
    border: 2px solid white;
}
 
 .message {
             /*background:#c9c9c9;*/
             background-color: rgb(252, 234, 187);
             cursor:pointer;
         }
.ui-tooltip {
    padding: 10px 20px;
    color: #333286;
    border-radius: 20px;
    font: bold 14px"Helvetica Neue", Sans-Serif;
    text-transform: uppercase;
    box-shadow: 0 0 7px black;
}
        /*.rdoCriteriaList {
            margin-top:0px !important;
        }*/
        .rdoCriteriaList label{
            font-size:x-small;
            font-weight:lighter !important;
            display:inline-block;
        }
        /*.sortable > div { float: left; margin:2px; }*/
        .highlight {
            border: 1px solid red;
            background-color: lightblue;
            padding-left:5px;
            float:left;
            margin-left:10px;
            }
        #divFinalLearningMessage{
            float:left;
            width:49%;
        }

    #divFinalNativeMessage{
        float:right;
        width:49%;
    }

img{border:none; float:left;margin-top:2px; line-height:0;}

        div.emoji
          {
          margin:2px;
          border:1px solid gray;
          height:auto;
          width:auto;
          float:left;
          text-align:center;
          cursor:pointer;
          }
        div.emoji img
          {
          display:inline;
          margin:3px;
          border:1px solid #ffffff;
          }
        div.emoji a:hover img
          {
          border:1px solid #0000ff;
          }

        div.punctuation
          {
          margin:2px;
          border:1px solid gray;
          height:auto;
          width:auto;
          float:left;
          text-align:center;
          cursor:pointer;
          }
      .firstword {
          /*display: inline-block !important;*/
      }
      .secondword{
          /*display: inline-block !important;*/
      }
    .paletteContainer span
    {
        /*display: inline-block !important;*/
    }

/*li{
	list-style:none;
	float:left;
	display:inline;
	margin-right:10px;
}*/

        .pallete {
            width:100%;
            height:100%;
            vertical-align:middle;
            margin-top:auto;
            margin-bottom:auto;
            background-color:transparent;

            /*border: 4px solid red;*/
            
            /*box-shadow: 1px 1px 1px 0px rgba(0, 0, 0, 0.4), 1px 1px 1px 0px rgba(255, 255, 255, 0.8);
            border-radius:1px;
            background:rgba(0, 0, 0, 0.1);*/
        }
        .pallete ul {
            margin-left:45px;
        }

    .items .ui-selecting { background: #FECA40; }
    .items .ui-selected { background: #F39814; }
    
    .pallete:hover {
            background-color:silver;
        }



/*  */
        .firstword
        {
            /*margin-right:10px !important;*/
        }
        .thirdword
        {
            margin-right:10px !important;
           
        }
#screenshot{
	position:absolute;
	border:1px solid #ccc;
	background:#333;
	padding:5px;
	display:none;
	color:#fff;
	}

          #UpdatePanel1, #UpdatePanel2 { 
      width:300px; height:100px;
     }

          .tblrow {
            border: 4px inset red;
            height:30PX;
        }

        /*.tdcolumn {
            width:25%;
        }*/
        
	.items{		
		margin: 0;
        padding:0;
		width:100%;
		/*height:100%;*/
		overflow:hidden;
        border: 1px solid gray;
		}
        .items li {
            list-style: none;
            float: left;
            height: auto;
            padding: 1px 1px 3px 1px;
            margin:0;
            overflow: visible;
            height: 35px;
            align-items:center
            /*border: 1px solid red;*/
            
           /* margin: 0 4px;
            background: #DBDAE0;
            color: #fff;
            text-align: center;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -moz-box-shadow: 0 1px 1px #777;
            -webkit-box-shadow: 0 1px 1px #777;
            box-shadow: 0 1px 1px #777;
            color: #555;*/
        }
	ul.items li:hover{color:#333;}
	
	ul.items h3{text-transform:uppercase;
                font-size:14px;
                font-weight:bold;
                margin:.25em 0;
                text-shadow:#f1f1f1 0 1px 0; }	
	ul.items .info{color:#999;text-shadow:#f1f1f1 0 1px 0;}
    .secondword
    {
        font-weight:bolder;
    }

    /*----Start Vertical Tab----*/
    /*.ui-tabs-vertical { width: 55em; }*/
    
    .ui-tabs-vertical > .ui-tabs-nav { /*padding: .2em .2em 14em .1em;*/ 
                                     float: right; 
                                     width: 4em;
                                     width: 1.7em !important; 
                                     background-color:transparent; 
    }
    .ui-tabs-vertical > .ui-widget-header
    {
        background-image: url('');
        color:transparent;  
        border-top-color: silver;
        border-left-color: silver;
        border-right-color: transparent;
        border-bottom-color: silver;
        height:100%;
        

    }
    .ui-tabs .ui-tabs-nav{
        float:left;

    }
        #wordTabsContainer > .ui-tabs .ui-tabs-nav {
            float:right !important;
        }
   .ui-tabs-vertical > .ui-tabs-nav li { /*clear: left;*/ 
                                        width: 100%;
                                        /*width: 30px !important;*/
                                        /*min-height:90px;*/ 
                                        border-bottom-width: 1px !important; 
                                        border-left-width: 0 !important; 

    }
   .ui-tabs-vertical > .ui-tabs-nav li a { display: block;

    }
    .ui-tabs-vertical > .ui-tabs-nav li.ui-tabs-selected { padding-bottom: 0; 
                                                         padding-left: .1em; 
                                                         border-right-width: 1px; 
                                                         margin-left: -2px; }
    .ui-tabs-vertical > .ui-tabs-panel { padding: 1em;width: 51em;}

    
     /*----End Vertical Tab----*/
    .show_addword
    {
        /*visibility:visible !important;*/
        display:inline-block !important;
    }
    .no-titlebar .ui-dialog-titlebar
    {
        display:none;
    }
    .ui-dialog
    {
        z-index:1000000;
    }
.pallete
{
    position:relative;
}
.chkAddToMyPhrases {
    position: absolute;
    bottom: 26px;
    left: 14px;
    width: 15px;
    height: 15px;
}


#ulInstruction {
    list-style: none;
    list-style-position: outside;
    text-indent: -1.7em;
    padding-left: 1em;
    margin-left: 13px;
}

        #ulInstruction>li>span {
            font-size: 14px !important;
            padding-left: 10px;
            font-weight: bold;
        }
ul#ulInstruction > li:before {
  content: '✓';
}

        #ulSubInstruction {
            list-style: none;
        }
        ul#ulSubInstruction > li:before {
            content: '\2756';
        }
        #ulSubInstruction > li > span {
            padding-left: 10px;
        }


  /*----End Vertical Tab----*/
    </style>
<!--[if IE]>
<style type="text/css">
    .btnsend_count_cmd{
        top:-22px !important;
        left:8px !important;
    }
    .tabs_links_menu .send-msg-tabs1 {
        top:10px !important;
        left:-2px !important;
    }

    .tabs_links_menu .send-msg-tabs2 {
        top:10px !important;
        left:-2px !important;
        
    }  
</style>
<![endif]-->
    <script type="text/javascript">
        var interval = null;
        var $sound = null;
        var configParams = {};
        var _KeepAlive;
        var _callAnswered = false;
        var _roomparameter = "";
        var _roomKeyParameter = "";
        var _fromparameter = "";
        var _groupparameter = "";
        var _currentTab = 0;
        var _currentWordTab = 0;
        var _SomeoneIscalling = false;
        var charactersLeftText = $('#lblcharleftLabel1').text();
        var _caller = "";
        var _isCallStop = false;
        var _wordTabDialogOpen = false;
        configParams.autoJoin = "0";
        configParams.enableDebug = "1";
        configParams.microphonePrivacy = "0";
        configParams.cameraPrivacy = "0";
        configParams.webrtcLogLevel = "0";
        configParams.isIE = false;
        configParams.hideConfig = "0";
        configParams.numRemoteSlots = 3;
        configParams.localCameraDisplayCropped = true;
        configParams.remoteCameraDisplayCropped = true;
        configParams.enableDebug = "1";

        function pageLoad() {
            //receiver, from, room, group
            //trigger the call after the selected user is done executing
            //let from = sessionStorage.getItem("from");
            //let room = sessionStorage.getItem("room");
            //let group = sessionStorage.getItem("group");
            //let roomKey = sessionStorage.getItem("roomKey");
            //if (roomKey != undefined && roomKey.length > 0) {
               
            //    _roomKeyParameter = roomKey;
            //    _groupparameter = group;
            //    _fromparameter = from;
            //    _roomparameter = room;
            //    sessionStorage.removeItem("from");
            //    sessionStorage.removeItem("room");
            //    sessionStorage.removeItem("group");
            //    sessionStorage.removeItem("roomKey");

            //}
            //if (_callAnswered === true || (roomKey != undefined && roomKey.length > 0)) {
            if (_callAnswered === true) {
                //$(this).dialog("close");
                //GetVideoKey();
                $('#btnCallIcon').addClass("callStart");
                loadVidyoClientLibrary(true, true, _roomKeyParameter, $("#hdnCurrentUserName").val(), false);
                //$(".divMessage").toggleClass("divMessageWithVideo");
                //FindUser(from);
                $("#renderer0").show();
                $("#renderer01").show();
                $("#renderer01_timesSection").show();
                $("#divCall_01").show();
                //$("#renderer01_bottomSection").show();
                Ring(false);
                
                //_SomeoneIscalling = false;
                if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                    $.connection.hub.start().done(function () {
                        chat.server.answered(_groupparameter, $("#hdnCurrentUserName").val(), _roomKeyParameter);
                    });
                } else {
                    chat.server.answered(_groupparameter, $("#hdnCurrentUserName").val(), _roomKeyParameter);
                }
                AddConferenceRoom(_roomparameter, _fromparameter, $("#hdnCurrentUserName").val(), _roomKeyParameter);

            }
            else {
                _SomeoneIscalling = false;
                _roomparameter = "";
                _fromparameter = "";
                _roomKeyParameter = "";
                _groupparameter = "";
            }
            _callAnswered = false;
            
            if ($("#hdnIsPostBack").val() == "1") {
                $("#hdnIsPostBack").val("0");
                let from = sessionStorage.getItem("from");
                let room = sessionStorage.getItem("room");
                let group = sessionStorage.getItem("group");
                let roomKey = sessionStorage.getItem("roomKey");
                let receiver = sessionStorage.getItem("receiver");
                sessionStorage.removeItem("from");
                sessionStorage.removeItem("room");
                sessionStorage.removeItem("group");
                sessionStorage.removeItem("roomKey");
                sessionStorage.removeItem("receiver");
                if (from != null && from != undefined) {
                    userIsCalling(receiver, from, room, group, roomKey);
                }
            }

        }
        function setIsPostBack() {
            $("#hdnIsPostBack").val("1");
        }

        function getParameterByName(name, url = window.location.href) {
            name = name.replace(/[\[\]]/g, '\\$&');
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }

        function Translate(sl, tl, word, target, origin) {
            if (word.trim().length == 0)
                return;

            var translatedtext = "";
            $('#imgTranslating').show();
            $('#imgTranslating2').show();
            var json = {
                Type: 'translate',
                sourceText: word,
                sourceLang: sl,
                targetLang: tl
            };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var json = JSON.stringify(data);
                json = json.replace(/\\n/g, '');
                var obj = $.parseJSON(JSON.parse(json));
                if (obj.Status == "True") {
                    $(target).val(obj.translatedText);
                    $('#imgTranslating').hide();
                    $('#imgTranslating2').hide();

                    //checkMessage(origin);
                }
                else
                    alert('Error translating word(s). Please check your network or internet.');
            });
        }

        function AutoTranslate(sl, tl, word, target) {
            if (word.trim().length == 0)
                return;

            var translatedtext = "";
            $('#imgTranslating').show();
            $('#imgTranslating2').show();
            var json = {
                Type: 'translate',
                sourceText: word,
                sourceLang: sl,
                targetLang: tl
            };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data);
                if (obj.Status == "True") {
                    $(target).val(obj.translatedText);
                    $('#imgTranslating').hide();
                    $('#imgTranslating2').hide();
                    $('#txtFreeMessage1').val('');
                    $('#txtFreeMessage2').val('');
                   
                }
                else
                    alert('Error translating word(s). Please check your network or internet.');
            });
        }

        //let checkMessages = (origin) => {

        //    return new Promise((resolve, reject) => {

        //        try {
        //            resolve(checkMessage(origin));
        //        } catch (err) {
        //            reject(err)
        //        }

        //    })

        //};
        async function checkMessages(origin) {
            async function checkedmessage(origin) {
                return new Promise((resolve, reject) => {
                    var freeNative = origin == 'freemessage' ? $("#txtFreeMessage1").val() : $("#native").val();
                    var freeLearning = origin == 'freemessage' ? $("#txtFreeMessage2").val() : $("#learning").val();

                    var json = {
                        Type: 'filtermessage',
                        Message: freeNative + ' ' +  freeLearning,
                    };
                    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                        var obj = $.parseJSON(data)
                        if (obj.Status == "foul") {
                            //toastr.options = {
                            //    "closeButton": true,
                            //    "debug": false,
                            //    "newestOnTop": false,
                            //    "progressBar": false,
                            //    "positionClass": "toast-top-right",
                            //    "preventDuplicates": true,
                            //    "onclick": null,
                            //    "showDuration": "300",
                            //    "hideDuration": "5000",
                            //    "timeOut": "5000",
                            //    "extendedTimeOut": "1000",
                            //    "showEasing": "swing",
                            //    "hideEasing": "linear",
                            //    "showMethod": "fadeIn",
                            //    "hideMethod": "fadeOut",
                            //    "target": ".ui-dialog"
                            //}
                            
                            //toastr.error("Your message contains repetitive or bad words, and will not be sent.", "Error");
                            //if (origin == 'freemessage')
                            //    $("#dialogSave").button("option", "disabled", true);
                            //else
                            //    $("#wordDialogSave").button("option", "disabled", true);
                            reject(false);    
                        }
                        else {
                            //if (origin == 'freemessage')
                            //    $("#dialogSave").button("option", "disabled", false);
                            //else
                            //    $("#wordDialogSave").button("option", "disabled", false);

                            resolve(true);
                        }
                        
                    }).error(function (response) {
                        reject(false);
                        alert(respose.responseText)
                    });
                });
            }
            var result = await checkedmessage(origin);

            return result;

        }

        function sleepFor(sleepDuration) {
            var now = new Date().getTime();
            while (new Date().getTime() < now + sleepDuration) { /* do nothing */ }
        }

        //window.onbeforeunload = function () {
        //    //if (_isincall == true) {
        //    //    _isincall = false;
        //    //    $("#btncallicon").click();

        //    //    sleepfor(3000);
        //    //}
        //    UpdateTalkStatus("false");

        //    return null;
        //};
        //window.mobilecheck = function () {
        //    var check = false;
        //    (function (a, b) { if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) check = true })(navigator.userAgent || navigator.vendor || window.opera);
        //    return check;
        //}

        var m_selectedItem = null;
        var m_shouldstoppropacation = false;

        function IsArrayContains(a, regex) {
            for (var i = 0; i < a.length; i++) {
                if (a[i].search(regex) > -1) {
                    return i;
                }
            }
            return -1;
        }
        function InitializeTabs() {
            $('#palettetabs').tabs({
                activate: function (event, ui) { //bind click event to link
                    if (ui.newTab.index() == 1) {
                        $('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);
                    }
                }
            });
        }



        function UpdateSentenceCount(add) {
            //update the word count
            var count = $('#lblWordCount').text();
            if (add == true)
                count = parseInt(count) + 1;
            else
                count = parseInt(count) - 1;
            if (count < 0)
                count = 0;
            $('#lblWordCount').text(count.toString());
        }


        function AddFreeMessage() {

            var span1 = "<span>{0}</span>".stringformat($("#txtFreeMessage1").val());
            var span2 = "<span>{0}</span>".stringformat($("#txtFreeMessage2").val());
            var removemes1 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            var removemes2 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";


            $('#divFinalLearningMessage').append('<div>' + span2 + removemes1.stringformat() + '</div>');
            $('#divFinalNativeMessage').append('<div>' + span1 + removemes2 + '</div>');
            //UpdateSentenceCount(true);
            GetFinalMessage();
            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            sessionStorage.setItem('shouldCountNumberOfSentence', 'false');
        }

        function TextMe() {

            var span1 = "<span>Text Me</span>";
            var span2 = "<span>テキストチャットで送ってください。</span>";
            var removemes1 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            var removemes2 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";

            var lang = $('#hdnNativeLanguageCode').val();
            $('#divFinalLearningMessage').append('<div>' + (lang == "en-US" ? span2 : span1) + removemes1.stringformat() + '</div>');
            $('#divFinalNativeMessage').append('<div>' + (lang == "en-US" ? span1 : span2) + removemes2 + '</div>');
            //UpdateSentenceCount(true);
            GetFinalMessage();
            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            sessionStorage.setItem('shouldCountNumberOfSentence', 'false');
        }
        function PleaseRepeat() {

            var span1 = "<span>Please Repeat!</span>";
            var span2 = "<span>もう一度言ってください！</span>";
            var removemes1 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            var removemes2 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";

            var lang = $('#hdnNativeLanguageCode').val();

            $('#divFinalLearningMessage').append('<div>' + (lang == "en-US" ? span2 : span1) + removemes1.stringformat() + '</div>');
            $('#divFinalNativeMessage').append('<div>' + (lang == "en-US" ? span1 : span2) + removemes2 + '</div>');
            //UpdateSentenceCount(true);
            GetFinalMessage();
            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            sessionStorage.setItem('shouldCountNumberOfSentence', 'false');
        }

         function ThankYouForYourAdvice() {

            var span1 = "<span>Thank you for your advice!</span>";
            var span2 = "<span>アドバイスありがとう Thank you!</span>";
            var removemes1 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            var removemes2 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";

            var lang = $('#hdnNativeLanguageCode').val();

            $('#divFinalLearningMessage').append('<div>' + (lang == "en-US" ? span2 : span1) + removemes1.stringformat() + '</div>');
            $('#divFinalNativeMessage').append('<div>' + (lang == "en-US" ? span1 : span2) + removemes2 + '</div>');
            //UpdateSentenceCount(true);
             GetFinalMessage();
             addUserPoints('Advice', $('#hdnSelectedUserID').val());
            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            sessionStorage.setItem('shouldCountNumberOfSentence', 'false');
        }

        function ImReady() {
            var span1 = "<span>I'm Ready!</span>";
            var span2 = "<span>準備できました！</span>";
            var removemes1 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            var removemes2 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";

            var lang = $('#hdnNativeLanguageCode').val();
            $('#divFinalLearningMessage').append('<div>' + (lang == "en-US" ? span2 : span1) + removemes1.stringformat() + '</div>');
            $('#divFinalNativeMessage').append('<div>' + (lang == "en-US" ? span1 : span2) + removemes2 + '</div>');
            //UpdateSentenceCount(true);
            //var users = $('.divUsers[data-issupport="True"]');
            //if (users.length > 0) {
            //    users.each(function (item) {
            //        GetFinalMessage($(this).data("userid"));
            //    });
            //}
            GetFinalMessage();
            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            sessionStorage.setItem('shouldCountNumberOfSentence', 'false');
            clearAnimation();
            updateAttendance();
            $('#hdnSupportId').val('');
            $('#hdnButtonType').val('');
            clearImReadyTimer();
        }

        function Issues() {
            var span1 = "<span>I encountered an issue.</span>";
            var span2 = "<span>問題が発生しました。</span>";
            var removemes1 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            var removemes2 = "<img class='imgRemoveMessage' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";

            var lang = $('#hdnNativeLanguageCode').val();
            $('#divFinalLearningMessage').append('<div>' + (lang == "en-US" ? span2 : span1) + removemes1.stringformat() + '</div>');
            $('#divFinalNativeMessage').append('<div>' + (lang == "en-US" ? span1 : span2) + removemes2 + '</div>');
            //UpdateSentenceCount(true);
            //var users = $('.divUsers[data-issupport="True"]');
            //if (users.length > 0) {
            //    users.each(function (item) {
            //        GetFinalMessage($(this).data("userid"));
            //    });
            //}
            GetFinalMessage();
            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            sessionStorage.setItem('shouldCountNumberOfSentence', 'false');
            addUserPoints('Issues', 0);
            $('#hdnSupportId').val('');
            $('#hdnButtonType').val('');
            $('#ddlCategory').val($('#hdnTalkCategory').val());
            $('#ddlCategory').trigger('change');
        }

        function ValidateSentence() {
            var correctorder = '';
            var language = '.firstword';
            var key = 'sentence2Ordinal';
            //if ($('#<%=chkNative.ClientID%>').prop("checked")) {
            language = '.secondword';
            //key = 'sentence1Ordinal';
            //}

            $('#MainContent_divSentence ' + language).each(function () {
                var ordinal = $(this).attr('data-ordinal');
                ////var isemoji = $(this).attr('data-isemoji');
                var ispunctuation = $(this).attr('data-ispunctuation');

                if (ordinal != undefined) {
                    if (isemoji == undefined || ispunctuation == undefined)
                        correctorder += ordinal + ',';
                }

            });
            var result = false;
            if (sessionStorage.getItem(key).toString() == correctorder)
                result = true;



            return result;
        }

        function InitializePopOver() {

            $('#MainContent_divSentence').popover({
                container: 'body',
                delay: { hide: 0 },
                animation: false,
                trigger: 'manual',
                html: true,
                title: $('#hdnPunctuation').val(),
                placement: 'top',
                content: function () {
                    var el = $('.popper-content');
                    el.append("<img src='../Images/x.png' width='16' height='16' style='position:absolute;right:5px;top:0px;cursor:pointer' onclick=\"ClosePopOver(); \" />");

                    return el.html();
                    //return $(this).next('.popper-content').html();
                }
            });
        }

        function ClosePopOver() {
            $('#MainContent_divSentence').popover('hide');
        }

        function SetupPopOver() {
            InitializePopOver();
            $('#MainContent_divSentence').popover('show');
            $(".popover").draggable();
        }

        function SearchViaReply(el) {
            var keyword = $(el).closest("#trMessage").attr("data-keyword");
            $('#hdnKeywords').val(keyword);
            $('#hdnAutoSearch').val("1");
            $('#imgSearchSentence').click();


        }
        //function clickFunction_test(el) {
        //    alert("Hello", el);
        //    //var ulelement = $(element).closest('.items').clone();
        //    //alert(ulelement);
        //    // you can manipulate the ulelement here before appending to a div
        //    //$("#destinationDiv").append(ulelement);
        //}

        function aaaa(element) {
            //var ulelement = $(element).closest('.items').clone();
            //var ulelement = $(element).parent().item('.items').clone();
            var ulelement = $(element).clone();
            // you can manipulate the ulelement here before appending to a div
            $("#destinationDiv").append(ulelement);

        }

        function InitializeReplaceWordSettings(el) {
            $('#txtSearchSentence').val('');
            if (m_selectedItem != null) {
                EndEdit(m_selectedItem);
                //$('#rdoCriteriaList').find("input[value='0']").prop("checked", true);
                return;
            }
            //$('#rdoCriteriaList').find("input[value='1']").prop("checked", true);
            var elementid = $('#' + el.id).parent().parent().parent()[0].id;
            //$('#' + elementid).siblings().css("border", "1px solid black");
            //$('#' + elementid).css("border", "2px solid red");
            //m_selectedItem = $('#' + elementid);//.parent();
            ////m_shouldstoppropacation = true;
            //$('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");
            ////$("#btnAddWord").show();
            //$("#btnAddWord").toggleClass("show_addword");
            //$('#palettetabs').tabs("option", "active", 0);
            var keywords = "";
            $(el).parent().parent().siblings("span").each(function () {
                if ($(this).attr("data-keyword")) {
                    keywords = keywords + $(this).attr("data-keyword") + ";";
                }
            });

            $("#hdnWordType").val($(el).parent().parent().parent().attr("data-wordtype"));
            $("#hdnWordKeyword").val(keywords);
            $("#hdnPrepareWordReplaceElementID").val(elementid);
            $("hdnWordPage").val("1");
            $("#btnSearchWord").click();
            //$("#btnAddWord").toggleClass("show_addword");

            $("#btnAddWord").show();
            showWordDialog(3);
            //$('#wordTabsContainer').dialog({
            //    modal: true,
            //    width: 996,
            //    open: function () {
            //        $('.ui-dialog').css("z-index", '9999');
            //    },
            //    buttons: {
            //        Ok: function () {
            //            $(this).dialog("destroy");
            //            $('#wordTabsContainer').show();
            //        }

            //    },
            //    close: function () {
            //        $(this).dialog("destroy");
            //        $('#wordTabsContainer').show();
            //    }

            //});
            //$("#wordTabsContainer").parent().appendTo($("form:first"));



        }

        function showWordDialog(index) {
            $('#wordTabsContainer').dialog({
                modal: true,
                width: 996,
                height: 370, 
                position: {
                    my: "right"
                },
                open: function () {
                    $('.ui-dialog').css("z-index", '9999');
                    $('#wordtabs').tabs("option", "active", index - 3);
                },
                buttons: {
                    Ok: function () {
                        $(this).dialog("close");
                        EndEdit(m_selectedItem);
                        //$('#wordTabsContainer').show();
                    }

                },
                close: function () {
                    $(this).dialog("close");
                    EndEdit(m_selectedItem);
                    //$('#wordTabsContainer').show();
                },
                beforeClose: function () {
                    if (_wordTabDialogOpen) {
                        return false;
                    }
                }

            });
            $("#wordTabsContainer").parent().appendTo($("form:first"));
        }

        function PrepareReplaceWordSettings(id) {
            var elementid = id;
            $('#' + elementid).siblings().css("border", "1px solid #2DE2E5");
            $('#' + elementid).css("border", "2px solid red");
            m_selectedItem = $('#' + elementid);//.parent();
            //m_shouldstoppropacation = true;
            $('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");

            $("#btnAddWord").show();
            $('html, body').animate({ scrollTop: $('body').height() }, 800);
            //$("#btnAddWord").toggleClass("show_addword");
            //$('#palettetabs').tabs("option", "active", 0);
        }

        function InitializedContextMenu(id) {
            var elementid = $('#' + id).parent()[0].id;
            var menu = [{
                name: $('#hdnReplaceWord').val(),
                img: '/Images/text_replace.png',
                title: 'Replace Word',
                disable: 'true'
            },
            {
                'name': $('#hdnSelectFromPalete').val(),
                img: '/images/select.png',
                fun: function () {
                    $('#' + id).parent().siblings().css("border", "2px solid #2DE2E5");
                    $('#' + id).parent().css("border", "2px solid red");
                    m_selectedItem = $('#' + id).parent();
                    m_shouldstoppropacation = true;
                    $('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");
                }
            },
            {
                'name': $('#hdnCreateNewWord').val(),
                img: '/Images/addreplaceword.png',
                fun: function () {

                    $('#' + id).parent().siblings().css("border", "2px solid #2DE2E5");
                    $('#' + id).parent().css("border", "2px solid red");
                    m_selectedItem = $('#' + id).parent();
                    m_shouldstoppropacation = true;
                    FreeForm();
                }
            },

            {
                name: $('#lblCancel').text(),
                img: '/images/x.png',
                title: 'Cancel',
                fun: function () {
                    EndEdit(m_selectedItem);
                }
            }];

            //Calling context menu

            if (mobilecheck()) {
                $('#' + id).contextMenu(menu);
            }
            else {
                $('#' + id).contextMenu(menu);
            }
        }


        function InitializedContextMenuForPalette() {

            $('.addORreplaceword').each(function () {
                var id = $(this)[0].id;
                var menu = [{
                    name: $('#hdnReplaceWord').val(),
                    img: '/Images/text_replace.png',
                    title: 'Replace Word',
                    disable: 'true'
                },
                {
                    'name': $('#hdnSelectFromPalete').val(),
                    img: '/images/select.png',
                    fun: function () {

                        //$('#' + id).parent().siblings().css("border", "1px solid black");
                        //$('#' + id).parent().first().css("border", "2px solid red");
                        //$('#' + id).parent().parent().siblings().first().css("border", "1px solid black");
                        $('.addORreplaceword').parent().parent().css("border", "2px solid #2DE2E5");
                        $('#' + id).parent().first().css("border", "2px solid red");
                        //m_selectedItem = $('#' + id).parent().parent();
                        m_selectedItem = $('#' + id).parent();
                        m_shouldstoppropacation = true;
                        $('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");
                    }
                },
                {
                    'name': $('#hdnCreateNewWord').val(),
                    img: '/Images/addreplaceword.png',
                    fun: function () {

                        //$('#' + id).parent().siblings().css("border", "1px solid black");
                        //$('#' + id).parent().css("border", "2px solid red");
                        //m_selectedItem = $('#' + id).parent();
                        $('.addORreplaceword').parent().parent().css("border", "2px solid #2DE2E5");
                        $('#' + id).parent().first().css("border", "2px solid red");
                        //m_selectedItem = $('#' + id).parent().parent();
                        m_selectedItem = $('#' + id).parent();
                        m_shouldstoppropacation = true;
                        FreeForm();
                    }
                },

                {
                    name: $('#lblCancel').text(),
                    img: '/images/x.png',
                    title: 'Cancel',
                    fun: function () {
                        EndEdit(m_selectedItem);
                    }
                }];

                //Calling context menu
                if (mobilecheck()) {
                    $('#' + id).contextMenu(menu);
                }
                else {
                    $('#' + id).contextMenu(menu);
                }
            });

        }


        function InitializedContextMenu2(id) {
            var menu = [{
                name: 'Replace Word',
                img: '/Images/text_replace.png',
                title: 'Replace Word',
                subMenu: [{
                    'name': 'Free Form',
                    img: '/Images/addreplaceword.png',
                    fun: function () {
                        if (m_selectedItem == null) {
                            $('#' + id).parent().siblings().css("border", "1px solid black");
                            $('#' + id).parent().css("border", "2px solid red");
                            m_selectedItem = $('#' + id).parent();
                            m_shouldstoppropacation = true;
                        }
                        else {

                            EndEdit(m_selectedItem);
                        }
                        FreeForm();
                    }
                }, {
                    'name': 'Select from the List',
                    img: '/images/select.png',
                    fun: function () {
                        if (m_selectedItem == null) {
                            $('#' + id).parent().siblings().css("border", "1px solid black");
                            $('#' + id).parent().css("border", "2px solid red");
                            m_selectedItem = $('#' + id).parent();
                            m_shouldstoppropacation = true;
                        }
                        else {

                            EndEdit(m_selectedItem);
                        }
                    }
                }]
            },
            {
                name: 'Cancel',
                img: '/images/x.png',
                title: 'Cancel',
                fun: function () {
                    EndEdit(m_selectedItem);
                }
            }];

            //Calling context menu
            $('#' + id).contextMenu(menu);
        }

        function CloseContextMenu() {
            $('.addORreplaceword').contextMenu('close');
        }
        function OpenContextMenu() {
            $('.addORreplaceword').contextMenu();
        }

        function wordClick(id, validate, playsound, e, shouldSend) {
            Console.WriteLine("-----I am here--------")
            var target = $(e.target);
            if (target.is("img") && target.hasClass("addreplaceword")) return;
            if (validate == false && playsound == true) {
                m_shouldstoppropacation = false;
                worddblClick(id);
            }
            // as per franks request
            if (validate == false && m_selectedItem == null && !shouldSend ) {
                return;
            }
            
            //needed this hack, stop propagation also stops the  plugins, wtf!!!
            if (m_shouldstoppropacation == true) {
                m_shouldstoppropacation = false;
                return;
            }
            var parent = $('#<%=divSentence.ClientID %>');
            var div = $('#' + id);
            if (!validate && m_selectedItem != null) {
                if ($(div).find(".firstword").length > 0) {


                    m_selectedItem.find(".firstword").val($(div).find(".firstword").text());

                    m_selectedItem.find(".firstword").attr("data-lang", $(div).find(".firstword").attr("data-lang"));
                    m_selectedItem.find(".firstword").attr("data-word", $(div).find(".firstword").attr("data-word"));
                    m_selectedItem.find(".firstword").attr("data-sound", $(div).find(".firstword").attr("data-sound"));
                    m_selectedItem.find(".firstword").attr("data-switchword", $(div).find(".firstword").attr("data-switchword"));
                    m_selectedItem.find(".firstword").attr("data-swapped", "1");

                    m_selectedItem.find(".secondword").val($(div).find(".secondword").text());

                    m_selectedItem.find(".secondword").attr("data-lang", $(div).find(".secondword").attr("data-lang"));
                    m_selectedItem.find(".secondword").attr("data-sound", $(div).find(".secondword").attr("data-sound"));
                    m_selectedItem.find(".secondword").attr("data-word", $(div).find(".secondword").attr("data-word"));
                    m_selectedItem.find(".secondword").attr("data-switchword", $(div).find(".secondword").attr("data-switchword"));
                    m_selectedItem.find(".secondword").attr("data-swapped", "1");

                    m_selectedItem.find(".thirdword").val($(div).find(".thirdword").text());

                    m_selectedItem.find(".otherword").attr("data-lang", $(div).find(".otherword").attr("data-lang"));
                    m_selectedItem.find(".otherword").attr("data-sound", $(div).find(".otherword").attr("data-sound"));
                    m_selectedItem.find(".otherword").attr("data-word", $(div).find(".otherword").attr("data-word"));
                    m_selectedItem.find(".otherword").attr("data-switchword", $(div).find(".otherword").attr("data-switchword"));
                    m_selectedItem.find(".otherword").attr("data-swapped", "1");
                    m_selectedItem.find(".thirdword").attr("data-phraseid", $(div).find(".thirdword").attr("data-phraseid"));

                    m_selectedItem.find(".firstword").text($(div).find(".firstword").text());
                    m_selectedItem.find(".secondword").text($(div).find(".secondword").text());
                    m_selectedItem.find(".thirdword").text($(div).find(".thirdword").text());
                    m_selectedItem.find(".otherword").text($(div).find(".otherword").text());
                    //set the image
                    if ($(div).find(".imgPicture").length > 0) {
                        if (m_selectedItem.find(".imgPicture").length == 0) {

                            var a = $(div).find(".gallery").clone();
                            m_selectedItem.find(".firstword").attr("data-image", $(div).find(".firstword").attr("data-image"));
                            m_selectedItem.find(".secondword").attr("data-image", $(div).find(".secondword").attr("data-image"));
                            //m_selectedItem.prepend(a);
                            m_selectedItem.find(".divShowImageContainer").append(a);
                            m_selectedItem.find(".imgPicture").attr("style", "width:18px;height:18px;");
                            m_selectedItem.addClass("screenshot");
                        }
                        else {
                            var a = m_selectedItem.find(".gallery").clone();
                            m_selectedItem.find(".firstword").attr("data-image", $(div).find(".firstword").attr("data-image"));
                            m_selectedItem.find(".secondword").attr("data-image", $(div).find(".secondword").attr("data-image"));
                            m_selectedItem.attr("data-image", $(div).attr("data-image"));
                            m_selectedItem.find(".gallery").attr("href", $(div).find(".gallery").attr("href"));
                        }
                    }
                    else {
                        m_selectedItem.find(".firstword").removeAttr("data-image");
                        m_selectedItem.find(".secondword").removeAttr("data-image");
                        m_selectedItem.find(".gallery").attr("href", "");
                        var img = m_selectedItem.find(".imgPicture");
                        if (img && img.length > 0) {
                            img.remove();
                        }

                    }
                    m_selectedItem.attr("data-sound", $(div).attr("data-sound"));
                    var firstsound = $(div).find(".firstword").attr("data-sound");
                    //var secondsound = $(div).find(".secondword").attr("data-sound");
                    var othersound = $(div).find(".otherword").attr("data-sound");
                    //alert(firstsound);
                    //alert(secondsound);
                    m_selectedItem.find(".firstword").attr("data-sound", firstsound == undefined ? "" : firstsound);
                    //m_selectedItem.find(".secondword").attr("data-sound", secondsound == undefined ? "" : secondsound);
                    m_selectedItem.find(".otherword").attr("data-sound", othersound == undefined ? "" : othersound);
                    $(m_selectedItem).find(".imgsmallspeaker").show();
                    $(m_selectedItem).find(".imgPicture").show();

                    if (_currentTab === 1 )
                        updateOwnPalette(m_selectedItem, false);

                }
                else {//punctuation
                    m_selectedItem.find(".firstword").val($(div).text());
                    m_selectedItem.find(".secondword").val($(div).text());
                    m_selectedItem.find(".thirdword").val($(div).text());
                    m_selectedItem.find(".firstword").text($(div).text());
                    m_selectedItem.find(".secondword").text($(div).text());
                    m_selectedItem.find(".thirdword").text($(div).text());
                    m_selectedItem.find(".otherword").text($(div).text());
                    m_selectedItem.find(".otherword").val($(div).text());

                }
                EndEdit(m_selectedItem);
                m_selectedItem = null;
                $('html, body').animate({ scrollTop: '0px' }, 800);
                //$('#rdoCriteriaList').find("input[value='0']").prop("checked", true);
                return;
            }

            if (sessionStorage.getItem('grouping') == null) {
                //Save the grouping for the first double click, and use this a comparer if the next element is belongs to this group,if not ignore
                sessionStorage.setItem('grouping', $(div).attr('data-elementgrouping'));
            }
            var grouping = sessionStorage.getItem('grouping');
            if (grouping != undefined && grouping != "undefined") {

                if ($(div).attr('data-isword') == 'false') {
                    if (grouping != $(div).attr('data-elementgrouping')) {
                        GetRandomOrderMessage('line');
                        return;
                    }
                }

            }
            $('#' + id).parent().siblings("img").each(function () {
                sound = $(this).attr("data-sound");
                $('#hdnSoundFile').val(sound);
                return;
            });

            //clone the div for adding to different div.
            var dv1 = div.clone();
            $(dv1).attr("id", $(dv1).attr("id") + "z");
            dv1.css("margin-left", "10px");
            dv1.css("width", "");
            if (parent.has('#' + dv1[0].id).length > 0)
                return;
            //add x button for removal
            //debugger;
            var img = $("<img id='img" + id + "' src='../Images/ico_Delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");

            var imgedit = $("<img id='img" + id + "' src='../Images/Ico_edit.png' class='addreplaceword iw-mTrigger' onclick='InitializeReplaceWordSettings(this);' />");

            $(img).click(RemoveWord);
            dv1.append(imgedit);
            //remove the double click
            dv1.removeAttr("ondblclick");
            parent.append(dv1);
            //save the order in the local storage for validation purposes.
            if (sessionStorage.getItem('sentence1Ordinal') == null)
                sessionStorage.setItem('sentence1Ordinal', $(div).parent().parent().attr('data-sentence1Ordinal'));
            if (sessionStorage.getItem('sentence2Ordinal') == null)
                sessionStorage.setItem('sentence2Ordinal', $(div).parent().parent().attr('data-sentence2Ordinal'));
            sessionStorage.setItem('shouldValidate', validate);
            //highlight
            if (validate) {
                $(div).parents(":eq(2)").siblings().css("background-color", "white");
                $(div).parents(":eq(2)").css("background-color", "rgba(252, 234, 187, 1)");
            }
            $(imgedit).on("click", function (e) {
                e.stopPropagation();
            });
            InitializedContextMenu(imgedit[0].id);
            if (shouldSend && m_selectedItem == null) {
                Add();
                $('html, body').animate({ scrollTop: '0px' }, 800);
            }

        }
        function BeginEdit(e) {

            if (m_selectedItem == null) {
                $(this).parent().siblings().css("border", "2px solid #2DE2E5");
                $(this).parent().css("border", "2px solid red");
                m_selectedItem = $(this).parent();
                m_shouldstoppropacation = true;
                InitializedContextMenu();
            }
            else {

                EndEdit(m_selectedItem);
            }
        }

        function EndEdit(el) {
            if (el != null)
                $(el).css("border", "2px solid #c9e265");
            else
                return

            m_selectedItem = null;
            $('.sContainer .screenshot').css("background-color", "white");
            //$("#btnAddWord").toggleClass("show_addword");

            //$("#btnAddWord").hide();
            CloseContextMenu();
            m_shouldstoppropacation = false;
            $("#hdnPrepareWordReplaceElementID").val("");
            $("#hdnWordKeyword").val('');

            AppendOrderedNativeLanguage(el);
            $('#wordTabsContainer').dialog('close');

        }

        function RemoveWord(e) {

            e.stopImmediatePropagation();
            var x = $(this).parent();
            var parent = x.parent();
            x.remove();
            //clear the local storage if no object remains in the div
            if (parent.children().length == 0) {
                if (sessionStorage.getItem('sentence1Ordinal') != null)
                    sessionStorage.removeItem('sentence1Ordinal');
                if (sessionStorage.getItem('sentence2Ordinal') != null)
                    sessionStorage.removeItem('sentence2Ordinal')
            }
        }

        function RemoveWord1(e, el) {

            e.stopImmediatePropagation();
            var x = $('#' + el).parent();
            var parent = x.parent();
            x.remove();
            var count = $('#lblWordCount').text();
            count = parseInt(count) - 1;
            $('#lblWordCount').text(count.toString());

            //clear the local storage if no object remains in the div
            if (parent.children().length == 0) {
                if (sessionStorage.getItem('sentence1Ordinal') != null)
                    sessionStorage.removeItem('sentence1Ordinal');
                if (sessionStorage.getItem('sentence2Ordinal') != null)
                    sessionStorage.removeItem('sentence2Ordinal')
            }
        }

        function worddblClick(id) {
            var sound = $('#' + id).attr('data-sound');
            //$.playSound(sound);
            var s = new buzz.sound(sound);
            s.load();
            s.play();
        }

        function PlaySequentialSounds(el, sendsentence) {
            $("#btnPlaySound").prop("disabled", true);
            var sounds = [];
            $('#<%=divSentence.ClientID %>').children('div').each(function () {
                if ($(this).attr("data-sound") != "" && $(this).attr("data-sound") != "../Content/sound/") {
                    sounds.push($(this).attr("data-sound"));
                }
            });

            if (!sendsentence) {
                $(el).siblings('span, a').each(function () {
                    if ($(this).attr("data-sound") != "" && ($(this).attr("data-sound") && $(this).attr("data-sound").indexOf(".mp3") > -1)) {
                        if ($(this).attr("data-sound").toLowerCase().indexOf("../content/sound/") == -1)
                            sounds.push("../Content/sound/" + $(this).attr("data-sound"));
                        else
                            sounds.push($(this).attr("data-sound"));
                    }
                });

            }
            //PlayNext1(sounds, 0);
            var soundscount = sounds.length;
            if (soundscount > 0) {
                var myaudio = [];
                var next = 0;
                for (var i = 0; i < soundscount; i++) {
                    myaudio[i] = new Audio(sounds[i]);
                    myaudio[i].load();
                }
                //$(el).attr('src', '../images/waves.gif');
                $(el).parent().find(".speaker").attr('src', '../images/waves.gif');
                if (sendsentence) {
                    $(".addallwords").attr("src", "/images/sendchat_disable.png");
                    $(".addallwords, .speaker").css("pointer-events", "none");
                }


                function playnext(element, index) {
                    if (next == myaudio.length) {
                        $("#btnPlaySound").prop("disabled", false);
                        $(el).parent().find(".speaker").attr('src', '../images/ICO_Speaker.png');
                        $(".addallwords").attr("src", "/images/new/talkSend.png");
                        if (sendsentence) {
                            $(".addallwords, .speaker").css("pointer-events", "auto");
                            Add();
                        }
                        return;
                    }
                    $(element).on('ended', function () {
                        next = next + 1;
                        if (next == myaudio.length) {
                            $("#btnPlaySound").prop("disabled", false);
                            $(el).parent().find(".speaker").attr('src', '../images/ICO_Speaker.png');
                            $(".addallwords").attr("src", "/images/new/talkSend.png");
                            if (sendsentence) {
                                Add();
                                $(".addallwords, .speaker").css("pointer-events", "auto");
                            }
                            return;
                        }

                        if (next > myaudio.length)
                            return;
                        if (myaudio[next].readyState == 0) {
                            next = next + 1;
                            playnext($(element), index);
                            return;
                        }
                        myaudio[next].play();
                    }).on("error", function () {
                        next = next + 1;
                        if (myaudio.length > next)
                            myaudio[next].play();
                        else {
                            $(el).parent().find(".speaker").attr('src', '../images/ICO_Speaker.png');
                            $(".addallwords").attr("src", "/images/new/talkSend.png");
                            if (sendsentence) {
                                $(".addallwords, .speaker").css("pointer-events", "auto");
                                Add();
                            }
                        }
                    });
                };

                myaudio.forEach(playnext);
                myaudio[0].play();

            } else {
                $("#btnPlaySound").prop("disabled", false);
                $(el).parent().find(".speaker").attr('src', '../images/ICO_Speaker.png');
                $(".addallwords").attr("src", "/images/new/talkSend.png");
                if (sendsentence) {
                    $(".addallwords, .speaker").css("pointer-events", "auto");
                    Add();
                }
            }

            $('#palettetabs').tabs("option", "active", 1);

        }

        function PlaySequentialSoundsOnly(el, sendsentence) {
            $("#btnPlaySound").prop("disabled", true);
            var sounds = [];
            if (!sendsentence) {
                //siblings("ul").find("li")
                $(el).siblings('ul').find('li').find('div').each(function () {
                    if ($(this).attr("data-sound") != "" && ($(this).attr("data-sound") && $(this).attr("data-sound").indexOf(".mp3") > -1)) {
                        if ($(this).attr("data-sound").toLowerCase().indexOf("../content/sound/") == -1)
                            sounds.push("../Content/sound/" + $(this).attr("data-sound"));
                        else
                            sounds.push($(this).attr("data-sound"));
                    }
                });
            }
            var soundscount = sounds.length;
            if (soundscount > 0) {
                var myaudio = [];
                var next = 0;
                for (var i = 0; i < soundscount; i++) {
                    myaudio[i] = new Audio(sounds[i]);
                    myaudio[i].load();
                }

                function playnext(element, index) {
                    if (next == myaudio.length) {
                        return;
                    }
                    $(element).on('ended', function () {
                        next = next + 1;
                        if (next >= myaudio.length) {
                            return;
                        }
                        if (myaudio[next].readyState == 0) {
                            next = next + 1;
                            playnext($(element), index);
                            return;
                        }
                        myaudio[next].play();
                    }).on("error", function () {
                        next = next + 1;
                        if (myaudio.length > next)
                            myaudio[next].play();
                        //else {
                        //    $(el).parent().find(".speaker").attr('src', '../images/ICO_Speaker.png');
                        //    $(".addallwords").attr("src", "/images/sendchat.png");
                        //    if (sendsentence) {
                        //        $(".addallwords, .speaker").css("pointer-events", "auto");
                        //        Add();
                        //    }
                        //}
                    });
                };

                myaudio.forEach(playnext);
                myaudio[0].play();

            } else {
                $("#btnPlaySound").prop("disabled", false);
                $(el).parent().find(".speaker").attr('src', '../images/ICO_Speaker.png');
                $(".addallwords").attr("src", "/images/new/talkSend.png");
                if (sendsentence) {
                    $(".addallwords, .speaker").css("pointer-events", "auto");
                    Add();
                }
            }

            //$('#palettetabs').tabs("option", "active", 1);

        }

        function PlayNext1(sounds, index) {
            if (index == sounds.length) {
                Add();
                return;
            }
            if (sounds[index] == "" || sounds[index] == "../Content/sound/") {
                index = index + 1;
                PlayNext1(sounds, index);

            } else {
                $sound = new buzz.sound(sounds[index]);
                $sound.load();
                $sound.bind("ended", function () {
                    index = index + 1;
                    PlayNext1(sounds, index);
                }).bind("error", function () {
                    index = index + 1;
                    PlayNext1(sounds, index);
                });
                $sound.play();
            }
        }

        function playsound(sounds) {
            //$.playSound('../content/sound/' + sounds);
            var s = new buzz.sound('../content/sound/' + sounds);
            s.load();
            s.play();
        }

        function playsoundnow(el, sounds) {
            //$.playSound('../content/sound/' + sounds);
            var s = new buzz.sound('../content/sound/' + sounds);

            s.bind("playing", function (e) {
                $(el).attr('src', '../images/waves.gif');
            });
            s.bind("error", function (e) {
                $(el).attr('src', '../images/ICO_Speaker.png');
            });
            s.bind("ended", function (e) {
                $(el).attr('src', '../images/ICO_Speaker.png');
            });
            s.load();
            s.play();
        }



        function playsoundsend(sounds) {
            //$.playSound('../content/sound/' + sounds);
            if (sounds == '')
                return;
            $sound = new buzz.sound('../content/sound/' + sounds);
            //$('#btnAdd').prop('disabled', true);
            $sound.bind("ended", function () {
                $sound = null;
                //    GetFinalMessage();
                //    $('#divFinalLearningMessage').empty();
                //    $('#divFinalNativeMessage').empty();
                //    $otherlanguages = null;
                //    ClearSelectedSentence();
                //    $('#btnAdd').prop('disabled', false);
            });

            $sound.load();
            $sound.play();
        }
        function stopSound(sounds) {
            if (sounds == '')
                return;

            if ($sound != null)
                $sound.stop();

            $sound = null;
        }
        function ClearSelectedSentence() {
            var parent = $('#<%=divSentence.ClientID %>');
            parent.empty();
            //clear the local storage if no object remains in the div
            if (parent.children().length == 0) {
                if (sessionStorage.getItem('sentence1Ordinal') != null)
                    sessionStorage.removeItem('sentence1Ordinal');
                if (sessionStorage.getItem('sentence2Ordinal') != null)
                    sessionStorage.removeItem('sentence2Ordinal')
            }

            sessionStorage.removeItem('shouldValidate');
            sessionStorage.removeItem('grouping')
            $('#hdnSoundFile').val('');
            return false;
        }
        function ClearSessionStorage() {
            if (sessionStorage.getItem('sentence1Ordinal') != null)
                sessionStorage.removeItem('sentence1Ordinal');
            if (sessionStorage.getItem('sentence2Ordinal') != null)
                sessionStorage.removeItem('sentence2Ordinal')
            if (sessionStorage.getItem('shouldValidate') != null)
                sessionStorage.removeItem('shouldValidate');
            if (sessionStorage.getItem('grouping') != null)
                sessionStorage.removeItem('grouping');
            if (sessionStorage.getItem('shouldCountNumberOfSentence') != null)
                sessionStorage.removeItem('shouldCountNumberOfSentence');
        }

        function UpdateTalkSubscription(from) {

            clearInterval(_KeepAlive);
            var time = $(".numberDisplay").text();
            //time = time.split(':')[0];
            if ($('#hdnSubscriptionID').val() == "0" || $('#hdnSubscriptionID').val() == "")
                return;
            var json = { Type: 'updatetalksubscription', UserTalkSubscriptionID: $('#hdnSubscriptionID').val(), UserName: $('#hdnCurrentUserName').val(), PartnerUserName: from, SessionTime: time };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data);
                if (obj.Status == "True") {
                    if (obj.hasOwnProperty('UserTalkSubscriptionID')) {
                        $("#hdnSubscriptionID").val(obj.UserTalkSubscriptionID);
                        $("#sessionTime").text(obj.SessionTime + "min");
                        //$("#totalTime").text(obj.TotalTime + "min");
                        if (obj.SessionTime == 0) {
                            $("#lblCanTalkContainer").click();
                            DisableICanTalkButton(obj.SessionTime);
                            //DisableICanTalkButton(0)
                            DisableEnableCallButton();
                        }
                    }
                    console.log("zero from update talk subscription");
                }
                else
                    alert('Error updating your talk subscription. Please check your network or internet.');
            });

        }
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

            $.connection.hub.disconnected(function () {
                if (!_isInCall) {
                    $("<div>You have network problem, please press OK to refresh the page</div>").dialog({
                        title: "Disconnected",
                        modal: true,
                        buttons: {
                            Ok: function () {
                                location.reload();
                            }
                        }
                    });
                }
            });

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
                    //var span = $(el).find(".statusContainer > #spanstatus");
                    //if (span) {
                    //    $(span).text("Offline");
                    //    var img = $(el).find('.statusContainer > img');
                    //    if (img) {
                    //        $(img).attr("src", "../Images/Offline.png");
                    //    }

                    //}
                    //$(el).find(".ontalk").hide();
                    $(el).find("#imgOnTalkStatus").attr("src", "../images/new/offline.png");
                    $(el).attr("data-isonline", "false");
                    DisableEnableCallButton();
                }
                if (userid == $('#hdnCurrentUserID').val()) {
                    changeStatusToConnected();
                    //callBroadCastHandler(10);
                    //$("<div>You have network problem, please press OK to refresh the page</div>").dialog({
                    //    title: "User Disconnected",
                    //    modal: true,
                    //    buttons: {
                    //        Ok: function () {
                    //            location.reload();
                    //        }
                    //    }
                    //});
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

                            //toastr.options.onCloseClick = function () { $('#btnChatSupport').removeClass("blink"); }
                            var $toast = toastr.lighterror(messageTemplate.stringformat(messages[0], messages[2]), "<div>" + $('#hdnNewMessageTitle').val() + "</div><br/>");
                            $('#btnChatSupport').addClass("blink");
                            $toast.delegate('.clear', 'click', function () {
                                toastr.clear($toast, { force: true });
                                SelectSupportOrPartner(true);
                            });



                        }
                        $(el).toggleClass("newMessage");
                        //interval = setInterval(function () {
                        //    $(el).toggleClass("newMessage");
                        //}, 1000);

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

                <%--if ($("#chkCallInProgress").prop("checked") == true) {
                    if (to == $('#hdnCurrentUserID').val()) {
                        cl = "newme";
                        clstate = "new";
                        avatar = $('#hdnSelectedAvatar').val();
                        firstname = $('#hdnSelectedFirstName').val();
                        style = "color:red;font-size:larger;font-weight:bold;"
                        spanid = "lblMe";
                    }
                    var str = '<tr id="trMessage" class="message" data-keyword="' + keywords + '">';
                    str = str + '<td class="nameContainer" style="vertical-align:middle;">';
                    str = str + '</td>';
                    str = str + '<td class="tblMessage_conv">';
                    str = str + '<div class="conversationDate" style="width:100%;text-align:center;">';
                    str = str + "<span class='chatname' id='" + spanid + "' style='" + style + "'>" + firstname + "</span>";
                    str = str + '<span class="" id="msgDate" style="width:100%;text-align:center;"><%=(System.DateTime.Now).ToShortDateString()%></span>';
                    str = str + '</div>';
                    str = str + '<div class="tblMessage_conversation">';

                    if (cl == "newyou")
                        str = str + '<span class="newbubble1 newyou learning partnerbubble ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;">' + "<div class='paletteContainer'>" + messages[0] + "</div>";
                    else
                        str = str + '<span class="newbubble1 newme learning partnerbubble ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;">' + "<div class='paletteContainer'>" + othermessages[0] + "</div>";
                    //if (cl == "newme") {
                    //    str = str + '<input title="Report this Problem Message" class="imgReport" id="imgReport" onclick="ConfirmReport(this); return false;" type="image" src="../Images/block.png" data-usermailid="' + usermailid + '">';
                    //}

                    if (cl == "newyou")
                        str = str + '<span class="newbubble ' + cl + ' ' + clstate + ' id="msg_conversation" style="word-wrap:break-word; width:40%;">' + "<div class='paletteContainer'>" + messages[2] + "</div>";
                    else
                        str = str + '<span class="newbubble ' + cl + ' ' + clstate + ' " id="msg_conversation" style="word-wrap:break-word; width:40%;">' + "<div class='paletteContainer'>" + othermessages[1] + "</div>";
                    str = str + '</span>';


                    str = str + '</span>';
                    str = str + '</div>';
                    str = str + '</td>';
                    str = str + '<td style="vertical-align:top;">';
                    str = str + '</td>';
                    str = str + '</tr>';
                }
                else {--%>
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
                //}


                //$('#tblMessage tr:last').after(str);
                //.bong
                let msgDom = $.parseHTML(str);
                //let temp = $.parseHTML(str);
                //$(temp).find("a.gallery").not(".secondword").attr("rel", "gal");
                //$('#imageTemporary').append(temp);
                //$(temp).find("a.gallery").not(".secondword").colorbox({
                //    open: true,
                //    rel: 'gal',
                //    fixed: true,
                //    width: "50%",
                //    height: "75%",
                //    onClosed: function () {
                //        $('#imageTemporary').empty();
                //    }
                //});

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
                //$('#imgSearchSentence').click();
            

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
                        $('#imageTemporary').empty();
                    }
                });
            }

            chat.client.sendToMailBox = function (to, from, message, othermessage) {
                //debugger;
                writeToOwnWindow(to, from, message, othermessage);
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

                    //if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                    //    $.connection.hub.start().done(function () {
                    //        chat.server.call($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room);
                    //    });
                    //} else {
                    //    chat.server.call($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room);
                    //}
                    //PlayRingBack(true);
                    //$("#btnCallIcon").attr("src", "../Images/Calling.gif")
                    $("#renderer0").show();
                    $("#renderer01").show();
                    $("#renderer01_timesSection").show();
                    $("#divCall_01").show();
                }
            }
            chat.client.callRejected = function (group, from) {
                $("#renderer01").hide();
                $("#divCall_01").hide();
                //$("#renderer01_timesSection").hide();
                //$("#renderer01_bottomSection").hide();
                //alert(from + " - " + $("#hdnCurrentUserName").val());
                //if (from != $("#hdnCurrentUserName").val() && _SomeoneIscalling) {

                //    return;
                //}
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
                if (from != $("#hdnCurrentUserName").val() )
                    $("#btnCallIcon").click();
                //alert("your call was rejected");
                clearInterval(_KeepAlive);
                //if (from == $("#hdnCurrentUserName").val()) {
                //    _SomeoneIscalling = false;                
                //}
                

            }

            //function UpdateTalkSubscription(from) {

            //    clearInterval(_KeepAlive);
            //    var time = $(".numberDisplay").text();
            //    //time = time.split(':')[0];
            //    if ($('#hdnSubscriptionID').val() == "0" || $('#hdnSubscriptionID').val() == "")
            //        return;
            //    var json = { Type: 'updatetalksubscription', UserTalkSubscriptionID: $('#hdnSubscriptionID').val(), UserName: $('#hdnCurrentUserName').val(), PartnerUserName: from, SessionTime: time };
            //    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
            //        var obj = $.parseJSON(data);
            //        if (obj.Status == "True") {
            //            if (obj.hasOwnProperty('UserTalkSubscriptionID')) {
            //                $("#hdnSubscriptionID").val(obj.UserTalkSubscriptionID);
            //                $("#sessionTime").text(obj.SessionTime + "min");
            //                //$("#totalTime").text(obj.TotalTime + "min");
            //                if (obj.SessionTime == 0) {
            //                    $("#lblCanTalkContainer").click();
            //                    DisableICanTalkButton(obj.SessionTime);
            //                    //DisableICanTalkButton(0)
            //                    DisableEnableCallButton();
            //                }
            //            }
            //            console.log("zero from update talk subscription");
            //        }
            //        else
            //            alert('Error updating your talk subscription. Please check your network or internet.');
            //    });

            //}

            //function AddConferenceRoom(room, caller, callee) {
            //    //time = time.split(':')[0];
            //    var json = { Type: 'addconferenceroom', Room: room, Caller: caller, Callee: callee };
            //    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
            //        var obj = $.parseJSON(data);
            //        if (obj.Status == "True") {

            //        }
            //        else
            //            alert('Error inserting conferenceroom. Please check your network or internet.');
            //    });

            //}

            //function DeleteConferenceRoom(room) {
            //    //time = time.split(':')[0];
            //    var json = { Type: 'deleteconferenceroom', room: room};
            //    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
            //        var obj = $.parseJSON(data);
            //        if (obj.Status == "True") {

            //        }
            //        else
            //            alert('Error inserting conferenceroom. Please check your network or internet.');
            //    });

            //}
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
                                "onCloseClick": function () {  }
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
                    $("#renderer01").hide();
                    $("#divCall_01").hide();
                    //$("#renderer01_timesSection").hide();
                    //$("#renderer01_bottomSection").hide();
                    $("#renderer1").hide();
                    if ($("#divCallAlert").dialog("isOpen") === true) {
                            $("#divCallAlert").dialog("close");

                        Ring(false);
                        _SomeoneIscalling = false;
                    }
                    UpdateTalkSubscription(from);
                    //$("#renderer2").hide();

                    //$('#chkCallInProgress').prop('checked', false).trigger("change");
                }
                else {
					//UpdateTalkSubscription($("#hdnCurrentUserName").val());
                    UpdateTalkSubscription($("#hdnSelectedUserName").val());
                }
                DeleteConferenceRoom(room);
                if (_isInCall && _SomeoneIscalling) {
                    _SomeoneIscalling = false;
                }
                _caller = "";
                //$('#chkCallInProgress').prop('checked', false).trigger("change");
                //$("#btnCallIcon").attr("src", "../Images/CallingStatic.png")
                //$("#renderer0").hide();
                //$("#renderer1").hide();
                //$(".divMessage").removeClass("divMessageWithVideo");
                //$('#chkCallInProgress').prop('checked', false).trigger("change");
                //toggleCallInProgress();
            }
            chat.client.callEnded = function (from, group, room) {

                if (from != $("#hdnCurrentUserName").val() && $("#btnCallIcon").attr("src").indexOf("callEnd.png") > -1)  {
                    $("#btnCallIcon").click();
                    $("#btnCallIcon").attr("src", "../Images/new/CallingStatic.png");
                    $("#renderer0").hide();
                    $("#divCall_01").hide();
                  
                    //$("#renderer01_bottomSection").hide();
                    $("#renderer01_timesSection").hide();
                   
                    $("#renderer1").hide();
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

            //$.connection.hub.start().done(function () {
            //    chat.server.getAllOnlineStatus();
            //    var el = $('.divUsers');
            //    if (el.length > 0)
            //        SelectUser($(el)[0]);
            //}).fail(function(error) {
            //    console.log('Invocation of start failed. Error:' + error)
            //});
        }

        function userIsCalling(receiver, from, room, group, roomKey) {
            if (from != $("#hdnCurrentUserName").val()) {
                //if (!IsCallerSelected(from) || receiver != $("#hdnCurrentUserName").val())
                if (receiver != $("#hdnCurrentUserName").val() || _SomeoneIscalling || _isInCall) {
                    if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                        $.connection.hub.start().done(function () {
                            alert('rejected');
                            chat.server.rejected(group, $("#hdnCurrentUserName").val());
                        });
                    } else {
                        chat.server.rejected(group, $("#hdnCurrentUserName").val());
                    }
                    if (!_SomeoneIscalling)
                        Ring(false);

                    return false;
                }
                _caller = from;
                _SomeoneIscalling = true;

                Ring(true);
                $("#lblCallAlertMessage").text(from + " is calling you.");
                var translations = {};
                translations["Ok"] = $('#hdnAnswer').val();
                translations["Cancel"] = $('#hdnReject').val();
                var buttonsOpts = {};
                _roomparameter = room;
                buttonsOpts[translations["Ok"]] = function () {
                    if (!IsCallerSelected(from)) {
                        _callAnswered = true;
                        _roomparameter = room;
                        _roomKeyParameter = roomKey;
                        _fromparameter = from;
                        _groupparameter = group;
                        $(this).dialog("close");
                        SelectCaller(from);

                    }
                    else {
                        $(this).dialog("close");
                        //GetVideoKey();
                        $('#btnCallIcon').addClass("callStart");
                        loadVidyoClientLibrary(true, true, roomKey, $("#hdnCurrentUserName").val(), false);
                        //$(".divMessage").toggleClass("divMessageWithVideo");
                        //FindUser(from);
                        $("#renderer0").show();
                        Ring(false);
                        if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                            $.connection.hub.start().done(function () {
                                chat.server.answered(group, $("#hdnCurrentUserName").val(), roomKey);
                            });
                        } else {
                            chat.server.answered(group, $("#hdnCurrentUserName").val(), roomKey);
                        }
                        AddConferenceRoom(room, from, $("#hdnCurrentUserName").val(), roomKey);
                    }

                }
                buttonsOpts[translations["Cancel"]] = function () {
                    _SomeoneIscalling = false;
                    $(this).dialog("close");
                    if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                        $.connection.hub.start().done(function () {
                            chat.server.rejected(group, $("#hdnCurrentUserName").val());
                        });
                    } else {
                        chat.server.rejected(group, $("#hdnCurrentUserName").val());
                    }
                    Ring(false);
                }

                $("#divCallAlert").dialog({
                    autoOpen: true,
                    modal: true,
                    buttons: buttonsOpts,
                    dialogClass: "no-titlebar"
                });
                //showCallAlert(receiver, from, room, group);
            }
        }

        function AddConferenceRoom(room, caller, callee, roomKey) {
            //time = time.split(':')[0];
            var json = { Type: 'addconferenceroom', Room: room, Caller: caller, Callee: callee, RoomKey: roomKey };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data);
                if (obj.Status == "True") {

                }
                else
                    alert('Error inserting conferenceroom. Please check your network or internet.');
            });

        }

        function DeleteConferenceRoom(room) {
            //time = time.split(':')[0];
            var json = { Type: 'deleteconferenceroom', room: room };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data);
                if (obj.Status == "True") {

                }
                else
                    alert('Error inserting conferenceroom. Please check your network or internet.');
            });

        }

        function writeToOwnWindow(to, from, message, othermessage) {
            var str = '<tr id="trMessage">';

            var messages = message.split('|');
            var othermessages = othermessage.split('|');
            var cl = "newyou";
            var avatar = $('#hdnCurrentAvatar').val();
            var firstname = $('#hdnCurrentFirstName').val();
            var spanid = "lblYou";
            var style = "color:black;font-size:8pt;font-weight:bold;"
            var seconlanguageonlyclass = "";
            if ($('#chkSecondLanguage').prop("checked") == true) {
                seconlanguageonlyclass = "newbubble1secondlanguageonly";
            }
            //Merge the message
           <%-- if ($("#chkCallInProgress").prop("checked") == true) {
                if (to == $('#hdnCurrentUserID').val()) {
                    cl = "newme";
                    avatar = $('#hdnSelectedAvatar').val();
                    firstname = $('#hdnSelectedFirstName').val();
                    var spanid = "lblMe";
                    style = "color:red;font-size:larger;font-weight:bold;"
                }

                var str = '<tr id="trMessage">';
                str = str + '<td class="nameContainer" style="vertical-align:middle;">';
                str = str + '</td>';
                str = str + '<td class="tblMessage_conv">';
                str = str + '<div class="conversationDate" style="width:100%;text-align:center;">';
                str = str + "<span class='chatname ' id='" + spanid + "' style='" + style + "'>" + firstname + "</span>";
                str = str + '<span class="" id="msgDate" style="width:100%;text-align:center;"><%=(System.DateTime.Now).ToShortDateString()%></span>'
                str = str + '</div>';
                str = str + '<div class="tblMessage_conversation">';

                if (cl == "newyou")
                    str = str + '<span class="newbubble1 learning ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;">' + "<div class='paletteContainer'>" + messages[0] + "</div>";
                else
                    str = str + '<span class="newbubble1 learning ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;">' + "<div class='paletteContainer'>" + othermessages[0] + "</div>";

                if (cl == "newyou")
                    str = str + '<span class="newbubble ' + cl + ' old" id="msg_conversation" style="word-wrap:break-word; width:40%;">' + "<div class='paletteContainer'>" + messages[2] + "</div>";
                else
                    str = str + '<span class="newbubble ' + cl + ' old" id="msg_conversation" style="word-wrap:break-word; width:40%;">' + "<div class='paletteContainer'>" + othermessages[2] + "</div>";
                str = str + '</span>';


                str = str + '</span>';
                str = str + '</div>';
                str = str + '</td>';
                str = str + '<td style="vertical-align:top;">';
                str = str + '</td>';
                str = str + '</tr>';
            }
            else {--%>
                if (to == $('#hdnCurrentUserID').val()) {
                    cl = "newme";
                    avatar = $('#hdnSelectedAvatar').val();
                    firstname = $('#hdnSelectedFirstName').val();
                    var spanid = "lblMe";
                    style = "color:red;font-size:8pt;font-weight:bold;"
                }
                var str = '<tr id="trMessage">';
                str = str + '<td  class="nameContainer" style="vertical-align:middle;">';
                str = str + "<span class='chatname' id='" + spanid + "' style='" + style + "'>" + firstname + "</span>";
                str = str + '</td>';
                str = str + '<td class="tblMessage_conv">';
                str = str + '<div class="conversationDate" style="width:100%;text-align:center;">';
                str = str + '<span id="msgDate" style="width:100%;text-align:center;"><%=(System.DateTime.Now).ToShortDateString()%></span>'
                str = str + '</div>';
                str = str + '<div class="tblMessage_conversation">';
                if (cl == "newyou")
                    str = str + '<span class="newbubble ' + cl + ' old" id="msg_conversation" style="word-wrap:break-word;">' + "<div class='paletteContainer'>" + messages[2] + "</div>";
                else
                    str = str + '<span class="newbubble ' + cl + ' old" id="msg_conversation" style="word-wrap:break-word;">' + "<div class='paletteContainer'>" + othermessages[2] + "</div>";
                str = str + '</span>';
                if (cl == "newyou")
                    str = str + '<span class="newbubble1 newyou ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important;">' + "<div class='paletteContainer'>" + messages[0] + "</div>";
                else
                    str = str + '<span class="newbubble1 newme ' + seconlanguageonlyclass + '" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important;">' + "<div class='paletteContainer'>" + othermessages[0] + "</div>";

                str = str + '</span>';
                str = str + '</div>';
                str = str + '</td>';
                str = str + '<td style="vertical-align:top;">';
                str = str + '</td>';
                str = str + '</tr>';

            //}
            //$('#tblMessage tr:last').after(str);
            $('#tblMessage').append(str);
            AttachPlaysound();
            $('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);
            $('#hdnSoundFile').val('');
            if (seconlanguageonlyclass.length > 0)
                $('#tblMessage').find(".newbubble").addClass("newbubblesecondlanguageonlyHidden");
            else
                $('#tblMessage').find(".newbubble").removeClass("newbubblesecondlanguageonlyHidden");

            return str;
        }
        function LikeMessage(el) {
            //debugger;
            var img = $(el);
            var json = { Type: 'likemessage', usermailid: $(el).attr("data-usermailid") };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data);

                if (obj.Status == "True") {
                    var current = img.attr('src');
                    var swap = img.attr('data-swap');
                    img.attr("src", swap).attr("data-swap", current);
                }
                else
                    alert('Error updating your status. Please check your network or internet.');
            });

        }

        function GetVideoKey() {
            var json = { Type: 'getvideokey' };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data);

                if (obj.Status == "True") {
                    $("#hdnToken").val(obj.key);
                    console.log(obj.key);
                }
                else
                    alert('Cannot generate video token.');
            });

        }


        function SelectCaller(username) {
            var el = $("#allfriends").find(".divUsers[data-username='" + username + "']")
            if ($(el).length > 0)
                SelectUser(el);

            return false;
        }

        function IsCallerSelected(username) {
            var el = $("#allfriends").find(".selected[data-username='" + username + "']")
            if ($(el).length > 0)
                return true;

            return false;
        }

        function SelectUser(el) {
            clearInterval(interval);
            $(el).addClass("selected");
            $(el).removeClass("newMessage");
            $(el).siblings().removeClass("selected");
            $(el).addClass("selected");
            var button = $('#<%=btnGetUserMessage.ClientID%>');
            $('#<%=hdnSelectedUserID.ClientID%>').val($(el).attr("data-userid"));
            $('#hdnName').val($(el).attr("data-firstname"));
            $('#hdnSelectedFirstName').val($(el).attr("data-firstname"));
            $('#hdnSelectedUserName').val($(el).attr("data-username"));
            $('#hdnSelectedAvatar').val($(el).attr("data-avatar"));
            $('hdnGroupName').val('');

            chat.server.createGroup($('#hdnCurrentUserID').val(), $('#hdnSelectedUserID').val());
            if ($(el).data("issupport") == null || $(el).data("issupport") == "False" || $(el).data("issupport") == "") {
                $('.partnersroom').show();
            }
            else {
                $('.partnersroom').hide();
            }
            DisableEnableCallButton();
            $(button).trigger('click');
        }
        function SelectUserOnOnline(el) {
            clearInterval(interval);
            $(el).addClass("selected");
            $(el).removeClass("newMessage");
            $(el).siblings().removeClass("selected");
            $(el).addClass("selected");
            $('#<%=hdnSelectedUserID.ClientID%>').val($(el).attr("data-userid"));
            $('#hdnName').val($(el).attr("data-firstname"));
            $('#hdnSelectedFirstName').val($(el).attr("data-firstname"));
            $('#hdnSelectedUserName').val($(el).attr("data-username"));
            $('#hdnSelectedAvatar').val($(el).attr("data-avatar"));
            $('hdnGroupName').val('');

            chat.server.createGroup($('#hdnCurrentUserID').val(), $('#hdnSelectedUserID').val());
        }

        function DisableEnableCallButton() {
            var el = $(".divUsers.selected").find('.ontalk').find('#imgOnTalkStatus');
            if ($(el).length > 0 && $(el).attr("src").indexOf('online') > -1 && $("#lblCanTalkContainer").hasClass("lblCanTalk") && !$("#lblCanTalkContainer").hasClass("lblCanTalkDisabled"))
                $("#btnCallIcon").removeClass("btnCallIconDisabled");
            else 
                $("#btnCallIcon").addClass("btnCallIconDisabled");
        }

        function DisableICanTalkButton(sessiontime) {
            if (sessiontime == 0) {
                //$("#lblCanTalk").removeClass("lblCantTalk");
                $("#lblCanTalkContainer").addClass("lblCanTalk").addClass("lblCanTalkDisabled");
            }
        }

        function ConfirmReport(el) {
            InitializeConfirmReportDialog(el);
            $("#confirmDialog").dialog("open");
        }
        function InitializeConfirmReportDialog(el) {
            var translations = {};
            translations["Ok"] = $('#lblOk').text();
            translations["Cancel"] = $('#lblCancel').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Ok"]] = function () {
                $(this).dialog("close");
                Report(el);
            }
            buttonsOpts[translations["Cancel"]] = function () {
                $(this).dialog("close");
            }

            $("#confirmDialog").dialog({
                autoOpen: false,
                modal: true,
                buttons: buttonsOpts
            });
        }

        var $otherlanguages = null;
        function Add() {
            //var str='<tr id="trMessage">'
            //str=str + '<td style="vertical-align:top;">'    
            //str=str + '</td>'
            //str=str + '<td class="tblMessage_conv">'
            //str=str + '<div style="width:100%;text-align:center;">'
            //str=str + '<span style="width:100%;text-align:center;">6/18/2015</span>'
            //str=str + '</div>'
            //str=str + '<div class="tblMessage_conversation">'
            //str=str + '<span class="bubble you old" id="msg_conversation" style="word-wrap:break-word; width:40%;">Im sorry&nbsp;I wasnt able to&nbsp;write to you&nbsp;sooner.&nbsp;<br>My&nbsp;name&nbsp;is&nbsp;John&nbsp;<br>I&nbsp;like&nbsp;drumming&nbsp;<br>&nbsp;<br>'
            //str=str + '</span>'
            //str=str + '<span class="bubble1" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;">すぐに&nbsp;へんじが&nbsp;できなくて&nbsp;ごめんなさい。&nbsp;<br>わたしの&nbsp;なまえは&nbsp;&nbsp;です。&nbsp;<br>わたしは&nbsp;ドラムをたたくこと&nbsp;がすきです。&nbsp;<br>my birthday is soon, turning 10/&nbsp;<br>'
            //str=str + '</span>'
            //str=str + '</div>'
            //str=str + '</td>'
            //str=str + '<td style="vertical-align:top;">'
            //str=str + '<img id="imgAvatarMe" class="imgAvatarMe" src="../Images/avatar/AB-2.png" style="height:65px;width:65px;">'
            //str=str + '</td>'
            //str = str + '</tr>'
            //$('#tblMessage tr:last').after(str);
            //return;
            var shouldValidate = sessionStorage.getItem('shouldValidate');
            var isEmoji = sessionStorage.getItem('isEmoji');
            if (isEmoji == "false") {
                if (!ValidateSentence()) {
                    //alert('Wrong order try again..');
                    GetRandomOrderMessage('order');
                    return false;
                }
            }

            var sentence1 = "";
            var sentence2 = "";
            var sentence3 = "";
            var sounds = "";
            if ($('#<%=divSentence.ClientID %>').children('div').length == 0 ||
                ($('#<%=divSentence.ClientID %>').children('div').length == 1 && $('#<%=divSentence.ClientID %>').children('div')[0].innerHTML == '')) {
                $("<div>" + $("#hdnNoSentenceToAdd").val() + "</div>").dialog({
                    modal: true,
                    buttons: {
                        Ok: function () {
                            $(this).dialog("close");
                        }
                    }
                });
                return false;
            }
            $('#<%=divSentence.ClientID %>').children('div').each(function () {
                var firstsound;
                var secondsound;
                var first = $(this).find(".firstword");
                var second = $(this).find(".secondword");
                if ($(first)) {
                    firstsound = $(first).attr("data-sound");
                    secondsound = $(second).attr("data-sound");
                    $(first).attr("data-sound", (secondsound == undefined) ? "" : secondsound);
                    $(second).attr("data-sound", (firstsound == undefined) ? "" : firstsound);
                }

            });

            $('#<%=divSentence.ClientID %>').children('div').each(function () {
                //var ordinals = sessionStorage.getItem('sentence1Ordinal').toString().split(',');

                $(this).children('span.secondword').each(function () {
                    $(this).show();
                    $(this).css('visibility', 'visible');
                    var s = $(this)[0];
                    sounds += $(s).attr('data-sound') + ",";

                    sentence2 += s.outerHTML + "&nbsp;";
                });
            });


            var ordinals = '';
            if (sessionStorage.getItem('sentence2Ordinal') != null)
                ordinals = sessionStorage.getItem('sentence2Ordinal').toString().split(',');

            if (shouldValidate == "true") {
                //TODO: add data ordinal to the emoji or for the tile coming from words palette.
                //TODO: Add the other language here.
                var array = new Array();
                var otherwordarray = new Array();
                var index = 0;
                //debugger;
                for (i in ordinals) {
                    if ($('#<%=divSentence.ClientID %>').find("span.firstword[data-ordinal='" + ordinals[i] + "']").length ||
                            $('#<%=divSentence.ClientID %>').find("span.firstword.img").length) {

                            var s = $('#<%=divSentence.ClientID %>').find("span.firstword[data-ordinal='" + ordinals[i] + "']")[0].outerHTML + "&nbsp;";
                            //sentence1 += s ;
                            array[index] = s;
                            index++;
                        }

                    }
                    index = 0;
                    for (i in ordinals) {
                        if ($('#<%=divSentence.ClientID %>').find("span.otherword[data-ordinal='" + ordinals[i] + "']").length ||
                            $('#<%=divSentence.ClientID %>').find("span.otherword.img").length) {

                            var s = $('#<%=divSentence.ClientID %>').find("span.otherword[data-ordinal='" + ordinals[i] + "']")[0].outerHTML + "&nbsp;";
                            //sentence1 += s ;
                            otherwordarray[index] = s;
                            index++;
                        }
                    }
                    index = 0;
                    //debugger;
                    $('#<%=divSentence.ClientID %>').children('div').each(function () {
                        $(this).children('span.firstword').each(function () {
                            $(this).show();
                            var s = $(this)[0].outerHTML + "&nbsp;";
                            if (IsArrayContains(array, $(this)[0].id) == -1)
                                array.splice(index, 0, s);
                            index++;
                        });
                    });
                    index = 0;
                    $('#<%=divSentence.ClientID %>').children('div').each(function () {
                        $(this).children('span.otherword').each(function () {
                            $(this).show();
                            var s = $(this)[0].outerHTML + "&nbsp;";
                            if (IsArrayContains(otherwordarray, $(this)[0].id) == -1)
                                otherwordarray.splice(index, 0, s);
                            index++;
                        });
                    });
                    for (var i = 0; i < array.length; i++) {
                        var html = $.parseHTML(array[i]);
                        $(html).show();
                        //var s = $(html)[0].outerHTML.replace("firstword", "") + "&nbsp;";;
                        var s = $(html)[0].outerHTML + "&nbsp;";;
                        sentence1 += s;//array[i].replace("firstword","");
                    }
                    for (var i = 0; i < otherwordarray.length; i++) {
                        var html = $.parseHTML(otherwordarray[i]);
                        $(html).show();
                        //var s = $(html)[0].outerHTML.replace("firstword", "") + "&nbsp;";;
                        var s = $(html)[0].outerHTML + "&nbsp;";;
                        sentence3 += s;//array[i].replace("firstword","");
                    }

                }
                else {
                    $('#<%=divSentence.ClientID %>').children('div').each(function () {
                    $(this).children('span.firstword').each(function () {
                        $(this).show();
                        sentence1 += $(this)[0].outerHTML + "&nbsp;";
                    });
                });
            }
            //update the word count
            //var count = $('#lblWordCount').text();
            //count = parseInt(count) + 1;
            //$('#lblWordCount').text(count.toString());
            //UpdateSentenceCount(true);


            var soundimage = "<img src=\"../Images/ICO_Speaker.png\" style=\"width:1px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"playsoundnow(this,'" + sounds + "');\" />";
            var removemes = "<img class='imgRemoveMessage{0}' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            //var freeform1 = '<input type="text" id="finalmessagefreeform1" style="font-size:smaller;"/>'
            //var freeform2 = '<input type="text" id="finalmessagefreeform2" style="font-size:smaller;"/>'

            //$('#divFinalLearningMessage').append('<div>' + sentence2 + soundimage  +  removemes.stringformat(count.toString()) + '</div>');
            //$('#divFinalNativeMessage').append('<div>' + sentence1 + soundimage + removemes.stringformat(count.toString()) + '</div>');

            $otherlanguages = $('#divFinalLearningMessage').clone();

            $('#divFinalLearningMessage').append('<div>' + sentence2 + '</div>');
            $('#divFinalNativeMessage').append('<div>' + sentence1 + '</div>');
            $otherlanguages.append('<div>' + sentence3 + '</div>');
            GetFinalMessage();

            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            $otherlanguages = null;
            stopSound($('#hdnSoundFile').val());
            //playsoundsend($('#hdnSoundFile').val());


            //$('#tblMessage1').append('<tr style="width:10px;">' + sentence1 + '</tr>')
            //$('#tblMessage2').append('<tr>' + sentence2 + '</tr>')
            sentence1 = "";
            sentence2 = "";
            sound = "";
            ClearSelectedSentence();
            if (m_selectedItem != null) {
                EndEdit(m_selectedItem);
            }


            return true;
        }


        function sortUsingNestedText(parent, childSelector, keySelector) {
            var items = parent.children(childSelector).sort(function (a, b) {
                var vA = $(keySelector, a).text();
                var vB = $(keySelector, b).text();
                return (vA < vB) ? -1 : (vA > vB) ? 1 : 0;
            });
            parent.append(items);
        }

        function SwitchLanguageOrder(obj) {

            var lang = $('#hdnNativeLanguageCode').val();
            var classname = "";
            if ($(obj).prop("checked")) {
                if (lang == "en-US")
                    classname = ".firstword";
                else
                    classname = ".secondword";
                $(classname).each(function () {
                    var ordinal = $(this).attr('data-ordinal');
                    $(this).parent().children('.imgsequence').each(function () {
                        $(this).attr('src', '../Images/orderedList' + ordinal + '.png');
                        if (classname == ".secondword")
                            $(this).hide();
                        else
                            $(this).show();
                    });
                });
            }
            else {
                if (lang == "en-US")
                    classname = ".secondword";
                else
                    classname = ".firstword";
                $(classname).each(function () {
                    var ordinal = $(this).attr('data-ordinal');
                    $(this).parent().children('.imgsequence').each(function () {
                        $(this).attr('src', '../Images/red' + ordinal + '.png')
                        if (classname == ".secondword")
                            $(this).hide();
                        else
                            $(this).show();
                    });
                });
            }
        }


        function HideShowSequence(obj) {
            if ($(obj).prop("checked")) {
                $('.imgsequence').show();
            }
            else {
                $('.imgsequence').hide();
            }
        }

        function HideSequence() {
            $('.imgsequence').hide();
        }


        function HideShowWords(obj, cls) {

            if ($(obj).prop("checked")) {
                $(cls).css("display", "inline-block");
                if (cls == ".firstword") {
                    $(".nativelanguageContainer").show();
                }
            }
            else {
                $(cls).attr("z-index", "-1000");
                $(cls).not('.paletteContainer > .firstword').css("display", "none");
                if (cls == ".firstword") {
                    $(".nativelanguageContainer").hide();
                }
            }
        }

        function SwitchWords(obj) {

            if ($(obj).prop("checked")) {
                $(".firstword").each(function () {
                    if ($(this).attr("data-switchword") != "") {
                        $(this).text($(this).attr("data-switchword"));
                    }
                });
                $(".secondword").each(function () {
                    if ($(this).attr("data-switchword") != "") {
                        $(this).text($(this).attr("data-switchword"));
                    }
                });
            }
            else {
                $(".firstword").each(function () {
                    if ($(this).attr("data-word") != "") {
                        $(this).text($(this).attr("data-word"));
                    }
                });
                $(".secondword").each(function () {
                    if ($(this).attr("data-word") != "") {
                        $(this).text($(this).attr("data-word"));
                    }
                });

            }

        }
        function setMinHeight() {
            $(".phraseContainer").addClass("phraseContainerJapanese");
        }
        function HighlightPalette() {
            $('.items').addClass("highlightPalette");
        }
        function changeActiveTab() {
            //if ($('#hdnCurrentTab').val() != 1) {
                //$('#rdoCriteriaList').find("input[value='1']").prop("checked", true);
                $('#mtabs').tabs("option", "active", 0);
            //}
        }

        function detectWebcam() {
            navigator.getMedia = (navigator.getUserMedia || // use the proper vendor prefix
                navigator.webkitGetUserMedia ||
                navigator.mozGetUserMedia ||
                navigator.msGetUserMedia || navigator.mediaDevices.getUserMedia);
            navigator.getMedia({ video: true }, function () {
                console.log("webcam detected");
                return true;
            }, function () {
                    $('#spanMessage').text($("#hdnNoWebCam").val());
                    $("#divModalMessage").dialog({
                        autoOpen: true,
                        modal: true,
                        buttons: {
                            "OK": function () {
                                $(this).dialog("close");
                            }
                        }
                    });
                    $("#imgTestCamera").addClass("disableHeaderMenu");
                    return false;
                //alert('Webcam not available ');
                // webcam is not available
            });

            //navigator.getMedia = (navigator.getUserMedia || // use the proper vendor prefix
            //    navigator.webkitGetUserMedia ||
            //    navigator.mozGetUserMedia ||
            //    navigator.msGetUserMedia || navigator.mediaDevices.getUserMedia);
            //alert(navigator.mediaDevices.getUserMedia);
            //navigator.getMedia({ video: true, audio: true }).then(function(stream) {
            //    console.log("webcam detected");
            //    alert('webcam detected');
            //}).catch(function(err) {
            //    alert(err);
            //    $('#spanMessage').text($("#hdnNoWebCam").val());
            //    $("#divModalMessage").dialog({
            //        autoOpen: true,
            //        modal: true,
            //        buttons: {
            //            "OK": function () {
            //                $(this).dialog("close");
            //            }
            //        }
            //    });

                //alert('Webcam not available ');
                // webcam is not available

            //    return false;
            //});
        }
        
        function detectMicrophone() {
            navigator.getMedia = (navigator.getUserMedia || // use the proper vendor prefix
                navigator.webkitGetUserMedia ||
                navigator.mozGetUserMedia ||
                navigator.msGetUserMedia || navigator.mediaDevices.getUserMedia);
            navigator.getMedia({ audio: true }, function () {
                console.log("audio detected");
            }, function () {
                    $('#spanMessage').text($("#hdnNoMicrophone").val());
                    $("#divModalMessage").dialog({
                        autoOpen: true,
                        modal: true,
                        buttons: {
                            "OK": function () {
                                $(this).dialog("close");
                            }
                        }
                    });

                //alert('audio not available ');
                // webcam is not available
            });
        }
        function showFriendsRoom() {
            var userid = $('#hdnSelectedUserID').val();
            url = '<%=Page.ResolveUrl("~/Student/MyFriendsRoom")%>' + "?fid=" + userid;
            //var windowObjectReference = window.open(url, '_blank');
            $(".iframe").attr("href", url);
            $(".iframe").click();
        }
        $(function () {

            //$('#btnWordTabButton').click(function () {
            //    showWordDialog();
            //});

            detectWebcam();
            detectMicrophone();
            //ShowParentsInfo();
            if ($("#hdnNativeLanguageCode").val() == "en-US") {
                //ShowReminderInstruction();
            }
            //}
            $('#lnkTranslate').click(() => {
                var sl = $("#hdnNativeLanguageCode").val().substr(0, 2);
                var tl = $("#hdnLearningLanguageCode").val().substr(0, 2);
                Translate(sl, tl, $("#txtFreeMessage1").val(), $("#txtFreeMessage2"), 'freemessage');
                $('#divFreeMessage').siblings().find('#dialogSave').focus();
            });

            $('#btnChatSupport').val($('#hdnChatSupport').val());
            onLineOffLine();
            attachedVidyo();
            $('#imgTalkChecklist').attr("src", '../Images/new/' + $('#hdnTalkChecklist').val());
            $('#imgGoToScheduler').attr("src", '../Images/new/' + $('#hdnGoToScheduler').val());
            $('#imgInstructionVideo').attr("src", '../Images/new/' + $('#hdnInstructionVideo').val());
            $('#imgTestCamera').attr("src", '../Images/new/' + $('#hdnTestCamera').val());
            $('#imgTestSound').attr("src", '../Images/new/' + $('#hdnTestSound').val());
            GetPartnerToDisplay();
            //GetAvailableSchedule();


            $('#ulAvailableTimes').on('click', '.scheduleme', function () {
                sessionStorage.setItem("yuckdate", $(this).data("date"));
                var url = '<%=Page.ResolveUrl("~/Student/Scheduler")%>';
                var newwindow = window.open(url, "_blank", "height=751,width=1038,scrollbars=yes,resizable=yes");
                if (window.focus) { newwindow.focus() }
                return false;
                
            });
            $('#ulAvailableSchedules').on('click', '.scheduleme', function () {
                sessionStorage.setItem("yuckdate", $(this).data("date"));
                var url = '<%=Page.ResolveUrl("~/Student/Scheduler")%>';
                  var newwindow = window.open(url, "_blank", "height=751,width=1038,scrollbars=yes,resizable=yes");
                  if (window.focus) { newwindow.focus() }
                  return false;

              });

            $("#cameras").change(function () {
                if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                    $.connection.hub.start().done(function () {
                        chat.server.partnerCameraChanged($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), true);
                    });
                } else {
                    chat.server.partnerCameraChanged($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), true);
                }



            });
            if ($("#hdnNativeLanguageCode").val() == "ja-JP") {
                $("#lblCanTalkContainer").addClass("lblCanTalkContainerJP");
            }
            $("#native").blur(function () {
                var sl = $("#hdnNativeLanguageCode").val().substr(0, 2);
                var tl = $("#hdnLearningLanguageCode").val().substr(0, 2);
                Translate(sl, tl, $("#native").val(), $("#learning"), 'word');
            });
            $("#learning").blur(function () {
                var sl = $("#hdnNativeLanguageCode").val().substr(0, 2);
                var tl = $("#hdnLearningLanguageCode").val().substr(0, 2);
                Translate(sl, tl, $("#native").val(), $("#learning"), 'word');
            });
            //$("#learning").blur(function () {
            //    var tl = $("#hdnNativeLanguageCode").val().substr(0, 2);
            //    var sl = $("#hdnLearningLanguageCode").val().substr(0, 2);
            //    Transate(sl, tl, $("#learning").val(), $("#native"));
            //});
            $("#lblRemainingTimer").click(function () {
                Talk();
            });
            $("#lblRemainingTimer").text($("#hdnSessionTalkTimer").val());
            $("#lblSessionLabel").text($("#hdnSessionTime").val());
            $("#lblTotalLabel").text($("#hdnTotalTime").val());
            if ($("#hdnTalkButtonTriggeredFromCodeBehind").val() == "True" && parseInt($('#sessionTime').text().replace("min", "")) > 0)
                CanTalkOrNot("");
            else
                $("#lblCanTalk").html($("#hdnIcantTalkNow").val());
            //$('#renderer01').click(function () {
            //    OpenDeviceList();
            //});



            $('#renderer01').click(function () {
                //alert("helllo")
                
                OpenDeviceList();
                return false;
            });
            if (parseInt($('#sessionTime').text().replace("min"), "") == 0) {
                DisableICanTalkButton(0);
                console.log("zero from onload");
            }
            $(".lblLanguage").text($("#hdn2ndLanguageLabel").val());
            InitializeTabs();
            $('#imgSettings').click(function () {
                var active = $("#mtabs").tabs("option", "active");
                if (active < 2)
                    $('#mtabs').tabs("option", "active", 2);
                else
                    $('#mtabs').tabs("option", "active", 0);
                return false;
            })
            $('.sortable').sortable({
                placeholder: 'highlight', axis: 'x',
                start: function (event, ui) {
                    ui.placeholder.height(ui.item.height());
                    ui.placeholder.width(ui.item.width());
                    ui.item.toggleClass("highlight");
                },
                stop: function (event, ui) {
                    ui.item.toggleClass("highlight");
                }
            }).disableSelection();
            ClearSelectedSentence();
            //$("#lblCanTalkContainer").click(function () {
            //    if ($(this).hasClass("lblCanTalkDisabled"))
            //        return false;
            //    UpdateTalkStatus("");
            //    //CanTalkOrNot();
            //});

            //$("#txtSearchFriend").attr("placeholder", $("#hdnSearchFriendsPlaceHolder").val());
            //$("#txtSearchFriend").on("keyup", function () {
            //    var value = $(this).val().toLowerCase();
            //    $("#allfriends .divUsers").filter(function () {
            //        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            //    });
            //});

        }
        );

        function onLineOffLine() {
            $("#lblCanTalkContainer").click(function () {
                if ($(this).hasClass("lblCanTalkDisabled"))
                    return false;
                UpdateTalkStatus("");
                //CanTalkOrNot();
            });
        }

        function InitializeTooltipSteps() {

            $('#step1').tooltip({ content: $("#hdnStep1").val(), items: '*' });
            $("#step2").tooltip({ content: $("#hdnStep2").val(), items: '*' });
            $("#step3").tooltip({ content: $("#hdnStep3").val(), items: '*' });
            $("#step4").tooltip({ content: $("#hdnStep4").val(), items: '*' });
            $("#step4b").tooltip({ content: $("#hdnStep4b").val(), items: '*' });
            $("#step5").tooltip({ content: $("#hdnStep5").val(), items: '*' });

            EnableDisableTooltip($('#chkTooltip'));

        }
        function EnableDisableTooltip(obj) {
            var enable = "enable";
            if (!$(obj).prop("checked")) {
                enable = "disable";
            }

            $('#step1').tooltip(enable);
            $("#step2").tooltip(enable);
            $("#step3").tooltip(enable);
        }

        function InitializeFreeMessage() {

            var translations = {};
            translations["Ok"] = $('#lblOk').text();
            translations["Cancel"] = $('#lblCancel').text();
            var buttonsOpts = {};
            //buttonsOpts[translations["Ok"]] = function () {
            //    AddFreeMessage();
            //    $('#txtFreeMessage1').val('');
            //    $('#txtFreeMessage2').val('');

            //    $(this).dialog("close");

            //}
            //buttonsOpts[translations["Cancel"]] = function () {
            //    $(this).dialog("close");
            //}

            buttonsOpts: [{
                id: "dialogSave",
                text: "Save",
                click: function () { $(this).dialog("close"); }
            },
            {
                id: "dialogCancel",
                text: "Cancel",
                click: function () {
                    $(this).dialog("close");
                }
            }];
            $('#txtFreeMessage1').val('');
            $('#txtFreeMessage2').val('');

            $("#divFreeMessage").dialog({
                autoOpen: false,
                height: 330,
                width: 800,
                modal: true,
                buttons: [{
                    id: "dialogSave",
                    text: $('#lblOk').text(),
                    click: function () {
                        var dialog = this;
                        checkMessages('freemessage')
                        .then(function () {
                            AddFreeMessage();
                            $('#txtFreeMessage1').val('');
                            $('#txtFreeMessage2').val('');
                            $(dialog).dialog("close");
                        }).catch(error => {
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
                                "hideDuration": "1000",
                                "timeOut": "1000",
                                "extendedTimeOut": "1000",
                                "showEasing": "swing",
                                "hideEasing": "linear",
                                "showMethod": "fadeIn",
                                "hideMethod": "fadeOut"
                                
                            }

                            toastr.error($('#hdnBadErrorMessage').val(), $('#hdnErrorHeader').val());
                        });
                    }
                },
                {
                    id: "dialogCancel",
                    text: $('#lblCancel').text(),
                    click: function () {
                        $('#txtFreeMessage1').val('');
                        $('#txtFreeMessage2').val('');
                        $(this).dialog("close");
                    }
                }]
            });
            //$("#dialogSave").button("option", "disabled", true);

        }

        function InitializeAddChangeWord() {
            var translations = {};
            translations["Ok"] = $('#lblOk').text();
            translations["Cancel"] = $('#lblCancel').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Ok"]] = function () {
                if (m_selectedItem != null) {
                    AddFreeFormWordOnSelectedPallete();
                }
                SaveUserWords($('#native').val(), $('#learning').val());
                $('#native').val('');
                $('#learning').val('');
                $('#sub').val('');
                $(this).dialog("close");
                m_shouldstoppropacation = false;

            }
            buttonsOpts[translations["Cancel"]] = function () {
                $(this).dialog("close");
                EndEdit(m_selectedItem);
            }

            $("#dialog-form").dialog({
                autoOpen: false,
                height: 300,
                width: 300,
                modal: true,
                buttons: [{
                    id: "wordDialogSave",
                    text: $('#lblOk').text(),
                    click: function () {
                        var dialog = this;
                        checkMessages('word')
                            .then(function () {
                                AddFreeFormWordOnSelectedPallete();
                                SaveUserWords($('#native').val(), $('#learning').val());
                                $('#native').val('');
                                $('#learning').val('');
                                $('#sub').val('');
                                m_shouldstoppropacation = false;
                                $(dialog).dialog("close");
                            }).catch(error => {
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
                                    "hideDuration": "1000",
                                    "timeOut": "10000",
                                    "extendedTimeOut": "1000",
                                    "showEasing": "swing",
                                    "hideEasing": "linear",
                                    "showMethod": "fadeIn",
                                    "hideMethod": "fadeOut"
                                    
                                }

                                toastr.error($('#hdnBadErrorMessage').val(), $('#hdnErrorHeader').val());
                            });
                    }
                },
                    {
                        id: "wordDialogCancel",
                        text: $('#lblCancel').text(),
                        click: function () {
                            $('#native').val('');
                            $('#learning').val('');
                            $('#sub').val('');

                            $(this).dialog("close");
                            EndEdit(m_selectedItem);
                        }
                    }],
                close: function (event, ui) { EndEdit(m_selectedItem); }
            });
            //$("#wordDialogSave").button("option", "disabled", true);
        }



        function AddFreeFormWordOnSelectedPallete() {
            var isedit = false;
            if (m_selectedItem != null)
                isedit = true;
            var parent = $('#<%=divSentence.ClientID %>');
            if (isedit) {
                m_selectedItem.find(".firstword").val($('#native').val());
                m_selectedItem.find(".secondword").val($('#learning').val());
                m_selectedItem.find(".thirdword").val('');
                m_selectedItem.find(".otherword").val($('#learning').val());

                m_selectedItem.find(".firstword").text($('#native').val());
                m_selectedItem.find(".secondword").text($('#learning').val());
                m_selectedItem.find(".thirdword").text('');
                m_selectedItem.find(".otherword").text($('#learning').val());

                m_selectedItem.find(".firstword").attr("data-word", $('#native').val());
                m_selectedItem.find(".firstword").attr("data-switchword", $('#native').val());
                m_selectedItem.find(".secondword").attr("data-word", $('#learning').val());
                m_selectedItem.find(".secondword").attr("data-switchword", $('#learning').val());
                m_selectedItem.find(".otherword").attr("data-word", "");
                m_selectedItem.find(".otherword").attr("data-switchword", "");

                m_selectedItem.find(".firstword").attr("data-sound", "");
                m_selectedItem.find(".secondword").attr("data-sound", "");
                m_selectedItem.find(".firstword").attr("data-image", "");
                m_selectedItem.find(".otherword").attr("data-image", "");
                m_selectedItem.find(".otherword").attr("data-sound", "");

                m_selectedItem.find(".firstword").attr("data-swapped", "1");
                m_selectedItem.find(".secondword").attr("data-swapped", "1");
                m_selectedItem.find(".thirdword").attr("data-swapped", "1");

                m_selectedItem.find(".firstword").attr("data-sentencesound", "");
                m_selectedItem.find(".secondword").attr("data-sentencesound", "");

                m_selectedItem.find(".secondword").attr("data-image", "");

                $(m_selectedItem).attr("data-sound", "");
                $(m_selectedItem).attr("data-image", "");
                $(m_selectedItem).find(".imgsmallspeaker").hide();
                $(m_selectedItem).find(".imgPicture").hide();

                m_selectedItem.find(".gallery").attr("href", "");
                var img = m_selectedItem.find(".imgPicture");
                if (img && img.length > 0) {
                    img.remove();
                }
                //m_selectedItem.find(".gallery").attr("href", "");
                var a = m_selectedItem.find(".gallery");
                if (a && img.length > 0) {
                    a.remove();
                }

                updateOwnPalette(m_selectedItem, true);
                EndEdit(m_selectedItem);

                m_selectedItem = null;
            }
            else {
                //var parent = $('#<%=divSentence.ClientID %>');
                var number = 100 + Math.floor(Math.random() * 1000);
                var span1 = "<span id='{0}' class='firstword'>".stringformat("divspanword" + number.toString()) + $('#native').val() + "</span>" + "<br/>"
                number = 100 + Math.floor(Math.random() * 1000) + 1;
                var span2 = "<span id='{0}' class='secondword'>".stringformat("divspanword" + number.toString()) + $('#learning').val() + "</span>" + "<br/>"
                number = 100 + Math.floor(Math.random() * 1000) + 2;
                var span3 = "<span id='{0}' class='thirdword'>".stringformat("divspanword" + number.toString()) + $('#sub').val() + "</span>" + "<br/>"
                number = 100 + Math.floor(Math.random() * 1000) + 2;
                var span4 = "<span id='{0}' class='otherword'>".stringformat("divspanword" + number.toString()) + $('#sub').val() + "</span>" + "<br/>"
                var words = span1 + span2 + span3 + span4;
                number = 1000 + Math.floor(Math.random() * 2000) + 3;
                var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:2px solid #2DE2E5;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px;position:relative;\" >" + "{1}" + "</div>").stringformat(number, words);

                //div.css("margin-left", "10px");
                //div.css("width", "");
                var divelement = $(div);
                //add x button for removal
                var id = number.toString();
                var img = $("<img id='img" + id + "' src='../Images/ico_Delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
                $(img).click(RemoveWord);

                divelement.append(img);
                //parent.append(divelement);
                //update the word count
                //var count = $('#lblWordCount').text();
                //count = parseInt(count) + 1;
                //$('#lblWordCount').text(count.toString());

                sessionStorage.setItem('shouldValidate', false);
            }
        }

        function AddEmoji(emoji) {

            var parent = $('#<%=divSentence.ClientID %>');
            var number = 100 + Math.floor(Math.random() * 1000);
            var span1 = "<span id='{0}' class='firstword' data-isemoji='true'>".stringformat("divspanword" + number.toString()) + emoji + "</span>" + "<br/>"
            number = 100 + Math.floor(Math.random() * 1000) + 1;
            var span2 = "<span id='{0}' class='secondword' data-isemoji='true' style='display:none;'>".stringformat("divspanword" + number.toString()) + emoji + "</span>" + "<br/>"
            number = 100 + Math.floor(Math.random() * 1000) + 1;
            var span3 = "<span id='{0}' class='otherword' data-isemoji='true' style='display:none;'>".stringformat("divspanword" + number.toString()) + emoji + "</span>" + "<br/>"
            var words = span1 + span2 + span3;
            number = 1000 + Math.floor(Math.random() * 2000) + 3;
            var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:2px solid #2DE2E5;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px;position:relative;\" >" + "{1}" + "</div>").stringformat(number, words);

            //div.css("margin-left", "10px");
            //div.css("width", "");
            var divelement = $(div);
            //add x button for removal
            var id = number.toString()
            var img = $("<img id='img" + id + "' src='../Images/ico_delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
            $(img).click(RemoveWord)

            divelement.append(img);
            parent.append(divelement);
            //update the word count
            //var count = $('#lblWordCount').text();
            //count = parseInt(count) + 1;
            //$('#lblWordCount').text(count.toString());

            //sessionStorage.setItem('shouldValidate', false);
        }

        function AddEmojiPunctuationSticker(el, type) {


            var isemoji = type.indexOf("isemoji") >= 0;
            var style = "";
            if (isemoji)
                style = "width:40px;height:40px;"

            var parent = $('#<%=divSentence.ClientID %>');
            var number = 100 + Math.floor(Math.random() * 1000);
            var span1 = "<span id='{0}' class='firstword' {1} style='{2}'>".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"
            number = 100 + Math.floor(Math.random() * 1000) + 1;
            var span2 = "<span id='{0}' class='secondword' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"
            number = 100 + Math.floor(Math.random() * 1000);
            var span3 = "<span id='{0}' class='otherword' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"
            //number = 100 + Math.floor(Math.random() * 1000) + 1;
            //var span3 = "<span id='{0}' class='fakewords' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"

            var words = span1 + span2 + span3;
            number = 1000 + Math.floor(Math.random() * 2000) + 3;
            var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:2px solid #2DE2E5;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px; position:relative; {2}\" >" + "{1}" + "</div>").stringformat(number, words);

            //div.css("margin-left", "10px");
            //div.css("width", "");
            var divelement = $(div);
            //add x button for removal
            var id = number.toString()
            var img = $("<img id='img" + id + "' src='../Images/ico_delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
            $(img).click(RemoveWord)

            divelement.append(img);
            parent.append(divelement);
            sessionStorage.setItem('isEmoji', "true");
            Add();
            //update the word count
            //var count = $('#lblWordCount').text();
            //count = parseInt(count) + 1;
            //$('#lblWordCount').text(count.toString());


        }

        function ReplacePunctuation(el, type) {


            var parent = $('#<%=divSentence.ClientID %>');
            var number = 100 + Math.floor(Math.random() * 1000);
            var span1 = "<span id='{0}' class='firstword' {1}>".stringformat("divspanword" + number.toString(), type) + el + "</span>" + "<br/>"
            number = 100 + Math.floor(Math.random() * 1000) + 1;
            var span2 = "<span id='{0}' class='secondword' {1} style='display:none;' >".stringformat("divspanword" + number.toString(), type) + el + "</span>" + "<br/>"
            number = 100 + Math.floor(Math.random() * 1000) + 1;
            var span3 = "<span id='{0}' class='otherword' {1} style='display:none;' >".stringformat("divspanword" + number.toString(), type) + el + "</span>" + "<br/>"

            //number = 100 + Math.floor(Math.random() * 1000) + 1;
            //var span3 = "<span id='{0}' class='fakewords' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"

            var words = span1 + span2 + span3;
            number = 1000 + Math.floor(Math.random() * 2000) + 3;
            var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:2px solid #2DE2E5;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px; position:relative; {2}\" >" + "{1}" + "</div>").stringformat(number, words);

            //div.css("margin-left", "10px");
            //div.css("width", "");
            var divelement = $(div);
            //add x button for removal
            var id = number.toString()
            var img = $("<img id='img" + id + "' src='../Images/ico_delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
            $(img).click(RemoveWord)

            divelement.append(img);
            parent.append(divelement);
            //update the word count
            //var count = $('#lblWordCount').text();
            //count = parseInt(count) + 1;
            //$('#lblWordCount').text(count.toString());

            //sessionStorage.setItem('shouldValidate', false);
        }

        function ShowTranlation() {
            $('#divFinalNativeMessage').toggle(1, function () {

                if ($('#divFinalNativeMessage').attr("data-isvisible") == "true") {
                    $('#divFinalLearningMessage').width("99%");
                    $('#divFinalNativeMessage').attr("data-isvisible", "false");
                }
                else {
                    $('#divFinalLearningMessage').width("48%");
                    $('#divFinalNativeMessage').attr("data-isvisible", "true");
                }
            });
        }

        function FreeForm() {
            //do not permit to add word.
            //if (m_selectedItem == null)
            //    return;

            InitializeAddChangeWord();
            $("#dialog-form").dialog("open");
        }
        function FreeMessage() {
            InitializeFreeMessage();
            $("#divFreeMessage").dialog("open");
        }

        function ClickSentenceSound(el) {
            //debugger;
            var sentencesound = $(el).parent().siblings(".soundicon");
            if (sentencesound.length > 0)
                $(sentencesound).click();
            Add();
        }

        //function SwitchSoundOnClickEvent()
        //{
        //    debugger;
        //    $(".pallete").each(function () {
        //        var onclickfunction = "AddAllWords(this, event);";
        //        if ($(".chkSoundAndMail").prop("checked") == false) {
        //            onclickfunction = "ClickSentenceSound(this);";
        //        }
        //        $(this).children("div").children(".addallwords, .speaker").attr("onclick", onclickfunction);
        //    });

        //}
        function AppendOrderedNativeLanguage(el) {
            if (el == null) {
                $('.nativelanguageContainer').remove();
                $(".pallete").each(function () {
                    var x;
                    var y = "";
                    var firstwords = $(this).find(".firstword");
                    x = $(firstwords).sort(function (a, b) {
                        return ($(b).data('ordinal')) < ($(a).data('ordinal')) ? 1 : -1;
                    });

                    $(x).each(function () {
                        y += $(this).text() + "&nbsp;";
                    });

                    div = "<div class='nativelanguageContainer'><span class='nativeLanguageText'>{0}</span></div>";
                    div = div.stringformat(y);
                    $(this).append(div);
                });
            }
            else {
                var x;
                var y = "";
                var parent = $(el).closest('.pallete');
               
                var firstwords = $(parent).find(".firstword");
                x = $(firstwords).sort(function (a, b) {
                    return ($(b).data('ordinal')) < ($(a).data('ordinal')) ? 1 : -1;
                });

                $(x).each(function () {
                    y += $(this).text() + "&nbsp;";
                });



                var div = $(parent).find(".nativelanguageContainer");
                $(div).html(y);
                //$(el).append(div);
            }
        }
        function AppendCircleButton() {
            //if ($(".pallete").has("#addallWords").length == 0)
            $(".pallete").each(function () {
                if ($(this).find("#addallWords").size() == 0)
                    $(this).append("<div style='position:relative;float:right'><img id='addallWords' class='addallwords' onclick='AddAllWords(this, event);'  src='/images/new/talkSend.png' style='width:32px;height:32px;padding-left:1px;padding-right:1px;cursor:pointer'/>" +
                        "<img id='sendspeaker' class='sendspeaker' src='/images/new/ICO_Speaker.png' style='position:absolute; width:24px;height:24px;cursor:pointer;left:0px;' onclick='AddAllWords(this, event);'/></div>");
            });

            ShowHideMailSoundIcon();
            AppendOrderedNativeLanguage(null);
            //else
            //{
            //    $(".pallete").each(function () {
            //        //var sentencesound = $(this).children('.soundicon');
            //        $(this).append("<div style='position:relative;float:right'><img id='addallWords' class='addallwords' onclick='ClickSentenceSound(this);'  src='/images/sendchat.png' style='width:32px;height:32px;padding-left:1px;padding-right:1px;cursor:pointer'/>" +
            //        "<img id='speaker' class='speaker' src='/images/ICO_Speaker.png' style='position:absolute; width:24px;height:24px;cursor:pointer;left:0px;' onclick='ClickSentenceSound(this);'/></div>");
            //    });

            //    $(".pallete").each(function () {
            //        var click = $(this).children("div").children(".addallwords").attr("onclick");
            //        alert(click);
            //    });

            //}
        }

        function toggleCallInProgress() {
            $(".conversationDate").toggleClass("conversationDateCallInProgress");
            $(".tblMessage_conversation").toggleClass("tblMessage_conversationCallInProgress");

            //$(".divMessage").toggleClass("divMessageSecondLanguageOnly");
            $('.newbubble1').toggleClass('learning');
            $('.imgReport').toggle();
            $('.chatname').toggleClass("nameInside");
            $('.chatdate').toggleClass("dateInside");
            $('.tblMessage_conversation').each(function () {
                var conv = $(this).find('.newbubble1');
                if (conv.hasClass("newyou")) {
                    conv.toggleClass("newyouInside");
                }
                //debugger;
                if ($("#chkCallInProgress").prop("checked") == true) {

                    $(this).find('.newbubble').addClass("newbubbleInside newmeInside");
                    $(this).find('.newbubble').appendTo(conv)

                    //$(this).parent().siblings().find(".nameContainer").find("#lblMe").appendTo($(this).siblings().find(".conversationDate"));
                    $(this).parent().siblings(".nameContainer").children("span").appendTo($(this).siblings(".conversationDate"));
                }
                else {
                    $(this).find('.newbubble').removeClass("newbubbleInside newmeInside");
                    $(this).find('.newbubble').removeClass("newyouInside");
                    $(this).find('.newbubble').prependTo($(this));
                    $(this).siblings(".conversationDate").children("#lblMe,#lblYou").prependTo($(this).parent().siblings('.nameContainer'));
                }
            });
        }
        function ChangeConversationColor() {
            var partner = $(".partner");
            if ($(partner).length > 0) {
                $(partner).each(function () {
                    $(this).parents("tr:first").find(".newbubble1").addClass("partnerbubble");
                });
            }
        }

        function ShowHideMailSoundIcon() {
            if ($('.chkSoundAndMail').prop("checked") == true)
                $(".sendspeaker").css("visibility", "visible");
            else
                $(".sendspeaker").css("visibility", "hidden");
        }
        function ShowHideSubLanguage2() {
            SwitchWords($(".chkSubLanguage2"));
        }
        function changeOwnPaletteButton() {
            $("#btnAddOwnPalette").html($("#hdnAddOwnPaletteLabel").val());
            $("#btnRemoveOwnPalette").html($("#hdnRemoveOwnPaletteLabel").val());
        }

        function saveOwnPalette() {
            var checkedPalette = '';
            $('.chkAddtoMyPhrases :checkbox:checked').each(function () {
                checkedPalette += $(this).parent().attr("data-paletteid") + ",";
            });
            var json = {
                Type: 'saveownpalette',
                SelectedPalette: checkedPalette
            };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {
                    $('#btnSearchSentenceUserPalette').click();
                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-center-right",
                        "preventDuplicates": true,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "5000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }

                    toastr.success("Selected Palette saved to My Phrases.", "Success");
                    $('.chkAddtoMyPhrases :checkbox').prop("checked", false);
                }
            });
            return false;
        }

        function deleteOwnPalette() {
            var checkedPalette = '';
            $('.chkAddtoMyPhrases :checkbox:checked').each(function () {
                checkedPalette += $(this).parent().attr("data-paletteid") + ",";
            });
            var json = {
                Type: 'deleteownpalette',
                SelectedPalette: checkedPalette
            };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {
                    $('#btnSearchSentenceUserPalette').click();
                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-center-right",
                        "preventDuplicates": true,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "5000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        //"hideMethod": "fadeOut"
                    }

                    toastr.success("Selected Palette removed from My Phrases.", "Success");
                }
            });
            return false;
        }
        function updateOwnPalette(element, custom) {
            var firstid = element.find(".firstword").data("phraseid");
            var secondid = element.find(".secondword").data("phraseid");
            var thirdid = element.find(".thirdword").data("phraseid");
            var subwordid = $('#hdnNativeLanguageCode').val() == "en-US" ? element.find(".secondword").data("switchwordphraseid") : element.find(".firstword").data("switchwordphraseid");


            var json = {
                Type: 'updateownpalette',
                phrases:
                    JSON.stringify([
                        { ID: firstid, Word: element.find(".firstword").text(), Sound: element.find(".secondword").data("sound"), ImageFile: element.find(".firstword").data("image") },
                        { ID: secondid, Word: element.find(".secondword").data("word"), Sound: element.find(".firstword").data("sound"), ImageFile: element.find(".secondword").data("image") },
                        { ID: thirdid == "" ? 0 : thirdid, Word: custom ? null : element.find(".thirdword").text(), Sound: null, ImageFile: null },
                        {
                            ID: subwordid, Word: $('#hdnNativeLanguageCode').val() == "en-US" ? element.find(".secondword").data("switchword") : element.find(".firstword").data("switchword"),
                            Sound: $('#hdnNativeLanguageCode').val() == "en-US" ? element.find(".firstword").data("sound") : element.find(".secondword").data("sound"),
                            ImageFile: $('#hdnNativeLanguageCode').val() == "en-US" ? element.find(".secondword").data("image") : element.find(".firstword").data("image")
                        }
                    ])
            };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {

                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": false,
                        "positionClass": "toast-center-right",
                        "preventDuplicates": true,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "5000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }

                    toastr.success("Palette updated.", "Success");
                }
            });
            return false;
        }

        function showCallButton() {
            $('#lblCanTalkContainer').show();
            $('#divCall').show();
            $('#divCall_01').show();

        }




        $(function () {
            var bootstrapButton = $.fn.button.noConflict(); // return $.fn.button to previously assigned value
            $.fn.bootstrapBtn = bootstrapButton;            // give $().bootstrapBtn the Bootstrap functionality
            var jqeBsTooltip = $.fn.tooltip.noConflict();
            $.fn.tlp = jqeBsTooltip;
            var maxLength = 100;
            charactersLeftText = $('#lblcharleftLabel1').text();
            $('#lblcharleftLabel1').text(charactersLeftText.stringformat(maxLength));
            $('#lblcharleftLabel2').text(charactersLeftText.stringformat(maxLength));
            ////$("#btnCallIcon").click(CreateAndJoinConference);
            //$("#btnCallIcon").click(function () {
            //    alert("xxxx");
            //});
            $(".editButtonClass").click(() => {
                //e.preventDefault();
                alert("this is tets");
            });
            isWithinThreshold();
            callImReadyHandler(-1);
            prepareCallToolsButton();
            $('#divImReady').click(function () {
                terminateReminder()
                $('#hdnButtonType').val("Ready");
                SelectSupport("Ready");
            });
            $('#divRepeatImage').click(function () {
                PleaseRepeat();
            });
            $('#divTextMeImage').click(function () {
                TextMe();
            });

            $('#divIssueImage').click(function () {
                $('#hdnButtonType').val("Issues");
                SelectSupport("Issues");
            });

            $('#divAdviceImage').click(function () {
                ThankYouForYourAdvice();
            });

            $("#chkSecondLanguage").change(function () {
                $(".lblLanguage").toggleClass("chkSecondLanguageSelected");
                $('.newbubble').toggle();
                $('.newbubble1').toggleClass('newbubble1secondlanguageonly');
            });

            //ShowHideMailSoundIcon();
            $('.chkSoundAndMail').change(function () {
                if ($('.chkSoundAndMail').prop("checked") == true)
                    $(".sendspeaker").css("visibility", "visible");
                else
                    $(".sendspeaker").css("visibility", "hidden");
            });

            $("#chkCallInProgress").change(function () {
                //toggleCallInProgress();
            });

            $("#txtFreeMessage2").attr("placeholder", $('#hdnFreeTextMessage1PlaceHolder').val());
            $("#txtFreeMessage1").attr("placeholder", $('#hdnFreeTextMessage2PlaceHolder').val());
            $("#txtSearchSentence").attr("placeholder", $('#hdnPhraseSearch').val());
            $("#txtSearchWord").attr("placeholder", $('#hdnWordSearch').val());
            changeOwnPaletteButton();
            $('#txtFreeMessage1').keyup(function () {
                var length = $(this).val().length;
                var length = maxLength - length;
                $('#lblcharleft1').text(length);
                $('#lblcharleftLabel1').text(charactersLeftText.stringformat(length));
            });
            $('#txtFreeMessage2').keyup(function () {
                var length = $(this).val().length;
                var length = maxLength - length;
                $('#lblcharleft2').text(length);
                $('#lblcharleftLabel2').text(charactersLeftText.stringformat(length));


            });
            $('#txtFreeMessage1').keypress(function (e) {
                if (e.keyCode === 13) {
                    $('#lnkTranslate').click();
                    setTimeout(function () { $('#divFreeMessage').parent().find("button:eq(1)").focus(); }, 100);
                }
            });
            $('#txtFreeMessage1').blur(function () {
                //var sl = $("#hdnNativeLanguageCode").val().substr(0, 2);
                //var tl = $("#hdnLearningLanguageCode").val().substr(0, 2);
                //Translate(sl, tl, $("#txtFreeMessage1").val(), $("#txtFreeMessage2"), 'freemessage');
                $('#lnkTranslate').click();
            });
            //$('#txtFreeMessage2').blur(function () {
            //    var sl = $("#hdnNativeLanguageCode").val().substr(0, 2);
            //    var tl = $("#hdnLearningLanguageCode").val().substr(0, 2);
            //    Translate(sl, tl, $("#txtFreeMessage1").val(), $("#txtFreeMessage2"), 'freemessage');
            //});

            AppendCircleButton();
            InitializeTooltipSteps();
            $('#chkTooltip').change(function () {
                EnableDisableTooltip(this)
            });

            var isSafari = !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/);

            //if (isSafari)
            //    $("#txtSearchSentence").addClear({ right: 50 });
            //else
            $("#txtSearchSentence").clearable();
            $("#txtSearchWord").clearable();

            $("#txtSearchSentence").on('keypress', function (e) {
                
                if (e.which == 13) {
                    changeActiveTab();
                    $('#imgSearchSentence').click();
                    e.preventDefault();
                }
            });
            $("#txtSearchWord").on('keypress', function (e) {
                if (e.which == 13) {
                    $('#imgSearchWord').click();
                    e.preventDefault();
                }
            });


            $('#imgSearchSentence').click(function () {
                UpdateCategory();
            });
            $('#btnCloseEmoji').click(function (e) {
                $('#emojigallery').dialog('close');
            });
            $('#imgEmoji').click(function () {
                var json = { Type: 'emoji' };
                $.post("../PhotoDetailsHandler.ashx", json, function (data) {
                    var obj = $.parseJSON(data)
                    var ediv = '';
                    var sdiv = '';

                    $.each(obj[0].emoji, function () {
                        ediv += '<div class="emoji" onclick="HighlightEmoji(this); SelectEmoji(this);">' +
                            '<img src="{0}" alt=""style="width:24px;height:24px;">&nbsp;&nbsp;</div>'.stringformat(this.ImageName);

                    });
                    $.each(obj[1].sticker, function () {
                        sdiv += '<div class="emoji" onclick="HighlightEmoji(this);SelectEmoji(this);">' +
                            '<img src="{0}" alt="" style="width:50px;height:50px;">&nbsp;&nbsp;</div>'.stringformat(this.ImageName);

                    });

                    $('#emoji').empty();
                    $('#sticker').empty();
                    $('#emoji').append(ediv);
                    $('#sticker').append(sdiv);
                    $("#emojigallery").dialog({
                        autoOpen: true,
                        height: 480,
                        width: 500,
                        position: ['center', 'center'],
                        modal: true,
                        open: function (event, ui) {
                        },
                        close: function (event, ui) {
                        }
                    }
                    );
                });
            });
            $('#imgPunctuation').click(function () {
                SetupPopOver();
            });
            //----------------------------------

            $('#btnSave').click(function (e) {
                var json = {
                    Type: 'useroptions',
                    SequenceOptionFlag: $('.chkSequence').prop("checked"),
                    NativeOptionFlag: $('.chkNative').prop("checked"),
                    SubLanguageOptionFlag: $('.chkSecondary').prop("checked"),
                    SubLanguage2OptionFlag: $('.chkSubLanguage2').prop("checked"),
                    SoundAndMail: $('.chkSoundAndMail').prop("checked"),
                    StepOptionFlag: $('#chkTooltip').prop("checked")
                };
                $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                    var obj = $.parseJSON(data)
                    if (obj.Status == "True") {
                        $('#lblSaveMessage').show();
                    }
                });
                e.stopPropagation();
            });

            $('.logo').attr("src", "../images/p_talk1.png");
            $('.logo').attr("width", "179px");
            $('.logo').attr("height", "40px");


            $("#wordtabs").tabs({
                activate: function (event, ui) {
                    if (ui.newTab.index() == 0) {
                        if (m_selectedItem == null) {
                            $('#btnAddWord').hide();
                        }
                        $('#btnDeleteWord').hide();
                    }
                    if (ui.newTab.index() == 1) {
                        $('#btnAddWord').show();
                        $('#btnDeleteWord').show();
                    }
                    _currentWordTab = ui.newTab.index();
                }
            }).removeClass('ui-tabs-vertical ui-helper-clearfix');
            //$("#wordtabs").tabs().removeClass('ui-tabs-vertical ui-helper-clearfix');
            //$("#btnAddWord").text($('#hdnAddWord').val());

            $("#chkShowTranslation").change(function () {
                //ShowTranlation();
            });
            $('#<%=chkSequence.ClientID%>').change(function () {

                HideShowSequence(this)
            });
            $('#<%=chkNative.ClientID%>').change(function () {
                HideShowWords(this, '.firstword');
            });
            $("#chkSecondary").change(function () {
                HideShowWords(this, '.thirdword');
            });
            $(".chkLanguageOrder").change(function () {
                SwitchLanguageOrder(this);
            });
            $(".chkSubLanguage2").change(function () {
                SwitchWords(this);
                //alert("helloooo")
            });

            //---Start Chat


            //---End Chat
            //-------------------------------

            //InitializedContextMenuForPalette();
            //$(document).on('keydown', function (e) {
            //    var tag = e.target.tagName.toLowerCase();
            //    if (e.which === 13 && !$(e.target).is('input, text, select')) {
            //        $('#btnAdd').click();
            //    }
            //});

            $('.sortable').sortable({
                placeholder: 'highlight', axis: 'x',
                start: function (event, ui) {
                    ui.placeholder.height(ui.item.height());
                    ui.placeholder.width(ui.item.width());
                    ui.item.toggleClass("highlight");
                },
                stop: function (event, ui) {
                    ui.item.toggleClass("highlight");
                }
            }).disableSelection();
            ClearSelectedSentence();
            //let from = sessionStorage.getItem("from");
            //let room = sessionStorage.getItem("room");
            //let group = sessionStorage.getItem("group");
            //let roomKey = sessionStorage.getItem("roomKey");
            //let receiver = sessionStorage.getItem("receiver");
            //sessionStorage.removeItem("from");
            //sessionStorage.removeItem("room");
            //sessionStorage.removeItem("group");
            //sessionStorage.removeItem("roomKey");
            //sessionStorage.removeItem("receiver");
            //if (from != null && from != undefined) {
            //    userIsCalling(receiver, from, room, group, roomKey);
            //}

        });

        function prepareCallToolsButton() {
            if ($('#hdnNativeLanguageCode').val() == "en-US") {
                $('#divImReady').addClass("divImReady_en");
                $('#divRepeatImage').addClass("divRepeatImage_en");
                $('#divTextMeImage').addClass("divTextMeImage_en");
                $('#divFreeMessageImage').addClass("divFreeMessageImage_en");
                $('#divIssueImage').addClass("divIssueImage_en");
                $('#divAdviceImage').addClass("divAdviceImage_en");
            }
            else {
                $('#divImReady').addClass("divImReady_jp");
                $('#divRepeatImage').addClass("divRepeatImage_jp");
                $('#divTextMeImage').addClass("divTextMeImage_jp");
                $('#divFreeMessageImage').addClass("divFreeMessageImage_jp");
                $('#divIssueImage').addClass("divIssueImage_jp");
                $('#divAdviceImage').addClass("divAdviceImage_jp");
            }
        }

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
        function CategoryChanged() {

            $(".clear-helper").click();
        }
        function changeAddWordText() {

            $("#btnAddWord").text($('#hdnAddWord').val());
        }

        function RemoveUserWord(e, el) {
            var translations = {};
            translations["Ok"] = "Yes";//$('#lblYes').text();
            translations["Cancel"] = "No";//$('#lblNo').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Ok"]] = function () {
                var json = {
                    Type: 'deleteword',
                    id: $(el).data("id"),
                 };
                 $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                     var obj = $.parseJSON(data)
                     if (obj.Status == "True") {
                         $('#btnSearchWord').click();
                     }
                 });
                 $(this).dialog("close");
             }
             buttonsOpts[translations["Cancel"]] = function () {
                 $(this).dialog("close");
            }
            $('#lblSaveWordQuestion').text($('#hdnDeleteWord').val());
            $("#divSaveWordDialog").dialog({
                 autoOpen: true,
                 height: 200,
                 width: 350,
                 modal: true,
                 buttons: buttonsOpts
            });
            e.stopPropagation();
            e.preventDefault();
            return false;
        }

        function SaveUserWords(native, learning) {
            var translations = {};
            translations["Ok"] = "Yes";//$('#lblYes').text();
            translations["Cancel"] = "No";//$('#lblNo').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Ok"]] = function () {
                var json = {
                    Type: 'saveword',
                    SenderId: <%=Language.Discovery.SessionManager.Instance.UserProfile.UserID.ToString()%>,
                    Learning: learning,//$('#learning').val(),
                    Native: native//$('#native').val()
                };
                $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                    var obj = $.parseJSON(data)

                    if (obj.Status == "True") {
                        $('#learning').val('');
                        $('#native').val('');
                        $('#btnSearchWord').click();
                    }
                });
                $('#native').val('');
                $('#learning').val('');
                $('#sub').val('');
                $(this).dialog("close");
            }
            buttonsOpts[translations["Cancel"]] = function () {
                $('#native').val('');
                $('#learning').val('');
                $('#sub').val('');
                $(this).dialog("close");
            }
            $('#lblSaveWordQuestion').text($('#hdnSaveWord').val());
            $("#divSaveWordDialog").dialog({
                autoOpen: true,
                height: 200,
                width: 350,
                modal: true,
                buttons: buttonsOpts
            });
        }
        function HighlightEmoji(el) {
            $(el).siblings('.emoji').css("border", "");
            $(el).css("border", "1px solid red");
        }
        function SelectEmoji(el) {

            var emoji = $('#imgEmoji');
            //$(emoji).attr("src", $(el).find('img').attr('src'));
            //$('#emoji').empty();
            $('#emojigallery').dialog('close');
            if ($(el).find('img').length > 0)
                AddEmojiPunctuationSticker($(el).find('img')[0].outerHTML, "data-isemoji='true'");
            else
                AddEmojiPunctuationSticker($(el).find('span')[0].outerHTML, "data-ispunctuation='true'");
            //AddEmoji($(el).find('img')[0].outerHTML);
        }

        function SelectPunctuation(el) {
            //ReplacePunctuation($(el).find('span')[0].outerHTML, "data-ispunctuation='true'");
            m_shouldstoppropacation = false;
            if (m_selectedItem != null)
                wordClick($(el)[0].id, false, false, false);
            else
                AddEmojiPunctuationSticker($(el).find('span')[0].outerHTML, "data-ispunctuation='true'");
            ClosePopOver();


        }

        function GetFinalMessage() {
            var jsonsentences = "[{ \"LanguageCode\":\"" + $('#hdnLearningLanguageCode').val() + "\", \"Message\" :\"";
            var sentence = "";
            $('#hdnKeywords').val('');
            $("#divFinalLearningMessage, .divUserPaletteContainer ").children("div").each(function () {
                $(this).children("span").each(function () {
                    var s = $(this)[0].outerHTML;
                    var obj = $(s);
                    if ($(obj).is("[data-image]") && $(obj).attr("data-image").length > 0) {
                        s = s.replace(/span/g, "a");
                        obj = $(s);
                        $(obj).attr("href", $(obj).attr("data-image"));
                        $(obj).addClass("gallery");
                        $(obj).attr("onclick", "ShowPicture();");

                    }
                    if ($(obj).is("[data-sound]")) {
                        if ($(obj).attr("data-sound").indexOf(".mp3") > -1) {
                            $(obj).addClass("hasSound");
                        }
                    }
                    if ($(obj).is("[data-keyword]") && $('#hdnKeywords').val().indexOf($(obj).attr("data-keyword")) == -1) {
                        if ($('#hdnKeywords').val() == "")
                            $('#hdnKeywords').val($(obj).attr("data-keyword"));
                        else
                            $('#hdnKeywords').val($('#hdnKeywords').val() + ";" + $(obj).attr("data-keyword"));
                    }

                    sentence += $(obj)[0].outerHTML + '&nbsp;';
                });

                $(this).children("input").each(function () {
                    sentence += $(this).val();
                });
                //sentence = $(this)[0].innerHTML;
                jsonsentences += sentence.replace(/"/g, "'") + "|";
                $('#<%=hdnLearning.ClientID%>').val($('#<%=hdnLearning.ClientID%>').val() + sentence + "|");
                sentence = "";

            });

            jsonsentences += "\"},";
            jsonsentences += "{ \"LanguageCode\":\"" + $('#hdnNativeLanguageCode').val() + "\", \"Message\" :\"";
            $("#divFinalNativeMessage, .divUserPaletteContainer").children("div").each(function () {
                $(this).children("span").each(function () {
                    var s = $(this)[0].outerHTML;
                    var obj = $(s);
                    if ($(obj).is("[data-image]") && $(obj).attr("data-image").length > 0) {
                        s = s.replace(/span/g, "a");
                        obj = $(s);
                        $(obj).attr("href", $(obj).attr("data-image"));
                        $(obj).addClass("gallery");
                        $(obj).attr("onclick", "ShowPicture();");

                    }
                    if ($(obj).is("[data-sound]")) {
                        if ($(obj).attr("data-sound").indexOf(".mp3") > -1) {
                            $(obj).addClass("hasSound");
                        }
                    }
                    if ($(obj).is("[data-keyword]") && $('#hdnKeywords').val().indexOf($(obj).attr("data-keyword")) == -1) {
                        if ($('#hdnKeywords').val() == "")
                            $('#hdnKeywords').val($(obj).attr("data-keyword"));
                        else
                            $('#hdnKeywords').val($('#hdnKeywords').val() + ";" + $(obj).attr("data-keyword"));
                    }

                    sentence += $(obj)[0].outerHTML + '&nbsp;';
                });

                $(this).children("input").each(function () {
                    sentence += $(this).val();
                });
                jsonsentences += sentence.replace(/"/g, "'").replace(/firstword/g, "") + "|";
                $('#<%=hdnNative.ClientID%>').val($('#<%=hdnNative.ClientID%>').val() + sentence.replace(/firstword/g, "") + "|");

                sentence = "";


            });
            jsonsentences += "\"},";
            //debugger;
            var languagearray = $.parseJSON($('#hdnOtherLanguageCode').val());
            jsonsentences += "{ \"LanguageCode\":\"" + languagearray[0] + "\", \"Message\" :\"";
            if ($otherlanguages != null) {

                $otherlanguages.children("div").each(function () {
                    $(this).children("span").each(function () {
                        var s = $(this)[0].outerHTML;
                        var obj = $(s);
                        if ($(obj).is("[data-image]")) {
                            s = s.replace(/span/g, "a");
                            obj = $(s);
                            $(obj).attr("href", $(obj).attr("data-image"));
                            $(obj).addClass("gallery");
                            $(obj).attr("onclick", "ShowPicture();");

                        }
                        if ($(obj).is("[data-sound]")) {
                            if ($(obj).attr("data-sound").indexOf(".mp3") > -1) {
                                $(obj).addClass("hasSound");
                            }
                        }
                        if ($(obj).is("[data-keyword]") && $('#hdnKeywords').val().indexOf($(obj).attr("data-keyword")) == -1) {
                            if ($('#hdnKeywords').val() == "")
                                $('#hdnKeywords').val($(obj).attr("data-keyword"));
                            else
                                $('#hdnKeywords').val($('#hdnKeywords').val() + ";" + $(obj).attr("data-keyword"));
                        }

                        sentence += $(obj)[0].outerHTML + '&nbsp;';
                    });


                    $(this).children("input").each(function () {
                        sentence += $(this).val();
                    });
                    //sentence = $(this)[0].innerHTML;
                    //debugger;
                    jsonsentences += sentence.replace(/"/g, "'") + "|";
                    $('#hdnOtherLanguages').val($('#hdnOtherLanguages').val() + sentence + "|");
                    sentence = "";

                });
            }
            //debugger;
            jsonsentences += "\"}]";
            //debugger;
            var native = $('#<%=hdnNative.ClientID%>').val();
            var learn = $('#<%=hdnLearning.ClientID%>').val();
            var receiverid = $('#hdnSelectedUserID').val();
            //if (supportId != 0) {
            //    receiverid = supportId;
            //}

            if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                $.connection.hub.start().done(function () {
                    chat.server.send(receiverid, $('#hdnCurrentUserID').val(), learn, native, jsonsentences, $('#hdnGroupName').val(), $('#hdnKeywords').val());
                });
            } else {
                chat.server.send(receiverid, $('#hdnCurrentUserID').val(), $('#<%=hdnLearning.ClientID%>').val(), $('#<%=hdnNative.ClientID%>').val(), jsonsentences, $('#hdnGroupName').val(), $('#hdnKeywords').val());
            }
            $('#<%=hdnNative.ClientID%>').val('');
            $('#<%=hdnLearning.ClientID%>').val('');

            $("tr.message").removeClass("message");
            return true;
        }

        function SetPalleteSelectable() {
        }


        function ShowPicture(e) {
            _wordTabDialogOpen = true;
            $("a.gallery").colorbox({
                onClosed: function () {
                    _wordTabDialogOpen = false;
                }
            });
            // m_shouldstoppropacation = true;
            return false;
        }
        function InitializeSearchText(value) {
            $('#txtSearchSentence').val(value);
        }

        function InitializeCategory(value) {
            $('#ddlCategory').val(value);
        }

        function ActivateSentencePaging(page, totalpage) {


            var option = "";
            var numofpages = 5;
            if (totalpage == 0)
                numofpages = 0;
            if (totalpage == 0) {
                $('#hdnsentencepage').val("1");
                $('#sentencePaging').empty();
                return;
            }
            $('#sentencePaging').pagination({
                items: totalpage,
                currentPage: page,
                displayedPages: numofpages,
                cssStyle: 'compact-theme',
                firstPageText: "<<",
                lastPageText: ">>",
                prevText: "<",
                nextText: ">",
                edges: 0,
                onPageClick: function (pageNumber, event) {

                    $('#hdnsentencepage').val(pageNumber);
                    $('#btnSearchSentence').click();
                }

            });
            if (totalpage == 1) {
                $('#sentencePaging').find('.prev').remove();
                $('#sentencePaging').find('.next').remove();
            }
            $(".sContainerb").swipe({
                //Generic swipe handler for all directions
                swipe: function (event, direction, distance, duration, fingerCount, fingerData) {
                    var currentpage = parseInt($('#hdnsentencepage').val());
                    if (direction == "up") {
                        currentpage = currentpage + 1;
                        if (currentpage > totalpage)
                            return;
                        $('#hdnsentencepage').val(currentpage);
                    } else if (direction == "down") {
                        currentpage = currentpage - 1;
                        if (currentpage < 1)
                            return;
                        $('#hdnsentencepage').val(currentpage);
                    }
                    $('#btnSearchSentence').click();
                    //$(this).text("You swiped " + direction);
                },
                //Default is 75px, set to 0 for demo so any distance triggers swipe
                threshold: 75
            });

        }

        function ActivateSentencePagingForUserPalette(page, totalpage) {


            var option = "";
            var numofpages = 5;
            if (totalpage == 0)
                numofpages = 0;
            if (totalpage == 0) {
                $('#hdnsentencepageUserPalette').val("1");
                $('#sentencePagingOwnPalette').empty();
                return;
            }
            $('#sentencePagingOwnPalette').pagination({
                items: totalpage,
                currentPage: page,
                displayedPages: numofpages,
                cssStyle: 'compact-theme',
                firstPageText: "<<",
                lastPageText: ">>",
                prevText: "<",
                nextText: ">",
                edges: 0,
                onPageClick: function (pageNumber, event) {

                    $('#hdnsentencepageUserPalette').val(pageNumber);
                    $('#btnSearchSentenceUserPalette').click();
                }

            });
            if (totalpage == 1) {
                $('#sentencePagingOwnPalette').find('.prev').remove();
                $('#sentencePagingOwnPalette').find('.next').remove();
            }
            $(".divUserPaletteContainer").swipe({
                //Generic swipe handler for all directions
                swipe: function (event, direction, distance, duration, fingerCount, fingerData) {
                    var currentpage = parseInt($('#hdnsentencepageUserPalette').val());
                    if (direction == "up") {
                        currentpage = currentpage + 1;
                        if (currentpage > totalpage)
                            return;
                        $('#hdnsentencepageUserPalette').val(currentpage);
                    } else if (direction == "down") {
                        currentpage = currentpage - 1;
                        if (currentpage < 1)
                            return;
                        $('#hdnsentencepageUserPalette').val(currentpage);
                    }
                    $('#btnSearchSentenceUserPalette').click();
                    //$(this).text("You swiped " + direction);
                },
                //Default is 75px, set to 0 for demo so any distance triggers swipe
                threshold: 75
            });

        }

        function ActivateWordPaging(page, totalpage) {
            var option = "";
            var numofpages = 7;
            if (totalpage == 0)
                numofpages = 0;

            if (totalpage == 0) {
                $('#hdnwordpage').val("1");
                $('#wordPaging').empty();
                return;
            }


            $('#wordPaging').pagination({
                items: totalpage,
                currentPage: page,
                displayedPages: numofpages,
                cssStyle: 'compact-theme',
                firstPageText: "<<",
                lastPageText: ">>",
                prevText: "<",
                nextText: ">",
                edges: 0,
                onPageClick: function (pageNumber, event) {
                    $('#hdnwordpage').val(pageNumber);
                    $('#btnSearchWord').click();
                }

            });
            if (totalpage == 1) {
                $('#wordPaging').find('.prev').remove();
                $('#wordPaging').find('.next').remove();
            }
            $(".sContainer").swipe({

                //Generic swipe handler for all directions
                swipe: function (event, direction, distance, duration, fingerCount, fingerData) {
                    var currentpage = parseInt($('#hdnwordpage').val());
                    if (direction == "right") {
                        currentpage = currentpage + 1;
                        if (currentpage > totalpage)
                            return;
                        $('#hdnwordpage').val(currentpage);
                    } else if (direction == "left") {
                        currentpage = currentpage - 1;
                        if (currentpage < 1)
                            return;
                        $('#hdnwordpage').val(currentpage);
                    }
                    $('#btnSearchWord').click();
                    //$(this).text("You swiped " + direction);
                },
                //Default is 75px, set to 0 for demo so any distance triggers swipe
                threshold: 75
            });
        }

        function ActivateWordPagingUserCreated(page, totalpage, ispageload) {

            var option = "";
            var numofpages = 4;
            if (totalpage == 0)
                numofpages = 0;

            if (totalpage == 0) {
                $('#hdnwordpageusercreated').val("1");
                $('#wordPagingusercreated').empty();
                return;
            }
            $('#wordPagingusercreated').pagination({
                items: totalpage,
                currentPage: page,
                displayedPages: numofpages,
                cssStyle: 'compact-theme',
                firstPageText: "<<",
                lastPageText: ">>",
                prevText: "<",
                nextText: ">",
                edges: 0,
                onPageClick: function (pageNumber, event) {
                    $('#hdnwordpageusercreated').val(pageNumber);
                    $('#btnSearchWordUserCreated').click();
                }

            });
            if (totalpage == 1) {
                $('#wordPagingusercreated').find('.prev').remove();
                $('#wordPagingusercreated').find('.next').remove();
            }
            //if (ispageload)
            //    $('.items2').hide();

            $("#divWordContainerUserCreated").swipe({
                //Generic swipe handler for all directions
                swipe: function (event, direction, distance, duration, fingerCount, fingerData) {
                    var currentpage = parseInt($('#hdnwordpageusercreated').val());
                    if (direction == "left") {
                        currentpage = currentpage + 1;
                        if (currentpage > totalpage)
                            return;
                        $('#hdnwordpageusercreated').val(currentpage);
                        //ToggleSlider("items2", "left", "hide");
                        //$('#btnSearchWord').click();
                        //$('.items2').show("slide", {
                        //    direction: "left"
                        //}, 2000);

                    } else if (direction == "right") {
                        currentpage = currentpage - 1;
                        if (currentpage < 1)
                            return;
                        $('#hdnwordpageusercreated').val(currentpage);
                        //ToggleSlider("items2", "right", "hide");
                    } else {
                        return;
                    }
                    $('#btnSearchWordUserCreated').click();
                },
                //Default is 75px, set to 0 for demo so any distance triggers swipe
                threshold: 75
            });
        }

        function AddAllWords(el, e) {
            ClearSelectedSentence();
            $('.addORreplaceword').parent().parent().parent().css("border", "2px solid #2DE2E5");
            EndEdit(null);
            var sound = "";
            //m_shouldstoppropacation = false;
            $(el).parent().siblings("ul").find("li").each(function () {
                wordClick($(this).find('div')[0].id, true, false, e, false);
            });
            $(el).siblings("ul").find("img").each(function () {
                sound = $(this).attr("data-sound");
                $('#hdnSoundFile').val(sound);
            });
            //playsoundsend($('#hdnSoundFile').val());
            if ($('.chkSoundAndMail').prop("checked") == false) {
                Add();
            }
            else {
                //debugger;
                //if ($(el).parent().parent().find("span[data-swapped]").length > 0)
                PlaySequentialSounds(el, true);
                //else
                //    ClickSentenceSound(el);
            }
            //$('#btnPlaySound').click();
            //GetFinalMessage();
            $('html, body').animate({ scrollTop: '0px' }, 800);
            return false;
        }

        function ClearMessage() {
            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            $('#lblWordCount').text("0");
        }

        function RemoveSingleMessage(el) {
            var c = $(el).attr('class');

            var m1 = $('#divFinalLearningMessage').find('.' + c);
            var m2 = $('#divFinalNativeMessage').find('.' + c);
            if (m1)
                m1.parent().remove();
            if (m2)
                m2.parent().remove();

            UpdateSentenceCount(false);
        }


        function GetRandomOrderMessage(type) {
            var enWrongMessage = ['Incorrect button order.', 'Try again!', 'Are you sure?', 'Nearly there!'];
            var enWrongLineMessage = ['Incorrect line phrase.', 'Try again!', 'Are you sure?'];
            var jpWrongMessage = ['ボタンの順番はあってるかな？', 'もう一度！', '本当にこれであってるかな？', 'もう少し！'];
            var jpWrongLineMessage = ['その行だったかな？', 'もう一度！', '本当にこれであってるかな？'];
            var cnWrongMessage = ['再试一次', '再试一次', '再试一次', '再试一次'];
            var enLimit = 'Should be minimum of 3 sentences.';
            var jpLimit = '3文以上でなければならない';

            var language = $('#hdnNativeLanguageCode').val();

            var result = '';
            if (type == 'order' && language == 'en-US') {
                result = enWrongMessage.random(enWrongMessage.length);
            }
            else if (type == 'order' && language == 'ja-JP') {
                result = jpWrongMessage.random(jpWrongMessage.length);
            }
            if (type == 'line' && language == 'en-US') {
                result = enWrongLineMessage.random(enWrongLineMessage.length);
            }
            if ((type == 'line' || type == 'order') && language == 'zh-CN') {
                result = cnWrongMessage.random(cnWrongMessage.length);
            }
            else if (type == 'line' && language == 'ja-JP') {
                result = jpWrongLineMessage.random(jpWrongLineMessage.length);
            }
            else if (type == 'limit' && language == 'en-US') {
                result = enLimit;
            }
            else if (type == 'limit' && language == 'ja-JP') {
                result = jpLimit;
            }

            $("#spanMessage").text(result);

            var translations = {};
            translations["Return"] = $('#lblReturn').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Return"]] = function () {
                $(this).dialog("close");
            }
            $("#divModalMessage").dialog({
                modal: true,
                buttons: buttonsOpts
            });

        }

        function UpdateCategory() {
            var ddl = $('#ddlCategory');
            if ($('#txtSearchSentence').val().length > 0 && $(ddl).val() != "0") {
                //$('#hdnStopCategoryPostback').val("1");
                $(ddl).val("0");
            }
            else {
                $('#hdnStopCategoryPostback').val("");
            }

        }

        function playsoundnow(el, sounds) {
            var s;
            if (sounds.toLowerCase().indexOf("content/sound") == -1)
                s = new buzz.sound('../content/sound/' + sounds);
            else
                s = new buzz.sound(sounds);
            s.load();
            s.play();
        }

        function PlaySentenceOrIndividualSound(el, sounds) {
            //debugger;
            if ($(el).parent().find("span[data-swapped]").length > 0) {
                //var el2 = $(el).parent().find(".imgsequence").first();
                PlaySequentialSoundsOnly(el, false);
            }
            else
                playsoundnow(el, sounds)

        }

        function AttachPlaysound() {
            $(".paletteContainer").children("span, a").each(function () {

                //if (($(this).closest('.tblMessage_conversation') && ($(this).parent().parent().hasClass("newbubble1 newme") || $(this).parent().parent().hasClass("newbubble newyou"))))
                if (($(this).closest('.tblMessage_conversation') && $(this).parent().parent().hasClass("newbubble1"))) {
                    if ($(this).hasClass("hasSound")) {
                        $(this).parent().attr("data-hassound", "true");
                        if ($(this).attr("onclick"))
                            $(this).attr("onclick", $(this).attr("onclick") + "playsoundnow(this,\"" + $(this).attr("data-sound") + "\");");
                        else
                            $(this).attr("onclick", "playsoundnow(this,\"" + $(this).attr("data-sound") + "\");");
                    }
                }

                if (($(this).closest('.tblMessage_conversation') && $(this).parent().parent().hasClass("newbubble"))) {
                    if ($(this).hasClass("hasSound")) {
                        $(this).removeClass("hasSound");
                    }
                }


            });

            $(".paletteContainer").each(function () {
                if ($(this).attr("data-hassound") == "true") {
                    if ($(this).find(".speaker").length == 0) {
                        var sentencesound = $($(this).children("span, a")[0]).attr("data-sentencesound");
                        var soundimage = "";
                        if (sentencesound != undefined && sentencesound.length > 0)
                            soundimage = "<img class=\"speaker\" src=\"../Images/ICO_Speaker.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"playsoundnow(this,'" + sentencesound + "');\" />";

                        if ($(this).children("span[data-swapped]").length > 0 || $(this).children("a[data-swapped]").length > 0)
                            soundimage = "<img class=\"speaker\" src=\"../Images/ICO_Speaker.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"PlaySequentialSounds(this, false);\" />";



                        $(this).append(soundimage);
                    }
                }
            });


        }
        function UpdateTalkStatus(pstatus) {
            var status = false;
            CanTalkOrNot(pstatus);
            //if (pstatus == "")
            //    status = $("#lblCanTalkContainer").hasClass("lblCantTalk");
            //var json = { Type: 'updatetalkstatus', UserID: $("#hdnCurrentUserID").val(), Status: status };
            //$.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
            //    var obj = $.parseJSON(data);
            //    if (obj.Status == "True") {
                    
            //    }
            //    else
            //        alert('Error updating your talk subscription. Please check your network or internet.');
            //});

        }
        function changeStatusToConnected() {
            if ($("#lblCanTalkContainer").hasClass("lblCanTalk")){
                $("#imgTalkStatus").attr("src", "../Images/new/offline.png");
                $("#lblCanTalkContainer").removeClass("lblCanTalk").toggleClass("lblCantTalk");
                CanTalkOrNot("");
            }
        }
        function CanTalkOrNot(pstatus) {
            if ($("#lblCanTalkContainer").hasClass("lblCantTalk") && pstatus == "") {
                $("#imgTalkStatus").attr("src", "../Images/new/online.png");
                $("#imgTalkStatus").closest(".divUsers").attr("data-isonline", "true");
                //$(".cantalkStatus").show();
                $("#lblCanTalkContainer").removeClass("lblCantTalk").toggleClass("lblCanTalk");
                $("#lblCanTalk").html($("#hdnIcanTalkNow").val());
                if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                    $.connection.hub.start().done(function () {
                        chat.server.canTalk($('#hdnCurrentUserID').val(), $("#hdnGroupName").val(), true);
                    });
                } else {
                    chat.server.canTalk($('#hdnCurrentUserID').val(), $("#hdnGroupName").val(), true);
                }
                sessionStorage.setItem("onlineStatus", true);
                var el = $(".divUsers[data-userid='" + $('#hdnSelectedUserID').val() + "']");

                //SelectUserOnOnline($(el)[0]);

            }
            else {
                $("#imgTalkStatus").attr("src", "../Images/new/offline.png");
                $("#imgTalkStatus").closest(".divUsers").attr("data-isonline", "false");
                //$(".cantalkStatus").hide();
                $("#lblCanTalkContainer").removeClass("lblCanTalk").toggleClass("lblCantTalk");
                $("#lblCanTalk").html($("#hdnIcantTalkNow").val());
                if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                    $.connection.hub.start().done(function () {
                        chat.server.canTalk($('#hdnCurrentUserID').val(), $("#hdnGroupName").val(), false);
                    });
                } else {
                    chat.server.canTalk($('#hdnCurrentUserID').val(), $("#hdnGroupName").val(), false);
                }

                sessionStorage.setItem("onlineStatus", false);


            }
            
            callBroadCastHandler(-1);
        }

        function getReadyButtonState() {
            $.ajax({
                type: "POST",
                url: "/Student/Talk.aspx/GetReadyButtonState",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg)
                {
                    alert(msg);
                }
            });
        }

        function successButtonState(val) {
            alert('success ' + val);
        }

         function failedButtonState(val) {
            alert('failedButtonState ' + val.get_message());
        }
        function callBroadCastHandler(count) {
            var caller = arguments.callee;
            //Infinite
            if (count == -1) {
                window.setTimeout(function () {
                    broadcastMyStatus();
                    caller(count);
                }, 5000);
            }
            if (count > 0) {
                if (count == 0) return;
                broadcastMyStatus();
                window.setTimeout(function () {
                    caller(count - 1);
                }, 5000);
            }
            if (count == null) { broadcastMyStatus(); }
        };

        function broadcastMyStatus() {
            try {
                var onlineStatus = sessionStorage.getItem("onlineStatus");
                if (onlineStatus == undefined || onlineStatus == null)
                    onlineStatus = false;

                if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                    $.connection.hub.start().done(function () {
                        chat.server.canTalk($('#hdnCurrentUserID').val(), $("#hdnGroupName").val(), onlineStatus);
                    });
                } else {
                    chat.server.canTalk($('#hdnCurrentUserID').val(), $("#hdnGroupName").val(), onlineStatus);
                }
                console.log("broadcastMyStatus : " + onlineStatus);
                chat.server.createGroup($('#hdnCurrentUserID').val(), $('#hdnSelectedUserID').val());
            }
            catch (err) {
            }

        }

        async function createRoom(roomName, caller, callee) {
            var json = {
                "RoomName": roomName,
                "Caller": caller,
                "Callee": callee,
            };
            return await $.post("../api/Vidyo/CreateRoom", json, function (data) {
                if (data) {
                    return data;
                }
            }).promise();

        }
       
        function CreateAndJoinConference(e) {
            var username = $("#lblLastName").text();
            if (($("#btnCallIcon").hasClass("btnCallIconDisabled") && !_isDisconnected) || $("#btnCallIcon").hasClass("btnCallIconDisabled")) {
                //debugger;
                ArrangeUIFromDisconnection(username);
                
                return false;
            }
            if ($("#btnCallIcon").attr("data-isfromhangup") == "true") {
                $("#btnCallIcon").attr("src", "../Images/new/CallingStatic.png");
                $("#renderer0").hide();
                $("#renderer1").hide();
                $("#btnCallIcon").removeAttr("data-isfromhangup");
                return;
            }
            e.stopPropagation();
            e.preventDefault();

            //$(".divMessage").toggleClass("divMessageWithVideo");

            if ($("#btnCallIcon").attr("src").indexOf("Calling.gif") > -1) {
                //$("#btnCallIcon").attr("src", "../Images/CallingStatic.png");
                //$("#renderer0").hide();
                ////Leave();
                PlayRingBack(false);
                debugger;
                
                $("#btnCallIcon").attr("src", "../Images/new/CallingStatic.png");
                $("#renderer0").hide();
                $("#renderer1").hide();
                var currentuser = $("#hdnCurrentUserName").val();
                var room = currentuser.replace("@", "_") + username.replace("@", "_");
                _SomeoneIscalling = false;
                if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                    $.connection.hub.start().done(function () {
                        chat.server.hangup($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room);
                    });
                } else {
                    chat.server.hangup($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room);
                    //Leave();
                }
            }
            else if ($("#btnCallIcon").attr("src").indexOf("CallingStatic.png") > -1) {
                //GetVideoKey();

                

                var currentuser = $("#hdnCurrentUserName").val();
                var room = currentuser.replace("@", "_") + username.replace("@", "_");
                //$('#btnCallIcon').addClass("callStart");
                //loadVidyoClientLibrary(true, true, room, $("#hdnCurrentUserName").val(), true);
                _roomparameter = room;
                createRoom(room, currentuser, username).then((data) => {
                    if (data) {
                        if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                            $.connection.hub.start().done(function () {
                                chat.server.call(username, $('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room, data.RoomKey);
                            });
                        } else {
                            chat.server.call(username, $('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room, data.RoomKey);
                        }
                        _SomeoneIscalling = true;
                        PlayRingBack(true);
                        $("#btnCallIcon").attr("src", "../Images/new/Calling.gif")
                    }
                }).catch(() => {
                    alert("ERROR: Error in creating a room. Please contact your administrator");
                });;
                
                //$("#renderer0").show();
            }
            else if ($("#btnCallIcon").attr("src").indexOf("callEnd.png") > -1) {
                _isInCall = false;
                _SomeoneIscalling = false;
                //$("#btnCallIcon").attr("src", "../Images/CallingStatic.png");
                //$("#renderer0").hide();
                //$("#renderer1").hide();
                //var currentuser = $("#hdnCurrentUserName").val();
                //var room = currentuser.replace("@", "_") + username.replace("@", "_");
                ArrangeUIFromDisconnection(username);
                DeleteConferenceRoom(_roomparameter);
                //alert(_isDisconnected);
                //if (_isDisconnected) {
                    if ($.connection.hub.state === $.signalR.connectionState.disconnected) {
                        $.connection.hub.start().done(function () {
                            chat.server.ended($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room);
                        });
                    } else {
                        chat.server.ended($('#hdnCurrentUserName').val(), $("#hdnGroupName").val(), room);
                //        //Leave();
                    }
                //    _isDisconnected = false;
                //}
            }
        }
        function ArrangeUIFromDisconnection(username) {
            $("#btnCallIcon").attr("src", "../Images/new/CallingStatic.png");
            $("#renderer0").hide();
            $("#renderer1").hide();
            var currentuser = $("#hdnCurrentUserName").val();
            var room = currentuser.replace("@", "_") + username.replace("@", "_");
        }
        function InitializeDeviceList() {
            var translations = {};
            translations["Cancel"] = "Close";
            var buttonsOpts = {};
            buttonsOpts[translations["Cancel"]] = function () {
                $(this).dialog("close");
            }

            $("#divDeviceList").dialog({
                autoOpen: false,
                height: 300,
                width: 400,
                modal: true,
                buttons: buttonsOpts
            });

        }

        function OpenDeviceList() {
            InitializeDeviceList();
            $("#divDeviceList").dialog("open");
        }

        function disabledMenus() {
            var style = "style='color;gray;cursor;default;pointerEvents:none;'";
            //$(".link_writenew").css("color", "gray");
            //$(".cont_writenew").css("cursor", "default");
            //$(".cont_writenew").css("pointerEvents", "none");
            $(".cont_writenew").addClass("disableLink");
            $("#imgNewMessage").addClass("disableHeaderMenu");

            //$(".cont_home").css("color", "gray");
            //$(".cont_home").css("cursor", "default");
            //$(".cont_home").css("pointerEvents", "none");
            $(".cont_home").addClass("disableLink");
            $("#imgHome").addClass("disableHeaderMenu");

            //$(".cont_mail_outer").css("color", "gray");
            //$(".cont_mail_outer").css("cursor", "default");
            //$(".cont_mail_outer").css("pointerEvents", "none");
            $(".cont_mail_outer").addClass("disableLink");
            $("#imgMailbox").addClass("disableHeaderMenu");

            //$(".cont_talk").css("color", "gray");
            //$(".cont_talk").css("cursor", "default");
            //$(".cont_talk").css("pointerEvents", "none");
            $(".cont_talk").addClass("disableLink");
            $("#imgTalk").addClass("disableHeaderMenu");

            $('#linkInfo').removeAttr("href");
            $('#linkInfo').addClass("disableLinkOnMenu");

            

        }

        function enabledMenus() {

            $(".cont_writenew").removeClass("disableLink");
            $("#imgNewMessage").removeClass("disableHeaderMenu");

            $(".cont_home").removeClass("disableLink");
            $("#imgHome").removeClass("disableHeaderMenu");

            $(".cont_mail_outer").removeClass("disableLink");
            $("#imgMailbox").removeClass("disableHeaderMenu");

            $(".cont_talk").removeClass("disableLink");
            $("#imgTalk").removeClass("disableHeaderMenu");

            $('#linkInfo').attr("href", "javascript:Info();");
            $('#linkInfo').removeClass("disableLinkOnMenu");
        }

        function GetPartnerToDisplay() {
            
            $.getJSON("../api/MatchMaker/GetPartnerToDisplay/" + $('#hdnCurrentUserID').val(),
                function (data) {
                    if (data) {
                        $('#ulAvailableTimes').empty();

                        data.forEach(item => {
                            var dt = new Date(item.Schedule);
                            var template = '<li><a class="scheduleme" data-id="{0}" href="#" data-date="{1}">{2}</a></li>';
                            template = template.stringformat(item.ScheduleId, moment(item.Schedule).format("YYYY-MM-DD HH:mm:ss"), item.TimeSchedule.replace(/\//g, '<br/>'));
                            //template = template.stringformat(item.ScheduleId, (dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + dt.getDate() + " " + dt.getHours() + ":" + dt.getMinutes()), item.TimeSchedule.replace(/\//g, '<br/>'));
                            $('#ulAvailableTimes').append(template);
                        });
                    }

                });
        }

        function GetAvailableSchedule() {
            var date = moment().format("YYYY-MM-DD");
            $.getJSON("../api/MatchMaker/GetAllTimeScheduleForTalkDisplay",
                function (data) {
                    if (data) {
                        $('#ulAvailableSchedules').empty();

                        var distinctDate = [... new Set(data.map(x => x.CustomDate))];
                        var innerul = "<ul>{0}</ul>";
                        for (let i = 0; i < distinctDate.length; i++) {
                            var template = '<li><a class="scheduleme" data-id="{0}" href="#" data-date="{0}">{1}</a>{2}</li>';

                            var times = data.filter(x => x.CustomDate == distinctDate[i]);
                            let innerLi = "<li>{0}</li>";
                            let innerLiFinal = "";
                            for (let i = 0; i < times.length; i++) {
                                let item = times[i];
                                innerLiFinal += innerLi.stringformat(item.TimeSchedule);
                            }
                            innerul = innerul.stringformat(innerLiFinal);
                            template = template.stringformat(distinctDate[i], moment(new Date(distinctDate[i])).format("MMM DD YYYY (ddd)"), innerul);
                            $('#ulAvailableSchedules').append(template);
                            innerul = "<ul>{0}</ul>";
                        }
                    }

                });
        }

        function gotoScheduler() {
                OpentoNewWindow('<%=Page.ResolveUrl("~/Student/Scheduler")%>');
        }

        function endCameraTesting() {
            $("#imgTestCamera").removeClass("callStart");
            $('#btnTestCamera').hide();
            $('#divCall').show();
            $('#divCall_01').show();
            testCameraAndMic();
            $("#imgTestCamera").removeClass("disableHeaderMenu");
            _SomeoneIscalling = false;

        }
        function TestCamera() {
            _SomeoneIscalling = true;
            //if (!detectWebcam()) {
            //    return false;
            //}
            //$('#imgTestCamera').addClass("callStart");
            //GetVideoKey();
            var currentuser = $("#hdnCurrentUserName").val();
            createRoom("", currentuser, "").then((data) => {
                if (data) {
                    //$("#hdnToken").val(obj.key);
                    //$("#btnCallIcon").addClass("callStart");
                    //loadVidyoClientLibrary(true, true, "testingonlyroom", $("#hdnCurrentUserName").val(), true);
                    //attachedVidyo();
                    $("#imgTestCamera").addClass("callStart");
                    BlockElement();
                    $("#imgTestCamera").addClass("disableHeaderMenu");
                    $('#divCall').hide();
                    $('#divCall_01').hide();
                    testCameraAndMic(data.RoomKey, currentuser);
                }
            });

                //var json = { Type: 'getvideokey' };
                //$.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                //    var obj = $.parseJSON(data);

                //    if (obj.Status == "True") {
                //        $("#hdnToken").val(obj.key);
                //        //$("#btnCallIcon").addClass("callStart");
                //        //loadVidyoClientLibrary(true, true, "testingonlyroom", $("#hdnCurrentUserName").val(), true);
                //        //attachedVidyo();
                //        $("#imgTestCamera").addClass("callStart");
                //        BlockElement();
                //        $("#imgTestCamera").addClass("disableHeaderMenu");
                //        $('#divCall').hide();
                //        testCameraAndMic();
                //    }
                //    else
                //        alert('Cannot generate video token.');
                //});


            
        }
        function TestSound() {
            playsound('System/' + $('#hdnSoundCheckFile').val());
        }

        function BlockElement() {
            $('#top_container').block({
                message: 'Loading video and microphone...',
                css: { border: 'none' }
            });
        }

        function UnBlockElement() {
            $('#top_container').unblock();;
        }
        function SelectSupport(type) {
            $("#hdnSupportId").val('');
            var el = $(".divUsers[data-issupport='True'][data-isonline='true']");
            if (el.length > 0) {
                if ($($(el)[0]).attr("data-userid") != $('#hdnSelectedUserID').val()) {
                    $("#hdnSupportId").val($($(el)[0]).attr("data-userid"));
                    SelectSupportOrPartner(false);
                    SelectUser($(el)[0]);
                }
                else {
                    if (type == "Issues") {
                        Issues();
                        SelectSupportOrPartner(false);
                    }
                    else
                        ImReady();
                }
            } else {
                el = $(".divUsers[data-issupport='True']");
                if (el.length > 0) {
                    var user = el.closest(".selected");
                    if (user.length > 0) {
                        if (type == "Issues") {
                            Issues();
                            SelectSupportOrPartner(false);
                        }
                        else
                            ImReady();
                        return;
                    }
                    
                    $("#hdnSupportId").val($($(el)[0]).attr("data-userid"));
                    //SelectUser($(el)[0]);
                    //initializeSupportFriendButton();
                    SelectSupportOrPartner(true);
                    
                    //$(el).each(function() {
                    //    if ($(this).hasClass("selected")) {
                    //        ImReady();
                    //        return false;
                    //    }
                    //});
                    //if ($($(el)[0]).attr("data-userid") != $('#hdnSelectedUserID').val()) {
                    //    $("#hdnSupportId").val($($(el)[0]).attr("data-userid"));
                    //    SelectUser($(el)[0]);
                    //}
                    //else {
                    //    ImReady();
                    //}
                }
            }

        }

        function SelectSupportOrPartner(autoselect) {
            toastr.clear();
            if ($('#hdnCurrentVideoPartnerId').val() == "") {
                $('#hdnCurrentVideoPartnerId').val($('#hdnSelectedUserID').val());
                var el;// = $(".divUsers[data-issupport='True'][data-isonline='true']");
                if ($("#hdnSupportId").val() == "") {
                    el = $(".divUsers[data-issupport='True'][data-isonline='true']");
                }
                else {
                    el = $(".divUsers[data-issupport='True'][data-userid='" + $("#hdnSupportId").val()  +  "']");
                }
                
                if (el.length > 0 && autoselect)
                    SelectUser($(el)[0]);
                else if (el.length == 0 && autoselect) {
                    el = $(".divUsers[data-issupport='True']");
                    if (el.length > 0) {
                        SelectUser($(el)[0]);
                    }
                }
                $('#btnChatSupport').val($('#hdnGoBackToPartner').val());
                if (!$('#btnChatSupport').hasClass("blink")) {
                    $('#btnChatSupport').addClass("blink");
                }
                if (_isInCall) {
                    $('#divMessageContainer').addClass("supportChart");
                }
                $('#btnChatSupport').removeClass("supportHasMessage");
            }
            else {
                var el = $(".divUsers[data-userid='" + $('#hdnCurrentVideoPartnerId').val() + "']");
                if (el.length > 0 && autoselect)
                    SelectUser($(el));

                $('#hdnCurrentVideoPartnerId').val('');
                $('#btnChatSupport').val($('#hdnChatSupport').val());
                $('#btnChatSupport').removeClass("blink");
                $('#hdnSupportId').val('');
                $('#btnChatSupport').addClass("supportHasMessage");
                $('#divMessageContainer').removeClass("supportChart");
            }


            return false;
        }

        function initializeSupportFriendButton() {
            if ($('#hdnCurrentVideoPartnerId').val() == "") {
                $('#hdnCurrentVideoPartnerId').val($('#hdnSelectedUserID').val());

                $('#btnChatSupport').val($('#hdnGoBackToPartner').val());
                if (!$('#btnChatSupport').hasClass("blink")) {
                    $('#btnChatSupport').addClass("blink");
                }
                if (_isInCall) {
                    $('#divMessageContainer').addClass("supportChart");
                }
                $('#btnChatSupport').removeClass("supportHasMessage");
            }
            else {
                $('#hdnCurrentVideoPartnerId').val('');
                $('#btnChatSupport').val($('#hdnChatSupport').val());
                $('#btnChatSupport').removeClass("blink");
                $('#hdnSupportId').val('');
                $('#btnChatSupport').addClass("supportHasMessage");
                $('#divMessageContainer').removeClass("supportChart");
            }


            return false;
        }

        function showHideChatSupportButton() {
            toastr.clear();
            $('#btnChatSupport').val($('#hdnChatSupport').val());
            $('#btnChatSupport').removeClass("blink");
            $('#btnChatSupport').toggle();
            $('#divMessageContainer').removeClass("supportChart");
            $('#btnChatSupport').removeClass("supportHasMessage").addClass("supportHasMessage");
        }

        function showFeedback() {
            if ($("#hdnNativeLanguageCode").val() == "en-US") {
                var message = $('#hdnFeedback').val();
                $("<div>" + message + "</div>").dialog({
                    modal: true,
                    buttons: {
                        Close: function () {
                            $(this).dialog("close");
                        }
                    }
                });
            }
        }

        function ShowReminderInstruction() {
            
                $("#divReminder").dialog({
                    height: 250,
                    width: 550,
                    modal: true,
                    closeOnEscape: true,
                    buttons: {
                        Close: function () {
                            $(this).dialog("close");
                        }
                    }
                });

             $("#divReminder").dialog("open");
                $('.ui-dialog-titlebar').css('display', "none");
            
            
        }

        function isWithinThreshold() {
            $.getJSON("../api/MatchMaker/IsWithinThreshold/",
                function (data) {
                    if (data) {
                        clearAnimation();
                        if ($("#hdnNativeLanguageCode").val() == "en-US") {
                            $("#divImReady").addClass("divImReadyAnimate_en");
                        }
                        else {
                            $("#divImReady").addClass("divImReadyAnimate_jp");
                        }
                    }
                    else {
                        clearAnimation();
                    }
                }
            );
        }

        function clearAnimation() {
            $("#divImReady").removeClass("divImReadyAnimate_en").removeClass("divImReadyAnimate_jp");
        }

        var _imReadyTimer;
        function callImReadyHandler(count) {
            //var caller = arguments.callee;
            //Infinite
            //if (count == -1) {
                _imReadyTimer = window.setTimeout(function ()
                {
                    isWithinThreshold();
                    //caller(count);
                }, 60000);
            //}
        }
         function clearImReadyTimer() {
             clearTimeout(_imReadyTimer);
             clearAnimation();
        }

        var _messageIndex = -1;
        var _reminder;
        var _timerIndex = -1;
        //var _timer = [3,1,3,3,5,3,1,3,3,0]
        var _timer = [180,60,180,180,300,180,60,180,180,0]
        //var _timer = [40,30,25,2,10,5,20,15,10,0]

        function terminateReminder() {
            toastr.clear();
            _messageIndex = -1;
            _timerIndex = -1;
            clearTimeout(_reminder);
        }
        // function callBroadCastHandler(count) {
        //    var caller = arguments.callee;
        //    //Infinite
        //    if (count == -1) {
        //        window.setTimeout(function () {
        //            broadcastMyStatus();
        //            caller(count);
        //        }, 3000);
        //    }
        //    if (count > 0) {
        //        if (count == 0) return;
        //        broadcastMyStatus();
        //        window.setTimeout(function () {
        //            caller(count - 1);
        //        }, 2000);
        //    }
        //    if (count == null) { broadcastMyStatus(); }
        //};
        function callReminder(count) {
            if (count == 0) return;
            var caller = arguments.callee;
            //Infinite
            if (count > 0) {
                _reminder = window.setTimeout(function ()
                {
                    
                    showReminder();
                    caller(count-1);
                }, _timer[count-1] * 1000);
            }
        }
        
        function showReminder() {
            toastr.clear();
             toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": true,
                "progressBar": false,
                "positionClass": "toast-center-middle",
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
                "onCloseClick": null
            }

            let message = $('#hdnReminderMessage').val().split('|');
            _messageIndex++;
            if (_messageIndex > message.length - 1)
                _messageIndex = 0;

            toastr.warning(message[_messageIndex], "REMINDER!");
        }


        function updateAttendance() {
            $.getJSON("../api/MatchMaker/UpdateAttendance",
                function (data) {
                    if (data) {
                        clearAnimation();
                    }
                }
            );
        }

        function addUserPoints(type, userid) {

            var json = {
                Type: type,
                UserID: userid
            };
            $.post("../api/MatchMaker/AddUserPoints", json, function (data) {
                if (data) {
                    console.log(data);
                }
                
            });

        }

        //function ShowParentsInfo() {
        //    if ($('#hdnParentsInfoFlag').val() == "False") {
        //        $("#txtParentsName").val("");
        //        $("#txtPhoneNumber").val("");
        //        $("#hdnParentsName").val("");
        //        $("#hdnPhoneNumber").val("");

        //        $("#divParentsInfo").dialog({
        //            height: 400,
        //            width: 650,
        //            modal: true,
        //            closeOnEscape: false,
        //            buttons: {
        //                Ok: function () {
        //                    if (validateParentsInfo()) {
        //                        $("#hdnParentsName").val($("#txtParentsName").val());
        //                        $("#hdnPhoneNumber").val($("#txtPhoneNumber").val());
        //                        //$('#btnSaveParentsInfo').click();
        //                        saveContact().then(() => {
        //                            $("#hdnParentsInfoFlag").val('True');
        //                            $(this).dialog("close");
        //                        }).catch(() => {
        //                            $("#hdnParentsInfoFlag").val('False');
        //                            $("#lblErrorSaving").show();
        //                        });
        //                    }
        //                }
        //            }
        //        });

        //        $("#divParentsInfo").keyup(function (event) {
        //            var key = event.keyCode || event.which;
        //            if (key == 13) {
        //                $("#btnRegister").attr("disabled", 'disabled');
        //                $(this).parent().find("button:eq(1)").click();
        //            }
        //        });
        //        $("#divParentsInfo").dialog("open");
        //        $('.ui-dialog-titlebar').css('display', "none");
        //        //$('.ui-dialog').css('z-index', 103);
        //        //$('.ui-widget-overlay').css('z-index', 102);
        //        //$('#divParentsInfo').parent().appendTo($("form:first"));
        //    }
        //}

        //async function saveContact() {
        //    return await $.post("../api/MatchMaker/SaveContact/" + $('#txtParentsName').val() + "/" + $('#txtPhoneNumber').val(),
        //        function (data) {
        //            if (data) {
        //                return data;
        //            }
        //        }).promise();

        //}

        //function validateParentsInfo() {
        //    var hasError = 0;
        //    var regex = /^\+?[0-9]{10,20}$/;
        //    if ($('#txtPhoneNumber').val() == "" || !regex.test($('#txtPhoneNumber').val())) {
        //        $("#lblPhoneNumberError").show()
        //        hasError++;
        //    }
        //    else {
        //        $("#lblPhoneNumberError").hide()
        //    }
        //    if ($('#txtParentsName').val() == "") {
        //        $("#lblParentsNameError").show()
        //        hasError++;
        //    }
        //    else {
        //        $("#lblParentsNameError").hide()
        //    }

        //    return hasError == 0;
        //}

    </script>
    
    <div id="divDeviceList" style="display:none;z-index:1000000000;">
        <ul style="list-style:none;">
            <li><asp:Label ID="lblCamera" runat="server" style="font-weight:bold;" Text="Select Camera" ClientIDMode="Static" meta:resourcekey="lblCameraResource1"></asp:Label></li>
            <li>
                <select id="cameras" class="device">
                    <option value="0" >Select Camera</option>
                </select>
            </li>
            <li><asp:Label ID="lblMicrophone" runat="server" style="margin-top:10px;display:inline-block;font-weight:bold;" Text="Select Microphone" ClientIDMode="Static" meta:resourcekey="lblMicrophoneResource1"></asp:Label></li>
            <li>
                <select id="microphones" class="device">
                    <option value="0" >Select Microphone</option>
                </select>
            </li>
            <li><asp:Label ID="lblSpeakers" runat="server" style="margin-top:10px;display:inline-block;font-weight:bold;" Text="Select Speaker" ClientIDMode="Static" meta:resourcekey="lblSpeakersResource1"></asp:Label></li>
             <li>
                <select id="speakers" class="device">
                    <option value="0" >Select Speaker</option>
                </select>
            </li>
        </ul>
    </div>
    <div id="divCallAlert" style="display:none;" >
        <asp:Label ID="lblCallAlertMessage" runat="server" Text="" ClientIDMode="Static" meta:resourcekey="lblCallAlertMessageResource1"></asp:Label><br />
        <br />
        <img src="../Images/new/Calling.gif" id="calling" style="display:block;margin:auto;width: 54px;"/>
    </div>
    <div id="divModalMessage" style="display:none;" >
        <span id="spanMessage"></span>
    </div>
    <div id="confirmDialog" title="&nbsp;" style="display:none;">
        <asp:Label ID="lblDialogMessage" runat="server" Text=""  meta:resourcekey="lblDialogMessageResource1"></asp:Label><br />
    </div>
    <div id="divReminder" style="display:none;">
        <ul id="ulInstruction">
                <li>
                    <asp:Label ID="lblReminderLine1" runat="server" Text="" Font-Size="Smaller" meta:resourcekey="lblReminderLine1Resource1"></asp:Label>
                    <%--<br />
                    <br />
                    <ul id="ulSubInstruction">
                        <li><asp:Label ID="lblReminderLine1_SubLine1" runat="server" Text="" Font-Size="Smaller" meta:resourcekey="lblReminderLine1_SubLine1Resource1"></asp:Label></li>
                        <li><asp:Label ID="lblReminderLine1_SubLine2" runat="server" Text="" Font-Size="Smaller" meta:resourcekey="lblReminderLine1_SubLine2Resource1"></asp:Label></li>
                    </ul>
                    <br />--%>
                </li>

                <li>
                    <asp:Label ID="lblReminderLine2" runat="server" Text="" Font-Size="Smaller" meta:resourcekey="lblReminderLine2Resource1"></asp:Label>
                </li>
            </ul>
    </div>
 
    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            
        </ContentTemplate>
        <Triggers>
            
        </Triggers>
    </asp:UpdatePanel>
                
    <div style="width:100%;">
        <asp:HiddenField ID="hdnReminderMessage" runat="server" ClientIDMode="Static"  meta:resourcekey="hdnReminderMessageResource1"/>
        <asp:HiddenField ID="hdnTalkCategory" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnButtonType" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnNewMessageTitle" runat="server" ClientIDMode="Static" meta:resourcekey="hdnNewMessageTitleResource1"/>
        <asp:HiddenField ID="hdnReplyButton" runat="server" ClientIDMode="Static" meta:resourcekey="hdnReplyButtonResource1"/>
        <asp:HiddenField ID="hdnSupportId" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnCurrentVideoPartnerId" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnSoundFile" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnPunctuation" runat="server" ClientIDMode="Static" meta:resourcekey="hdnPunctuationResource1"/>
        <asp:HiddenField ID="hdnSelectFromPalete" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSelectFromPaleteResource1" />
        <asp:HiddenField ID="hdnReplaceWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnReplaceWordResource1"/>
        <asp:HiddenField ID="hdnCreateNewWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCreateNewWordResource1"/>
        <asp:HiddenField ID="hdnCategory" runat="server" ClientIDMode="Static" value="0"/>
        <asp:HiddenField ID="hdnCallBusyMessage" runat="server" ClientIDMode="Static" value="" meta:resourcekey="hdnCallBusyMessageResource1"/>

        <asp:HiddenField ID="hdnWordType" runat="server" Value="" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnwordpage" runat="server" Value="1" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnwordpageusercreated" runat="server" Value="1" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnsentencepage" runat="server" Value="1" ClientIDMode="Static"  />
        <asp:HiddenField ID="hdnsentencepageUserPalette" runat="server" Value="1" ClientIDMode="Static"  />
        <asp:HiddenField ID="hdnOtherLanguages" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnLearning" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnNative" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnKeywords" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnGroupName" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnNativeLanguageCode" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnOtherLanguageCode" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnLearningLanguageCode" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnFreeTextMessage1PlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeTextMessage1PlaceHolderResource1"/>
        <asp:HiddenField ID="hdnFreeTextMessage2PlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeTextMessage2PlaceHolderResource1"/>
        <asp:HiddenField ID="hdnStopCategoryPostback" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnAutoSearch" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnAddWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnAddWordResource1"/>
        <asp:HiddenField ID="hdnFreeformWordTitle" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeformWordTitleResource1"/>
        <asp:HiddenField ID="hdnNoSentenceToAdd" runat="server" ClientIDMode="Static" meta:resourcekey="hdnNoSentenceToAddResource1"/>
        <asp:HiddenField ID="hdnWordKeyword" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnPrepareWordReplaceElementID" runat="server" ClientIDMode="Static"/>
    	<asp:HiddenField ID="hdnStep1" runat="server" Value="Let’s choose a Category!" ClientIDMode="Static" meta:resourcekey="hdnStep1Resource1"/>
		<asp:HiddenField ID="hdnStep2" runat="server" Value="Click ↑ or &quot;Words in Order&quot;!" ClientIDMode="Static" meta:resourcekey="hdnStep2Resource1" />
		<asp:HiddenField ID="hdnStep3" runat="server"  Value="Put in Correct Order/Click the Cog and replace Words!" ClientIDMode="Static" meta:resourcekey="hdnStep3Resource1"/>
        <asp:HiddenField ID="hdnStep4" runat="server"  Value="Put in Correct Order/Click the Cog and replace Words!" ClientIDMode="Static" meta:resourcekey="hdnStep4Resource1"/>
        <asp:HiddenField ID="hdnStep4b" runat="server"  Value="Put in Correct Order/Click the Cog and replace Words!" ClientIDMode="Static" meta:resourcekey="hdnStep4bResource1"/>
        <asp:HiddenField ID="hdnStep5" runat="server"  Value="Put in Correct Order/Click the Cog and replace Words!" ClientIDMode="Static" meta:resourcekey="hdnStep5Resource1"/>
        <asp:Label ID="lblReturn" runat="server" meta:resourcekey="hdnReturnResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:Label ID="lblOk" runat="server" meta:resourcekey="hdnlblOkResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:Label ID="lblCancel" runat="server" meta:resourcekey="hdnlblCancelResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:HiddenField ID="hdnToken" ClientIDMode="Static" runat="server"  Value=""/>
        <asp:HiddenField ID="hdnRoom" ClientIDMode="Static" runat="server"  Value=""/>
        <asp:HiddenField ID="hdnAnswer" runat="server" ClientIDMode="Static" meta:resourcekey="hdnAnswerResource1"/>
        <asp:HiddenField ID="hdnReject" runat="server" ClientIDMode="Static" meta:resourcekey="hdnRejectResource1"/>
        <asp:HiddenField ID="hdn2ndLanguageLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdn2ndLanguageLabelResource1"/>
        <asp:HiddenField ID="hdnSessionTalkTimer" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSessionTalkTimerResource1"/>
        <asp:HiddenField ID="hdnSessionTime" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSessionTimeResource1"/>
        <asp:HiddenField ID="hdnTotalTime" runat="server" ClientIDMode="Static" meta:resourcekey="hdnTotalTimeResource1"/>
        <asp:HiddenField ID="hdnTalkButtonTriggeredFromCodeBehind" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnCurrentTab" runat="server" ClientIDMode="Static" Value="0"/>
        <asp:HiddenField ID="hdnRemainingTime" runat="server" ClientIDMode="Static" meta:resourcekey="hdnRemainingTimeResource1"/>
        <asp:HiddenField ID="hdnTimeElapsed" runat="server" ClientIDMode="Static" meta:resourcekey="hdnTimeElapsedResource1"/>
        <asp:HiddenField ID="hdnSoundCheckFile" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSoundCheckFileResource1"/>
        <asp:HiddenField ID="hdnPhraseSearch" runat="server" ClientIDMode="Static" meta:resourcekey="hdnPhraseSearchResource1"/>
        <asp:HiddenField ID="hdnWordSearch" runat="server" ClientIDMode="Static" meta:resourcekey="hdnWordSearchResource1"/>
        <asp:HiddenField ID="hdnErrorHeader" runat="server" ClientIDMode="Static" meta:resourcekey="hdnErrorHeaderResource1"/>
        <asp:HiddenField ID="hdnBadErrorMessage" runat="server" ClientIDMode="Static" meta:resourcekey="hdnBadErrorMessageResource1"/>
        <asp:HiddenField ID="hdnDeleteWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnDeleteWordResource1"/>
        <asp:HiddenField ID="hdnSaveWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSaveWordResource1"/>
        <asp:HiddenField ID="hdnAuthentication" runat="server" Value="" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnFeedback" runat="server" Value="" ClientIDMode="Static"  meta:resourcekey="hdnFeedbackResource1"/>
<%--        <asp:HiddenField ID="hdnParentsInfoFlag" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnPhoneNumber" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnParentsName" runat="server" ClientIDMode="Static" />--%>
        <asp:HiddenField ID="hdnNoWebCam" runat="server" ClientIDMode="Static" meta:resourcekey="hdnNoWebCamResource1"/>
        <asp:HiddenField ID="hdnNoMicrophone" runat="server" ClientIDMode="Static" meta:resourcekey="hdnNoMicrophoneResource1"/>
        <asp:HiddenField ID="hdnTimeIsUp" runat="server" ClientIDMode="Static" meta:resourcekey="hdnTimeIsUpResource1"/>

      <%-- <div id="divParentsInfo" style="display:none;">
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
            <td><asp:Label ID="lblPhoneNumber" runat="server" Text="Contactable Phone Number:" meta:resourcekey="lblPhoneNumberResource1"></asp:Label></td>
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
    </div>--%>

        <div id="destinationDiv" style="background: silver;width:500px; height:100px;"></div>
        <div id="divSaveWordDialog" title="&nbsp;" style="display:none;">
			<asp:Label ID="lblSaveWordQuestion" runat="server" Text="Do you want to save your word?" ClientIDMode="Static"></asp:Label><br />
		</div>
        <div id="dialog-form" title="&nbsp;" style="display:none;">
            <asp:Label ID="lblDialogNativeLanguage" runat="server" Text="Native Language"  meta:resourcekey="lblDialogNativeLanguageResource1"></asp:Label><br />
            <input type="text" name="native" id="native" class="text ui-widget-content ui-corner-all" spellcheck="true" /><br />
            <asp:Label ID="lblDialogLearningLanguage" runat="server" Text="Learning Language"  meta:resourcekey="lblDialogLearningLanguageResource1"></asp:Label>&nbsp;&nbsp;<img id="imgTranslating" src="../Images/translating.gif" style="display:none;float:none !important;" /><br />
            <input type="text" name="learning" id="learning" value="" class="text ui-widget-content ui-corner-all" spellcheck="true"/><br />
            <asp:Label ID="lblDialogSubLanguage" runat="server" style="display:none;" Text="Sub Language"  meta:resourcekey="lblDialogSubLanguageResource1"></asp:Label><br />
            <input type="text" name="sub" id="sub" value="" style="display:none;" class="text ui-widget-content ui-corner-all" /><br />
            <asp:Label ID="lblTranslating" runat="server" style="display:none;" Text="Translating..., Please wait." ClientIDMode="Static"  meta:resourcekey="lblTranslatingResource1"></asp:Label><br />
        </div>
        <div id="emojigallery" style="width:800px;display:none;">
           <div id="tabs" style="height:90%;">
                <ul style="display:none;">
                <li><asp:HyperLink ID="HyperLink1" href="#emoji" runat="server" Text="Emoji" meta:resourcekey="HyperLink1Resource1"  style="display:none;"/></li>
                <li><asp:HyperLink ID="HyperLink2" href="#sticker" runat="server" Text="Sticker" style="display:none;" meta:resourcekey="HyperLink2Resource1" /></li>
                <li><asp:HyperLink ID="HyperLink3" href="#punctuation" runat="server" Text="Punctuation" meta:resourcekey="HyperLink3Resource1"  style="display:none;" /></li>
                </ul>
               <div id="emoji" style="overflow-y:scroll;height:400px;" >

               </div>
               <div id="sticker" style="display:none;">

               </div>
               <div id="punctuation1" style="display:none;">
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>.</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>?</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>:</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>;</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>!</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>#</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>&</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>*</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>$</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>@</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>/</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>\</span></div>
               </div>
            </div>   
            <asp:Button ID="btnCloseEmoji" runat="server" Text="Close" ClientIDMode="Static" meta:resourcekey="btnCloseEmojiResource1"/>
        </div>
        <div id="punctuationGallery" style="width:400px;display:none;" class="popper-content hide">
               <div id="punctuationContainer" >
                   <div id="pdot" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>.</span></div>
                   <div id="pquestionmar" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>?</span></div>
                   <div id="pcolon" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>:</span></div>
                   <div id="psemicolon" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>;</span></div>
                   <div id="pexclamation" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>!</span></div>
                   <div id="psharp" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>#</span></div>
                   <div id="pampersand" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>&</span></div>
                   <div id="pasterisk" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>*</span></div>
                   <div id="pdollar" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>$</span></div>
                   <div id="pat" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>@</span></div>
                   <div id="pslash" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>/</span></div>
                   <div id="pbackslash" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>\</span></div>
               </div>
            
        </div>
        <div id="divFreeMessage" style="display:none;position: relative;">
          <fieldset>
            <legend>
                <asp:Label ID="lblFreeMessage" runat="server" Text="Free Message" meta:resourcekey="lblFreeMessageResource1"></asp:Label></legend><br />
                <asp:HyperLink ID="lnkTranslate" runat="server" CssClass="btn" Text="Translate" ClientIDMode="Static" meta:resourcekey="btnTranslateResource1" style="position: absolute;margin: 0% 43%;top: 25px;"></asp:HyperLink>
              <table style="width:100%;">
                  <tr>
                      <td>
                          <textarea id="txtFreeMessage1" class="text ui-widget-content ui-corner-all" style="width:98%;height:100%;" cols="1" rows="5" maxlength="100" spellcheck="true" ></textarea>
                          <span id="lblcharleft1" style="display:none;">100</span>&nbsp;<asp:Label ID="lblcharleftLabel1" runat="server" ClientIDMode="Static" meta:resourcekey="lblcharleftLabel1Resource1">Characters remaining</asp:Label>
                      </td>
                      <td>
                          <textarea id="txtFreeMessage2" class="text ui-widget-content ui-corner-all" style="width:98%;height:100%" cols="1" rows="5" maxlength="100" spellcheck="true" ></textarea>
                          <span id="lblcharleft2"  style="display:none;">100</span>&nbsp;<asp:Label ID="lblcharleftLabel2" runat="server" ClientIDMode="Static" meta:resourcekey="lblcharleftLabel1Resource1">Characters remaining</asp:Label>
                      </td>
                  </tr>
                  <tr>
                      <td colspan="2" style="text-align:center;">
                          <img id="imgTranslating2" src="../Images/translating.gif" style="display:none;float:none !important;" />
                      </td>
                  </tr>
              </table>
          </fieldset>
        </div>   
                <asp:HiddenField ID="hdnSelectedUserID" runat="server" ClientIDMode="Static" Value="0" />
                <asp:HiddenField ID="hdnCurrentUserID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnCurrentFirstName" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnCurrentUserName" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnSelectedFirstName" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnSelectedUserName" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnCurrentAvatar" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnSelectedAvatar" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnName" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnSubscriptionID" runat="server" ClientIDMode="Static" Value="0" />
                <asp:HiddenField ID="hdnSearchFriendsPlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSearchFriendsPlaceHolderResource1"/>
                <asp:HiddenField ID="hdnFrom" runat="server" ClientIDMode="Static" />
               
            <div class="smc_top_container" id="smc_top_container" style="display: none;">
                <div class="smctc_msgbox" id="smctc_msgbox">
                    <asp:Label ID="lblSentence" CssClass="smctc_lbl" runat="server" Text="Create Sentence to Add" AssociatedControlID="divSentence" meta:resourcekey="lblSentenceResource1" ></asp:Label>
                    <div id="divSentence" class="sortable" runat="server" tabindex="0">
                        <div></div>
                    </div>
                    <asp:Label ID="lblInstruction" Visible="false" CssClass="smctc-instructions" runat="server" Text=""  meta:resourcekey="lblInstructionResource1" ></asp:Label>
                </div>
                <div class="smctc_msgbox_btn" id="smctc_msgbox_btn">
                    <div class="playsound_container" style="float: left !important;">
                        <div>
                            <asp:Button CssClass="smctc_msgbox_btnaddclear_container_lbl" ID="btnPlaySound" style="background-image:url('../Images/playsounds.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left;" Height="48px" BorderStyle="None" Width="48px" Text="" runat="server" ClientIDMode="Static" OnClientClick="PlaySequentialSounds(); return false;"  />
                        </div>
                    </div>
                    <div class="addclear_container">
                        <div class="smctc_msgbox_btnaddclear_container">
                            <asp:Button CssClass="smctc_msgbox_btnaddclear_container_lbl" ID="btnAdd" style="background-image:url('../Images/sendchat.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left;" Height="48px" BorderStyle="None" Width="58px" Text="" runat="server" ClientIDMode="Static" OnClientClick="Add(); return false;" UseSubmitBehavior="false" />
                        </div>
                        <div class="smctc_msgbox_btnaddclear_container" style="margin-top:-20px;">
                            <asp:Button CssClass="smctc_msgbox_btnaddclear_container_lbl" ID="btnClear" style="background-image:url('../Images/deletechat.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left;" Height="48px" BorderStyle="None" Width="58px" Text="" runat="server" OnClientClick="return ClearSelectedSentence();"/>
                        </div>
                    </div>
                </div>
            </div>
     
        <div id="top_container">
                <div id="divTalkScheduleContainer" style="display:flex; gap: 20px;">

                    <%--button section--%>

                    <div id="divActionContainer" >
                        <div id="divActionInnerContainer">
                            <img class="actionButton" id="imgTalkChecklist" src="../Images/new/Group_10_new" onclick="talkChecklist();" />
                            <img class="actionButton disableHeaderMenu" id="imgTestCamera" src="../Images/new/Group_11" onclick="TestCamera();" />
                            <img class="actionButton" id="imgTestSound" src="../Images/new/Group_12" onclick="TestSound();" />
                            <img class="actionButton" id="imgGoToScheduler" src="../Images/new/Group_13" onclick="gotoScheduler();" />
                            <img class="actionButton" id="imgInstructionVideo" src="../Images/new/Group_14" onclick="OpenYouTube('hdnTalkTutorial');" />
                            <asp:HiddenField id="hdnTalkChecklist" runat="server" ClientIDMode="Static"  meta:resourcekey="hdnTalkChecklistResource1"/>
                            <asp:HiddenField id="hdnGoToScheduler" runat="server" ClientIDMode="Static"  meta:resourcekey="hdnGoToSchedulerResource1"/>
                            <asp:HiddenField id="hdnInstructionVideo" runat="server" ClientIDMode="Static"  meta:resourcekey="hdnInstructionVideoResource1"/>
                            <asp:HiddenField id="hdnTestCamera" runat="server" ClientIDMode="Static"  meta:resourcekey="hdnTestCameraResource1"/>
                            <asp:HiddenField id="hdnTestSound" runat="server" ClientIDMode="Static"  meta:resourcekey="hdnTestSoundResource1"/>
                        </div>
                    </div>

                       <%--button section end--%>

                      <%--Recruiting time section--%>
                    
                    <div id="divAvailableTimesContainer" style="border-radius: 8px; width: 52%">
                        <asp:Label ID="lblAvailableTime" runat="server" ClientIDMode="Static" Text="Available Time" meta:resourcekey="lblAvailableTimeResource1" ></asp:Label>
                        <hr style="border-bottom: 1px solid #D9EEFC;"/>
                        <div id="divAvailableTimesInnerContainer">
                            <ul id="ulAvailableTimes">
                            </ul>
                        </div>
                    </div>

                      <%--Recruiting time section end--%>

                   <%-- <div id="divAvailableScheduleContainer" style="display:none; border: 5px solid green">
                        <asp:Label ID="lblAvailableSchedule" runat="server" ClientIDMode="Static" Text="Available Schedule" meta:resourcekey="lblAvailableScheduleResource1" ></asp:Label>
                        <div id="divAvailableScheduleInnerContainer">
                            <ul id="ulAvailableSchedules">
                            </ul>
                        </div>
                    </div>--%>
                    <div class="take_recruit_support_container" style ="display:flex; flex-direction: column ; width: 38%; background-color: white">
                     <div class="mailbox_frnd_container" id="allfriends">
                                    <asp:Repeater ID="rptFriends" runat="server">
                                        <HeaderTemplate>
                                        </HeaderTemplate>
                                       <ItemTemplate>
                                            <div id="divUsers" class="divUsers" role="button" onclick="SelectUser(this);"  data-isonline='<%#  Convert.ToBoolean(Eval("IsCanTalk")) ?  "true" : "false"%>' data-issupport="<%# Eval("IsSupport") %>" data-userid="<%# Eval("UserID") %>" data-firstname="<%# Eval("FirstName") %>" data-username="<%# Eval("UserName") %>" data-avatar="<%# Eval("Avatar") %>">
                                                <div class="divUser_avatar" id="divUser_avatar">
                                                    <img src='<%# Eval("Avatar") %>' style="width:55px;height:55px;">
                                                  
                                                </div>
                                                <div class="divUser_avatar_info" id="divUser_avatar_info">
                                                    <span class="divUser_Avatar_Name" id="divUser_Avatar_Name"><%# Eval("FirstName") %></span><br/>
                                                    <span class="divUser_Avatar_Name" id="divUser_Avatar_Other_Info"><%# Eval("UserName") %></span><br />
                                                    <span class="divUser_Avatar_Name" id="divUser_Avatar_address" style="word-wrap:break-word;width:100px;display:block"><%# Eval("Address") %></span>
                                                    <div class="statusContainer">
                                                        <div class="ontalk" title='<%#  Eval("IsCanTalk").ToString() %>'>
                                                            <%--<img src="../Images/new/offline.png" id="imgOnTalkStatus"/>--%>
                                                            <img src='<%#  Convert.ToBoolean(Eval("IsCanTalk")) ?  "../Images/new/custom_online.png" : "../Images/new/custom_offline.png"%>' id="imgOnTalkStatus"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="divuser-msg-identification">
                                                    <asp:Image ID="Image1" CssClass="mailbox-img" runat="server" ImageUrl="~/Images/mail.png" Width="24px" Height="16px"  meta:resourcekey="imgAvatarResource2" /><span class="mailbox-img-counter"><%# Eval("UnReadMessageCount") %></span>
                                                    
                                                </div>
                                                <div class="divuser-msg-flag">
                                                    <asp:Image ID="imgflag" CssClass="msg_unflagged" runat="server" ImageUrl="~/Images/strip_metro7.png" Width="16px" Height="16px" style="display:none;border-style:none;"  meta:resourcekey="imgflagResource2"  onclick="FlagUnflag(this); return false;" />
                                                    <asp:Label ID="lblflag" CssClass="msg_unflagged" runat="server" onclick="FlagUnflag(this, event); return false;" ></asp:Label>
                                                </div>
                                            <div style='clear:both;'></div>
                                            </div>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                    </asp:Repeater>   
                                    <asp:HiddenField ID="hdnIsPostBack" runat="server" ClientIDMode="Static"/>

                                </div>
                    
                        <%--call end container--%>
                     <div id="callContainer" >
                           <hr  style="color: #D9EEFC !important;"/>
                    <img src="../Images/callEnd.png" id="btnTestCamera" onclick="endCameraTesting();" style="width: 54px;display:none;"/>
                    <div id="divCall"  style="display:none;">
                        <img src="../Images/new/custom_video.png" id="btnCallIcon" class="btnCallIconDisabled"  onclick="CreateAndJoinConference(event);"/>
                    </div>
                    <div id="lblCanTalkContainer"  class="lblCanTalkContainer lblCantTalk"  style="display:none;">
                        <img src="../Images/new/offline.png" id="imgTalkStatus" />
                        <%--<asp:Label ID="lblCanTalk" runat="server" Text="I Cannot Talk Now" ClientIDMode="Static"></asp:Label>--%>
                    </div>
                         
                    <div class="timerContainer">

                      
                         <div class="sessionContainer">
                                  <img src="../Images/new/Stopwatch.png" />
                                 <asp:Label ID="sessionTime" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                                <asp:Label ID="lblSessionLabel" runat="server" Text="Session:" ClientIDMode="Static"></asp:Label>
                               
                            </div>

                        <div class="divRemainingTimeLabel">
                            <asp:Label ID="lblRemainingTimer" runat="server" Text="Remaining Talk Timer" ClientIDMode="Static"></asp:Label>
                        </div>
                        <div class="minContainer" style="padding-top:4px;"> 



                           





<%--                            <div class="totalContainer" style="display:none;">
                                <asp:Label ID="lblTotalLabel" runat="server" Text="Total:" ClientIDMode="Static"></asp:Label>
                                <asp:Label ID="totalTime" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                            </div>--%>
                        </div>
                    </div>
                         </div>



                        <%-- <div style="background-color: #E3F2F0; width: 100%; height: 80px; display: flex; justify-content: space-evenly; align-items: center">
                               <div class="totalContainer" style="display:none;">
                                <asp:Label ID="Label4" runat="server" Text="Total:" ClientIDMode="Static"></asp:Label>
                                <asp:Label ID="Label5" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                            </div>
                                  <img src="../Images/new/Stopwatch.png" style="width: 40px; height: 40px;"/>
                                 <asp:Label ID="Label1" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                                <asp:Label ID="Label3" runat="server" Text="Session:" ClientIDMode="Static"></asp:Label>
                               
                            </div>--%>
                        </div>

                 </div>    

                                        
               
                <div id="renderer1" style="display:none;"></div>
                
                 <div class="sendmsg_top_container" id="sendmsg_top_container" >
                        <div id="renderer0" class="selfView" style="display:none;"></div>
                       <div id="renderer01" style="display:none; margin-top: -60px; margin-left: 10px" >
                                <button style="width: 100%; background-color: #F9FCFF; color: #444444; text-align: center; border: 1px solid #D9EEFC; border-radius:8px; box-shadow: 0px 1px 6px 0px rgba(0, 0, 0, 0.15);
">Audio Setting</button>
                         
                            <%-- <div id="renderer01_timesSection" class="sessionContainer" style="background-color: #E3F2F0; width: 100%; height: 80px; display: flex; justify-content: space-evenly; align-items: center">
                                  <img src="../Images/new/Stopwatch.png" />
                                 <asp:Label ID="sessionTime" runat="server" Text="" ClientIDMode="Static"></asp:Label>
                                <asp:Label ID="lblSessionLabel" runat="server" Text="Session:" ClientIDMode="Static"></asp:Label>
                               
                            </div>--%>
                            

                             </div> 

                      
                     <%--<div id="renderer01_timesSection" class="sessionContainer" style="display: none; margin-left: 10px">--%>
                     <div id="renderer01_timesSection" class="sessionContainer" style="display: none; margin-left: 10px">
                                 <img src="../Images/callEnd.png" onclick="endCameraTesting();" style="width: 54px;"/>
                          </div>
                  
                        <asp:UpdatePanel ID="updFriends" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div id="divFinalLearningMessage" class="divFinalLearningMessage" style="height:80px; overflow:auto;border: 1px solid #d3d2d2;width:99.5%; word-wrap:break-word;display:none;" ></div>
                                <div id="divFinalNativeMessage" class="divFinalLearningMessage" style="display:none; height:80px;overflow:auto;border: 1px solid #d3d2d2; word-wrap:break-word;" data-invisible="false"></div>
                                <div id="divOtherLanguages" class="divOtherLanguages" style="display:none; height:80px;overflow:auto;border: 1px solid #d3d2d2; word-wrap:break-word;" data-invisible="false"></div>
                             
                                
                              
                            </ContentTemplate>
                            
                        </asp:UpdatePanel>









               

                    <asp:UpdatePanel ID="updateSelectedUser" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="mailbox_chatroom_profile" id="mailbox_chatroom_profile">
                                <div id="divUser" runat="server">
                                    <div class="mcp_avatar" id="mcp_avatar" style="display:none;">
                                        <asp:Image ID="imgAvatar" CssClass="selected_mcp_avatar_img" runat="server" ClientIDMode="Static" meta:resourcekey="imgAvatarResource1" onclick="GotoFriendsRoom();"/>
                                    </div>
                                    <div class="mcp_information" id="mcp_information">
                                                
                                        <asp:Label ID="lblLastName" style="display:none;" CssClass="mcp_information_others" runat="server" meta:resourcekey="lblLastNameResource1" ClientIDMode="Static"></asp:Label><br />
                                        <asp:Label ID="lblFirstNAme" CssClass="mcp_information_name" runat="server" meta:resourcekey="lblFirstNAmeResource1" ClientIDMode="Static" onclick="GotoFriendsRoom();" style="cursor:pointer;"></asp:Label><br />
                                        <asp:Label ID="lblAddress" CssClass="mcp_information_others" runat="server" meta:resourcekey="lblAddressResource1"></asp:Label><br />
                                        <asp:Image ID="imgStatus" CssClass="mcp_information_others" style="display:none;" runat="server" meta:resourcekey="imgStatusResource1"/><asp:Label ID="lblOnlineStatusText" style="display:none;" CssClass="mcp_information_others" runat="server" meta:resourcekey="lblOnlineStatusTextResource1"></asp:Label><br />
                                        <%--<asp:Image ID="imgLike" runat="server" ImageUrl="~/Images/heartUnlike.png" meta:resourcekey="imgLikeResource1" style="display: none;"/>&nbsp;<asp:Label ID="lblLikeCount" CssClass="mcp_information_others" runat="server" style="margin-right:5px;display: none;" meta:resourcekey="lblLikeCountResource1"></asp:Label><asp:Label ID="lblStatusText" CssClass="mcp_information_others" runat="server" meta:resourcekey="lblStatusTextResource1"></asp:Label>--%>
                                    </div>
                                    <div style='clear:both;'></div>
                                </div>
                            </div>

                        </div>


                        </ContentTemplate>
                    </asp:UpdatePanel>
              
                        <div id="renderer2" class="remoteView" style="display:none;">

                        </div>
                    </div>

                    
                <div id="divMessageContainer">
                    <div class="smctc_msgbox_btnaddclear_container">
                        <div id="divSecondLanguage">
                            <asp:CheckBox runat="server" id="chkSecondLanguage" class='chkLanguage' ClientIDMode="static"/><label for="chkSecondLanguage" class='lblLanguage'>2nd Language Only</label>
                            <asp:CheckBox runat="server" id="chkCallInProgress" style="display:none;" ClientIDMode="static"/>
                        </div>                    
                    </div>
                     <div id="divChatBoxLabecontainer">
                         <asp:Button runat="server" ID="btnChatSupport" CssClass="btn supportHasMessage" ClientIDMode="Static" Text="Chat Support" OnClientClick="SelectSupportOrPartner(true); return false;" style="display:none;" UseSubmitBehavior="false"/>
                         <asp:HiddenField runat="server" ID="hdnChatSupport" ClientIDMode="Static" meta:resourcekey="hdnChatSupportResource1"/>
                         <asp:HiddenField runat="server" ID="hdnGoBackToPartner" ClientIDMode="Static" meta:resourcekey="hdnGoBackToPartnerResource1"/>
                         <asp:Label ID="lblChatBox" ClientIDMode="Static" runat="server" Text="Chat" meta:resourcekey="lblChatBoxLabelResource1"></asp:Label>
                     </div>
                      <asp:UpdatePanel ID="updMessages" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Button ID="btnGetUserMessage" runat="server" Text="Get User" style="display:none;" ClientIDMode="Static" OnClick="btnGetUserMessage_Click" meta:resourcekey="btnGetUserMessageResource1" />
                                   
                                <div id="divMessage" class="divMessage">
                                    <asp:Repeater ID="rptConversation" runat="server" ClientIDMode="Static" OnItemDataBound="rptConversation_ItemDataBound">
                                        <HeaderTemplate>
                                            <asp:Button ID="btnLoadPrevious" runat="server" Text="Load Previous..." OnClientClick="LoadPrevious(); return false;" Visible="false" />
                                            <table id="tblMessage" class="tblMessage">
                                        </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr runat="server" id="trMessage"  data-keyword='<%# Eval("Keyword") %>'>
                                                    <td class="nameContainer" style="vertical-align:top;width:13%;">
                                                        <asp:Label runat="server" id="lblYou" class="partner chatname" style="color:red;font-size:8pt;font-weight:bold;  margin-top: 45px;" Text='<%# Eval("Sender") %>' Visible="false"></asp:Label>
                                                        <asp:Label runat="server" id="lblMe" class="chatname" style="color:black;font-size:10pt;font-weight:bold; display:none" Text='<%# Eval("Sender") %>' Visible="false"></asp:Label>
                                                        <asp:Image ID="imgAvatarYou" CssClass="imgAvatarYou" style="margin-top: 40px; border-radius: 50%;" runat="server" Width="65px" Height="65px" meta:resourcekey="imgAvatarYouResource1" Visible="true"/>

                                                        
                                                    </td>
                                                    <td class="tblMessage_conv">
                                                        <div class="conversationDate" style="width:100%;text-align:center;">
                                                            <span class="chatdate" style="width:100%;text-align:center;"><%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %></span>
                                                        </div>
                                                        <div class="tblMessage_conversation">
                                                            <span class="<%# Eval("CssClass") %>" id="msg_conversation" style="word-wrap:break-word;"><%# Server.HtmlDecode(Eval("NativeLanguageMessage").ToString() )%>
                                                            </span>
                                                            <span class="<%# Eval("CssClass2") %>" id="msg_conversation2" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;"><%# Server.HtmlDecode( Eval("LearningLanguageMessage").ToString() )%>
                                                                <asp:ImageButton ID="imgReport" CssClass="imgReport" ClientIDMode="Static" runat="server" data-usermailid='<%# Eval("UserMailID") %>' meta:resourcekey="imgReportResource1" ImageUrl="~/Images/block.png" style="" ToolTip="Report this Problem Message" Visible='<%# Convert.ToBoolean(Eval("IsReply")) ? false : true%>' OnClientClick="ConfirmReport(this); return false;"/>
                                                                <asp:ImageButton ID="imgReply" CssClass="imgReply" ClientIDMode="Static" runat="server" data-usermailid='<%# Eval("UserMailID") %>' meta:resourcekey="imgReplyResource1" ImageUrl="~/Images/talkreply.png" style="" ToolTip="Reply to this message." Visible='<%# Convert.ToBoolean(Eval("IsReply")) ? false : true%>' OnClientClick="SearchViaReply(this); return false;"/>
                                                                </span>
                                                        </div>
                                                    </td>
                                                  <%--  <td style="vertical-align:top;">
                                                        <asp:Image ID="imgAvatarMe" CssClass="imgAvatarMe" runat="server" Width="65px" Height="65px" meta:resourcekey="imgAvatarMeResource1"/>
                                                    </td>--%>
                                                </tr>
                                            </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    <div id="divToolsContainer">
                        <div id="divImReady" class="square_custom">
                            <asp:Label ID="lblPresent" Visible="false" ClientIDMode="Static" runat="server" Text="&nbsp;" meta:resourcekey="lblPresentLabelResource2"></asp:Label>
                            <%--<div class="divStepCircle" id="stepPresent"><span>1</span></div>--%>
                        </div>
                        <div id="divRepeatImage" class="square_custom">
                            <asp:Label ID="lbPleaseRepeatLabel" Visible="false" ClientIDMode="Static" runat="server" Text="Please Repeat!" meta:resourcekey="lbPleaseRepeatLabelResource1"></asp:Label>
                            <%--<div class="divStepCircle" id="stepPleaseRepeat"><span>2</span></div>--%>
                        </div>
                        <div id="divTextMeImage" class="square_custom">
                            <asp:Label ID="lblTextMeLabel" Visible="false" ClientIDMode="Static" runat="server" Text="Text Me" meta:resourcekey="lblTextMeLabelResource1"></asp:Label>
                            <%--<div class="divStepCircle" id="stepTextMe"><span>3</span></div>--%>
                        </div>
                        <div id="divFreeMessageImage" class="square_custom" runat="server" ClientIDMode="Static" onclick="FreeMessage(); return false;">
                            <asp:ImageButton ID="imgFreeFormMessage" Visible="false" ClientIDMode="Static" ImageUrl="~/Images/new/talkFreeMessage.png" BackColor="Transparent" BorderColor="Transparent" runat="server" AlternateText="Free Form" OnClientClick="FreeMessage(); return false;" ToolTip="Free Form" meta:resourcekey="imgFreeFormMessageResource1"/>
                            <asp:Label ID="lblFreeLabel" style="display:none;" ClientIDMode="Static" runat="server" Text="Free" meta:resourcekey="lblFreeLabelResource1"></asp:Label>
                            <span id="lblfreemessage" style="display:none;">&nbsp;</span> <%--hack--%>
                            <%--<div class="divStepCircle" id="stepFreeMessage"><span>4</span></div>--%>
                        </div>
                        <div id="divIssueImage" class="square">
                        </div>
                        <div id="divAdviceImage" class="rectangle">
                        </div>
                    </div>
                </div>
        </div>
<%--        <div class="sendmsg_bottom_container" id="sendmsg_bottom_container" >
            <div id="divDisplaySuggestion" class="suggestionContainer" runat="server" style="width:100%; float:left; color:white; font-weight:bold;cursor:pointer;vertical-align:middle;line-height:30px;" onclick="return UseSuggestion();" title="Click to use Today's Topic">
                <asp:Label ID="lblTopic" CssClass="snd-todays-topic"  runat="server" Text="Today's Topic: " meta:resourcekey="lblTopicResource1"></asp:Label>
            </div>
            <div id="divSuggestion" runat="server" style=" float:left; height:100px; width:100%;display:none;">
            </div>
         </div>--%>
        <div class="sendmsg_middle_container" id="sendmsg_middle_container">
            <div id="mtabs">
                <div class="smc_criteria_container" id="smc_criteria_container">
                    <div class="smc_search_container" id="smc_search_container" style="position:relative;">
                    <asp:Label ID="lblSentences" CssClass="smcsc_search_lbl" runat="server" Text="Palette Search" meta:resourcekey="lblSentencesResource1" style="display:none;"></asp:Label>
                    <div style="float:left;" class="smc_search_child_container">
                        <div class="divSearchContainer">
                            <div class="emoji_container" style="display:none;">
	                            <img id="imgEmoji2"  src="../Images/emoji.png" class="smcsc_search_emoji" />
	                            <img id="imgPunctuation"  src="../Images/exclamation.gif" class="smcsc_search_emoji" />
	                            <asp:ImageButton ID="imgAddWord" ImageUrl="~/Images/addreplaceword.png" BorderColor="Transparent" BackColor="Transparent" runat="server" AlternateText="Free Form"  OnClientClick="FreeForm(); return false;"  ToolTip="Add/Replace Word" style="float:left;position:relative;top:-10px;display:none;" meta:resourcekey="imgAddWordResource1"   />
	                            <asp:Label ID="lblLabelAddEditWord" runat="server" Text="Add/Replace Word" meta:resourcekey="lblLabelAddEditWordResource1" style="font-size:x-small;display:none;"></asp:Label>
                            </div>
                            <img id="imgEmoji"  src="../Images/emoji.png" class="smcsc_search_emoji" style="display:none;" />
                            <div id="divSearchUpperRow" class="divSearchRow">
 						        <asp:UpdatePanel ID="updCategory" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlCategory"  AutoPostBack="true" onchange="CategoryChanged();" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" CssClass="smcsc_search_slct" runat="server" meta:resourcekey="ddlCategoryResource1" ClientIDMode="Static"></asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <fieldset class="criterialist" style="display:none;">
                                    <legend>
                                        <asp:Label ID="lblCriteriaLabel" CssClass="lblCriteriaLabel" runat="server" Text="Search" ClientIDMode="Static" meta:resourcekey="lblCriteriaLabelResource1"></asp:Label>
                                    </legend>
                                    <asp:RadioButtonList ID="rdoCriteriaList" CssClass="rdoCriteriaList" runat="server" ClientIDMode="Static" RepeatDirection="Horizontal" CellSpacing="0" CellPadding="0" >
                                        <asp:ListItem Text="Phrase+Word" Value="0" Selected="True" meta:resourcekey="rdoPhraseWordResource1"></asp:ListItem>
                                        <asp:ListItem Text="Word" Value="1"  meta:resourcekey="rdoWordResource1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    
                                </fieldset>
                            </div>
                            <div id="divSearchLowerRow" class="divSearchRow">
                                <div id="lblTopicsLabelContainer" style="display:none;"><asp:Label ID="lblTopicsLabel" CssClass=""  runat="server" Text="Topics:" meta:resourcekey="lblTopicsLabelResource1"></asp:Label></div>
                                <div class="smc_search_container_search_box_txt" id="word_search">
                                    <asp:TextBox ID="txtSearchSentence" CssClass="smcsc_search_txt clearable" runat="server" BorderColor="Transparent" meta:resourcekey="txtSearchSentenceResource1" ClientIDMode="Static" spellcheck="true"></asp:TextBox>
                                    <asp:ImageButton ID="imgClearSearch" CssClass="smcsc_search_x" ImageUrl="~/Images/x.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1" style="display:none;"/>
                                    <asp:ImageButton ID="imgSearchSentence" CssClass="smcsc_search_img" ImageUrl="~/Images/SearchF.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" OnClick="imgSearchSentence_Click" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1"/>
                                </div>
                                <div class="divNumbercircle" id="step2" style="display:none;"><span>2</span></div>                 
                                <div class="divSentenceLabelContainer" style="display:none;">
                                    <div class="divNumbercircle" id="step3"><span>3</span></div>
                                    <asp:Label ID="lblSentenceTitle" ClientIDMode="Static" runat="server" Text="Phrase Palette" meta:resourcekey="lblSentenceTitleResource1" style="line-height:24px;font-weight:bold;"></asp:Label>
                                    <div class="divNumbercircle" id="step3OwnPalette"><span>3</span></div>
                                    <asp:Label ID="lblOwnPaletteTitle" ClientIDMode="Static" runat="server" Text="Phrase Palette" meta:resourcekey="lblOwnPaletteTitleResource1" style="line-height:24px;font-weight:bold;display:none;"></asp:Label>
                                </div>
                            </div>
                        </div>

                    <ul class="tabs_links_menu">
                        <li class="prhraseTabs"><asp:HyperLink CssClass="send-msg-tabs1" ID="linkTabPhrases" href="#mtab1" runat="server" Text="Phrases" meta:resourcekey="linkTabPhrasesResource1"/></li>
                        <li class="prhraseTabs tabAddToMyPhrases"><asp:HyperLink CssClass="send-msg-tabs2" ID="linkMyPhrases" href="#mtab2" runat="server" Text="Own Palette" meta:resourcekey="linkMyPhrasesResource1"/></li>
                        <li  style="display:none;"><asp:HyperLink CssClass="send-msg-tabs3" ID="linkTabOptions" href="#mtab3" runat="server" Text="Options" meta:resourcekey="linkTabOptionsResource1" /></li>
						<li id="liTabWordForPhrase" class="wordTab" style="background: #3868D6 !important;"><asp:HyperLink CssClass="send-msg-tabs5" ID="HyperLink4" href="#mtab5" runat="server" Text="Word" meta:resourcekey="linkTabWordResource1"/></li>
						<li id="liTabUserWordForPhrase" class="wordTab"><asp:HyperLink CssClass="send-msg-tabs6" ID="HyperLink5" href="#mtab6" runat="server" Text="My Word" meta:resourcekey="linkTabUserWordResource1" /></li>
                    </ul>
                       
                    <div class="divAddOwnPaletteContainer">
                        <asp:HiddenField ID="hdnAddOwnPaletteLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnAddOwnPaletteLabelResource1" />
                        <button type="button" id="btnAddOwnPalette" class="btnUpdate_profile btnAddOwnPalette" onclick="saveOwnPalette();"></button>
                        <asp:HiddenField ID="hdnRemoveOwnPaletteLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnRemoveOwnPaletteLabelResource1" />
                        <button type="button" id="btnRemoveOwnPalette" class="btnUpdate_profile btnRemoveOwnPalette" onclick="deleteOwnPalette();"></button>
                       
                    </div>


                            <div class="divNumbercircle" id="step1" style="display:none;"><span>1</span></div>
                            <asp:HiddenField ID="hdnIcanTalkNow" runat="server" ClientIDMode="Static" meta:resourcekey="hdnIcanTalkNowResource1"/>
                            <asp:HiddenField ID="hdnIcantTalkNow" runat="server" ClientIDMode="Static"  meta:resourcekey="hdnIcantTalkNowResource1"/>
                           <%-- <div id="divIssues" class="talkButton">
                                <asp:Label ID="lblIssues" ClientIDMode="Static" runat="server" Text="ISSUES" meta:resourcekey="lblIssuesResource1"></asp:Label>                                
                            </div>--%>
                        </div>
                    </div>

                   
                    <asp:ImageButton ClientIDMode="Static" CssClass="smcsc_search_emoji" ID="imgSettings" ImageUrl="~/Images/settings.png" BackColor="Transparent" BorderColor="Transparent" runat="server" ToolTip="" meta:resourcekey="imgSettingsResource1"/>
                    
                </div>

            
               
            <div id="mtab1">


























                  <div class="src_frame" id="setting_palette">
                        <div class="switch_container" style="display: none;">
                            <div class="sc_lbl">
                                <asp:Label ID="Label6" runat="server" Text="Sequencence"  meta:resourcekey="lblSequenceResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="Checkbox1" class="switch6 chkSequence" checked="checked" runat="server"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="Label7" runat="server" Text="Native Language" meta:resourcekey="lblNativeResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="Checkbox2" class="switch6 chkNative" checked="checked"  runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" id="div5" runat="server">
                            <div class="sc_lbl">
                                <asp:Label ID="Label8" runat="server" Text="Romanji" meta:resourcekey="lblRomanjiResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="Checkbox3" class="switch6 chkSecondary" checked="checked"  ClientIDMode="Static" runat="server"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" style="display:none !important;">
                            <div class="sc_lbl">
                                <asp:Label ID="Label9" runat="server" Text="Sound" meta:resourcekey="lblSoundResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSound" class="switch6 chkSound" checked="checked"  />
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" style="display: none;">
                            <div class="sc_lbl">
                                <asp:Label ID="Label10" runat="server" Text="Language Order" meta:resourcekey="lblLanguageOrderResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div id="div6" runat="server" class="make-switch" data-on="warning" data-off="danger" data-on-label="ENG" data-off-label="JP">
                                    <input type="checkbox" id="Checkbox4" runat="server" class="chkLanguageOrder"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="Label11" runat="server" Text="Kanji" meta:resourcekey="lblSubLanguage2Resource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div id="div7" runat="server" class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="Checkbox5" runat="server" class="chkSubLanguage2"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="Label12" runat="server" Text="Sound" meta:resourcekey="lblSoundAndMailResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div id="div8" runat="server" class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="Checkbox6" runat="server" class="chkSoundAndMail"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" style="display:none;">
							<div class="sc_lbl">
								<asp:Label ID="Label13" runat="server" Text="Step"  meta:resourcekey="lblStepResource1"></asp:Label>
							</div>
							<div class="sc_conf">
									<div class="make-switch" data-on="warning" data-off="default">
									<input type="checkbox" id="Checkbox7" class="switch6" checked="checked" runat="server" ClientIDMode="Static"/>
								</div>
							</div>
						</div>

                    <div>
					    <%--<asp:Button ID="btnSave" ClientIDMode="Static" CssClass="btnUpdate_profile" Width="97px" Height="36px" runat="server" Text="Save" style="background-image:url('../Images/btnUpdateProfile.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat;float:left;" OnClientClick="return false;" BorderStyle="None" ValidationGroup="p" meta:resourcekey="btnSaveResource1" UseSubmitBehavior="false" CausesValidation="false"/> --%>
                        <asp:Button ID="Button1" ClientIDMode="Static" CssClass="btnUpdate_profile btnSettingsSave" runat="server" Text="Save" OnClientClick="return false;"  ValidationGroup="p" meta:resourcekey="btnSaveResource1" UseSubmitBehavior="false" CausesValidation="false"/> 
                        <asp:Label ID="Label14" style="display:none;" ClientIDMode="Static" runat="server" Text="Turning &quot;OFF&quot; Sequence and Native Language can make the Palette into a Puzzle."  meta:resourcekey="lblSaveExResource1"></asp:Label>
                    </div>
					<asp:Label ID="Label15" ClientIDMode="Static" runat="server" Text="Options Saved" meta:resourcekey="lblSaveMessageResource1" style="display:none;" ForeColor="Green" EnableViewState="false"></asp:Label>

                    </div>

                
                <div class="smc_bottom_container" id="smc_bottom_container">
                <div class="sbc_left_container" id="sbc_left_container">
                   
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div id="divStep2ArrowContainer">
                            <div class="arrowlabelnumberContainer">
                                <div class="divNumbercircle" id="step5"><span>5</span></div>
                            </div>
                        </div>
                            <div id="sentenceContainer" runat="server" class="sContainerb">
                            
                            </div>
                            <asp:Label ID="lblLabelSentencePaging" ClientIDMode="Static" runat="server" Text="Phrase palette"  meta:resourcekey="lblLabelSentencePagingResource1" style="line-height:24px; font-weight:bold;display:none;"></asp:Label>
                            <div  class="sentencepagingContainer">
                                <div class="arrowContainer arrowlabelnumberContainer">
                                        <div style="width:75px;">
                                            <asp:ImageButton ID="imgBack" ImageUrl="~/Images/previousArrow.png" BackColor="Transparent"  BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgBackResource1" OnClick="imgBack_Click"/>
                                            <asp:ImageButton ID="imgForward" ImageUrl="~/Images/nextArrow.png" BackColor="Transparent"  BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgForwardResource1" OnClick="imgForward_Click"/>
                                        </div>
                                </div>
                                <div id="sentencePaging" title="Page"></div>
                            </div>
                            <asp:Button ID="btnSearchSentence" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchSentence_Click" meta:resourcekey="btnSearchSentenceResource1"/>
                        </ContentTemplate>
                     <Triggers>
                         <asp:AsyncPostBackTrigger ControlID="imgSearchSentence" EventName="click" />
                         <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="imgBack" EventName="click" />
                        <asp:AsyncPostBackTrigger ControlID="imgForward" EventName="click" />
                     </Triggers>
                    </asp:UpdatePanel>
                </div>
                
            </div>
               
            
            </div>
            <div id="mtab2">
                <div class="smc_bottom_container">
                     <p> this is a test==============</p>
                <div class="sbc_left_container">
                   
                    <asp:UpdatePanel ID="updOwnPalette" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="divStep2ArrowContainer">
                            <div class="arrowlabelnumberContainer">
                            </div>
                            <div class="arrowlabelnumberContainer">
                                <div class="divNumbercircle" id="step5OwnPalette"><span>5</span></div>
                            </div>
                        </div>
                            <asp:Label ID="Label2" ClientIDMode="Static" runat="server" Text="Phrase palette"  meta:resourcekey="lblLabelSentencePagingResource1" style="line-height:24px; font-weight:bold;display:none;"></asp:Label>
                            <div id="sentenceContainerOwnPalette" runat="server" class="sContainerb divUserPaletteContainer">
                            
                            </div>
                            <div  class="sentencepagingContainer">
                                <div id="sentencePagingOwnPalette" style="title="Page"></div>
                            </div>
                            <asp:Button ID="btnSearchSentenceUserPalette" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchSentenceUserPalette_Click" meta:resourcekey="btnSearchSentenceResource1"/>
                        </ContentTemplate>
                     <Triggers>
                         
                     </Triggers>
                    </asp:UpdatePanel>
            </div>
            </div>
        </div>
            <div id="mtab3">
                <div class="sbc_right_container" id="sbc_right_container">
                    <div class="src_frame">
                        <div class="switch_container" style="display: none;">
                            <div class="sc_lbl">
                                <asp:Label ID="lblSequence" runat="server" Text="Sequencence"  meta:resourcekey="lblSequenceResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSequence" class="switch6 chkSequence" checked="checked" runat="server"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="lblNative" runat="server" Text="Native Language" meta:resourcekey="lblNativeResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkNative" class="switch6 chkNative" checked="checked"  runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" id="divRomanji" runat="server">
                            <div class="sc_lbl">
                                <asp:Label ID="lblRomanji" runat="server" Text="Romanji" meta:resourcekey="lblRomanjiResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSecondary" class="switch6 chkSecondary" checked="checked"  ClientIDMode="Static" runat="server"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" style="display:none !important;">
                            <div class="sc_lbl">
                                <asp:Label ID="lblSound" runat="server" Text="Sound" meta:resourcekey="lblSoundResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSound" class="switch6 chkSound" checked="checked"  />
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" style="display: none;">
                            <div class="sc_lbl">
                                <asp:Label ID="lblLanguageOrder" runat="server" Text="Language Order" meta:resourcekey="lblLanguageOrderResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div id="divorder" runat="server" class="make-switch" data-on="warning" data-off="danger" data-on-label="ENG" data-off-label="JP">
                                    <input type="checkbox" id="chkLanguageOrder" runat="server" class="chkLanguageOrder"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="lblSubLanguage2" runat="server" Text="Kanji" meta:resourcekey="lblSubLanguage2Resource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div id="div4" runat="server" class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSubLanguage2" runat="server" class="chkSubLanguage2"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="lblSoundAndMail" runat="server" Text="Sound" meta:resourcekey="lblSoundAndMailResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div id="div1" runat="server" class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSoundAndMail" runat="server" class="chkSoundAndMail"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" style="display:none;">
							<div class="sc_lbl">
								<asp:Label ID="lblStep" runat="server" Text="Step"  meta:resourcekey="lblStepResource1"></asp:Label>
							</div>
							<div class="sc_conf">
									<div class="make-switch" data-on="warning" data-off="default">
									<input type="checkbox" id="chkTooltip" class="switch6" checked="checked" runat="server" ClientIDMode="Static"/>
								</div>
							</div>
						</div>

                    <div>
					    <%--<asp:Button ID="btnSave" ClientIDMode="Static" CssClass="btnUpdate_profile" Width="97px" Height="36px" runat="server" Text="Save" style="background-image:url('../Images/btnUpdateProfile.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat;float:left;" OnClientClick="return false;" BorderStyle="None" ValidationGroup="p" meta:resourcekey="btnSaveResource1" UseSubmitBehavior="false" CausesValidation="false"/> --%>
                        <asp:Button ID="btnSave" ClientIDMode="Static" CssClass="btnUpdate_profile btnSettingsSave" runat="server" Text="Save" OnClientClick="return false;"  ValidationGroup="p" meta:resourcekey="btnSaveResource1" UseSubmitBehavior="false" CausesValidation="false"/> 
                        <asp:Label ID="lblSaveEx" style="display:none;" ClientIDMode="Static" runat="server" Text="Turning &quot;OFF&quot; Sequence and Native Language can make the Palette into a Puzzle."  meta:resourcekey="lblSaveExResource1"></asp:Label>
                    </div>
					<asp:Label ID="lblSaveMessage" ClientIDMode="Static" runat="server" Text="Options Saved" meta:resourcekey="lblSaveMessageResource1" style="display:none;" ForeColor="Green" EnableViewState="false"></asp:Label>

                    </div>
                </div>
            </div>
            <div  class="smc_word_container" id="smc_word_container">
                <div id="wordTabsContainer" style="display:none;">
                    <div id="wordtabs">
						<ul>
							<li id="liTabWord" class="wordTab"><asp:HyperLink CssClass="send-msg-tabs5" ID="linkTabWord" href="#mtab5" runat="server" Text="Word" meta:resourcekey="linkTabWordResource1"/></li>
							<li id="liTabUserWord" class="wordTab"><asp:HyperLink CssClass="send-msg-tabs6" ID="linkTabUserWord" href="#mtab6" runat="server" Text="My Word" meta:resourcekey="linkTabUserWordResource1" /></li>
						</ul>
                        
                        <div id="mtab5">
                            
                            <div id="divWordPaletteOtherContainer1">
                                <div class="steptitlepagingContainer">
                                    <div class="smc_search_container_search_box_txt">
                                        <asp:TextBox ID="txtSearchWord" CssClass="smcsc_search_txt clearable" runat="server" BorderColor="Transparent" meta:resourcekey="txtSearchSentenceResource1" ClientIDMode="Static" spellcheck="true"></asp:TextBox>
                                        <asp:ImageButton ID="ImageButton1" CssClass="smcsc_search_x" ImageUrl="~/Images/x.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1" style="display:none;"/>
                                        <asp:ImageButton ID="imgSearchWord" CssClass="smcsc_search_img" ImageUrl="~/Images/SearchF.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" OnClick="imgSearchWord_Click" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1"/>
                                    </div>
                                </div>
                                <div class="steptitlepagingContainer centerElementContainer" style="display:none;">
                                    <div class="divNumbercircle" id="step4"><span>4</span></div>
                                    <asp:Label ID="lblLabelWordPaging" runat="server" Text="Word palette" meta:resourcekey="lblLabelWordPagingResource1" style="line-height:24px;text-align:center;font-weight:bold; background-color: #3868D6 !important; border: 1px solid red;" ></asp:Label>
                                </div>
                                <div class="steptitlepagingContainer">
							        <div class="wordpagingContainer">
								        <div id="lbl1" style="border:1px solid buttonface;display:none;" title="Page" ></div>
							        </div>
                                </div>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" style="width:100%;" >
                                <ContentTemplate>
                                    <div id="divWordContainer" runat="server" class="sContainer">
                            
                                    </div>
                                    <div class="wordpagingContainer">
                                        <button type="button" id="btnAddWord1" class="" onclick="FreeForm(); return false;" style="background-color:rgb(252, 234, 187);display:none;"></button>
                                        <div id="wordPaging" style="border:1px solid buttonface;" title="Page"></div>
                                    </div>
                                    <asp:Button ID="btnSearchWord" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchWord_Click" meta:resourcekey="btnSearchWordResource1"/>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="imgSearchWord" EventName="click" />
                                    <asp:AsyncPostBackTrigger ControlID="imgBack" EventName="click" />
                                    <asp:AsyncPostBackTrigger ControlID="imgForward" EventName="click" />
                                    
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <div id="mtab6">
                            <%--<div  class="smc_word_container" id="divWordPaletteUserCreated" style="display:flex !important;">--%>
							            <%--<div class="loader" style="margin-right: auto; margin-left: auto; display: block; background-repeat: no-repeat;background-image: url(../images/loading.gif); height: 50px; width: 50px; margin-top: -50px;"></div>--%>
                                        <div id="divWordPaletteOtherContainer2">
                                            <div class="steptitlepagingContainer">
                                                <%--<div class="divNumbercircle" id="step3bb"><span>3*</span></div>--%>
                                            </div>
                                            <div class="steptitlepagingContainer centerElementContainer" style="display:none;">
                                                <div class="divNumbercircle" id="step4b"><span>4</span></div>
                                                <asp:Label ID="lblLabelWordPagingUserCreated" CssClass="lblLabelWordPaging" runat="server" Text="My Word palette" meta:resourcekey="lblLabelWordPagingUserCreatedResource1" ></asp:Label>
                                            </div>
                                            <div class="steptitlepagingContainer">
                                            </div>
                                        </div>
					            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional"  style="width:100%;">
						            <ContentTemplate>
							            <div id="divWordContainerUserCreated" runat="server" class="sContainer">
							            </div>
							            <div class="wordpagingContainer">
								            <div id="wordPagingusercreated" style="border:1px solid buttonface;" title="Page"></div>
							            </div>
							            <asp:Button ID="btnSearchWordUserCreated" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchWord_Click" meta:resourcekey="btnSearchWordResource1"/>
						            </ContentTemplate>
						            <Triggers>
							           <asp:AsyncPostBackTrigger ControlID="imgSearchSentence" EventName="click" />
                                        <asp:AsyncPostBackTrigger ControlID="imgBack" EventName="click" />
                                        <asp:AsyncPostBackTrigger ControlID="imgForward" EventName="click" />
                                        <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
						            </Triggers>
					            </asp:UpdatePanel>
				            <%--</div>--%>
                            
                        </div>
                        <img id="btnAddWord" src="../Images/createmyword.png" onclick="FreeForm(); return false;" />
                    </div>
                </div>
            </div>

    </div>
         <div class="sendmsg_bottom_container" id="Div2" >
        <div id="div3" class="suggestionContainer" runat="server" style="float:left;">
        </div>
        </div>
    </div>
        </div>

    <div id="imageTemporary" style="display:none;"></div>

</asp:Content>
