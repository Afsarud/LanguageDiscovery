﻿const OPEN_REMOTE_SLOT = "-1";

// Keep track of attributes of remote camera sources:
// * max = maximum number of remote cameras to render; initialize to 8 but update as needed per resource manager recommendations.
// * count = total number of remote cameras that are streaming in the conference.
// * rendered = number of remote cameras that are locally rendered.
var remoteSources = { max: 3, count: 0, rendered: 0 }
var _isJoining = false;
var _room = "demoroom";
var _username = "";
var _ringbacksound = null;
var _ringsound = null;
var webrtcInitializeAttempts = 0;
var _isInCall = false;
var _isDisconnected = false;
var _startTime;
var _beepSound;
var _beepInterval;
var _warningshowed = false;
var vidyoConnector;

var cameras = {};
var microphones = {};
var speakers = {};
var selectedLocalCamera = { id: 0, camera: null };
var cameraPrivacy = false;
//var microphonePrivacy = true;
var remoteCameras = {};
var _isPartnerCameraChanged = false;
var _isVideoConnectorInstanceCreated = false;


// rendererSlots[0] is used to render the local camera;
// rendererSlots[1] through rendererSlots[8] are used to render up to 8 cameras from remote participants.
//var rendererSlots = ["1", OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT];
//var rendererSlots = ["1", OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT];
var rendererSlots = ["1", OPEN_REMOTE_SLOT, OPEN_REMOTE_SLOT];

function removescript() {

    var head = document.getElementsByTagName('head')[0];
    var scripts = head.getElementsByTagName('script');
    if (scripts.length > 0) {
        for (var i = 0; i < scripts.length; i++) {
            if (scripts[i].id == "vidyoscript") {
                alert(scripts[i]);
                head.removeChild(scripts[i]);
            }
        }

    }

}
function loadVidyoClientLibrary(room) {
    _isJoining = true;
    
    _room = room;
    if (_isJoining == true) {
        joinLeave();
    }

    //_username = user;
}

function attachedVidyo() {

    //We need to ensure we're loading the VidyoClient library and listening for the callback.
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.id = "vidyoscript";
    script.src = 'Scripts/VidyoClient.min.js'
    document.getElementsByTagName('head')[0].appendChild(script);
    script.onload = function () {
        onVidyoClientLoaded({ state: 'READY', description: 'Native XMPP + WebRTC' });
    };
    var style = document.createElement('link');
    style.rel = 'stylesheet';
    style.type = 'text/css';
    style.href = 'css/VidyoClient.css';
    document.getElementsByTagName('head')[0].appendChild(style);

    //GetVideoKey();
}

function onVidyoClientLoaded(status) {
    console.log("Status: " + status.state + "Description: " + status.description);
    switch (status.state) {
        case "READY":    // The library is operating normally
            //$("#connectionStatus").html("Ready to Connect");
            //$("#helper").addClass("hidden");
            //$("#toolbarLeft").removeClass("hidden");
            //$("#toolbarCenter").removeClass("hidden");
            //$("#toolbarRight").removeClass("hidden");
            //$("#rendererContainer").removeClass("hidden");

            // After the VidyoClient is successfully initialized a global VC object will become available
            // All of the VidyoConnector gui and logic is implemented in VidyoConnectorCustomLayout.js
            //if (VCUtils.params.webrtc === "true") {
            //    ++webrtcInitializeAttempts;
            //}
            //StartVidyoConnector(VC, configParams);

            window.VC = new window.VidyoClientLib.VidyoClient('', () => {
                // After the VidyoClient is successfully initialized a global VC object will become available
                // All of the VidyoConnector gui and logic is implemented in VidyoConnector.js
                StartVidyoConnector(VC, window.VCUtils ? window.VCUtils.params.webrtc : 'true');
            });

            break;
        case "RETRYING": // The library operating is temporarily paused
            consol.log("Temporarily unavailable retrying in " + status.nextTimeout / 1000 + " seconds");
            break;
        case "FAILED":   // The library operating has stopped
            // If WebRTC initialization failed, try again up to 3 times.
            if (status.description.includes("Could not initialize WebRTC transport") && (webrtcInitializeAttempts < 3)) {
                // Attempt to start the VidyoConnector again.
                //StartVidyoConnector(VC, configParams);
                window.VC = new window.VidyoClientLib.VidyoClient('', () => {
                    // After the VidyoClient is successfully initialized a global VC object will become available
                    // All of the VidyoConnector gui and logic is implemented in VidyoConnector.js
                    StartVidyoConnector(VC, window.VCUtils ? window.VCUtils.params.webrtc : 'true');
                });
                ++webrtcInitializeAttempts;
            } else {
                ShowFailed(status);
            }
            break;
        case "FAILEDVERSION":   // The library operating has stopped
            console.log("Failed: " + status.description);
            break;
        case "NOTAVAILABLE": // The library is not available
            console.log.html(status.description);
            break;
        case "TIMEDOUT":   // Transcoding Inactivity Timeout
            console.log("Failed: " + status.description);
            console.log('Page timed out due to inactivity. Please refresh your browser and try again.');
            break;
    }
    return true; // Return true to reload the plugins if not available
}

