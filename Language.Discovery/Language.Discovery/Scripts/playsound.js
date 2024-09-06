/**
 * @author Alexander Manzyuk <admsev@gmail.com>
 * Copyright (c) 2012 Alexander Manzyuk - released under MIT License
 * https://github.com/admsev/jquery-play-sound
 * Usage: $.playSound('http://example.org/sound.mp3');
**/

(function ($) {

    $.extend({
        playSound: function () {
            var embed = "<embed src='" + arguments[0] + "' hidden='true' autostart='true' loop='false' class='playSound'>";
            //var audio = "<audio controls><source src='"+ arguments[0] +  "'  type='audio/mpeg'>" + embed + "</audio>";
            
            return $(embed).appendTo('body');
        }
    });

    ////function fnIsAppleMobile() {
    ////    if (navigator && navigator.userAgent && navigator.userAgent != null) {
    ////        var strUserAgent = navigator.userAgent.toLowerCase();
    ////        var arrMatches = strUserAgent.match(/(iphone|ipod|ipad)/);
    ////        if (arrMatches)
    ////            return true;
    ////    } // End if (navigator && navigator.userAgent) 

    ////    return false;
    ////} // End Function fnIsAppleMobile


})(jQuery);