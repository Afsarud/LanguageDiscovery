<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FriendsRoom.aspx.cs" Inherits="Language.Discovery.FriendsRoom" meta:resourcekey="Page" culture="auto" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
       <div>test</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server" enctype="multipart/form-data">
    <script src="../Scripts/Others.js"></script>
    <style>

        div.wrapper{
	        /*float:left;*/ /* important */
            margin-left:auto;
            margin-right:auto;
            width:100%;
	        position:relative; /* important(so we can absolutely position the description div */ 
            
        }
        div.description{
	       
	        
	        text-align:center;
	        width:100%;
	        /* styling bellow */
	        background-color:black;
	        font-family: 'tahoma';
            font-family: Arial !important;
	        font-size:15px;
	        color:white;
	        opacity:0.6; /* transparency */
	        filter:alpha(opacity=60); /* IE transparency */
        }
        p.description_content{
	        padding:5px;
	        margin:0px;
            
        }

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

         .split { width: 33%; float: left; }

             .CheckboxList input
        {
            float:left;
            clear:both;
        }
                  .panel
        {
            height:300px;
            overflow:auto;

        }
     
    </style>
    <link id="MyStyleSheet" rel="stylesheet" type="text/css" runat="server" />
    <script type="text/javascript">
//        function Like() {
//            var json = { Type : 'Status', status: $('#<%=lblStatus.ClientID%>').val() };
//          $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
        //                var obj = $.parseJSON(data)
        //if (obj.Status == "True") {
        //$('#spanStatus').css("display", "");
        //}
        //else
        //alert('Error updating your status.');
        //
        //});
        //
        //}
        $(function () {
            //$("#linkName").tooltip({ position: { my: "left+15 center", at: "right center" } });
            //$("#linkName").mouseenter();
            $(".lblWriteNewEx").click(function () {
                $(".imgWriteNew").click();
            });
            $('#myfriends').click(function (el) {
                
                var userid = $(this).attr('data-userid');
                var url = $(location).attr('href');

                url = url.substring(0, url.lastIndexOf('/') + 1);

                $(location).attr('href', url + 'FriendsRoom?fid=' + userid);
            });

            $(".imglike").click(function () {
                
                //var onclickevent = $('.userBlock .wrapper').attr("onclick");
                //$('.userBlock .wrapper').removeAttr("onclick");
                var img = $(this);
                var json = { Type: 'like', userid: $(this).attr("data-userid"), ilike: $(this).attr("data-ilike"), userid: $('#hdnUserID').val(), userstatusid: $(this).attr("data-userstatusid") };
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
                        //$('.userBlock .wrapper').attr("onclick", onclickevent);
                    }
                    else {
                        alert('Error updating your status.');
                        //$('.userBlock .wrapper').attr("onclick", onclickevent);
                    }
                });


            });
        });

        function SelectTab() {
            $('#tabs').tabs({
                selected: $("#<%=hdnSelectedTab.ClientID%>").val(),
                activate: function (event, ui) {
                    $("#<%=hdnSelectedTab.ClientID%>").val(ui.newTab.index());

                    }
            });
                    $('#tabs').tabs("option", "active", $("#<%=hdnSelectedTab.ClientID%>").val());
             }


        function HighlightAvatar(el) {
            $(el).siblings('.img').css("border", "");
            $(el).css("border", "1px solid red");
        }
        function SelectAvatar(el) {
            
            var avatar = $('#<%=imgAvatar.ClientID%>');
            $(avatar).attr("src", $(el).find('img').attr('src'));
            $('#avatargallery').empty();
            $('#avatargallery').dialog('close');
            SaveAvatar($(el).find('img').attr('src'));
        }

        function SaveAvatar(avatar) {
            var json = { Type: 'avatar', avatar: avatar };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {
                    //
                }
                else
                    alert('Error updating your avatar.');
            });
        }

        function ChangeSkin(skin) {
            if (skin != "")
                $('#content').css("background-image", "url(/Images/Skin/" + skin + ")");
        }

    </script>
    
    <asp:HiddenField ID="hdnColor" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnSkin" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnBackgroundColorLabel" runat="server" ClientIDMode="Static" meta:resourcekey="hdnBackgroundColorLabelResource1"/>
    <asp:HiddenField ID="hdnUserID" runat="server" ClientIDMode="Static" />
    <div class="profile_left_Container" id="profile_left_Container">
        <div class="prof_left_frame" id="prof_left_frame">
            <div class="prof_left_top" id="prof_left_top">
                <div class="prof_frame_avatar" id="prof_frame_avatar">
                    <asp:Image ID="imgAvatar" CssClass="prof_left_avatar_img" runat="server" Width="100px" Height="100px" ImageUrl="~/Images/no_avatar.png" meta:resourcekey="imgAvatar" ClientIDMode="Static" />
                </div>
                <div class="prof_frame_info" id="prof_frame_info">
                    <div class="prof_info_name" id="prof_info_name">
                        <div>
                            <asp:LinkButton ID="linkName" Text="Lucy" runat="server" OnClick="linkName_Click" ClientIDMode="Static" meta:resourcekey="linkNameResource1" ToolTip="Click to send Message"></asp:LinkButton>
                        </div>
                        <asp:ImageButton ID="imgWriteNew" class="imgWriteNew" runat="server" OnClick="imgWriteNew_Click" ImageUrl="~/Images/WriteNew.png" meta:resourcekey="imgWriteNewResource1" AlternateText="Write New Message" ToolTip="Write New Message" ClientIDMode="Static" style="width:30px;height:30px;vertical-align:middle;" BackColor="Transparent" BorderColor="Transparent" BorderStyle="None"/>
                        <asp:Label ID="lblWriteNewEx" CssClass="lblWriteNewEx" Text="Write a New Message!" runat="server" meta:resourcekey="lblWriteNewExResource1"></asp:Label>
                    </div>
                    <div class="prof_info_location" id="prof_info_location">
                        <asp:Label ID="lblLocation" Text="Melbourne, Australia" runat="server" meta:resourcekey="lblLocationResource1"></asp:Label>
                    </div>
                    <div class="prof_info_location_upload_img" id="prof_info_location_upload_img">
                        <asp:Image ID="like" class="imglike" runat="server" ImageUrl="~/Images/heartLike.png" meta:resourcekey="imgLikeResource1" AlternateText="Click to like or unlike" ClientIDMode="Static" data-ilike="false" />
                        <div class="prof_info_location_upload_img" id="Div1">
                            
                        </div>
                    </div>
                    
                        
                    
                </div>
            </div>
        </div>
        <div class="prof_MyPhoto_Container" id="prof_MyPhoto_Container">
            <div class="prof_left_bottom" id="prof_left_bottom">
                <div class="prof_left_bot_upload_img" id="prof_left_bot_upload_img">
                    <asp:Label ID="lblMyPhoto" CssClass="prof_left_bot_upload_img_info" Text="My Photos" runat="server" meta:resourcekey="lblMyPhotoResource1"></asp:Label>
                </div>
                <div class="prof_left_bot_divider" id="prof_left_bot_divider">
                    <div id="divMyPhoto" class="divMyPhoto-frnds" runat="server"> 
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
                                <div class="wrapper" >
                                    <asp:Image ID="picAlbum" CssClass="prof-image" runat="server" AlternateText=<%# Eval("Description") %> ImageUrl='<%# Eval("Photo") %>' Width="350px" Height="290px" meta:resourcekey="picAlbum" />
                                    <div class="description-frnds">
                                        <p class="description_content"><span><%#Eval("Description") %></span>
                                            <img id='like' src="../Images/heartLike.png"/>
                                            <span class="likecount"><%# Eval("LikeCount") %></span>
                                        </p>
                                    </div>
                                </div>
                                <br />
                            </ItemTemplate>
                            <EmptyItemTemplate>
                            </EmptyItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="FriendsRoom_right_Container" id="FriendsRoom_right_Container">
        <div class="prof_top_container" id="prof_top_container">
            <img id="imgStatusBox" src="../Images/new/status box.png" />
            <div class="prof_top_con_lblupdatemystatus" id="prof_top_con_lblupdatemystatus">
                <asp:Label ID="lblStatusLabel" CssClass="lblUpdateMyStatus" Text="Status" runat="server" meta:resourcekey="lblStatusResource1"></asp:Label>
            </div>
            <div class="prof_top_con_txtupdatemystatus" id="prof_top_con_txtupdatemystatus">
                <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>
            </div>
            <div class="lblLikeCount">
                <div style="padding-left: 50px;float:left;">
                    <img src="../Images/like_star.png" alt=""/>
                </div>
                <div style="margin-top: 12px;">
                    <asp:Label ID="lblCountLikeLabel" CssClass="lblCountLikeLabel"  runat="server" Text="Stars Received:" meta:resourcekey="lblCountLikeLabelResource1"></asp:Label>
                    <asp:Label ID="lblCountLike" CssClass="lblCountLike" runat="server" ClientIDMode="Static" Text="0" meta:resourcekey="lblCountLikeResource1"></asp:Label>
                </div>
            </div>
        </div>
        <div class="frnds_prof_bottom_container" id="frnds _prof_bottom_container">
                                <div class="tcp_lbl_title">
                                    <asp:Label ID="lblAboutLabel" runat="server" Text="About Me" Font-Bold="True" meta:resourcekey="lblAboutLabelResource1"></asp:Label>  
                                </div>
                                <div class="tcp_lbl_title_container">
                                    <asp:Label ID="lblAboutMe" runat="server" Text="This will help new friends find you." meta:resourcekey="lblAboutMeResource1"></asp:Label>  
                                </div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" style="top:0;">
                <ContentTemplate>
                    <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />
                    <div id="tabs" class="frnds_tabs">
                        <ul>
                        <li><asp:HyperLink ID="HyperLink1" href="#tab1" runat="server" Text="User Information" meta:resourcekey="HyperLink1Resource1"/></li>
                        <li><asp:HyperLink ID="HyperLink2" href="#tab2" runat="server" Text="Things I like" meta:resourcekey="HyperLink2Resource1" /></li>
                        <li><asp:HyperLink ID="HyperLink3" href="#tab3" runat="server" Text="About Me" meta:resourcekey="HyperLink3Resource1" /></li>
                        </ul>

                        <div id="tab1" class="panel_frnds">
                            <div class="tabl_container_profile">
                                <div class="tcp_lbl_title">
                                    <asp:Label ID="lblUserNameLabel" runat="server" Text="User Name" Font-Bold="True" meta:resourcekey="lblUserNameLabelResource1"></asp:Label>  
                                </div>
                                    <div class="<%--tcp_lbl_title_container--%>">
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
                                    <asp:Label ID="lblBirthday" runat="server" Font-Bold="True"></asp:Label>                              
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
                                        <asp:Label ID="lblLevel" runat="server" meta:resourcekey="lblLevelResource1" ></asp:Label>  
                                    </div>
                                <div class="tcp_lbl_title">
                                    <asp:Label ID="lblGenderLabel" runat="server" Text="Gender:" Font-Bold="True" meta:resourcekey="lblGenderLabelResource1"></asp:Label>  
                                </div>
                                    <div class="tcp_lbl_title_container">
                                        <asp:Label ID="lblGender" runat="server" Text="" Font-Bold="True" meta:resourcekey="lblGenderLabelResource1"></asp:Label>  
                                    </div>
                                <div class="tcp_lbl_title">
                                    <asp:Label ID="lblHometownLabel" runat="server" Text="Home Town:" Font-Bold="True" meta:resourcekey="lblHometownLabelResource1"></asp:Label>  
                                </div>
                                    <div class="tcp_lbl_title_container">
                                        <asp:Label ID="lblHometown" runat="server" meta:resourcekey="lblHometownResource1"></asp:Label>  
                                    </div>
