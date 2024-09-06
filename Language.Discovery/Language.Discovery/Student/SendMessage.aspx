
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SendMessage.aspx.cs" Inherits="Language.Discovery.SendMessage" ValidateRequest="false" EnableEventValidation="false" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <%--thanks to http://findicons.com/icon/69363/circle_orange?id=69415 and http://www.icons-land.com/ --%>
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
	<link href="../App_Themes/Default/simplePagination.css?123456" rel="stylesheet" />
	<script src="../Scripts/buzz.min.js"></script>
	<script src="../Scripts/jquery.ui.position.min.js"></script>
	<script src="../Scripts/contextMenu.min.js"></script>
	<link href="../App_Themes/Default/contextMenu.css" rel="stylesheet" />
	<%--<script src="../Scripts/jquery.ui.touch-punch.min.js"></script>--%>
    <script src="../Scripts/touchpunch.js"></script>
	<link href="../App_Themes/Default/bootstrap.min.css" rel="stylesheet" />
	<script src="../Scripts/jquery-clearsearch.js"></script>
	<script src="../Scripts/bootstrap2.3.2.js"></script>
    <%--<script src="../Scripts/tocca.js"></script>--%>
    <%--<script src="../Scripts/jquery.touchSwipe.min.js"></script>--%>
    <link href="../App_Themes/Default/jqueryui_custom/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />
<%--    <link href="../App_Themes/Default/mail.css?31124793df6CF74A398A87A14df06B797A2Bava" rel="stylesheet" type="text/css" media="screen and (min-width : 1024px)"/>
    <link rel="stylesheet" media="only screen and (max-width: 1024px), only screen and (max-device-width: 1024px) " href="../App_Themes/Default/mailTabletLandscape.css?31124jdf7936CFsddff7df4dfgA398A87fgA1406fgBdfd797Akk2Ba" type="text/css" />
    <link rel="stylesheet" media="only screen and (max-width: 1023px), only screen and (max-device-width: 768px) and (orientation:portrait)" href="../App_Themes/Default/mailTabletPortrait.css?311df2fddfgdfgfggfgf36CF74A39jj8Afgf87A1406B797xxssaxxbxxbss" type="text/css" />
    <link rel="stylesheet" media="only screen and (max-width: 896px), only screen and (max-device-width: 896px) orientation: landscape " href="../App_Themes/Default/mailMobileLandscape.css?311247936CF7df4A3fgfgsdf98A87A1406Bdfdfdddd797Akk2Ba" type="text/css" />--%>
    <link href="../App_Themes/Default/mail.css?123dffgf4" rel="stylesheet" type="text/css" media="screen and (min-width : 1024px)"/>
    <link rel="stylesheet" media="(min-width: 768px) and (max-width: 1024px) and (orientation: landscape)" href="../App_Themes/Default/mailTabletLandscape.css?123derefdfdfdfgff4" type="text/css" />
    <link rel="stylesheet" media="(min-width: 768px) and (max-width: 1024px)  and (orientation:portrait)" href="../App_Themes/Default/mailTabletPortrait.css?122f3kdfjddffdfgfdg4" type="text/css" />
    <link rel="stylesheet" media="(min-width: 414px) and (max-width: 896px) and (orientation: landscape)" href="../App_Themes/Default/mailMobileLandscape.css?abdfddffdf34df4" type="text/css" />
    <link rel="stylesheet" media="(min-width: 414px) and (max-width: 896px) and (orientation: portrait)" href="../App_Themes/Default/mailTabletPortrait.css?abddffdf34df4" type="text/css" />
    <link rel="stylesheet" media="(device-width: 412px) and (device-height: 915px) and (orientation:portrait)" href="../App_Themes/Default/mailTabletPortrait.css?abddfdfdf34df4" type="text/css" />
    <link rel="stylesheet" media="(device-width: 412px) and (device-height: 915px) and (orientation:landscape)" href="../App_Themes/Default/mailTabletLandscape.css?abddffdfddff34df4" type="text/css" />


    <%--<link rel="stylesheet" media="only screen and (max-width: 900px), only screen and (max-device-width: 900) and (orientation:portrait)" href="../App_Themes/Default/mailMobilePortrait.css?ddb0c8ce65274234a8638eaa812fc0fe" type="text/css" />--%>

	<style type="text/css">
     .ui-tooltip, .arrow:after {
    /*background: linear-gradient(to bottom, rgba(251,200,67,1) 0%, rgba(248,164,38,1) 100%);*/
    background: #fff4ca;
    border: 2px solid white;
}
	
