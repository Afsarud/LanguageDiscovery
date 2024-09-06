<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Photos.aspx.cs" Inherits="Language.Discovery.Photos" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../colorbox/colorbox.css" rel="stylesheet" />
    <script src="../colorbox/jquery.colorbox.js"></script>
    <script src="../Scripts/Others.js"></script>

    <style>
        /* This rule is read by Galleria to define the gallery height: */
        #divAlbums {
           
            overflow:scroll;
        }
        .container { position: relative; width: 120px;float: left;  margin-right: 10px; margin-bottom:10px; }
        .checkbox { position: absolute; top: -10px; left: 0px; }
        
        .customTooltip  {
        color: white;
        border-radius: 5px;
        font: bold 14px "Helvetica Neue", Sans-Serif;
        text-transform: uppercase;
        background-color:red;
        background:red;
        opacity:1;
          }

    </style>

    <script>
        //$(function () {
        //    $('#divAlbums a').lightBox({ fixedNavigation: true });
        //})

        function view() {
            //// Load the classic theme
            //Galleria.loadTheme('../Scripts/galleria.classic.min.js');
            
            //// Initialize Galleria
            //Galleria.run('.xxx');

          
                $('#divAlbums a').lightBox({ fixedNavigation: true });
         }

        function close() {

        }

        function AddPicture(json) {

            var obj = jQuery.parseJSON(json);
            var image = "<a href='{0}' ><img id='MainContent_ListView1_ctrl0_picAlbum_0' src='{0}' alt='{1}' style='height:100px;width:100px;'></a>";
            debugger;
            var x = image.stringformat(obj.Image, obj.Description);
            var container = $('#divAlbums');
            container.append($(x));
            view();
        }

        function Upload() {
            $('#<%=FileUpload1.ClientID%>').uploadify('upload', '*');
        }

         
        function readImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#image_upload_preview').attr('src', e.target.result).width('50').height('50'); // setting ur image here		
                };

                reader.readAsDataURL(input.files[0]);   // Read in the image file as a data URL.   			}      		
            }

            $(function () {
                $('#<%=FileUpload1.ClientID%>').bind('change', function () {

                    //this.files[0].size gets the size of your file.
                    alert(this.files[0].size);

                });
            });
        }

        $(function () {
                $(".gallery").colorbox({
                    rel: 'gallery', transition: "none", width: "75%", height: "75%", innerWidth:400,
                    onComplete: function () {
                        $('.cboxPhoto').css({ "float": 'left' });
                        //Ajaxify comments and likes
                        //$.get("../PhotoDetailsHandler.ashx", function (html) {
                        //    alert(html);
                        //});

                        var div = '<div id="test" style="background-color:red;height:500px; width:300px; float:right; margin-right:50px;padding-top:50px;">{0}</div>'

                        $('#cboxLoadedContent').append()
                        
                    }
                });
                $('.description').blur(function () {
                    SaveDescription(this);
                });

                $("#txtDescription").tooltip({ position: { my: "left+15 center", at: "right center" }, tooltipClass: "customTooltip" });
        });

        function SaveDescription(el) {
            var json = { Type: 'description', status: 'description', description: $(el).val(), userphotoid: $(el).attr('data-userphotoid') };
             $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
                 var obj = $.parseJSON(data)
                 if (obj.Status == "True") {
                     $('#spanStatus').css("display", "");
                     $("#txtDescription").attr("title", "");
                     $("#txtDescription").tooltip("close");
                 }
                 else if (obj.Status == "foul") {
                     $("#txtDescription").attr("title", "Please watch your language.");
                     //$("#txtDescription").tooltip({ position: { my: "left+15 center", at: "right center" }, tooltipClass: "customTooltip" });
                     $("#txtDescription").mouseenter();
                 }
                 else
                     alert('Error updating your Description.');

             });

         }

        function EditDescription(el) {
            $(el).siblings('#txtDescription').css("display", "");
            //$(el).siblings('#linkUpdate').css("display", "");
            $(el).siblings('#txtDescription').focus();
            $(el).css("display", "none");
            $(el).siblings('#txtDescription').blur(function () {
                alert('test');
            });


        }

        function GetSelectedImage(el) {
            
            var imageid = '';
            $('.container').find(':checkbox').each(function () {
                if( $(this).is(":checked") )
                    imageid += $(this).attr('data-userphotoid') + ",";
            });
            
            //var hdnimageid = $('#hdnImageID');
            $('#hdnImageID').val(imageid.substring(0, imageid.length - 1));
            if (imageid.length == 0) {
                //$(el).parent().html('<span>Please select image first.</span>');
                $('#lblmessage').show();
                return false;
            }
            else {
                return true;
            }
        }
        
    </script>
            <div  style="float:left;width:15%">
                <asp:FileUpload ID="FileUpload1" runat="server" class="upload" meta:resourcekey="FileUpload1Resource1" Width="240px"/>
                <asp:Label ID="lblAddCaption" runat="server" Text="Add Caption" meta:resourcekey="lblAddCaptionResource1"></asp:Label>
                <asp:TextBox ID="txtDescription1" runat="server" meta:resourcekey="txtDescription1Resource1" ></asp:TextBox>
                <asp:Label ID="lblDescriptionMessage" runat="server" Text="Please watch your language" EnableViewState="false" Visible="false" ForeColor="White" BackColor="Red"></asp:Label>
                <asp:FileUpload ID="FileUpload2" runat="server" class="upload" meta:resourcekey="FileUpload2Resource1" Visible="False"/>
                <asp:TextBox ID="txtDescription2" runat="server" meta:resourcekey="txtDescription2Resource1" Visible="False"></asp:TextBox>
                <asp:FileUpload ID="FileUpload3" runat="server" class="upload" meta:resourcekey="FileUpload3Resource1" Visible="False"/>
                <asp:TextBox ID="txtDescription3" runat="server" meta:resourcekey="txtDescription3Resource1" Visible="False"></asp:TextBox>
                <asp:FileUpload ID="FileUpload4" runat="server" class="upload" meta:resourcekey="FileUpload4Resource1" Visible="False"/>
                <asp:TextBox ID="txtDescription4" runat="server" meta:resourcekey="txtDescription4Resource1" Visible="False"></asp:TextBox>
                <asp:FileUpload ID="FileUpload5" runat="server" class="upload" meta:resourcekey="FileUpload5Resource1" Visible="False"/>
                <asp:TextBox ID="txtDescription5" runat="server" meta:resourcekey="txtDescription5Resource1" Visible="False"></asp:TextBox>
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="False" EnableViewState="False" meta:resourcekey="lblMessageResource1"></asp:Label>
                <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" meta:resourcekey="btnUploadResource1" />
                <asp:Button ID="btnBackToMyRoom" runat="server" Text="Back to My Room" PostBackUrl="~/Student/MyRoom.aspx" meta:resourcekey="btnBackToMyRoomResource1" />
            </div>
    <asp:HiddenField ID="hdnImageID" runat="server" ClientIDMode="Static" />
   
            <div style="border:1px solid black;float:right;width:69%;">
                <div style="width:100%; height:50px;">
                    <asp:Button ID="btnDeleteSelected" runat="server" Text="Delete Selected" OnClientClick="return GetSelectedImage();" OnClick="btnDeleteSelected_Click" meta:resourcekey="btnDeleteSelectedResource1" Visible="False" />
                    <span id="lblmessage" style="display:none;color:red;">Please select image to delete.</span>
                </div>
                <div id="divAlbums" class="xxx">
                    <asp:ListView ID="ListView1" GroupItemCount="10" runat="server">
                        <LayoutTemplate>
                            <asp:PlaceHolder ID="groupPlaceholder" runat="server" />
                        </LayoutTemplate>
                        <GroupTemplate>
                            <div>
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </div>
                            
                        </GroupTemplate>
                        <ItemTemplate>
                            <div class="container">
                                <a class="gallery" href='<%# Eval("Photo") %>' title='<%# Eval("Description") %>' rel="gallery" style="width:400px;" >
                                   <asp:Image ID="picAlbum" runat="server" AlternateText='<%# Eval("Description") %>' ImageUrl='<%# Eval("Photo") %>' data-userphotoid='<%# Eval("UserPhotoID") %>'  meta:resourcekey="picAlbumResource1" />
                                </a>
                                <input id="chkSelected" type="checkbox" class="checkbox" data-userphotoid="<%# Eval("UserPhotoID") %>" />
                                <asp:Label ID="lblChangeDescription" runat="server" Text="Change Caption" meta:resourcekey="lblChangeDescriptionResource1"></asp:Label>
                                <asp:TextBox CssClass="description" ID="txtDescription" runat="server" Width="400px" Text='<%# Eval("Description") %>' TextMode="MultiLine" ClientIDMode="Static" meta:resourcekey="txtDescriptionResource1" data-userphotoid='<%# Eval("UserPhotoID") %>'></asp:TextBox>
                            </div>

                        </ItemTemplate>
                        
                        <EmptyItemTemplate>
                        </EmptyItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        
