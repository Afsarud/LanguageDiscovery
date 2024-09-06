$(document).ready(function () {
   
});
var _vidyoConnector;
var _isJoining = false;
var _room = "demoroom";
var _localCamera = null;
var _username = "";
var _sound = null;
var cameras = {};
var microphones = {};
var speakers = {};
var selectedLocalCamera = { id: 0, camera: null };

function LoadVidyoClientLibrary(webrtc, joincall, room, user, isCaller) {
    //$("#btnJoinCall").prop("disabled", true);
    //$("#lblInfo").show();
    // If webrtc, then set webrtcLogLevel
    var mp3 = "RingBack.mp3";
    if (isCaller)
        _sound = new buzz.sound('../content/sound/System/RingBack.mp3');

    if (isCaller)
        PlayRingBack(true);
    else
        Ring(false);
    var webrtcLogLevel = "&webrtcLogLevel=info";
    if (webrtc) {
        //// Set the WebRTC log level to either: 'info' (default), 'error', or 'none'
        //if (configParams.webrtcLogLevel === 'info' || configParams.webrtcLogLevel === 'error' || configParams.webrtcLogLevel == 'none')
        //    webrtcLogLevel = '&webrtcLogLevel=' + configParams.webrtcLogLevel;
        //else
        //    webrtcLogLevel = '&webrtcLogLevel=info';
    }

    //We need to ensure we're loading the VidyoClient library and listening for the callback.
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://static.vidyo.io/4.1.22.9/javascript/VidyoClient/VidyoClient.js?onload=onVideoClientLoaded&webrtc=' + webrtc + '&plugin=false' + webrtcLogLevel;
    //alert(script);
    document.getElementsByTagName('head')[0].appendChild(script);
    _isJoining = joincall;
    _room = room;
    _username = user;
}

function onVideoClientLoaded(status) {
    //console.log("Status: " + status.state + "Description: " + status.description);
    
    switch (status.state) {
        case "READY":    // The library is operating normally
            console.log("Status: " + status.state + " Description: " + status.description);
            // After the VidyoClient is successfully initialized a global VC object will become available
            // All of the VidyoConnector gui and logic is implemented in VidyoConnector.js

            //var webrtcExtensionPath = "";
            //if (VCUtils.params.webrtc === "true") {
            //    if (status.hasOwnProperty("downloadPathWebRTCExtensionFirefox"))
            //        webrtcExtensionPath = status.downloadPathWebRTCExtensionFirefox;
            //    else if (status.hasOwnProperty("downloadPathWebRTCExtensionChrome"))
            //        webrtcExtensionPath = status.downloadPathWebRTCExtensionChrome;
            //}
            //StartVidyoConnector(VC, VCUtils.params.webrtc, webrtcExtensionPath, configParams);
            //alert("onVideoClientLoaded");
            StartVideoConnector();
           
            break;
        case "RETRYING": // The library operating is temporarily paused
            break;
        case "FAILED":   // The library operating has stopped
            break;
        case "FAILEDVERSION":   // The library operating has stopped
            break;
        case "NOTAVAILABLE": // The library is not available
            break;
    }
    return true; // Return true to reload the plugins if not available
}

function StartVideoConnector()
{
    VC.CreateVidyoConnector({
        viewId: "", // Div ID where the composited video will be rendered;
        viewStyle: "VIDYO_CONNECTORVIEWSTYLE_Default", // Visual style of the composited renderer
        remoteParticipants: 2, // Maximum number of participants to render
        logFileFilter: "error",
        logFileName: "",
        userData: ""
    }).then(function (vc) {
        console.log("Create success");
        _vidyoConnector = vc;
        handleDeviceChange();
        DisplayLocalCamera();
        DisplayRemoteCamera();
        InitializeAudio();
        
        if (_isJoining == true) {
            JoinCall();
        }
        

        
    }).catch(function (error) {
        console.log("Create error: " + error);
    });

    
}

