<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TalkMonitor.aspx.cs" Inherits="Language.Discovery.Student.TalkMonitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="origin-trial" content="ApX266sAgbMtMDHdG/awWBzCROjsFD5SeCg6+cxBSXplZGxYG+nnq+piX+rCBD60eNH8BGH5VXgy8EOtk1pPWgcAAAB9eyJvcmlnaW4iOiJodHRwczovL2hvbWUucGFsYXlnby5jb206NDQzIiwiZmVhdHVyZSI6IlJUQ0V4dGVuZERlYWRsaW5lRm9yUGxhbkJSZW1vdmFsIiwiZXhwaXJ5IjoxNjUzNDM2Nzk5LCJpc1N1YmRvbWFpbiI6dHJ1ZX0="/>
    <script src="scripts/jquery-2.0.3.min.js"></script>
    <script src="scripts/VideoPlatformApi.js?ddxxxsddfdf13sdf4sdddffdfdfsdfs1"></script>
    <link href="css/TalkMonitor.css?xx" rel="stylesheet" />
    <link href="css/VidyoClient.css" rel="stylesheet" />
    <style>
        .highlight
        {
            background-color:teal !important;
            color:white !important;
        }
        #chat {
          font-family: Arial, Helvetica, sans-serif;
          border-collapse: collapse;
          width: 100%;
          text-align: left;
          position: relative;
            
        }

        #chat td, #customers th {
          border: 1px solid #ddd;
          padding: 8px;
        }

        /*#chat tr:nth-child(even){background-color: #f2f2f2;}*/

        #chat tr:hover {background-color: #ddd;}

        #chat th {
          padding-top: 12px;
          padding-bottom: 12px;
          text-align: left;
          background-color: brown;
          color: white;
          position: sticky;
        top: 0; /* Don't forget this, required for the stickiness */
        box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.4);
        }

    </style>
    <script>
        var configParams = {};
        var platformInfo = {};
        var _getChat;


	var webrtcInitializeAttempts = 0;

	function UpdateHelperPaths(status) {
		$("#helperPlugInDownload").attr("href", status.downloadPathPlugIn);
		$("#helperAppDownload").attr("href", status.downloadPathApp);
	}
	function ShowFailed(status) {
		var helperText = '';
		 // Display the error
		helperText += '<h2>An error occurred, please reload</h2>';
		helperText += '<p>' + status.description + '</p>';

		$("#helperText").html(helperText);
		$("#failedText").html(helperText);
		$("#failed").removeClass("hidden");
		$("#connectionStatus").html("Failed: " + status.description);
	}
	function ShowFailedVersion(status) {
		var helperText = '';
		 // Display the error
		helperText += '<h4>Please Download a new plugIn and restart the browser</h4>';
		helperText += '<p>' + status.description + '</p>';

		$("#helperText").html(helperText);
	}

	function joinViaBrowser() {
		$("#helperText").html("Loading...");
		$("#helperPicker").addClass("hidden");
		loadVidyoClientLibrary();
	}

	function GetVideoKey(el) {
	    var json = { Type: 'getvideokey' };
	    $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
	        var obj = $.parseJSON(data);

	        if (obj.Status == "True") {
	            $("#hdnToken").val(obj.key);
	            Connect2(el);

	        }
	        else
	            alert('Cannot generate video token.');
	    });

     }
        function setGetChat(caller, callee) {
            _getChat = setInterval(() => { GetChat(caller, callee) }, 5000); // every 5 seconds
        }

        function GetChat(callerid, calleeid) {

            var json = { Type: 'getchat', Caller: callerid, Callee: calleeid };
            $.post("Handler/GenericPostingHandler.ashx", json, function (data) {
                debugger;
                var obj = $.parseJSON(data);

                if (obj.Status == "True") {
                    debugger;
                    if (obj.Message != "") {
                        $('#chat tbody').empty();
                        for (var i = 0; i < obj.Message.length; i++) 
                        {
                            var m = obj.Message[i];
                            $('#chat tbody').append('<tr><td>' + m.Sender + '</td><td>' + m.Recepient + '</td><td>' + AddTargetBlank(m.NativeLanguageMessage) + '</td><td>' + AddTargetBlank(m.LearningLanguageMessage) +'</td></tr>')
                        }
                        $('#chatMessages').scrollTop($('#chatMessages')[0].scrollHeight);
                    }
                }
                else
                    alert('error getting chat');
            });

        }

	function Connect(el)
    {
        clearInterval(_getChat);
	    debugger;
	    //loadPlatformInfo(platformInfo);
        //GetVideoKey(el);
        let roomKey = $(el).data("roomkey");
        Connect2(el);
        loadVidyoClientLibrary(roomKey);
	    // Extract the desired parameter from the browser's location bar
        var callerid = $(el).data("callerid");
        var calleid = $(el).data("calleid");
        setGetChat(callerid, calleid);
	   
	}

	function Connect2(el)
	{
	    function getUrlParameterByName(name) {
	        var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
	        return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
	    }

	    // Fill in the form parameters from the URI

	    //$(".resourceId").val($(el).attr("data-room"));
	    configParams.autoJoin = "1";
	    configParams.enableDebug = getUrlParameterByName("enableDebug");
	    configParams.microphonePrivacy = "1";
        configParams.cameraPrivacy = '1';//getUrlParameterByName("cameraPrivacy");
	    configParams.webrtcLogLevel = getUrlParameterByName("webrtcLogLevel");
	    configParams.isIE = platformInfo.isIE;
        configParams.hideConfig = '0';//getUrlParameterByName("hideConfig");

	    var numRemoteSlots = getUrlParameterByName("numRemoteSlots");
	    configParams.numRemoteSlots = numRemoteSlots ? parseInt(numRemoteSlots) : 8;

	    var displayCropped = getUrlParameterByName("localCameraDisplayCropped");
	    configParams.localCameraDisplayCropped = displayCropped ? (displayCropped === "1") : true;

	    displayCropped = getUrlParameterByName("remoteCameraDisplayCropped");
	    configParams.remoteCameraDisplayCropped = displayCropped ? (displayCropped === "1") : true;

	    // If the parameters are passed in the URI, do not display options dialog
	    //if (host && token && displayName && resourceId) {
	    //	$(".optionsParameters").addClass("optionsHidePermanent");
        //}
	    $(".highlight").removeClass("highlight");
	    $(el).parent().parent().addClass("highlight");
        }

        function AddTargetBlank(text) {
            var myDiv;
            try {
                text = text.replace("onclick", "data-onclick");
                var myDiv = $('<div>').html(text);
                $(myDiv).find('a').removeAttr("onclick");
                $(myDiv).find('a').attr("target", "_blank");
            }
            catch (err) {

                $(myDiv).find('a').unbind();
            }

            return $(myDiv).html();
        }

	// Runs when the page loads
	$(function () {
        attachedVidyo();

	});
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <asp:HiddenField ID="hdnDisplayName" runat="server" ClientIDMode="Static" />
      <asp:HiddenField ID="hdnToken" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnUser" runat="server" ClientIDMode="Static" />
    <div id="options">
        
        <p>
            <input id="resourceId" class="resourceId" type="text" placeholder="Conference Reference" value="" style="display:none;"/>
        </p>
        <div id="messages">
			<!-- All Vidyo-related messages will be inserted into these spans. -->
			<span id="error"></span>
			<span id="message"></span>
		</div>
        <div id="grdRoomsContainer" style="height: 150px;">
            <asp:GridView ID="grdRooms" runat="server" 
                        GridLines="Both" Width="100%"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" 
                        BackColor="White" BorderColor="#336666"
                        style="overflow-y: scroll;height: 97%;"
                        BorderWidth="1px" meta:resourcekey="grdResultResource1">
                        <RowStyle BackColor="White" ForeColor="#333333"  Font-Size="Small" Height="10px"/>
                        <SelectedRowStyle BackColor="#339966" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White"  Height="10px" />
                        <Columns>
                            <asp:BoundField DataField="RoomName" HeaderText="Room" meta:resourcekey="BoundFieldResource1" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Caller" HeaderText="Caller" meta:resourcekey="BoundFieldResource2" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Callee" HeaderText="Callee" meta:resourcekey="BoundFieldResource3" >
                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="CreateDate" HeaderText="Date" meta:resourcekey="BoundFieldResource3" >
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-Width="75px">
                                <ItemTemplate>
                                    <asp:Button ID="btnConnect" Text="Connect" OnClientClick="Connect(this); return false;" runat="server" ClientIDMode="Static" 
                                        data-room='<%#Eval("RoomName") %>' data-callerid='<%#Eval("Caller") %>' data-calleid='<%#Eval("Callee") %>' data-roomkey='<%#Eval("RoomKey") %>' Width="65px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>        
        </div>
        <div id="chatMessages" style="height:500px;overflow-x:scroll;">
            <table id="chat">
                <thead>
                    <tr>
                        <th>Sender</th>
                        <th>Recipient</th>
                        <th>Message</th>
                        <th>Translation</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <div id="rendererContainer" class="hidden">
		<div id="renderer0" class="pluginOverlay"> </div>
        <div id="renderer01" class="pluginOverlay"> </div>
		<div id="renderer1" class="pluginOverlay"> </div>
		<div id="renderer2" class="pluginOverlay"> </div>
		<div id="renderer3" class="pluginOverlay"> </div>
	</div>
    <div id="toolbarLeft" class="toolbar hidden" style="display:none;">
		<span id="participantStatus"></span>
	</div>
	<div id="toolbarCenter" class="toolbar hidden">
        <div id="divCameraAndMicContainer">
            <p style="display:none;">
			    <!-- On page load, this input is filled with a list of all the available cameras on the user's system. -->
			    <label for="cameras">Camera</label>
			    <select id="cameras">
				    <option value='0'>None</option>
			    </select>
		    </p>
            <p>
			    <!-- On page load, this input is filled with a list of all the available microphones on the user's system. -->
			    <label for="microphones">Microphone</label>
			    <select id="microphones" style="width:184px;">
				    <option value='0'>None</option>
			    </select>
		    </p>
            <p>
			    <!-- On page load, this input is filled with a list of all the available microphones on the user's system. -->
			    <label for="speakers">Speaker</label>
			    <select id="speakers" style="width:184px;">
				    <option value='0'>None</option>
			    </select>
		    </p>
        </div>

		<!-- This button toggles the camera privacy on or off. -->
		<button id="cameraButton" title="Camera Privacy" class="toolbarButton cameraOff" onclick="return false;" style="display:none;"></button>

		<!-- This button joins and leaves the conference. -->
		<button id="joinLeaveButton" title="Join Conference" class="toolbarButton callStart" onclick="return false;"></button>

		<!-- This button mutes and unmutes the users' microphone. -->
		<button id="microphoneButton" title="Microphone Privacy" class="toolbarButton microphoneOff" onclick="return false;"></button>
    
	</div>
    </div>
    </form>
</body>
</html>