// Run StartVidyoConnector when the VidyoClient is successfully loaded
function StartVidyoConnector(VC, configParams) {

    //var vidyoConnector = null;
    var cameras = {};
    var microphones = {};
    var speakers = {};
    var selectedLocalCamera = { id: 0, camera: null };
    var cameraPrivacy = false;
    var microphonePrivacy = false;
    var remoteCameras = {};

    remoteSources.max = 3;
    console.log("Number of remote slots: " + configParams.numRemoteSlots);
    //remoteSources.max = configParams.numRemoteSlots;

    window.onresize = function () {
        showRenderers(vidyoConnector);
    };

    VC.CreateVidyoConnector({
        viewId: null, // Set to null in order to create a custom layout
        viewStyle: "VIDYO_CONNECTORVIEWSTYLE_Default",   // Visual style of the composited renderer
        remoteParticipants:3, // Maximum number of participants to render
        logFileFilter: "warning info@VidyoClient info@VidyoConnector",
        logFileName: "VidyoConnector.log",
        userData: 0,
        constraints: {
            disableGoogleAnalytics: true
        }
    }).then(function (vc) {
        vidyoConnector = vc;
        console.log("vidyoconnector is set.");
        $('#imgTestCamera').removeClass("disableHeaderMenu");

        // Don't display left panel if hideConfig is enabled.
        //if (configParams.hideConfig=="1") {
        //    updateRenderers(vidyoConnector, true);
        //}

        registerEventListeners(vidyoConnector, cameras, microphones, speakers, selectedLocalCamera, remoteCameras, configParams);
        handleDeviceChange(vidyoConnector, cameras, microphones, speakers);

        // If enableDebug is configured then enable debugging
        if (configParams.enableDebug === "1") {
            vidyoConnector.EnableDebug({ port: 7776, logFilter: "warning info@VidyoClient info@VidyoConnector" }).then(function () {
                console.log("EnableDebug success");
            }).catch(function () {
                console.error("EnableDebug failed");
            });
        }

        if (_isJoining == true) {
            joinLeave();
        }
        setMicrophonePrivacy(vidyoConnector);

        $("#microphoneButton").click(function () {
            // MicrophonePrivacy button clicked
            setMicrophonePrivacy(vidyoConnector);
        });

        function setMicrophonePrivacy(vidyoConnector) {
            microphonePrivacy = !microphonePrivacy;
            vidyoConnector.SetMicrophonePrivacy({
                privacy: microphonePrivacy
            }).then(function () {
                if (microphonePrivacy) {
                    $("#microphoneButton").addClass("microphoneOff").removeClass("microphoneOn");
                } else {
                    $("#microphoneButton").addClass("microphoneOn").removeClass("microphoneOff");
                }
                console.log("SetMicrophonePrivacy Success");
            }).catch(function () {
                console.error("SetMicrophonePrivacy Failed");
            });
        }

       
       
    }).catch(function (err) {
        console.error("CreateVidyoConnector Failed " + err);
    });
}