function DisplayLocalCamera()
{
    //alert('display');
    _vidyoConnector.RegisterLocalCameraEventListener({
        onAdded: function (localCamera) {
            console.log("added local Camera : " + localCamera);

            var exists = $("#cameraList option")
               .filter(function (i, o) { return o.value === window.btoa(localCamera.id); })
               .length > 0;
            
            if (!exists) {
                $("#cameraList").append("<option value='" + window.btoa(localCamera.id) + "'>" + localCamera.name + "</option>");
                cameras[window.btoa(localCamera.id)] = localCamera;
            }
        },
        onRemoved: function (localCamera) {
            $("#cameraList option[value='" + window.btoa(localCamera.id) + "']").remove();
            delete cameras[window.btoa(localCamera.id)];

            // If the removed camera was the selected camera, then hide it
            if (selectedLocalCamera.id === localCamera.id) {
                _vidyoConnector.HideView({ viewId: "selfView" }).then(function () {
                    console.log("HideView Success");
                }).catch(function (e) {
                    console.log("HideView Failed");
                });
            }
        },
        onSelected: function (localCamera) {
            console.log("select local Camera : "+ localCamera);
            if (localCamera) {
                //alert("camera selected - " + localCamera.name);
                //$("#cameraList option[value='" + window.btoa(localCamera.id) + "']").prop('selected', true);
                selectedLocalCamera.id = localCamera.id;
                selectedLocalCamera.camera = localCamera;
                
                _localCamera = localCamera; 
                /* Camera was selected by user or automatically */
                _vidyoConnector.AssignViewToLocalCamera({
                    viewId: "selfView",
                    localCamera: localCamera,
                    displayCropped: true,
                    allowZoom: false
                }).then(function () {
                    ShowRenderer("selfView");
                }).catch(function (e) {
                    console.log("AssignViewToLocalCamera Failed");
                });
                $("#selfView").height(70);
                $("#selfView").width(200);
            } else {
                selectedLocalCamera.id = 0;
                selectedLocalCamera.camera = null;
                _vidyoConnector.HideView({ viewId: "selfView" });
            }
        },
        onStateUpdated: function (localCamera, state) { /* Camera state was updated */ }
    }).then(function () {
        console.log("RegisterLocalCameraEventListener Success");
    }).catch(function () {
        console.error("RegisterLocalCameraEventListener Failed");
    });
}

function handleDeviceChange() {
    $("#cameraList").change(function () {
        // Camera selected from the drop-down menu
        $("#cameraList option:selected").each(function () {
            // Hide the view of the previously selected local camera
            _vidyoConnector.HideView({ viewId: "selfView" });
           
            // Select the newly selected local camera
            //debugger;
            var camera = cameras[$(this).val()];
            _vidyoConnector.SelectLocalCamera({
                localCamera: camera
            }).then(function () {
                //alert("SelectCamera Success");
                console.log("SelectCamera Success");
            }).catch(function () {
                console.error("SelectCamera Failed");
            });
        });
    });
}

function DisplayRemoteCamera()
{
    console.log("Display Remote Camera Init");
    _vidyoConnector.RegisterRemoteCameraEventListener({
        onAdded: function(remoteCamera, participant) {
            if (remoteCamera) {
                console.log("Remote Camera Added");
              _vidyoConnector.AssignViewToRemoteCamera({
                  viewId: "remoteView",
                remoteCamera: remoteCamera,
                displayCropped: true,
                allowZoom: false
                });
            }
            //$("#btnJoinCall").prop("disabled", false);
            //$("#lblInfo").text("Connected..")
        },
        onRemoved: function(remoteCamera, participant) {
            /* Existing camera became unavailable. */
            if (remoteCamera ) {
                _vidyoConnector.HideView({
                    viewId: "remoteView"
                    });
                }
            },
        onStateUpdated: function(remoteCamera, participant, state) { /* Camera state was updated */ }
    }).then(function () {
        //debugger;
            console.log("RegisterRemoteCameraEventListener Success");
        }).catch(function() {
            console.error("RegisterRemoteCameraEventListener Failed");
        });
}

