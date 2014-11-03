<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="jqm14" />
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<!--<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=false"></script>-->
<style type="text/css">
body { overflow: hidden; }
.ui-panel-wrapper, .map-container { width: 100%; height: 100%; padding: 0; }
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
<div data-role="page" data-theme="b" id="map-page" class="ui-responsive-panel">
    <div data-role="header" data-position="fixed" class="map-header">
        <g:link uri="/" data-icon="home" rel="external" class="btnBack">Back</g:link>
        <h1>E7READ Explore</h1>
        <a href="#nav-panel" data-icon="bullets" rel="external" class="ui-btn ui-icon-bullets ui-btn-icon-notext ui-corner-all"></a>
    </div>
    <div data-role="main" class="ui-content map-container">
        <div id="map-canvas"></div>
    </div>
    <!--
    <div data-role="footer" data-position="fixed" class="map-footer">
        <input id="pac-input" class="controls" type="text" placeholder="Search Box"/>
    </div>
    -->
    <div data-role="panel" id="nav-panel">
        <ul data-role="listview">
            <!--
            <li data-icon="delete"><a href="#" data-rel="close">Close menu</a></li>
            -->
            <g:each in="${categories}" var="category">
                <li>
                    <a href="#" class="category-menu-item" data-name="${category.name}">
                        <g:message code="category.name.i18n.${category.name}" default="${category.name}" />
                    </a>
                </li>
            </g:each>
        </ul>
    </div><!-- /panel -->
</div>
<script type="text/javascript">
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

    // show marker in google map
    var searchByLocation = function(channel, category) {

        var center = map.getCenter();
        var queryData = {
            channel: channel,
            category: category,
            center: center.lat() + "," + center.lng()
        };

        $.get('/content/searchByLocation', queryData).done(function(data) {
            if (!data) { return; }

            var infowindow = new google.maps.InfoWindow();

            var marker;

            for (var i = 0; i < data.length; i++) {

                var content = data[i];

                marker = new google.maps.Marker({
                    position: new google.maps.LatLng(
                                    content.location.lat + (Math.random()/500),
                                    content.location.lon + (Math.random()/500)
                    ),
                    map: map,
                    title: content.cropTitle,
                    draggable: false,
                    animation: google.maps.Animation.DROP
                });

                google.maps.event.addListener(marker, 'click', (function(marker, html) {

                    return function() {
                        infowindow.setContent(html);
                        infowindow.open(map, marker);

                        console.log(marker);
                    };
                })(marker, makeHtmlContent(content)));
            }
        });
    };

    var currentChannel = $('meta[name=params-channel]').attr('content');
    searchByLocation(currentChannel, 'industry');

    $('.btnBack').unbind('click').click(function() {
        history.back();
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

        map.setCenter(lastLocation);

        searchByLocation();
    });

    google.maps.event.addListener(map, 'bounds_changed', function() {
        var bounds = map.getBounds();
        searchBox.setBounds(bounds);
    });

});
</script>
</body>
</html>