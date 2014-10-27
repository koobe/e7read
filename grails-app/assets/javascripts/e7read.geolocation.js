$(function() {

    // This module must enable by HTML meta tag (name=geo-enabled) first.
    var enabled = $('meta[name=geo-enabled]').attr('content');
    if (!enabled || enabled.toLowerCase()!='true') return;

    // Upload location info
    var callbackUrl = $('meta[name=geo-callback-url]').attr('content');

    console.log('[E7READ] Geo Location module initialized...');

    var update_location = function(lat, lon) {
        console.log("Update Location: " + lat + ", " + lon);
        $.ajax({
            url: callbackUrl,
            data: {lat: lat, lon: lon},
            success: function(data) {
                // none
                console.log(data);
            }
        });
    };

    $.geoupdate = function(options) {

        var options = $.extend({
            lat: null,
            lon: null
        }, options );

        update_location(options.lat, options.lon);
    };

    navigator.geolocation.getCurrentPosition(function(position) {
        var lat = position.coords.latitude;  //緯度
        var lon = position.coords.longitude; //經度
        update_location(lat, lon);
    });
});