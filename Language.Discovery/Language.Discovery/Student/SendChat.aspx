﻿    <%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SendChat.aspx.cs" Inherits="Language.Discovery.SendChat" ValidateRequest="false" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
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
    <script src="../Scripts/Others.js" type="text/javascript"></script>
    <link href="../colorbox/colorbox.css" rel="stylesheet" />
    <script src="../colorbox/jquery.colorbox.js"></script>
    <script src="../Scripts/bootstrap-paginator.min.js"></script>
    <script src="../Scripts/bootstrap-switch.min.js"></script>
    <link href="../App_Themes/Default/bootstrap-switch.css" rel="stylesheet" />
    <script src="../Scripts/jquery.simplePagination.js"></script>
    <link href="../App_Themes/Default/simplePagination.css" rel="stylesheet" />
    <script src="../Scripts/buzz.min.js"></script>
    <script src="../Scripts/jquery.ui.position.min.js"></script>
    <script src="../Scripts/contextMenu.min.js"></script>
    <link href="../App_Themes/Default/contextMenu.css" rel="stylesheet" />
    <script src="../Scripts/jquery.ui.touch-punch.min.js"></script>
    <link href="../App_Themes/Default/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/addClear.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.signalR-2.2.0.min.js"></script>
     <script src="/signalr/hubs"></script>
    <link href="../App_Themes/Default/DefaultTalk.css" rel="stylesheet" />

    <style type="text/css">
        .rdoCriteriaList {
            margin-top:0px !important;
        }
        .rdoCriteriaList label{
            font-size:x-small;
            font-weight:lighter !important;
            display:inline-block;
        }
        .sortable > div { float: left; }
        #divFinalLearningMessage{
            float:left;
            width:49%;
        }

    #divFinalNativeMessage{
        float:right;
        width:49%;
    }

