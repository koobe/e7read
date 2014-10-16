<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="jqm14" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=false"></script>
<style>
    /*html { height: 100% }
    body { height: 100%; margin: 0; padding: 0 }*/
    .topnav {
        height: 10%;
        box-shadow: 0px 0px 5px #555555;
        z-index: -9999;
    }
    #map-page, #map-canvas { width: 100%; height: 100%; padding: 0; }
</style>
<meta name="params-lat" content="${lat}" />
<meta name="params-lon" content="${lon}" />
</head>
<body>

<div data-role="page" data-theme="b" id="map-page">
    <div data-role="header">
        <g:link uri="/" data-icon="home" rel="external">Back</g:link>
        <h1>E7READ Explore</h1>
    </div>
    <div role="main" class="ui-content" id="map-canvas"></div>
</div>

<div class="topnav">...</div>
<div style="margin-top:100px"></div>

<script type="text/javascript">
$( document ).on( "pageinit", "#map-page", function() {

    var myLatlng = new google.maps.LatLng(${lat}, ${lon});

    var mapOptions = {
        center: myLatlng,
        zoom: ${zoom},
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    // make content layout for info window display
    var makeHtmlContent = function() {

        var box = $('<div class="row" />');

        var left = $('<div class="col-sm-4" />');

        var a = $('<a target="blank" />').attr('href', '/share/${content.id}');
        a.append($('<img align="left" alt="cover" border="0" class="img-thumbnail img-responsive" style="max-width: 200px; max-height: 200px; padding: 10px;" />').attr('src', '${content.coverUrl}'));

        left.append(a);

        box.append(left);

        var right = $('<div class="col-sm-8" />');

        right.append($('<h4 style="color:#333;"/>').text('${content.cropTitle}'));
        right.append($('<p style="color:#333;"/>').text('${content.cropText}'));
        right.append($('<a target="blank" style="font-size: 1.1em;" />').attr('href', '/share/${content.id}').text('more...'));

        box.append(right);

        return box.html();
    };


    var infowindow = new google.maps.InfoWindow();

    var marker;

    marker = new google.maps.Marker({
        position: new google.maps.LatLng(
        		${lat} + (Math.random()/500),
        		${lon} + (Math.random()/500)
        ),
        map: map,
        title: '${contentTitle}',
        draggable: false,
        animation: google.maps.Animation.DROP
    });

    google.maps.event.addListener(marker, 'click', (function(marker, html) {

        return function() {
            infowindow.setContent(html);
            infowindow.open(map, marker);

            console.log(marker);
        };
    })(marker, makeHtmlContent()));

    infowindow.setContent(makeHtmlContent());
    infowindow.open(map, marker);

});
</script>
</body>
</html>