function joinLeave() {
    if ($("#joinLeaveButton").hasClass("callStart")) {
        $("#connectionStatus").html("Connecting...");
        $("#joinLeaveButton").removeClass("callStart").addClass("callEnd");
        $('#joinLeaveButton').prop('title', 'Leave Conference');

        connectToConference(vidyoConnector, remoteCameras, configParams);

    } else {
        vidyoConnector.Disconnect().then(function () {
            vidyoConnector.HideView({ viewId: "renderer0" }).then(function () {
                $("#renderer1").hide();
                $("#renderer2").hide();
                $("#renderer3").hide();
                $("#toolbarCenter").addClass("hidden");
                console.log("HideView Success");
            }).catch(function (e) {
                console.log("HideView Failed");
            });
            console.log("Disconnect Success");
        }).catch(function ( ex) {
            console.error("Disconnect Failure: " + ex);
        });
    }
    $("#joinLeaveButton").one("click", joinLeave);

}
function createGuid() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}  
function testCameraAndMic(room, user) {
    if (vidyoConnector == undefined || vidyoConnector == null) {
        console.error("vidyoConnector is null");
        attachedVidyo();
        UnBlockElement();
        return;
    }
    vidyoConnector.HideView({ viewId: "renderer0" }).then(function () {
        console.log("HideView daw Success");
        $('#renderer0').hide();
    });
    // join or leave dependent on the joinLeaveButton, whether it
    // contains the class callStart or callEnd.
    _username = user;
    if ($("#imgTestCamera").hasClass("callStart")) {
        $("#imgTestCamera").removeClass("callStart").addClass("callEnd");
        //$("#imgTestCamera").one("click", testCameraAndMic);
        //assignCameraToLocalView(vidyoConnector, cameras);
        registerEventListeners(vidyoConnector, cameras, microphones, speakers, selectedLocalCamera, remoteCameras, configParams);
        connectToTestConference(vidyoConnector, remoteCameras, configParams, room);
        $('#btnTestCamera').show();

    } else {
        vidyoConnector.Disconnect().then(function () {
            vidyoConnector.HideView({ viewId: "renderer0" }).then(function () {
                console.log("HideView Testing Success");
            }).catch(function (e) {
                console.log("HideView Testing Failed");
            });
            console.log("Disconnect Testing Success");
        }).catch(function () {
            console.error("Disconnect Testing Failure");
        });
    }

}
function connectToTestConference(vidyoConnector, remoteCameras, configParams, room) {
    console.log("connected to room:" + room);
    vidyoConnector.ConnectToRoomAsGuest({
        // Take input from options form
        host: "ld.platform.vidyo.io",
        displayName: _username.replace('@', '_'),
        roomKey: room,
        // Define handlers for connection events.
        onSuccess: function () {
            //$("#btnCallIcon").attr("src", "../Images/callEnd.png")
            //$('#chkCallInProgress').prop('checked', true).trigger("change");
            // Connected
            //$('#renderer0').show();
            console.log("vidyoConnector.Connect : onSuccess callback received");
            // Register for resource manager events
            vidyoConnector.RegisterResourceManagerEventListener({
                onAvailableResourcesChanged: function (cpuEncode, cpuDecode, bandwidthSend, bandwidthReceive) {
                    console.log("onAvailableResourcesChanged: cpuEncode=" + cpuEncode + ", cpuDecode=" + cpuDecode +
                        ", bandwidthSend=" + bandwidthSend + ", bandwidthReceive=" + bandwidthReceive);
                },
                onMaxRemoteSourcesChanged: function (maxRemoteSources) {
                    console.log("****** onMaxRemoteSourcesChanged: maxRemoteSources=" + maxRemoteSources);
                    if ((maxRemoteSources < remoteSources.max) && (remoteSources.rendered > maxRemoteSources)) {
                        console.log("****** maxRemoteSources dropped from " + remoteSources.max + " to " + maxRemoteSources + ". Removing " + (remoteSources.rendered - maxRemoteSources) + " remote sources");
                    } else if ((maxRemoteSources > remoteSources.max) && (remoteSources.count > remoteSources.max)) {
                        // The maxRemoteSources increased and we have additional sources to render.
                        console.log("****** maxRemoteSources increased from " + remoteSources.max + " to " + maxRemoteSources);
                        var numSourcesToAdd = maxRemoteSources - remoteSources.rendered;
                        var addedSources = 0;
                        console.log("******* ...will attempt to add " + numSourcesToAdd + " sources");
                        //debugger;
                        // Search for a remote camera to render.
                        for (var id in remoteCameras) {
                            if (!remoteCameras[id].isRendered) {
                                // If an open slot is found then render remote camera stream to it.
                                var openSlot = findOpenSlot();
                                if (openSlot > 0)
                                    renderToSlot(vidyoConnector, remoteCameras, id, openSlot);

                                // Check if we have added our allotment of remote sources. If so, then break out of loop.
                                ++addedSources;
                                if (addedSources == numSourcesToAdd)
                                    break;
                            }
                        }
                    }
                    // Update the stored max remote sources value.
                    remoteSources.max = maxRemoteSources;
                }
            }).then(function () {
                console.log("RegisterResourceManagerEventListener Success");
            }).catch(function () {
                console.error("RegisterResourceManagerEventListener Failed");
            });
        },
        onFailure: function (reason) {
            // Failed
            console.error("vidyoConnector.Connect : onFailure callback received " + reason);
            connectorDisconnected(vidyoConnector, remoteCameras, "Failed", "");
            alert("Connection Failed: " + reason);
            //$("#error").html("<h3>Call Failed: " + reason + "</h3>");
        },
        onDisconnected: function (reason) {
            // Disconnected
            console.log("vidyoConnector.Connect : onDisconnected callback received");
            connectorDisconnected(vidyoConnector, remoteCameras, "Disconnected", "Call Disconnected: " + reason);
            if (configParams.hideConfig != "1") {
                updateRenderers(vidyoConnector, false);
            }
        }
    }).then(function (status) {
        if (status) {
            console.log("Connect Success");
        } else {
            console.error("Connect Failed");
            connectorDisconnected(vidyoConnector, remoteCameras, "Failed", "");
            //$("#error").html("<h3>Call Failed" + "</h3>");
        }
    }).catch(function () {
        console.error("Connect Failed");
        connectorDisconnected(vidyoConnector, remoteCameras, "Failed", "");
        //$("#error").html("<h3>Call Failed" + "</h3>");
    });
}