<%--                                <div class="tcp_lbl_title">
                                    <asp:Label ID="lblGradeLabel" runat="server" Text="Grade:"  Font-Bold="True" meta:resourcekey="lblGradeLabelResource1"></asp:Label>  
                                </div>
                                    <div class="tcp_lbl_title_container">
                                        <asp:Label ID="lblGrade" runat="server"></asp:Label>  
                                    </div>--%>
                                <div class="tcp_lbl_title">
                                    <asp:Label ID="lblClassLabel" runat="server" Text="Class:" Visible="false" Font-Bold="True" meta:resourcekey="lblClassLabelResource1"></asp:Label>  
                                </div>
                                    <div class="tcp_lbl_title_container">
                                        <asp:Label ID="lblClass" runat="server" Text="" Font-Bold="True" Visible="false" meta:resourcekey="lblClassLabelResource1"></asp:Label>  
                                    </div>
                            </div>
                        </div>
                        <div id="tab2" class="panel_frnds">
                                <asp:CheckBoxList ID="chkInterestGroup" runat="server" DataTextField="InterestName" DataValueField="InterestID" ClientIDMode="Static" RepeatColumns="1" BorderColor="Control" BorderStyle="Solid" BorderWidth="1px" Width="100%" CssClass="CheckboxList " meta:resourcekey="chkInterestGroupResource1" Enabled="false"></asp:CheckBoxList>
                        </div>
                        <div id="tab3" class="panel_frnds">
                            <asp:CheckBoxList ID="chkAboutMe" runat="server" DataTextField="AboutMe" DataValueField="AboutMeID" ClientIDMode="Static" RepeatColumns="1" BorderColor="Control" BorderStyle="Solid" BorderWidth="1px" Width="100%" CssClass="CheckboxList " meta:resourcekey="chkAboutMeResource1" Enabled="false"></asp:CheckBoxList>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

               <%-- <ul style="visibility:hidden;">
                    <li class="split"><asp:Label ID="lblWhoLikesMe" Text="My Friends" runat="server" meta:resourcekey="lblWhoLikesMeResource1"></asp:Label></li>
                    <li class="split" style="text-align:right;"> </li>
                    <li>
                        <div id="div1" runat="server" style="border:1px outset gray;width:400px;height:500px;overflow:scroll;">
                            <asp:ListView ID="ListView1" runat="server">
                                    <LayoutTemplate>
                                        <asp:PlaceHolder ID="groupPlaceholder" runat="server" />
                                    </LayoutTemplate>
                                    <GroupTemplate>
                                        <div style="text-align:center;">
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
                                                        <span><%#Eval("LikeDate") %></span>

                                                    </td>
                                                </tr>
                                            </table>
                                            </center>
                                        </div>
                                        <div class="wrapper"  data-userid='<%# Eval("UserID") %>' id="myFriends" >
                                            <asp:Image ID="picAlbum" runat="server" AlternateText='<%# Eval("Description") %>' ImageUrl='<%# Eval("Photo") %>' Width="300px" Height="300px" meta:resourcekey="picAlbumResource2" />
                                            <div class="description">
                                                <p class="description_content"><span><%#Eval("Description") %></span>
                                                    <img id='like' src="../Images/heartLike.png"/>
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
                </ul>--%>
        </div>
    </div>
    <div id="avatargallery" style="width:600px;display:none;" title="Select Avatar">
      
    </div>
</asp:Content>