<%--    <script type="text/javascript">
        $(window).load(
             function () {
                 $("#<%=FileUpload1.ClientID%>").uploadify({
                       'fileSizeLimit' : '2MB',
                       'swf': '../Scripts/uploadify.swf',
                       'cancelImg': '../Scripts/uploadify-cancel.png',
                       'buttonText': 'Browse Files',
                       'uploader': '../UploadHandler.ashx',
                       'fileTypeDesc': 'Image Files',
                       'fileTypeExts': '*.jpg;*.jpeg;*.gif;*.png',
                       'multi': true,
                       'auto': false,
                       'onUploadSuccess': function (file, data, response) {
                           if (response == true) {
                               //AddPicture(data);
                           }
                       },
                       'onUploadError' : function(file, errorCode, errorMsg, errorString) {
                           alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
                       },
                       'onSelect' : function(file1) {
                           if (file1) {
                               var reader = new FileReader();               
                               reader.result
                               $('#image_upload_preview').attr('src', reader.result).width('50').height('50'); // setting ur image here		
                               //reader.onload = function (e) {
                               //    alert(e.target.result);
                               //    $('#image_upload_preview').attr('src',e.target.result).width('50').height('50'); // setting ur image here		
                               //};           
                           }
                       }
                   });
               }
            );
    </script>--%>
</asp:Content>