// Render a video in the div.
function ShowRenderer(vidyoConnector, divId) {
    var rndr = document.getElementById(divId);
    vidyoConnector.ShowViewAt({ viewId: divId, x: rndr.offsetLeft, y: rndr.offsetTop, width: rndr.offsetWidth, height: rndr.offsetHeight });
}

// Find an open slot in the receive source slots (1 - 8)
function findOpenSlot() {
    // Scan through the renderer slots and look for an open slot.
    for (var i = 1; i < rendererSlots.length; ++i) {
        if (rendererSlots[i] === OPEN_REMOTE_SLOT)
            return i;
    }
    return 0;
}

// Render a remote camera to a particular slot
function renderToSlot(vidyoConnector, remoteCameras, participantId, slot) {
    // Render the remote camera to the slot.
    //alert(slot + " " + participantId);
    rendererSlots[slot] = participantId;
    remoteCameras[participantId].isRendered = true;
    vidyoConnector.AssignViewToRemoteCamera({
        viewId: "renderer" + (slot),
        remoteCamera: remoteCameras[participantId].camera,
        displayCropped: configParams.remoteCameraDisplayCropped,
        allowZoom: false
    }).then(function (retValue) {
        console.log("AssignViewToRemoteCamera " + participantId + " to slot " + slot + " = " + retValue);
        ShowRenderer(vidyoConnector, "renderer" + (slot));
        $("#renderer" + (slot)).show();
        ++remoteSources.rendered;
    }).catch(function () {
        console.log("AssignViewToRemoteCamera Failed");
        rendererSlots[slot] = OPEN_REMOTE_SLOT;
        remoteCameras[participantId].isRendered = false;
    });
}
function onDisconnected() {
    //if (_isPartnerCameraChanged) {
    //    return;
    //}
    //_isDisconnected = true;
    //if (_isInCall == true) {
    //    _SomeoneIscalling = false;
    //    _isInCall = false;
    //    if ($("#btnCallIcon").attr("src").indexOf("callEnd.png") > -1) {
    //        joinLeave();
    //        $("#btnCallIcon").attr("src", "../Images/new/CallingStatic.png");
    //        $("#renderer0").hide();
    //        $("#renderer1").hide();
    //    }
        
    //    //$("#btnCallIcon").click();
    //}
    ////UpdateTalkStatus("false");
}
function registerEventListeners(vidyoConnector, cameras, microphones, speakers, selectedLocalCamera, remoteCameras, configParams) {
    // Map the "None" option (whose value is 0) in the camera, microphone, and speaker drop-down menus to null since
    // a null argument to SelectLocalCamera, SelectLocalMicrophone, and SelectLocalSpeaker releases the resource.
    cameras[0] = null;
    microphones[0] = null;
    speakers[0] = null;
    $("#cameras").empty();
    $("#microphones").empty();
    $("#speakers").empty();
    // Handle appearance and disappearance of camera devices in the system
    vidyoConnector.RegisterLocalCameraEventListener({
        onAdded: function (localCamera) {
            // New camera is available
            //if (!cameras.includes(localCamera)) {
            $("#cameras").append("<option value='" + window.btoa(localCamera.id) + "'>" + localCamera.name + "</option>");
            cameras[window.btoa(localCamera.id)] = localCamera;
            if (localCamera.name.toLowerCase().indexOf("front") > -1 || localCamera.name.toLowerCase().indexOf("前面カメラ") > -1) {
                $("#cameras option[value='" + window.btoa(localCamera.id) + "']").prop('selected', true);
                $("#cameras").trigger('change');
            }

            //}
        },
        onRemoved: function (localCamera) {
            // Existing camera became unavailable
            $("#cameras option[value='" + window.btoa(localCamera.id) + "']").remove();
            delete cameras[window.btoa(localCamera.id)];

            // If the removed camera was the selected camera, then hide it
            if (selectedLocalCamera.id === localCamera.id) {
                vidyoConnector.HideView({ viewId: "renderer0" }).then(function () {
                    console.log("HideView Success");
                }).catch(function (e) {
                    console.log("HideView Failed");
                });
            }
        },
        onSelected: function (localCamera) {
            // Camera was selected/unselected by you or automatically
            if (localCamera) {
                $("#cameras option[value='" + window.btoa(localCamera.id) + "']").prop('selected', true);
                selectedLocalCamera.id = localCamera.id;
                selectedLocalCamera.camera = localCamera;

                // Assign view to selected camera
                vidyoConnector.AssignViewToLocalCamera({
                    viewId: "renderer0",
                    localCamera: localCamera,
                    displayCropped: true,
                    allowZoom: true
                }).then(function () {
                    console.log("AssignViewToLocalCamera Success");
                    ShowRenderer(vidyoConnector, "renderer0");
                    _isPartnerCameraChanged = false;
                }).catch(function (e) {
                    console.log("AssignViewToLocalCamera Failed");
                });
            } else {
                selectedLocalCamera.id = 0;
                selectedLocalCamera.camera = null;
            }
        },
        onStateUpdated: function (localCamera, state) {
            // Camera state was updated
        }
    }).then(function () {
        console.log("RegisterLocalCameraEventListener Success");
    }).catch(function () {
        console.error("RegisterLocalCameraEventListener Failed");
    });

    // Handle appearance and disappearance of microphone devices in the system
    vidyoConnector.RegisterLocalMicrophoneEventListener({
        onAdded: function (localMicrophone) {
            // New microphone is available
            $("#microphones").append("<option value='" + window.btoa(localMicrophone.id) + "'>" + localMicrophone.name + "</option>");
            microphones[window.btoa(localMicrophone.id)] = localMicrophone;
        },
        onRemoved: function (localMicrophone) {
            // Existing microphone became unavailable
            $("#microphones option[value='" + window.btoa(localMicrophone.id) + "']").remove();
            delete microphones[window.btoa(localMicrophone.id)];
        },
        onSelected: function (localMicrophone) {
            // Microphone was selected/unselected by you or automatically
            if (localMicrophone)
                $("#microphones option[value='" + window.btoa(localMicrophone.id) + "']").prop('selected', true);
        },
        onStateUpdated: function (localMicrophone, state) {
            // Microphone state was updated
        }
    }).then(function () {
        console.log("RegisterLocalMicrophoneEventListener Success");
    }).catch(function () {
        console.error("RegisterLocalMicrophoneEventListener Failed");
    });

    // Handle appearance and disappearance of speaker devices in the system
    vidyoConnector.RegisterLocalSpeakerEventListener({
        onAdded: function (localSpeaker) {
            // New speaker is available
            $("#speakers").append("<option value='" + window.btoa(localSpeaker.id) + "'>" + localSpeaker.name + "</option>");
            speakers[window.btoa(localSpeaker.id)] = localSpeaker;
        },
        onRemoved: function (localSpeaker) {
            // Existing speaker became unavailable
            $("#speakers option[value='" + window.btoa(localSpeaker.id) + "']").remove();
            delete speakers[window.btoa(localSpeaker.id)];
        },
        onSelected: function (localSpeaker) {
            // Speaker was selected/unselected by you or automatically
            if (localSpeaker)
                $("#speakers option[value='" + window.btoa(localSpeaker.id) + "']").prop('selected', true);
        },
        onStateUpdated: function (localSpeaker, state) {
            // Speaker state was updated
        }
    }).then(function () {
        console.log("RegisterLocalSpeakerEventListener Success");
    }).catch(function () {
        console.error("RegisterLocalSpeakerEventListener Failed");
    });

    vidyoConnector.RegisterRemoteCameraEventListener({
        onAdded: function (camera, participant) {
            getParticipantName(participant, function (name) {
                if (name.indexOf('_Teacher') > -1)
                    return;

                console.log("Participant onAdded " + name);
                _isPartnerCameraChanged = false;
                //debugger;
                // Store the remote camera for this participant
                remoteCameras[participant.id] = { camera: camera, isRendered: false };
                ++remoteSources.count;

                // Check if resource manager allows for an additional source to be rendered.
                if (remoteSources.rendered < remoteSources.max) {
                    // If an open slot is found then assign it to the remote camera.
                    //debugger;
                    var openSlot = findOpenSlot();
                    if (openSlot > 0) {

                        renderToSlot(vidyoConnector, remoteCameras, participant.id, openSlot);
                    }
                }
            });


        },
        onRemoved: function (camera, participant) {
            console.log("RegisterRemoteCameraEventListener onRemoved participant.id : " + participant.id);
            delete remoteCameras[participant.id];
            --remoteSources.count;

            // Scan through the renderer slots and if this participant's camera
            // is being rendered in a slot, then clear the slot and hide the camera.
            for (var i = 1; i < rendererSlots.length; i++) {
                if (rendererSlots[i] === participant.id) {
                    rendererSlots[i] = OPEN_REMOTE_SLOT;
                    console.log("Slot found, calling HideView on renderer" + i);
                    vidyoConnector.HideView({ viewId: "renderer" + (i) }).then(function () {
                        console.log("HideView Success");
                        --remoteSources.rendered;

                        // If a remote camera is not rendered in a slot, replace it in the slot that was just cleared
                        for (var id in remoteCameras) {
                            if (!remoteCameras[id].isRendered) {
                                renderToSlot(vidyoConnector, remoteCameras, id, i);
                                break;
                            }
                        }
                    }).catch(function (e) {
                        console.log("HideView Failed");
                    });
                    break;
                }
            }
            console.log("Participant name on removed: " + participant.name)
            if (participant.name.indexOf("_Teacher") > -1)
                return;
            else {
                onDisconnected();
            }

        },
        onStateUpdated: function (camera, participant, state) {
            alert("camera state : " + state);
        }
    }).then(function () {
        console.log("RegisterRemoteCameraEventListener Success");
    }).catch(function () {
        console.error("RegisterRemoteCameraEventListener Failed");
    });

    vidyoConnector.RegisterParticipantEventListener({
        onJoined: function (participant) {
            getParticipantName(participant, function (name) {
                //alert(name);
                //$("#participantStatus").html("" + name + " Joined");
                console.log("Participant onJoined: " + name);
            });
        },
        onLeft: function (participant) {
            getParticipantName(participant, function (name) {
                //$("#participantStatus").html("" + name + " Left");
                console.log("Participant onLeft: " + name);
                if (name.indexOf('_Teacher') > -1)
                    return;
                else {
                    onDisconnected();
                }
            });
        },
        onDynamicChanged: function (participants, cameras) {
            // Order of participants changed
        },
        onLoudestChanged: function (participant, audioOnly) {
            //getParticipantName(participant, function(name) {
            //    console.log("" + name + " Speaking");
            //});

            //// Consider switching loudest speaker tile if resource manager allows
            //// for at least 1 remote source to be rendered.
            //if (remoteSources.max > 0) {
            //    // Check if the loudest speaker is being rendered in one of the slots
            //    var found = false;
            //    for (var i = 1; i < rendererSlots.length; i++) {
            //        if (rendererSlots[i] === participant.id) {
            //            found = true;
            //            break;
            //        }
            //    }
            //    console.log("onLoudestChanged: loudest speaker in rendererSlots? " + found);

            //    // First check if the participant's camera has been added to the remoteCameras dictionary
            //    if (!(participant.id in remoteCameras)) {
            //        console.log("Warning: loudest speaker participant does not have a camera in remoteCameras");
            //    }
            //    // If the loudest speaker is not being rendered in one of the slots then
            //    // hide the slot 1 remote camera and assign loudest speaker to slot 1.
            //    else if (!found) {
            //        // Set the isRendered flag to false of the remote camera which is being hidden
            //        remoteCameras[rendererSlots[1]].isRendered = false;

            //        // Hiding the view first, before assigning to the loudes speaker's camera.
            //        vidyoConnector.HideView({ viewId: "renderer1"}).then(function() {
            //            console.log("HideView Success");
            //            --remoteSources.rendered;

            //            // Assign slot 1 to the the loudest speaker
            //            renderToSlot(vidyoConnector, remoteCameras, participant.id, 1);
            //        }).catch(function(e) {
            //            console.log("HideView Failed, loudest speaker not assigned");
            //        });
            //    }
            //} else {
            //    console.log("Warning: not rendering loudest speaker because max remote sources is 0.");
            //}
        }
    }).then(function () {
        console.log("RegisterParticipantEventListener Success");
    }).catch(function () {
        console.err("RegisterParticipantEventListener Failed");
    });
}

