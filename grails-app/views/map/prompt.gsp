<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="jqm14" />
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<!--<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=false"></script>-->
<style type="text/css">
body { overflow: hidden; }
.map-container { width: 100%; height: 100%; padding: 0; }
#map-page {width: 100%; height: 100%; }
#map-canvas { width: 100%; height: 100%; }
.controls {
    margin-top: 16px;
    border: 1px solid transparent;
    border-radius: 2px 0 0 2px;
    box-sizing: border-box;
    -moz-box-sizing: border-box;
    height: 32px;
    outline: none;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

#pac-input {
    background-color: #fff;
    padding: 0 11px 0 13px;
    width: 400px;
    font-family: Roboto;
    font-size: 15px;
    font-weight: 300;
    text-overflow: ellipsis;
    opacity: .7;
}

#pac-input:focus {
    border-color: #4d90fe;
    margin-left: -1px;
    padding-left: 14px;  /* Regular padding-left + 1. */
    width: 401px;
    opacity: 1;
}

.pac-container {
    font-family: Roboto;
}

#type-selector {
    color: #fff;
    background-color: #4d90fe;
    padding: 5px 11px 0px 11px;
}

#type-selector label {
    font-family: Roboto;
    font-size: 13px;
    font-weight: 300;
}
</style>
</head>
<body>
<div data-role="page" data-theme="b" id="map-page">
    <div data-role="header" data-position="fixed" class="map-header">
        <g:link uri="/" data-icon="back" rel="external" class="btnCancel">Cancel</g:link>
        <h1>Where? Where?</h1>
        <g:link uri="#" data-icon="check" rel="external" class="btnDone">Done</g:link>
    </div>
    <div data-role="main" class="ui-content map-container">
        <div id="map-canvas"></div>
    </div>
    <!--
    <div data-role="footer" data-position="fixed" class="map-footer">
        <input id="pac-input" class="controls" type="text" placeholder="Search Box"/>
    </div>
    -->
</div>
<script type="text/javascript">

//var callbackFunction = null;

$( document ).on( "pageinit", "#map-page", function() {

    var myLatlng = new google.maps.LatLng(${lat}, ${lon});

    var mapOptions = {
        center: myLatlng,
        zoom: ${zoom},
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles: GOOGLE_MAPS_STYLES.Cool_Grey
    };

    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    // make content layout for info window display
    var makeHtmlContent = function(content) {

        var box = $('<div class="row" />');

        var left = $('<div class="col-sm-4" />');

        var a = $('<a target="blank" />').attr('href', content.shareUrl);
        a.append($('<img align="left" alt="cover" border="0" class="img-thumbnail img-responsive" style="max-width: 200px; max-height: 200px; padding: 10px;" />').attr('src', content.coverUrl));

        left.append(a);

        box.append(left);

        var right = $('<div class="col-sm-8" />');

        right.append($('<h4 style="color:#333;"/>').text(content.cropTitle));
        right.append($('<p style="color:#333;"/>').text(content.cropText));
        right.append($('<a target="blank" style="font-size: 1.1em;" />').attr('href', content.shareUrl).text('read more...'));

        box.append(right);

        return box.html();
    };

    var mymarker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: "You're Here",
        draggable: true,
        animation: google.maps.Animation.DROP
    });

    $('.btnCancel').unbind('click').click(function() {
        window.close();
        return false;
    });

    $('.btnDone').unbind('click').click(function() {
        var lat = mymarker.getPosition().lat();
        var lng = mymarker.getPosition().lng();

        console.log(window.parent.$('input[name=lat]'));

        window.opener.$('input[name=lat]').val(lat);
        window.opener.$('input[name=lon]').val(lng);
        window.opener.$('input[name=geolocation]').val(lat+","+lng);
        window.opener.$('input[name=geolocation]').trigger('change');

//        if (callbackFunction) {
//            callbackFunction(lat, lng);
//        }

        window.close();

        return false;
    });

    var elm = $('<input id="pac-input" class="controls" type="text" placeholder="Search Box" style="display: none">');

    elm.appendTo($('#map-canvas'));

    var input = document.getElementById('pac-input');
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchBox = new google.maps.places.SearchBox(input);

    setTimeout(function() {
        elm.show(200);
    }, 1000);

    var placesMarkers = [];

    google.maps.event.addListener(searchBox, 'places_changed', function() {
        var places = searchBox.getPlaces();

        if (places.length == 0) {
            return;
        }

        for (var i = 0, marker; marker = placesMarkers[i]; i++) {
            marker.setMap(null);
        }

        placesMarkers = [];

        var bounds = new google.maps.LatLngBounds();

        var lastLocation;

        for (var i = 0, place; place = places[i]; i++) {
            var image = {
                url: place.icon,
                size: new google.maps.Size(71, 71),
                origin: new google.maps.Point(0, 0),
                anchor: new google.maps.Point(17, 34),
                scaledSize: new google.maps.Size(25, 25)
            };

            var marker = new google.maps.Marker({
                map: map,
                icon: image,
                title: place.name,
                position: place.geometry.location
            });

            placesMarkers.push(marker);

            bounds.extend(lastLocation = place.geometry.location);
        }

        //map.fitBounds(bounds);

        mymarker.setPosition(lastLocation);

        map.setCenter(lastLocation);
    });

    google.maps.event.addListener(map, 'bounds_changed', function() {
        var bounds = map.getBounds();
        searchBox.setBounds(bounds);
    });

});
</script>
</body>
</html>