function InitializeAudio()
{
    _vidyoConnector.RegisterLocalMicrophoneEventListener({
        onAdded: function (localMicrophone) { /* New microphone is available */
            
            if (localMicrophone) {
                console.log("local microphone Success");
              _vidyoConnector.SelectLocalMicrophone(localMicrophone);
            }
        },
        onRemoved:  function(localMicrophone) { /* Existing microphone became unavailable */ },
        onSelected: function(localMicrophone) { /* Microphone was selected by user or automatically */ },
        onStateUpdated: function(localMicrophone, state) { /* Microphone state was updated */ }
    }).then(function() {
        console.log("RegisterLocalMicrophoneEventListener Success");
    }).catch(function() {
        console.error("RegisterLocalMicrophoneEventListener Failed");
    });

    /* Speaker event listener */
    _vidyoConnector.RegisterLocalSpeakerEventListener({
        onAdded: function(localSpeaker) { /* New speaker is available */
            if (localSpeaker) {
                console.log("local speaker Success");
              _vidyoConnector.SelectLocalSpeaker(localSpeaker);
            }
        },
        onRemoved:  function(localSpeaker) { /* Existing speaker became unavailable */ },
        onSelected: function(localSpeaker) { /* Speaker was selected by user or automatically */ },
        onStateUpdated: function(localSpeaker, state) { /* Speaker state was updated */ }
        }).then(function() {
            console.log("RegisterLocalSpeakerEventListener Success");
        }).catch(function() {
            console.error("RegisterLocalSpeakerEventListener Failed");
        });
}

function JoinCall()
{
    //alert('join');
    //LoadVidyoClientLibrary(true);
    //DisplayRemoteCamera();
    _vidyoConnector.Connect({
        host: "prod.vidyo.io",  // Server name, for most production apps it will be prod.vidyo.io
        token: $("#hdnToken").val(),//"cHJvdmlzaW9uAEFrb3RvQDI1OTY4YS52aWR5by5pbwA2MzY5ODE0NTI1NAAAOTNhMjZhYWI1YWIxYjg5ZjdiMjI2MzA0OGY2ZDMxNDVjOTk3Y2UwMTU4MGE3NzQ4Yjk0MDA3ZDEzNGExY2ZlNmE5ZDE1ZmNlNmU1Yzk2YjI3NjkyNGZkMDdiNDRjYWQ5",          // Add generated token (https://developer.vidyo.io/documentation/4-1-16-8/getting-started#Tokens)
        displayName: _username.replace('@', '_'),  // Display name
        resourceId: _room, // Room name
        onSuccess: function () {
            console.log("Connected!! YAY!");
            ShowRenderer("remoteView");
            $("#remoteView").show();
            $("#btnCallIcon").attr("src", "../Images/callEnd.png")
            PlayRingBack(false);
            $('#chkCallInProgress').prop('checked', true).trigger("change");
            //$("#chkSecondLanguage").click();
            //$("#btnJoinCall").prop("disabled", false);
            //$("#lblInfo").text("Connected..")
            var cameracount = $('#cameraList').children('option').length;
            //alert(cameracount);
            //if (cameracount >= 2)
            //    $('#cameraList option:eq(1)').prop('selected', true);
            //else
            //    $('#selfView').disabled();

            ShowRenderer("selfView");
            
        },
        onFailure: function (reason) {
            console.error("Connection failed");
        },
        onDisconnected: function (reason) {
            console.log(" disconnected - " + reason);
            //debugger;
            _vidyoConnector.SelectLocalCamera({
                localCamera: null
            }).then(function () {
                console.log("SelectCamera Success");
            }).catch(function () {
                console.error("SelectCamera Failed");
            });
            _vidyoConnector.SelectLocalMicrophone({
                localMicrophone: null
            }).then(function () {
                console.log("SelectLocalMicrophone Success");
            }).catch(function () {
                console.error("SelectLocalMicrophone Failed");
            });
            _vidyoConnector.SelectLocalSpeaker({
                localSpeaker: null
            }).then(function () {
                console.log("SelectLocalSpeaker Success");
            }).catch(function () {
                console.error("SelectLocalSpeaker Failed");
            });
        }
    });
}