function handleDeviceChange(vidyoConnector, cameras, microphones, speakers) {
    // Hook up camera selector functions for each of the available cameras
    $("#cameras").change(function () {
        // Camera selected from the drop-down menu
        assignCameraToLocalView(vidyoConnector, cameras);
    });

    // Hook up microphone selector functions for each of the available microphones
    $("#microphones").change(function () {
        // Microphone selected from the drop-down menu
        $("#microphones option:selected").each(function () {
            microphone = microphones[$(this).val()];
            vidyoConnector.SelectLocalMicrophone({
                localMicrophone: microphone
            }).then(function () {
                console.log("SelectMicrophone Success");
            }).catch(function () {
                console.error("SelectMicrophone Failed");
            });
        });
    });

    // Hook up speaker selector functions for each of the available speakers
    $("#speakers").change(function () {
        // Speaker selected from the drop-down menu
        $("#speakers option:selected").each(function () {
            speaker = speakers[$(this).val()];
            vidyoConnector.SelectLocalSpeaker({
                localSpeaker: speaker
            }).then(function () {
                console.log("SelectSpeaker Success");
            }).catch(function () {
                console.error("SelectSpeaker Failed");
            });
        });
    });
}

function assignCameraToLocalView(vidyoConnector, cameras) {
    $("#cameras option:selected").each(function () {
        // Hide the view of the previously selected local camera
        vidyoConnector.HideView({ viewId: "renderer0" }).then(function () {
            console.log("HideView Success");
        }).catch(function (e) {
            console.log("HideView Failed");
        });

        // Select the newly selected local camera
        camera = cameras[$(this).val()];
        vidyoConnector.SelectLocalCamera({
            localCamera: camera
        }).then(function () {
            console.log("SelectCamera Success");
            _isPartnerCameraChanged = false;
        }).catch(function () {
            console.error("SelectCamera Failed");
            alert(x + " failed");
        });
    });
}

