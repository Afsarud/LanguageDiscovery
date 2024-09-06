<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyFriendsRoom.aspx.cs" Inherits="Language.Discovery.MyFriendsRoom" meta:resourcekey="PageResource1" MaintainScrollPositionOnPostback="true" culture="auto" uiculture="auto" ValidateRequest="false" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server" enctype="multipart/form-data">
    <meta content="width=device-width, initial-scale=1" name="viewport" />
	<link href="../App_Themes/Default/jqueryui_custom/jquery-ui-1.10.4.custom.min.css" rel="stylesheet" />
	<link href="../App_Themes/Default/skeleton.css" rel="stylesheet" type="text/css" />
	<link href="../App_Themes/Default/user_profile.css" rel="stylesheet" type="text/css" />
    <link href="../App_Themes/Default/MyFriendsRoom.css?121sdfsdf212" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jqueryModal.js"></script>
    <link href="../App_Themes/Default/jqueryModal.css" rel="stylesheet" />
	<style>
		div.img
		{
			margin:2px;
			border:1px solid gray;
			height:auto;
			width:auto;
			float:left;
			text-align:center;
			cursor:pointer;
		}
		div.img img
		{
			display:inline;
			margin:3px;
			border:1px solid #ffffff;
		}
		div.img a:hover img
		{
			border:1px solid #0000ff;
		}
		.popover{
			width:400px;
		}
		div.color
		{
			margin:2px;
			border:1px solid gray;
			height:auto;
			width:auto;
			float:left;
			text-align:center;
			cursor:pointer;
		}
		div.skin
		{
			margin:2px;
			border:1px solid gray;
			height:auto;
			width:auto;
			float:left;
			text-align:center;
			cursor:pointer;
		}
		.prof_left_bottom {
			margin-top:-5px !important;
		}
    .ui-tooltip {
			background: linear-gradient(to bottom, rgba(251,200,67,1) 0%, rgba(248,164,38,1) 100%);
			border: 2px solid white;
		}
		.ui-tooltip {
			padding: 10px 20px;
			color: white;
			border-radius: 20px;
			font: bold 14px"Helvetica Neue", Sans-Serif;
			text-transform: uppercase;
			box-shadow: 0 0 7px black;
			background-color: orange !important;
		}
		.tooltip-inner {
			white-space: pre-wrap;
		}
        .ui-dialog-titlebar{
            display:none;
        }
	</style>
	<link id="MyStyleSheet" rel="stylesheet" type="text/css" runat="server" />
	<script src="../Scripts/Others.js"></script>
	<script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_beginRequest(beginRequest);

        function beginRequest() {
            prm._scrollPosition = null;
        }

        function SaveStatus() {
            var json = { Type: 'status', status: $('#<%=txtStatus.ClientID%>').val() };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {
                    $("#txtStatus").attr("title", "");
                    $("#txtStatus").tooltip("close");
                }
                else if (obj.Status == "foul") {
                    $("#txtStatus").attr("data-html", "true");
                    $("#txtStatus").attr("title", $("#hdnTooltipMessage").val());
                    $("#txtStatus").mouseenter();
                    $("#txtStatus").tooltip("open");
                }
                else {
                    alert('Error updating your status.');
                }
            });
        }

        function SaveSkin() {
            var json = { Type: 'skin', skin: $('#hdnSkin').val() };
             $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                 var obj = $.parseJSON(data)
                 if (obj.Status != "True") {
                     alert('Error updating your status.');
                 }
             });
         }

        function OpenAvatarWindow() {
            var json = { Type: 'avatar' };
            $.post("../PhotoDetailsHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                var sdiv = '';
                $.each(obj.avatars, function () {
                    if (this.ImageName.indexOf(".db") < 0) {
                        sdiv += '<div class="img" onclick="HighlightAvatar(this);SelectAvatar(this);" >' +
                            '<img src="{0}" alt="" width="75" height="75">&nbsp;&nbsp;</div>'.stringformat(this.ImageName);
                    }
                });
                $('#avatarContainer').append(sdiv);
                $("#avatargallery").dialog({
                    autoOpen: true,
                    height: 500,
                    width: 600,
                    position: ['center', 'center'],
                    modal: true,
                    title: $("#hdnSelectAvatar").val(),
                    close: function (event, ui) {
                        $('#avatarContainer').empty();
                    }
                });
            });
        }

        function InitializePopOver() {
            $('#btnChangeMyRoom').popover({
                container: 'body',
                delay: { hide: 0 },
                animation: false,
                trigger: 'manual',
                html: true,
                placement: 'bottom',
                title: $('#hdn'),
                content: function () {
                    var el = $('.popper-content');
                    el.append("<img src='../Images/x.png' width='16' height='16' style='position:absolute;right:5px;top:0px;cursor:pointer' onclick=\"ClosePopOver(); \" />");
                    return el.html();
                }
            });
        }

        function ClosePopOver() {
            $('#btnChangeMyRoom').popover('hide');
        }

        function SetupPopOver() {
            InitializePopOver();
            $('#btnChangeMyRoom').popover('show');
            $(".popover").draggable();
        }

        function SelectColor(el) {
            ChangeSkin($(el).data("color") + ".png");
            $('#hdnSkin').val($(el).attr("data-color") + ".png");
            //$.modal.close();
            //$('#btnReload').click();
        }

        function SelectSkin(el) {
            $('#hdnSkin').val($(el).attr("data-image"));
            $('#myroomColors').dialog('close');
            $('#btnReload').click();
        }

        function InitializeDateOfbirth() {
            $("#txtDateOfBirth").datepicker({
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                numberOfMonths: 1
            });
        }

        function Alert() {
            $("#alertmessage").dialog({
                modal: true,
                buttons: {
                    Ok: function () {
                        $(this).dialog("close");
                    }
                }
            });
        }

        function ShowHideDetailsImages() {
            var skin = $('#content').css("background-image");
             if (skin.indexOf('solid') > -1) {
                   $('#divRightContainer').hide();
                   $('#divPhotoContainer').hide();
                }
                else{
                    $('#divRightContainer').show();
                    $('#divPhotoContainer').show();
                }
        }

        $(function () {

                try {
                    if (window.self !== window.top) {
                        $("#header").hide()
                    }
                } catch (e) {
                }
            window.scrollTo = function (x, y) {
                return true;
            }

            ShowHideDetailsImages();

            
            $('#btnCloseAvatar').click(function (e) {
                $('#avatargallery').dialog('close');
            });
            $(".lblWriteNewEx").click(function () {
                $(".imgWriteNew").click();
            });

            $('#imgThemeOk').click(function () {
                $.modal.close();
                SaveSkin();
                //$('#btnReload').click();
            });
            $('#imgProfile').click(function () {
                var dlg = $("#prof_bottom_container").dialog({
                    autoOpen: true,
                    height: 500,
                    width: 600,
                    position: ['center', 'center'],
                    modal: true,
                    buttons: [{
                            id: "dialogCancel",
                            text: $('#hdnCancel').val(),
                            click: function () {
                                $(this).dialog("close");
                            }
                        }]
                });
                $('.ui-dialog').css('z-index', 103);
                $('.ui-widget-overlay').css('z-index', 102);
                dlg.parent().appendTo($("form:first"));
            });
            $("#txtStatus").tooltip({
                position: {
                    my: "left bottom+30",
                    at: "left bottom+30",
                },
                open: function () {
                    $(".ui-tooltip").attr("style", $(".ui-tooltip").attr("style") + ";background-color:orange !important;");
                },
                content: function () {
                    var element = $(this);
                    if (element.is("[title]")) {
                        return element.attr("title");
                    }
                }
            });

            $('#btnChangeAvatar').click(function (e) {
                OpenAvatarWindow();
                e.preventDefault();
            });

            $('#<%=imgAvatar.ClientID%>').dblclick(function () {
                OpenAvatarWindow();
            });

            $('#btnChangeMyRoom').click(function (e) {
                $('#divThemes').modal();
                //$("#myroomColors").dialog({
                //    autoOpen: true,
                //    height: 300,
                //    width: 300,
                //    position: ['center', 'center'],
                //    title: $('#hdnBackgroundColorLabel').val(),
                //    modal: true
                //});

                e.preventDefault();
            });

            $('#<%=txtStatus.ClientID%>').blur(function () {
                SaveStatus();
            });

            $(".imglike").click(function () {
                var onclickevent = $('.userBlock .wrapper').attr("onclick");
                $('.userBlock .wrapper').removeAttr("onclick");
                var img = $(this);
                var json = { Type: 'likephoto', userid: $(this).attr("data-userid"), userphotoid: $(this).attr("data-userphotoid"), ilike: $(this).attr("data-ilike") };
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
                        $('.userBlock .wrapper').attr("onclick", onclickevent);
                    }
                    else {
                        alert('Error updating your status.');
                        $('.userBlock .wrapper').attr("onclick", onclickevent);
                    }
                });

                ValidatorEnable(document.getElementById('rfvPassword'), false);
                ValidatorEnable(document.getElementById('revPassword'), false);
                ValidatorEnable(document.getElementById('cvConfirmPassword'), false);
            });

            ValidatorEnable(document.getElementById('rfvPassword'), false);
            ValidatorEnable(document.getElementById('revPassword'), false);
            ValidatorEnable(document.getElementById('cvConfirmPassword'), false);
        });

        function SelectTab() {
            $('#tabs').tabs({
                selected: $("#<%=hdnSelectedTab.ClientID%>").val(),
                activate: function (event, ui) {
                    $("#<%=hdnSelectedTab.ClientID%>").val(ui.newTab.index());
                    if (ui.newTab.index() > 0) {
                        checkforSelectedLevel();
                    }
                }
            });
            $('#tabs').tabs("option", "active", $("#<%=hdnSelectedTab.ClientID%>").val());
        }

        function SelectUser(el) {
            var userid = $(el).attr('data-userid');
            var url = $(location).attr('href');
            url = url.substring(0, url.lastIndexOf('/') + 1);
            $(location).attr('href', url + 'FriendsRoom?fid=' + userid);
        }

        function HighlightAvatar(el) {
            $(el).siblings('.img').css("border", "");
            $(el).css("border", "1px solid red");
            $(el).siblings('.img').removeClass("selected");
            $(el).addClass("selected");
        }

        function SelectAvatar(el) {
            var avatar = $('#<%=imgAvatar.ClientID%>');
            $(avatar).attr("src", $(el).find('img').attr('src'));
            $('#avatarContainer').empty();
            $('#avatargallery').dialog('close');
            SaveAvatar($(el).find('img').attr('src'));
        }

        function ChangeSkin(skin) {
            if (skin != "") {
                //$('#content').css("background-image", "url(/Images/Skin/" + skin + ")");
                $('#content').css("background-image", "url(../Images/Skin/myroom/" + skin +  ")");
            }
        }

        function SaveAvatar(avatar) {
            var json = { Type: 'avatar', avatar: avatar };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {
                    //Set the image in the Master page.
                    $('#imgOwner').attr("src", avatar);
                }
                else {
                    alert('Error updating your avatar.');
                }
            });
        }

        function ShowHidePassword() {
            $('#txtPassword').val("");
            $('#txtConfirmPassword').val("");

            if ($('#divPassword').css("display") == "none") {
                $('#divPassword').show();
                $('#hdnShouldValidate').val("1");
                ValidatorEnable(document.getElementById('rfvPassword'), true);
                ValidatorEnable(document.getElementById('revPassword'), true);
                ValidatorEnable(document.getElementById('cvConfirmPassword'), true);
                $('#tab1').scrollTop($('#tab1')[0].scrollHeight);
            }
            else {
                $('#divPassword').hide();
                $('#hdnShouldValidate').val("0");
                ValidatorEnable(document.getElementById('rfvPassword'), false);
                ValidatorEnable(document.getElementById('revPassword'), false);
                ValidatorEnable(document.getElementById('cvConfirmPassword'), false);
            }
        }

        function checkforSelectedLevel() {
            if ($('#hdnShouldValidate').val() == "1") {
                Page_ClientValidate("p");
            }
            if ($('#ddlGrade').val() == "0") {
                Alert();
                return false;
            } else {
                return true;
            }
        }
	</script>
	<div id="alertmessage" style="display: none;">
		<asp:Label ID="lblAlert" Text="" runat="server" meta:resourcekey="lblAlertResource1"></asp:Label>
	</div>
	<asp:HiddenField ID="hdnTooltipMessage" runat="server" ClientIDMode="Static" meta:resourcekey="hdnTooltipMessageResource1"/>
	<asp:HiddenField ID="hdnColor" runat="server" ClientIDMode="Static" />
	<asp:HiddenField ID="hdnSkin" runat="server" ClientIDMode="Static" />
	<asp:HiddenField ID="hdnBackgroundColorLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnBackgroundColorLabelResource1"/>
	<asp:HiddenField ID="hdnSelectAvatar" runat="server" ClientIDMode="Static" meta:resourcekey="hdnSelectAvatarResource1"/>
    <asp:HiddenField ID="hdnCancel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnCancelResource1"/>
	<asp:Button ID="btnReload" runat="server" OnClick="btnReload_Click" ClientIDMode="Static" style="display:none;" />
	
	<div class="profile_left_Container" id="profile_left_Container">
		<div class="prof_left_frame" id="prof_left_frame">
			<div class="prof_frame_info" id="prof_frame_info">
				<div class="prof_info_name" id="prof_info_name">
                    <div>
                        <asp:LinkButton ID="linkName" Text="Lucy" runat="server" OnClick="linkName_Click" ClientIDMode="Static" meta:resourcekey="linkNameResource1" ToolTip="Click to send Message"></asp:LinkButton>
					    <asp:Label ID="lblName" Text="Lucy" runat="server" meta:resourcekey="lblName" style="display:none;"></asp:Label>
                    </div>
				</div>
				<div class="prof_info_location" id="prof_info_location">
					<asp:Label ID="lblLocation" Text="Melbourne, Australia" runat="server" meta:resourcekey="lblLocationResource1"></asp:Label>
				</div>
				<div class="prof_info_location_upload_img" id="prof_info_location_upload_img">
						
				</div>
			</div>
        <div class="prof_top_container" id="prof_top_container">
			<img id="imgStatusBox" src="../Images/new/status.png" />
			<div class="prof_top_con_lblupdatemystatus" id="prof_top_con_lblupdatemystatus">
				<asp:Label ID="lblStatus" CssClass="lblUpdateMyStatus" Text="Update My Status" runat="server" meta:resourcekey="lblStatusResource1" style="display:none;"></asp:Label>
				<img id='like' src="../Images/heartLike.png" class="imglike_UpdateMyStatus" style="display: none;" />
				<asp:Label ID="lblLikeCount" CssClass="lblLikeCount_UpdateMyStatus" Text="0" runat="server" meta:resourcekey="lblLikeCountResource1" style="display: none;"></asp:Label>
			</div>
			<div class="prof_top_con_txtupdatemystatus" id="prof_top_con_txtupdatemystatus">
				<asp:TextBox ID="txtStatus" CssClass="prof_top_con_txtupdatemystatus_box" runat="server" TextMode="MultiLine" BackColor="Transparent" BorderWidth="0" meta:resourcekey="txtStatus" ReadOnly="true" ClientIDMode="Static" AutoComplete="off" AutoCompleteType="Disabled" spellcheck="true"></asp:TextBox><span id="spanStatus" style="display:initial;"><img class="prof_top_con_txtupdatemystatus_boxcheck" src="../Images/check.png"/></span>
				<asp:Button ID="btnSaveStatus" runat="server" Visible="False" Text="Save Status" OnClientClick="SaveStatus(); return false;" meta:resourcekey="btnSaveStatusResource1" />
			</div>
            <div id="divPhotoContainer">
                <asp:Image ID="imgPhoto" ClientIDMode="Static" runat="server" />
                <asp:Label runat="server" ID="lblCaption" ClientIDMode="Static"></asp:Label>
                <asp:Button ID="btnAddPhoto" CssClass="btnAddPhoto" Height="44px" BorderStyle="None" Width="194px"  runat="server" ClientIDMode="Static" Text="" Visible="false" OnClick="btnAddPhoto_Click" />
            </div>
		</div>
        <div class="lblLikeCount">
			<div style="padding-left: 50px;float:left;">
				<img id="imgStar" src="../Images/like_star.png" alt=""/>
			</div>
			<div id="lblCountLikeLabelContainer" >
				<asp:Label ID="lblCountLikeLabel"  runat="server" Text="Stars Received:" meta:resourcekey="lblCountLikeLabelResource1"></asp:Label>
			</div>
		</div>

			<div class="prof_left_top" id="prof_left_top">
				<div id="changemyroom">
                    <div id="divMyRoomButtonContainer" style="display:none;">
                        <asp:Button ID="btnChangeAvatar" CssClass="buttons" style="background-image:url('../Images/new/avatar.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:center; padding-left:15px; background-size: cover; border-radius:8px;"  Height="36px" BorderStyle="None" Width="194px"  runat="server" Text="" ClientIDMode="Static" />
					    <asp:Button ID="btnChangeMyRoom" CssClass="buttons" style="background-image:url('../Images/new/room.png'); background-color:Transparent; cursor:pointer; background-repeat:no-repeat; background-position:center; padding-left:15px;background-size: cover; border-radius:8px;" Height="36px" BorderStyle="None" Width="194px"  runat="server" Text=""  ClientIDMode="Static" />
                    </div>
                    <div class="prof_frame_avatar" id="prof_frame_avatar">
					    <asp:Image ID="imgAvatar" CssClass="prof_left_avatar_img" runat="server" ImageUrl="~/Images/no_avatar.png" meta:resourcekey="imgAvatarResource1" AlternateText="Double click to change your avatar" ToolTip="Double click to change your avatar" ClientIDMode="Static" />
					    <asp:HyperLink ID="linkChangeAvatar" runat="server" meta:resourcekey="linkChangeAvatarResource1" Text="Change Avatar" Visible="false" ></asp:HyperLink> 
				    </div>
                    <div id="divLinkContainer">
                        <asp:ImageButton ID="imgWriteNew" class="imgWriteNew" runat="server" OnClick="imgWriteNew_Click" ImageUrl="~/Images/WriteNew.png" meta:resourcekey="imgWriteNewResource1" AlternateText="Write New Message" ToolTip="Write New Message" ClientIDMode="Static" style="width:30px;height:30px;vertical-align:middle;" BackColor="Transparent" BorderColor="Transparent" BorderStyle="None"/>
                        <asp:Label ID="lblWriteNewEx" CssClass="lblWriteNewEx" Text="Write a New Message!" runat="server" meta:resourcekey="lblWriteNewExResource1"></asp:Label>
                    </div>

				</div>
			</div>
    </div>
      
		<div class="prof_MyPhoto_Container" id="prof_MyPhoto_Container" style="display:none;">
			<div class="prof_left_bottom" id="prof_left_bottom">
				<div class="prof_left_bot_upload_img" id="prof_left_bot_upload_img">
					<asp:Label ID="lblMyPhoto" CssClass="prof_left_bot_upload_img_info" Text="My Photos" runat="server" meta:resourcekey="lblMyPhotoResource1"></asp:Label>
				</div>
				<div class="prof_left_bot_divider" id="prof_left_bot_divider">
					<div id="divMyPhoto" class="divMyPhoto" runat="server">                            
						<asp:ListView ID="listPhoto" runat="server">
							<LayoutTemplate>
								<asp:PlaceHolder ID="groupPlaceholder" runat="server" />
							</LayoutTemplate>
							<GroupTemplate>
								<div style="text-align:center;">
									<asp:PlaceHolder ID="itemPlaceholder" runat="server" />
								</div>
							</GroupTemplate>
							<ItemTemplate>
								<div class="wrapper" id="myphotos">
									<asp:Image ID="picAlbum" CssClass="prof-image" runat="server" AlternateText=<%# Eval("Description") %> ImageUrl='<%# Eval("Photo") %>' Width="350px" Height="290px" meta:resourcekey="picAlbum" />
									<div class="description">
										<p class="description_content"><span><%#Eval("Description") %></span>
											<img id='like' src="../Images/heartLike.png" style="display:none;"/>
											<span class="likecount" style="display:none;"><%#Eval("LikeCount") %></span>
										</p>
									</div>
								</div>
								<br />
							</ItemTemplate>
							<EmptyItemTemplate>
							</EmptyItemTemplate>
						</asp:ListView>
					</div>
					
					<asp:Label ID="lblUploadPhotoLabel" Text="Maximum 2MB" runat="server" meta:resourcekey="lblUploadPhotoLabelResource1" ClientIDMode="Static"></asp:Label>
				</div>
			</div>
		</div>
	</div>
	<div class="profile_right_Container" id="profile_right_Container">
		
		<div class="prof_bottom_container" id="prof_bottom_container"  style="display:none;">
			<div class="tcp_lbl_title">
				<asp:Label ID="lblAboutLabel" runat="server" Text="About Me" Font-Bold="True" meta:resourcekey="lblAboutLabelResource1"></asp:Label>
			</div>
			<div class="tcp_lbl_title_container">
				<asp:Label ID="lblAboutMe" runat="server" Text="This will help new friends find you." meta:resourcekey="lblAboutMeResource1"></asp:Label>  
			</div>
			<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" style="top:0;">
				<ContentTemplate>
					<asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />
					<div id="tabs">
						<ul class="tabs_links_menu">
							<li><asp:HyperLink ID="HyperLink1" href="#tab1" runat="server" Text="User Information" meta:resourcekey="HyperLink1Resource1"/></li>
							<li><asp:HyperLink ID="HyperLink2" href="#tab2" runat="server" Text="Things I like" meta:resourcekey="HyperLink2Resource1" /></li>
							<li><asp:HyperLink ID="HyperLink3" href="#tab3" runat="server" Text="About Me" meta:resourcekey="HyperLink3Resource1" /></li>
							<li class="updateContainer"><asp:Button ID="btnUpdate" ClientIDMode="Static" CssClass="btnUpdate_profile" Width="97px" Height="36px" runat="server" Text="" style="display:none; background-image:url('../Images/btnUpdateProfile.png');padding-left:7px; background-color:Transparent; cursor:pointer; background-repeat:no-repeat;"  BorderStyle="None" OnClick="btnUpdate_Click" ValidationGroup="p" meta:resourcekey="btnUpdateResource1" OnClientClick="return checkforSelectedLevel();"/> </li>
						</ul>
						<div id="tab1" class="panel_profile">
							<div class="tabl_container_profile">
								<div class="tcp_lbl_title">
									<asp:Label ID="lblUserNameLabel" runat="server" Text="User Name" Font-Bold="True" meta:resourcekey="lblUserNameLabelResource1"></asp:Label>
								</div>
									<div class="tcp_lbl_title_container">
										<asp:Label ID="lblUserName" runat="server" meta:resourcekey="lblUserNameResource1"></asp:Label> 
									</div>
								<div class="tcp_lbl_title" style="display:none;">
									<asp:Label ID="lblSchoolLabel" runat="server" Text="School" Font-Bold="True" meta:resourcekey="lblSchoolLabelResource1"></asp:Label> 
								</div>
								<div class="tcp_lbl_title_container" style="display:none;">
									<asp:Label ID="lblSchool" runat="server" Text="School" Font-Bold="True"></asp:Label> 
								</div>
								<div class="tcp_lbl_title" style="display:none;">
									<asp:Label ID="lblBirthdayLabel" runat="server" Text="Birthday:" Font-Bold="True" meta:resourcekey="lblBirthDayLabelResource1"></asp:Label>
								</div>
								<div class="tcp_lbl_title_container" style="display:none;">
									<asp:TextBox ID="txtDateOfBirth" runat="server" ClientIDMode="Static"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvDateOfBirth" ClientIDMode="Static"  runat="server" ErrorMessage="Date of Birth is required" ControlToValidate="txtDateOfBirth" ValidationGroup="p" ForeColor="Red" Display="Dynamic" Enabled="false">*</asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate = "txtDateOfBirth" ValidationGroup="p" ForeColor="Red"
										ValidationExpression = "^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$"
										runat="server" ErrorMessage="Invalid Start Date format. Valid Date Format dd/MM/yyyy">*
									</asp:RegularExpressionValidator>
								</div>
								<div class="tcp_lbl_title" style="display:none;">
									<asp:Label ID="lblAgeLabel" runat="server" Text="Age:" Font-Bold="True" meta:resourcekey="lblAgeLabelResource1"></asp:Label>
								</div>
									<div class="tcp_lbl_title_container" style="display:none;">
										<asp:Label ID="lblAge" runat="server" meta:resourcekey="lblAgeResource1"></asp:Label>  
									</div>
								<div class="tcp_lbl_title">
									<asp:Label ID="lblLevelLabel" runat="server" Text="Level:" Font-Bold="True" meta:resourcekey="lblLevelLabelResource1"></asp:Label>
								</div>
								<div class="tcp_lbl_title_container">
									<asp:Label ID="lblLevel" runat="server" meta:resourcekey="lblLevelResource1" Visible="false" ></asp:Label>
									<asp:DropDownList ID="ddlGrade" runat="server" meta:resourcekey="ddlGradeResource1" ValidationGroup="p" ClientIDMode="Static"></asp:DropDownList>
									<asp:CompareValidator ID="cfvGrade" runat="server" ErrorMessage="Grade is Required" ValidationGroup="p" ForeColor="Red" Display="Dynamic" ClientIDMode="Static" meta:resourcekey="cfvGradeResource1"  Operator="NotEqual" ValueToCompare="0" ControlToValidate="ddlGrade" Enabled="False">*</asp:CompareValidator>
								</div>
								<div class="tcp_lbl_title">
									<asp:Label ID="lblGenderLabel" runat="server" Text="Gender:" Font-Bold="True" meta:resourcekey="lblGenderLabelResource1"></asp:Label>
								</div>
								<div class="tcp_lbl_title_container">
									<asp:DropDownList ID="ddlGender" runat="server" meta:resourcekey="ddlGenderResource1">
										<asp:ListItem Text="Male" Value="Male" meta:resourcekey="ListItemResource1"></asp:ListItem>
										<asp:ListItem Text="Female" Value="Female" meta:resourcekey="ListItemResource2"></asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="tcp_lbl_title">
									<asp:Label ID="lblHometownLabel" runat="server" Text="Home Town:" Font-Bold="True" meta:resourcekey="lblHometownLabelResource1"></asp:Label>
								</div>
									<div class="tcp_lbl_title_container">
										<asp:Label ID="lblHometown" runat="server" meta:resourcekey="lblHometownResource1" Visible="false"></asp:Label>  
										<asp:DropDownList ID="ddlHomeTown" runat="server"></asp:DropDownList>
									</div>
								<div class="tcp_lbl_title">
									<asp:Label ID="lblClassLabel" Visible="false" runat="server" Text="Class:" Font-Bold="True" meta:resourcekey="lblClassLabelResource1"></asp:Label> 
								</div>
									<div class="tcp_lbl_title_container">
										<asp:DropDownList ID="ddlClass" Visible="false" runat="server" meta:resourcekey="ddlClassResource1"></asp:DropDownList>
									</div>
								<div class="tcp_lbl_title" style="display:none;">
									<asp:LinkButton ID="linkChangePassword" runat="server"  OnClientClick="ShowHidePassword();return false;" meta:resourcekey="linkChangePasswordResource1">Change Password</asp:LinkButton>
								</div> 
								<div class="tcp_lbl_title_container">
									<div id="divPassword" style="display:none;width:100%;" >
										<div style="width: 200px; float: left;">
											<asp:HiddenField ID="hdnShouldValidate" runat="server" Value="0" ClientIDMode="Static" />
											<asp:Label ID="lblPasswordLabel" runat="server" Text="Password" AssociatedControlID="txtPassword" meta:resourcekey="lblPasswordLabelResource1"></asp:Label>
											<asp:TextBox ID="txtPassword" TextMode="Password" runat="server" meta:resourcekey="txtPasswordResource1"></asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" ValidationGroup="p" ForeColor="Red" ClientIDMode="Static" meta:resourcekey="rfvPasswordResource1">*</asp:RequiredFieldValidator>
											<asp:RegularExpressionValidator ID="revPassword" ControlToValidate="txtPassword" ValidationGroup="p" ForeColor="Red" ClientIDMode="Static"
												ValidationExpression = "^(?=.*[A-Z])^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$"
												runat="server" ErrorMessage="">*
											</asp:RegularExpressionValidator>
											<asp:Label ID="lblConfirmPasswordLabel" runat="server" Text="Confim Password" AssociatedControlID="txtConfirmPassword" meta:resourcekey="lblConfirmPasswordLabelResource1"></asp:Label>
											<asp:TextBox ID="txtConfirmPassword" TextMode="Password" runat="server" meta:resourcekey="txtConfirmPasswordResource1"></asp:TextBox>
											<asp:CompareValidator ID="cvConfirmPassword" runat="server" ErrorMessage="Password not matched" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ValidationGroup="p" ForeColor="Red" ClientIDMode="Static" meta:resourcekey="cvConfirmPasswordResource1">*</asp:CompareValidator>
													<asp:LinkButton ID="linkCancel" runat="server" OnClientClick="ShowHidePassword(); return false;" meta:resourcekey="linkCancelResource1">Cancel</asp:LinkButton>
										</div>
										<div id="divReminder" style="float: right; width: 100px; border: 1px solid red;">
											<asp:Label ID="lblReminder" runat="server" Text="Password must be at least 7 characters, mix of letters and numbers" ForeColor="red" meta:resourcekey="lblReminderResource1"></asp:Label>
										</div>
									</div>
									<asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="p" BorderColor="Red" BorderStyle="Solid" BorderWidth="1px" ClientIDMode="Static"  HeaderText="Please check your inputs" ForeColor="Red" Width="200px" meta:resourcekey="ValidationSummary1Resource1" />
								</div>
							</div>
						</div>
						<div id="tab2" class="panel_profile">
							<asp:CheckBoxList ID="chkInterestGroup" runat="server" DataTextField="InterestName" DataValueField="InterestID" ClientIDMode="Static" RepeatColumns="1" Width="100%" CssClass="CheckboxList " meta:resourcekey="chkInterestGroupResource1"></asp:CheckBoxList>
						</div>
						<div id="tab3" class="panel_profile">
							<asp:CheckBoxList ID="chkAboutMe" runat="server" DataTextField="AboutMe" DataValueField="AboutMeID" ClientIDMode="Static" RepeatColumns="1" Width="100%" CssClass="CheckboxList " meta:resourcekey="chkAboutMeResource1"></asp:CheckBoxList>
						</div>
					</div>        
					<asp:Image ID="imgSuccess" runat="server" EnableViewState="False" Visible="False" ImageUrl="~/Images/check.png" meta:resourcekey="imgSuccessResource1" style="display:none;" />
				</ContentTemplate>
				<Triggers>
					<asp:PostBackTrigger ControlID="btnUpdate"/>
				</Triggers>
			</asp:UpdatePanel>

			<%-- 
			<ul style="visibility:collapse;">
				<li class="split"><asp:Label ID="lblWhoLikesMe" Text="My Friends" runat="server" meta:resourcekey="lblWhoLikesMeResource1"></asp:Label></li>
				<li class="split" style="text-align:right;"><asp:Button ID="btnViewFriends" runat="server" PostBackUrl="~/Student/SearchFriend.aspx" Text="View Friends" meta:resourcekey="btnViewFriendsResource1" /> </li>
				<li>
					<div id="div1" runat="server" style="border:1px outset gray;width:400px;height:auto;overflow:scroll;">
						<asp:ListView ID="ListView1" runat="server">
							<LayoutTemplate>
								<asp:PlaceHolder ID="groupPlaceholder" runat="server" />
							</LayoutTemplate>
							<GroupTemplate>
								<div style="text-align:center;" class="userBlock" >
									<asp:PlaceHolder ID="itemPlaceholder" runat="server" />
								</div>
							</GroupTemplate>
							<ItemTemplate>
								<div>
									<center>
										<table>
											<tr>
												<td  rowspan="2">
													<asp:Image ID="imgAvatar" runat="server" Width="65px" Height="65px" ImageUrl='<%# Eval("Avatar") %>' meta:resourcekey="imgAvatarResource2" />
												</td>
												<td style="text-align:left;">
													<span><%#Eval("FirstName") %></span><br />
												</td>
											</tr>
										</table>
									</center>
								</div>
								<div class="wrapper" onclick="SelectUser(this);"  data-userid='<%# Eval("UserID") %>' id="myfriends" data-userphotoid='<%# Eval("UserPhotoID") %>'  data-ilike='<%# Eval("ILike") %>' >
									<asp:Image ID="picAlbum" runat="server" AlternateText='<%# Eval("Description") %>' ImageUrl='<%# Eval("Photo") %>' Width="300px" Height="300px" meta:resourcekey="picAlbumResource2" />
									<div class="description">
										<p class="description_content"><span><%#Eval("Description") %></span>
											<img id='like' src='<%# Eval("LikeImage") %>' class="imglike" data-userid='<%# Eval("UserID") %>' id="myfriends" data-userphotoid='<%# Eval("UserPhotoID") %>'  data-ilike='<%# Eval("ILike") %>' />
											<span class="likecount"><%#Eval("LikeCount") %></span>
										</p>
									</div>
								</div>
							</ItemTemplate>
							<EmptyItemTemplate>
							</EmptyItemTemplate>
						</asp:ListView>                        
					</div>
				</li>
			</ul>
			--%>
		</div>

		<div id="avatargallery" style="width:600px;display:none; visibility:visible;" title="Select Avatar">
			<div id="avatarContainer" style="overflow:auto;height:auto;"></div>
			<asp:Button ID="btnCloseAvatar" runat="server" Text="Close"  ClientIDMode="Static" meta:resourcekey="btnCloseAvatarResource1" />
		</div>


		<div id="myroomColors" style="width:600px;display:none;height:600px; visibility:visible;" title="Select Background Color">
			<div id="Div2" style="overflow:auto;height:auto;width:100%;" >
				<%--<div id="default" class="color" style="width:30px;height:30px;background-color:#f9f8f8;" data-color="default" onclick="SelectColor(this);" ></div>
				<div id="purple" class="color" style="width:30px;height:30px;background-color:purple;" data-color="Purple" onclick="SelectColor(this);" ></div>
				<div id="blue" class="color" style="width:30px;height:30px;background-color:blue;" data-color="Blue" onclick="SelectColor(this);"></div>
				<div id="green" class="color" style="width:30px;height:30px;background-color:#285c00;" data-color="Green" onclick="SelectColor(this);"></div>
				<div id="pink" class="color" style="width:30px;height:30px;background-color:#9C1C6B;" data-color="DarkPink" onclick="SelectColor(this);"></div>
				<div id="darkpink" class="color" style="width:30px;height:30px;background-color:#ee22c3;" data-color="Pink" onclick="SelectColor(this);"></div>
				<div id="orange" class="color" style="width:30px;height:30px;background-color:#17d1fa;" data-color="SkyBlue" onclick="SelectColor(this);"></div>
				<div id="teal" class="color" style="width:30px;height:30px;background-color:TEal;" data-color="Teal" onclick="SelectColor(this);"></div>
				<div id="maroon" class="color" style="width:30px;height:30px;background-color:#b33941;" data-color="Maroon" onclick="SelectColor(this);"></div>
				<div id="tealblue" class="color" style="width:30px;height:30px;background-color:#336699;" data-color="TealBlue" onclick="SelectColor(this);"></div>
				<div id="regentblue" class="color" style="width:30px;height:30px;background-color:#ACD1E9;" data-color="RegentBlue" onclick="SelectColor(this);"></div>
				<div id="Div1" class="color" style="width:30px;height:30px;background-color:#dbedd6;" data-color="Pale1" onclick="SelectColor(this);"></div>
				<div id="Div3" class="color" style="width:30px;height:30px;background-color:#E6FFFF;" data-color="Pale2" onclick="SelectColor(this);"></div>
				<div id="Div4" class="color" style="width:30px;height:30px;background-color:#ECC8EC;" data-color="Pale3" onclick="SelectColor(this);"></div>
				<div id="Div5" class="color" style="width:30px;height:30px;background-color:#dadbf1;" data-color="Pale4" onclick="SelectColor(this);"></div>
				<div id="Div6" class="color" style="width:30px;height:30px;background-color:#ffebeb;" data-color="Pale5" onclick="SelectColor(this);"></div>
				<div id="Div7" class="color" style="width:30px;height:30px;background-color:#e8e8ae;" data-color="Pale6" onclick="SelectColor(this);"></div>--%>
			</div>
			<fieldset>
				<legend>Skin</legend>
				<div style="border:1px solid black;">
					<div id="Div15" class="skin" style="width:30px;height:30px;background-color:#f9f8f8;" data-image="" onclick="SelectSkin(this);"></div>
					<div id="Div8" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/Chrysanthemum_thumb.jpg)" data-image="Chrysanthemum.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div9" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/Desert_thumb.jpg)" data-image="Desert.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div10" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/Hydrangeas_thumb.jpg)" data-image="Hydrangeas.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div11" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/Jellyfish_thumb.jpg)" data-image="Jellyfish.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div12" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/Koala_thumb.jpg)" data-image="Koala.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div13" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/Penguins_thumb.jpg)" data-image="Penguins.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div14" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/Tulips_thumb.jpg)" data-image="Tulips.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div16" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/img2_thumb.jpg)" data-image="img2.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div17" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/img3_thumb.jpg)" data-image="img3.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div18" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/img4_thumb.jpg)" data-image="img4.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div19" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/img5_thumb.jpg)" data-image="img5.jpg" onclick="SelectSkin(this);"></div>
					<div id="Div20" class="skin" style="width:30px;height:30px;background-image:url(/Images/Skin/img6_thumb.jpg)" data-image="img6.jpg" onclick="SelectSkin(this);"></div>
				</div>
			</fieldset>
			<asp:Button ID="Button1" runat="server" Text="Close"  ClientIDMode="Static" meta:resourcekey="btnCloseAvatarResource1" />

		</div>
        <div id="divRightContainer">
            <div id="divClickBook">
                <asp:Image runat="server" ID="imgClickBook" ClientIDMode="Static" AlternateText="" ImageUrl="~/Images/new/E_clickbook.png" meta:resourcekey="imgClickBookResource1" />
            </div> 
            <div id="divBookContainer" >
                <img id="imgProfile" src="../Images/new/book.png" alt="" />
            </div>
            <div id="divPlantsContainer" >
                <img src="../Images/new/plants.png"  alt="" />
            </div>
        </div>

        <div id="divThemes" class="modal" style="display:none;">
            <div id="firstRow" class="rows">
                <div class="divColorContainer">
                    <div id="purple" class="theme" data-color="Purple" style="background-color:purple;color:purple;" onclick="SelectColor(this);" >
                        <label>Purple</label>
                    </div>
                    <div id="pink" class="theme" data-color="Pink" style="background-color:pink;color:pink;" onclick="SelectColor(this);" >
                        <label>Pink</label>
                    </div>
                    <div id="scarlet" class="theme" data-color="Scarlet" style="background-color:#FF2400;color:#FF2400;" onclick="SelectColor(this);" >
                        <label>Scarlet</label>
                    </div>
                    <div id="orange" class="theme" data-color="Orange" style="background-color:orange;color:orange;" onclick="SelectColor(this);" >
                        <label>Orange</label>
                    </div>
                    <div id="sunlight" class="theme" data-color="Sunlight" style="background-color:#FFDE00;color:#FFDE00;" onclick="SelectColor(this);" >
                        <label>Sunlight</label>
                    </div>
                    <div id="lilac" class="theme" data-color="Lilac" style="background-color:#AA98A9;color:#AA98A9;" onclick="SelectColor(this);" >
                        <label>Lilac</label>
                    </div>
                </div>
            </div>
            <div id="secondRow" class="rows">
                <div class="divColorContainer">
                    <div id="navy" class="theme" data-color="Navy" style="background-color:navy;color:navy;" onclick="SelectColor(this);" >
                        <label>Navy</label>
                    </div>
                    <div id="skyblue" class="theme" data-color="Skyblue" style="background-color:skyblue;color:skyblue;" onclick="SelectColor(this);" >
                        <label>Sky Blue</label>
                    </div>
                    <div id="cyan" class="theme" data-color="Cyan" style="background-color:cyan;color:cyan;" onclick="SelectColor(this);" >
                        <label>Cyan</label>
                    </div>
                    <div id="lime" class="theme" data-color="Lime" style="background-color:lime;color:lime;" onclick="SelectColor(this);" >
                        <label>Lime</label>
                    </div>
                    <div id="brown" class="theme" data-color="Brown" style="background-color:brown;color:brown;" onclick="SelectColor(this);" >
                        <label>Brown</label>
                    </div>
                    <div id="alder" class="theme" data-color="Alder" style="background-color:rosybrown;color:rosybrown;" onclick="SelectColor(this);" >
                        <label>Alder</label>
                    </div>
                </div>
            </div>
            <div id="thirdRow" class="rows">
                <div class="divColorContainer">
                    <div id="beige" class="theme" data-color="Beige" style="background-color:#F5F5DC;color:#F5F5DC;" onclick="SelectColor(this);" >
                        <label>Beige</label>
                    </div>
                    <div id="peach" class="theme" data-color="Peach" style="background-color:#FFE5B4;color:#FFE5B4;" onclick="SelectColor(this);" >
                        <label>Peach</label>
                    </div>
                    <div id="amber" class="theme" data-color="Amber" style="background-color:#FFBF00;color:#FFBF00;" onclick="SelectColor(this);" >
                        <label>Amber</label>
                    </div>
                    <div id="grassgreen" class="theme" data-color="Grassgreen" style="background-color:#7ec850;color:#7ec850;" onclick="SelectColor(this);" >
                        <label>GrassGreen</label>
                    </div>
                    <div id="seaweed" class="theme" data-color="Seaweed" style="background-color:#437C17;color:#437C17;" onclick="SelectColor(this);" >
                        <label>Seaweed</label>
                    </div>
                    <div id="ruby" class="theme" data-color="Ruby" style="background-color:#F62217;color:#F62217;" onclick="SelectColor(this);" >
                        <label>Ruby</label>
                    </div>
                </div>
            </div>
            <div id="divImgOkContainer">
                <img id="imgThemeOk" src="../Images/new/circlesave.png" />
            </div>
        </div>
	</div>
</asp:Content>