img{border:none;}

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
            
            /*box-shadow: 1px 1px 1px 0px rgba(0, 0, 0, 0.4), 1px 1px 1px 0px rgba(255, 255, 255, 0.8);
            border-radius:1px;
            background:rgba(0, 0, 0, 0.1);*/
        }
        .pallete ul {
            margin-left:24px;
        }

    .items .ui-selecting { background: #FECA40; }
    .items .ui-selected { background: #F39814; }
    
    .pallete:hover {
            background-color:silver;
        }



/*  */
        .firstword
        {
            margin-right:10px !important;
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
            border: 2px inset silver;
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
            padding: 1px 1px 1px 1px;
            margin:0;
            overflow: visible;
            
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
    .ui-tabs-vertical { width: 55em; }
    .ui-tabs-vertical .ui-tabs-nav { padding: .2em .2em 14em .1em; 
                                     float: right; 
                                     width: 4em;
                                     width: 1.7em !important; 
                                     background-color:transparent; }
    .ui-tabs-vertical .ui-widget-header
    {
        background-image: url('');
        color:transparent;  
        border-top-color: silver;
        border-left-color: silver;
        border-right-color: transparent;
        border-bottom-color: silver;
        height:100%;
        /*height:auto !important;*/

    }
    .ui-tabs-vertical .ui-tabs-nav li { clear: left; 
                                        width: 100%;
                                        width: 30px !important;
                                        height:90px !important; 
                                        border-bottom-width: 1px !important; 
                                        border-left-width: 0 !important; 
                                        /*margin: 0 0 -1px -1px;*/ 


    }
        /*.tabs_links_menu .send-msg-tabs1 {
            -webkit-transform: rotate(90deg);
            -moz-transform: rotate(90deg);
            -o-transform: rotate(90deg);
            -ms-writing-mode: tb-rl;

            
        }

        .tabs_links_menu .send-msg-tabs2 {
            -webkit-transform: rotate(90deg);
            -moz-transform: rotate(90deg);
            -o-transform: rotate(90deg);
            -ms-writing-mode: tb-rl;

            
        }*/  
    .ui-tabs-vertical .ui-tabs-nav li a { display: block;
    /*position:relative !important;
    left:-18px !important;*/

    }
    .ui-tabs-vertical .ui-tabs-nav li.ui-tabs-selected { padding-bottom: 0; 
                                                         padding-left: .1em; 
                                                         border-right-width: 1px; 
                                                         margin-left: -2px; }
    .ui-tabs-vertical .ui-tabs-panel { padding: 1em;width: 51em;}
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
        var chat = null;
        var interval = null;
        window.mobilecheck = function () {
            var check = false;
            (function (a, b) { if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) check = true })(navigator.userAgent || navigator.vendor || window.opera);
            return check;
        }

        var m_selectedItem = null;
        var m_shouldstoppropacation = false;

        function IsArrayContains(a, regex){
            for(var i = 0; i < a.length; i++) {
                if(a[i].search(regex) > -1){
                    return i;
                }
            }
            return -1;
        }

        function UpdateSentenceCount(add) {
            //update the word count
            var count = $('#lblWordCount').text();
            if( add == true )
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


            $('#divFinalLearningMessage').append('<div>' + span1 + removemes1.stringformat() + '</div>');
            $('#divFinalNativeMessage').append('<div>' + span2 + removemes2 + '</div>');
            UpdateSentenceCount(true);
            sessionStorage.setItem('shouldCountNumberOfSentence', 'false');
        }
        
        function ValidateSentence() {
            var correctorder = '';
            var language = '.firstword';
            var key = 'sentence2Ordinal';
            //if ($('#<%=chkNative.ClientID%>').prop("checked")) {
                language = '.secondword';
                key = 'sentence1Ordinal';
            //}

            $('#MainContent_divSentence ' + language).each(function () {
                var ordinal = $(this).attr('data-ordinal');
                var isemoji = $(this).attr('data-isemoji');
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
                placement : 'top',
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
                     //if (m_selectedItem == null) {
                         //$(this).parent().siblings().css("border", "");
                         $('#' + id).parent().siblings().css("border", "1px solid black");
                         $('#' + id).parent().css("border", "2px solid red");
                         m_selectedItem = $('#' + id).parent();
                         m_shouldstoppropacation = true;
                         $('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");

                         //InitializePopOver();
                         //SetupPopOver();
                         
                         //$('.popper-content').find('img')[0].onclick = "$('#' +" + elementid + ").popover('hide')";
                         
                         //$('#punctuationGallery').popover(

                         //InitializedContextMenu();
                         //$('.addreplaceword').contextMenu('menu');
                         //OpenContextMenu();
                     //}
                     //else {

                       //  EndEdit(m_selectedItem);
                         //$('.addreplaceword').contextMenu('destroy');
                     //}
                 }
             },
            {
                'name': $('#hdnCreateNewWord').val(),
                img: '/Images/addreplaceword.png',
                fun: function () {
                    
                    //if (m_selectedItem == null) {
                        //$(this).parent().siblings().css("border", "");
                        $('#' + id).parent().siblings().css("border", "1px solid black");
                        $('#' + id).parent().css("border", "2px solid red");
                        m_selectedItem = $('#' + id).parent();
                        m_shouldstoppropacation = true;
                        //InitializedContextMenu();
                        //$('.addreplaceword').contextMenu('menu');
                        //OpenContextMenu();
                    //}
                    //else {

                    //    EndEdit(m_selectedItem);
                        //$('.addreplaceword').contextMenu('destroy');
                    //}
                    FreeForm();
                }
            },
           
            {
                name: $('#lblCancel').text(),
                img: '/images/x.png',
                title: 'Cancel',
                fun: function () {
                    EndEdit(m_selectedItem);
                    //$('#MainContent_divSentence').popover('hide');
                    //ClosePopOver();
                }
            }];

            //Calling context menu

            //$('.addreplaceword').contextMenu(menu);
            if (window.mobilecheck()) {
                $('#' + id).contextMenu(menu, {triggerOn: 'hover'});
            }
            else {
                $('#' + id).contextMenu(menu, { triggerOn: 'hover' });
            }
            

            //$.contextMenu({
            //    selector: '.addreplaceword',
            //    trigger: 'none',
            //    callback: function (key, options) {
            //        var m = "clicked: " + key;
            //        window.console && console.log(m) || alert(m);
            //    },
            //    items: {
            //        "edit": { name: "Replace Word", icon: "edit" },
            //        "sep1": "---------",
            //        "quit": { name: "Cancel", icon: "quit" }
            //    }
            //});
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
                            //$(this).parent().siblings().css("border", "");
                            $('#' + id).parent().siblings().css("border", "1px solid black");
                            $('#' + id).parent().css("border", "2px solid red");
                            m_selectedItem = $('#' + id).parent();
                            m_shouldstoppropacation = true;
                            //InitializedContextMenu();
                            //$('.addreplaceword').contextMenu('menu');
                            //OpenContextMenu();
                        }
                        else {

                            EndEdit(m_selectedItem);
                            //$('.addreplaceword').contextMenu('destroy');
                        }
                        FreeForm();
                    }
                }, {
                    'name': 'Select from the List',
                    img: '/images/select.png',
                    fun: function () {
                        if (m_selectedItem == null) {
                            //$(this).parent().siblings().css("border", "");
                            $('#' + id).parent().siblings().css("border", "1px solid black");
                            $('#' + id).parent().css("border", "2px solid red");
                            m_selectedItem = $('#' + id).parent();
                            m_shouldstoppropacation = true;
                            //InitializedContextMenu();
                            //$('.addreplaceword').contextMenu('menu');
                            //OpenContextMenu();
                        }
                        else {

                            EndEdit(m_selectedItem);
                            //$('.addreplaceword').contextMenu('destroy');
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

            //$('.addreplaceword').contextMenu(menu);
            $('#' + id).contextMenu(menu, { triggerOn: "hover" });

            //$.contextMenu({
            //    selector: '.addreplaceword',
            //    trigger: 'none',
            //    callback: function (key, options) {
            //        var m = "clicked: " + key;
            //        window.console && console.log(m) || alert(m);
            //    },
            //    items: {
            //        "edit": { name: "Replace Word", icon: "edit" },
            //        "sep1": "---------",
            //        "quit": { name: "Cancel", icon: "quit" }
            //    }
            //});
        }

        function CloseContextMenu() {
            //$('.addreplaceword').contextMenu({ close: function () { alert("test"); } });
            //$('.addreplaceword').contextMenu('hide');
            //$('.iw-contextMenu').css('display', 'none');
            $('.addreplaceword').contextMenu('close');
        }
        function OpenContextMenu() {
            $('.addreplaceword').contextMenu();
        }
        
        function wordClick(id, validate) {
            // as per franks request
            if (validate == false && m_selectedItem == null)
                return;
            //needed this hack, stop propagation also stops the  plugins, wtf!!!
            if (m_shouldstoppropacation == true) {
                m_shouldstoppropacation = false;
                return;
            }

           
            var parent = $('#<%=divSentence.ClientID %>');
            var div = $('#' + id);
            //debugger;
            if (!validate && m_selectedItem != null) {
                if ($(div).find(".firstword").length > 0) {

                    m_selectedItem.find(".firstword").val($(div).find(".firstword").text());

                    m_selectedItem.find(".firstword").attr("data-lang", $(div).find(".firstword").attr("data-lang"));
                    m_selectedItem.find(".firstword").attr("data-word", $(div).find(".firstword").attr("data-word"));
                    m_selectedItem.find(".firstword").attr("data-switchword", $(div).find(".firstword").attr("data-switchword"));

                    m_selectedItem.find(".secondword").val($(div).find(".secondword").text());

                    m_selectedItem.find(".secondword").attr("data-lang", $(div).find(".secondword").attr("data-lang"));
                    m_selectedItem.find(".secondword").attr("data-word", $(div).find(".secondword").attr("data-word"));
                    m_selectedItem.find(".secondword").attr("data-switchword", $(div).find(".secondword").attr("data-switchword"));

                    m_selectedItem.find(".thirdword").val($(div).find(".thirdword").text());

                    m_selectedItem.find(".firstword").text($(div).find(".firstword").text());
                    m_selectedItem.find(".secondword").text($(div).find(".secondword").text());
                    m_selectedItem.find(".thirdword").text($(div).find(".thirdword").text());
                    //set the image
                    if ($(div).find(".imgPicture").length > 0) {
                        if (m_selectedItem.find(".imgPicture").length == 0) {
                            var a = $(div).find(".gallery").clone();
                            m_selectedItem.find(".firstword").attr("data-image", $(div).find(".firstword").attr("data-image"));
                            m_selectedItem.find(".secondword").attr("data-image", $(div).find(".secondword").attr("data-image"));
                            m_selectedItem.prepend(a);
                            m_selectedItem.addClass("screenshot");
                        }
                        else {
                            var a = m_selectedItem.find(".gallery").clone();
                            m_selectedItem.find(".firstword").attr("data-image", $(div).find(".firstword").attr("data-image"));
                            m_selectedItem.find(".secondword").attr("data-image", $(div).find(".secondword").attr("data-image"));
                            m_selectedItem.find(".gallery").attr("href", $(div).find(".gallery").attr("href"));
                        }
                    }

                }
                else {//punctuation
                    
                    //m_selectedItem.attr("data-ispunctuation", "true");
                    m_selectedItem.find(".firstword").val($(div).text());
                    m_selectedItem.find(".secondword").val($(div).text());
                    m_selectedItem.find(".thirdword").val($(div).text());

                    m_selectedItem.find(".firstword").text($(div).text());
                    m_selectedItem.find(".secondword").text($(div).text());
                    m_selectedItem.find(".thirdword").text($(div).text());
                }
                EndEdit(m_selectedItem);
                m_selectedItem = null;
                return;
            }

            

            if (sessionStorage.getItem('grouping') == null) {
                //Save the grouping for the first double click, and use this a comparer if the next element is belongs to this group,if not ignore
                sessionStorage.setItem('grouping', $(div).attr('data-elementgrouping'));
            }
            //else {
            //    var grouping = sessionStorage.getItem('grouping');
            //    if (grouping != $(div).attr('data-grouping')) {
            //        alert('You cannot select other sentence than the first selected');
            //        return;
            //    }
            //}

            var grouping = sessionStorage.getItem('grouping');
            if (grouping != undefined && grouping != "undefined") {

                if ($(div).attr('data-isword') == 'false') {
                    if (grouping != $(div).attr('data-elementgrouping')) {
                        GetRandomOrderMessage('line');
                        //alert('You cannot select other tiles from other sentence. Click clear button to reset the selection.');
                        return;
                    }
                }

            }
            //debugger;
            $('#' + id).parent().siblings("img").each(function () {
                sound = $(this).attr("data-sound");
                $('#hdnSoundFile').val(sound);
                return;
            });

            //clone the div for adding to different div.
            var dv1 = div.clone();
            dv1.css("margin-left", "10px");
            dv1.css("width", "");
            if (parent.has('#' + dv1[0].id ).length > 0)
                return;
            //add x button for removal
            //debugger;
            var img = $("<img id='img" + id + "' src='../Images/ico_Delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
           
            var imgedit = $("<img id='img" + id + "' src='../Images/Ico_edit.png' class='addreplaceword' onclick='' />");

            $(img).click(RemoveWord);
            //$(imgedit).click(BeginEdit);
            


            //dv1.append("<img id='img" + id + "' src='../Images/x.png' style='width:10px; height:10px; float:right;' onclick=\"RemoveWord('img" + id + "');\" />");
            // as per franks request
            
            //remove sa per franks request
            //dv1.append(img);
            dv1.append(imgedit);
            //remove the double click
            dv1.removeAttr("ondblclick");
            parent.append(dv1);
            //update the word count
            //var count = $('#lblWordCount').text();
            //count = parseInt(count) + 1;
            //$('#lblWordCount').text(count.toString());
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
          
            //if (m_selectedItem == null)
            InitializedContextMenu(imgedit[0].id);
        }
        function BeginEdit(e) {
            
            if (m_selectedItem == null) {
                //$(this).parent().siblings().css("border", "");
                $(this).parent().siblings().css("border", "1px solid black");
                $(this).parent().css("border", "2px solid red");
                m_selectedItem = $(this).parent();
                m_shouldstoppropacation = true;
                InitializedContextMenu();
                //$('.addreplaceword').contextMenu('menu');
                //OpenContextMenu();
            }
            else {
                
                EndEdit(m_selectedItem);
                //$('.addreplaceword').contextMenu('destroy');
            }
        }

        function EndEdit(el) {
            //$(this).parent().siblings().css("border", "");
            $(el).css("border", "1px solid black");
            //$(this).parent().css("border", "2px solid red");
            //m_selectedItem = $(this).parent();
            m_selectedItem = null;
            $('.sContainer .screenshot').css("background-color", "white");
            CloseContextMenu();
        }

        function RemoveWord(e) {
            
            e.stopImmediatePropagation();
            var x = $(this).parent();
            var parent = x.parent();
            x.remove();
            //var count = $('#lblWordCount').text();
            //count = parseInt(count) - 1;
            //$('#lblWordCount').text(count.toString());

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

        //function xx() {
            
        //    //$('.screenshot').tooltip({ content: "<img src=\"$('.screenshot').attr('data-image')\" />" });
        //}

        function worddblClick(id) {
            var sound = $('#' + id).attr('data-sound');
            $.playSound(sound);
        }

        function playsound(sounds) {
            //$.playSound('../content/sound/' + sounds);
            var s = new buzz.sound('../content/sound/' + sounds);
            //$('.soundicon').attr('src', '../images/waves.gif');
            //s.bind("ended", function (e) {
            //    $('.soundicon').attr('src', '../images/sound.png');
            //});
            s.load();
            s.play();
            
            //var sound = sounds.toString().split(',')
            //for (i in sound) {
            //    if (sound[i] == '')
            //        continue;

            //    if (sound[i].toLowerCase().indexOf('content') != -1)
            //        $.playSound(sound[i]);
            //    else
            //        $.playSound('../content/sound/' + sound[i]);
            //}
        }

        function playsoundnow(el,sounds) {
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

            //var sound = sounds.toString().split(',')
            //for (i in sound) {
            //    if (sound[i] == '')
            //        continue;

            //    if (sound[i].toLowerCase().indexOf('content') != -1)
            //        $.playSound(sound[i]);
            //    else
            //        $.playSound('../content/sound/' + sound[i]);
            //}
        }

        function playsoundsend(sounds) {
            //$.playSound('../content/sound/' + sounds);
            if (sounds == '')
                return;
            var s = new buzz.sound('../content/sound/' + sounds);
            s.load();
            s.play();
        }


        function ClearSelectedSentence() {
            var parent = $('#<%=divSentence.ClientID %>');
            parent.empty();
            //$('#lblWordCount').text("0");

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

        $(function () {
            $('.logo').attr("src", "../images/p_talk1.png");
            $('.logo').attr("width", "179px");
            $('.logo').attr("height", "40px");

         

            //InitializePopOver();
            //InitializedContextMenu();
            $("#mtabs").tabs().addClass('ui-tabs-vertical ui-helper-clearfix');
            $("#mtabs li").removeClass('ui-corner-top').addClass('ui-corner-right');


            //ShowTranlation();
            //$(".switch6").switchbutton();

            //$("#chkLanguageOrder")
            //    .switchbutton({
            //        checkedLabel: 'ENG',
            //        uncheckedLabel: 'JP'
            //    });
            //$(".ui-switchbutton-enabled").text("test"); //placeholder for localization :) ayos..
            $("#chkShowTranslation").change(function () {
                //ShowTranlation();
            });

            $('#<%=chkSequence.ClientID%>').change(function () {
                
                HideShowSequence(this)
                //if ($(this).prop("checked")) {
                //    $('.imgsequence').show();
                //}
                //else {
                //    $('.imgsequence').hide();
                //}
            });

            $('#<%=chkNative.ClientID%>').change(function () {
              
                HideShowWords(this, '.firstword');
                //if ($(this).prop("checked")) {
                //    $('.secondword').show();
                //}
                //else {
                //    $('.secondword').hide();
                //}
            });

            $("#chkSecondary").change(function () {
                
                HideShowWords(this, '.thirdword');
                //if ($(this).prop("checked")) {
                //    $('.thirdword').show();
                //}
                //else {
                //    $('.thirdword').hide();
                //}
            });

            $(".chkLanguageOrder").change(function () {
                
                SwitchLanguageOrder(this);
            });
            $(".chkSubLanguage2").change(function () {
                SwitchWords(this);
            });

            //---Start Chat

            chat = $.connection.chatHub;
           

            chat.client.OnlineStatus = function (connectionid, userList) {
                //alert("online :" +  connectionid);
            }

            chat.client.joined = function (connectionid, userList) {
                //debugger;
                $.each(userList, function (index, value) {
                    var el = $(".divUsers[data-userid='" + value + "']");
                    if (el) {
                        var span = $(el).find("#spanstatus");
                        if (span) {
                            $(span).val("Online");
                            var img = $(span).find('img');
                            if (img) {
                                $(img).attr("src", "../Images/online.png");
                            }
                        }
                    }

                        //$(el).children("#spanstatus").attr("src", "../Images/online.png");
                });
            }

            chat.client.onUserDisconnected = function (connectionid, userid) {
                //debugger;
                    var el = $(".divUsers[data-userid='" + userid + "']");
                    if (el) {
                        var span = $(el).find("#spanstatus");
                        if (span) {
                            $(span).val("Offline");
                            var img = $(span).find('img');
                            if (img) {
                                $(img).attr("src", "../Images/Offline.png");
                            }
                        }
                    }

                    //$(el).children("#spanstatus").attr("src", "../Images/online.png");
                
            }

            chat.client.addMessage = function (usermailid, to, from, message, groupname) {
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
                        interval = setInterval(function () {
                            $(el).toggleClass("newMessage");
                        }, 1000);
                        
                    }
                    if (from == $('#hdnCurrentUserID').val()) {
                        writeToOwnWindow(to, from, message);
                    }
                    return;
                }

                var messages = message.split('|');
                var cl = "you";
                var clstate = "old";
                var avatar = $('#hdnCurrentAvatar').val()
                if (to == $('#hdnCurrentUserID').val()) {
                    cl = "me";
                    clstate = "new";
                    avatar = $('#hdnSelectedAvatar').val()
                }
                var str='<tr id="trMessage">'
                str = str + '<td style="vertical-align:top;">'
                if (cl == "me") 
                    str = str + '<img class="imgAvatarYou" id="imgAvatarYou" style="width: 65px; height: 65px;" src="'+ avatar +'">'
                
                str=str + '</td>'
                str=str + '<td class="tblMessage_conv">'
                str=str + '<div style="width:100%;text-align:center;">'
                str=str + '<span id="msgDate" style="width:100%;text-align:center;"></span>'
                str=str + '</div>'
                str=str + '<div class="tblMessage_conversation">'
                str = str + '<span class="bubble ' +  cl + ' ' + clstate + '" id="msg_conversation" style="word-wrap:break-word; width:40%;">' + messages[0];
                str=str + '</span>'
                str = str + '<span class="bubble1" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;">' + messages[2];
                if (cl == "me") {
                    str = str + '<input title="Report this Problem Message" class="imgReport" id="imgReport" onclick="ConfirmReport(this); return false;" type="image" src="../Images/block.png" data-usermailid="' + usermailid + '">'
                    str = str + '<input title="Click this if you like the message!" class="imgLikeMessage" id="imgLikeMessage" onclick="return false;" type="image" src="../Images/default_star.png" data-swap="../Images/like_star.png" data-usermailid="' + usermailid + '">'
                }
                str=str + '</span>'
                str=str + '</div>'
                str=str + '</td>'
                str = str + '<td style="vertical-align:top;">'
                if (cl == "you")
                    str = str + '<img id="imgAvatarMe" class="imgAvatarMe" src="' + avatar + '" style="height:65px;width:65px;">'
                str=str + '</td>'
                str = str + '</tr>'
                $('#tblMessage tr:last').after(str);

                $('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);
                $('#hdnSoundFile').val('');
            }

            chat.client.sendToMailBox = function (to, from, message) {
                writeToOwnWindow(to, from, message);
                
            }


            chat.client.NotifyUser = function (from,message) {
                //debugger;
                var messages = message.split('|');
                var cl = "you";
                var avatar = $('#hdnCurrentAvatar').val()
                if (to == $('#hdnCurrentUserID').val()) {
                    cl = "me";
                    avatar = $('#hdnSelectedAvatar').val()
                }
                var str = '<tr id="trMessage">'
                str = str + '<td style="vertical-align:top;">'
                if (cl == "me")
                    str = str + '<img class="imgAvatarYou" id="imgAvatarYou" style="width: 65px; height: 65px;" src="' + avatar + '">'

                $('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);
                $('#hdnSoundFile').val('');

                alert("User is not online, this message will be sent to mailbox.");

            }


            chat.client.setChatGroup = function (groupname) {
                $('#hdnGroupName').val(groupname);
            }
            $.connection.hub.logging = true;
            $.connection.hub.start(function () {
                chat.server.getAllOnlineStatus();
                var el = $('.divUsers');
                if (el.length > 0)
                    SelectUser($(el)[0]);
            });

            //---End Chat

        });


        function writeToOwnWindow(to, from, message) {
            var messages = message.split('|');
            var cl = "you";
            var avatar = $('#hdnCurrentAvatar').val()
            if (to == $('#hdnCurrentUserID').val()) {
                cl = "me";
                avatar = $('#hdnSelectedAvatar').val()
            }
            var str = '<tr id="trMessage">'
            str = str + '<td style="vertical-align:top;">'
            if (cl == "me")
                str = str + '<img class="imgAvatarYou" id="imgAvatarYou" style="width: 65px; height: 65px;" src="' + avatar + '">'

            str = str + '</td>'
            str = str + '<td class="tblMessage_conv">'
            str = str + '<div style="width:100%;text-align:center;">'
            str = str + '<span id="msgDate" style="width:100%;text-align:center;">6/18/2015</span>'
            str = str + '</div>'
            str = str + '<div class="tblMessage_conversation">'
            str = str + '<span class="bubble ' + cl + ' old" id="msg_conversation" style="word-wrap:break-word; width:40%;">' + messages[0];
            str = str + '</span>'
            str = str + '<span class="bubble1" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;">' + messages[2];
            str = str + '</span>'
            str = str + '</div>'
            str = str + '</td>'
            str = str + '<td style="vertical-align:top;">'
            if (cl == "you")
                str = str + '<img id="imgAvatarMe" class="imgAvatarMe" src="' + avatar + '" style="height:65px;width:65px;">'
            str = str + '</td>'
            str = str + '</tr>'
            $('#tblMessage tr:last').after(str);

            $('#divMessage').scrollTop($('#divMessage')[0].scrollHeight);
            $('#hdnSoundFile').val('');

            //alert("User is not online, this message will be sent to mailbox.");
                
        }
        function LikeMessage(el) {
            //debugger;
            var img = $(el);
            var json = { Type: 'likemessage', usermailid: $(el).attr("data-usermailid") };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)

                if (obj.Status == "True") {
                    var current = img.attr('src');
                    var swap = img.attr('data-swap');
                    img.attr("src", swap).attr("data-swap", current);
                }
                else
                    alert('Error updating your status. Please check your network or internet.');
            });

        }

        function SelectUser(el) {
            clearInterval(interval);
            $(el).addClass("selected");
            $(el).removeClass("newMessage");
            $(el).siblings().removeClass("selected");
            $(el).addClass("selected");
            var button = $('#<%=btnGetUserMessage.ClientID%>');
            $('#<%=hdnSelectedUserID.ClientID%>').val($(el).attr("data-userid"));
            $('#<%=hdnName.ClientID%>').val($(el).attr("data-firstname"));
            $('#hdnSelectedAvatar').val($(el).attr("data-avatar"));
            $('hdnGroupName').val('');

            chat.server.createGroup($('#hdnCurrentUserID').val(), $('#hdnSelectedUserID').val());
            
              $(button).trigger('click');

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
            if (shouldValidate == "true") {
                if (!ValidateSentence()) {
                    //alert('Wrong order try again..');
                    GetRandomOrderMessage('order');
                    return false;
                }
            }

            var sentence1 = "";
            var sentence2 = "";
            var sounds = "";
            if ($('#<%=divSentence.ClientID %>').children('div').length == 0) {
                alert("No Sentence to Add");
                return;
            }

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
                    if (sessionStorage.getItem('sentence1Ordinal') != null)
                        ordinals = sessionStorage.getItem('sentence1Ordinal').toString().split(',');

                    if (shouldValidate == "true") {
                        //TODO: add data ordinal to the emoji or for the tile coming from words palette.
                        //$('#<%=divSentence.ClientID %>').children('div').each(function () {
                //$(this).children('span.firstword').each(function () {
                //  $(this).show();
                //sentence1 += $(this)[0].outerHTML + "&nbsp;";
                //});
                //});
                var array = new Array();
                var index = 0;
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

                $('#<%=divSentence.ClientID %>').children('div').each(function () {
                    $(this).children('span.firstword').each(function () {
                        $(this).show();

                        //sentence1 += $(this)[0].outerHTML + "&nbsp;";
                        var s = $(this)[0].outerHTML + "&nbsp;";
                        //if (array.indexOf(s) == -1)
                        if (IsArrayContains(array, $(this)[0].id) == -1)
                            array.splice(index, 0, s);
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



            $('#divFinalLearningMessage').append('<div>' + sentence2  + '</div>');
            $('#divFinalNativeMessage').append('<div>' + sentence1  + '</div>');

            GetFinalMessage();

            $('#divFinalLearningMessage').empty();
            $('#divFinalNativeMessage').empty();
            playsoundsend($('#hdnSoundFile').val());
            

                    //$('#tblMessage1').append('<tr style="width:10px;">' + sentence1 + '</tr>')
                    //$('#tblMessage2').append('<tr>' + sentence2 + '</tr>')
            sentence1 = "";
            sentence2 = "";
            sound = "";
            ClearSelectedSentence();



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
            if ($(obj).prop("checked")) {
                $('.firstword').each(function () {
                    var ordinal = $(this).attr('data-ordinal');
                    $(this).parent().children('.imgsequence').each(function () {
                        //if (lang == "en-US")
                            //$(this).attr('src', '../Images/red' + ordinal + '.png');
                        //else
                            $(this).attr('src', '../Images/orderedList' + ordinal + '.png');

                    });
                });
            }
            else {
                $('.secondword').each(function () {
                    var ordinal = $(this).attr('data-ordinal');
                    $(this).parent().children('.imgsequence').each(function () {
                        //if (lang == "en-US")
                        //    $(this).attr('src', '../Images/orderedList' + ordinal + '.png')
                        //else
                            $(this).attr('src', '../Images/red' + ordinal + '.png')
                            

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


        function HideShowWords(obj, cls) {
            
            if ($(obj).prop("checked")) {
                $(cls).show();
            }
            else {
                $(cls).attr("z-index", "-1000");
                $(cls).hide();
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
        
        $(function () {

            $('.sortable').sortable({ axis: 'x', tolerance: 'pointer', refreshPositions: true }).disableSelection();
        });

        function InitializeFreeMessage() {

            var translations = {};
            translations["Ok"] = $('#lblOk').text();
            translations["Cancel"] = $('#lblCancel').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Ok"]] = function () {
                AddFreeMessage();
                $('#txtFreeMessage1').val('');
                $('#txtFreeMessage2').val('');
                $(this).dialog("close");
            }
            buttonsOpts[translations["Cancel"]] = function () {
                $(this).dialog("close");
            }

            $("#divFreeMessage").dialog({
                autoOpen: false,
                height: 300,
                width: 500,
                modal: true,
                buttons: buttonsOpts
            });


        }

        function InitializeAddChangeWord()
        {
            var translations = {};
            translations["Ok"] = $('#lblOk').text();
            translations["Cancel"] = $('#lblCancel').text();
            var buttonsOpts = {};
            buttonsOpts[translations["Ok"]] = function () {
                AddFreeFormWordOnSelectedPallete();
                $('#native').val('');
                $('#learning').val('');
                $('#sub').val('');
                $(this).dialog("close");
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
                buttons: buttonsOpts,
                close: function (event, ui) { EndEdit(m_selectedItem); }
            });
        }

     

        function AddFreeFormWordOnSelectedPallete() {
            var isedit = false;
            if (m_selectedItem != null)
                isedit = true;

            var parent = $('#<%=divSentence.ClientID %>');
            if (isedit) {
                m_selectedItem.find(".firstword").val($('#native').val());
                m_selectedItem.find(".secondword").val($('#learning').val());
                m_selectedItem.find(".thirdword").val($('#sub').val());

                m_selectedItem.find(".firstword").text($('#native').val());
                m_selectedItem.find(".secondword").text($('#learning').val());
                m_selectedItem.find(".thirdword").text($('#sub').val());
                
                m_selectedItem.find(".firstword").attr("data-word", "");
                m_selectedItem.find(".firstword").attr("data-switchword", "");
                m_selectedItem.find(".secondword").attr("data-word", "");
                m_selectedItem.find(".secondword").attr("data-switchword", "");

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
                var words = span1 + span2 + span3;
                number = 1000 + Math.floor(Math.random() * 2000) + 3;
                var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px;position:relative;\" >" + "{1}" + "</div>").stringformat(number, words);

                //div.css("margin-left", "10px");
                //div.css("width", "");
                var divelement = $(div);
                //add x button for removal
                var id = number.toString()
                var img = $("<img id='img" + id + "' src='../Images/ico_Delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
                $(img).click(RemoveWord)

                divelement.append(img);
                parent.append(divelement);
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
            var words = span1 + span2;
            number = 1000 + Math.floor(Math.random() * 2000) + 3;
            var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px;position:relative;\" >" + "{1}" + "</div>").stringformat(number, words);

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

              //number = 100 + Math.floor(Math.random() * 1000) + 1;
              //var span3 = "<span id='{0}' class='fakewords' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"

              var words = span1 + span2
              number = 1000 + Math.floor(Math.random() * 2000) + 3;
              var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px; position:relative; {2}\" >" + "{1}" + "</div>").stringformat(number, words);

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

        function ReplacePunctuation(el, type) {


            var parent = $('#<%=divSentence.ClientID %>');
            var number = 100 + Math.floor(Math.random() * 1000);
            var span1 = "<span id='{0}' class='firstword' {1}>".stringformat("divspanword" + number.toString(), type) + el + "</span>" + "<br/>"
            number = 100 + Math.floor(Math.random() * 1000) + 1;
            var span2 = "<span id='{0}' class='secondword' {1} style='display:none;' >".stringformat("divspanword" + number.toString(), type) + el + "</span>" + "<br/>"

             //number = 100 + Math.floor(Math.random() * 1000) + 1;
             //var span3 = "<span id='{0}' class='fakewords' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"

            var words = span1 + span2
            number = 1000 + Math.floor(Math.random() * 2000) + 3;
            var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px; position:relative; {2}\" >" + "{1}" + "</div>").stringformat(number, words);

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

        function ShowTranlation(){
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
            if (m_selectedItem == null)
                return;

            InitializeAddChangeWord();
            $("#dialog-form").dialog("open");
        }
        function FreeMessage() {
            InitializeFreeMessage();
            $("#divFreeMessage").dialog("open");
        }

        function AppendCircleButton() {
            if ($(".pallete").has("#addallWords").length == 0)
                $(".pallete").prepend("<img id='addallWords' class='addallwords' onclick=' AddAllWords(this);' src='/images/up.png' style='float:left; width:24px;height:24px;padding-left:1px;padding-right:1px;cursor:pointer'/>");
        }
        $(function () {

            $("#txtFreeMessage1").attr("placeholder", $('#hdnFreeTextMessage1PlaceHolder').val());
            $("#txtFreeMessage2").attr("placeholder", $('#hdnFreeTextMessage2PlaceHolder').val());
            AppendCircleButton();
            
            var isSafari = !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/);
            
            if (isSafari)
                $("#txtSearchSentence").addClear({ right: 25 });
            else
                $("#txtSearchSentence").addClear();


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
                         open: function(event, ui)
                         {
                            // $(this).closest(".ui-dialog")
                            //.find(".ui-dialog-titlebar-close")
                            //.removeClass("ui-dialog-titlebar-close")
                            //.html("<span class='ui-button-icon-primary ui-icon ui-icon-closethick'></span>");
                             //$('#tabs').tabs({ active: 0 });
                         },
                         close: function (event, ui) {
                             //$(this).empty().dialog('destroy');
                         }
                     }
                     );
                 });
            });
            $('#imgPunctuation').click(function () {
                SetupPopOver();
            });
        });

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
            if( m_selectedItem != null )
                wordClick($(el)[0].id, false);
            else
                AddEmojiPunctuationSticker($(el).find('span')[0].outerHTML, "data-ispunctuation='true'");
            ClosePopOver();

            
        }

        function GetFinalMessage() {
            
            //var sentencecount = $('#lblWordCount').text();
            //if (sessionStorage.getItem('shouldCountNumberOfSentence') == null) {
            //    if (parseInt(sentencecount) < 3) {
            //        GetRandomOrderMessage('limit');
            //        return false;
            //    }
            //}
            //$('#btnSend').prop("disabled", true);
            ////$('#btnSend').attr('disabled', 'disabled');
            var sentence = "";
            $("#divFinalLearningMessage").children("div").each(function () {
                $(this).children("span").each(function () {
                    var s = $(this)[0].outerHTML;
                    var obj = $(s);
                    if ($(obj).is("[data-image]")) {
                        s = s.replace(/span/g, "a");
                        obj = $(s);
                        $(obj).attr("href", $(obj).attr("data-image"));
                        $(obj).addClass("gallery");
                        $(obj).attr("onclick","ShowPicture();");

                    }
                    
                    sentence += $(obj)[0].outerHTML + '&nbsp;';
                    //if ($(this)[0].innerHTML.indexOf('img') > -1)
                    //    sentence += $(this)[0].innerHTML + '&nbsp;';
                    //else
                    //    sentence += $(this).text() + '&nbsp;';
                });

                
                $(this).children("input").each(function () {
                    sentence += $(this).val();
                });
                //sentence = $(this)[0].innerHTML;
                $('#<%=hdnLearning.ClientID%>').val($('#<%=hdnLearning.ClientID%>').val() + sentence + "|");
                sentence = "";

            });
            

            $("#divFinalNativeMessage").children("div").each(function () {
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

                    sentence += $(obj)[0].outerHTML + '&nbsp;';
                    //if ($(this)[0].innerHTML.indexOf('img') > -1)
                    //    sentence += $(this)[0].innerHTML + '&nbsp;';
                    //else
                    //    sentence += $(this).text() + '&nbsp;';
                });

                $(this).children("input").each(function () {
                    sentence += $(this).val();
                });

                //if ($(this).find("#finalmessagefreeform2").length > 0) {
                //    sentence += $(this).find("#finalmessagefreeform2").val();
                //}

                $('#<%=hdnNative.ClientID%>').val($('#<%=hdnNative.ClientID%>').val() + sentence + "|");

                sentence = "";
                
                chat.server.send($('#hdnSelectedUserID').val(), $('#hdnCurrentUserID').val(), $('#<%=hdnNative.ClientID%>').val(), $('#<%=hdnLearning.ClientID%>').val(), $('#hdnGroupName').val());
                $('#<%=hdnNative.ClientID%>').val('');
                $('#<%=hdnLearning.ClientID%>').val('');
                
            });

            //if (sessionStorage.getItem('shouldCountNumberOfSentence') != null)
                //sessionStorage.removeItem('shouldCountNumberOfSentence');
            //$('#btnSendDummy').click();
            return true;
        }

        function SetPalleteSelectable() {
            //$(".items").selectable();
            //$(".items").selectable({
            //    selected: function (event, ui) {
            //        $(event.target).find('.ui-selectee.ui-selecting').not(ui.selecting).removeClass('ui-selecting');
            //        $(event.target).find('.ui-selectee.ui-selected').not(ui.selecting).removeClass('ui-selected');
            //        $(event.target).addClass("selected").siblings().removeClass("selected");
            //    }
                
            //});
        }


        function ShowPicture(e) {
            //debugger;
            //alert('showpicture');
            $("a.gallery").colorbox();
            m_shouldstoppropacation = true;
            //e.stopImmediatePropagation();
            //var x = e.isImmediatePropagationStopped() ;
            //alert(x);

            return false;
        }

        function ActivateSentencePaging(page, totalpage) {


            var option = "";
            var numofpages = 10;
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
                onPageClick: function (pageNumber, event) {

                    $('#hdnsentencepage').val(pageNumber);
                    $('#btnSearchSentence').click();
                }

            });

        }

        function ActivateWordPaging(page, totalpage) {
            var option = "";
            var numofpages = 2;
            if (totalpage == 0)
                numofpages = 0;

            if (totalpage == 0) {
                $('#hdnwordpage').val("1");
                $('#wordPaging').empty();
                return;
            }


            $('#wordPaging').pagination({
                displayLastPages: false,
                items: totalpage,
                currentPage: page,
                displayedPages: numofpages,
                cssStyle: 'compact-theme',
                prevText: "<",
                nextText: ">",
                edges:1,
                onPageClick: function (pageNumber, event) {

                    $('#hdnwordpage').val(pageNumber);
                    $('#btnSearchWord').click();
                }

            });
        }

        function UseSuggestion() {
            $('#<%=divSuggestion.ClientID%>').find(".suggestion").each(function () {
                wordClick($(this)[0].id, true);
            });
            return false;
        }

        function AddAllWords(el) {
            var sound = "";
            $(el).siblings("ul").find("li").each(function () {
                wordClick($(this).find('div')[0].id, true);
            });
            $(el).siblings("ul").find("img").each(function () {
                sound = $(this).attr("data-sound");
                $('#hdnSoundFile').val(sound);
            });

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
                $(ddl).val("0");
            }
            
        }
      


    </script>
    <div id="divModalMessage" style="display:none;" >
        <span id="spanMessage"></span>
    </div>
    <div id="confirmDialog" title="&nbsp;" style="display:none;">
        <asp:Label ID="lblDialogMessage" runat="server" Text=""  meta:resourcekey="lblDialogMessageResource1"></asp:Label><br />
    </div>
    <div style="width:100%;">
        <asp:HiddenField ID="hdnSoundFile" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnPunctuation" runat="server" ClientIDMode="Static" meta:resourcekey="hdnPunctuationResource1"/>
        <asp:HiddenField ID="hdnSelectFromPalete" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSelectFromPaleteResource1" />
        <asp:HiddenField ID="hdnReplaceWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnReplaceWordResource1"/>
        <asp:HiddenField ID="hdnCreateNewWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCreateNewWordResource1"/>

        <asp:HiddenField ID="hdnwordpage" runat="server" Value="1" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnsentencepage" runat="server" Value="1" ClientIDMode="Static"  />
        <asp:HiddenField ID="hdnLearning" runat="server" />
        <asp:HiddenField ID="hdnNative" runat="server" />
        <asp:HiddenField ID="hdnGroupName" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnNativeLanguageCode" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnLearningLanguageCode" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnFreeTextMessage1PlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeTextMessage1PlaceHolderResource1"/>
        <asp:HiddenField ID="hdnFreeTextMessage2PlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeTextMessage2PlaceHolderResource1"/>
        <asp:HiddenField ID="HiddenField2" runat="server" ClientIDMode="Static" />
        <asp:Label ID="lblReturn" runat="server" meta:resourcekey="hdnReturnResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:Label ID="lblOk" runat="server" meta:resourcekey="hdnlblOkResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:Label ID="lblCancel" runat="server" meta:resourcekey="hdnlblCancelResource1" ClientIDMode="Static" style="display:none;"/>

        <div id="dialog-form" title="&nbsp;" style="display:none;">
            <asp:Label ID="lblDialogNativeLanguage" runat="server" Text="Native Language"  meta:resourcekey="lblDialogNativeLanguageResource1"></asp:Label><br />
            <input type="text" name="native" id="native" class="text ui-widget-content ui-corner-all" /><br />
            <asp:Label ID="lblDialogLearningLanguage" runat="server" Text="Learning Language"  meta:resourcekey="lblDialogLearningLanguageResource1"></asp:Label><br />
            <input type="text" name="learning" id="learning" value="" class="text ui-widget-content ui-corner-all" /><br />
            <asp:Label ID="lblDialogSubLanguage" runat="server" style="display:none;" Text="Sub Language"  meta:resourcekey="lblDialogSubLanguageResource1"></asp:Label><br />
            <input type="text" name="sub" id="sub" value="" style="display:none;" class="text ui-widget-content ui-corner-all" /><br />
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
        <div id="divFreeMessage" style="display:none;">
          <fieldset>
            <legend>
                <asp:Label ID="lblFreeMessage" runat="server" Text="Free Message" meta:resourcekey="lblFreeMessageResource1"></asp:Label></legend>
              <table style="width:100%;">
                  <tr>
                      <td>
                          <textarea id="txtFreeMessage1" class="text ui-widget-content ui-corner-all" style="width:98%;height:100px;" cols="1" rows="10" ></textarea>
                      </td>
                      <td>
                          <textarea id="txtFreeMessage2" class="text ui-widget-content ui-corner-all" style="width:98%;height:100px" cols="1" rows="10"  ></textarea>
                      </td>
                  </tr>
              </table>
          </fieldset>
        </div>   
                <asp:HiddenField ID="hdnSelectedUserID" runat="server" ClientIDMode="Static" Value="0" />
                <asp:HiddenField ID="hdnCurrentUserID" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnCurrentAvatar" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnSelectedAvatar" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnName" runat="server" ClientIDMode="Static" />
                <div class="sendmsg_top_container" id="sendmsg_top_container" >
                    <asp:UpdatePanel ID="updFriends" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div id="divFinalLearningMessage" class="divFinalLearningMessage" style="height:80px; overflow:auto;border: 1px solid #d3d2d2;width:99.5%; word-wrap:break-word;display:none;" ></div>
                            <div id="divFinalNativeMessage" class="divFinalLearningMessage" style="display:none; height:80px;overflow:auto;border: 1px solid #d3d2d2; word-wrap:break-word;" data-invisible="false"></div>
                            <div class="mailbox_frnd_container" id="allfriends">
                                <asp:Repeater ID="rptFriends" runat="server">
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div id="divUsers" class="divUsers" role="button" onclick="SelectUser(this);" data-userid="<%# Eval("UserID") %>" data-firstname="<%# Eval("FirstName") %>" data-avatar="<%# Eval("Avatar") %>">
                                            <div class="divUser_avatar" id="divUser_avatar">
                                                <img src='<%# Eval("Avatar") %>' style="width:55px;height:55px;">
                                            </div>
                                            <div class="divUser_avatar_info" id="divUser_avatar_info">
                                                <span class="divUser_Avatar_Name" id="divUser_Avatar_Name"><%# Eval("FirstName") %></span><br/>
                                                <span class="divUser_Avatar_Name" id="divUser_Avatar_Other_Info"><%# Eval("UserName") %></span><br />
                                                <span class="divUser_Avatar_Name" id="Span1" style="word-wrap:break-word;width:100px;display:block"><%# Eval("Address") %></span>
                                                <span class="divUser_Avatar_Name" id="spanstatus"><img src='<%# Eval("StatusImage") %>'/><%# Eval("OnlineStatusText") %></span>
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
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
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
                                            <tr runat="server" id="trMessage">
                                                <td style="vertical-align:top;">
                                                    <asp:Image ID="imgAvatarYou" CssClass="imgAvatarYou" runat="server" Width="65px" Height="65px" meta:resourcekey="imgAvatarYouResource1"/>
                                                </td>
                                                <td class="tblMessage_conv">
                                                    <div style="width:100%;text-align:center;">
                                                        <span style="width:100%;text-align:center;"><%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %></span>
                                                    </div>
                                                    <div class="tblMessage_conversation">
                                                        <span class="<%# Eval("CssClass") %>" id="msg_conversation" style="word-wrap:break-word; width:40%;"><%# Server.HtmlDecode(Eval("NativeLanguageMessage").ToString() )%>
                                                        </span>
                                                   <%-- </div>
                                                    <div class="tblMessage_conv_eng">--%>
                                                        <span class="bubble1" style="word-wrap:break-word; background-color:#ccffff; border:#ccffff !important; width:40%;"><%# Server.HtmlDecode( Eval("LearningLanguageMessage").ToString() )%>
                                                            <asp:ImageButton ID="imgReport" CssClass="imgReport" ClientIDMode="Static" runat="server" data-usermailid='<%# Eval("UserMailID") %>' meta:resourcekey="imgReportResource1" ImageUrl="~/Images/block.png" style="" ToolTip="Report this Problem Message" Visible='<%# Convert.ToBoolean(Eval("IsReply")) ? false : true%>' OnClientClick="ConfirmReport(this); return false;"/>
                                                            <asp:ImageButton ID="imgLikeMessage" CssClass="imgLikeMessage" ClientIDMode="Static" runat="server" data-usermailid='<%# Eval("UserMailID") %>' meta:resourcekey="imgLikeMessageResource1" ImageUrl="../Images/default_star.png" data-swap="../Images/like_star.png" style="" ToolTip="Click this if you like the message!" Visible='<%# Convert.ToBoolean(Eval("IsReply")) ? false : true%>' OnClientClick="LikeMessage(this);return false;"/>
                                                            </span>
                                                    </div>
                                                </td>
                                                <td style="vertical-align:top;">
                                                    <asp:Image ID="imgAvatarMe" CssClass="imgAvatarMe" runat="server" Width="65px" Height="65px" meta:resourcekey="imgAvatarMeResource1"/>
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
                </div>
            <div class="smc_top_container" id="smc_top_container">
                <div class="smctc_msgbox" id="smctc_msgbox">
                    <asp:Label ID="lblSentence" CssClass="smctc_lbl" runat="server" Text="Create Sentence to Add" AssociatedControlID="divSentence" meta:resourcekey="lblSentenceResource1" ></asp:Label>
                    <div id="divSentence" class="sortable" runat="server"></div>
                    
                    <asp:Label ID="lblInstruction" Visible="false" CssClass="smctc-instructions" runat="server" Text=""  meta:resourcekey="lblInstructionResource1" ></asp:Label>
                </div>
                <div class="smctc_msgbox_btn" id="smctc_msgbox_btn">
                    <div class="smctc_msgbox_btnaddclear_container">
                        <asp:Button CssClass="smctc_msgbox_btnaddclear_container_lbl" ID="btnAdd" style="background-image:url('../Images/sendchat.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left;" Height="48px" BorderStyle="None" Width="58px" Text="" runat="server" ClientIDMode="Static" OnClientClick="Add(); return false;" />
                    </div>
                    <div class="smctc_msgbox_btnaddclear_container" style="margin-top:-20px;">
                        <asp:Button CssClass="smctc_msgbox_btnaddclear_container_lbl" ID="btnClear" style="background-image:url('../Images/deletechat.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left;" Height="48px" BorderStyle="None" Width="58px" Text="" runat="server" OnClientClick="return ClearSelectedSentence();"/>
                    </div>
                </div>
            </div>
     <div class="sendmsg_bottom_container" id="sendmsg_bottom_container" >
        <div id="divDisplaySuggestion" class="suggestionContainer" runat="server" style="width:100%; float:left; color:white; font-weight:bold;cursor:pointer;vertical-align:middle;line-height:30px;" onclick="return UseSuggestion();" title="Click to use Today's Topic">
            <asp:Label ID="lblTopic" CssClass="snd-todays-topic"  runat="server" Text="Today's Topic: " meta:resourcekey="lblTopicResource1"></asp:Label>
        </div>
        <div id="divSuggestion" runat="server" style=" float:left; height:100px; width:100%;display:none;">
        </div>
    </div>
        
        <div class="sendmsg_middle_container" id="sendmsg_middle_container">
            <div id="mtabs">
                    <ul class="tabs_links_menu">
                        <li><asp:HyperLink CssClass="send-msg-tabs1" ID="linkTabWords" href="#mtab1" runat="server" Text="Words" meta:resourcekey="linkTabWordsResource1"/></li>
                        <li><asp:HyperLink CssClass="send-msg-tabs2" ID="linkTabOptions" href="#mtab2" runat="server" Text="Options" meta:resourcekey="linkTabOptionsResource1" /></li>
                    </ul>
            <div id="mtab1">
                <div class="smc_middle_container" id="smc_middle_container">
                    
                    <div  class="smc_word_container" id="smc_word_container">
                        <asp:Label ID="lblLabelWordPaging" runat="server" Text="Word palette" meta:resourcekey="lblLabelWordPagingResource1" style="float:left;line-height:24px;width:100%;padding-bottom:12px;text-align:center;font-weight:bold;" ></asp:Label>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
                            <ContentTemplate>
                                <div id="divWordContainer" runat="server" class="sContainer">
                            
                                </div>
                                <div>
                                    
                                    <div id="wordPaging" style="height:25px;border:1px solid buttonface;width:120%;float:left;" title="Page"></div>
                                </div>
                                <asp:Button ID="btnSearchWord" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchWord_Click" meta:resourcekey="btnSearchWordResource1"/>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="imgSearchSentence" EventName="click" />
                                <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            <div class="smc_bottom_container" id="smc_bottom_container">
                <div class="smc_criteria_container" id="smc_criteria_container">
                    <div class="smc_search_container" id="smc_search_container">
                        <asp:Label ID="lblSentences" CssClass="smcsc_search_lbl" runat="server" Text="Palette Search" meta:resourcekey="lblSentencesResource1" style="display:none;"></asp:Label>
                        <asp:Label ID="lblLabelSentencePaging" runat="server" Text="Phrase palette" meta:resourcekey="lblLabelSentencePagingResource1" style="float:left;line-height:24px;margin-right:5px;font-weight:bold;"></asp:Label>
                        <div style="float:left;">
                            <asp:RadioButtonList ID="rdoCriteriaList" CssClass="rdoCriteriaList" runat="server" ClientIDMode="Static" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Phrase+Word" Value="0" Selected="True" meta:resourcekey="rdoPhraseWordResource1"></asp:ListItem>
                                <asp:ListItem Text="Word" Value="1" meta:resourcekey="rdoWordResource1"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>                        
                        <div class="smc_search_container_search_box_txt">
                            <asp:TextBox ID="txtSearchSentence" CssClass="smcsc_search_txt clearable" runat="server" BorderColor="Transparent" meta:resourcekey="txtSearchSentenceResource1" ClientIDMode="Static"></asp:TextBox>
                            <asp:ImageButton ID="imgClearSearch" CssClass="smcsc_search_x" ImageUrl="~/Images/x.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1" style="display:none;"/>
                            <asp:ImageButton ID="imgSearchSentence" CssClass="smcsc_search_img" ImageUrl="~/Images/SearchF.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" OnClick="imgSearchSentence_Click" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1"/>
                        </div>
                        <asp:DropDownList ID="ddlCategory" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" CssClass="smcsc_search_slct" runat="server" meta:resourcekey="ddlCategoryResource1" ClientIDMode="Static"></asp:DropDownList>
                        <img id="imgEmoji"  src="../Images/emoji.png" class="smcsc_search_emoji" />
                        <img id="imgPunctuation"  src="../Images/exclamation.gif" class="smcsc_search_emoji" />
                        <asp:ImageButton ID="imgAddWord" ImageUrl="~/Images/addreplaceword.png" BorderColor="Transparent" BackColor="Transparent" runat="server" AlternateText="Free Form"  OnClientClick="FreeForm(); return false;"  ToolTip="Add/Replace Word" style="float:left;position:relative;top:-10px;display:none;" meta:resourcekey="imgAddWordResource1"   />
                        <asp:Label ID="lblLabelAddEditWord" runat="server" Text="Add/Replace Word" meta:resourcekey="lblLabelAddEditWordResource1" style="font-size:x-small;display:none;"></asp:Label>
                    </div>
                </div>
                <div class="sbc_left_container" id="sbc_left_container">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                            <div id="sentenceContainer" runat="server" class="sContainerb">
                            
                            </div>
                            <div>
                                <div id="sentencePaging" style="height:25px;" title="Page"></div>
                            </div>
                            <asp:Button ID="btnSearchSentence" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchSentence_Click" meta:resourcekey="btnSearchSentenceResource1"/>
                        </ContentTemplate>
                     <Triggers>
                         <asp:AsyncPostBackTrigger ControlID="imgSearchSentence" EventName="click" />
                         <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                     </Triggers>
                    </asp:UpdatePanel>
                </div>

            </div>
            </div>
            <div id="mtab2">
                <div class="sbc_right_container" id="sbc_right_container">
                    <div class="src_frame">
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="lblSequence" runat="server" Text="Sequencence"  meta:resourcekey="lblSequenceResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                    <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSequence" class="switch6" checked="checked" runat="server"/>
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="lblNative" runat="server" Text="Native Language" meta:resourcekey="lblNativeResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkNative" class="switch6" checked="checked"  runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="switch_container" id="divRomanji" runat="server">
                            <div class="sc_lbl">
                                <asp:Label ID="lblRomanji" runat="server" Text="Romanji" meta:resourcekey="lblRomanjiResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSecondary" class="switch6" checked="checked"  />
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
                            <div class="sc_lbl">
                                <asp:Label ID="lblSound" runat="server" Text="Sound" meta:resourcekey="lblSoundResource1"></asp:Label>
                            </div>
                            <div class="sc_conf">
                                <div class="make-switch" data-on="warning" data-off="default">
                                    <input type="checkbox" id="chkSound" class="switch6" checked="checked"  />
                                </div>
                            </div>
                        </div>
                        <div class="switch_container">
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
                    </div>
                </div>
            </div>
            </div>

        </div>
    </div>
         <div class="sendmsg_bottom_container" id="Div2" >
        <div id="div3" class="suggestionContainer" runat="server" style="width:100%;float:left;">
        </div>
    </div>

</asp:Content>