function getParticipantName(participant, cb) {
    if (!participant) {
        cb("Undefined");
        return;
    }

    if (participant.name) {
        cb(participant.name);
        return;
    }

    participant.GetName().then(function (name) {
        cb(name);
    }).catch(function () {
        cb("GetNameFailed");
    });
}

function showRenderers(vidyoConnector) {
    ShowRenderer(vidyoConnector, "renderer0");
    ShowRenderer(vidyoConnector, "renderer1");
    ShowRenderer(vidyoConnector, "renderer2");
}

function updateRenderers(vidyoConnector, fullscreen) {
    fullscreen = false;
    $("#rendererContainer").removeClass("hidden");

    if (fullscreen) {
        $("#options").addClass("optionsHide");
        $("#rendererContainer").css({ 'position': 'absolute', 'top': '0px', 'right': '0px', 'left': '438px', 'bottom': '60px', 'z-index': '99', 'width': '75%' })
        $("#renderer0").css({ 'position': 'absolute', 'left': '0%', 'right': '66%', 'top': '0px', 'bottom': '67%', 'width': '34%', 'background-color': 'gray' });
        $("#renderer1").css({ 'position': 'absolute', 'left': '34%', 'right': '33%', 'top': '0px', 'bottom': '67%', 'width': '33%', 'background-color': 'darkgray' });
        $("#renderer2").css({ 'position': 'absolute', 'left': '67%', 'right': '0%', 'top': '0px', 'bottom': '67%', 'width': '33%', 'background-color': 'gray' });
    } else {
        $("#options").removeClass("optionsHide");
        $("#rendererContainer").css({ 'position': 'absolute', 'top': '0px', 'right': '0px', 'bottom': '60px', 'z-index': '99', 'width': '75%' })
    }
    showRenderers(vidyoConnector);
}