.ui-tooltip {
    padding: 10px 20px;
    color: black;
    border-radius: 20px;
    font: bold 14px"Helvetica Neue", Sans-Serif;
    text-transform: uppercase;
    box-shadow: 0 0 7px black;
}
		.selectbox
		{
			height:97px;
			width: 191px;
			background-color: #FFF;
			font: 400 12px/18px 'Open Sans' , sans-serif;
			color: #000;
			font-weight: normal;
			border: 1px solid #B8B8B8;
			padding: 5px;
		}
		.hide {
			display:none;
		}
		.rdoCriteriaList {
			margin-top:0px !important;
			position:absolute;
			top:25px;
			width: 150px;
		}
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
            min-height:50px;
			}
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
			margin-left:35px;
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
            /*padding: 0px 5px 0px 5px;*/
		}
		.secondword
		{
			/*margin-right:10px !important;*/
            /*padding: 0px 5px 0px 5px;*/
            padding-right:10px;
		}
		.thirdword
		{
			/*margin-right:10px !important;*/
            padding: 0px 5px 0px 5px;
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
		/*border: 1px solid gray;*/
		}
		.items li {
            min-height:60px;
			list-style: none;
			float: left;
            padding: 1px 1px 1px 1px;
			/*height: auto;
			padding: 1px 1px 1px 1px;
			margin:0;
			overflow: visible;*/
			
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
	.ui-tabs-vertical { width: 99%; }
	/*.ui-tabs-vertical > .ui-tabs-nav { padding: .2em .2em 14em .1em; 
									 float: right; 
									 width: 4em;
									 width: 1.7em !important; 
									 background-color:transparent; }*/
	/*.ui-tabs-vertical > .ui-widget-header
	{
		background-image: url('');
		color:transparent;  
		border-top-color: silver;
		border-left-color: silver;
		border-right-color: transparent;
		border-bottom-color: silver;
		height:100%;

	}*/
	/*.ui-tabs-vertical > .ui-tabs-nav li { clear: left; 
										width: 100%;
										width: 30px !important;
										height:90px !important; 
										border-bottom-width: 1px !important; 
										border-left-width: 0 !important; 

	}*/
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
	/*.ui-tabs-vertical > .ui-tabs-nav li a { display: block;

	}
	.ui-tabs-vertical > .ui-tabs-nav li.ui-tabs-selected { padding-bottom: 0; 
			 											 padding-left: .1em; 
														 border-right-width: 1px; 
														 margin-left: -2px; }
	.ui-tabs-vertical > .ui-tabs-panel { padding: 1em;width: 51em;}*/


    #palettetabs{
        margin-top:30px;
    }
  /*----End Vertical Tab----*/

    /*#txtSearchSentence:-ms-input-placeholder {
       font-size: 10px !important;
    }

    #txtSearchSentence::-webkit-input-placeholder {
       font-size: 10px !important;
    }

    #txtSearchSentence:-moz-placeholder {
          font-size: 10px !important;
    }
    #txtSearchSentence::-moz-placeholder { 
          font-size: 10px !important;
    }*/

    .lblOptionExplanation
    {
        font-size:small;
        margin-top:10px;
        display:inline-block;
    }
    .column1
    {
        width:88%;
        float:left;
    }
    .editcontainer{
         float:right;
         width:10%;
     }
   .palette:after {
        
        display: table;
        clear: both;
    }
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
        var _currentTab = 0;
		window.mobilecheck = function () {
			var check = false;
			(function (a, b) { if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipad|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) check = true })(navigator.userAgent || navigator.vendor || window.opera);
			return check;
        }
		var m_addEmojiPunctuationSticker = false;
		var m_selectedItem = null;
		var m_shouldstoppropacation = false;
		var m_labelSentence;
		var m_phrasecount = 0;
        function isIOS() {
            return (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 0) || navigator.platform === 'iPad' || (navigator.maxTouchPoints && navigator.maxTouchPoints > 2)
        }

		function InitializeTabs()
		{
		    $('#palettetabs').tabs({
		        //activate: function (event, ui) { //bind click event to link
		        //    if (ui.newTab.index() == 2) {
		        //        $('#imgAddRemoveToVIP').attr("src", "/Images/removetovip.png");
		        //        $('#hdnAddRemoveVipUserState').val("remove");
		        //        $('#imgAddRemoveToVIP').unbind().click(GetFlaggedUsers());

		        //    }
		        //    else {
		        //        $('#imgAddRemoveToVIP').attr("src", "/Images/addtovip.png");
		        //        $('#hdnAddRemoveVipUserState').val("add");
		        //        $('#imgAddRemoveToVIP').unbind().click(GetFlaggedUsers());

		        //    }

		        //    $("#hdnSelectedTab").val(ui.newTab.index());
		        //}
		    });
		}

		function Translate(sl, tl, word, target) {
		    if(word.trim().length == 0)
		        return;

		    var translatedtext = "";
            $('#imgTranslating').show();
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
	            }
	            else
	                alert('Error translating word(s). Please check your network or internet.');
	        });

	    }

		function IsArrayContains(a, regex){
			for(var i = 0; i < a.length; i++) {
				if(a[i].search(regex) > -1){
					return i;
				}
			}
			return -1;
		}
		var $otherlanguages = null;
        function Add() {
            
			var shouldValidate = sessionStorage.getItem('shouldValidate');
			if ( shouldValidate== "true") {
				if (!ValidateSentence()) {
					//alert('Wrong order try again..');
					GetRandomOrderMessage('order');
					return false;
				}
			}

			var r1 = $('#divFinalLearningMessage').find(".forEdit").parent();
			var r2 = $('#divFinalNativeMessage').find(".forEdit").parent();

			var palettecount = $('#lblWordCount').text();
		    palettecount = parseInt(palettecount);
		    if (palettecount == 15 && (r1 && r1.length == 0)) {
		        $("#divMaxPalette").dialog({
		            modal: true,
		            buttons: {
		                Ok: function () {
		                    $(this).dialog("close");
		                }
		            }
		        });
		        return false;
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
			
		    RemoveFinalSentencePlaceHolder();

            $('#<%=divSentence.ClientID %>').children('div').each(function () {
                var firstsound;
                var secondsound;
                var first = $(this).find(".firstword");
                var second = $(this).find(".secondword");
                if($(first))
                {
                    firstsound = $(first).attr("data-sound");
                    secondsound = $(second).attr("data-sound");
                    $(first).attr("data-sound", (secondsound == undefined) ? "" : secondsound);
                    $(second).attr("data-sound", (firstsound == undefined) ? "" : firstsound);
                }
			});

			$('#<%=divSentence.ClientID %>').children('div').each(function () {

			    $(this).children('span.secondword').each(function () {
					$(this).show();
					$(this).css('visibility', 'visible');
					var s = $(this)[0];
					sounds += $(s).attr('data-sound') + ",";

					sentence2 += s.outerHTML + "&nbsp;";
			    });

			});

		 
		  
			
			var ordinals = '';
			if(sessionStorage.getItem('sentence1Ordinal') != null)
				ordinals = sessionStorage.getItem('sentence1Ordinal').toString().split(',');
			
			if (shouldValidate == "true" || shouldValidate == "trueforemoji")
			{
				//TODO: add data ordinal to the emoji or for the tile coming from words palette.
				//$('#<%=divSentence.ClientID %>').children('div').each(function () {
					//$(this).children('span.firstword').each(function () {
					  //  $(this).show();
						//sentence1 += $(this)[0].outerHTML + "&nbsp;";
					//});
				//});
				var array = new Array();
				var otherwordarray = new Array();
				var index = 0;
				for (i in ordinals) {
					if ($('#<%=divSentence.ClientID %>').find("span.firstword[data-ordinal='" + ordinals[i] + "']").length ||
						$('#<%=divSentence.ClientID %>').find("span.firstword.img").length) {
						
						var s = $('#<%=divSentence.ClientID %>').find("span.firstword[data-ordinal='" + ordinals[i] + "']")[0].outerHTML + "&nbsp;";
						
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
						
						//sentence1 += $(this)[0].outerHTML + "&nbsp;";
						var s = $(this)[0].outerHTML + "&nbsp;";
						//if (array.indexOf(s) == -1)
						if (IsArrayContains(array,$(this)[0].id) == -1)
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
			else
			{
				$('#<%=divSentence.ClientID %>').children('div').each(function () {
					$(this).children('span.firstword').each(function () {
						$(this).show();
						sentence1 += $(this)[0].outerHTML + "&nbsp;";
					});
				});
			}
			//update the word count
			var count = $('#lblWordCount').text();
			count = parseInt(count) + 1;
			m_phrasecount = m_phrasecount + 1;
			//$('#lblWordCount').text(count.toString());
			

			
			var soundimage = "<img src=\"../Images/new/ICO_MailSpeaker.png\" style=\"width:1px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"playsoundnow(this,'" + sounds + "');\" />";
			var removemes = "<img class='imgRemoveMessage{0}' src=\"../Images/x.png\" style=\"width:16px; height:16px; position:absolute;right:0px;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
			var editmes = "<img class='imgEditMessage{0}' src=\"../Images/pencil.png\" style=\"width:16px; height:16px; position:absolute;right:16px;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"EditMessage(this);\" />";
			//var freeform1 = '<input type="text" id="finalmessagefreeform1" style="font-size:smaller;"/>'
		    //var freeform2 = '<input type="text" id="finalmessagefreeform2" style="font-size:smaller;"/>'
			
			 if ($otherlanguages == null)
				$otherlanguages = $('#divFinalLearningMessage').clone();
			
			//$('#divFinalLearningMessage').append('<div>' + sentence2 + soundimage  +  removemes.stringformat(count.toString()) + '</div>');
		    //$('#divFinalNativeMessage').append('<div>' + sentence1 + soundimage + removemes.stringformat(count.toString()) + '</div>');
			 var uid = uuidv4();
			 if (r1 && r2 && r1.length > 0 && r2.length > 0) {
			     $(r1).replaceWith("<div style='position:relative;' class='palette'><div class='column1'>" + sentence2 + "</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>");
			     $(r2).replaceWith("<div style='position:relative;' class='palette'><div class='column1'>" + sentence1 + "</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>", r2);
			 }
			 else {
			     $('#divFinalLearningMessage').append("<div style='position:relative;' class='palette'><div class='column1'>" + sentence2 +"</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>");
			     $('#divFinalNativeMessage').append("<div style='position:relative;' class='palette'><div class='column1'>" + sentence1 +"</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>");
			     $otherlanguages.append('<div>' + sentence3 + '</div>');
			     UpdateSentenceCount(true);
			 }

			//$('#tblMessage1').append('<tr style="width:10px;">' + sentence1 + '</tr>')
			//$('#tblMessage2').append('<tr>' + sentence2 + '</tr>')
			sentence1 = "";
			sentence2 = "";
			sound = "";
			ClearSelectedSentence();
			
			if (!m_addEmojiPunctuationSticker) {
			    $('html, body').animate({ scrollTop: '0px' }, 800);
			}
			m_addEmojiPunctuationSticker = false;

			//$('#divFinalLearningMessage').animate({ scrollTop: $('#divFinalLearningMessage')[0].scrollHeight }, 800);
			//$('#divFinalNativeMessage').animate({ scrollTop: $('#divFinalNativeMessage')[0].scrollHeight }, 800);

			return true;
        }

         function AddEmojiToTemporaryContainer() {
			var r1 = $('#divFinalLearningMessage').find(".forEdit").parent();
			var r2 = $('#divFinalNativeMessage').find(".forEdit").parent();

			var palettecount = $('#lblWordCount').text();
		    palettecount = parseInt(palettecount);
		    if (palettecount == 15 && (r1 && r1.length == 0)) {
		        $("#divMaxPalette").dialog({
		            modal: true,
		            buttons: {
		                Ok: function () {
		                    $(this).dialog("close");
		                }
		            }
		        });
		        return false;
		    }
			var sentence1 = "";
			var sentence2 = "";
			var sentence3 = "";
			var sounds = "";

			$('#divEmojiEditContainer').children('div').each(function () {

			    $(this).children('span.secondword').each(function () {
					$(this).show();
					$(this).css('visibility', 'visible');
					var s = $(this)[0];
					sentence2 += s.outerHTML + "&nbsp;";
			    });

			});
			
			var ordinals = '';
			if(sessionStorage.getItem('sentence1Ordinal') != null)
				ordinals = sessionStorage.getItem('sentence1Ordinal').toString().split(',');

				var array = new Array();
				var otherwordarray = new Array();
				var index = 0;
				for (i in ordinals) {
					if ($('#divEmojiEditContainer').find("span.firstword[data-ordinal='" + ordinals[i] + "']").length ||
						$('#divEmojiEditContainer').find("span.firstword.img").length) {
						
						var s = $('#divEmojiEditContainer').find("span.firstword[data-ordinal='" + ordinals[i] + "']")[0].outerHTML + "&nbsp;";
						
						array[index] = s;
						index++;
					}
				}
                index = 0;
				for (i in ordinals) {
					if ($('#divEmojiEditContainer').find("span.otherword[data-ordinal='" + ordinals[i] + "']").length ||
						   $('#divEmojiEditContainer').find("span.otherword.img").length) {

							var s = $('#divEmojiEditContainer').find("span.otherword[data-ordinal='" + ordinals[i] + "']")[0].outerHTML + "&nbsp;";
							//sentence1 += s ;
							otherwordarray[index] = s;
							index++;
						}
					}
					index = 0;
					//debugger;

				$('#divEmojiEditContainer').children('div').each(function () {
					$(this).children('span.firstword').each(function () {
						$(this).show();
						
						//sentence1 += $(this)[0].outerHTML + "&nbsp;";
						var s = $(this)[0].outerHTML + "&nbsp;";
						//if (array.indexOf(s) == -1)
						if (IsArrayContains(array,$(this)[0].id) == -1)
							array.splice(index, 0, s);
						index++;
					});
				});
				
				index = 0;
				$('#divEmojiEditContainer').children('div').each(function () {
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

			
			//update the word count
			var count = $('#lblWordCount').text();
			count = parseInt(count) + 1;
			m_phrasecount = m_phrasecount + 1;
			//$('#lblWordCount').text(count.toString());
			

			
			var soundimage = "<img src=\"../Images/new/ICO_MailSpeaker.png\" style=\"width:1px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"playsoundnow(this,'" + sounds + "');\" />";
			var removemes = "<img class='imgRemoveMessage{0}' src=\"../Images/x.png\" style=\"width:16px; height:16px; position:absolute;right:0px;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
			var editmes = "<img class='imgEditMessage{0}' src=\"../Images/pencil.png\" style=\"width:16px; height:16px; position:absolute;right:16px;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"EditMessage(this);\" />";
			
			 if ($otherlanguages == null)
				$otherlanguages = $('#divFinalLearningMessage').clone();
			
			 var uid = uuidv4();
			 if (r1 && r2 && r1.length > 0 && r2.length > 0) {
			     $(r1).replaceWith("<div style='position:relative;' class='palette'><div class='column1'>" + sentence2 + "</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>");
			     $(r2).replaceWith("<div style='position:relative;' class='palette'><div class='column1'>" + sentence1 + "</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>", r2);
			 }
			 else {
			     $('#divFinalLearningMessage').append("<div style='position:relative;' class='palette'><div class='column1'>" + sentence2 +"</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>");
			     $('#divFinalNativeMessage').append("<div style='position:relative;' class='palette'><div class='column1'>" + sentence1 +"</div><div class='editcontainer'>" + removemes.stringformat(uid) + editmes.stringformat(uid) + "</div></div>");
			     $otherlanguages.append('<div>' + sentence3 + '</div>');
			     UpdateSentenceCount(true);
			 }

			//$('#tblMessage1').append('<tr style="width:10px;">' + sentence1 + '</tr>')
			//$('#tblMessage2').append('<tr>' + sentence2 + '</tr>')
			sentence1 = "";
			sentence2 = "";
			sound = "";
			
			//if (!m_addEmojiPunctuationSticker) {
			//    $('html, body').animate({ scrollTop: '0px' }, 800);
			//}
			//m_addEmojiPunctuationSticker = false;

			//$('#divFinalLearningMessage').animate({ scrollTop: $('#divFinalLearningMessage')[0].scrollHeight }, 800);
   //          $('#divFinalNativeMessage').animate({ scrollTop: $('#divFinalNativeMessage')[0].scrollHeight }, 800);
             $('#divEmojiEditContainer').empty();
			return true;
		}

	    function uuidv4() {
	        //return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c => (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16))
	        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
	            var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
	            return v.toString(16);
	        });

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
			if (count == 0)
				AddFinalSentencePlaceHolder();
		}

		  
		function AddFreeMessage() {
		    var palettecount = $('#lblWordCount').text();
		    palettecount = parseInt(palettecount);
		    if (palettecount == 15) {
		        $("#divMaxPalette").dialog({
		            modal: true,
		            buttons: {
		                Ok: function () {
		                    $(this).dialog("close");
		                }
		            }
		        });
		        return false;
		    }

            var r1 = $('#divFinalLearningMessage').find(".forEdit").parent();
            var r2 = $('#divFinalNativeMessage').find(".forEdit").parent();

			RemoveFinalSentencePlaceHolder();
			var span1 = "<span data-isfreemessage='1'>{0}</span>".stringformat($("#txtFreeMessage1").val());
            var span2 = "<span data-isfreemessage='1'>{0}</span>".stringformat($("#txtFreeMessage2").val());
			var removemes1 = "<img class='imgRemoveMessage{0}' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
			var removemes2 = "<img class='imgRemoveMessage{0}' src=\"../Images/x.png\" style=\"width:16px; height:16px; float:right;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"RemoveSingleMessage(this);\" />";
            var editmes = "<img class='imgEditMessage{0}' src=\"../Images/pencil.png\" style=\"width:16px; height:16px; position:absolute;right:16px;vertical-align:middle;cursor:pointer;float:right;\" onclick=\"EditMessage(this);\" />";

			$("#hdnFreeMessage1").val( $("#hdnFreeMessage1").val() + "|" + $("#txtFreeMessage1").val());
            $("#hdnFreeMessage2").val($("#hdnFreeMessage2").val() + "|" + $("#txtFreeMessage2").val());
            var uuid = uuidv4();
            if (r1 && r2 && r1.length > 0 && r2.length > 0) {
                $(r1).replaceWith("<div style='position:relative;' class='palette'><div class='column1'>" + span1 + "</div><div class='editcontainer'>" + removemes1.stringformat(uuid) + editmes.stringformat(uuid) + "</div></div>");
                $(r2).replaceWith("<div style='position:relative;' class='palette'><div class='column1'>" + span2 + "</div><div class='editcontainer'>" + removemes1.stringformat(uuid) + editmes.stringformat(uuid) + "</div></div>", r2);
            }
            else {
                $('#divFinalLearningMessage').append('<div style="position:relative;" class="palette"><div class="column1">' + span1 + '</div><div class="editcontainer">' + removemes1.stringformat(uuid) + editmes.stringformat(uuid) + '</div></div>');
                $('#divFinalNativeMessage').append('<div style="position:relative;" class="palette"><div class="column1">' + span2 + '</div><div class="editcontainer">' + removemes2.stringformat(uuid) + editmes.stringformat(uuid) + '</div></div>');

                if ($otherlanguages == null)
                    $otherlanguages = $('#divFinalLearningMessage').clone();

                $otherlanguages.append('<div style="position:relative;" class="palette"><div class="column1">' + span1 + '</div><div class="editcontainer">' + removemes1 + editmes.stringformat(uuid) + '</div></div>');
                UpdateSentenceCount(true);
            }
			
		    //sessionStorage.setItem('shouldCountNumberOfSentence', 'false');

			//$('#divFinalLearningMessage').animate({ scrollTop: $('#divFinalLearningMessage')[0].scrollHeight }, 800);
			//$('#divFinalNativeMessage').animate({ scrollTop: $('#divFinalNativeMessage')[0].scrollHeight }, 800);

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
			
            $('.sContainerb').popover({
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
            $('.sContainerb').popover('hide');
		}

		function SetupPopOver() {
            InitializePopOver();
            editLastMessage();
            $('.sContainerb').popover('show');
			$(".popover").draggable();
			//$('html, body').animate({ scrollTop: $('body').height() }, 800);
        }

        function editLastMessage() {
            if (!$('#divFinalNativeMessage').children('.palette').children('.column1').hasClass('forEdit')) {
                $('#divFinalNativeMessage').children('.palette').last().children('.column1').addClass('forEdit');
                $('#divFinalLearningMessage').children('.palette').last().children('.column1').addClass('forEdit');
            }
        }
		function replaceWordBackground(elementid)
        {
            if (elementid == "" || elementid == null || m_selectedItem == null)
                return;
		    $('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");
            $('#' + elementid).siblings().css("border", "1px solid black");
            $('#' + elementid).css("background-color", "rgb(252, 234, 187)");
		    $('#' + elementid).css("border", "2px solid red");
		}
        function InitializeReplaceWordSettings(id) {
		    if (m_selectedItem != null) {
		        EndEdit(m_selectedItem);
		        return;
		    }
            var elementid = $('#' + id);//.parent()[0].id;
            if (!$(elementid).hasClass("replaceable")) {
                return
            }
		    //$('#' + elementid).siblings().css("border", "1px solid black");
		    //$('#' + elementid).css("border", "2px solid red");
		    m_selectedItem = $(elementid);//.parent();
		    //m_shouldstoppropacation = true;
		    $('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");
		    //$('#mtabs').tabs("option", "active", 1);
            $("#hdnWordToReplaceId").val(id);
            $("#hdnPrepareWordReplaceElementID").val(id);
		    $("#hdnWordType").val($(elementid).attr("data-wordtype"));
		    //$("#btnAddWord").show();
		    $("hdnWordPage").val("1");
            $("#btnSearchWord").click();
		}

        function PrepareReplaceWordSettings(id) {
            //var elementid = id;
            //$('#' + elementid).siblings().css("border", "1px solid #2DE2E5");
            //$('#' + elementid).css("border", "2px solid red");
            //m_selectedItem = $('#' + elementid);//.parent();
            ////m_shouldstoppropacation = true;
            //$('.sContainer .screenshot').css("background-color", "rgb(252, 234, 187)");

            //$("#btnAddWord").show();
            $('html, body').animate({
                scrollTop: $(
                    'html, body').get(0).scrollHeight
            }, 800);
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
					 //if (m_selectedItem == null) {
						 //$(this).parent().siblings().css("border", "");
						 $('#' + id).parent().siblings().css("border", "1px solid black");
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
				$('#' + id).contextMenu(menu);
			}
			else {
				$('#' + id).contextMenu(menu);
			}
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
			$('#' + id).contextMenu(menu);
		}

		function sleep(milliseconds) {
			var start = new Date().getTime();
			for (var i = 0; i < 1e7; i++) {
				if ((new Date().getTime() - start) > milliseconds) {
					break;
				}
			}
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
        
		function wordPlaysound(id)
		{
            worddblClick(id);
            InitializeReplaceWordSettings(id);
		}
		var hasAddedWord = false;
		function wordClick(id, validate, playsound) {
            var isSoundPlayed = false;
		    RemoveSentencePlaceHolder();
            if ((playsound == true && m_selectedItem == null) || playsound == true) {
                m_shouldstoppropacation = false;
                worddblClick(id);
                isSoundPlayed = true;
            }
			if (hasAddedWord)
			    return;

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
							m_selectedItem.prepend(a);
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
					var secondsound = $(div).find(".secondword").attr("data-sound");
					var othersound = $(div).find(".otherword").attr("data-sound");

					m_selectedItem.find(".firstword").attr("data-sound", firstsound == undefined ? "" : $(div).find(".firstword").attr("data-sound"));
					m_selectedItem.find(".secondword").attr("data-sound",secondsound == undefined ? "" : $(div).find(".secondword").attr("data-sound"));
                    m_selectedItem.find(".otherword").attr("data-sound", othersound == undefined ? "" : $(div).find(".otherword").attr("data-sound"));
                    if(!isSoundPlayed)
					    worddblClick(id);
				}
				else {//punctuation
					
					//m_selectedItem.attr("data-ispunctuation", "true");
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
                $('#mtabs').tabs("option", "active", 0);
                $('html, body').animate({ scrollTop: '0px' }, 800);
				return;
			}

			
            isSoundPlayed = false;
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
			//clone the div for adding to different div.
			var dv1 = div.clone();
			
			dv1.css("margin-left", "10px");
			$(dv1).attr("id", $(dv1).attr("id") + "z");
			$(dv1).attr("onclick", "wordPlaysound('" + $(dv1).attr("id") + "');");
			
			//dv1.css("width", "");
			if (parent.has('#' + dv1[0].id ).length > 0)
				return;
			//add x button for removal
			//debugger;
			var img = $("<img id='img" + id + "' src='../Images/ico_Delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
		   
			var imgedit = $("<img id='imgedit" + id + "' src='../Images/swapoutline.png' class='addreplaceword' onclick='InitializeReplaceWordSettings(this);' />");

			$(img).click(RemoveWord);
			//$(imgedit).click(BeginEdit);
			


			//dv1.append("<img id='img" + id + "' src='../Images/x.png' style='width:10px; height:10px; float:right;' onclick=\"RemoveWord('img" + id + "');\" />");
			// as per franks request
			
			//remove sa per franks request
			if(!validate)
			    dv1.append(img);
			
			if ($(div).attr("data-wordtype") && $(div).attr("data-wordtype").length > 0)
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
			hasAddedWord = !validate;
			
			//highlight
			if (validate) {
				$(div).parents(":eq(2)").siblings().css("background-color", "white");
				$(div).parents(":eq(2)").css("background-color", "rgba(252, 234, 187, 1)");
			}
			//if (m_selectedItem == null)
			$(imgedit).on("click", function (e) {
				e.stopPropagation();
			});

            
		    if($(parent).find(".soundicon").length == 0)
		    {
		        var icon = $('#'+id).parents().siblings(".soundicon");
		        if(icon.length > 0)
		        {
		            icon = icon.clone();
		            icon.removeAttr("onclick");
		            icon.click(function() {
		                PlaySequentialSoundsOnly(this);
		            });
		        }
		        parent.append(icon);
		    }

			//$('html, body').animate({ scrollTop: $('body').height() }, 800);
			//InitializedContextMenu(imgedit[0].id);
		}
		function BeginEdit(e) {
		    if (m_selectedItem == null) {
		        
				//$(this).parent().siblings().css("border", "");
				$(this).parent().siblings().css("border", "1px solid black");
                $(this).parent().css("border", "2px solid white");
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
			//$(el).css("border", "1px solid black");
			//$(this).parent().css("border", "2px solid red");
			//m_selectedItem = $(this).parent();
            if (el != null)
                $(el).css("border", "2px solid #faa732");
            else
                return
			m_selectedItem = null;
            $('.sContainer .screenshot').css("background-color", "white");
            $(el).css("background-color", "white");
            //if (_currentTab != 3) {
            //    $("#btnAddWord").hide();
            //}
            $("#hdnPrepareWordReplaceElementID").val("");
			$("#hdnWordType").val("");
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
			hasAddedWord = false;
			sessionStorage.setItem('shouldValidate', true);
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
            //$.playSound(sound);
            if (sound.trim() != "") {
                var s = new buzz.sound(sound);
                s.load();
                s.play();
            }
		}

		function playsound(sounds) {
			var s = new buzz.sound('../content/sound/' + sounds);
			s.load();
			s.play();
		}

		function playsoundnow(el,sounds) {
			//$.playSound('../content/sound/' + sounds);
			var s = new buzz.sound('../content/sound/' + sounds);
			
			s.bind("playing", function (e) {
				$(el).attr('src', '../images/waves.gif');
			});
			s.bind("error", function (e) {
				$(el).attr('src', '../images/new/ICO_MailSpeaker.png');
			});
			s.bind("ended", function (e) {
				$(el).attr('src', '../images/new/ICO_MailSpeaker.png');
			});
			s.load();
			s.play();
        }

        function PlaySentenceOrIndividualSound(el, sounds) {
            //debugger;
            if ($(el).parent().find("span[data-swapped]").length > 0) {
                //var el2 = $(el).parent().find(".imgsequence").first();
                PlaySequentialSoundsOnly(el);
            }
            else
                playsoundnow(el, sounds)

        }

		function PlaySequentialSoundsOnly(el) {
		    //$("#btnPlaySound").prop("disabled", true);
		    var sounds = [];

		    //siblings("ul").find("li")
		    $(el).siblings('li').each(function () {
                if ($(this).find('div').attr("data-sound") != "" && ($(this).find('div').attr("data-sound") && $(this).find('div').attr("data-sound").indexOf(".mp3") > -1)) {
                    if ($(this).find('div').attr("data-sound").toLowerCase().indexOf("../content/sound/") == -1)
                        sounds.push("../Content/sound/" + $(this).find('div').attr("data-sound"));
		            else
                        sounds.push($(this).find('div').attr("data-sound"));
		        }
		    });
		    
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
		            $(element).on('ended', function() {
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
		                //    $(el).parent().find(".speaker").attr('src', '../images/ICO_MailSpeaker.png');
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

		    }
		}

		
		function RemoveSentencePlaceHolder() {
			var label = $("#lblSentence");
			label.addClass("hide");
			return false;
		}

		function AddSentencePlaceHolder() {
			var label = $("#lblSentence");
			label.removeClass("hide");
			return false;
		  }


		function RemoveFinalSentencePlaceHolder() {
			var label = $("#lblLearning");
			label.addClass("hide");
			return false;
		}

		function AddFinalSentencePlaceHolder() {
			var label = $("#lblLearning");
			label.removeClass("hide");
			return false;
		}


		function ClearSelectedSentence() {
			var parent = $('#<%=divSentence.ClientID %>').find('*').not(".smctc_lbl");
			//parent.empty();
			parent.remove();
			//$('#lblWordCount').text("0");

			//clear the local storage if no object remains in the div
			if (parent.children().length == 0) {
				if (sessionStorage.getItem('sentence1Ordinal') != null)
					sessionStorage.removeItem('sentence1Ordinal');
				if (sessionStorage.getItem('sentence2Ordinal') != null)
					sessionStorage.removeItem('sentence2Ordinal')
			}
			
			sessionStorage.removeItem('shouldValidate');
			sessionStorage.removeItem('grouping');
			hasAddedWord = false;
			AddSentencePlaceHolder();
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
		function InitializeSwipe() {
		    //$(function () {
		        
		     
		    //});
		}
		function Touchmove()
		{
		    //$('.sContainerb').bind('touchmove',
      //          function (e) {
      //              e.preventDefault();
      //          }
      //      );
		}
		function ShowHideSubLanguage2() {
		    SwitchWords($(".chkSubLanguage2"));
		}
        function showFloatButton() {
            $('.floatButtonContainer').show();
        }
        function showMessage() {

            var userid = $('#hdnCurrentUser').val();//$(el).attr("data-usermailid");
            var senderid = $('#lstRecipient option:selected').val();
            if (senderid == undefined) {
                senderid = $('#lstRecipient option:first').val();
            }
            var json = { Type: 'getlastmessagedetailsbyuseridandsenderid', userid: userid, senderid: senderid, isincoming: true};
            $.post("../Handler/MailboxHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data);
                if (obj) {
                    //var date = $.datepicker.formatDate('mm/dd/yy', new Date(parseInt(obj.Message.CreateDate.replace('/Date(', ''))));
                    toastr.clear();
                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "newestOnTop": true,
                        "progressBar": false,
                        "positionClass": "toast-top-left",
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
                        "tapToDismiss": false
                    }
                    var messageTemplate = '<div>{0}</<div><br><hr><div>{1}</<div>';
                    toastr.viewmessage(messageTemplate.stringformat(obj.Message.NativeLanguageMessage.replace(/hasSound/g, ""), obj.Message.LearningLanguageMessage.replace(/hasSound/g, "")), $("#lblViewMessage").text());
                }
            }).error(function (msg) {
                $("<div>Error getting Messages. Please contact administrator.<br\>" + msg + "</div>").dialog({
                    modal: true,
                    buttons: {
                        Ok: function () {
                            $(this).dialog("close");
                        }
                    }
                });
            });
        }

        function findPos(obj) {
            var curtop = 0;
            var offset = 0;
            if (obj.id == "arrowBottom") {
                offset = 70;
            }
            if (obj.offsetParent) {
                do {
                    curtop += obj.offsetTop;
                } while (obj = obj.offsetParent);
                return curtop - 70;
            }
        }
        function attachClickOnWord() {
            
            $(document).off('click', '.wordContainer').on('click' , '.wordContainer', function (e) {
                var elem = $(this).attr("id");
                wordPlaysound(elem);
            });
        }
        $(function () {
            attachClickOnWord();
            $('#lstRecipient').change(function () {
                showMessage();
            });
            $('.floatButtonContainer').click(function () {
                showMessage();
            });
            $('#divTop').click(function () {
                $('html, body').animate({ scrollTop: 0 }, 800);
            });
            $('#divDown').click(function () {
                $('html, body').animate({
                    scrollTop: findPos(document.getElementById("arrowTop"))
                }, 800);
            });
            $('#divUp').click(function () {
                $('html, body').animate({
                    scrollTop: findPos(document.getElementById("arrowTop"))
                }, 800);

            });
            
            
            $("#hdnSelectedUsers").val(sessionStorage.getItem("selectedUser"));
            
		    $("#native").blur(function() {
		        var sl = $("#hdnNativeLanguageCode").val().substr(0,2);
		        var tl = $("#hdnLearningLanguageCode").val().substr(0,2);
                Translate(sl, tl, $("#native").val(), $("#learning"));
                $("#word-ok-button").focus();
            });
            $("#native").keyup(function (e) {
                if (e.keyCode == 13  ) {
                    $("#word-ok-button").focus();
                }
            });
		    //$("#learning").blur(function() {
		    //    var tl = $("#hdnNativeLanguageCode").val().substr(0,2);
		    //    var sl = $("#hdnLearningLanguageCode").val().substr(0,2);
		    //    Transate(sl, tl, $("#learning").val(),$("#native"));
		    //});

			//InitializePopOver();
		    //InitializedContextMenu();
		    //if ($('#hdnNativeLanguageCode').val().indexOf("en") > -1)
		    //    $(".items > .wordContainer").css("min-height", "60px !important");
		    //else
		    //    $(".items > .wordContainer").css("min-height", "43px !important");
		    $('#imgSettings').click(function () {
		        //$('#mtabs').tabs("option", "active", 2);
		        var active = $("#mtabs").tabs("option", "active");
		        if (active != 2)
		            $('#mtabs').tabs("option", "active", 2);
		        else
		            $('#mtabs').tabs("option", "active", 0);

		        return false;
		    });
            $("#mtabs").tabs({
                activate: function (event, ui) {
                    if (ui.newTab.index() != 3) {
                        if (m_selectedItem == null) {
                            //$('#btnAddWord').hide();
                        }
                    }
                    if (ui.newTab.index() == 3) {
                        $('#btnAddWord').show();
                    }
                    _currentTab= ui.newTab.index();
                }
            }).addClass('ui-tabs-vertical ui-helper-clearfix');
            $("#mtabs li").removeClass('ui-corner-top').addClass('ui-corner-right');

            $("#wordtabs").tabs();

			$("#btnAddWord").text($('#hdnAddWord').val());
			InitializeTabs();
            ShowTranlation();

            $("#txtSearchSentence").on('keypress', function (e) {
                
                if (e.which == 13) {
                    //changeActiveTab();
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

			//$(".switch6").switchbutton();
			//InitializeTooltipSteps();
			$(".suggestionContainer").hover(function () {
			    $(".suggestionContainer").attr("title", $("#hdnSuggestedTopic").val());
			});
			//$("#chkLanguageOrder")
			//    .switchbutton({
			//        checkedLabel: 'ENG',
			//        uncheckedLabel: 'JP'
			//    });
		    //$(".ui-switchbutton-enabled").text("test"); //placeholder for localization :) ayos..
			$("#chkShowTranslation").change(function () {
				ShowTranlation();
			});

			$('#<%=chkSequence.ClientID%>').change(function () {
				
			    HideShowSequence(this);
				//if ($(this).prop("checked")) {
				//    $('.imgsequence').show();
				//}
				//else {
				//    $('.imgsequence').hide();
				//}
			});
		    $('#chkTooltip').change(function () {
				EnableDisableTooltip(this)
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
				//var lang = $('#hdnNativeLanguageCode').val();
				//if ($(this).prop("checked")) {
				//    $('.firstword').each(function () {
				//        var ordinal = $(this).attr('data-ordinal');
				//        $(this).parent().children('.imgsequence').each(function () {
				//            if (lang == "en-US") 
				//                $(this).attr('src', '../Images/orderedList' + ordinal + '.png')
				//            else
				//                $(this).attr('src', '../Images/red' + ordinal + '.png')
							
				//        });
				//        //alert($(this).attr('data-ordinal') + $(this).text());
				//    });
				//}
				//else {
				//    $('.secondword').each(function () {
				//        var ordinal = $(this).attr('data-ordinal');
				//        $(this).parent().children('.imgsequence').each(function () {
				//            if (lang == "en-US")
				//                $(this).attr('src', '../Images/red' + ordinal + '.png')
				//            else
				//                $(this).attr('src', '../Images/orderedList' + ordinal + '.png')
								
				//        });
				//        //alert($(this).attr('data-ordinal') + $(this).text());
				//    });
				//}
			});
			$(".chkSubLanguage2").change(function () {
				SwitchWords(this);
            });

			//$("#chkLanguageOrder").change(function () {

			//    var lang = $('#hdnNativeLanguageCode').val();
			//    if ($(this).prop("checked")) {
			//        $('.items').children('.pallete').each(function () {
			//            sortUsingNestedText($(this).first().first().first(), "li", "li.data-ordinalNative");
			//        });
					
			//    }
			//    else {
			//        $('.items').children('.pallete').each(function () {
			//            sortUsingNestedText($(this).first().first().first(), "li", "li.data-ordinalLearning");
			//        });

			//        //sortUsingNestedText($('ul.pallete>ul'), "li", "li.data-ordinalLearning");
			//    }
			//});
			
		});

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
				if (lang == "en-US")
					classname = ".firstword";
				else
					classname = ".secondword";
				$(classname).each(function () {
					var ordinal = $(this).attr('data-ordinal');
					$(this).parent().children('.imgsequence').each(function () {
						$(this).attr('src', '../Images/orderedList' + ordinal + '.png'); 
						if (classname == ".secondword")
							$(this).show();
						else
							$(this).hide();

					});
					//alert($(this).attr('data-ordinal') + $(this).text());
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
							$(this).show();
						else
							$(this).hide();

					});
					//alert($(this).attr('data-ordinal') + $(this).text());
				});
			}
		}

		function HideShowSequence(obj) {
		    if (obj == null)
		    {
		        obj = $('#chkSequence')
		    }
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
		        if ($(cls).length > 0) {
		            $(cls).show();
		            //$(cls).parent().css("height", 60);
		        } 
		        //$('li.pallete').css("height", "");
		        if (cls != ".firstword") {
		            $('li.pallete > ul > li').css("height", "");
		            $('li.pallete > ul > li').css("padding-bottom", "");
		            $('li.pallete > ul > li div').css("height", "");
		        }
		    }
			else {
		        $(cls).attr("z-index", "-1000");
		        if ($(cls).length > 0) {
		            $('li.pallete > ul > li ' + cls ).hide();
		            //$(cls).parent().css("height", 45);
		        }
		        //else
		            //$(".secondword").parent().css("height", 45);

		        //$('.pallete').css("height", 48);
		        if (cls != ".firstword") {
		            $('li.pallete > ul > li').css("height", "45px");
		            $('li.pallete > ul > li').css("padding-bottom", "5px");
		            $('li.pallete > ul > li > div').css("height", "45px");
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
		
		$(function () {
			////$('.sortable').sortable({ tolerance: 'pointer', refreshPositions: true }).disableSelection();
		    $('.sortable').sortable({
		        items: '> div',
                helper: 'clone',
			    placeholder: 'highlight',
			    tolerance: 'pointer',
                cursor: 'move',
				start: function (event, ui) {
					ui.placeholder.height(ui.item.height());
					ui.placeholder.width(ui.item.width());
					ui.item.toggleClass("highlight");
				},
				stop: function (event, ui) {
					ui.item.toggleClass("highlight");
				}
            }).disableSelection();

           
		    ////ClearSelectedSentence();

		  

		    //$(".sortable").disableSelection();

		});
        function activateSortablePalette() {
            $('.sortableLi').sortable({
                items: '> li',
                helper: 'clone',
                placeholder: 'highlight',
                tolerance: 'pointer',
                cursor: 'move',
                start: function (event, ui) {
                    ui.placeholder.height(ui.item.height());
                    ui.placeholder.width(ui.item.width());
                    ui.item.toggleClass("highlight");
                },
                stop: function (event, ui) {
                    ui.item.toggleClass("highlight");
                }
            })//.disableSelection();
        }
		function InitializeFreeMessage() {

			var translations = {};
			translations["Ok"] = $('#lblOk').text();
			translations["Cancel"] = $('#lblCancel').text();
			var buttonsOpts = {};
			buttonsOpts[translations["Ok"]] = function () {
                if ($("#txtFreeMessage1").val().trim().length == 0 || $("#txtFreeMessage2").val().trim().length == 0) {
                    $("#lblFreeMessageInfo").show();
                    return;
                } else {
                    $("#lblFreeMessageInfo").hide();
                }
                var dialog = this;
                checkMessages('freemessage')
                    .then(function () {
                        AddFreeMessage();
                        save(false);
                        $('#txtFreeMessage1').val('');
                        $('#txtFreeMessage2').val('');
                        $('#lblcharleft1').text("150");
                        $('#lblcharleft2').text("150");
                        $(dialog).dialog("close");
                    }).catch(error => {
                        
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
                            "timeOut": "0",
                            "extendedTimeOut": "1000",
                            "showEasing": "swing",
                            "hideEasing": "linear",
                            "showMethod": "fadeIn",
                            "hideMethod": "fadeOut"

                        }

                        toastr.error($('#hdnBadErrorMessage').val(), $('#hdnErrorHeader').val());
                    });

				
			}
			buttonsOpts[translations["Cancel"]] = function () {
				$('#txtFreeMessage1').val('');
				$('#txtFreeMessage2').val('');
				$('#lblcharleft1').text("150");
				$('#lblcharleft2').text("150");
				$("#lblFreeMessageInfo").hide();
				$(this).dialog("close");
			}
			$("#divFreeMessage").dialog({
				autoOpen: false,
				height: 350,
				width: 800,
				modal: true,
				buttons: buttonsOpts
			});
        }

        

		function InitializeAddChangeWord()
		{
			//var translations = {};
			//translations["Ok"] = $('#lblOk').text();
			//translations["Cancel"] = $('#lblCancel').text();
   //         var buttonsOpts = {};
			//buttonsOpts[translations["Ok"]] = function () {
			  
   //             var dialog = this;
   //             checkMessages('word')
   //                 .then(function () {
   //                     AddFreeFormWordOnSelectedPallete();
   //                     SaveUserWords();
   //                     EndEdit(m_selectedItem);
   //                     $(dialog).dialog("close");
   //                 }).catch(error => {
   //                     //toastr.clear();
   //                     toastr.options = {
   //                         "closeButton": true,
   //                         "debug": false,
   //                         "newestOnTop": false,
   //                         "progressBar": true,
   //                         "positionClass": "toast-top-right",
   //                         "preventDuplicates": true,
   //                         "onclick": null,
   //                         "showDuration": "300",
   //                         "hideDuration": "1000",
   //                         "timeOut": "10000",
   //                         "extendedTimeOut": "1000",
   //                         "showEasing": "swing",
   //                         "hideEasing": "linear",
   //                         "showMethod": "fadeIn",
   //                         "hideMethod": "fadeOut"

   //                     }

   //                     toastr.error($('#hdnBadErrorMessage').val(), $('#hdnErrorHeader').val());
   //                 });
				
			//}
			//buttonsOpts[translations["Cancel"]] = function () {
			//	$(this).dialog("close");
			//	EndEdit(m_selectedItem);
   //         }

            var buttons = [{
                id: "word-ok-button",
                text: $('#lblOk').text(),
                click: function() {
                    var dialog = this;
                    checkMessages('word')
                        .then(function () {
                            AddFreeFormWordOnSelectedPallete();
                            SaveUserWords();
                            EndEdit(m_selectedItem);
                            $(dialog).dialog("close");
                        }).catch(error => {
                            //toastr.clear();
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
                     id: "word-cancel-button",
                     text: $('#lblCancel').text(),
                    click: function () {
                        $(this).dialog("close");
                        EndEdit(m_selectedItem);
                    }
                }
            ]

			$("#divFreeformWord").dialog({
			    autoOpen: false,
			    title: $("#hdnFreeformWordTitle").val(),
				height: 320,
				width: 400,
				modal: true,
				buttons: buttons, //buttonsOpts,
				close: function (event, ui) { EndEdit(m_selectedItem); }
			});
		}

	 

		function AddFreeFormWordOnSelectedPallete() {
			var isedit = false;
			if (m_selectedItem != null)
				isedit = true;
			
			var parent = $('#<%=divSentence.ClientID %>');
		    if (isedit) {
		        m_selectedItem.attr("data-sound", "");
		        m_selectedItem.find(".firstword").attr("data-sound", "");
		        m_selectedItem.find(".secondword").attr("data-sound", "");
		        m_selectedItem.find(".otherword").attr("data-sound", "");

                m_selectedItem.find(".firstword").attr("data-swapped", "1");
                m_selectedItem.find(".secondword").attr("data-swapped", "1");
                m_selectedItem.find(".thirdword").attr("data-swapped", "1");
                m_selectedItem.find(".otherword").attr("data-swapped", "1");

				m_selectedItem.find(".firstword").val($('#native').val());
				m_selectedItem.find(".secondword").val($('#learning').val());
				m_selectedItem.find(".thirdword").val($('#sub').val());
				m_selectedItem.find(".otherword").val($('#learning').val());

				m_selectedItem.find(".firstword").text($('#native').val());
				m_selectedItem.find(".secondword").text($('#learning').val());
				m_selectedItem.find(".thirdword").text($('#sub').val());
				m_selectedItem.find(".otherword").text($('#learning').val());
				
				m_selectedItem.find(".firstword").attr("data-word", "");
				m_selectedItem.find(".firstword").attr("data-switchword", "");
				m_selectedItem.find(".secondword").attr("data-word", "");
				m_selectedItem.find(".secondword").attr("data-switchword", "");

				m_selectedItem.find(".otherword").attr("data-word", "");
				m_selectedItem.find(".otherword").attr("data-switchword", "");

				if (m_selectedItem.find(".imgPicture").length != 0) {
					m_selectedItem.find(".imgPicture").parent().siblings(".firstword").removeAttr("data-image");
					m_selectedItem.find(".imgPicture").parent().siblings(".secondword").removeAttr("data-image");
					m_selectedItem.find(".imgPicture").hide();
				}

				EndEdit(m_selectedItem);
				m_selectedItem = null;
			}
			<%--else {
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
			}--%>
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
            //。, ., ？, ?, 。
            var punctuation = ['。', '.', '？', '?', '！', '!', '‼', '!!', '⁉', '!?'];

			var isemoji = type.indexOf("isemoji") >= 0;
			var style = "";
            if (isemoji)
                style = "width:40px;height:27px;"
            else {
                var r1 = $('#divFinalLearningMessage').find(".forEdit").children('span').last();
                var r2 = $('#divFinalNativeMessage').find(".forEdit").children('span').last();
                if (r1 && r1.length) {
                    const regex = /([。|.|？|?|！|!|‼|⁉])$|(!.*?)$|(!.*!)$/gm;
                    const subst = $(el).text();
                    var str1 = $(r1).text();
                    var str2 = $(r2).text();

                    var match = regex.exec(str1);
                    if (match != null) {
                        var result = str1.replace(regex, subst);
                        $(r1).text(result);
                        word = $(r1).attr('data-switchword');
                        if (word != '') {
                            result = word.replace(regex, subst);
                            $(r1).attr('data-switchword', result);
                        }
                        word = $(r1).attr('data-word');
                        if (word != '') {
                            result = word.replace(regex, subst);
                            $(r1).attr('data-word', result);
                        }
                    }
                    else {
                        $(r1).text($(r1).text() + subst);
                        word = $(r1).attr('data-switchword');
                        if (word != '') {
                            $(r1).attr('data-switchword', word + subst);
                        }
                        word = $(r1).attr('data-word');
                        if (word != '') {
                            $(r1).attr('data-word', word + subst);
                        }

                    }
                    match = regex.exec(str2);
                    if (match != null) {
                        var result = str2.replace(regex, subst);
                        $(r2).text(result);
                        word = $(r2).attr('data-switchword');
                        if (word != '') {
                            result = word.replace(regex, subst);
                            $(r2).attr('data-switchword', result);
                        }
                        word = $(r2).attr('data-word');
                        if (word != '') {
                            result = word.replace(regex, subst);
                            $(r2).attr('data-word', result);
                        }
                    }
                    else {
                        $(r2).text($(r2).text() + subst);
                        word = $(r2).attr('data-switchword');
                        if (word != '') {
                            $(r2).attr('data-switchword', word + subst);
                        }
                        word = $(r2).attr('data-word');
                        if (word != '') {
                            $(r2).attr('data-word', word + subst);
                        }
                    }

                    
                    //if (punctuation.includes($(el).text())) {
                    //    var lastChar = $(r1).text().slice(-1);
                    //    if (punctuation.includes(lastChar)) {
                    //        $(r1).text($(r1).text().replace(lastChar, $(el).text()));
                    //    }
                    //    else {
                    //        $(r1).text($(r1).text() + $(el).text());
                    //    }

                    //    var lastChar2 = $(r2).text().slice(-1);
                    //    if (punctuation.includes(lastChar2)) {
                    //        $(r2).text($(r2).text().replace(lastChar2, $(el).text()));
                    //    }
                    //    else {
                    //        $(r2).text($(r2).text() + $(el).text());
                    //    }

                    $('#divFinalLearningMessage').find(".forEdit").removeClass('forEdit');
                    $('#divFinalNativeMessage').find(".forEdit").removeClass('forEdit');
                        
                    //}
                    return false;
                    //else {
                    //    $('#divFinalLearningMessage').find(".forEdit").removeClass('forEdit');
                    //    $('#divFinalNativeMessage').find(".forEdit").removeClass('forEdit');
                    //}
                    //if (punctuation.includes($(el).text())) {
                    //    var lastChar = $(r1).text().slice(-1);
                    //    if (punctuation.includes(lastChar)) {
                    //        $(r1).text($(r1).text().replace(lastChar, $(el).text()));
                    //    }
                    //    else {
                    //        $(r1).text($(r1).text() + $(el).text());
                    //    }

                    //    var lastChar2 = $(r2).text().slice(-1);
                    //    if (punctuation.includes(lastChar2)) {
                    //        $(r2).text($(r2).text().replace(lastChar2, $(el).text()));
                    //    }
                    //    else {
                    //        $(r2).text($(r2).text() + $(el).text());
                    //    }

                    //    $('#divFinalLearningMessage').find(".forEdit").removeClass('forEdit');
                    //    $('#divFinalNativeMessage').find(".forEdit").removeClass('forEdit');
                    //    return false;
                    //}
                    //else {
                    //    $('#divFinalLearningMessage').find(".forEdit").removeClass('forEdit');
                    //    $('#divFinalNativeMessage').find(".forEdit").removeClass('forEdit');
                    //}
                }

            }

            var parent = $(isemoji ? '#divEmojiEditContainer' : '#<%=divSentence.ClientID %>');
			  var number = 100 + Math.floor(Math.random() * 1000);
			  var span1 = "<span id='{0}' class='firstword' {1} style='{2}'>".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"
			  number = 100 + Math.floor(Math.random() * 1000) + 1;
			  var span2 = "<span id='{0}' class='secondword' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"
			  number = 100 + Math.floor(Math.random() * 1000) + 2;
			  var span3 = "<span id='{0}' class='otherword' {1} style='display:none;{2}' >".stringformat("divspanword" + number.toString(), type, style) + el + "</span>" + "<br/>"

            var words = span1 + span2 + span3;
			  number = 1000 + Math.floor(Math.random() * 2000) + 3;
			  var div = ("<div id=\"div{0}\" class=\"screenshot\" style=\"border:1px solid black;text-align:center; display:inline-block;background-color:white;cursor:pointer;margin-left:10px; position:relative; {2}\" >" + "{1}" + "</div>").stringformat(number, words);

			  var divelement = $(div);
			  //add x button for removal
			  var id = number.toString()
			  var img = $("<img id='img" + id + "' src='../Images/ico_delete.png' style='width:15px; height:15px; position:absolute;bottom:-5px;right:-5px;' />");
			  //$(img).click(RemoveWord)

            //var el = $('#<%=divSentence.ClientID %> > div').detach();

			//divelement.append(img);
			parent.append(divelement);
            if (isemoji) {
                //sessionStorage.setItem('shouldValidate', 'trueforemoji');
                //m_addEmojiPunctuationSticker = true;
                AddEmojiToTemporaryContainer();
            }
            return true;
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
			//if (m_selectedItem == null)
			//	return;

			InitializeAddChangeWord();
			$("#divFreeformWord").dialog("open");
		}
		function FreeMessage() {
			InitializeFreeMessage();
			$("#divFreeMessage").dialog("open");
		}
		function ChangeTheIsDropDownChange(v) {
			$('#hdnIsDropDownChangeFromClient').val(v);
		}
		function AppendCircleButton() {
			
			if ($(".pallete").has("#addallWords").length == 0)
				$(".pallete").prepend("<img id='addallWords' class='addallwords' onclick=' AddAllWords(this);' src='/images/addpaletteNew.png' style='float:left; width:24px;height:24px;padding-left:1px;padding-right:1px;cursor:pointer'/>");
		}

		function InitializeTooltipSteps()
		{

		    $('#step1').tooltip({ content: $("#hdnStep1").val(), items: '*' });
		    $("#step2").tooltip({ content: $("#hdnStep2").val(), items: '*' });
		    $("#step3").tooltip({content: $("#hdnStep3").val(), items: '*'});
		    $("#step3b, #step3bb").tooltip({ content: $("#hdnStep3b").val(), items: '*' });
		    $("#step4").tooltip({ content: $("#hdnStep4").val(), items: '*' });
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
		    $("#step3b , #step3bb").tooltip(enable);
		    $("#step4").tooltip(enable);
		    $("#step5").tooltip(enable);

		}

		$(function () {
			var bootstrapButton = $.fn.button.noConflict(); // return $.fn.button to previously assigned value
			$.fn.bootstrapBtn = bootstrapButton;            // give $().bootstrapBtn the Bootstrap functionality
			var jqeBsTooltip = $.fn.tooltip.noConflict();
            $.fn.tlp = jqeBsTooltip;
            var maxLength = 150;
            var charactersLeftText = $('#lblcharleftLabel1').text();
            $('#lblcharleftLabel1').text(charactersLeftText.stringformat(maxLength));
            $('#lblcharleftLabel2').text(charactersLeftText.stringformat(maxLength));


			$('#lstRecipient option:eq(0)').prop('selected', true);

			InitializeDropdownMenuClick();
			$("#txtFreeMessage1").attr("placeholder", $('#hdnFreeTextMessage1PlaceHolder').val());
			$("#txtFreeMessage2").attr("placeholder", $('#hdnFreeTextMessage2PlaceHolder').val());
            
			//var maxLength = 150;
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
			AppendCircleButton();
			//InitializeTooltipSteps();
			var isSafari = !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/);
			
			//if (isSafari)
			//	$("#txtSearchSentence").addClear({ right: 25 });
			//else
            $("#txtSearchSentence").clearable();
            $("#txtSearchWord").clearable();
            $("#txtSearchSentence").attr("placeholder", $('#hdnSearchPlaceHolder').val());
            $("#txtSearchWord").attr("placeholder", $('#hdnSearchWordPlaceHolder').val());

			//$('.addallwords').click(function () {
			//    AddAllWords($(this));
			//});
			
			//$('#imgClearSearch').click(function (e) {
			//    $('#imgSearchSentence').switchClass("smcsc_search_img_x_isvisible", "smcsc_search_img", 0);
			//    $('#imgEmoji').switchClass("smcsc_search_emoji_x_isvisible", "smcsc_search_emoji", 0);
			//    $('#txtSearchSentence').val('');
			//    $('#imgClearSearch').toggle();
			//    e.preventDefault();
			//});

			//$('#txtSearchSentence').on("input", function () {
			//    if ($('#txtSearchSentence').val() != "") {
			//        $('#imgSearchSentence').switchClass("smcsc_search_img", "smcsc_search_img_x_isvisible", 0);
			//        $('#imgEmoji').switchClass("smcsc_search_emoji","smcsc_search_emoji_x_isvisible", 0);
			//        $('#imgClearSearch').show();
			//    }
			//    else {
			//        $('#imgSearchSentence').switchClass("smcsc_search_img_x_isvisible", "smcsc_search_img", 0);
			//        $('#imgEmoji').switchClass("smcsc_search_emoji_x_isvisible", "smcsc_search_emoji", 0);
			//        $('#imgClearSearch').hide();
			//    }
			//});

			$('#imgSearchSentence').click(function () {
				UpdateCategory();
			});
			$('#btnCloseEmoji').click(function (e) {
                $('#emojigallery').dialog('close');
                e.preventDefault();
                return false;
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
                    var translations = {};
                    
                    translations["Cancel"] = $('#btnCloseEmoji').val();
                    var buttonsOpts = {};
                    buttonsOpts[translations["Cancel"]] = function () {
                        $('#emojigallery').dialog('close');
                    }

					 $("#emojigallery").dialog({
						 autoOpen: true,
						 height: 480,
						 width: 500,
						 position: ['center', 'center'],
                         modal: true,
                         buttons: buttonsOpts,
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
			$('#btnPunctuation').click(function () {
				SetupPopOver();
			});

			$('#btnSave').click(function (e) {
				var json = {
					Type: 'useroptions',
					SequenceOptionFlag: $('#chkSequence').prop("checked"),
					NativeOptionFlag: $('#chkNative').prop("checked"),
					SubLanguageOptionFlag: $('#chkSecondary').prop("checked"),
                    SubLanguage2OptionFlag: $('#chkSubLanguage2').prop("checked"),
                    StepOptionFlag: $('#chkTooltip').prop("checked"),
                    OrderByLearning: $('#chkOrderByLearningLanguage').prop("checked")
				};
				$.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
					var obj = $.parseJSON(data)
					if (obj.Status == "True") {
                        $('#lblSaveMessage').show();
                        $('#imgSearchSentence').click();
					}
				});
				e.stopPropagation();
			});

            
        });

        function checkMessage()
        {
            $("#hdnLearning").val('');
            $("#hdnNative").val('');
            $("#hdnFreeMessage1").val('');
            $("#hdnFreeMessage2").val('');
            $("#hdnOtherLanguagesContent").val('');
            if (!GetFinalMessage(false))
                return;
		    var learning = $("#hdnLearning").val();
            var native = $("#hdnNative").val();
            var freeNative = $("#hdnFreeMessage1").val();
            var freeLearning = $("#hdnFreeMessage2").val();
            var other = $("#hdnOtherLanguagesContent").val();
		    var json = {
		        Type: 'checkmessage',
                Learning: escape(learning),
                Native: escape(native),
                FreeNative: escape(freeNative),
                FreeLearning: escape(freeLearning),
                OtherMessage: escape(other),
            };
		    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {
                        toastr.options = {
                          "closeButton": true,
                          "debug": false,
                          "newestOnTop": false,
                          "progressBar": false,
                          "positionClass": "toast-top-right",
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
                    
                    toastr.error($('#hdnBadErrorMessage').val(), $('#hdnErrorHeader').val());

                }
                else {
                     $("#hdnLearning").val('');
                    $("#hdnNative").val('');
                    $("#hdnFreeMessage1").val('');
                    $("#hdnFreeMessage2").val('');
                    $("#hdnOtherLanguagesContent").val('');
                    GetFinalMessage(true);
                }
		    }).error(function(response) {
		        alert(respose.responseText)
		    });
        }

        async function checkMessages(origin) {
            async function checkedmessage(origin) {
                return new Promise((resolve, reject) => {
                    var freeNative = origin == 'freemessage' ? $("#txtFreeMessage1").val() : $("#native").val();
                    var freeLearning = origin == 'freemessage' ? $("#txtFreeMessage2").val() : $("#learning").val();

                    var json = {
                        Type: 'filtermessage',
                        Message: freeNative + ' ' + freeLearning,
                    };
                    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                        var obj = $.parseJSON(data)
                        if (obj.Status == "foul") {
                            reject(false);
                        }
                        else {
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

		function save(showMessage)
		{
		    var learning = $("#divFinalLearningMessage").html();
		    var native = $("#divFinalNativeMessage").html();
		    var json = {
		        Type: 'savemessage',
		        SaveMessageId: $("#hdnSavedMessageId").val(),
		        SenderId: <%=Language.Discovery.SessionManager.Instance.UserProfile.UserID.ToString()%>,
                Learning: escape(learning.replace("\n\t\t\t\t\t\t\t<span class=\"lblLearning_lbl hide\" id=\"lblLearning\">Message</span>\n\t\t\t\t\t\t","")),
                Native: escape(native)

            };
		    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)

                if (obj.Status == "True") {
                    $("#hdnSavedMessageId").val(obj.Id);
                    if (showMessage) {
                        $("<div><span>" + $("#hdnSavedMessageInfo").val() + "</span></div>").dialog({
                            modal: true,
                            buttons: {
                                Ok: function () {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    }
                }
		    }).error(function(response) {
		        alert(respose.responseText)
		    });
		}

	    function LoadSavedMessage()
	    {
	        $("#divFinalLearningMessage").html($("#hdnLearningLanguageForSave").val());
	        $("#divFinalNativeMessage").html($("#hdnNativeLangaugeForSave").val());
	        $("#lblWordCount").text($("#divFinalNativeMessage").children("div").length);
	    }

	    function SaveUserWords()
	    {
	        var translations = {};
	        translations["Ok"] = $('#lblYes').text();
	        translations["Cancel"] = $('#lblNo').text();
	        var buttonsOpts = {};
	        buttonsOpts[translations["Ok"]] = function () {
                var json = {
		        Type: 'saveword',
		        SenderId: <%=Language.Discovery.SessionManager.Instance.UserProfile.UserID.ToString()%>,
                Learning: $('#learning').val(),
                Native: $('#native').val()
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
                $('#wordtabs').tabs({ active: 1 });
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

        function ShowSendMessageWarning()
        {
            checkMessage();
	        //var translations = {};
	        //translations["Ok"] = $('#lblReturntoMessage').text();
	        //translations["Cancel"] = $('#lblSend').text();
	        //var buttonsOpts = {};
	        //buttonsOpts[translations["Ok"]] = function () {
	        //    $(this).dialog("close");
	        //}
         //   buttonsOpts[translations["Cancel"]] = function () {
         //       GetFinalMessage(true);
	        //    $(this).dialog("close");
	        //}
	        //$("#divSendWarning").dialog({
	        //    autoOpen: true,
	        //    height: 200,
	        //    width: 350,
	        //    modal: true,
	        //    buttons: buttonsOpts
	        //});
        }

       

        function HighlightEmoji(el) {
			$(el).siblings('.emoji').css("border", "");
			$(el).css("border", "1px solid red");
        }
        function SelectEmoji(el) {

            var emoji = $('#imgEmoji');
			$('#emojigallery').dialog('close');
            if ($(el).find('img').length > 0)
				AddEmojiPunctuationSticker($(el).find('img')[0].outerHTML, "data-isemoji='true'");
			else
			    AddEmojiPunctuationSticker($(el).find('span')[0].outerHTML, "data-ispunctuation='true'");

            //$('html, body').animate({ scrollTop: $('body').height() }, 800);
        }

        function SelectPunctuation(el) {
            //ReplacePunctuation($(el).find('span')[0].outerHTML, "data-ispunctuation='true'");
            m_shouldstoppropacation = false;
            var shouldAdd = false;
            if( m_selectedItem != null )
                wordClick($(el)[0].id, false, false);
            else
                shouldAdd = AddEmojiPunctuationSticker($(el).find('span')[0].outerHTML, "data-ispunctuation='true'");
            ClosePopOver();
            if (shouldAdd)
                Add();


        }

        function GetFinalMessage(postback) {
		    //$("#hdnLearningLanguageForSave").val($("#divFinalLearningMessage").html());
		    //$("#hdnNativeLangaugeForSave").val($("#divFinalNativeMessage").html());
		    //$("#hdnOtherLangaugeForSave").val($("$otherlanguages").html());

            var jsonsentences = "[{ \"LanguageCode\":\"" + $('#hdnLearningLanguageCode').val() + "\", \"Message\" :\"";
            var isDemo = $('#hdnIsDemo').val();
            var sentencecount = $('#lblWordCount').text();
            var mandatorySentenceCount = 3;
            //if (isDemo == "1")
            //	mandatorySentenceCount = 1;
            if (sessionStorage.getItem('shouldCountNumberOfSentence') == null) {
                if (parseInt(sentencecount) < mandatorySentenceCount) {
                    GetRandomOrderMessage('limit');
                    return false;
                }
            }
			
			//$('#btnSend').prop("disabled", true);
            //$('#btnSend').attr('disabled', 'disabled');
			var sentence = "";
			
			$("#divFinalLearningMessage").children("div").children(".column1").each(function () {
			    
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
                    if ($(obj).is("[data-sound]")) {
                        if ($(obj).attr("data-sound").indexOf(".mp3") > -1)
					    {
					        $(obj).addClass("hasSound");
                            //if ($(obj).attr("onclick"))
                            //    $(obj).attr("onclick", $(obj).attr("onclick") + "playsoundnow(this,xxx" + $(obj).attr("data-sound") + "xxx);");
                            //else
                            //    $(obj).attr("onclick", "playsoundnow(this,xxx" + $(obj).attr("data-sound") + "xxx);");
                        }
                    }
                    if ($(obj).is("[data-keyword]") && $('#hdnKeywords').val().indexOf($(obj).attr("data-keyword")) == -1) {
                        if($('#hdnKeywords').val() == "")
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
			$("#divFinalNativeMessage").children("div").children(".column1").each(function () {
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
					        //if ($(obj).attr("onclick"))
					        //    $(obj).attr("onclick", $(obj).attr("onclick") + "playsoundnow(this,xxx" + $(obj).attr("data-sound") + "xxx);");
					        //else
					        //    $(obj).attr("onclick", "playsoundnow(this,xxx" + $(obj).attr("data-sound") + "xxx);");
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

			    jsonsentences += sentence.replace(/"/g, "'") + "|";
				$('#<%=hdnNative.ClientID%>').val($('#<%=hdnNative.ClientID%>').val() + sentence + "|");
				sentence = "";

			});
			m_phrasecount = 0;
			jsonsentences += "\"},";
			
			var languagearray = $.parseJSON($('#hdnOtherLanguageCode').val());
			jsonsentences += "{ \"LanguageCode\":\"" + languagearray[0] + "\", \"Message\" :\"";
			//alert(jsonsentences);
            
			if($otherlanguages != null)
			{
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
			                    //if ($(obj).attr("onclick"))
			                    //    $(obj).attr("onclick", $(obj).attr("onclick") + "playsoundnow(this,xxx" + $(obj).attr("data-sound") + "xxx);");
			                    //else
			                    //    $(obj).attr("onclick", "playsoundnow(this,xxx" + $(obj).attr("data-sound") + "xxx);");
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
			        //jsonsentences += sentence.replace(/"/g, "\"") + "|"
			        jsonsentences += sentence.replace(/"/g, "'") + "|";
			        $('#hdnOtherLanguages').val($('#hdnOtherLanguages').val() + sentence + "|");
			        sentence = "";

			    });
			}
			//debugger;
			jsonsentences += "\"}]";
            $('#hdnOtherLanguagesContent').val(jsonsentences);
            if (postback) {
                $('#btnSendDummy').click();

                if (sessionStorage.getItem('shouldCountNumberOfSentence') != null)
                    sessionStorage.removeItem('shouldCountNumberOfSentence');
            }

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
			$("a.gallery").colorbox();
			m_shouldstoppropacation = true;
			return false;
		}

		function ActivateSentencePaging(page, totalpage, ispageload) {
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

			//if (ispageload)
			//    $('.items').hide();

			//$(".sContainerb").swipe({
			//    //Generic swipe handler for all directions
			//    swipe: function (event, direction, distance, duration, fingerCount, fingerData) {
			//        var currentpage = parseInt($('#hdnsentencepage').val());
			//        if (direction == "up") {
			//            currentpage = currentpage + 1;
			//            if (currentpage > totalpage)
			//                return;
			//            $('#hdnsentencepage').val(currentpage);
			//            //ToggleSlider('items', 'up', 'hide');
			//        } else if (direction == "down") {
			//            currentpage = currentpage - 1;
			//            if (currentpage < 1)
			//                return;
			//            $('#hdnsentencepage').val(currentpage);
			//            //ToggleSlider('items', 'down', 'hide');
			//        }
			//        $('#btnSearchSentence').click();
			//        //$(this).text("You swiped " + direction);
			//    },
			//    //Default is 75px, set to 0 for demo so any distance triggers swipe
			//    threshold: 75
			//});



		}

		function ActivateWordPaging(page, totalpage, ispageload) {

			var option = "";
			var numofpages = 5;
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
			    edges:0,
				onPageClick: function (pageNumber, event) {

					$('#hdnwordpage').val(pageNumber);
					$('#btnSearchWord').click();
				}

			});
			if (totalpage == 1) {
				$('#wordPaging').find('.prev').remove();
				$('#wordPaging').find('.next').remove();
			}
			//if (ispageload)
		    //    $('.items2').hide();

			//$(".sContainer").swipe({
			//    //Generic swipe handler for all directions
			//    swipe: function (event, direction, distance, duration, fingerCount, fingerData) {
			//        var currentpage = parseInt($('#hdnwordpage').val());
			//        if (direction == "left") {
			//            currentpage = currentpage + 1;
			//            if (currentpage > totalpage)
			//                return;
			//            $('#hdnwordpage').val(currentpage);
			//            //ToggleSlider("items2", "left", "hide");
			//            //$('#btnSearchWord').click();
			//            //$('.items2').show("slide", {
			//            //    direction: "left"
			//            //}, 2000);

			//        } else if (direction == "right") {
			//            currentpage = currentpage - 1;
			//            if (currentpage < 1)
			//                return;
			//            $('#hdnwordpage').val(currentpage);
			//            //ToggleSlider("items2", "right", "hide");
			//        } else {
			//            return;
			//        }
			//        $('#btnSearchWord').click();
			//    },
			//    //Default is 75px, set to 0 for demo so any distance triggers swipe
			//    threshold: 75
			//});
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
		        edges:0,
		        onPageClick: function (pageNumber, event) {

		            $('#hdnwordpageusercreated').val(pageNumber);
		            $('#btnSearchWord').click();
		        }

		    });
		    if (totalpage == 1) {
		        $('#wordPagingusercreated').find('.prev').remove();
		        $('#wordPagingusercreated').find('.next').remove();
		    }
		    //if (ispageload)
		    //    $('.items2').hide();

		    //$("#divWordContainerUserCreated").swipe({
		    //    //Generic swipe handler for all directions
		    //    swipe: function (event, direction, distance, duration, fingerCount, fingerData) {
		    //        var currentpage = parseInt($('#hdnwordpageusercreated').val());
		    //        if (direction == "left") {
		    //            currentpage = currentpage + 1;
		    //            if (currentpage > totalpage)
		    //                return;
		    //            $('#hdnwordpageusercreated').val(currentpage);
		    //            //ToggleSlider("items2", "left", "hide");
		    //            //$('#btnSearchWord').click();
		    //            //$('.items2').show("slide", {
		    //            //    direction: "left"
		    //            //}, 2000);

		    //        } else if (direction == "right") {
		    //            currentpage = currentpage - 1;
		    //            if (currentpage < 1)
		    //                return;
		    //            $('#hdnwordpageusercreated').val(currentpage);
		    //            //ToggleSlider("items2", "right", "hide");
		    //        } else {
		    //            return;
		    //        }
		    //        $('#btnSearchWord').click();
		    //    },
		    //    //Default is 75px, set to 0 for demo so any distance triggers swipe
		    //    threshold: 75
		    //});
		}

		function ToggleSlider(item, direction, type) {
		    //if (type == "hide") {
		    //    $('.' + item).hide("slide", {
		    //        direction: direction
		    //    }, 500);
		    //}
		    //else if (type == "show") {
		    //    $('.' + item).show("slide", {
		    //        direction: direction
		    //    }, 500);
		    //}

		}

		//}
		//function ShowWordSlide() {
		//    $('.items2').show("slide", {
		//        direction: "right"
		//    }, 500);
		//    //$('.loader').hide();
		//}

        function UseSuggestion() {
            ClearSelectedSentence();
		    $('#<%=divSuggestion.ClientID%>').find(".wordContainer").each(function () {
				wordClick($(this)[0].id, true, false);
            });
            Add();
            ClearSelectedSentence();
			return false;
		}

		function AddAllWords(el) {
            RemoveSentencePlaceHolder();
            ClearSelectedSentence();

            $(el).siblings("ul").find("li").each(function () {
				wordClick($(this).find('div')[0].id, true, false);
            });
            var parent = $('#<%=divSentence.ClientID %>');
            $(parent).find(".soundicon").remove();
		    if($(parent).find(".soundicon").length == 0)
		    {
		        var icon = $(el).siblings("ul").find(".soundicon");
		        if(icon)
		        {
		            icon = icon.clone();
		            icon.removeAttr("onclick");
		            icon.click(function() {
		                PlaySequentialSoundsOnly(this);
		            });
                }
                parent.find('div:last').after(icon);
		        //parent.append(icon);
		    }
			//$('html, body').animate({ scrollTop: $('body').height() }, 800);
            let added = Add();
            ClearSelectedSentence();
            if (added) {
                save(false);
            }
			return false;
		}

		function ClearMessage() {
			$('#divFinalLearningMessage').empty();
			$('#divFinalNativeMessage').empty();
			$('#lblWordCount').text("0");
			$otherlanguages = null;
		}

		function RemoveSingleMessage(el) {
			var c = $(el).attr('class');
            
			var m1 = $('#divFinalLearningMessage').find('.' + c);
			var m2 = $('#divFinalNativeMessage').find('.' + c);
			if (m1)
				m1.parent().parent().remove();
			if (m2)
			    m2.parent().parent().remove();

			UpdateSentenceCount(false);
		}

		function EditMessage(el) {
		    
		    var c = $(el).attr('class');
		    
		    var m1 = $('#divFinalLearningMessage').find('.' + c);
		    var m2 = $('#divFinalNativeMessage').find('.' + c);
		    if (m1) {
		        m1.parent().parent().siblings().children(".column1").removeClass("forEdit");
		        m1.parent().siblings(".column1").toggleClass("forEdit");
		    }
		    if (m2) {
		        m2.parent().parent().siblings().children(".column1").removeClass("forEdit");
		        m2.parent().siblings(".column1").toggleClass("forEdit");
		    }
		}


		function GetRandomOrderMessage(type) {
			var enWrongMessage = ['Incorrect button order.', 'Try again!', 'Are you sure?', 'Nearly there!'];
			var enWrongLineMessage = ['Please "+ Add to Message" or "Clear" the Sentence in the Edit Box.'];
			var jpWrongMessage = ['ボタンの順番はあってるかな？', 'もう一度！', '本当にこれであってるかな？', 'もう少し！'];
			//var jpWrongLineMessage = ['編集ボックスの文を「メッセージに追加」するか「クリア」してね！', 'もう一度！', '本当にこれであってるかな？'];
			var jpWrongLineMessage = ['編集ボックスの文を「メッセージに追加」するか「クリア」してね！'];
			var cnWrongMessage = ['再试一次', '再试一次', '再试一次', '再试一次'];
			var enLimit = 'Should be minimum of 3 sentences.';
			var jpLimit = '3文以上でなければならない';
			var chLimit = '应至少3句话。';
			
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
			else if (type == 'limit' && language == 'zh-CN') {
			    result = chLimit;
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
			var ddl = $('#hdnCategory');
			if ($('#txtSearchSentence').val().length > 0 && $(ddl).val() != "0") {
				ChangeTheIsDropDownChange('0');
				$(ddl).val("0");
				$('#hdnTopCategory').val("1");

				//$(".dropdown-menu li a").parents(".dropdown").find('.btn').html('[All] > [All]' + ' <span class="caret"></span>');
			}
			
		}

		function InitializeDropdownMenuClick() {
			$(".dropdown-menu .dropdown-submenu").each(function () {
				var menu = $(this).find(".dropdown-menu");
				if (menu.length == 0)
				    $(this).addClass("dropdown-withoutsubmenu").removeClass("dropdown-submenu");

				
			});

			$(".dropdown-menu .dropdown-withoutsubmenu").click(function () {
				var menu = $(this).find(".dropdown-menu");
				if (menu.length == 0) {
					$(this).parents(".dropdown").find('.btn').html($(this).parents(".dropdown-submenu").find('a').first().text() + $(this).text() + ' <span class="caret"></span>');
					$("#hdnTopCategory").val($(this).find('a').first().attr("data-value"));
					$("#hdnTopCategoryName").val($(this).find('a').first().text());
					$('#txtSearchSentence').val('');
					$('#txtSearchSentence').text('');
					$('.clear-helper').css('display', 'none');
					$("#btnSearchByCategory").click();
				}
			});
			$(".dropdown-menu .dropdown-submenu").click(function (event) {
				
				var menu = $(this).find(".dropdown-menu");
				if (menu.length > 0) {
					event.stopPropagation();
				}
				$(".clear-helper").click();
			});
			$(".dropdown-menu li a").click(function (event) {
				$(this).parents(".dropdown").find('.btn').html($(this).parents(".dropdown-submenu").find('a').first().text() + '>' + $(this).text() + ' <span class="caret"></span>');
				$("#hdnCategory").val($(this).attr("data-value"));
				$("#hdnTopCategory").val($(this).parents(".dropdown-submenu").find('a').first().attr("data-value"));
				$("#hdnTopCategoryName").val($(this).parents(".dropdown-submenu").find('a').first().text());
				$(".clear-helper").click();
				$("#btnSearchByCategory").click();
				
				//$(this).parents(".dropdown").find('.btn').val( $(this).text() + '>'+ $(this).data('value'));
			});
		}

		function DisableCategory() {
			$('#dropdownMenu1').addClass("disabled");
		}

		function InitializeCategory(code) {
			$('#dropdownMenu1').html(code + ' <span class="caret"></span>');
			$(".dropdown-menu").find(".dropdown-submenu").each(function () {
				if ($(this).find(".dropdown-menu").length == 0) {

				}
			});
			$("#hdnTopCategoryName").val(code);
		}

		function RemoveUser() {
			if ($('#lstRecipient option').length == 1)
				return false;

			$('#hdnRemovedUsers').val( $('#hdnRemovedUsers').val() + ',' + $('#lstRecipient option:selected').val());
			$('#lstRecipient option:selected').remove();
			$('#lstRecipient option:eq(0)').prop('selected', true);
		}

		function ShowHidePaletteContainer(show) {
			if (show == true)
				$(".sContainerb").show();
			else
				$(".sContainerb").hide();
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

		function RejectMessage(isdemo) {
			var translations = {};
			translations["Ok"] = $('#lblOk').text();
			var buttonsOpts = {};
			buttonsOpts[translations["Ok"]] = function () {
				$(this).dialog("close");
				window.location = 'Mailbox?d=' + isdemo;
			}

			$("#divRejectMessage").dialog({
				autoOpen: true,
				height: 300,
				width: 300,
				modal: true,
				buttons: buttonsOpts
			});
		}

		function InitializeSearchText(value)
		{
		    $('#txtSearchSentence').val(value);
		}

		function RightArrowClick() {

        }
       
       

	</script>
	<div id="divModalMessage" style="display:none;" >
		<span id="spanMessage"></span>
	</div>
 
	<div style="width:100%;">
        <asp:HiddenField ID="hdnNativeLangaugeForSave" runat="server" ClientIDMode="Static" value=""/>
        <asp:HiddenField ID="hdnLearningLanguageForSave" runat="server" ClientIDMode="Static" value=""/>
        <asp:HiddenField ID="hdnOtherLangaugeForSave" runat="server" ClientIDMode="Static" value=""/>
        <asp:HiddenField ID="hdnSavedMessageId" runat="server" ClientIDMode="Static" value="0"/>
        <asp:HiddenField ID="hdnSavedMessageInfo" runat="server" ClientIDMode="Static" value="" meta:resourcekey="hdnSavedMessageInfoResource1"/>
		<asp:HiddenField ID="hdnIsDemo" runat="server" ClientIDMode="Static" value="0"/>
		<asp:HiddenField ID="hdnIsDropDownChangeFromClient" runat="server" ClientIDMode="Static" value="0"/>
		<asp:HiddenField ID="hdnPunctuation" runat="server" ClientIDMode="Static" meta:resourcekey="hdnPunctuationResource1"/>
		<asp:HiddenField ID="hdnSelectFromPalete" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSelectFromPaleteResource1" />
		<asp:HiddenField ID="hdnReplaceWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnReplaceWordResource1"/>
		<asp:HiddenField ID="hdnCreateNewWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCreateNewWordResource1"/>
		<asp:HiddenField ID="hdnFreeMessage1" runat="server" ClientIDMode="Static" value=""/>
		<asp:HiddenField ID="hdnFreeMessage2" runat="server" ClientIDMode="Static" value=""/>
		<asp:HiddenField ID="hdnTopCategory" runat="server" ClientIDMode="Static" value="0"/>
        <asp:HiddenField ID="hdnTopCategoryName" runat="server" ClientIDMode="Static" value=""/>
		<asp:HiddenField ID="hdnCategory" runat="server" ClientIDMode="Static" value="0"/>

        <asp:HiddenField ID="hdnWordToReplaceId" runat="server" Value="" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnWordType" runat="server" Value="" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnwordpage" runat="server" Value="1" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnwordpageusercreated" runat="server" Value="1" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnsentencepage" runat="server" Value="1" ClientIDMode="Static"  />
		<asp:HiddenField ID="hdnLearning" runat="server" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnNative" runat="server" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnKeywords" runat="server"  ClientIDMode="Static"/>
		<asp:HiddenField ID="hdnNativeLanguageCode" runat="server" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnOtherLanguageCode" runat="server" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnOtherLanguagesContent" runat="server" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnLearningLanguageCode" runat="server" ClientIDMode="Static" />
		<asp:HiddenField ID="hdnFreeTextMessage1PlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeTextMessage1PlaceHolderResource1"/>
		<asp:HiddenField ID="hdnFreeTextMessage2PlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeTextMessage2PlaceHolderResource1"/>
		<asp:HiddenField ID="hdnSearchPlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSearchPlaceHolderResource1"/>
        <asp:HiddenField ID="hdnSearchWordPlaceHolder" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSearchWordPlaceHolderResource1"/>
        <asp:HiddenField ID="hdnAddWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnAddWordResource1"/>
        <asp:HiddenField ID="hdnFreeformWordTitle" runat="server" ClientIDMode="Static" meta:resourcekey="hdnFreeformWordTitleResource1"/>
        <asp:HiddenField ID="hdnNoSentenceToAdd" runat="server" ClientIDMode="Static" meta:resourcekey="hdnNoSentenceToAddResource1"/>
        <asp:HiddenField ID="hdnSearchSentenceHistoryIndex" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnSearchWordHistoryIndex" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdnIsFirstLogin" runat="server" ClientIDMode="Static" value="0"/>
    	<asp:HiddenField ID="hdnStep1" runat="server" Value="Let’s choose a Category!" ClientIDMode="Static" meta:resourcekey="hdnStep1Resource1"/>
		<asp:HiddenField ID="hdnStep2" runat="server" Value="Click ↑ or &quot;Words in Order&quot;!" ClientIDMode="Static" meta:resourcekey="hdnStep2Resource1" />
		<asp:HiddenField ID="hdnStep3" runat="server"  Value="Put in Correct Order/Click the Cog and replace Words!" ClientIDMode="Static" meta:resourcekey="hdnStep3Resource1"/>
        <asp:HiddenField ID="hdnStep3b" runat="server" Value="Click and Change Words!" ClientIDMode="Static" meta:resourcekey="hdnStep3bResource1"/>
		<asp:HiddenField ID="hdnStep4" runat="server" Value="Add to your Message!" ClientIDMode="Static" meta:resourcekey="hdnStep4Resource1"/>
		<asp:HiddenField ID="hdnStep5" runat="server"  Value="Send to your Friends!" ClientIDMode="Static" meta:resourcekey="hdnStep5Resource1"/>
        <asp:HiddenField ID="hdnSuggestedTopic" runat="server" ClientIDMode="Static" value="" meta:resourcekey="hdnSuggestedTopicResource1"/>
        <asp:HiddenField ID="hdnSelectedUsers" runat="server" ClientIDMode="Static" value=""/>
        <asp:HiddenField ID="hdnErrorHeader" runat="server" ClientIDMode="Static" meta:resourcekey="hdnErrorHeaderResource1"/>
        <asp:HiddenField ID="hdnBadErrorMessage" runat="server" ClientIDMode="Static" meta:resourcekey="hdnBadErrorMessageResource1"/>
        <asp:HiddenField ID="hdnDeleteWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnDeleteWordResource1"/>
        <asp:HiddenField ID="hdnSaveWord" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSaveWordResource1"/>
        <asp:HiddenField ID="hdnCurrentUser" runat="server" ClientIDMode="Static"/>

        <asp:Label ID="lblReturn" runat="server" meta:resourcekey="hdnReturnResource1" ClientIDMode="Static" style="display:none;"/>
		<asp:Label ID="lblOk" runat="server" meta:resourcekey="hdnlblOkResource1" ClientIDMode="Static" style="display:none;"/>
		<asp:Label ID="lblCancel" runat="server" meta:resourcekey="hdnlblCancelResource1" ClientIDMode="Static" style="display:none;"/>
		<asp:Label ID="lblYes" runat="server" meta:resourcekey="lblYesResource1" ClientIDMode="Static" style="display:none;"/>
		<asp:Label ID="lblNo" runat="server" meta:resourcekey="lblNoResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:Label ID="lblReturntoMessage" runat="server" meta:resourcekey="lblReturntoMessageResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:Label ID="lblSend" runat="server" meta:resourcekey="lblSendResource1" ClientIDMode="Static" style="display:none;"/>
        <asp:HiddenField ID="hdnPrepareWordReplaceElementID" runat="server" ClientIDMode="Static"/>

        <div id="divSendWarning" title="&nbsp;" style="display:none;">
			<asp:Label ID="lblSendWarning" runat="server" Text="Warning"  ClientIDMode="Static" meta:resourcekey="lblSendWarningResource1"></asp:Label><br />
		</div>

		<div id="divSaveWordDialog" title="&nbsp;" style="display:none;">
			<asp:Label ID="lblSaveWordQuestion" runat="server" Text="Do you want to save your word?" ClientIDMode="Static"></asp:Label><br />
		</div>

		<div id="divMaxPalette" title="&nbsp;" style="display:none;">
			<asp:Label ID="lblMaxPalette" runat="server" Text="You can only send a maximum of  5 palette."  meta:resourcekey="lblMaxPaletteResource1"></asp:Label><br />
		</div>
		
		<div id="divRejectMessage" title="&nbsp;" style="display:none;">
			<asp:Label ID="lblRejectMessage" runat="server" Text="Your message is not sent. Please write up nice messages to your Japan friends!"  meta:resourcekey="lblRejectMessageResource1"></asp:Label><br />
		</div>

		<div id="divFreeformWord" title="&nbsp;" style="display:none;">
			<asp:Label ID="lblDialogNativeLanguage" runat="server" Text="Native Language"  meta:resourcekey="lblDialogNativeLanguageResource1"></asp:Label><br />
			<input type="text" name="native" id="native" class="text ui-widget-content ui-corner-all" style="width:250px;" spellcheck="true"/><br />
			<asp:Label ID="lblDialogLearningLanguage" runat="server" Text="Learning Language"  meta:resourcekey="lblDialogLearningLanguageResource1"></asp:Label>&nbsp;&nbsp;<img id="imgTranslating" src="../Images/translating.gif" style="display:none;" /><br />
			<input type="text" name="learning" id="learning" value="" class="text ui-widget-content ui-corner-all" style="width:250px;" spellcheck="true"/>
			<asp:Label ID="lblDialogSubLanguage" runat="server" style="display:none;" Text="Sub Language"  meta:resourcekey="lblDialogSubLanguageResource1"></asp:Label>
			<input type="text" name="sub" id="sub" value="" style="display:none;" class="text ui-widget-content ui-corner-all" />
            <asp:Label ID="lblTranslating" runat="server" style="display:none;" Text="Translating..., Please wait." ClientIDMode="Static"  meta:resourcekey="lblTranslatingResource1"></asp:Label>
            <ul>
                <li><asp:Label ID="lblDialogTranslationInstruction" runat="server" Text=""  meta:resourcekey="lblDialogTranslationInstructionResource1"></asp:Label><br /></li>
            </ul>
            
		</div>
		

		<div id="emojigallery" style="width:800px;display:none;">
		   <div id="tabs" style="height:90%;">
				<ul style="display:none;">
				<li><asp:HyperLink ID="HyperLink1" href="#emoji" runat="server" Text="Emoji" meta:resourcekey="HyperLink1Resource1"  style="display:none;"/></li>
				<li><asp:HyperLink ID="HyperLink2" href="#sticker" runat="server" Text="Sticker" style="display:none;" meta:resourcekey="HyperLink2Resource1" /></li>
				<li><asp:HyperLink ID="HyperLink3" href="#punctuation" runat="server" Text="Punctuation" meta:resourcekey="HyperLink3Resource1"  style="display:none;" /></li>
				</ul>
			   <div id="emoji" style="overflow-y:scroll;height:380px;" >

			   </div>
			   <div id="sticker" style="display:none;">

			   </div>
			   <div id="punctuation1" style="display:none;">
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>.</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>?</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>!</span></div>
                   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>&nbsp;</span></div>

				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>:</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>;</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>#</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>&</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>*</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>$</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>@</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>/</span></div>
				   <div class="emoji" style="width:20px;height:20px;" onclick="HighlightEmoji(this);SelectEmoji(this);" ><span>\</span></div>
			   </div>
			</div>   
			<asp:Button ID="btnCloseEmoji" runat="server" Text="Close" ClientIDMode="Static" meta:resourcekey="btnCloseEmojiResource1" UseSubmitBehavior="false" CausesValidation="false" style="display:none;"/>
		</div>
		<div id="punctuationGallery" style="width:400px;display:none;" class="popper-content hide">
			   <div id="punctuationContainer" >
				   <div id="pdot" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>.</span></div>
				   <div id="pquestionmar" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>?</span></div>
				   <div id="pexclamation" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>!</span></div>
				   <div id="pthickexclamation" class="punctuation" style="width:20px;height:20px;font-weight:800;" onclick="SelectPunctuation(this);" ><span>！</span></div>
				   <div id="pdoubleexclamation" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>!!</span></div>
                   <div id="pthickdoubleexclamation" class="punctuation" style="width:20px;height:20px;font-weight:800;" onclick="SelectPunctuation(this);" ><span>‼</span></div>
                   <div id="pthickdoubleexclamation" class="punctuation" style="width:20px;height:20px;font-weight:800;" onclick="SelectPunctuation(this);" ><span>‼</span></div>
				   <div id="pexquestion" class="punctuation" style="width:20px;height:20px;" onclick="SelectPunctuation(this);" ><span>!?</span></div>
				   <div id="pthickexquestion" class="punctuation" style="width:20px;height:20px;font-weight:800;" onclick="SelectPunctuation(this);" ><span>⁉</span></div>
			   </div>
			
		</div>
		<div id="divFreeMessage" style="display:none;">
		  <fieldset>
			<legend>
				<asp:Label ID="lblFreeMessage" runat="server" Text="Free Message" meta:resourcekey="lblFreeMessageResource1"></asp:Label></legend><br />
			  <table style="width:100%;height:150px;">
				  <tr>
					  <td>
						  <textarea id="txtFreeMessage1" class="text ui-widget-content ui-corner-all freemessage" style="width:98%;height:100%;" cols="1" rows="5" maxlength="150" spellcheck="true"></textarea>
						  <span id="lblcharleft1" style="display:none;">150</span>&nbsp;<asp:Label ID="lblcharleftLabel1" runat="server"  ClientIDMode="Static" meta:resourcekey="lblcharleftLabel1Resource1">Characters remaining</asp:Label>
					  </td>
					  <td>
						  <textarea id="txtFreeMessage2" class="text ui-widget-content ui-corner-all freemessage" style="width:98%;height:100%" cols="1" rows="5" maxlength="150" spellcheck="true"></textarea>
						  <span id="lblcharleft2" style="display:none;">150</span>&nbsp;<asp:Label ID="lblcharleftLabel2" runat="server"  ClientIDMode="Static" meta:resourcekey="lblcharleftLabel1Resource1">Characters remaining</asp:Label>
					  </td>
				  </tr>
				  <tr>
					  <td>
						   &nbsp; 
					  </td>
					  <td>
							
					  </td>
				  </tr>
				  <tr>
					  <td colspan="2">
						  <asp:Label ID="lblFreeMessageInfo" ForeColor="red" style="display: none;" runat="server" ClientIDMode="Static" meta:resourcekey="lblFreeMessageInfoResource1">Enter the messages both in Eng and Japanese.</asp:Label>
					  </td>
				  </tr>

			  </table>
		  </fieldset>
		</div>   
		   
		<div class="sendmsg_top_container" id="sendmsg_top_container">
			<div class="stc_avatar_container" id="stc_avatar_container">
                <div class="floatButtonContainer">
                   <a href="#" class="float">
                        <i class="material-icons partner-message">insert_comment</i>
                   </a>
               	    <asp:Label ID="lblViewMessage" runat="server" Text="View Received Message"  Font-Size="Smaller" ClientIDMode="Static" meta:resourcekey="lblViewMessageResource1"></asp:Label>
                </div>
				<div class="sac_inf-to" id="Div1">
					<asp:Label ID="lblTo" CssClass="sac_inf_to" runat="server" Text="To:" Visible="true" meta:resourcekey="lblToResource1" ></asp:Label>
				</div>
				<div class="stc_avatar_container" id="Div5">
					<asp:ListBox ID="lstRecipient" runat="server" CssClass="selectbox" ClientIDMode="Static" >
					</asp:ListBox>
					<asp:HiddenField ID="hdnRemovedUsers" ClientIDMode="Static"  runat="server" /> 
					<asp:ImageButton runat="server" ID="btnDeleteUser" ImageUrl="../Images/ico_Delete.png" ClientIDMode="Static" OnClientClick="RemoveUser(); return false;" style="padding:0px !important;"  meta:resourcekey="btnDeleteUserResource1"/>
                    
				</div>
                <div id="divCCContainer">
                    <asp:CheckBox ID="chkCC" runat="server" ClientIDMode="Static" Checked="false"/>
                    <asp:Label ID="lblcc" runat="server" Text="CC to other students" meta:resourcekey="lblccResource1" ></asp:Label>
                </div>
				<div class="sac_img" id="sac_img" style="display:none;">
					<asp:Image ID="imgTo" CssClass="sac_img_avatar" runat="server" ImageUrl="~/Images/no_avatar.png" Width="70px" Height="70px" meta:resourcekey="imgToResource1" />
				</div>
				<div class="sac_inf" id="sac_inf" style="display:none;">
					<asp:Label CssClass="sac_inf_name" ID="lblToName" runat="server" Text="Sayaka" meta:resourcekey="lblToNameResource1" ></asp:Label>
				</div>
			</div>
			<div class="stc_msg_send_container" id="stc_msg_send_container">
				<div class="smsc_left" id="smsc_left">
					<div class="lblLearning_lbl_container" id="lblLearning_lbl_container">
						
					</div>
					<div class="lblLearning_lbl_msg" id="lblLearning_lbl_msg">
						<div id="divFinalLearningMessage" class="divFinalLearningMessage" style="height:130px; overflow:auto;border: 1px solid #d3d2d2;width:99.5%; word-wrap:break-word;" >
							<asp:Label CssClass="lblLearning_lbl" ID="lblLearning" runat="server" Text="Message:" meta:resourcekey="lblLearningResource1" ClientIDMode="Static"></asp:Label>
						</div>
						<div id="divFinalNativeMessage" class="divFinalLearningMessage" style="display:none; height:130px;overflow:auto;border: 1px solid #d3d2d2; word-wrap:break-word;" data-invisible="false"></div>
					</div>
					
				</div>
				<div class="smsc_right" id="smsc_right">
					<div class="smsc_btnsend_count" id="smsc_btnsend_count">
						<%--<div class="btnsend_count_lbl_frame" id="btnsend_count_lbl_frame">--%>
							<%--<div class="count-sentence-frame">
								<label class="btnsend_count_lbl" id="lblWordCount">0</label>
								<asp:Label ID="lblsentenceLabel" class="btnsend_count_lbl2" runat="server" Text="SENTENCE" meta:resourcekey="lblsentenceLabelResource1" ClientIDMode="Static"></asp:Label>
							</div>--%>
                            <img id="btnSend" class="btnsend_count_cmd" src="../Images/new/send_new.png" onclick="ShowSendMessageWarning();return false;"/>
							
							<asp:Button Height="30px" Width="96px" ID="btnSendDummy" runat="server" Text="Send" OnClick="btnSend_Click" ClientIDMode="Static" style="display:none;" />
						<%--</div>--%>  
						<div class="btn_msg_container" id="btn_msg_container">
							<asp:ImageButton CssClass="bmct_btn" ClientIDMode="Static" ID="imgFreeFormMessage" ImageUrl="~/Images/new/free_message.png"  BackColor="Transparent" BorderColor="Transparent" runat="server" AlternateText="Free Form" OnClientClick="FreeMessage(); return false;" ToolTip="Free Form" meta:resourcekey="imgFreeFormMessageResource1"   />
                            <%--<div class="divNumbercircle" id="step5"><span>3</span></div>--%>
							<asp:ImageButton CssClass="bmct_btn" ID="imgClearMessage" ImageUrl="~/Images/clearmessage.png" Width="18px" Height="20px" BackColor="Transparent" BorderColor="Transparent" runat="server" AlternateText="Clear Message" OnClientClick="ClearMessage() ;return false;" ToolTip="Clear Message" meta:resourcekey="imgClearMessageResource1" Visible="false" />
							<div id="divShowTranslation" class="make-switch switch-large" runat="server" data-on-label="<i class='icon-ok icon-white'><img src='../Images/japan.png' style='width:24x !important;height:24px !important;'/></i>" data-off-label="<i class='icon-remove'><img src='../Images/australia.png' style='width:24x !important;height:24px !important;' /></i>" data-on="warning" data-off="warning" style="line-height:10px !important;padding-bottom:0px !important; padding-top:0px !important;margin-top:-8px;display:none;">
								<input id="chkShowTranslation" type="checkbox" >
							</div>
							<asp:LinkButton ID="linkShowTranslation" Visible="false" CssClass="btn_msg_container_translation" BackColor="Transparent" runat="server" OnClientClick="ShowTranlation();return false;" meta:resourcekey="linkShowTranslationResource1">Translation</asp:LinkButton>
						</div>
                        <asp:Label ID="lblFreeMessageLabel" runat="server" Text="Free Message"  style="display:none;" meta:resourcekey="lblFreeMessageLabelResource1" ClientIDMode="Static" ></asp:Label>
                        <div id="saveContainer">
                            <img src="../Images/new/new_save.png" id="mailSave" onclick="save(true);" />
                             <div class="cont_home" onclick="save();" style="display:none;">
                                
<%--                            <i class="material-icons link_save">save</i>
                                <asp:Label ID="lblSaveOutMessageLabel" runat="server" Text="Save" CssClass="save_text"  meta:resourcekey="lblSaveOutMessageLabelResource1" ClientIDMode="Static" ></asp:Label>--%>
                        </div>
                        </div>
					</div>
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
        <div id="divTop" style="display:none;">
            <a id="arrowTop">
                <span class="spanTop"></span>
            </a>
        </div>
        <div id="divDown" style="display:none;">
            <a id="arrowDown">
                <span class="down"></span>
            </a>
        </div>
		<div id="mtabs">
			<ul class="tabs_links_menu">
                <li style="display:none;"><asp:HyperLink CssClass="send-msg-tabs1" ID="linkTabPhrase" href="#mtab1" runat="server" Text="Phrases" meta:resourcekey="linkTabPhraseResource1" /></li>
				<li style="display:none;"><asp:HyperLink CssClass="send-msg-tabs2" ID="linkTabWords" href="#mtab2" runat="server" Text="Words" meta:resourcekey="linkTabWordsResource1"/></li>
				<li  style="display:none;"><asp:HyperLink CssClass="send-msg-tabs3" ID="linkTabOptions" href="#mtab3" runat="server" Text="Options" meta:resourcekey="linkTabOptionsResource1" /></li>
                <li  style="display:none;" id="tab4"><asp:HyperLink CssClass="send-msg-tabs4" ID="linkTabUsersWords" href="#mtab4" runat="server" Text="User Words" meta:resourcekey="linkTabUsersWordsResource1"/></li>
			</ul>
            <div id="divCriteria">
                <div class="smc_middle_container" id="smc_middle_container">
			    </div>
			    <div class="smc_criteria_container" id="smc_criteria_container">
				        <div class="smc_search_container" id="smc_search_container">
                            <div class="divNumbercircle" id="step1"><span>1</span></div>
                            <div id="lblTopicsLabelContainer"><asp:Label ID="lblTopicsLabel" CssClass=""  runat="server" Text="Topics:" meta:resourcekey="lblTopicsLabelResource1"></asp:Label></div>
					        <asp:Repeater ID="rptTopCategory" runat="server" ClientIDMode="Static" OnItemDataBound="rptTopCategory_ItemDataBound">
						        <HeaderTemplate>
								        <div class="dropdown">
								        <button class="btn btn-warning dropdown-toggle  dropdown_slct" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
								        <span class="caret"></span>
								        </button>
								        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
						        </HeaderTemplate>
						        <ItemTemplate>
							        <li class="dropdown-submenu"><a style="cursor:pointer;pointer-events: none;" disabled data-value="<%# Eval("TopCategoryHeaderID") %>"><%# DataBinder.Eval(Container.DataItem,"TopCategoryName").ToString() %></a>
								        <asp:Repeater ID="rptCategory" runat="server">
									        <HeaderTemplate>
										        <ul class="dropdown-menu scrollable-menu">
									        </HeaderTemplate>
									        <ItemTemplate>
										        <li><a tabindex="-1" href="#" data-value="<%# Eval("PhraseCategoryID") %>"><%# DataBinder.Eval(Container.DataItem,"PhraseCategoryCode").ToString() %></a></li>
									        </ItemTemplate>
									        <FooterTemplate>
										        </ul>
									        </FooterTemplate>
								        </asp:Repeater>
							        </li>
						        </ItemTemplate>
						        <FooterTemplate>
							        </ul>
							        </div>
						        </FooterTemplate>
					        </asp:Repeater>
					        <asp:Button ID="btnSearchByCategory" ClientIDMode="Static" runat="server" style="display:none;" OnClick="btnSearchByCategory_Click"/>
					        <div class="smc_search_container_search_box_txt">
						        <asp:TextBox ID="txtSearchSentence" CssClass="smcsc_search_txt clearable" runat="server" BorderColor="Transparent" meta:resourcekey="txtSearchSentenceResource1" ClientIDMode="Static" placeholder="Search" spellcheck="true"></asp:TextBox>
						        <asp:ImageButton ID="imgClearSearch" CssClass="smcsc_search_x" ImageUrl="~/Images/x.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1" style="display:none;"/>
						        <asp:ImageButton ID="imgSearchSentence" CssClass="smcsc_search_img" ImageUrl="~/Images/SearchF.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" OnClick="imgSearchSentence_Click" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1"/>
                            

							        <asp:RadioButtonList ID="rdoCriteriaList" CssClass="rdoCriteriaList" Visible="false" runat="server" ClientIDMode="Static" RepeatDirection="Horizontal">
								        <asp:ListItem Text="Phrase+Word" Value="0" Selected="True" meta:resourcekey="rdoPhraseWordResource1"></asp:ListItem>
								        <asp:ListItem Text="Word" Value="1" meta:resourcekey="rdoWordResource1"></asp:ListItem>
							        </asp:RadioButtonList>
						        <div style="float:left;">
						        </div>                        
					        </div>
					        <img id="imgEmoji"  src="../Images/emojiNew.png" class="smcsc_search_emoji" style="width: 80px !important;margin-top: 1px; height: 45px !important"/>
					        <%--<img id="imgPunctuation"  src="../Images/exclamation.gif" class="smcsc_search_emoji" />--%>
                            <input type="button" id="btnPunctuation" class="btnPunctuation" value="!" style="cursor:pointer; float:left; color: white"/> 
					        <asp:Label ID="lblLabelAddEditWord" runat="server" Text="Add/Replace Word" meta:resourcekey="lblLabelAddEditWordResource1" style="font-size:x-small;display:none;"></asp:Label>
                            <asp:ImageButton ClientIDMode="Static" CssClass="smcsc_search_emoji" ID="imgSettings" ImageUrl="~/Images/settings.png" BackColor="Transparent" BorderColor="Transparent" runat="server" ToolTip="" meta:resourcekey="imgSettingsResource1"   />
				        </div>
			        </div>
            </div>
		    <div id="mtab1">
		        <div class="smc_bottom_container">
			        <div class="sbc_left_container">
                        <div  class="smc_sentence_container" id="divphrasePalette">
				            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" >
		                        <ContentTemplate>
				                    <asp:Label ID="lblLabelSentencePaging" runat="server" Text="Phrase palette" meta:resourcekey="lblLabelSentencePagingResource1" style="line-height:24px;font-weight:bold; display: none;"></asp:Label>
                                    <div id="divStep2ArrowContainer">
                                       <div class="arrowlabelnumberContainer">
                                       </div>
                                        <div class="arrowlabelnumberContainer">
                                            <div id="step2Container" class="arrowlabelnumberContainer">
                                                <div class="divNumbercircle" id="step2" ><span>2</span></div>
                                            </div>
                                            <asp:Label ID="lblSentenceTitle" ClientIDMode="Static" runat="server" Text="Phrase Palette" meta:resourcekey="lblSentenceTitleResource1" style="line-height:24px;font-weight:bold;"></asp:Label>
                                        </div>
                                    </div>
				                    <div id="sentenceContainer" runat="server" class="sContainerb">
							
				                    </div>
				                    <div class="sentencepagingContainer">
                                         <div class="arrowContainer arrowlabelnumberContainer">
                                            <div style="width:75px;height:30px;">
                                                <asp:ImageButton ID="imgBack" ImageUrl="~/Images/previousArrow.png" BackColor="Transparent"  BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgBackResource1" OnClick="imgBack_Click"/>
                                                <asp:ImageButton ID="imgForward" ImageUrl="~/Images/nextArrow.png" BackColor="Transparent"  BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgForwardResource1" OnClick="imgForward_Click"/>
                                            </div>
                                        </div>
                                        <div id="divSentencePagingContainer">
					                        <div id="sentencePaging" title="Page"></div>
                                        </div>
				                    </div>
				                    <asp:Button ID="btnSearchSentence" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchSentence_Click" meta:resourcekey="btnSearchSentenceResource1" />
			                    </ContentTemplate>
			                    <Triggers>
				                    <asp:AsyncPostBackTrigger ControlID="imgSearchSentence" EventName="click" />
                                <asp:AsyncPostBackTrigger ControlID="imgBack" EventName="click" />
                                <asp:AsyncPostBackTrigger ControlID="imgForward" EventName="click" />
				                    <asp:AsyncPostBackTrigger ControlID="btnSearchByCategory" EventName="click" />
			                    </Triggers>
		                    </asp:UpdatePanel>
                        </div>
			        </div>
		        </div>
		    </div>
           
		    <div id="mtab3">
			    <div class="sbc_right_container" id="sbc_right_container">
				    <div class="src_frame">
					    <div class="switch_container">
						    <div class="sc_lbl">
							    <asp:Label ID="lblSequence" runat="server" Text="Sequencence"  meta:resourcekey="lblSequenceResource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
								    <div class="make-switch" data-on="warning" data-off="default">
								    <input type="checkbox" id="chkSequence" class="switch6" checked="checked" runat="server" ClientIDMode="Static"/>
							    </div>
						    </div>
                            <asp:Label ID="lblSequenceEx" CssClass="lblOptionExplanation" runat="server" Text="This dispalys Word Orders on the Palette - Suitable for <b>Beginner</b> level students."  meta:resourcekey="lblSequenceExResource1"></asp:Label>
					    </div>
					    <div class="switch_container">
						    <div class="sc_lbl">
							    <asp:Label ID="lblNative" runat="server" Text="Native Language" meta:resourcekey="lblNativeResource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
							    <div class="make-switch" data-on="warning" data-off="default">
								    <input type="checkbox" id="chkNative" class="switch6" runat="server"  ClientIDMode="Static"/>
							    </div>
						    </div>
                            <asp:Label ID="lblNativeEx" CssClass="lblOptionExplanation" runat="server" Text="This displays Native Language Translations - Suitable for <b>Middle</b> level students."  meta:resourcekey="lblNativeExResource1"></asp:Label>
					    </div>
					    <div class="switch_container" id="divRomanji" runat="server">
						    <div class="sc_lbl">
							    <asp:Label ID="lblRomanji" runat="server" Text="Romanji" meta:resourcekey="lblRomanjiResource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
							    <div class="make-switch" data-on="warning" data-off="default">
								    <input type="checkbox" id="chkSecondary" class="switch6"  ClientIDMode="Static" runat="server"/>
							    </div>
						    </div>
                            <asp:Label ID="lblRomanjiEx"  CssClass="lblOptionExplanation" runat="server" Text="This displays Romanji Character for Japanese - Suitable for Romanji learners."  meta:resourcekey="lblRomanjiExResource1"></asp:Label>
					    </div>
					    <div class="switch_container">
						    <div class="sc_lbl">
							    <asp:Label ID="lblSubLanguage2" runat="server" Text="Kanji" meta:resourcekey="lblSubLanguage2Resource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
								    <div id="div4" runat="server" class="make-switch" data-on="warning" data-off="default">
								    <input type="checkbox" id="chkSubLanguage2" runat="server" class="chkSubLanguage2" ClientIDMode="Static"/>
							    </div>
						    </div>
                            <asp:Label ID="lblSubLanguage2Ex" CssClass="lblOptionExplanation" runat="server" Text="This displays Kanji Character for Japanese - Suitable for <b>Advanced</b> level students."  meta:resourcekey="lblSubLanguage2ExResource1"></asp:Label>
					    </div>
					    <div class="switch_container" style="display:none;">
						    <div class="sc_lbl">
							    <asp:Label ID="lblSound" runat="server" Text="Sound" meta:resourcekey="lblSoundResource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
							    <div class="make-switch" data-on="warning" data-off="default">
								    <input type="checkbox" id="chkSound" class="switch6" checked="checked"  />
							    </div>
						    </div>
					    </div>
					    <div class="switch_container" style="display:none;">
						    <div class="sc_lbl">
							    <asp:Label ID="lblLanguageOrder" runat="server" Text="Language Order" meta:resourcekey="lblLanguageOrderResource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
								    <div id="divorder" runat="server" class="make-switch" data-on="warning" data-off="danger" data-on-label="ENG" data-off-label="JP">
								    <input type="checkbox" id="chkLanguageOrder" runat="server" checked="checked" class="chkLanguageOrder"/>
							    </div>
						    </div>
					    </div>
                        <div class="switch_container">
						    <div class="sc_lbl">
							    <asp:Label ID="lblStep" runat="server" Text="Step"  meta:resourcekey="lblStepResource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
								    <div class="make-switch" data-on="warning" data-off="default">
								    <input type="checkbox" id="chkTooltip" class="switch6" checked="checked" runat="server" ClientIDMode="Static"/>
							    </div>
						    </div>
                            <asp:Label ID="lblStepEx"  CssClass="lblOptionExplanation" runat="server" Text="This shows each step for creating new messages on the Palette &#9312; - &#9316;."  meta:resourcekey="lblStepExResource1"></asp:Label>
					    </div>
                        <div class="switch_container">
						    <div class="sc_lbl">
							    <asp:Label ID="lblOrderByLearningLanguage" runat="server" Text="Order by Learning Language"  meta:resourcekey="lblOrderByLearningLanguageResource1"></asp:Label>
						    </div>
						    <div class="sc_conf">
								    <div class="make-switch" data-on="warning" data-off="default">
								    <input type="checkbox" id="chkOrderByLearningLanguage" class="switch6" runat="server" ClientIDMode="Static"/>
							    </div>
						    </div>
                            <asp:Label ID="lblOrderByLearningLanguageExp"  CssClass="lblOptionExplanation" runat="server" Text="Displays the phrase palette in the order of learning languages."  meta:resourcekey="lblOrderByLearningLanguageExpResource1"></asp:Label>
					    </div>
				    </div>

                    <div>
					    <asp:Button ID="btnSave" ClientIDMode="Static" CssClass="btnUpdate_profile btnSettingsSave"  Height="36px" runat="server" Text="Save" style="cursor:pointer; width:164px !important; float:left;" OnClientClick="return false;" BorderStyle="None" ValidationGroup="p" meta:resourcekey="btnSaveResource1"/> 
                        <asp:Label ID="lblSaveEx" style="display:none;" ClientIDMode="Static" runat="server" Text="Turning &quot;OFF&quot; Sequence and Native Language can make the Palette into a Puzzle."  meta:resourcekey="lblSaveExResource1"></asp:Label>
                    </div>
				    <asp:Label ID="lblSaveMessage" ClientIDMode="Static" runat="server" Text="Options Saved" meta:resourcekey="lblSaveMessageResource1" style="display:none;" ForeColor="Green" EnableViewState="false"></asp:Label>
			    </div>
		    </div>

		</div>
        <div  class="smc_word_container" id="smc_word_container">
            <div id="wordtabs">
				<ul>
					<li id="liTabWord" class="wordTab"><asp:HyperLink CssClass="send-msg-tabs5" ID="linkTabWord" href="#mtab2" runat="server" Text="Word" meta:resourcekey="linkTabWordResource1"/></li>
					<li id="liTabUserWord" class="wordTab"><asp:HyperLink CssClass="send-msg-tabs6" ID="linkTabUserWord" href="#mtab4" runat="server" Text="My Word" meta:resourcekey="linkTabUserWordResource1" /></li>
				</ul>
                <div id="mtab2">
                                <div id="divWordSearchContainer">
                                    <div class="steptitlepagingContainer">
                                        <div class="smc_search_container_search_box_txt">
                                            <asp:TextBox ID="txtSearchWord" CssClass="smcsc_search_txt clearable" runat="server" BorderColor="Transparent" meta:resourcekey="txtSearchSentenceResource1" ClientIDMode="Static" spellcheck="true"></asp:TextBox>
                                            <asp:ImageButton ID="ImageButton1" CssClass="smcsc_search_x" ImageUrl="~/Images/x.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1" style="display:none;"/>
                                            <asp:ImageButton ID="imgSearchWord" CssClass="smcsc_search_img" ImageUrl="~/Images/SearchF.png" BackColor="Transparent" Width="12px" Height="13px" BorderColor="Transparent" runat="server" OnClick="imgSearchWord_Click" ClientIDMode="Static" meta:resourcekey="imgSearchSentenceResource1"/>
                                        </div>
                                        <div class="divNumbercircle" id="step3b"  style="display:none;"><span>3*</span></div>
                                    </div>

                                </div>
                                        <div id="divWordPaletteOtherContainer">
                                            <div class="steptitlepagingContainer">
                                                <asp:Label ID="lblLabelWordPaging" CssClass="lblLabelWordPaging" runat="server" Text="Word palette" meta:resourcekey="lblLabelWordPagingResource1" ></asp:Label>
                                            </div>
                                        </div>


		            <div class="smc_bottom_container" id="smc_bottom_container">
			            <div class="sbc_left_container" id="sbc_left_container">
                            <div  class="smc_word_container" id="divWordPalette">
					            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"  style="width:100%;">
						            <ContentTemplate>

							            <%--<div class="loader" style="margin-right: auto; margin-left: auto; display: block; background-repeat: no-repeat;background-image: url(../images/loading.gif); height: 50px; width: 50px; margin-top: -50px;"></div>--%>
							            <div id="divWordContainer" runat="server" class="sContainer">
								    
							            </div>
							            <div class="wordpagingContainer">
                                            <div class="arrowContainer arrowlabelnumberContainer"></div>
                                            <div class="divWordPagingContainer">
                                                <div id="wordPaging" title="Page"></div>
                                            </div>
								            
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
                        </div>
                    </div>
                </div>
                <div id="mtab4">
                                        <div id="divWordPaletteOtherContainer2">
                                            <div class="steptitlepagingContainer">
                                                <div class="divNumbercircle" id="step3bb" style="display:none;"><span>3*</span></div>
                                            </div>
                                            <div class="steptitlepagingContainer">
                                                <asp:Label ID="lblLabelWordPagingUserCreated" CssClass="lblLabelWordPaging" runat="server" Text="My Word palette" meta:resourcekey="lblLabelWordPagingUserCreatedResource1" ></asp:Label>
                                            </div>
                                        </div>
		            <div class="smc_bottom_container" id="smc_bottom_container4">
			            <div class="sbc_left_container" id="sbc_left_container4">
                            <div  class="smc_word_container" id="divWordPaletteUserCreated" style="display:flex !important;">
					            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional"  style="width:100%;">
						            <ContentTemplate>
							            <%--<div class="loader" style="margin-right: auto; margin-left: auto; display: block; background-repeat: no-repeat;background-image: url(../images/loading.gif); height: 50px; width: 50px; margin-top: -50px;"></div>--%>
							            <div id="divWordContainerUserCreated" runat="server" class="sContainer">
								    
							            </div>
							            <div class="wordpagingContainer">
                                            <div class="arrowContainer arrowlabelnumberContainer"></div>
                                            <div class="divWordPagingContainer">
								                <div id="wordPagingusercreated" title="Page"></div>
                                            </div>
							            </div>
							            <asp:Button ID="Button1" runat="server" Text="Button" ClientIDMode="Static" style="display:none" OnClick="btnSearchWord_Click" meta:resourcekey="btnSearchWordResource1"/>
						            </ContentTemplate>
						            <Triggers>
							            <asp:AsyncPostBackTrigger ControlID="imgSearchWord" EventName="click" />
                                        <asp:AsyncPostBackTrigger ControlID="imgBack" EventName="click" />
                                        <asp:AsyncPostBackTrigger ControlID="imgForward" EventName="click" />
						            </Triggers>
					            </asp:UpdatePanel>
				            </div>
                        </div>
                    </div>
                </div>
                <div id="divCreateWordContainer">
                    <img id="btnAddWord" src="../Images/createmyword.png" onclick="FreeForm(); return false;" style="width: 180px;height: 42px;" />
                </div>
            </div>
             <div id="divUp" style="display:none;">
                <a id="arrowUp">
                    <span class="up"></span>
                </a>
            </div>


        </div>
	</div>
    <div class="smc_top_container" id="smc_top_container">
			<div class="smctc_msgbox" id="smctc_msgbox">
                <div id="divEmojiEditContainer" style="display:none;"></div>
				<div id="divSentence" class="sortable" runat="server"  style="display:none;">
                    <asp:Label ID="lblSentence" CssClass="smctc_lbl" runat="server" Text="Create Sentence to Add" AssociatedControlID="divSentence" meta:resourcekey="lblSentenceResource1" ClientIDMode="Static" ></asp:Label>
					<div></div>
				</div>
			</div>
			<div class="smctc_msgbox_btn" id="smctc_msgbox_btn" style="display:none;">
                <div style="height:40px;">
				    <div class="divNumbercircle" id="step3"><span>3</span></div>
                    <asp:Label ID="lblEditLabel" runat="server" Text="Create Sentence to Add" meta:resourcekey="lblSentenceResource1" ClientIDMode="Static" ></asp:Label>
                    <button type="button" id="btnAddWord1" onclick="FreeForm(); return false;" style="background-color:rgb(252, 234, 187);display:none; white-space: pre-wrap;">Create<br /> Words</button>
                    
                </div>
				<asp:Label ID="lblInstruction" Visible="false" CssClass="smctc-instructions" runat="server" Text=""  meta:resourcekey="lblInstructionResource1" ></asp:Label>
                <div id="divAddclearContainer">
				    <div class="smctc_msgbox_btnaddclear_container">
                        <img src="../Images/new/clear.png" id="btnClear" onclick="return ClearSelectedSentence(); return false;" />
					    <%--<asp:Button CssClass="smctc_msgbox_btnaddclear_container_lbl" ID="btnClear" style="background-image:url('../Images/btnClearMsg.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left;" Height="31px" BorderStyle="None" Width="117px" Text="Clear" runat="server" OnClientClick="return ClearSelectedSentence();" meta:resourcekey="btnClearResource1" />--%>
				    </div>
				    <div class="smctc_msgbox_btnaddclear_container">
                        <img src="../Images/new/add message.png" id="btnAdd" onclick="Add(); return false;" />
					    <%--<asp:Button CssClass="smctc_msgbox_btnaddclear_container_lbl" ID="btnAdd" style="background-image:url('../Images/new/add message.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:left;background-size: 100% 99%;text-align:center;" Height="31px" BorderStyle="None" Width="250px" Text="+ Add" runat="server" ClientIDMode="Static" OnClientClick="Add(); return false;" meta:resourcekey="btnAddResource1"  />--%>
                        <div class="divNumbercircle" id="step4"><span>4</span></div>
				    </div>
                </div>
			</div>
		</div>
	</div>

    </asp:Content>


<%--var touchStartTime;
var touchStartLocation;
var touchEndTime;
var touchEndLocation;

$thing.bind('touchstart'), function() {
     var d = new Date();
     touchStartTime = d.getTime();
     touchStartLocation = mouse.location(x,y);
});

$thing.bind('touchend'), function() {
     var d = new Date();
     touchEndTime= d.getTime();
     touchEndLocation= mouse.location(x,y);
     doTouchLogic();
});

function doTouchLogic() {
     var distance = touchEndLocation - touchStartLocation;
     var duration = touchEndTime - touchStartTime;

     if (duration <= 100ms && distance <= 10px) {
          // Person tapped their finger (do click/tap stuff here)
     }
     if (duration > 100ms && distance <= 10px) {
          // Person pressed their finger (not a quick tap)
     }
     if (duration <= 100ms && distance > 10px) {
          // Person flicked their finger
     }
     if (duration > 100ms && distance > 10px) {
          // Person dragged their finger
     }
}--%>