function Leave() {
    if (_vidyoConnector) {
        _vidyoConnector.Disconnect().then(function () {
            console.log("Disconnect Success");
            _vidyoConnector.HideView({ viewId: "selfView" }).then(function () {
                console.log("HideView Success");
                //_vidyoConnector.SelectLocalCamera(null);
                //_vidyoConnector.SelectLocalMicrophone(null);
                //_vidyoConnector.SelectLocalSpeaker(null);
            }).catch(function (e) {
                console.log("HideView Failed");fe
            });
        }).catch(function () {
            console.error("Disconnect Failure");
        });
    }
    else
    {
        _vidyoConnector = null;
    }
    $('#chkCallInProgress').prop('checked', false).trigger("change");
    PlayRingBack(false);
}

function ShowHideVideo(hide) {
    // CameraPrivacy button clicked
    _vidyoConnector.SetCameraPrivacy({
        privacy: hide
    }).then(function () {
        if (hide) {
            // Hide the local camera preview, which is in slot 0
            $("#cameraButton").addClass("cameraOff").removeClass("cameraOn");
            _vidyoConnector.HideView({ viewId: "selfView" }).then(function () {
                console.log("HideView Success");
            }).catch(function (e) {
                console.log("HideView Failed");
            });
        } else {
            // Show the local camera preview, which is in slot 0
            $("#cameraButton").addClass("cameraOn").removeClass("cameraOff");
            _vidyoConnector.AssignViewToLocalCamera({
                viewId: "selfView",
                localCamera: _localCamera.camera,
                displayCropped: true,
                allowZoom: false
            }).then(function () {
                console.log("AssignViewToLocalCamera Success");
                ShowRenderer("selfView");
            }).catch(function (e) {
                console.log("AssignViewToLocalCamera Failed");
            });
        }
        console.log("SetCameraPrivacy Success");
    }).catch(function () {
        console.error("SetCameraPrivacy Failed");
    });
}

// Handle the microphone mute button, toggle between mute and unmute audio.
function MuteUnMute(mute)
{
    // MicrophonePrivacy button clicked
    _vidyoConnector.SetMicrophonePrivacy({
        privacy: mute
    }).then(function () {
        if (mute) {
            $("#microphoneButton").addClass("microphoneOff").removeClass("microphoneOn");
        } else {
            $("#microphoneButton").addClass("microphoneOn").removeClass("microphoneOff");
        }
        console.log("SetMicrophonePrivacy Success");
    }).catch(function () {
        console.error("SetMicrophonePrivacy Failed");
    });
}

function ShowRenderer(divId)
{
    var rndr = document.getElementById(divId); 
    _vidyoConnector.ShowViewAt(divId, rndr.offsetLeft, rndr.offsetTop, rndr.offsetWidth, rndr.offsetHeight);

}

function Ring(ringing) {
    //var s = new buzz.sound('../content/sound/System/Ring.mp3');
    if (_sound == null)
        _sound  = new buzz.sound('../content/sound/System/Ring.mp3');
    _sound.load();
    if (ringing) {
        _sound.play().loop();
    }
    else {
        _sound.stop();
    }
}

function PlayRingBack(ringing) {
    
    //var s = new buzz.sound('../content/sound/System/RingBack.mp3');
    _sound.load();
    if (ringing)
        _sound.play().loop();
    else {
        _sound.stop();
    }
}

