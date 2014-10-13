<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
html { height: 100% }
body { height: 100%; margin: 0; padding: 0 }
#map_canvas { height: 100% }
</style>
<asset:stylesheet src="application.css"/>
<asset:javascript src="application.js"/>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=${grailsApplication.config.google.api.key}&sensor=false"></script>
</head>
<body>
<div id="map_canvas" style="width:100%; height:100%"></div>
<script type="text/javascript">
$(function() {
    var myLatlng = new google.maps.LatLng(${lat}, ${lon});

    var mapOptions = {
        center: myLatlng,
        zoom: ${zoom},
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptions);

    // make content layout for info window display
    var makeHtmlContent = function(content) {

        var box = $('<div class="row" />');

        var left = $('<div class="col-sm-4" />');

        var a = $('<a target="blank" />').attr('href', content.shareUrl);
        a.append($('<img align="left" alt="cover" border="0" class="img-thumbnail img-responsive" />').attr('src', content.coverUrl));

        left.append(a);

        box.append(left);

        var right = $('<div class="col-sm-8" />');

        right.append($('<h4/>').text(content.cropTitle));
        right.append($('<p/>').text(content.cropText));
        right.append($('<a target="blank" />').attr('href', content.shareUrl).text('read more...'));

        box.append(right);

        return box.html();
    };

    // show marker in google map
    $.get('/content/searchByLocation', function(data) {
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

});
</script>
</body>
</html>