function defaultToFontCamera() {
    var localcameras = Object.values(cameras);
    if (localcameras != null && localcameras.length > 0) {
        localcameras.forEach((item) => {
            if (item != null) {
                if (item.name.toLowerCase().indexOf("front") > -1) {
                    $("#cameras option[value='" + window.btoa(item.id) + "']").prop('selected', true);
                    $("#cameras").trigger('change');
                    return;
                }
            }
        });
    }
}

// Attempt to connect to the conference
// We will also handle connection failures
// and network or server-initiated disconnects.
function connectToConference(vidyoConnector, remoteCameras, configParams) {
    console.log("connected to room:" + _room);
    vidyoConnector.ConnectToRoomAsGuest({
        // Take input from options form
        host: "ld.platform.vidyo.io",
        displayName: $("#hdnDisplayName").val() + '_Teacher',
        roomKey: _room,
        // Define handlers for connection events.
        onSuccess: function () {
            console.log("vidyoConnector.Connect : onSuccess callback received");
            $("#toolbarCenter").removeClass("hidden");

            updateRenderers(vidyoConnector, true);
        },
        onFailure: function (reason) {
            // Failed
            console.error("vidyoConnector.Connect : onFailure callback received " + reason);
            connectorDisconnected(vidyoConnector, remoteCameras, "Failed", "");
            alert("Connection Failed: " + reason);
            onDisconnected();
            //$("#error").html("<h3>Call Failed: " + reason + "</h3>");
        },
        onDisconnected: function (reason) {
            // Disconnected
            console.log("vidyoConnector.Connect : onDisconnected callback received");
            connectorDisconnected(vidyoConnector, remoteCameras, "Disconnected", "Call Disconnected: " + reason);
            if (configParams.hideConfig != "1") {
                updateRenderers(vidyoConnector, false);
            }
        }
    }).then(function (status) {
        if (status) {
            console.log("Connect Success");
        } else {
            console.error("Connect Failed");
            connectorDisconnected(vidyoConnector, remoteCameras, "Failed", "");
            //$("#error").html("<h3>Call Failed" + "</h3>");
        }
    }).catch(function () {
        console.error("Connect Failed");
        connectorDisconnected(vidyoConnector, remoteCameras, "Failed", "");
        //$("#error").html("<h3>Call Failed" + "</h3>");
    });
}

