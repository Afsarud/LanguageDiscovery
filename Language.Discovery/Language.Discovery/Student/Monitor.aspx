<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Monitor.aspx.cs" Inherits="Language.Discovery.Student.Monitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script src="../Scripts/VidyoConnectorCustomLayout.js?31"></script>
<link href="../App_Themes/Default/TalkMonitor.css" rel="stylesheet" />
    <style>
        .highlight
        {
            background-color:teal !important;
            color:white !important;
        }
    </style>
    <script>
    var configParams = {};
	var platformInfo = {};
	var webrtcInitializeAttempts = 0;

	function onVidyoClientLoaded(status) {
		console.log("Status: " + status.state + "Description: " + status.description);
		switch (status.state) {
			case "READY":    // The library is operating normally
				$("#connectionStatus").html("Ready to Connect");
				$("#helper").addClass("hidden");
				$("#toolbarLeft").removeClass("hidden");
				$("#toolbarCenter").removeClass("hidden");
				$("#toolbarRight").removeClass("hidden");
				$("#rendererContainer").removeClass("hidden");

				// After the VidyoClient is successfully initialized a global VC object will become available
				// All of the VidyoConnector gui and logic is implemented in VidyoConnectorCustomLayout.js
				if (VCUtils.params.webrtc === "true") {
					++webrtcInitializeAttempts;
				}
				StartVidyoConnector(VC, configParams);
				break;
			case "RETRYING": // The library operating is temporarily paused
				$("#connectionStatus").html("Temporarily unavailable retrying in " + status.nextTimeout/1000 + " seconds");
				break;
			case "FAILED":   // The library operating has stopped
				// If WebRTC initialization failed, try again up to 3 times.
				if (status.description.includes("Could not initialize WebRTC transport") && (webrtcInitializeAttempts < 3)) {
					// Attempt to start the VidyoConnector again.
					StartVidyoConnector(VC, configParams);
					++webrtcInitializeAttempts;
				} else {
					ShowFailed(status);
				}
				break;
			case "FAILEDVERSION":   // The library operating has stopped
				UpdateHelperPaths(status);
				ShowFailedVersion(status);
				$("#connectionStatus").html("Failed: " + status.description);
				break;
			case "NOTAVAILABLE": // The library is not available
				UpdateHelperPaths(status);
				$("#connectionStatus").html(status.description);
				break;
            case "TIMEDOUT":   // Transcoding Inactivity Timeout
                $("#connectionStatus").html("Failed: " + status.description);
                $("#messages #error").html('Page timed out due to inactivity. Please refresh your browser and try again.');
                break;
		}
		return true; // Return true to reload the plugins if not available
	}
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

	function loadVidyoClientLibrary(webrtc, plugin) {
		// If webrtc, then set webrtcLogLevel
		var webrtcLogLevel = "";
		if (webrtc) {
			// Set the WebRTC log level to either: 'info' (default), 'error', or 'none'
			if (configParams.webrtcLogLevel === 'info' || configParams.webrtcLogLevel === 'error' || configParams.webrtcLogLevel == 'none')
				webrtcLogLevel = '&webrtcLogLevel=' + configParams.webrtcLogLevel;
			else
				webrtcLogLevel = '&webrtcLogLevel=info';
		}

		//We need to ensure we're loading the VidyoClient library and listening for the callback.
		var script = document.createElement('script');
		script.type = 'text/javascript';
		script.src = 'https://static.vidyo.io/4.1.25.17/javascript/VidyoClient/VidyoClient.js?onload=onVidyoClientLoaded&webrtc=' + webrtc + '&plugin=' + plugin + webrtcLogLevel;
		document.getElementsByTagName('head')[0].appendChild(script);
	}
	function joinViaBrowser() {
		$("#helperText").html("Loading...");
		$("#helperPicker").addClass("hidden");
		loadVidyoClientLibrary(true, false);
	}

	function GetVideoKey(el) {
	    var json = { Type: 'getvideokey' };
	    $.post("../Handler/GenericPostingHandler.ashx", json, function (data) {
	        var obj = $.parseJSON(data);

	        if (obj.Status == "True") {
	            $("#hdnToken").val(obj.key);
	            Connect2(el);

	        }
	        else
	            alert('Cannot generate video token.');
	    });

	}

	function Connect(el)
	{
	    debugger;
	    //loadPlatformInfo(platformInfo);
	    GetVideoKey(el);
	    // Extract the desired parameter from the browser's location bar
	   
	}

	function Connect2(el)
	{
	    function getUrlParameterByName(name) {
	        var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
	        return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
	    }

	    // Fill in the form parameters from the URI

	    $(".resourceId").val($(el).attr("data-room"));
	    configParams.autoJoin = "1";
	    configParams.enableDebug = getUrlParameterByName("enableDebug");
	    configParams.microphonePrivacy = getUrlParameterByName("microphonePrivacy");
	    configParams.cameraPrivacy = getUrlParameterByName("cameraPrivacy");
	    configParams.webrtcLogLevel = getUrlParameterByName("webrtcLogLevel");
	    configParams.isIE = platformInfo.isIE;
	    configParams.hideConfig = getUrlParameterByName("hideConfig");

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
	    joinViaBrowser();
	    $(".highlight").removeClass("highlight");
	    $(el).parent().parent().addClass("highlight");
	}

	// Runs when the page loads
	$(function () {
	    
	});
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <asp:HiddenField ID="hdnDisplayName" runat="server" ClientIDMode="Static" />
      <asp:HiddenField ID="hdnToken" runat="server" ClientIDMode="Static" />
    <div id="options">
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
			<select id="microphones">
				<option value='0'>None</option>
			</select>
		</p>
        <p>
			<!-- On page load, this input is filled with a list of all the available microphones on the user's system. -->
			<label for="speakers">Speaker</label>
			<select id="speakers">
				<option value='0'>None</option>
			</select>
		</p>
        <p>
            <input id="resourceId" class="resourceId" type="text" placeholder="Conference Reference" value="" style="display:none;"/>
        </p>
        <div id="messages">
			<!-- All Vidyo-related messages will be inserted into these spans. -->
			<span id="error"></span>
			<span id="message"></span>
		</div>
        <p>
            <asp:GridView ID="grdRooms" runat="server" 
                        GridLines="Both" Width="100%"
                        EmptyDataText="No record to display." AutoGenerateColumns="False" 
                        BackColor="White" BorderColor="#336666"
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
                            <asp:TemplateField ItemStyle-Width="75px">
                                <ItemTemplate>
                                    <asp:Button ID="btnConnect" Text="Connect" OnClientClick="Connect(this); return false;" runat="server" ClientIDMode="Static" data-room='<%#Eval("RoomName") %>' Width="65px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>        
        </p>
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
		<!-- This button toggles the camera privacy on or off. -->
		<button id="cameraButton" title="Camera Privacy" class="toolbarButton cameraOn" onclick="return false;"></button>

		<!-- This button joins and leaves the conference. -->
		<button id="joinLeaveButton" title="Join Conference" class="toolbarButton callStart" onclick="return false;"></button>

		<!-- This button mutes and unmutes the users' microphone. -->
		<button id="microphoneButton" title="Microphone Privacy" class="toolbarButton microphoneOn" onclick="return false;"></button>
	</div>
    </div>
    </form>
</body>
</html>
