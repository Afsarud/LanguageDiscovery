<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TalkMonitor.aspx.cs" Inherits="Language.Discovery.Student.TalkMonitor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../App_Themes/Default/TalkMonitor.css" rel="stylesheet" />
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

	function joinViaPlugIn() {
		$("#helperText").html("Don't have the PlugIn?");
		$("#helperPicker").addClass("hidden");
		$("#helperPlugIn").removeClass("hidden");
		loadVidyoClientLibrary(false, true);
	}

	function joinViaElectron() {
		$("#helperText").html("Electron...");
		$("#helperPicker").addClass("hidden");
		loadVidyoClientLibrary(false, true);
	}
	function loadAppFromProtocolHandler(forceRedirect) {
		var protocolHandlerLink = 'vidyoconnector://' + window.location.search;

		if (platformInfo.isiOS || platformInfo.isAndroid || forceRedirect) {
			window.open(protocolHandlerLink, '_self');
		} else {
			$('body').append("<iframe src='" + protocolHandlerLink + "' style='width:0;height:0;border:0; border:none;'></iframe>");
		}
	}
	function joinViaApp() {
		$("#helperText").html("Don't have the app?");
		$("#helperPicker").addClass("hidden");
		$("#helperApp").removeClass("hidden");
		/* launch */
		loadAppFromProtocolHandler(false);
		loadVidyoClientLibrary(false, false);
	}
	function joinViaOtherApp() {
		$("#helperText").html("Don't have the app?");
		$("#helperPicker").addClass("hidden");
		$("#helperOtherApp").removeClass("hidden");
		/* launch */
		loadAppFromProtocolHandler(false);
		loadVidyoClientLibrary(false, false);
	}

	function loadPlatformInfo(platformInfo) {
		var userAgent = navigator.userAgent || navigator.vendor || window.opera;
		// Opera 8.0+
		platformInfo.isOpera = userAgent.indexOf("Opera") != -1 || userAgent.indexOf('OPR') != -1 ;
		// Firefox
		platformInfo.isFirefox = userAgent.indexOf("Firefox") != -1 || userAgent.indexOf('FxiOS') != -1 ;
		// Chrome 1+
		platformInfo.isChrome = userAgent.indexOf("Chrome") != -1 || userAgent.indexOf('CriOS') != -1 ;
		// Safari
		platformInfo.isSafari = !platformInfo.isFirefox && !platformInfo.isChrome && userAgent.indexOf("Safari") != -1;
		// AppleWebKit
		platformInfo.isAppleWebKit = !platformInfo.isSafari && !platformInfo.isFirefox && !platformInfo.isChrome && userAgent.indexOf("AppleWebKit") != -1;
		// Internet Explorer 6-11
		platformInfo.isIE = (userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true );
		// Edge 20+
		platformInfo.isEdge = !platformInfo.isIE && !!window.StyleMedia;
		// Check if Mac
		platformInfo.isMac = navigator.platform.indexOf('Mac') > -1;
		// Check if Windows
		platformInfo.isWin = navigator.platform.indexOf('Win') > -1;
		// Check if Linux
		platformInfo.isLinux = navigator.platform.indexOf('Linux') > -1;
		// Check if iOS
		platformInfo.isiOS = userAgent.indexOf("iPad") != -1 || userAgent.indexOf('iPhone') != -1 ;
		// Check if Android
		platformInfo.isAndroid = userAgent.indexOf("android") > -1;
		// Check if Electron
		platformInfo.isElectron = (typeof process === 'object') && process.versions && (process.versions.electron !== undefined);
		// Check if WebRTC is available
		platformInfo.isWebRTCAvailable = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || (navigator.mediaDevices ? navigator.mediaDevices.getUserMedia : undefined)) ? true : false;
		// Check if 64bit
		platformInfo.is64bit = navigator.userAgent.indexOf('WOW64') > -1 ||  navigator.userAgent.indexOf('Win64') > -1 || window.navigator.platform == 'Win64';	
	}
	
	function loadHelperOptions(platformInfo) {
		if (!platformInfo.isMac && !platformInfo.isWin && !platformInfo.isLinux) {
			/* Mobile App*/
			if (platformInfo.isAndroid || platformInfo.isiOS) {
				$("#joinViaApp").removeClass("hidden");
			} else {
				$("#joinViaOtherApp").removeClass("hidden");
			}
			if (platformInfo.isWebRTCAvailable) {
				/* Supports WebRTC */
				$("#joinViaBrowser").removeClass("hidden");
			}
		} else {
			/* Desktop App */
			$("#joinViaApp").removeClass("hidden");

			if (platformInfo.isWebRTCAvailable) {
				/* Supports WebRTC */
				$("#joinViaBrowser").removeClass("hidden");
			}
			if (platformInfo.isSafari || (platformInfo.isAppleWebKit && platformInfo.isMac) || (platformInfo.isIE && !platformInfo.isEdge)) {
				/* Supports Plugins */
				$("#joinViaPlugIn").removeClass("hidden");
			}
		}
	}

	// Runs when the page loads
	$(function() {
		var connectorType = getUrlParameterByName("connectorType");
		loadPlatformInfo(platformInfo);

		// Extract the desired parameter from the browser's location bar
		function getUrlParameterByName(name) {
			var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
			return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
		}

		// Fill in the form parameters from the URI
		var host = getUrlParameterByName("host");
		if (host)
			$(".host").val(host);
		var token = getUrlParameterByName("token");
		if (token)
			$(".token").val(token);
		var displayName = getUrlParameterByName("displayName");
		if (displayName)
			$(".displayName").val(displayName);
		var resourceId = getUrlParameterByName("resourceId");
		if (resourceId)
			$(".resourceId").val(resourceId);
		configParams.autoJoin    = getUrlParameterByName("autoJoin");
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
		if (host && token && displayName && resourceId) {
			$(".optionsParameters").addClass("optionsHidePermanent");
		}
		joinViaBrowser();

		//if (connectorType == "app") {
		//	joinViaApp();
		//} else if (connectorType == "browser") {
		//	joinViaBrowser();
		//} else if (connectorType == "plugin") {
		//	joinViaPlugIn();
		//} else if (connectorType == "other") {
		//	joinViaOtherApp();
		//} else if (platformInfo.isElectron) {
		//	joinViaElectron();
		//} else {
		//	loadHelperOptions(platformInfo);
		//}
	});
	</script>
    
    <asp:HiddenField ID="hdnToken" runat="server" ClientIDMode="Static" />
    <div id="options" class="optionsHide">
        <p>
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
        <div id="messages">
			<!-- All Vidyo-related messages will be inserted into these spans. -->
			<span id="error"></span>
			<span id="message"></span>
		</div>
    </div>

    <div id="rendererContainer" class="hidden">
		<div id="renderer0" class="pluginOverlay"> </div>
		<div id="renderer01" class="pluginOverlay"> </div>
		<div id="renderer1" class="pluginOverlay"> </div>
		<div id="renderer2" class="pluginOverlay"> </div>
		<div id="renderer3" class="pluginOverlay"> </div>
	</div>
    <div id="toolbarLeft" class="toolbar hidden">
		<span id="participantStatus"></span>
	</div>
	<div id="toolbarCenter" class="toolbar hidden">
		<!-- This button toggles the camera privacy on or off. -->
		<button id="cameraButton" title="Camera Privacy" class="toolbarButton cameraOn"></button>

		<!-- This button joins and leaves the conference. -->
		<button id="joinLeaveButton" title="Join Conference" class="toolbarButton callStart"></button>

		<!-- This button mutes and unmutes the users' microphone. -->
		<button id="microphoneButton" title="Microphone Privacy" class="toolbarButton microphoneOn"></button>
	</div>
</asp:Content>
