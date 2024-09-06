<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchFriend.aspx.cs" Inherits="Language.Discovery.Student.SearchFriend" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/themes/live.search.result.css" rel="stylesheet" />
    <script src="../Scripts/Others.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#txtUser").keyup(function () {
                var kw = $("#txtUser").val();
                //alert(kw);
                if (kw != '' && kw.length >= 2) { //at least 2 characters
                    $('.spinner').show();
                    $.ajax
                    ({
                        type: "POST",
                        url: "../Handler/SearchHandler.ashx",
                        data: "name=" + kw,
                        success: function (data) {

                            var data1 = $.parseJSON(data)
                            var result = "";
                            if (data1 == null) {
                                result = 'No user found.';
                                $("#results").empty();
                                $("#results").append('<ul>' + result + '</ul>');
                                return;
                            }

                            
                            $.each(data1, function (i, obj) {
                                var isFriend = obj.IsFriend;
                                var label = 'Add Friend';
                                if (isFriend)
                                    label = 'Un Friend';
                                result += ("<li><div id='auth_img'><img src='{0}'></div>" +
                                "<div id='rest'><span>{1}</span><br/><span>{2}</span><br/><span>{3}</span><br/><a href='#' style='text-decoration:underline;' onclick='AddRemoveFriend(this)' data-userid='{4}' data-isfriend='{5}'>{6}</a><br/></div>" +
                                "<div style='clear:both;'></div></li>").stringformat("../Images/avatar/" + obj.Avatar, obj.FirstName, obj.LastName,obj.Address , obj.UserID, isFriend, label);
                            });
                    
                            $("#results").empty();
                            $("#results").append('<ul>' + result + '</ul>') ;
                        }
                    });
                }
                else {
                    $("#results").html("");
                }

                $('.spinner').hide();
                return false;
            });

            /*$("#keywords").change(function()
            {
              $("#results").html("");
              $("#keywords").value = "";
            });*/
            //$("html").click();
            //LiveSearch.searchBoxes.add(this.resultsElement).click(function(e) { e.stopPropagation(); });
            //$("html").click(function(e){ e.stopPropagation(); });

            //$(".overlay").click(function () {
            //    $(".overlay").css('display', 'none');
            //    $("#results").css('display', 'none');
            //});
            //$("#keywords").focus(function () {
            //    $(".overlay").css('display', 'block');
            //    $("#results").css('display', 'block');
            //});
        });
        function AddRemoveFriend(el) {
            
            var userid = $(el).attr('data-userid');
            var t = 'add';
            if ($(el).attr('data-isfriend') === 'true') {
                t = 'remove'
            }

            var json = { Type: t, useridtoprocess: userid };
            $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                var obj = $.parseJSON(data)
                if (obj.Status == "True") {
                    if (t == 'add') {
                        $(el).text('Un Friend');
                        $(el).attr('data-isfriend', true);
                    }
                    else {
                        $(el).text('Add Friend');
                        $(el).attr('data-isfriend', false);
                    }
                }
                else
                    alert('Error updating your status.');

            });


        }

    </script>
    <div style="margin:auto;">
          <div id="textspan"><asp:Label ID="lblSearch" runat="server" Text="Enter email or Name :" meta:resourcekey="lblSearchResource1"></asp:Label> &nbsp;&nbsp;</div>
          <div id="inputbox">
            <asp:TextBox ID="txtUser" runat="server" ClientIDMode="Static" meta:resourcekey="txtUserResource1" TextMode="Search"></asp:TextBox><div class="spinner" style="display:none;color:blue;"><img src="spinner.gif" /></div>
          </div>
        
        <div id="results"></div>
        <div class="overlay"></div>
    </div>
</asp:Content>