function disconnect() {
    connectorDisconnected(vidyoConnector, remoteCameras, "", "");
}

// Connector either fails to connect or a disconnect completed, update UI
// elements and clear rendererSlots and remoteCameras.
function connectorDisconnected(vidyoConnector, remoteCameras, connectionStatus, message) {
    $("#connectionStatus").html(connectionStatus);
    $("#message").html(message);
    $("#participantStatus").html("");
    $("#joinLeaveButton").removeClass("callEnd").addClass("callStart");
    $('#joinLeaveButton').prop('title', 'Join Conference');

    // Clear rendererSlots and remoteCameras when not connected in case not cleared
    // in RegisterRemoteCameraEventListener onRemoved.
    for (var i = 1; i < rendererSlots.length; i++) {
        if (rendererSlots[i] != OPEN_REMOTE_SLOT) {
            rendererSlots[i] = OPEN_REMOTE_SLOT;
            console.log("Calling HideView on renderer" + i);
            vidyoConnector.HideView({ viewId: "renderer" + (i) }).then(function () {
                console.log("HideView Success");
            }).catch(function (e) {
                console.log("HideView Failed");
            });
        }
    }
    remoteCameras = {};
    remoteSources.max = 3;
    remoteSources.count = 0;
    remoteSources.rendered = 0;

    // Unregister for resource manager events
    vidyoConnector.UnregisterResourceManagerEventListener().then(function () {
        console.log("UnregisterResourceManagerEventListener Success");
    }).catch(function () {
        console.error("UnregisterResourceManagerEventListener Failed");
    });
}

function showElapsedwindow() {
    //if (_beepSound == null)
    //    _beepSound = new buzz.sound('../Content/Sound/System/beep.mp3');
    //_beepSound.load();
    //_beepSound.play().loop();
    timeElapsed();
    clearInterval(_beepInterval);
}
