$(function() {

    // This module must enable by HTML meta tag (name=geo-enabled) first.
    var enabled = $('meta[name=geo-enabled]').attr('content');
    if (!enabled || enabled.toLowerCase()!='true') return;

    console.log('[E7READ] Geo Location module initialized...');

    var show_map = function(position) {
        var lat = position.coords.latitude;  //緯度
        var lon = position.coords.longitude; //經度
        console.log("Location: " + lat + ", " + lon);

        // Upload location info
        var callbackUrl = $('meta[name=geo-callback-url]').attr('content');

        $.ajax({
            url: callbackUrl,
            data: {lat: lat, lon: lon},
            success: function() {
                // none
            }
        });
    };

    navigator.geolocation.getCurrentPosition(show_map);
});