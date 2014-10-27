$(function() {

    // This module must enable by HTML meta tag (name=geo-enabled) first.
    var enabled = $('meta[name=geo-enabled]').attr('content');
    if (!enabled || enabled.toLowerCase()!='true') return;

    // Upload location info
    var callbackUrl = $('meta[name=geo-callback-url]').attr('content');

    console.log('[E7READ] Geo Location module initialized...');

    var update_location = function(lat, lon, callback) {
        console.log("Update Location: " + lat + ", " + lon);

        if (callback == null) {
            callback = function(data) {
                // none
                console.log(data);
            };
        }

        $.ajax({
            url: callbackUrl,
            data: {lat: lat, lon: lon},
            success: callback
        });
    };

    $.geoupdate = function(options) {

        var options = $.extend({
            lat: null,
            lon: null,
            callback: null
        }, options);

        update_location(options.lat, options.lon, options.callback);
    };

    navigator.geolocation.getCurrentPosition(function(position) {
        var lat = position.coords.latitude;  //緯度
        var lon = position.coords.longitude; //經度
        update_location(lat, lon);
    });
});